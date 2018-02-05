Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2045840-1517820499-2-9895792616261506208
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517820498; b=HoFMXiehDlUWGVs3McOBZwLbxMqt9Z8JwcB+6TxzyMBFjf1
    uFMULEBo1y9+NZGE2W0KCmxtnOeMY754KtcNsloCbOx1G6P4HFy4sAcCkSSegT3f
    PmADUQbpqtgVvEYI70fy/5ue5nw0SQL10HRd+CjvW1caN356S353DmyvEwzVHrk0
    VlvZ3S4UaZjR//k4ucw8z4ygnPJFx777/n2c34nqhiyBpdEYfu/TNLbdEdHgAPFj
    +a/AKCe2fHHN1qwUWEmn6cv7v4ZNCkryj7aHeNJPqN0iWZzVjpjq+M6sOGVpKNzz
    8zGYT3T6j0AIKU/plGbLczHyrxgXTWo/Xi9/Qog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517820498; bh=7cN1Twp/8nyIDEBx80Z+tl+iC43nwMGkcj+tIRZjDy0=; b=C
    ab3s0vKhlfo823nme2zPZN8stkZPntgV7k9Phi3JN9+AkQhaGyZlx6ZO2bWw5ZAI
    pPjicdqoWVi2ikBFI3PPXNsJvzRYHLg5rJ39nKSBXEkn6equ/zhLaJBXGVy7zofq
    k/AgUtCpscbX2rYr9CjYW2GxTc9yWR96EG/YpgmC7md941tVkUYsgs7TEQZ9khlp
    LJJoqQF16syzDYzpSeQv2OIhRmJDCMDww5hntX0QuBFUH20t6DLZ/4zOxbRmazhV
    eyUJrn3L9YShtZNr5AA9BUh2/istznDj9Ch21aXYh70xjC+qXMC8IGFXEZ3iE4+n
    Lx/BEY4T4q1p4LHyLny2g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=VmgIc62N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=VmgIc62N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbeBEIsQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 03:48:16 -0500
Received: from mail-eopbgr50108.outbound.protection.outlook.com ([40.107.5.108]:58144
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752671AbeBEIsO (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 5 Feb 2018 03:48:14 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH] mm/kasan: Don't vfree() nonexistent vm_area.
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Paul Menzel <pmenzel+linux-kasan-dev@molgen.mpg.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
References: <12c9e499-9c11-d248-6a3f-14ec8c4e07f1@molgen.mpg.de>
 <20180201163349.8700-1-aryabinin@virtuozzo.com>
 <20180201195757.GC20742@bombadil.infradead.org>
 <e1cf8e8e-4cc4-ff4f-92e1-f6fcf373c67f@virtuozzo.com>
 <20180202172027.GB16840@bombadil.infradead.org>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <5ea1af5e-213d-5881-652a-c3f2c535254a@virtuozzo.com>
Date: Mon, 5 Feb 2018 11:48:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180202172027.GB16840@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5PR0602CA0011.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::21) To AM4PR08MB2819.eurprd08.prod.outlook.com
 (2603:10a6:205:d::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f8dfcab-603f-4552-5c42-08d56c752fed
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:AM4PR08MB2819;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2819;3:hPAafmSoJHhnjSBaT1oXafANaupzfM53d37vUdISmgiWsaGfN4i0w2U8JHBVnWjKsnvgVzIJfqZ/Vi21y/ODVykVDQf6LsBK9T9gE3R3n2P6UcN1wAddAVyJU3ZsLezPeKem1CaCdgmBRf/uJGTmy634y9OAjYbteeeH1a4iwmdbJRanjtF52Yaiteyj6l7nL69GyIDhO19Tcr85KS0p3XdNvenW5MTtujy7K9+z2sjhcJkQxQz5A6p5iIj6UhEi;25:sIjD/QTKfWe0PPHSP9Kp3a2SEy8sM0byoia4AxZHw6P7pHTi3cR/jW+pYLHlPBQAmqUo7qj7MG4sXPJdqlzO/6XTs9khwdpo08P3NBJiNJ5pE014386P1dfkdmKd1UcD9IeFp+inQ8V3FcNQ2tOxyBJgi1P/ATSXGPd/sgGuCVu/Ruw1ZIsFaZGBhZ1cT6o0sbWRT3c0uH7woFfgImDR6pGd7BQvNFO7eoHCvLJexh1V86zFvqFVJ3ErYQ+IEVGnV9p4Jj/zbGjeu6pH+o6EJyCdphxdJgbVZW5yPuBtFePKk/WE3eJTebMk9gYpIT2yLuR3tP4lIxAd/HzqlJ+TRg==;31:roR1/g+N1eK59zQgYv3T/eNLttpaoNRjWyXtenDNI8J3qxIuMu7gcjE9lIf3zyAp4s6T+KM4HZHwgYgEJuz8k5WbSimd2hNTrThnPlA83J/wZjdqtzyL5/TYAJURYmJbN4LlOBshWterfA/YfhVmp0FbvPM3qcBzaNf5bkw5edQ5RULI+lgZQ/gV1lwZyOc44VnxO+uxQ6c+zztwylGHzCgA5dP1t2mhlxx3OGhUDj4=
X-MS-TrafficTypeDiagnostic: AM4PR08MB2819:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2819;20:07Yvjt8oomCleXc+puf/6q4NKJW6AUYnHn9qUTDZY7jv/OTN5CEDZS0nu2mQhB3or0i2Q/m75nQs68rpiFcABRygPM8IOCvRYkgOwpTBnxjmfAHwHQS8TyHUac205uzzQgtZYLC+pjVQgZkrjQvYPAbFjZ9zWt0xXIFQrDVYaooKjsat2DYJOzf64uydj7Blo3Ad3D/ZGYgFTopUmwIhfTYx5WExtEFBSzGLR/qMjRxWhFU3I5b4GA4SkVnzl7dDavwTdR6gQ0UZt0Z9V/5dro/tRh+6R9EjuWiuT5PnO5dD18K4qEJMsZWG22vGG//XHRDNbrRS7E+886uhyKxSccbxH3DnJbcyHL/hYiE0ImVKyKcJWp9bey9qA2ctENjB8f7WDnrbPr+gGM1lqCxmiZLJIELz+0HQQ8/qXCzH1B8=;4:cZXWFWk3JSB1tWIs1Zp7DfFQCbdod0jH3q5/B2+K3Pn7I8oaSH3I9PfFb7tNGcm5u9SmDga8LKZdUgHlS2Th6zlRuuxGmY0Htd9xRwPK+/FTpKExlXrKQjLAZa8O419oL36KaILfOTawb4+WWKXBSvFV+aT7UTR91iF6eASzsq1BglRJqLQ9SQauFFD90vTy237XfkpRZy4iNLw0KkdXQ4ROfFastJUnUdmRMSNr5eya+GlT4VHOTJwbwPsWSzIPIX4F9uVx6kSCvq62QJyHhQ==
X-Microsoft-Antispam-PRVS: <AM4PR08MB281904A91361EE29B9F70F24B0FE0@AM4PR08MB2819.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6041288)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:AM4PR08MB2819;BCL:0;PCL:0;RULEID:;SRVR:AM4PR08MB2819;
X-Forefront-PRVS: 0574D4712B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(346002)(39380400002)(396003)(376002)(39840400004)(189003)(199004)(5660300001)(55236004)(53546011)(77096007)(66066001)(65956001)(65806001)(386003)(26005)(52146003)(23676004)(47776003)(16526019)(106356001)(54906003)(36756003)(58126008)(6486002)(2906002)(186003)(478600001)(6246003)(76176011)(31686004)(53936002)(83506002)(2950100002)(25786009)(6916009)(16576012)(50466002)(52116002)(81166006)(64126003)(81156014)(8676002)(8936002)(316002)(6666003)(4326008)(86362001)(65826007)(2870700001)(97736004)(105586002)(3846002)(229853002)(2486003)(6116002)(305945005)(31696002)(7736002)(68736007)(93886005);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR08MB2819;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA4TUIyODE5OzIzOjBPRDgvRjZReTdPY3JTYWorWkFzaDl6SGh3?=
 =?utf-8?B?NEFmejFhblVqdEEvR3VYZnBQNU44NmdTZjdqczcxRXBDRmFTcUdUUkIvMUoz?=
 =?utf-8?B?Y2lBNmp1VjJ1bUNwZ0FzR3BZWWMvSHc3YVFnamkzRklQQ2J1THMzRjFwaHlC?=
 =?utf-8?B?L1JpWERFVDNRZnUzRkZRSTNheHpJeTZYVEVPcmpiVm1taHpVNlpiR1FsQUc5?=
 =?utf-8?B?bzg3cFh1d3B5Vks1ODNRVzJuYXJheStxTlIwNWdlcXM4aTlUTktjZWFQeHVy?=
 =?utf-8?B?enNETmU0L2ZNa0dlcTJRVzdRaVpvME9XdVdDaGRxT1hZUjJIRGhaKzd4eWli?=
 =?utf-8?B?Mml1aUlpM3JzcmFyV05kMTVpTUF1WVhyN2VqbUpDMkZOWE1vZzBjZ3FSWVFx?=
 =?utf-8?B?bHRHcG44eDZxVHJPOTJTQ3pjbDhLUEU3OUNaaTEvYTRqOFlycHZHWVEya3k4?=
 =?utf-8?B?dUdaUkJ6Sk1abGsrWkNKcGxORmZoWmYvU05qMC9mSmFoTE5sMjJwd2NHaDds?=
 =?utf-8?B?UnVNYUh6NjZDaFNmMXBZZTUrTFdreG9ncTBYaHR2S2xtWTYwemRDMnIxY1Z2?=
 =?utf-8?B?SDNxTktpelMzbWtCK1lIV1gzUEtJcDF0UExlcGFza1U0K2Evajl3dFFIUkhX?=
 =?utf-8?B?MUpCbm9tM0dzb2pDbHNnTU5zVUF1L2NNc3JuUGxCdDR3cHM1aEVxSnpEK25O?=
 =?utf-8?B?ckNIRmRFaW9HQTZIbHhteWY0N1ZwOXArb3hiM0NraDB1N05vRGxNMlU4cHpI?=
 =?utf-8?B?ekQ0bTdRZnBuSVhmQVNZL2I1QmlzaDNHREx0cWdrdzloZ2lWdk0zdFpRdXFa?=
 =?utf-8?B?M1JqL2RBSDhBdjZvdzBXV00vZitzRUtadzFiMVRwZVJzQnQwWTcvS1RCYmZG?=
 =?utf-8?B?M2M5SHR4WGM2SHdWdHpMd3kvY1p3d3g0c3pYZjBWdStOaWxLQ1BLS2pkRTc4?=
 =?utf-8?B?eU9WRnlJYzBJQkNIVGU3ZHhXN1VuVURvQXBVSlV1dFhMM2FBZENETCtrRlZK?=
 =?utf-8?B?MXhwZk9DVnEvN3lkK0hocUxwSDV0WHFia01IaHBZSGthTGc2dTZoYkZEVERr?=
 =?utf-8?B?KzdDUkk3dUx2YTA1dC95ZkU5VTRKTXc1UW5UaW9YYzFEOGRSYjhvbWs4ZzIv?=
 =?utf-8?B?M1AzcmpSOXdZWG0yWWFpYjFnaWRnRjRsSmFKTjAyTHg4b1JYR1pZTmh0bnVU?=
 =?utf-8?B?M3J6K3B6dFZaMFp2WURsd3U1OStYQWhDalc4cGJ3UmhRMzl4cExRaWZZblZN?=
 =?utf-8?B?RWhVdm5wbCtKSGZNRlRHdSt5MmZkSkdNbzFSOVVFMUtuRmxKenNmZUt1dWZZ?=
 =?utf-8?B?bGpKZzNka3BaQzFvZHlFNGtSYjJYZnI1cXNHUXdsK2FGNDEwYzVuR2pNdEhB?=
 =?utf-8?B?SlNKQXYvMHJyeHZLaVdsdUlDWkNnUmtVaCtqOWhDYVBKS0p6d0lsNnR4R3pV?=
 =?utf-8?B?aElxUURZTXd2OFl1dHhvc1lZVElvckdEQWxPWkplejJhSndzRXRLMEhick42?=
 =?utf-8?B?cmUzZ2d1d29JbGdlWWk4cmozaSs1VmFiMFpLSk5HeHVlcHBKYXN3MzJaNWg4?=
 =?utf-8?B?YzA1ZGRGbGQ2WlZobXRNbW54dEUyZmtUY1I1SGdNZ3FCNys2RUJZT0pSeG1r?=
 =?utf-8?B?T2hia1NZeXY1Sm4wR2xIdnRWaUc4eXFndGVna3NyaWZyL1g3MXZ6NzlNN09U?=
 =?utf-8?B?cmN3bHEwV1FiVVRlVStDSEtrdDZRZzZST3VIZC91M1RkRTZRSkhsTGlvOENX?=
 =?utf-8?B?NHlhSmh1WEJBSVpLZ0NGbGljN2taSEZJZGNJcHBSZVdyTUpkaG05M0VMem04?=
 =?utf-8?B?YlFJMjFkN0RWOFZmSGp1bURVbldRdTBZdVpYUGVUdGFTeTk1NEJ1MkJkSEJx?=
 =?utf-8?B?TWJEdFBmVFdTZlNjQkczU1kxSDhMbE9Tb2tpVXo3T1hzSHFzWkFuRnR2RElv?=
 =?utf-8?B?WjZJazliYVR3PT0=?=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2819;6:lNJ5Q7HNHn0LabUGWqorwj+hQAR7GKWjypanpCtL8lfN5GutO7lZrpaZdC7a7DAW2cRCZHPOanhQyXaOsCvJemDOWxjirBtLoipXxhPywK9EgiBIWDimUtNlpDxN2XkVBLdv0p1vzs+NDP8l+kNY/VArdOTYL6lqbKRdzJDO8LGvnv6BkEM9mEUKy/YSRnqJL/L5Ug9vigZCBZNVCkASCMDDSUta3b/jmn05rlRYQWozbsRON60WeVJcAZxV9Wm21oZNNW0jATz2CEF4sNu9ZhDTVGQHvNSrgzMBFqmf2VW79qaD3z2PomzHts/6BDsXxM1H2yPT99cc+Sh4uv6KX/8KSaC/tjo9kqpxFk+kDtU=;5:17DcOw9jadkYKtR9uqXd6HaPgWEJmae3CFSPYIW0UjcdQW3RvMzLkhP0SkKP96stH/K0QciCwkOtTdaHSZl++bTF1dEcVS6ncGjcfwWf10orqv0qF8vOX+jHCA+iQeR60gcuVsjtxZ9DRsOS0uwyRH5Okmki7vZRJTUyVHSFAS0=;24:lts6u2HMoMzrGOQGFXAcvajsRGKrvjccHYrvARL0sXxHQUqv/khFkaUQheUQd1ryit/mX2Sj24gi7wA5bjFM+Lbmd/vlEM/OhIgqcgiEQ2o=;7:9OwF0b2TaKw8nAq0GsnQBpJDSqAy9NDSD6p3L7gd5/hPiCI+fLnZr1GlbvKHb73F8KDlh7/dgkrDmUUuzVlTgMWS94iCfwEjklHlhs3pJnAck6ek+FHA5hNjc+eNv7Cn5uDuNSNqe1K1LsZ4h9xPAxaSFwZTuiXcPOKmNLJsiXtqh92QJl/+pIB9vcTX4+y9bNkdWaIPJxlOYir4B/K1qiux8VudEiaVykVS5n6B1pQQEvA4vNhsXGvCSo48lOlu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2819;20:ZvF44DNS9loKB2JGiVve4aIsFWoo58ZnSroNq6/jVJd/3iUO9/6NKbuSSy7Nu3g2YBgoRzcWNv6euPhnWksO2r9bSShzdGl5GpqV9r+aaaJcb9m8wHQmp7azYS+nPNNzfIvkGb6i/jdUAwVLBI5+KjAVaS3COaHEOXnq5rd2dT4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 08:48:10.8538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8dfcab-603f-4552-5c42-08d56c752fed
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2819
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/02/2018 08:20 PM, Matthew Wilcox wrote:
> On Thu, Feb 01, 2018 at 11:22:55PM +0300, Andrey Ryabinin wrote:
>>>> +		vm = find_vm_area((void *)shadow_start);
>>>> +		if (vm)
>>>> +			vfree((void *)shadow_start);
>>>> +	}
>>>
>>> This looks like a complicated way to spell 'is_vmalloc_addr' ...
>>>
>>
>> It's not. shadow_start is never vmalloc address.
> 
> I'm confused.  How can you call vfree() on something that isn't a vmalloc
> address?
> 

​vfree() is able to free any address returned by __vmalloc_node_range().
And __vmalloc_node_range() gives you any address you ask.
It doesn't have to be an address in [VMALLOC_START, VMALLOC_END] range.

That's also how the module_alloc()/module_memfree() works on architectures that
have designated area for modules.

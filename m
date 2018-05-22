Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2771174-1527007387-2-7531400950537145044
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527007387; b=j3N8juKWf7VJawrqMOSwM+Y46OuscMpRpdbLolYIO8ORnsWgZq
    n293LEqFYkjf7+SX0sTygwoCbNigwrW36CnAKeLlJz2QDRa3vreVnS1GoKdAx28q
    M4YGmlwQXoXtwAdP8YVhKuybDwzY4U6IFNHKmojjoQOnq5hxsI3fBPmNwmRsW3gW
    FUMT1wsJIVoMAt+sXidYPpL4pl9g6/xuBAlgzzpk9jZKmmhF3iZ+IBQB+B3rwFzV
    U4i6zr0+sg2hM43J5PPlQdI98BEfwPxFAU9fVvDK14GhupGEVqEiylW2C1mCqwc6
    mzBQvf58NCzGWQBIAv6lw0z3J92awNQAboRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527007387;
    bh=UrgZDrfbMMos4FYj7UjPZY750yFqKF8EX+M61Tl7qVk=; b=JNMKFHxWl93c
    VYEe304qoI8+bWCdtUrFQ6I7boB+dIZ3Q8VE/eEz8MHY7WkrJN5ydugHlzQFwC6C
    QRYo1mYrL9u8KaACxOt4KQCv/ZQZusvcy+5FMra1gPgT9J06eh3UtMxUDgL1HbSC
    yiHaATmy6moQAgGx1sidO2sYXy4EOs01Gf2oS89lQ2klWWFA4agVBJdCKFfpw7lM
    8ehQ+jMXILkM88PU1VkfpH8mCb2vK/Lbah6FZAbYePl8p5b+nfwz4CZY2DjwdcPc
    r3u4yT1zBeluq+wtGz3jTbdFUSqK3E+qD+89Z2o2gOlneCtaR54jHxvK1/Yy0JF2
    12VCl7ZG1w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com
    header.i=@virtuozzo.com header.b=a8MWHTkQ x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=virtuozzo.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com
      header.i=@virtuozzo.com header.b=a8MWHTkQ x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=virtuozzo.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCcVyBLix2CgOj4lErKolM0f4tnbkJkkJQThh7I24RMhFEFlTEGwi0BdQmkeMx2kR3jWZIrmJP3g+rANOWa0u6vGh3dZW80dO2uRcs+2a1Omouw9jkBZ
    FB8vq/LNEibVw0VgOVueHorTfiNolpPavkFEQHinA3SmTyZ4EHk0S1mM4NZjhowYoK8QdsvkDrbCzdlXHPXuCHxq4DRkxZbJlzxUHpQVhAVxrvBouUkAAKj1
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=dhh_qWxcV0sA:10 a=Tgzm40sRGssA:10 a=2TtQ-EmcicUA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=tpEzL2_AlxEA:10 a=TYBLyS7eAAAA:8 a=VwQbUJbxAAAA:8
    a=ou6u0OF48KUZVMUEiWkA:9 a=QEXdDO2ut3YA:10 a=zvYvwCWiE4KgVXXeO06c:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeEVQnD (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 12:43:03 -0400
Received: from mail-eopbgr30127.outbound.protection.outlook.com ([40.107.3.127]:12566
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751371AbeEVQnB (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 22 May 2018 12:43:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH] mm/kasan: Don't vfree() nonexistent vm_area.
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Menzel <pmenzel+linux-kasan-dev@molgen.mpg.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
References: <12c9e499-9c11-d248-6a3f-14ec8c4e07f1@molgen.mpg.de>
 <20180201163349.8700-1-aryabinin@virtuozzo.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <4fc394ae-65e8-7c51-112a-81bee0fb8429@virtuozzo.com>
Date: Tue, 22 May 2018 19:44:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180201163349.8700-1-aryabinin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR08CA0066.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::37) To VI1PR08MB3262.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::17)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3262;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3262;3:+PLB+k2QaVD4q0XXvqNNm0cTt+YEa6ZR5ZZZ2F+PrHUanUN6lR6Xy/FhwZMYfAmgXDxAFe9h/PRP2zRQtVXEA/R5PqkTTLvMnICAMU8LHeAO2ANbBCBw6cfylplklDVsoVHN35o30izRfALE9xkknqnnGWX4pMNV/Z+sC3O9xpLtVMMH8MiZE/ujkYz7gmC3LO8oMcttRk1cLkmlc9sUu6H/7OE4iDaY6jwz8FYZdZXjnzFsJzHXfQnjVICxsukO;25:pMTtP/YgmQs/dcS8KH382keoRW4RKc88GYnIP2V4175jBPAk+CFOkfWqN7dcYH4QVjPyPgG2NTR0vA5myEPlb91stdFHenFN8Zj/55Vw9eN2eTQP3tQHemjKbPW07NnQuDOKaPWTdavSyHGZanhwRLH77MeHwzSsQ+Tt7e8brZi3s1mLagmZd4rgjBQqXdwthPb9qayHLPn04aE/bEzhD5pqCydRa2vIDCfeEkavFl/NhLhb8SzeMsD5Hsp7UlhY+VnWyRADV+p+68caXJ6plqF2sUsNNen58YmDsc1j/jtm6kT9/Fx5LtfM38ZAF1c9bIlnCNCxNw7AdsC8Sgd4uQ==;31:s/0a93Kx9fQMRq+d7w+gBsYuDxAIRZQP3kwAxeZqWQzesJGxcPaC7G9Aplzwbs84ondXsrGjUUyopQk96zPyKqYTpaPpfLf0ae7NaJ/h1Ssb/9c4MVEKpb8KLVjnnRDh71wYmqUFVOJdnqPonkU/rS83V3kw2wDwAoaZc25QtIqRH53RHTexkl+27IZoA+h3bg2fBlIx3+XQxHcBwHpDDN2XbxJYqOwWPvK+vt4tycs=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3262:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3262;20:H8gwQgUmPiMQ4yijUz/ecFT6NGxDkAQHUbzz4leIN0nB1S2Oji89pMd8nYlwbHqvxorKW91q0nJSOhb2qLYLqOLl8/RnCjnWsjtQGjJJPfO/PiRpXkt4QO/y391JryoX9ZHHPUf9bBrb4JmV72H/xvKlugdKa6MTvFMfUFbTcvPKW/RhE+gfbZI3xA+QGnum5pCGQ5kH4dRol2ItjVI0jc4hXXL8zQILlT5MN98tlDbL+SYBvmiRA6I2vZOQyEAkZrLv6LDeh9B9qddpSKPYaoSez4XDzrWd7h6s99O5CRXPubH8TlOhP5JyBiCvF+86bVBFUlWlhzpAmQnRJE8uxEUq2AraFEYdk2y6dpQuh4P6CMkvywhht9LV8qekUQ+IIoqZPNw1Qn16t64Isl4AJU5RHhe7v/z0I34b+jpv9d9O9Ow7umUK1Oqdqaquz5/+BKE0N1wjO02kQD8L+euqYPVWfwXgYynrTcFpDmZGuXfURRUSjXBHhwE903syu3ua;4:JTIEcuUNo8LX+AilvxMZw7UZRbPuHUtEALOlzMcTOoTTJnDDYwntdY70Qxivbh/TatLbwWr3/UI/4unuQyskwh1SX3C3MuOo+hk5pyZF83NFzFVfbrmAb6E2TquT/J8usMr3wtU9/GkSfXm2goyK4OPfLXOkRJNqpSvmWiNZHg+ZW/jMuiXT0jet2d7+eE7w81lvRCavCJyRkRKh4zIRenHpljTVJd4qjgaTY9GYF6CLGbo3x+o2kmXE4ptfVH76X+Hgc1IL388rUcLLfM6/AiWp42CbjdOGBL2JuVZenlllPRGGOr3qW4e+idkJLo8Q7DIoNVa8EuJ+8Pwgza6gaJ4rEuYMv39WpaM6bFE/8Cg=
X-Microsoft-Antispam-PRVS: <VI1PR08MB326267B3CADFA06AD374E25AB0940@VI1PR08MB3262.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR08MB3262;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3262;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(366004)(346002)(39380400002)(39850400004)(396003)(189003)(199004)(230700001)(478600001)(186003)(6916009)(2906002)(16576012)(3846002)(54906003)(53936002)(81166006)(8676002)(81156014)(6666003)(316002)(5660300001)(16526019)(6486002)(64126003)(68736007)(58126008)(65826007)(6116002)(97736004)(26005)(77096007)(86362001)(31696002)(31686004)(106356001)(476003)(105586002)(59450400001)(52116002)(47776003)(66066001)(65956001)(65806001)(2616005)(956004)(486006)(446003)(11346002)(76176011)(386003)(55236004)(53546011)(6246003)(7736002)(36756003)(8936002)(50466002)(305945005)(4326008)(25786009)(229853002)(52146003)(23676004)(2486003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3262;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMjYyOzIzOnlJV3R4cVZCbVNyMHFDY3hmeVZaRjZDS2h0?=
 =?utf-8?B?OENjeWVDVlU1ZmxNem1lTkdSd1llRktHYUR2eFM5U2Rza3ZSWGdzdHVIOHJW?=
 =?utf-8?B?T0VJYW9Ka0V1ZVdoN1NXVkM2R2NNZVNsUkpldVVoRm82djA0TnFVQkdiZGc1?=
 =?utf-8?B?WDR6RFhnblFQTXB0NmZudElyaHZPaHJicWdGbml6c0FMZ2MzdGJUbVpUbXR5?=
 =?utf-8?B?aXpGcW5zRUNtM0xkVjFUZE5uYUluRjAybk9vMUo4K0NoSVorUHN4dXkxT0R2?=
 =?utf-8?B?OFBCa3ZxSzd0V2FLWk8wWXpHV1A2NFkwMlVYL0Q0RWtMSHhDZzRhQm9LQXg1?=
 =?utf-8?B?NWtXb01ZcUxYZmJhbS9JNmkvKy9idXZpYmNtbnNlTE5MSEU3SDBBM21yTUl1?=
 =?utf-8?B?dG1pTUhPTWd2ZWpaWTJxbHpOQXFFTG9tSEkvL2ZIUFJUOTBHa3FhVnQzbWV0?=
 =?utf-8?B?UWNEaEltNXRLdzRNQ3dZektpaVkwODFrLzNzbUJMUUJmSWVUekN2Y25RbnQ5?=
 =?utf-8?B?aTlJV2dzdHlScWk4bzRVRnRmME9vQTlqQ25GYTlsaVp0cEhlQjlwSUY3bWNt?=
 =?utf-8?B?Z1JxL01UQ01zWXFySkNLMy9lVmdpb1ltTTZGTExxUGhJUzZBdm9wQVpqcmg2?=
 =?utf-8?B?NEFacTMxdWtHbnFRcGpTWG9hNnNmY2RPK3IrQ3QyS1V6NEZpcnl6V2JZK2Vs?=
 =?utf-8?B?ZXd4NHpmZmx1d0U5OGVQb2MzM1lWdWt4TW5jVEd1ZlpZMFVEY2Q4cG5CdVlD?=
 =?utf-8?B?Z3g5NnJtcjZvQjhiTUpmQUlxWVJGenZWZEJCK1owVVhWL2xSbDh2bS9JTUlI?=
 =?utf-8?B?YVFlNGFqclhuYzZ4WmRSMzJkZXhsL0tTcU1tU3EzUC8zbmg2SkRpUWl4VmhT?=
 =?utf-8?B?Qk55MGhQckd2TlBDdGozbmRJR3JodXE2QlVyUVp4cXd1QVg2N0pTdDNKRDdy?=
 =?utf-8?B?ajYrWlVDaXVNZlJXaDd5T2hkL2JXVW5GZVJNYzJUbmZDZzgxMENia2t2UVU4?=
 =?utf-8?B?WFJLK2N3MUs3OWhsSStJazRtdU5wcENsUEZpMDlSV3BSR2dYU3A4ZzdpSFl5?=
 =?utf-8?B?NFJjVTNuMlA0UkpZbzdTNlV6RUFtZmMvRW1VejBaZXRlMW1CT3N1TGpYenZZ?=
 =?utf-8?B?b1pXamNpSi9kSjJ6Um9pZEs1alN0aHFuTFJ6cjZhY3p6UVEvQmFTR3N0Zk8w?=
 =?utf-8?B?YWFySnhBUXJaaFJlWVR3RFdNZ2Y2SEhJam1aMEd2YXo1bzJFNDJBUktwalZQ?=
 =?utf-8?B?N1R6bm80MUU0S21hUU1aMng1bHZBbjF2cnNsOER4aTlOZDRVdDRCQzJmc2Y0?=
 =?utf-8?B?UGhXNS9ZL3YzZVR0Y2NieEhaUzRnditPZStLanRuM0xXdm1mR2pKaGRVQzR4?=
 =?utf-8?B?UXRQRmF3VkxWVFNoWjRzclZkUFN3VDRCYVVheDA3ZUNCWmMrT3FrUVA0S2p1?=
 =?utf-8?B?c1hDbjVoZmlvMy9zZ2k3TTVKclg3ZUhhUUk3eHNqR1BIbjRGUCtXSm5ENEI1?=
 =?utf-8?B?TGp3bk5LWjdLa3VxS091QnVnZHBMQ2ZZZGovbGpkWVhNYXR6dGZFNnp6dGdu?=
 =?utf-8?B?NXVWUVdCS2RCUzdmR2ttcEhkMzZ1VVRqc3VYZ0ttb0ZkMldZRzRCeVlFSllK?=
 =?utf-8?B?a3ZCc0pWQWZWeFcvYUh2dVZKQ0FVVGVQSHI4eFhkNzFDdkF1MUJiNDFGRG5j?=
 =?utf-8?B?T3FYaStOOVpyMDRBRHBuaGhzQ004R0w0VGpoemRpRkcvR2tCWUpYY29CVjN1?=
 =?utf-8?B?T3cwTFA2S0x2VW1BNGZ2WUNJcGdJYS94SWRZUXV6Nk5INlcrQkVzOHV0T0M0?=
 =?utf-8?B?R3I4TWFoOEx1SmJuSjhBN21RaGtaelMwNVJPWGlZUTl5WW5NbHJOOXhxVFJ2?=
 =?utf-8?B?eTQwSFRMTUN2bzluZmNrR0ppYWp3RDJHTE9yL0RGNWpSODYrQm1UMmNSS0RZ?=
 =?utf-8?B?aHBhV29JRGZaTTd3dEZjZnRnS2ZyWmpIV2d3WUhwSUtPQlZVRjNGeXJuY2Q3?=
 =?utf-8?B?VDhaZXorN2JwdnZhaVA1RVhRRFB0UVFrMnJEdz09?=
X-Microsoft-Antispam-Message-Info: xsb7TarBV6//srY/tRdOPiteuSKP+COcZ8rYmgdIJAJTA15MFBmkvSKHmZdvj9cdZJ+DQs0aovuiQZYKutF0sAJZtADg6GM2Ffywk7ZeMpp/PtaXOvf7zPuv+lAqAKV8f+jJ3xpYqxbMnBwnRd7PLlr9hsBc4/ktWNIgzqG+Y1TlDuapW7lC/dEnZMnCKTKd
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3262;6:JV18px2OIGK+CE+79D7dkhQHhrj0ejxw8rQqWzNrooyPnNYM6r0eKHpixuMN41K4xoH3imSYT+TYAd6wTEmFUNUYWxVkxnJTOROM2gLYvPC1hNKgHLPrVTJJkmpT/cdGb8v/Jqof0AFiJd8jyCOpXA7THzYraUagb3shSkCdz6v+f4OP8qi7oRHMJIHrunEdusQ/ZxNAN3xJX+EK1loz/Wy266aagur2cmCREyRT9UbIA2pzTzL7QnUcNh/KOBFmCAJ5yL+UGPNXTh+WSHdjaaptrg35Y+uVHUwF4GaFT05Luz8WgVAqEsF/C42vmSs8VQHFbgaB57AVfM0hfklkGWYI8GHq3/uvkxaX5O9s7vFvtfcaNt+e8qartHEoBP7vcbLAfFw5POtJGkbtSuH8xk5rrDQLEMTdHSA64dYtcobBnZj5+DuE+kbnLLQn5HI5ur0iJTmZz0lITWx7GQqEHw==;5:CHUl2M3rFqbovgPvQ32XG/VfmS4Cjn85gOAp0ZGrYMbnWtPLv/epXkBjuqY/B4VqH/j5a6GTwmFMYE9TMNRQpy+fFNJh7yFobhRk4bABh3WpL//BP4Pgv++ZL4ViR69028G1OwK3cbiJXVRX11CS/6GmQrxDcKhx98UxLJ3dGP4=;24:Xb/aBIgQ5dKGPHBQr8kOsg4Cf4yJ1aMKBiHVaL5/snuwcJEVBHNUEyoSPkGO/yLxRXdvAZ0j2Y2Key9zcJj+9/sXIg0fjoEtiMWJUOqI62U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3262;7:fBTRkl3UfSxQFyG7IbMEl4L2l6J3sQJXcsfGsxEaTnMfg5jaTG6O+K+1E32MyOgVVAjQXikknikP2AXdAhod2+Q5HLj70SRVbuSy6GK8e8JH9Lv93KX3deMRqOif7qhrW6tFuQqkXRvNKl1fOdrCe1VWO9GkJdrMjp/trga1+HOMdwk2zNg8iUlcCAUM392ArcJXos3MsDd8SHVKjlkyai8eX4ou7qXINR1UfrjQGoQ0QUPtCEtN7v3+zLEgNY8T;20:XAGimQ2PfO3rvvqit2zzjROqk09599Q3P11dUm4wcAJ7S+FRMeupaE5u1PAzckffrn/NyNcSSs3kESgq3MbfqF7TEhR4vXvnpvYJavZVCAVbyf/Ast7UIlPxYlEHmKY6feffhEX6CJvFq3maahz43Eni/Nzz9xIXUTia+coM+jk=
X-MS-Office365-Filtering-Correlation-Id: e2c149c2-c2f8-466f-0ca5-08d5c0030f5a
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 16:42:51.0600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c149c2-c2f8-466f-0ca5-08d5c0030f5a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3262
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/01/2018 07:33 PM, Andrey Ryabinin wrote:
> KASAN uses different routines to map shadow for hot added memory and memory
> obtained in boot process. Attempt to offline memory onlined by normal boot
> process leads to this:
> 
>     Trying to vfree() nonexistent vm area (000000005d3b34b9)
>     WARNING: CPU: 2 PID: 13215 at mm/vmalloc.c:1525 __vunmap+0x147/0x190
> 
>     Call Trace:
>      kasan_mem_notifier+0xad/0xb9
>      notifier_call_chain+0x166/0x260
>      __blocking_notifier_call_chain+0xdb/0x140
>      __offline_pages+0x96a/0xb10
>      memory_subsys_offline+0x76/0xc0
>      device_offline+0xb8/0x120
>      store_mem_state+0xfa/0x120
>      kernfs_fop_write+0x1d5/0x320
>      __vfs_write+0xd4/0x530
>      vfs_write+0x105/0x340
>      SyS_write+0xb0/0x140
> 
> Obviously we can't call vfree() to free memory that wasn't allocated via
> vmalloc(). Use find_vm_area() to see if we can call vfree().
> 
> Unfortunately it's a bit tricky to properly unmap and free shadow allocated
> during boot, so we'll have to keep it. If memory will come online again
> that shadow will be reused.
> 
> Fixes: fa69b5989bb0 ("mm/kasan: add support for memory hotplug")
> Reported-by: Paul Menzel <pmenzel+linux-kasan-dev@molgen.mpg.de>
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: <stable@vger.kernel.org>
> ---

This seems stuck in -mm. Andrew, can we proceed?

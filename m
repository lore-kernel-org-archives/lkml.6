Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387525-1519635773-2-14206108348120572665
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519635772; b=W42zETv6wNl4C590ovmvsscnpGABdVkvCZTVBbe3EoPw2x3
    SYRnF72MmLTaoQOmDMBKd9rKTjlUk9ZNEMSO7R//GGqeBEFr8vmTMrBLrB2gLNSY
    rKiLbI7EJwcKZiIbqB9lPVIH++AjjE6xt/ErXlarBSmWeqZlgmV5XNx+ixEjr20Q
    amqvBpM4mbmkPN2JnrNb+BP2ckcUB9GzJ2PzE+PGWl1+Dgco4AcEnEtL2168EoO2
    C7eGcNGbtYJRoyPQ0gME1BZt+mkbmmNWQFIJHjkkL010RNxv3zXyGrSCv5pdM39O
    TnCssDHpc5FpwPyHlq5qBvx3a5R4yBWDObY41BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519635772; bh=8G4BhxBFNCT3wni6MTzOQ6bwqXdZ8zXoo4scx03keqA=; b=s
    8tSAd0pB4HS14uOB3qnpQNhwzqFPmbNVdcc816XTgmcGC1KGkeRdapy9lcsqtQbP
    YyxRJcQFHx/2Uj3V3OinNF39qclVwQt9cm0EA7ASusrgxxO0Qiu420814tuKmsNn
    BUl5uoFBBgm0ew60FWubJxvjVCYmqTi8rSvOyrEA61CPtu2Gm9fSFuRKy/WnQwQX
    2rW7Iatq2HtpgoUJwfI/uUHHWpXnuUhxI84EMOqetn+uIRWHRdfCtB6uxiX6HEWx
    /k5oF96RcS6i2T9zRt2Q1cdpTZJ1kj0+TJhtlIoXGXzSsN8WZoXC1kpY9yhMVqiM
    W3LHW8CXvhvyXlz201qLg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=NWfPPxsN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=NWfPPxsN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbeBZJCk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 04:02:40 -0500
Received: from mail-db5eur01on0114.outbound.protection.outlook.com ([104.47.2.114]:45132
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752405AbeBZJCg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 26 Feb 2018 04:02:36 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=xemul@virtuozzo.com;
Subject: Re: [PATCH v5 0/4] vm: add a syscall to map a process memory into a
 pipe
To: Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, criu@openvz.org, gdb@sourceware.org,
        devel@lists.open-mpi.org, rr-dev@mozilla.org,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Jann Horn <jannh@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrei Vagin <avagin@openvz.org>
References: <1515479453-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180220164406.3ec34509376f16841dc66e34@linux-foundation.org>
From: Pavel Emelyanov <xemul@virtuozzo.com>
Message-ID: <3122ec5a-7f73-f6b4-33ea-8c10ef32e5b0@virtuozzo.com>
Date: Mon, 26 Feb 2018 12:02:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180220164406.3ec34509376f16841dc66e34@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0202CA0001.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::11) To AM4PR0802MB2129.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d19ad0bb-66d1-4c32-e064-08d57cf7abce
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:AM4PR0802MB2129;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0802MB2129;3:xrXyNNJiTmgp8uH1Q3/B5/SkTkdUoHSdJ/iTbuAR38Q/vk7gttuy3V47Dg1HwWKxXHitPNU4W9J5v8glEFmNBfmtxFpN9Hu2K2563zMvl+4RNBn9zWr2RDM07/2gHYpHEo158A3ejQDU0nH0vyluFtpIwE+7UTog8jhQ+GoNGa30yvwLEXlIHjKvWAJwOqjmig3d6kAduiKPtn2/LZKtUmL6KC9H1Ya8QgMf4WeCEoVW/IhNO+yi967XcNVuCcp2;25:0uq+ptBYOeYNi9BSDYVjpP+x8ia2Qx4A833LKojkCl0WSSuVem20gzz+/0BLQLa72bYYwOpiPi2uXzeCulB0Hj+DWSUpushbBGWUxA/LA8882KlYYPqvuYhTgnfV1Eec6PZizgfFIBWpHqw+7TGD250iJL4NPZduJw7kBcV2Yoszn8qpgwMEGv3UipbJr5JQm2BuWaaYR8czUo+e+mZR85Q7VRd9GzoqZD5LOYtOzodMQyQB9xD0Kh42Bbi6GfIjaWTI+i8nzmlKx7lWCfm8osvvS46x1JDhFVsY08fvIoK5pjubuu/XfMb0VUAHXRK8SOfcE2bemIwndtb7rUlA9g==;31:pCVBR1l1NL6pHWHi2/E7gqy4uZBRWQXNZAEWzKXEn27pfy5BpkNy2OFwRPaF89iHcFmiT9Upn4BxNDU37wUHxbrEthZwTyoNz6Wy09G7pYAQtIi++Z+wqcOPwOxhwgv5Q5R1r4PmIr906DGjzghs7AucwWRbSNqdyNVtZGO8yzJBAVo2Jopd4KtmoZzgjRuIVatSuPAGHKVeHIoSz3jjkUxJwAzp2Pj92Ib5ItXWgqM=
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2129:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0802MB2129;20:yPRuN0m5zoEa9Az64qWzguVBzzxYUKwjVRQsiii+geXVD3kjY+DhFSK/xd/M68p94G/ORbisCxmBWeseXZpE4Ghx5OHCKYEzY1CdQRAMmpazsTEu7ymhRjBUPRHdhALjj6A6AYsjyM8YTaYHIdd+5KJiFXQ6XDbgTbRP2Blok50sMJRiJFDjEkQwcWp0l2GxcZlyLWxrjOYw1hq+hbZeE3zAZY2bV35zvPXp45pBqR7CTQjNL+t6LW8rd3knhEG2jqYW35UThQ8LXmRdsdRx25h5QgyvUqo+agR89VyNCtWGCV6vHeABfx4qlTNAyq5WNV8mvA6ztJJrJ+Xr0MvYprmV9/ci2T9WMF9PF/deZWU0o/mqLGvGNRW2StbuOs30b9606hZEBhmDV8PJr1cx+MS+yLyR3NZCFFHLAYXWSSrUMIctgy96mKdJi2vu/YvcOx5xJetRX26r66NenIgPtycjXaXfoKYDNfqQU4ZqDO1zrP/lxd8PtbpIPjS90/Sq;4:6PLzGbEKUxRPFCue8ekAYhzW+dmpLyJniXGCRfUx+T5ByhvQBMDTydaryPkaNxQPGz/N0iR5ohinKikxLEIJKzyWNpaIcfH+vR0mj/K0C77jciSuqhG0MMKI9WO9+4BYBZC9cm9oDUCT21aq8e+2T9iFRtshjevBJa/vu4y4ryFcAkdb3yiHPjft6Ud+bvYgYbu0MCkf250K36wplx9SY5QmBUjda3g3yzq4gYrWMibXXYkWyu6ewqkhcxWhH8JDOx8dG709SicH7Z/xCWjlXKuM2zuno/uanF1ssG1OHxn/wxiugw56uLSzbDcLKS1O
X-Microsoft-Antispam-PRVS: <AM4PR0802MB21297F8B64B9C89A1F5199D0B0C10@AM4PR0802MB2129.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(104084551191319);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231220)(944501161)(3002001)(6041288)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM4PR0802MB2129;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0802MB2129;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39380400002)(366004)(376002)(39830400003)(396003)(199004)(189003)(386003)(53546011)(81156014)(81166006)(8936002)(31686004)(8676002)(6486002)(5660300001)(2486003)(58126008)(76176011)(52116002)(16576012)(110136005)(54906003)(65956001)(316002)(66066001)(65806001)(47776003)(50466002)(64126003)(230700001)(2906002)(23676004)(7736002)(86362001)(478600001)(97736004)(106356001)(107886003)(6246003)(53936002)(305945005)(25786009)(31696002)(39060400002)(4326008)(7416002)(52146003)(68736007)(26005)(77096007)(105586002)(2950100002)(6666003)(16526019)(229853002)(3846002)(6116002)(65826007)(36756003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0802MB2129;H:[172.16.24.160];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA4MDJNQjIxMjk7MjM6dE5BQUQ0SndHQ2FOaXBxSkEvSm1xN2VQ?=
 =?utf-8?B?UlhNZHBIZkh4MmVvTVRualpjUG9tTDRNOWZLSVM0SXo4TVM1RzBFSEw1cHNW?=
 =?utf-8?B?VXRNWmZuQVlyMmN4cTN5elV5YmtEQmh5UUdUT0YwQVpjZjc5SkpRazNyU2Fm?=
 =?utf-8?B?MlpieHdBNE9hWVRGbE91S25RN2E0dnhQZnZkL3JBR1RBTlRyY1NNZHBBajRQ?=
 =?utf-8?B?eUhPZ0w1Mis5bnAvYkNWVy9FMG9XekFKZzJEQ2svbWlPN3QvMHYreXVLWnlY?=
 =?utf-8?B?QWFKOE1hZktnbXJFNVZUQU05YkFUbTdZcER2alkwNmtIMUx5OUtaNDgxNlJX?=
 =?utf-8?B?Sk5nb1VRTFQzNmdhMzdKY1RQWUF1dVE4V3NiZHdMdnYyRUhybk1rRlQ0RFNl?=
 =?utf-8?B?NGdTbWhkRDAyV0tUUUQwMkJGNnhQUkN0MmtwT1BoL2dSTHlWcXFicm1LdzJN?=
 =?utf-8?B?N041cDAvd096QzVOT21wdDBvU3cvWlBxV1VOR2VMZ1JoM1dFSTB4Y2tuNnpp?=
 =?utf-8?B?VFlYb3dpbUg1RkxXaWYwbGt0dmhKNHk1QkE1RzRKKzdlNHpJZktGUjN0eHhQ?=
 =?utf-8?B?d2dHUHFyRWpTUlhxVDNNOXZhcVEvendnNzdpMTJXbjA3Sm9zV2w3eGlCSkls?=
 =?utf-8?B?dGpJaFpLQ2dxTWxMc3BxTkxDTVRxbnZPamdWR0dRcTF6dERON3FUczFQUlV3?=
 =?utf-8?B?VTVIM2dGcGVqeTJEZnc4YVZwRmJ0SE9YVTkrRjlYNDNWOGNXa0tVTUpWUmN1?=
 =?utf-8?B?TUNtMlMyb1dRSDBMb2E1VXlOMTBOOXo5S1BUY3FOVEdaN2pQL0JHRG1WRUdt?=
 =?utf-8?B?TUxsemVRMmlOMGxHbS83YkIrNjI2ZmFYUGQvYk9wZG91a1pweWxMczNQSldw?=
 =?utf-8?B?eTBYanJvcjdyc2x5RUdvVmpmMmkyL1Myc3NUZ0NBOUhlUkhUaHI0Vk1lQ0pE?=
 =?utf-8?B?RjJZVFFzeFhxQ0RNT3EzMzFNUHcyL2FoQ1l3R0lEM3BDbS94NjBFV3RpMTVw?=
 =?utf-8?B?NEk5aVFncW5aOHRwdzhRRzBZbEFFZ2lRaVppc25QSTgyV1ppYS9wVWd4R3Jj?=
 =?utf-8?B?NHVMU1BWT3pnb210bm1oZ2dWUXdZbkltZzRRSEdWZ0ZmdEhBVFBvcGJwY09l?=
 =?utf-8?B?SVFSV2JQLzQ0MnE5elJQME9leFBWZlpmd1hiL0F4MWVaek9xSVN2RG1IM2I3?=
 =?utf-8?B?RGxCaVVObXZpcWFoV1hLRXM2b3hYamhPWkd3Z08zNWc0NFdFYzB1L3lROXlC?=
 =?utf-8?B?cEkxVGpuZEg3dXEvaFlMTEYwWXdvVXZ5dnBUQWhvUUNLOCt4MGd3YWNSNEpx?=
 =?utf-8?B?SjNBTW54d1A0VHMrOXdsTFNiK0lDeU9BY3VUTm43Z1hMQnZrbEVqcVNUYXp1?=
 =?utf-8?B?ak9NTW9Ed3VEUk5YOURnbE1tRjFIY0ZaMVZsbWxaTVpremZaZTFkVzV4YnFD?=
 =?utf-8?B?aTVqc0lVOGljTE1oR1M0ZU55MjFNUUpkRHBZcnFOZFNIaEtYSTRNTWpLNDhq?=
 =?utf-8?B?SXpoS3lNSldZR0o5bXgyc0Z0bDBvU1FEd3kvSXJCV0VYN2xwcE1waE9FSDB3?=
 =?utf-8?B?elN0N1M2VDJqK2tyaTdHRlVLOGpENFFFZE4rRGtLaUljL1Y5TmZLRk5LU2xY?=
 =?utf-8?B?ZVFubUxhQkcwb0UzSHB5R0puODhucGpscG1lcjVvUlVFQmdXSEsvZUlQRmVh?=
 =?utf-8?B?eTdzTmErVE9yd25QUzFzaGdyUERtbDR6R2FvaGZVYnVnOEt5R24vYzZaY2ha?=
 =?utf-8?B?MGhINVNndE9oVGFZTmZEQ1p4L2VFSTRNS3Nkc1oxZVJJeVcyeXczYWRodUsz?=
 =?utf-8?B?MU1VbDV3R3Z1L25ob21CTnRSaHlYS2liSUtORzMrVUxMbi9NOHhhNVc1Y0pZ?=
 =?utf-8?B?VkdaOTdEMnNrYThCaG1FQ0FkaXpCSXBkKythdzQzMkVqSUhReEpQNmdhK0Qw?=
 =?utf-8?B?MDhUVlJjSm9ydGc9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0802MB2129;6:m8t20UuOtKzbHbWQTNTxB2GkZEmYYfwIFfMEyuTqRo0PQWcziG6ouxTqVwCSNwmxMsQo1+MQQ4mjdtSIM4g4cZzeIZNNvsZt8G4ibMTazpsjHhCE4bpAD7ER/qErqCPYnV9yAJHN1D7/RxVnxZi0vpvXZbV0b8XLjke1dVkiLZpXvqnKxbTq+UHd/1eu8nBm3dSJci4nzKzTs4oT2lA/Hjrac43kGwwySEZwiswjbdAwBIbnbk7JDXoeDoPGS5U83wYsOy3uZ9AioydP97WX7msZCdxe7+j6g/GDA9KGsPvY37k4TXG6pQvKkFenndG+qHz91qhT/6EuyY5KkJ8V4vrW498AeoPJcstNiEw1xUo=;5:vbgD51lW4acjtrerOrlYQ2RZZYCTwHsCPSA8LYWMd/9Gw9EGKNsy9UpRBUvld55199q6XqKwrCoa9dnyEkdQbVGF0R66PbrR3nvQZg0mn2qzDpGGdfNEPltjE+ITAfbexgOPiuaLwSUTNokalXuqBhoBHXy7oTi/ECixo0boS4M=;24:1zObTkgboYu1fmlowve6aamibuYPMrSEsCWoY6ODuWCSW+goc5H4w6wJl35vD9iVpLAsXx6QPQpNAXdhXuQ+6JjVjpvD0S+7QZpP7gS8V8I=;7:WPnQf//gYyqH/BgB0sqwHCJR+nTXdemEBNBSk2eAbUZSfGp6TkxUS1fMr/9bfVmYzreEvom4Eias8WV68t6TKQXlp20eWcmWWLVPbsJy5rDY6iI+Mkj5TQAo7EMwgqKA0ZUh+gn7ddC5X6CrkS3NUT+yPFjNnTBNOCB5YvoxRYejs2W3od2XZHW7OloJ0UodIHyagjaSfuMcRL/xhq0u1me7tGlE1mLBMObfXkawwj0MwY0p5s8OB3oejzRgBtci
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0802MB2129;20:Ng1gISXAeqYybadKlLUXVaMFgWynmlYGylXpJpLeNgW0RSBKfnk9Ut/gxbQFpl9noajwM9qM7XkLB97uVfCZhRQPZkJdZkGyV1QHyyjGk0hCPBwYrn8lV18t4/TtrJ18Ihe6o5K6p99QxSFUGCt/sdb7ARsXleRt2Q6Qkn0qW4c=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 09:02:31.1052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d19ad0bb-66d1-4c32-e064-08d57cf7abce
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2129
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 03:44 AM, Andrew Morton wrote:
> On Tue,  9 Jan 2018 08:30:49 +0200 Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> 
>> This patches introduces new process_vmsplice system call that combines
>> functionality of process_vm_read and vmsplice.
> 
> All seems fairly strightforward.  The big question is: do we know that
> people will actually use this, and get sufficient value from it to
> justify its addition?

Yes, that's what bothers us a lot too :) I've tried to start with finding out if anyone 
used the sys_read/write_process_vm() calls, but failed :( Does anybody know how popular
these syscalls are? If its users operate on big amount of memory, they could benefit from
the proposed splice extension.

-- Pavel

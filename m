Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3213686-1520305410-2-5136607939918934426
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520305410; b=anqV1SlBOlyVlT+wutaramn17h1eohm6ExbXjWGebhIRizZ
    5LtIFDA9QAKoFzL93D5V/ZYKRhUVrYuD5ez4wZ8Hd3I3cAGOooSMReoCMX/tTh2V
    aUsesUh89zQ1CzJ+hhL+4i/8e2Y1POnAfG0Y7N/gBDU/Pk1P5RVwxm92iVNhhDAu
    bQBupej5GDSML+bzAUh87xC/zio9MQKO0jRcFpePxSyWNazks04nrA+4ulK+eDXS
    TrcKmb0ZalrqQGQ8przhx8n5+/ena9vdJ8By05k0RI8vmqP0aUZ5Fhm1z4FK13Hf
    zuo91ymaZfyV3BjMllpxONFMDt44z/h2YTjrBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520305410; bh=ZfFyJFxFSeWQOYZwg2GA9Wn409v23nQYJt+y3Aof1ww=; b=n
    dNoqJnYn1SSXcPKNw2Z0gAUUxZRsDQmiLJR4+KTQfHZZCPgAxXLdEy5e+BuIMZZ8
    +oOQx/A1y8khnz5ge0GT4joffutTLXYTWdkDfBw5bSNxHygM5DCSjYAHHvFZl3fK
    QFta0AMzKdRoA7ZwIC4QBtkqsGcUGKYNJHt1EMndFllhffdfVo2a/8ZC9wVegDQX
    OhPtDNmZY8aD/BTrjBhyYt5tRq3mGsrhYZm+OXiV/NKLgxXnVwCKndXubPqOU/Sx
    iZ6nQ0pY+YkITLbEREB9CooKoTANJmLfkUASK/TOI464+nY5uISyp6ON7UNmaZA0
    3/eHF/qGf0/909taZWGyw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=nSYVlHPu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=H1iPkgui x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=nSYVlHPu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=H1iPkgui x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932088AbeCFDDN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 22:03:13 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43578 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752719AbeCFDDL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Mar 2018 22:03:11 -0500
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
To: Randy Dunlap <rdunlap@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, <davem@davemloft.net>
References: <20180306013457.1955486-1-ast@kernel.org>
 <67abc3a2-80c9-7223-37c2-e15bbecdcd00@infradead.org>
CC: <daniel@iogearbox.net>, <torvalds@linux-foundation.org>,
        <gregkh@linuxfoundation.org>, <mcgrof@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-api@vger.kernel.org>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <eaaac6df-6deb-46e7-3020-83a97221d1f8@fb.com>
Date: Mon, 5 Mar 2018 19:02:12 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <67abc3a2-80c9-7223-37c2-e15bbecdcd00@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:180::1:52a8]
X-ClientProxiedBy: DM5PR1601CA0030.namprd16.prod.outlook.com
 (2603:10b6:4:5e::43) To BYAPR15MB2504.namprd15.prod.outlook.com
 (2603:10b6:a02:8e::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74bd899c-0e81-4864-af82-08d5830eac62
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2504;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2504;3:hjcR3e28yFOYh7Vx07z78w9Us+eQBF3h51Cvo/I1pYRTUA5wVIFmgsAIBi2pfLsf1Xm09DatRkZULcrgI848irlgqFEjFU9Z40FjepquNLXzUDpuefKqEv5apaKGecBbkvLCL1NgdLoFK1efO3/zWv6r71mQju7H56kZbuQb9Cm8T7ihud6B6qagfQjoh8B48SBiORavZzeaZ3lQ+GLCr00AqimfX055WC6e9VatfUTE4oTVAb9/RCUvWRLAniTf;25:d8xNuK9wT6C4JLYdkPSx/bjwOg0lXTTBlIDZMoZ0dH2C+Ov1vAPafF8TNlNulr7WbdMFZ85MzcUTHbRyDwMUkRsVVjl/A2AjSchQ7M7RBFWuU0o5r3nw01CwVrRj32jYdDccDfWL7ZC75/YCl53gJX9kChWbU1B7dOaypRDMoQlkEo7bypUMzbdah29yyUH/lqBQ6ZDAtxb+VTq3MgakJf6Un3zhOfxfVkmuAllAf8fGe98XRNTKwcXpNbpzkqsXg4RgQCnoeo8romoToNH1BZOe7x4TaaiKnnpJ5+nCJJFr0iyI5czqzEntstzPajKHRzeAhUvZS59Coh3CdSHLVQ==;31:/4tOQnI1ln8XxNz6Hq2meYu0JKsQxni6+VEQBX6NpYVbYO6h4bnhKZANl7wFiC66gbqSPMCUX76lmrsJdSmepIDV0DpUGHfu/IJUk38bhjV6tzSMSb6tR7cxC51u27b1ZrB4LSN/nxn8e1tJ7SjmXpXsvS2o8cITWx2S+uL6T17rqbB6KVxsDJsy+CaMsJaG1jA9LnJy5MQ3cB6QQgR1Fwg3HM6Re4ZZcxpdtzVc41U=
X-MS-TrafficTypeDiagnostic: BYAPR15MB2504:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2504;20:eyuocVvs5YArYtN4Rea68AHSaeXBkxTHXq1vZxN354T8j2YuwBIqJ1lkEuRU4AgL5efHq46TecGqchrgeyhqX1esxelrzHw27Sf4rDJaVO/ovNGoY+AEhssueWyFBjNglWGzip/MMQbec0G/WQ7PSXTx0tNcuBAUYZcNHNAwS0sY6PktXx/dTscaDaKgzeF1Ofig4jTtReZtV3uJE9q1mWDBFNia7WbIFTY1pl5AWY8IYrnxZeBKzjbSmfv59P3suBTVGrzGmBxzHy5E3pBgpA66fKkx6/pOTyAho4JNIlsq8LY3EjKPkDm1HdyMX885IL4M926qRWvEqa8Q0AV3ek76iosn0Fy66FefJarDvb7u3a8889k4vKWSWRs0suvHbIp7+C3qKd/p/5VY3M7RJhsQ++qs1ZJzww/wJlVWzCRiQpyuup7jt21NQrsk4ut7orz8VnM5z6cdAcDxe9gLXK2KMXmtklVrhYLoUhAHm0Js9x/W6atxHaf8gb6tUaIO;4:1gDvBNtTf62q55PqYZllfaYTGtSjf85tp95G09ue3/TQ8BLFfBWBIkWzWkXtMDVoDOjy+Obgw7S8iFAq79IPsFoUqLSp9Nc7jAA81oiC2XYErFiyqFB4DLhnfIG4OxtLlcDPzLuGA4u3GdA99/Oo1uXROXKAIdhdY9HPxCx6aurwB4fAoVeXPNi8UBRVeT3xY86qe3pVfAgEPvv2dt8jsLXOmnn99Z34ddwB9/vhuTTPFazBNDApYsb8sAgpk8DXwopX0+5mlodIAOSfHbhEXw==
X-Microsoft-Antispam-PRVS: <BYAPR15MB25042938443A2BBEE6B9DA0FD7D90@BYAPR15MB2504.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(11241501184)(944501244)(52105095)(93006095)(93001095)(10201501046)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BYAPR15MB2504;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2504;
X-Forefront-PRVS: 06036BD506
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(39380400002)(396003)(189003)(199004)(68736007)(6486002)(5660300001)(53936002)(6246003)(229853002)(105586002)(230700001)(31686004)(106356001)(65806001)(36756003)(64126003)(6306002)(50466002)(65956001)(2950100002)(6666003)(65826007)(47776003)(8936002)(1706002)(305945005)(7416002)(7736002)(81166006)(6116002)(58126008)(110136005)(8676002)(81156014)(2486003)(316002)(46003)(67846002)(31696002)(97736004)(86362001)(52396003)(52116002)(59450400001)(966005)(478600001)(386003)(53546011)(76176011)(2906002)(52146003)(4326008)(186003)(16526019)(25786009)(23676004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2504;H:[IPv6:2620:10d:c081:1132::1018];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjE1TUIyNTA0OzIzOjBZeFhSU1ArRzNRbnFNSDlLeFo5YTRTUDd2?=
 =?utf-8?B?eTFreTh4WlQ5WnIxcDlEelVQL282NmpsaWsyeXN3cWx2SzBMa1ZYcjNDOTNG?=
 =?utf-8?B?VGgzWk1aclUwQnZCOUxSSGRlNFZHb0Z2RndaZXQ0YkgxMnhUN3huYi83bWxo?=
 =?utf-8?B?MUdkWXphcElvQ2lDNGJrY2Y5NlNrWHdmTHlWaDJSTGx5T1hESkpuUmVGYllO?=
 =?utf-8?B?UWlQY1BUVU0rL3FKL0JFLzFCNHc4QVNVZmhjcjVtRDFqYXF1RGQ3SEZaVjdF?=
 =?utf-8?B?NmJ4VTJXdnJCYm1YYU5lMzNORE1hRlBZUXJPcE9LN1ZaOUw2QTJKNlQ0ZGYr?=
 =?utf-8?B?Vk9DMWhqTkY4UWQ4K3c4M1FGc3F0bTNsSitlYXdhNDJDMmdXUm9yejhPWFJS?=
 =?utf-8?B?QW92dEloK3lJbVFPVUFLVDlGM1RqUDdHN2FJRFlKaUJGcWZYaTdOcEpSN21n?=
 =?utf-8?B?NHZPVkRkS3NIb3JrTXFtTzhWZ2x0b1NtRHB4UGE2YnJJYk96NzhRL3dDL1E2?=
 =?utf-8?B?b3pIazFLK0dYT2JOelRsaHRaOXVzWlhDY2toZG1oSHY2R3pna0FoaUN1ZHFK?=
 =?utf-8?B?MGFFUk0zd0daajlvS0orb1A4VUtYdVcxWnpDeW9CTzZuZUtSUGpQckxyNXU1?=
 =?utf-8?B?L3NDRHBBNU1lY1VrRW9ieXBZaDJsK1FNbmZNWk9LM2xSL25Gb2RGaTVNSG5Q?=
 =?utf-8?B?bFhIYTV0aFA4cnY4Vk5BLzVUZHJlWlNGV0RIN0ZlZWc3WHRNUWd4emtsQ3BT?=
 =?utf-8?B?TVh4N3dpeXhKTkNUdEpwbWx4RWRaeUVHdUsvZUpheGJkaE1pVHlpOS9Dc05X?=
 =?utf-8?B?NWZhYzU0cGpEaUxhS2paT3ZUSnJFR25RdHVjM3kwR2NhTTYwQ1hxOEFUb2xJ?=
 =?utf-8?B?Sk1LYldPSmNYYlpyZW5qMDRBREZCOGhlTEtOV2ZDL2hnTnlxVVlteG9FREJS?=
 =?utf-8?B?dkhnNlpGVzA1bGpIVnJ5MzJiUUlYaktsZHRTdHRTWXp2QkNrTzdNOTZBU015?=
 =?utf-8?B?aHppYlNqSm92RU5MZ3R4c1VBa3ArL0NYWE9VTnRMRW1Lc1hmT3AxbXduU2Zx?=
 =?utf-8?B?OE9kcXoxYlFlWkw0TEdYM1Z2UURpUHlMbVA3b2ExZVhpYld1dHNDWTRlaExu?=
 =?utf-8?B?bXRsaDlLZnU3NnVlckg3UVNNNDRxN2lhc0o2NjE1a29RK3RaM2FjaWRiYnM0?=
 =?utf-8?B?UFhBeERNWVpFM09Nemc5STlVR0x5dGM5a1NjWUp1Ynh3emNvN2FMS2ZTQUhy?=
 =?utf-8?B?Qm9sUjR2MHNHRGNnY0ZpckZrOFZsMVNIODZoaEJ0Y1Z6SlNoY0tLSUtDclBN?=
 =?utf-8?B?Y1p2d0R3MGFWbXdoK2h2R3FteXUwUFAxTG1qK3FqNHRNdzJON25BclN0TEFK?=
 =?utf-8?B?RDFWcUM0eW9RTWJYUjgwMEVEVmpTKzR2Mm1XWTVYTUwwcjBlb2VkOVUvVlpB?=
 =?utf-8?B?U3hIQXEzUUdtMWdvUWlZYVpSWWhXUzB6TFdvSThCU0phZDFGMHVTMGNhenJp?=
 =?utf-8?B?V3AxMUIxTDNQSSs3by9XQmtYQlhPR2lFeXRJcWFKU1lqM3NoTUF6QnBtb1VQ?=
 =?utf-8?B?ZFRvQktYZy9zZE9MdFM2Nnp5OC9FVU40V2Y0Q1l4QkVtSnpPeHJDL2dYcmlJ?=
 =?utf-8?B?eHBtNHZQUG9uTW0zeU9nbExMaWg4U0w4Y0dLaXFYNml3bHFrNlVSYmFLbnR2?=
 =?utf-8?B?Y1Z4SDZLc1k3dC9IV3VyMGNML0VWTFFtZGpOUlhlN0pPamFZTGQxQVJJQlB6?=
 =?utf-8?B?Sjg5aXljOHh2VSs4b0tVWVF6QU42SXJWQmJZUTVvZEs5dmhDSHg1TExtdlpF?=
 =?utf-8?B?b0duTnh4cnhjRzBVbE5KUng3amRHRVFUWHRDSkFpYjFYSmNSYlpmZnpjVXhM?=
 =?utf-8?Q?Br9BMCs6kTMkLpfrOCqW0583TzP4uHtW?=
X-Microsoft-Antispam-Message-Info: GDaN3cI1DrLySNLYaCIFnjhWn69+h6fiOnQc67qFOinVexvRUvg0qWSnt1a9XAtEjiqRDA7Vwg8AS+GQMDFTBZG0WMjddTJNPYsAftLSSgZaigUoHGj5aIzb4Fj/YZD16Lkh9U97DuHAU/JBt2PDs75uZCnYbgBNCPMtZyrh38Lhvbcje8BeAAxE4L1ZUfIt
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2504;6:eeMNYU6/FcREWPzQ/baG2bEQDtG4OXH1g7GfP26ETEDDjiLH+m195oc+BkbBWNHndmt6sWtI+2TJf37jOgJ0kt2QOa4mPN6L0GfwE52/HuVFs5XIgSIoR4rQFxcfeTBowyDO+cjx7dQ2F2bZNqFaSBicnNek9IynUgvDjm0RSToAoM5emDgS6hIl1wj4xgjzjkvicrv2rSmG+U1+Uy4t0PHk0AQ/UTK3eAeMo1mGAp1SY/fAK/E/q/2nTN1bqF86hxqdFrvI88Yd+TwMZ5V+YAVQeUf5Wb92k75PEfi4B7CKOpVyZiLI1qQexGKkxh0MYr2nGAJ8I2gPFLh6QiEEK9+YLio8G21FkReh5mmuDMI=;5:V54nxkM827sRMAskBMaTbzKkrSh4xggGW5aKprWwJRmytUNr6YFH9F289jZbeWysq/xqrVLY8cwMw8qnCkPWkScBqXhx+zlSzdjArhVh5JXvx2z4UiQImqyb0umZnkj9TYOZ42EG4XEHMaBwdIo0IY9XhqP2JWRVaRjiqcuqrOQ=;24:h6m5eQrC7Ol9QSNc5TS6z5JH1V79VIFgmRU4phaw2wMnWd10HMDKH+ajmIdnE7L5XsO7cGU/IdZS/8P8tdgfwdHcNGw+id2mFBn2Gte3/X0=;7:Bs91jqp5ILLMUT26qjku65vp9jfzZ1ob8IYwFiIP+D+vL2OB9aTS/iNFl9W3lafO42e9JWtdGlLqnxckps3ySjkO9xo8t2/TKSjBN/BI0FUh7G9nb8v7xt7aM9zMQJWgeqm7hsuYLdZ+5hk2kxuh50MF/r0F7ovyKGCLD1bJBjnSJmeMbssx9ABSNo5kRygFHaaviX4s+O6KSNlRb8tttxBksxfisyrX5Pcb1el9/X9B+pFnvEdORhjH8kZpGVse
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2504;20:Az9EsqE5/8rryke7uz3qGLhcRAgyhKi6EZ5Gc8LOydY2YeVkqg22JUzTToSoCcHK/KPw8Otl9HRa0RzhBTX3Wc6OteJXIvZEHQd2gJNuXcuED7LGJYoMkTIMDGZ0+tdHKu+Ln+g7VmkB7Z/g3RPkP6SC0T0cXeeYhjs1uVS0si8=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2018 03:02:17.0847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bd899c-0e81-4864-af82-08d5830eac62
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2504
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/5/18 6:13 PM, Randy Dunlap wrote:
> Hi,
>
> On 03/05/2018 05:34 PM, Alexei Starovoitov wrote:
>
>> diff --git a/kernel/module.c b/kernel/module.c
>> index ad2d420024f6..6cfa35795741 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>
>> @@ -3669,6 +3683,17 @@ static int load_module(struct load_info *info, const char __user *uargs,
>>  	if (err)
>>  		goto free_copy;
>>
>> +	if (info->hdr->e_type == ET_EXEC) {
>> +#ifdef CONFIG_MODULE_SIG
>> +		if (!info->sig_ok) {
>> +			pr_notice_once("umh %s verification failed: signature and/or required key missing - tainting kernel\n",
>
> That's not a very friendly message to tell a user.  "umh" eh?

umh is an abbreviation known to kernel newbies:
https://kernelnewbies.org/KernelProjects/usermode-helper-enhancements

The rest of the message is copy paste of existing one.

>> +				       info->file->f_path.dentry->d_name.name);
>> +			add_taint(TAINT_UNSIGNED_MODULE, LOCKDEP_STILL_OK);
>> +		}
>
> And since the signature failed, why is it being loaded at all?

because this is how regular kernel modules deal with it.
sig_enforce is handled earlier.

> Is this in the "--force" load path?

--force forces modver and modmagic. These things don't apply here.


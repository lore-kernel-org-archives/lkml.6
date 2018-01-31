Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753086AbeAaJOe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:14:34 -0500
Received: from mail-ve1eur01on0130.outbound.protection.outlook.com ([104.47.1.130]:26160
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752715AbeAaJOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:14:11 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=eshatokhin@virtuozzo.com;
Subject: Re: [PATCH v5 0/3] livepatch: introduce atomic replace
To: Joe Lawrence <joe.lawrence@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        jpoimboe@redhat.com, jeyu@kernel.org, jikos@kernel.org, mbenes@suse.cz
References: <cover.1515786085.git.jbaron@akamai.com>
 <c9064c38-9f04-f6d3-c28b-593a0bb74488@virtuozzo.com>
 <86cac2eb-0de4-bae7-f633-5ad03297880d@akamai.com>
 <20180126102326.u5jscbbgburrzatp@pathway.suse.cz>
 <adf9b91f-e9e9-9d9a-8b28-5754c16c0782@virtuozzo.com>
 <20180130140303.6xmjgnbdemovzif5@pathway.suse.cz>
 <54c06e8c-2749-7c53-5a44-575c0ba69551@virtuozzo.com>
 <af3f596d-c3cc-1096-8670-352ab66fc87f@akamai.com>
 <e8c0328a-b7c7-3e8d-0cd0-fe0c608026d8@redhat.com>
From: Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Message-ID: <3ac34cb7-8753-56bb-38b4-2a84b141e06a@virtuozzo.com>
Date: Wed, 31 Jan 2018 12:14:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <e8c0328a-b7c7-3e8d-0cd0-fe0c608026d8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [95.25.160.64]
X-ClientProxiedBy: AM5PR0502CA0006.eurprd05.prod.outlook.com
 (2603:10a6:203:91::16) To AM5PR0802MB2435.eurprd08.prod.outlook.com
 (2603:10a6:203:9f::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0f0fa54-7724-4ec2-f4e2-08d5688afb06
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:AM5PR0802MB2435;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0802MB2435;3:e3KVT10SjqCtjhUCU8ZbVSXTDxFl5IlWw20Ab0troGh8hU5WL+cZjnb09CLJtSnAuVKLsbJ6F37ga+VZzA8np5NpTfA93+2t3bTwwLo2wP4wnmjL9vQwkKH2oAnEXUR0ql9xrw+GCiTjjZB9QpjPpZwuGwCHU3t4JV0s7jwc3XW5LjqCtLtsJIodrepCbqlsQPKd7Bffq75Yjdg27QH3rEn7R4ydwg1F2hLVzfd5TZ4LrDIxjUBjKa9+bYiY4r3q;25:J19fvOuHKCPgM0EyhTt1s7mCu8Rjud2uq6YxX1bYf88/Bn76x/ZCfqQl2ZSOQCOI4sFKVyY8RDyaH6x8ZAG5Hq1Pt4mbSZekvEKFfafVKQGl9pBrDsJjB2nn89O/MnlObaxD10BLSJKSBvud6ZxUbrCdDwWb0ey/dqc77opvOBzNtlkTZxyykV+mb0tgotS7cFCjOOT9y5yxuahTL13rUEPCst2lPGU7yMUBSRJovWkAcrQB/o8iYsfSSuqqaAprmYAAbXr/d9UqNBNFO8N+X9RNhYqHIdtinn6e/g1pGrxcqANfAB9P749RjPcppclD6V2U+rafBKXF5Ta1fXlo0w==;31:uT2G7u1oQDOGKl/xb/yeNYPCjndox9YoG30FXdS/Z7TAhBIjmTGK2SrQ7zn+j4IwlbXSm+VUxfNAUcaBYti2IpbbTfkwqsAd2ha2Jy67S9Q/SKhrQi7a7DJMJPGPxs8ako9LychZ1Zjae9qZYnUnDOoOM/OF+Ecq41AOz3AJgP8NFCI0nXoeitmkzc818m1gCb6hPZ5JrosULJcy0weLx7+Ks22RW8xejgtJPD9or3U=
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2435:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0802MB2435;20:Awj+znh9xGH1e9etpQkV47Hj8yNUjCpUz+9W83XBDp87WVheBmm2cESFQYz6YKbXx33mDAFFv1+93V25ZYzVEuubf2+pK8iDUzIiGxOyGv9kGLz/afQdZOIynTGeD+ZA6e7J9tSuw9V867mkfuwpY4gjS5cc/9UsH5xsc3HivMX8x4BTZx/GA9nMU8nCN50p7Sn9QSShD9lXhXcQ8BvYghi3i1PGkMLBi5pyQUkl7uLRO2JGl+t2HE2Y7hrQ2reic40TQ0yDLplW6owLmAUp8/QDyUDjRo/EQuNUrZ4NeoabkVTk4ptAOSiWBIXnf+1m1/gHFyAqtzFFZq19rQO697vEZNJi7KrD8S8vrsk+tbzJiXu1cFFgYK4FY20UOXkJSFdFouTMzlc04hyzdaEuJruwviCqN39gH/f+tCSP0CA=;4:ubI4T74RRSY+LB4r/r9mGWtrYDSPjWZh0J2HeRF1B8/yhQhwHVehHXVGJzYUUF2vCXIaCf9OvhOs6+zvznYkbedwMFTWJhTXJwry1b5iqVAeIHJycLA++L/hNJbPjI2yxbYrgensVmwGDdh8xuxxMteDJocf51Ll90uO9mpikc2u9scyUeGqP8EMJHIUpM6j8vNANdLNZf+UN+ySco9gAaos/uhJX3btqibJUAvFTMV1bhSyLaueiNIGg/gZtrsHUXfRnC+pNr6yeVRj1h86ik3Nz51+Rjx/pevefzs+pKq+vYPcoSjNAsKKRAKZER2wJKdvMhBfn7pFOwhVWDe5wA==
X-Microsoft-Antispam-PRVS: <AM5PR0802MB243533A7FB9359580812CC96D9FB0@AM5PR0802MB2435.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(3231101)(2400082)(944501161)(10201501046)(93006095)(93001095)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:AM5PR0802MB2435;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0802MB2435;
X-Forefront-PRVS: 056929CBB8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39840400004)(346002)(396003)(39380400002)(366004)(189003)(199004)(3846002)(316002)(68736007)(23676004)(52116002)(4326008)(6486002)(25786009)(7736002)(76176011)(26005)(97736004)(478600001)(386003)(6246003)(31696002)(305945005)(53546011)(93886005)(77096007)(67846002)(105586002)(64126003)(16576012)(58126008)(59450400001)(52146003)(83506002)(117156002)(229853002)(50466002)(966005)(5660300001)(2906002)(6666003)(65806001)(8676002)(36756003)(65826007)(2486003)(8936002)(47776003)(6306002)(81156014)(81166006)(106356001)(110136005)(230700001)(53936002)(6116002)(186003)(66066001)(16526019)(2950100002)(31686004)(86362001)(65956001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0802MB2435;H:[192.168.0.101];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:3;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDJNQjI0MzU7MjM6RlRtNUlLZ2svdGJtSnJBVVF0QkJCMTlv?=
 =?utf-8?B?b253NDBXbUFOSXV3eExJcWZoU1lHQk51cExjcTM4V1hLQTM5cHN1aVN3R1ha?=
 =?utf-8?B?dDdvdXNCeDFFd0V1NW91aTVkSFRIMEExTDNiRkdWTjE4Y3MwOElRT3Y5SjJN?=
 =?utf-8?B?V0VjRzZFcjVPdll6QTFDTXc5UlBYR0hHMG9IaHRLTGlCd1BRYzN1TTJMODlv?=
 =?utf-8?B?OVpBNVB4VVExdmxqczNGb0R0eUd6Sy95dmJDa1h6VnU5dTIwVm9OY3FTZXdm?=
 =?utf-8?B?Yzd2REIrSGg4ZDdubHp3S3hMRnIyNHRQWVNQMWphN1FCdGQ4Z1dxMDFoeGpT?=
 =?utf-8?B?eDd2NTdlQ0lEMnJCelpBeE5TREdHQmtoWG92aGVNeERIaXlpYTZiYTBvaDZi?=
 =?utf-8?B?a2d3OXAyWjJ3NHVta0ljeG5lSXExK2JlcGNBaFVvZUwzMUhkRlVraldFejU4?=
 =?utf-8?B?dU5aeXdBZXh2NHlHRDZzWmJkRzAvUWlXRjJPK1dUcG1iL1Y5UEtRRmFzOFVW?=
 =?utf-8?B?RXJITThIVVlseFhOK1NyN3RuU0EvVGRkODl5TGJrWW4xWi8vT1ExeFpuWGRo?=
 =?utf-8?B?bWdqdHIxWmN1dFk5bXVPWVRrQkxCOXY4TjdlRGxNcEhCYmJGY2R5UUMwbkxJ?=
 =?utf-8?B?WXBMYWRIalFWd0c5b3FIYWJZQnhINGg5aDVsNW05Nk05QXA0MzhUMkNmQWQv?=
 =?utf-8?B?cHc3MTUyVkt3WUp4L21DSTc1SmxvbEd0VGhHTnU5VGRUajlGUjNoQ3R3ZFVQ?=
 =?utf-8?B?RnU5YThuaUZXRk0yL0QyRTZZc1RXT3pPd1F5K241NFJHeklNaXlOTkR4eDVr?=
 =?utf-8?B?dnVDdWdQSFhwNDNUL1RYcER5MWthZnhTdlVCYlhpYXFlUzR6MXBaWS9qRXJj?=
 =?utf-8?B?Mm1oRUUvblB3RlltVStnNUQ1bG96VlNpZmZTMTVKNm5JOXhWbU94WE5qK2xQ?=
 =?utf-8?B?UG5BS2RKYVVtbzhVQldVeE51djVXYXlNLytRbmtUU3RZb0FQQzJaWTJPaFNi?=
 =?utf-8?B?S2dqeUtHaTU0ekhLNlJFVGtjWUtKQzNRc2wvbDMyMjM0SnQ4OGRNVHk5M1BX?=
 =?utf-8?B?ajNaUmE3M3hNdGZJSmtFTkdqRHlqZGNFbVdiZmJvdFd4Uk4zampKMGFacFpy?=
 =?utf-8?B?VFVRa3hPWmhNakpyZERLUE9janRXcUZrUi9qUUJJL2cwOUE2NWNpcHdFdUtM?=
 =?utf-8?B?dmw5TG9kQVJOSHpLTERxWkVpNkFpdkxmeUZObUFTRDJjakhhVTRNV3psakVB?=
 =?utf-8?B?YnIyK1Y2d1JLVGRseitVVFVUOVUrK1Bjb29saHltMHcvYnEvMzlFYWxkS3Fr?=
 =?utf-8?B?K3NwSzRjV083ZWU4dlF2RGp0b0gvc3FLVVQ1R3diSG9nMms4bzdLVWlkb2V0?=
 =?utf-8?B?MUFVSVExT3N4N1hqUk5IaUt4VnhIZDRLdTBER1BuV0dIbkFjeFhySU01YmVF?=
 =?utf-8?B?K2E0RnZWWWw5OG5HeGZKOGFrUkhIeHJKUUJWaXBueXNtRTFIU21UUzA0MHdO?=
 =?utf-8?B?MkpSczFWemFPZEVjZW4vcC83ajlPNU5UTkdVUTBFcnIyTTNPWW8vOGZxTWha?=
 =?utf-8?B?MmJQa0hWaWwrMEZtb3Rkb0xBVjVDTjJBZDI1dThRTXFSdTFHNTEvWktvRHhN?=
 =?utf-8?B?UHFlTjJMb1NHcjBNMlp4WWFUT3ZRbUQrZDZTU3NGWmR0VnhSMU12eExrN0l2?=
 =?utf-8?B?eU12OExCQmgycnBkZlpXMnk5VXVjejRZRE5abmxhdWx1SDVDMGhSTVdhNFlu?=
 =?utf-8?B?eVpnd1Q5c21DUjdDWFVFWHp6M0o1N0d2VThaY0tMOHEwZ3lrUEpkZTdiWTBZ?=
 =?utf-8?B?V28wbmNNREt6L250dXhiZ1l4RE81L3N1MHlBVzhlRUpwRzdyL0FKQUd4S1JY?=
 =?utf-8?B?SzZWU285MWpQUlQxUTkyRVBkR2lhazV3bHJVRzNXT0Fkb3MrR0o1SEVMWnlk?=
 =?utf-8?B?U2I5VlpmekRFYlBNZGRlbXRVZjc3MkNROEQ2TWFKOUFqcWROK0Z6OHBKQllu?=
 =?utf-8?B?c05rN2hzZWlXQlZRNDc5ZXpsQUNPemxQZ21tV1FBPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0802MB2435;6:2JTmE2cF/5m5JFE/INc2z2moco0fCIKj1udelSbf4Ia2tLrR9zNKtDmBZqernpBKfAzcubiXO01qv0nxgrzzbcWa/fmUilrC0lU6z4grDxdx66kz6TL0xbwo3vHREgYG0MATEZGzwUxaY2W8r5W3FbIEmmK5YMs/LALQ8KeqBLZ9EYY34Wmmu8eYv7+e/O6ypHegUxAQIs4IC+Pce6dUEDkBp4Rga6gdh/4NRqshC9aWjiMa6fToH8vMU/hOR/bZcX+JISKFX3iT6aL/XbVC4UO2eWRxw54SGxvf4tYDXSmDyqYQsA5XfaUwGbX60Qmqnf6aN8CTkaHSxqnvFU8KLR46iHVUO0h2Ix9kMOVGAjI=;5:QB5mzR1KJs27jxHmqbvPDTeBMYWgLH2VtFe7XvwGjeFrUQXot9fpHbRw9qZjn99hzXOQ+M0KZLfdjBO7SvFoaJS9S3V9zlC94nr+DHNYSwL/oUF1M1sPeKk9RQCA0alCzXYHkxjeOL+b6KF4vxiZ52v2B0cb49kDsRPq640oCiY=;24:1h/RBt0RdnYdjyBUkUQU2aUm4i7AAErJFv8y4oLxXBX8AT4nxiQoHMBn3gFfY9GEey126YR/v8i2RLO6HZrJmAc6Hpae6Nsdn8hFycDU+7o=;7:5BaY087G4RWeHj1rkyOTTqLBnAPszH/TTsHE07GPum9sh+t2qT25LDYP6AxxkaiSluMiwLsgpYqXiFx5v3G1+smkCx9LaglrVaiinbOCFKMBs59BAj+1mdEej7PWHB6lwq3QlioMO1UCs9/atkLqKMVwoSixt4VbmF9BD/1Z8KYBbIv07v3GN4Bwg00gP3Tz0tlX9G8nnVTZFPxm3WIZk9c6stk541NHILQB24JiD3Jir0Z9Fb0JIKzYY9En/O5a
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0802MB2435;20:OqCDrtx6QFBA8tMRGiXcUN+msH6V2/mojSg1IARdysrUETrtllL3bJjAF3GlC90BR5PUfg4eReow1jZGw2T6YsZ9lc9ACZpBwd7+Suxd5ENlNsRHtwtvcc0RHxTFPQzZ0GhE/LPoegFhP7g+3MJ7J0bj23O5Uq7hsiG/xq3PPMs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2018 09:14:06.3480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f0fa54-7724-4ec2-f4e2-08d5688afb06
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2435
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.01.2018 22:24, Joe Lawrence wrote:
> On 01/30/2018 01:19 PM, Jason Baron wrote:
>> [ ... snip ... ]
>>
>> Our main interest in 'atomic replace' is simply to make sure that
>> cumulative patches work as expected in that they 'replace' any prior
>> patches. We have an interest primarily in being able to apply patches
>> from the stable trees via livepatch. I think the current situation with
>> respect to 'replace' and callbacks is fine for us as well, but could
>> change based on more experience with livepatch.
> 
> Well the callback implementation was based somewhat on theoretical
> usage..  it was inspired by the kpatch macros that you talk about below,
> in which we had a few specific use-cases.  Converting (un)patch
> notifiers to the livepatch model presented additional callback
> locations, and as such we ended up with pre-patch, post-patch,
> pre-unpatch and post-unpatch callbacks.  Hopefully we'll get a better
> idea of their worth as we gain experience using them.  At this point in
> time I would suggest keeping it as simple and safe as possible.  :)
> 
>> As an aside I was just wondering how you are making use of the callbacks
>> using the tool you mentioned (that is based on kpatch)? I see in the
>> upstream kpatch that there are hooks such as: 'KPATCH_LOAD_HOOK(fn)' and
>> 'KPATCH_UNLOAD_HOOK(fn)'. However, these are specific to 'kpatch' (as
>> opposed to livepatch), and I do not see these sort of macros for the
>> recently introduced livepatch callbacks. It seems it would be easy
>> enough to add similar hooks for the livepatch callbacks. I was thinking
>> of writing such a patch, but was wondering if there was an existing
>> solution?
> 
> I've got a work in progress PR for this very feature:
> https://github.com/dynup/kpatch/pull/780

Yes, exactly, I use that. It is an important piece of the puzzle.

> 
> Evgenii has already provided some helpful feedback. Another set of
> eyes/testing would be appreciated!
> 
> Regards,
> 
> -- Joe
> .
> 

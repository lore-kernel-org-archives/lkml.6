Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933638AbeBULuS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 06:50:18 -0500
Received: from mail-bn3nam01on0068.outbound.protection.outlook.com ([104.47.33.68]:34907
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752866AbeBULuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 06:50:16 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH 1/4] locking/ww_mutex: add ww_mutex_is_owned_by function
 v3
To: Maarten Lankhorst <dev@mblankhorst.nl>,
        Peter Zijlstra <peterz@infradead.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180220125829.27060-1-christian.koenig@amd.com>
 <20180220131253.GF25314@hirez.programming.kicks-ass.net>
 <8fd80334-4d0e-8ed0-8a09-02a7e36a0eae@gmail.com>
 <20180220135709.GD25201@hirez.programming.kicks-ass.net>
 <b625cbca-c05a-afd1-fe97-a7a0760383c1@amd.com>
 <20180220145413.GF25201@hirez.programming.kicks-ass.net>
 <2dac8ec9-c54a-7dd1-af4e-62f2bc1a959c@gmail.com>
 <20180220152158.GH25201@hirez.programming.kicks-ass.net>
 <20180220235621.GD22199@phenom.ffwll.local>
 <9d782099-567f-38cb-391a-3c2a50cd5edd@mblankhorst.nl>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <4db106d0-6df3-f7cf-2e03-44f346660a31@amd.com>
Date: Wed, 21 Feb 2018 12:50:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9d782099-567f-38cb-391a-3c2a50cd5edd@mblankhorst.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88]
X-ClientProxiedBy: VI1PR08CA0218.eurprd08.prod.outlook.com
 (2603:10a6:802:15::27) To CY4PR12MB1301.namprd12.prod.outlook.com
 (2603:10b6:903:40::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7aff87d7-84f0-422c-7f70-08d579214545
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1301;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1301;3:yM+q1E6ipNr7HAMZs7VzatOKMEpmFXUYO8wb7Bi40/aw6CYMDSKv4w27AcwZMOBFNyOG0LCdfjnU1YPtYvMGfV+KHcj3cg/zTJgoNPQgM4qNma9en0e0t5OLgcUi4N+knSMTbisG4hi3rvfgJKglNXscI9WNFNeEe1+RZbwgFOON0msfbapPxTbNdc7IDGJ4rLhi3g94T7M8aZYj2q4uCTdjRem5NAlnFxLhQKVcxSMb7GbjmtFpbRmFgut/5ZbF;25:eyr9rst6ng5TlEvy1q4VINbbW2y/fXiv+NVYr+Vp62XhVtgZq+g5VE0GwcIL8e8xdIJUowsMiBv5RdeR5GbgYyLHJOYs6I4FPwR+7qLhoebSMY8pHwHSOjMvopPeLkmLk/x0//I49z5+aAIDIq/p63bYqibbN4DMliXWsfCrT3r5pkCZH8QObh02i0l7dSI9+BCHp2WK5GF7sDNnVEV5wLP/d1qQMDiNRtQKAETpn059cLFuIxDONyjaltQxPUroReIbbANFaIhLg4+hnBy1Wj0nmgsb4lTfdSiLNwdbg9YmV7L/82KkxuwbUjDBBglbfr2FOaLOVjaG2fPyjYgXjw==;31:pdF8aVvlIUd2o37k6JXVf39JRUbwlgpEF5CB4+FM8eIpDRDxc60IpKDnIY+lpwaCfVQBJh35suaO+L1J7a6uq+fef5UNk+DsH//pAuLMQwwEiEjjoXp80rWTcDqxRUFjtAbuw3cH1GY/87uxwKbjlCuJ8OKGZkxl8+pMbFXdNGkWQG12tAkxe1aMazIdg7XFebCzym8Y71HeknPxDoPvrFvo318lP3e+QkVNkw1hLm8=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1301:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1301;20:sdSRlDmxaOrITUDz561GSk+Oxo0JG6OYl9huPnn15jSMWK8WRV+J7f+PbUMT5Y9XRjbkjfJI7RhAFdUKKiAbF1+l3/HCu2TLvcNBaugi3HnLu7yQMBHSSQQwPDi0GjsXdkIZCcte535xaBC1hF7Yu8KyG7aYh/sH18ynIXmgdnLbX2JYkJkGeTdFnAKjTqzvPUVq5yCMKSN/T/DQkZKVk5VcJ55iUK5A8qfeNZyhIvczz3iZI5W06kAmHTjiMUuftJtHynTNl50zukiZdENZYaS+NiHFdw+2louQgk+QiPO/MXwg5amrATm3QrMHb1kLKXTafwdO9lzW+8ljIRj6rNQ3FnpE7dRoh0weMUS8LZmuvTtKDwhxCISIKVAEusNMVPIYyeu71fdDJcAtYyaxU2YBI5A+Sd4Qf5ueJrB1AVHI48c5HR3gIaRLHcrjFc6KHv38UPbex4JFzD/0u4rss0MLEfeqHP9FuGOeU5wzUjJEwuwE4Y4x6MqYmP/TeEE6;4:ANIPHUekWJ4gRgaFghEwleCCNZ5Y93UddhSOkO8smD4v8catnzlzcKurqFI1XigMokBYd+JGjdRPwAedtzRN+Y0z6TeHpBqJWhnNfnpmFLxQn1wIGrh1ru+Jaa46RJJSVDl4YAUP2jMaLqxMdpp/Bl+w2YGWbEUEVOn9+CFY7ZfOyE3nUziav4rcE0m2Zzt0oG+nNLDs4slNBSYHlOyX0K8mOkDDSh6zT4RZnGbV/6QwOiHOWg8L+7iAPPdDPLR9MtuHlSs0eDoVtJ4RMP3rLA==
X-Microsoft-Antispam-PRVS: <CY4PR12MB1301F04ED6B2EE7E373AE66283CE0@CY4PR12MB1301.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001067)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(944501161)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR12MB1301;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1301;
X-Forefront-PRVS: 0590BBCCBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(346002)(39860400002)(376002)(366004)(396003)(39380400002)(199004)(189003)(377424004)(76176011)(106356001)(16526019)(72206003)(59450400001)(186003)(1706002)(31696002)(2906002)(478600001)(2950100002)(65826007)(6666003)(2870700001)(6116002)(386003)(93886005)(5660300001)(97736004)(68736007)(86362001)(229853002)(7736002)(6486002)(305945005)(2486003)(65806001)(58126008)(67846002)(25786009)(105586002)(47776003)(31686004)(65956001)(52396003)(52116002)(36756003)(110136005)(23676004)(52146003)(53936002)(316002)(81166006)(64126003)(8936002)(81156014)(6246003)(8676002)(50466002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1301;H:[IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMzAxOzIzOlJ2YlloZG9hNjU5Y1YxSkUzTU9GS1E3NWV1?=
 =?utf-8?B?R1hIa2wxU0JPbjJpNTd6M1J2Y1hWaUtPdmpneW1PQWJhQ2RXcThTOVQ3eGNu?=
 =?utf-8?B?TXBzMzBqNmkzYXdsMVRBN0sxN1B4bDljbHc3NHN3OG1qemZkek5GdlJwM1Q3?=
 =?utf-8?B?U2pQN0dkOXpBSlJ5dzhMaVNXbzkvZWlZeW5mcVk5dzJvM0xIQmozNEZ0VGRr?=
 =?utf-8?B?V0VUZjdjcHl5cVl2aGlIUlREcXJ4R2kzdUNRNjM5U1dYWExwY0l2c1gyemt2?=
 =?utf-8?B?c0dHVzJGdmYrM1doUUJTTjNPWmxhQ0x6dmdMK2RNK1NRRms2azVSSHhYSmVG?=
 =?utf-8?B?Wmx2RTVJSGl0c0tVTVFSUXN3NHZyQlZzaEJHMHZldTRyV2N3Mjg0alJXbTQz?=
 =?utf-8?B?OFFwN1FSYmtFSHlyMVVhSWtTdTlOOFpRQ1ZpVnNKQXFDVS9HUjgwZFZ5TWht?=
 =?utf-8?B?RzVPVDFTNlc5VU03RE9DZmFwR2NiTmlvKzBNTGcwZmluaGlpSlpwUCtLellT?=
 =?utf-8?B?ZVFzUHkzWGErTWRKczlRSnQwcnprSWlrZ3BWUEhvTFZJL3FLNlhhc05FOVlp?=
 =?utf-8?B?MXVJbjljRGV6SEFVMDVJaEZrckVzRk0yNlpzWi9iU09GUU9XODJYUkVSOWo4?=
 =?utf-8?B?Rk5YZ0E4MEx0U3R3N1M4RkN0dmljNnl5SXJEYTIyZEdkOWc3RjNZOXJsb2hX?=
 =?utf-8?B?Z29ZeU9teTlzb0Zkb2M5eVFkMDJCZnQwUzdzaUNYaVg5ZVJOL3pRV25HdHk2?=
 =?utf-8?B?dFZlODZPbUJpcEZJaXJJM1gxNHBRb01zaFQ3clA4b1BXWTB0Vjk0N051eVlQ?=
 =?utf-8?B?ZVpNVG0yTnVKdktFUkxPWEQ1YmhLK0o0S3N3SFh6YTJCajFjeHE0ZmpNK1B6?=
 =?utf-8?B?TzJxbjRxTXBkWGR6TXBoSk5PYk1lLytaMlBrN1Yzek5IaGFTWEpZUnpCUEhW?=
 =?utf-8?B?bjIrcDhWQlBxdXlPSjZma243TmloNms5WWxHaGtyNmd6dHlCNG83SnhJYjUy?=
 =?utf-8?B?OTBMSkUyaUpRclkxRklIR0tTWVVOQ3NLSy9ZZW5OcENQYUVYSVBKOWxMZSto?=
 =?utf-8?B?WDFnOFBibkhtR3I3RkEzT0dvNHNzbnpyakpHMmJFOVhJQ2V0OXQrYzlhc3kw?=
 =?utf-8?B?T0V0M2dYb2JBejdPVGp1bkN3cW42VEhpOW16ZzFpMng3Y3Zaa3huM1plZElP?=
 =?utf-8?B?QXlObkdMaUxkOUQ0VWVVNTczYnk0SHhEVFBMY1lhNFpIY3pUVDlmOXhVY2tq?=
 =?utf-8?B?Y1ZDcklsdGpHd3pTeU93TDFsTFAxR21IQ0pUY2xEQ01OY3BId0lSeStYNDl5?=
 =?utf-8?B?ZTJ3djc5OXdGYURrRmYwZ0NwQkg0NkJFWnAxUU85eGZOUnh6MlZvbFBSZEJW?=
 =?utf-8?B?Ym5pU3BLTTdHaitNYyt3ZUJ2c2Y4aG5vZHN6WTdrc1JuZDlOcElYem0rcFR4?=
 =?utf-8?B?LzBYNE1td0g5QllVYTRTcjY3WHNlMzM4NDZxaGZrL1dWM3B4OWJJcXMyNk9T?=
 =?utf-8?B?TmQ5Y3h0ME1BWVJWZUtQZzlCblNIOXhGeG1aYVhFZGhqY01BVDVMa1NUa21M?=
 =?utf-8?B?a3VEazJ4dnBGVUM5NlppcVdWRm9ZK0txVUlOeG4rNHlTU3U3RFBuOUljNkZY?=
 =?utf-8?B?SG9saC9Vb2J2QVdIaG5kZ3UvclNPU0puWEs4ckp5cW5DZEhCRmduNjNPdksr?=
 =?utf-8?B?N3Jqa0hqVHVOY1BnVW1ZQjE0SWNMRjkwSGhtSFgzUjdhb0dJSHIzT3ErK3Iy?=
 =?utf-8?B?VUZaV2RucVRQK3N4MG9DZUIxdXdqUlpScytCWmtnNSt4RHRMTUl0RUVFQ1g3?=
 =?utf-8?B?N29pVDhYV3F3K0taUWFTRnJOSklWLy9ud1E5VGpxSCttK09ob0d0UG1WV3Ba?=
 =?utf-8?B?V29uT0NtNk9BQXdlaSsyczN4dkQzWEl4Um9Lb3orZG1BMmE5eFhNT2FhdklV?=
 =?utf-8?Q?jxy1xQSxrelUMY3ZlUhTGMJF0dhWvQ=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1301;6:mldRHiBQ+6SAnPyrhJoW1bphYvZ6M3PWtPVCuyj0NCGUqulh+O5+G2CziYTz31zg5QUpL3FrC1eeyG8G3neNmV6sxsZfW5RlLHVYH9r40u/uIYGjG8aHcjsskG8k8EWmTXRqfcREm2cLu9fIgVCq1/PyGmWBXek/GEWcFcowqFJLtwaSt9Br+A5vBbi1uJmUPB1FFhBHsN0u0Ar3sj5cmP37TBuylOczLSsq7ryzkxSuLWg8uZeFAgscf5+lBS3HIxvHjlHbmzEyJuzywO0HKKsCidAYqSceklun2978XOmFsYNN7co/hk9yHgWmUcZOAZW/a18B9iBManEHkQDyAHcYDF1BKEQYf00fZCZ2lag=;5:5mybydyZb4z3kJGv/OBgs7d6a6SpR6ObiK2bazJrNl9eIvODJqK/l5gxXp4G0IXWN5156k9Q32Mnx1/u/zifphlUsDmVkgk/6J5M2R2GMcGFJ5XB44ZFqN9SX8pTb5b3TnprW0OH5On5cpaNTLgKn0gC9+nT/R0LSo1uH1JTNaI=;24:NSR/v4Y3zzVaTBkvkou7rPP/F3u8nz/XRbgxdPeN61ISsCMnD5z4iftuugwCqxsojyigLweEtNFwtvhcSIpu1nztj5o5NiYgEzqyKsXCO2o=;7:FrYDxvp2gCHuyG33SuoaJyr0DoTrmBgVgzdV9/nA93AiXZqMTHVSqky5IqFCCp41hLLanjEH5QKP1JMm7KuzrbL81R5Ktm0hyrPQdtKOKOegG/1ohrQHDLvGCGWJkHjtDy21Mny+bivMwsZaMhhA4N8AuquSpT8ufHG+PdPEDdKAQFS0BDf13G/hf7goMsq2kK2QIb3O6z8D2OJzujUzqHsbpjl+TSInXJcn3BV39V3ek/NaevfAxSa5Lz6uRQsC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1301;20:G/DYDXKEnefi13h2V9ZxwxVYu75vHf0CyoH6D3lMNEyfXP4aZYGr2YFF1M8i+e9/a7CBZhXFOHNoW8Dpwj/Al7mfYodqNRyLoBpA2hpydHHO02BFI/MhtfclBqLP7sF/WmfM8GRIhzyaA2ZHfuoGLE7LGm9omOuNViVMaCW015ww4oMDB88O6Zua6xg604E9YOr6vgJRowIcUEzORQ1lEXTD+0zIhps3dXT6rEqVmbDEOPaRPskF9oTFqUPABHwy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 11:50:13.1794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aff87d7-84f0-422c-7f70-08d579214545
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1301
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.02.2018 um 11:54 schrieb Maarten Lankhorst:
> Op 21-02-18 om 00:56 schreef Daniel Vetter:
>> On Tue, Feb 20, 2018 at 04:21:58PM +0100, Peter Zijlstra wrote:
>>> On Tue, Feb 20, 2018 at 04:05:49PM +0100, Christian König wrote:
>>>> Am 20.02.2018 um 15:54 schrieb Peter Zijlstra:
>>>>> On Tue, Feb 20, 2018 at 03:34:07PM +0100, Christian König wrote:
>>>>>>> OK, but neither case would in fact need the !ctx case right? That's just
>>>>>>> there for completeness sake?
>>>>>> Unfortunately not. TTM uses trylock to lock BOs which are about to be
>>>>>> evicted to make room for all the BOs locked with a ctx.
>>>>>>
>>>>>> I need to be able to distinct between the BOs which are trylocked and those
>>>>>> which are locked with a ctx.
>>>>>>
>>>>>> Writing this I actually noticed the current version is buggy, cause even
>>>>>> when we check the mutex owner we still need to make sure that the ctx in the
>>>>>> lock is NULL.
>>>>> Hurm... I can't remember why trylocks behave like that, and it seems
>>>>> rather unfortunate / inconsistent.
>>>> Actually for me that is rather fortunate, cause I need to distinct between
>>>> the locks acquired through trylock and lock.
>>> I suppose that would always be possible using:
>>> ww_mutex_trylock(.ctx=NULL), and it could be that there simply weren't
>>> any immediate uses for a !NULL trylock and it was thus not implemented.
>>>
>>> But that is all very long ago..
>> I think we simple never had a use-case for interleaving ww_mutex_lock(ctx)
>> and ww_mutex_trylock(ctx). Nesting multiple trylocks in ctx-locks happens
>> plenty, but not further:
>>
>> The common use-case for that is locking a bunch of buffers you need (for
>> command submission or whatever), and then trylocking other buffers to make
>> space for the buffers you need to move into VRAM. I guess if only
>> trylocking buffers doesn't succeed in freeing up enough VRAM then we could
>> go into blocking ww_mutex_locks which need the ctx (and which would need
>> all the trylock-acquired buffers to be annotated with the ctx too). TTM
>> currently tries to be far enough away from that corner case (using a
>> defensive "never use more than 50% of all memory for gfx" approach) that
>> it doesn't seem to need that.
>>
>> Once we get there it should indeed be simply to add a ctx parameter to
>> ww_mutex_trylock to fix this case. The TTM side rework is definitely going
>> to be the much bigger issue here ...
>> -Daniel
> Yes, I think fixing trylock to take a ctx parameter would be a better fix than ww_mutex_is_owned_by..

Yeah, but as I noted now multiple times that won't work.

See I need to distinct between the BOs acquired with and without a 
context. Otherwise the whole approach doesn't make much sense.

Christian.

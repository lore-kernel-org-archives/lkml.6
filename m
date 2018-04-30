Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756639AbeD3Tew (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 15:34:52 -0400
Received: from mail-sn1nam01on0064.outbound.protection.outlook.com ([104.47.32.64]:12512
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932363AbeD3T2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 15:28:51 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
To: christian.koenig@amd.com, Oleg Nesterov <oleg@redhat.com>
Cc: David.Panariti@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        "Eric W. Biederman" <ebiederm@xmission.com>, Alexander.Deucher@amd.com,
        akpm@linux-foundation.org
References: <87muxsbmkp.fsf@xmission.com>
 <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com> <877eowa5qh.fsf@xmission.com>
 <20180425135552.GD7592@redhat.com>
 <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
 <20180425171757.GA10441@redhat.com>
 <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com> <874ljyu98e.fsf@xmission.com>
 <c3c9787d-b279-8169-43d1-74eeb666ffbd@gmail.com>
 <bceb1a1b-c453-782d-5a7d-40fa2f22c813@amd.com>
 <20180430160006.GB10583@redhat.com>
 <e5b0221d-84ba-10ff-4a58-4fa27c99650f@amd.com>
 <bb224134-7ccb-cc87-9a71-3ef1743eb074@gmail.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <79b2ce10-2cd7-b6f2-551e-0b4ae21072af@amd.com>
Date: Mon, 30 Apr 2018 15:28:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <bb224134-7ccb-cc87-9a71-3ef1743eb074@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YQBPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::16) To DM2PR12MB0313.namprd12.prod.outlook.com
 (2a01:111:e400:50d0::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0313;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0313;3:ZJi744xNmdmod1oessh80Ne1wREaNBlqty/eiFOOYZHtfrngxupFKNegACO5lsnySNVpAaZM4o1o6ndisa5UIs/t8EIHhvJ3DoZE7OnWpV/qf8lY1tS0/8atXUX5sHTw/LaybxzkxHTLCVfGYbAcqtu6Ppjk9wpNvyyB8YX/qInOlpsBVeM9b0IkK/A8/YUp5BoOyXhNZkXtxpqVW7BTyKNfUUOXmw2LQBXxqtar2IK3dwPAiwHVOE1hg704zjXM;25:UTdvPdhYwuRNgqUw7YyRR3QxoITeLecJRxlvxJFwW4g0e3wVH00VgNzxxlbKy4lwguJQYXB30asf2Q+uh3XSFulhNxP7KT99Acx2Tv1bBm0QVNvtNE0NeOvjVnuVRCtCyqyhzkoZ57IVeLa3CIu18SLtvGaCfURE7tIpQggGvEU8pOi6Jr4Xrl4oJpiHqKlWhLtqsYbaSxXnyruYJMIh4+WPTWZD/CTJZfjUEWAeB79iYoyO7bQxQpnF2avmq/+zo712jCMbi1KAQAgbKiQQcKEblwHh1laAuUhCW5jQ58b63Zaob8nvq2TQ3ISTavHuprZjV5QiE9V980lNnaZYFw==;31:ylpI2D8yF8mxSWWBcj/QchIJ2FKpPCkyqryqazozqf1eIkgBt3ptkB5NkLTQOC5yFZu0CrmopI6LegPpumWbXJLK2HehbFAUhbRxckb502bN0Z7TbjkgHBwGqL9G5WwVaJMl29nROYTidQexAPL330jQmFGrMwe3R4p9Q4KNoVKC3R00QnjSGRjOPV4shGsgMdbscHlJtOAbYp/l3+NimeSewTMS1hMYNmCsT4v4Im0=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0313:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0313;20:Jobe0oYiyZkDLxMLw6i4glEyE/R4mBJ8JGyl54DbyJVbZyufIRjPZGpvoept1BGc9S2zzdsjkHklfwS/zg0BszTfGWlJfVKo181WhkqUSg7L8nTtezLjKArYf5odug8J9KkKtiQ1iOPAhOmiWQpZnJ2LQU5Eb9rgtrhYYmEX5O4cmEHXt6AliZ7YlRXoav2jwN1Me3pUw9S1kt0zxzSxSqBHsVhhufNVJ3ZnRPcdQ+4oO3thpTqUFFzsKR+XJgplIPFjNgkYDcVXUlmsKMQie1RGmLaJq/5Y+GltfQhsNoPeeV2bFTuJ+AO8BQJCFKypCHDAvR6jFgitvx5g5Ef2wRHWFipd759ngib4jZ55SPyu+n7z5kX3eAK5WqhGY5Fn5eIrZyFB89GtU4W2zY0tBdxz9TKsFSxBnGzukQfw/i/RWPaM/IfUKJ4JbG1Zp/5jdT/Z5arWrT4VFIVkgLa6nnEvcxFqtjaBZ9K802KmZkQoG9cqZej+UDY4ivfuSzvR;4:Fpxgcu49Mpvwq+yQNk17jf+tOElmpo3yyKfM6lMep5CmPtrA4e7ColRhEMdujSnab/d3QYEtQjX3exgE8cds7YxaG5phtSOzfM/xu7rO5sNhEUBWRAmRceNOtIRuNTjxcuUW3GK1h7xrB/dJUe2xbkmuMbP0eBvMOjuIEVio5PuLtqhHz18rFpENvDPtYA3By8awqRVunglnjS5duL6gq8Z+GcW3JvzMxYxZvyjJ8hqWS9Y1CMqBRMPKtNzfu+4AVwCqyNSICacWchjFPW34PWW414prm8g2Ob9YV4VA3FQ6mg7o7xbUUe973PAKRs5H
X-Microsoft-Antispam-PRVS: <DM2PR12MB0313DBE7C521C048B813D6A8EA820@DM2PR12MB0313.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM2PR12MB0313;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0313;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(476003)(6486002)(77096007)(31696002)(53546011)(86362001)(305945005)(105586002)(25786009)(386003)(6666003)(93886005)(31686004)(3846002)(956004)(7736002)(2870700001)(67846002)(2906002)(50466002)(97736004)(64126003)(26005)(6116002)(486006)(6916009)(2616005)(2486003)(316002)(23676004)(52146003)(186003)(16526019)(966005)(47776003)(106356001)(6246003)(8936002)(58126008)(8676002)(16576012)(68736007)(4326008)(65826007)(59450400001)(65806001)(72206003)(478600001)(5660300001)(65956001)(52116002)(229853002)(53936002)(66066001)(81166006)(76176011)(446003)(81156014)(6306002)(11346002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0313;H:[172.27.230.118];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMzEzOzIzOmtHR0ZvUFprc0dNS3FHKzNxd3VHcWhaMTI4?=
 =?utf-8?B?T3k4a3E4UUFheWFCQnhuVXZ1RVoyRHBDc3VvUG9FaThUQThXNndSZXg1NTJY?=
 =?utf-8?B?NnRsOGc0bWk1VEFONzlZMVRHY2RXYUNETUpRRFFHMERoVXlGaUVibWNPYkpO?=
 =?utf-8?B?RXZtc3FrSzBvZWtNSU43VG04MUNJWk0wd0pHdEVLUE9aVnk0U3dFQjRBb084?=
 =?utf-8?B?VVVYSkhUV0JlenJ6V1lEdWpnY1Z3WERPL2NYOG1sa2pjOVZtY1ZFOEsrT25s?=
 =?utf-8?B?ZmhNZGthWWFMM21rdUxtcFZQVmQ2d29qbUtjdHZQQ0MvY2xGVUFoRGVmcUNH?=
 =?utf-8?B?VkxGeFh2bVJqYkpXbU1rUHdENlBBSUdtWEFTem1LT3BiY3VWZkZRRnd6aEYx?=
 =?utf-8?B?Q0hsQXRFWjU1bXhFQzZuTWxYbFRvYWp2V2U3QURUZDFzMllITG1UU29FdE9B?=
 =?utf-8?B?U2p3OW9wMUdwUVNZS2gzYWRXbDdBaWtPdkJGMFVKVnRxaWJSMnBDRlFlWU13?=
 =?utf-8?B?c005cUkwU2VwRjVoMHBwNmZ5eExsN3RjajZSenJoVWVvZlEzL205RUlSWmFq?=
 =?utf-8?B?RDhTOUpTeFNBVWhJKzRQZUVmcld5aCtuTjhKZzJibXJudXlMT1UzTDR2WWdX?=
 =?utf-8?B?b0tocGhpUml4WTlCNEpENCs4bU50U0tBRFRFVXNRemhIdkt5TThGVm0zRXpZ?=
 =?utf-8?B?bDBWRmNwODRWb2RWME9PUVdQQnRsQjdYNFlkKzIvZXRWNjBabEkyN09BNnN3?=
 =?utf-8?B?dyt3SW1oaWJ2cnI5djkvVFF1aUNmRGthTEpsZUhUTzR2M2RaR29tWThzSmdz?=
 =?utf-8?B?UFNFd3I1QTVISUFYUmI0ditxNTNFYUZucWhKVTU3WnR4SWxPZ21FeVkzWGp2?=
 =?utf-8?B?bDNzcWtadW1ES3Z3Q2dKamZub1pXUkU2QW1xSDNvN0ZlNksrTGQwRElwclRQ?=
 =?utf-8?B?UTNqV0NkZXdnaUJwYWREcWdjMkhRNkN5ZU0wRmxoY0pDVFdZbExSTGpyVGZT?=
 =?utf-8?B?YVgzc0Z4RnBJbXBUWG4xMEFiZ09WOFJpYnZMcXpFVTduQnI4bExENFUzcmRr?=
 =?utf-8?B?U0M1b2VDcWNSS2JhUG9RbEdlYXJOOUZQZmhOUHJVdFM5RHNQSTUvOWF2Y2F0?=
 =?utf-8?B?Y05ZRWVmSFZtRE9WOXJvZ2xOZ3hpWnArSThRQXZyNDV2aXRVYkpJVU40bEF4?=
 =?utf-8?B?Z3JZWlZsU2pFVjdrZjdoOWcvZEl6WmFlOEpyUnVxcnNSTVBrdXZxN1oxWFB5?=
 =?utf-8?B?QklKTFpuMjZuSXdvK3gvRnZSMmk0bHdxTkYvVDRaNU1hWHdVbjA4S1JLaUZV?=
 =?utf-8?B?cXUvcFM0V09Qay9nbnZVMnVSbFduK3FKbTBqYkZiQ0lSWWxBY3dJeEJoOVRD?=
 =?utf-8?B?WWpkMHJpbGJDRmhVOFBjQ0FUNUZkcTFIaW90Ykd6T0gzTzI4U1lOeGpGeGRh?=
 =?utf-8?B?NFBRRUR1NGFLRlFSb1EyM0xrVlNjbnVpS3VtUU85ckI3VUxwSXFQSHFDWEln?=
 =?utf-8?B?NzU3SkFjNmkvS1ZTVmdod0RKbkRRZzM1bTM3RFJSaDliT0w5U0gvZjBoZjNu?=
 =?utf-8?B?Y0NWd0tlVVhuc3lEVXJwU2ZjMS9WK2FVZGRKMUNJRW55dS9DZE5mR1h6L28x?=
 =?utf-8?B?K1dzbVdPUXFMREJOZzVROVBzMTJYYmYrTUlLTDQvRUxVbFk1aGI1bW55Ly9k?=
 =?utf-8?B?SkNEbThSaDhRU3lvMmM4SXIraWlkTllNRHlxRW9qbVltQWZCK0Q3Y0JDa3Y1?=
 =?utf-8?B?bUhxUmkyVWhGQVZqSTdwelF5UjI1VTY4ZXRWaE5LcFB1RXRDcTB3NTlXdnJ4?=
 =?utf-8?B?WmRodHhDamF3RVBVZVpPZE1obFFxY2tqbk5aN0RtSHZsNTRmVUFqUFdablBD?=
 =?utf-8?B?RFR4eUdJU0tRTk5WMjJlOVZ0RUg3WHpnWnN3R1daSFVlcEt6QVA0T2ZKZjV4?=
 =?utf-8?B?cmRrMGNQQmd0Q3pzN2xZc0VSL0V3R21ZcGJRNGZsVS8xbVlnWHI3cGZ0SlVG?=
 =?utf-8?B?V284TDNZd0ZYRDlzTnVIUkNhUVU2b3pGVGZjUmJsdEp4cEtEWlRZZkJ1TFkx?=
 =?utf-8?B?aWxQZ2FseXdHdVBQRGNLL3dIQVRoQUYxT1EvRkd2ZG5wTDA4UWtmTDlNUHM2?=
 =?utf-8?B?Rmc9PQ==?=
X-Microsoft-Antispam-Message-Info: SVnISunLLOPjDvgzrF8h7uSDSmQpkfkPjPaxG2sd3iZiDV0cQPJQqMpCi1TTKbqALZ/iwgGa9nvsWlNtnSzJqwCM3uJbKKc5qn0KJBB1l0qhUGHlvnNm2dVPJr2vkNChXJE+J1XYCqpFn/eC+fimn+osOcDkW8vviFyPo5ecL7KuMyTTjpxwX1g0Fgefh4LM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0313;6:uJZDesacqVDz+s71k/qe0B8g05qr1/P9Lj3geb8eHy9/DtLq0Qz2NREoD+Y4pklUgxgtVCPnXZnxFSUJrOH5OPHgh/rcDSeu45ZDa898BAdoquF7RXlUEE4dh+XiuXcyyn7ghG+65pyHWedwWd8FjjVo83xbJdngyoem9zWSwXmWxcbPhrP9/5+3IZkrrfe6vJS0QsepiFuE8DR8hIn+A1sxmjHPq6qLj9WCZl6MM6g4l+EGuMalrg9FrVzyDNWC3EiRpa1vP+Pv+OcQtqRqrIV5DUjiqeDmFc+Kge+p8X6sXju7Dpms3EH5ckDAQBjBUP4Bekt+6KYCWpn21oRohxrKnHRMC7kE/Bur9mbOlkXWZJJ/sa8hbhRnHSd36jPph0fTQu47zPEmbREYZSUZ8o88mkLz+enGWDxW8IBhwetsdBHYAahSY7zy20FJhUJHiHYH+FDphHg8Kv/R+cCNvA==;5:3w8ZaGd/slpd2JhjQRb++6moKDEzSqTTltTg/YvG3fv6i6i9VLo+TPw1HLHVifi8U+dHSpIWADqML2K3+YR05sR5Rl+JY0xnInMWqjKt4Ys45z5jFb52aBAaLWhLQkQLuZ8CAMNHi+EIguk/XldXniY9mL7I+9B/h9cYehERSIM=;24:EtC/b/vExxjOaJQKYlZGQRAWTPc68bUbVawvzZ04oOlD9eZ9k8a+C2EbYr+8XbLJm5Gh094FEDAOUu+IJXt07OFAnrwThk4Sf/rGPytvVwg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0313;7:ius4IxlAI0DP+2A9pAEife05CO4m55EMPl2c5wvI/PDEmCgEud8xxu7iwXgaLwY4MI/l4d0d6Sf8Pa8z2DWnL/zhF3G7//NxGRcBifC0He6wp0ZcqYcFxW0MyjoO9W8+auziD/M4UjcfaOyLkZSTeRgZz4b7e2VmiB2n5pOU7DDC1n3WvAMARozXfg4N8Tnjky/2YFnfKXHSW8VFgd1H08maZUbPbkTHX4Giv6gpamru0au+esuervFu/2/WaNzl;20:8j2C+Cg0dlmsqGVSmMhL8smNNbHbTEq4GsaQiMYtQcL+EgjOPLfkb/YsvGjQeRtRfM0RdcVFekFar+v43UlLsb9heipC+WYWGMGXGBxpm50gstUA6cvWknoIJ3Cz7+tyRmMC2L4uwc2ZT3X7b2b2MD1hw5VETGo1nTfPiOdO/Zdl8rap8veaJOXr+lM3YrD2Utt6Pk00CBOhHhYwDoleBN1pRHHI5xsxnfd6ZNEPxRpIJkB0tbLGjrDzo4MPkZ6V
X-MS-Office365-Filtering-Correlation-Id: 17fb842f-b758-480f-2212-08d5aed09946
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 19:28:48.3859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fb842f-b758-480f-2212-08d5aed09946
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0313
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/30/2018 02:29 PM, Christian König wrote:
> Am 30.04.2018 um 18:10 schrieb Andrey Grodzovsky:
>>
>>
>> On 04/30/2018 12:00 PM, Oleg Nesterov wrote:
>>> On 04/30, Andrey Grodzovsky wrote:
>>>> What about changing PF_SIGNALED to PF_EXITING in
>>>> drm_sched_entity_do_release
>>>>
>>>> -       if ((current->flags & PF_SIGNALED) && current->exit_code == 
>>>> SIGKILL)
>>>> +      if ((current->flags & PF_EXITING) && current->exit_code == 
>>>> SIGKILL)
>>> let me repeat, please don't use task->exit_code. And in fact this 
>>> check is racy
>>>
>>> But this doesn't matter. Say, we can trivially add 
>>> SIGNAL_GROUP_KILLED_BY_SIGKILL,
>>> or do something else,
>>
>>
>> Can you explain where is the race and what is a possible alternative 
>> then ?
>
> The race is that the release doesn't necessarily comes from the 
> process/context which used the fd.
>
> E.g. it is just called when the last reference count goes away, but 
> that can be anywhere not related to the original process using it, 
> e.g. in a kernel thread or a debugger etc...

I still don't see how it is a problem, if release comes from another 
task, then our process  (let's say Firefox who received SIGKILL) won't 
even get here since fput will not call .release so it will die instantly,
the last process who holds the reference (let's say the debugger) when 
finish will just go to wait_event_timeout and wait for SW queue to be 
empty from jobs (if any). So all the jobs will have their chance to get 
to HW anyway.

>
> The approach with the flush is indeed a really nice idea and I bite 
> myself to not had that previously as well.

Regarding your request from another email to investigate more on .flush

Looked at the code and did some reading -

 From LDD3
"The flush operation is invoked when a process closes its copy of a file 
descriptor for a device; it should execute (and wait for) any 
outstanding operations on the device"

 From printing back trace from dummy .flush hook in our driver -

Normal exit (process terminates on it's own)

[  295.586130 <    0.000006>]  dump_stack+0x5c/0x78
[  295.586273 <    0.000143>]  my_flush+0xa/0x10 [amdgpu]
[  295.586283 <    0.000010>]  filp_close+0x4a/0x90
[  295.586288 <    0.000005>]  SyS_close+0x2d/0x60
[  295.586295 <    0.000003>]  do_syscall_64+0xee/0x270

Exit triggered by fatal signal (not handled  signal, including SIGKILL)

[  356.551456 <    0.000008>]  dump_stack+0x5c/0x78
[  356.551592 <    0.000136>]  my_flush+0xa/0x10 [amdgpu]
[  356.551597 <    0.000005>]  filp_close+0x4a/0x90
[  356.551605 <    0.000008>]  put_files_struct+0xaf/0x120
[  356.551615 <    0.000010>]  do_exit+0x468/0x1280
[  356.551669 <    0.000009>]  do_group_exit+0x89/0x140
[  356.551679 <    0.000010>]  get_signal+0x375/0x8f0
[  356.551696 <    0.000017>]  do_signal+0x79/0xaa0
[  356.551756 <    0.000014>]  exit_to_usermode_loop+0x83/0xd0
[  356.551764 <    0.000008>]  do_syscall_64+0x244/0x270

So as it was said here before, it will be called for every process 
closing his FD to the file.

But again, I don't quire see yet what we earn by using .flush, is it 
that you force every process holding reference to DRM file not
die until all jobs are submitted to HW (as long as the process not being 
killed by  a signal) ?

Andrey

>
> Christian.

The idea here is that any task still referencing this file and putting 
down the reference and is not
exiting due to SIGKILL will just have to go through the  slow path - 
wait for jobs completion on GPU (with some TO).
>
>>
>>>   but I fail to understand what are you trying to do. Suppose
>>> that the check above is correct in that it is true iff the task is 
>>> exiting and
>>> it was killed by SIGKILL. What about the "else" branch which does
>>>
>>>     r = wait_event_killable(sched->job_scheduled, ...)
>>>
>>> ?
>>>
>>> Once again, fatal_signal_pending() (or even signal_pending()) is not 
>>> well defined
>>> after the exiting task passes exit_signals().
>>>
>>> So wait_event_killable() can fail because fatal_signal_pending() is 
>>> true; and this
>>> can happen even if it was not killed.
>>>
>>> Or it can block and SIGKILL won't be able to wake it up.
>>>
>>>> If SIGINT was sent then it's SIGINT,
>>> Yes, but see above. in this case fatal_signal_pending() will be 
>>> likely true so
>>> wait_event_killable() will fail unless condition is already true.
>>
>> My bad, I didn't show the full intended fix, it was just a snippet to 
>> address the differentiation between exiting
>> do to SIGKILL and any other exit, I also intended to change 
>> wait_event_killable to wait_event_timeout.
>>
>> Andrey
>>
>>>
>>> Oleg.
>>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeEBLtE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:49:04 -0400
Received: from mail-by2nam03on0076.outbound.protection.outlook.com ([104.47.42.76]:11392
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751094AbeEBLs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:48:56 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
        Oleg Nesterov <oleg@redhat.com>
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
 <79b2ce10-2cd7-b6f2-551e-0b4ae21072af@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <28de0150-0a31-f51a-4f56-0a71f741e07e@amd.com>
Date: Wed, 2 May 2018 13:48:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <79b2ce10-2cd7-b6f2-551e-0b4ae21072af@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: HE1PR0301CA0021.eurprd03.prod.outlook.com
 (2603:10a6:3:76::31) To DM5PR12MB1723.namprd12.prod.outlook.com
 (2603:10b6:3:10f::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1723;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1723;3:1akAAELFkOFrlNROFfBFw7PkWXdT3eKACgiDFVtf6xW65ZRRe9cRDjaJQNxftuhWkv98Uy5gqw/WMITMpv5FnPAPnWmYWNl0QwV/2ULk0A63hcgLrI1xciiDagUzFH+O7sjEyAE0I2x+5cuXOEy/8dycP0X2vzsTK3J0/ftgIb894yXiw0A+nOMQ67T//QBiUAT8oxQavtvlA8sa/HOJznxH7lhtWZ7qQU8IIo/wKyHTL8OusJ1TYBKai0HM9vzj;25:IEcAS0ZcXg32Bz2QsmbgdeNob58+36KcgcyZZCx4rlqLbAkqIhuLv7h0An4XvHaFZ4Fgeazx5kmA0MZzjySFLPFBfU4MNsarrgK3Ox+Qwcw/8PMe0aJd0j88XvPO0YbXI/vYorTVgscmARk1mv74La2sk6R7TUxHpkopNW5RBMZ9H7cMD0DhsyiXUBgRi3JVRFbZyCfpc45agyv7uuSfAqOB3o6QEL3+GSojPh0EP1Ir9cH4pXdGh6spL6H2xRW1z79+OMGaXs2xfSrDFNq2mIV1V83xw39qedTf0yGQY0wcedS08NqxyhC7UjO1G8MCsQQ+XLPVI0/wEzKmSnyc+w==;31:iEdr2SB3THssFS8oK2Yi4mcxancgMC7mPGIZm0gqDAwEPuczlE1ZzknbkS+un4IYmUiif+8c7sw3Yta0jJUA4nUY/FmMyq35F/Oh5OD3M+zccKRWM2Mq9NMvCFvYC/Ycz+tHrFeWu8mJEHbWzoSU8uusTh1n5E7JXx/iJ2VB5wKhnn2FQ9ck814iJLY+U9+CsT5xNevOap7tPeMX6pIYWBcwaXxdJUWhjLJSggbNDCc=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1723:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1723;20:/zuL68+3APz9MxYUihYqYh0rBjfI7rqIViTDVpDxYj22OSrR//l88maZdSB0/8s9f4b8UJegizZnUzabLXSYg0SVXYem/m+Any2h+wHOlu9s45XDMpd6ybQYvfiLgtbN6MypxYh/rvDDn19hl531cQQS15/2PsfDo8tPlDA4RQXb7Ezyv/8A+Q9yPRujnXkMkhFFIjiaQCEtE2rGHTzRGH3z16mL5FvNMq58NiMgtgbmXIJrjz8AvfVIUaGdllC+l/hS29o8EqmqyoLaJmD/63YQ7Yxc/c73fgVqPukf7YlrN6WOmY7g39+32dso0rFdlmMmcVUtf1ybwGhWEMWs5Y0H74hqjV3w7/QVAFjWehSnjRxfOjxC4mdK9rW8mzgh8FCIh4ORaEDuimnde4KxUwhMb+qJvHdwP0a4BGL3H4Xyz0894BVsPyCfGKKmebbSqqX+mFhkEXuftG830E8NTKgsy1dunzqDkaDPx1Br9/olrPxOxuXISHdaeFFXehgq;4:LNBmZHSAiHoB3Opbhfa1y8f6Iz+gyf7WPQIFXtsBPrBfRg9WS/0g+pCtQT0C0j2qaxcC8nEghrsY/2jbYEu6RL2igGOvu6Ly+N5wlAmJUWPRi6zLFYN2x5e+ffnalmOUSR4f+MIt93KIv3e/4oWwpBuJN7L/Y95OXnzmVN+UbhwAqmi4SUxvzpypbFyst4x1LL4I0O1LGGKdwcrCh+S4B1EYs2CT0YyyirxBSMaze19sj84u/oiV7eZ5xMYxlzFkIQ5zXIYfwVwFBWeT4ofFmQ==
X-Microsoft-Antispam-PRVS: <DM5PR12MB1723AB2AEC86272B2EB755DA83800@DM5PR12MB1723.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB1723;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1723;
X-Forefront-PRVS: 06607E485E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(366004)(346002)(396003)(39380400002)(376002)(39860400002)(189003)(199004)(65956001)(47776003)(2906002)(72206003)(2616005)(36756003)(23676004)(65806001)(2486003)(52116002)(64126003)(478600001)(52396003)(6486002)(6116002)(1706002)(81166006)(229853002)(8936002)(81156014)(97736004)(52146003)(5660300001)(8676002)(446003)(50466002)(65826007)(476003)(486006)(11346002)(2870700001)(6666003)(93886005)(31696002)(86362001)(7736002)(25786009)(31686004)(58126008)(110136005)(46003)(16526019)(186003)(316002)(4326008)(53546011)(305945005)(76176011)(386003)(67846002)(59450400001)(105586002)(6246003)(106356001)(68736007)(53936002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1723;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzIzOzIzOlB6VHk2c2pxaWlWTUp1di9ZMVJObHhlRGFO?=
 =?utf-8?B?bXV3SzM0dmNDRzlBNm0yRW9FMzdsVkRnR2xYU254NzMzR1VlRDFOUFIyWmxG?=
 =?utf-8?B?ejlMMUFBbWZZVW1EY3ZRRkttOUpyamZ3ckpmT0NvN2RoUVZ3eWNBd0c4ZzVF?=
 =?utf-8?B?RGYyT1JDT3p5Z0p5cnE4YW5rZVl6dWlVUnR0UlNhbHcxbmRNRUVqWW9DN2d3?=
 =?utf-8?B?QVo4RWVIbFhpT3FSOHY1TnFsWXFqcE1aMDkyZmc1NWVLMFhrM2NpVGhYY2pj?=
 =?utf-8?B?NmNhVDlBMW11Yjl6MjZqZS9KR3FKTUhDMTFZbUNsanV2VFU1MFl2L1lYK0lQ?=
 =?utf-8?B?N0txdUw3RkFIWFNvRnJJUlNBMlBpQ2h1TVFIUENHVHZHdnRYTXgyc2JmQ2hO?=
 =?utf-8?B?enJFaklvbjlkM3RjalpPUDNsaGswcFdobmcvV2Z5ci9wdkY5ZE9DMiszYmVy?=
 =?utf-8?B?SWhpRmZyaHJpdmVqMDFtcVZpTDZUdWU1YzlpOFlUNi91c29wVW9YUTZNaG00?=
 =?utf-8?B?UWd0c2FIZk13U0pnUnhkb3RoYndUbXNZY2FFdDMrR1Y5WkFHNmFJMUYzS0ZX?=
 =?utf-8?B?aG1HQ2ZCOHpBOVZPdXgvK3YxNzlZMXdtNnk2RGx5dEpDZTRwYzBrNkZiN3NH?=
 =?utf-8?B?YVI1SnRMUC8rUU9HQlN6a3FpVDBSaGY5c1B2TEtVTEhXV1Z5K3pmN0xzb0pO?=
 =?utf-8?B?d01FcGphdlErOTBIZ0NlMmJVRTdUUXRaUmZ1RE8wVWJxN3JVdFhTdkN3RWFz?=
 =?utf-8?B?Qjcyak5jaGRRa1cyKzJEV0FQclpCSEsyeDFEM3ZFd3VJdlhvYW54NzRLSS9x?=
 =?utf-8?B?Rkw4THRKb1UrakNraitjZnl6dE8xc0VEOHVsVS9pRkZ6OGlTRHcvVWtoRnhI?=
 =?utf-8?B?TlhTVXA4cDlPcWl0TEt3T2VMUEZUVFBHN05vZmo1N3gxdTFUbHI0ZjlNWkJ4?=
 =?utf-8?B?MEJ3RVFQWCt1S2J6K2I3NmFuclh5dlp3OExNRTlVcmxjbFA0SUZodDRxQ3o2?=
 =?utf-8?B?NHNNVUIvcXcydXdsbGE2ZFNCOGE2cVNaOUJSQWZqelo5dkVDNVVMRUZpRzFt?=
 =?utf-8?B?b3JTOU56RnFGcHdOSlNzWFg1TDUwaGtFbDBYMEZuV3ZwTFhNbmtKOUs2ZkN2?=
 =?utf-8?B?aTBVZG5rVEVTZTl3Z1AyeTNRQ2JzTFUrOExzSk9EVHZMbG9vanFIS1AzcEY4?=
 =?utf-8?B?WFUyWjVuYzZBMEkwWDhnREQyRFFDbExpUjNJdjF4UUd3cFNvak5BSkk0K0Jm?=
 =?utf-8?B?clFTMmJNcXNiaHpOKzh1SWJYNEVVVkc1bFUxYzl0RlZwUDBtOSs2Unpva3Br?=
 =?utf-8?B?b1NGMjk4ekh0NHJOS1B2WlFVR3FmRVN4UGZiRng4R0dWVVNLOUxaK2szbElW?=
 =?utf-8?B?cklIN3R3Zm1CdHRBRUQ5Q2hJbXhEU2FlWk4wTXBQL2VvWFA5UVJBTEM2ZGg1?=
 =?utf-8?B?c1BnMlNNRWJiQXRwSXhIeG1HT25BWnI0TTZ1d1I5L0huRHN3TFh1TkcxTzNo?=
 =?utf-8?B?QlBOQWtOZXJ5a2lMc2U0RlgrbUhuQTRtYnEydHhOSW1UMk5UNXZ1a0sxalpE?=
 =?utf-8?B?L3N2VlVFdG9kSm5GVVBRM0dmNlkzWnM4cnpZQitsTE1iVGwvaEFHYWsweXlx?=
 =?utf-8?B?TldIWW1ZMzU1ZWNubjFsS040V2dCTGJ3T3p3RHdpRUV0U2w4bnJXUHNadkVS?=
 =?utf-8?B?N1VyNUxMaytwcnVzWE1LTTdpMlg1dzJJNU1ITjRmTXZSNEYza2RTei9kMCtV?=
 =?utf-8?B?azhiMlVZUmcxUW5QcVBuUmRTMW00c2VKbVEwRjQxYXUrSXgwMTkyV3NocE1S?=
 =?utf-8?B?bFdEdkZNeWJuTlRSc3NoNnd1b3IzNm1oaDBzcFhZTDFrZDdBKzNsQjVXK0NU?=
 =?utf-8?B?RDJkdFJrSk1NSEprUXpib0hvNXV4c21IMUJsM2hGYVVONm1qYWVtSzdpa3pT?=
 =?utf-8?B?NjJBdGdzMmdla3N5UlZhLzdPVVlvUmJBajFySWQreWxqZVpMeTluZ0l2NXJJ?=
 =?utf-8?B?ejNtWmJlRjhHanN1U3RUVE4ya2lqUkduRzdwTy9VL2xaR3Z0aUx2bmp0QjI4?=
 =?utf-8?Q?UfZce+XteYm58IbfdEOyBkZ9F?=
X-Microsoft-Antispam-Message-Info: SMvGB0cfbNKLXucoOnVG2vakknBp6FS6J0Ja248bNUI3nTnMv8I8sZo7cvCP+mtGYnIQqGeE7UZKw/I29JaFQisPjne9m3u6LP0XPaMZJKMOA4c1wc1DsYKMMXBBp2Xgz27brLwakJopWV0iyxGD7p6TWHJd2r9yin+4RMa9IEpQNAP5Gsc+m6DEHs8eshYn
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1723;6:TRzuiDs7aAnHL12JM8E+vI2x97KQ+3YVY4UGuZUYrkf5r6JO7sT3JsNg2Iw4sHyx2qmCTHT1Y6U3I4UFL1QgTm6reTx1PbCMws3RMi6D5jjasDnafeyZETlASLdEeS4I0I6DP8zwcUdXqdFVfhZVctnL0g87WzB70CF5jwDtIpFUPLCVXO5zfM/RzXGdhcqPexUVkNkwIAUbDXz68rfnQaJqvFa/TaGhv/1fDvv8ja6Nnilfg7uqoDhvN/PHDdUS1i58vLOcnQeJI4L71RvlmdY4X7G1UeKhINVaZlCQLVq9DA6Wl9RfMXs1rsjqxwJvlLhSSgL8wzH0eiC1P70VVMbOfxV7fzHycha8CZReJU0CUDqwsCn5vPJcks4KfaQGnJaeu/EO6j/t2GmPFZKDWJjKuBpVgduhXj+A8SAe6Enu+FWcj9JCftSicWKfMDesEt3VLRSi1Lq0Mdeq342k3g==;5:qLh6+0hgLzvjovmAM/4CCFGwUsv4EOtqUGamVqcNvB7TPTCifj372i5gfMPtIrXV0EweTLqzHjv2RDCI0Zo2hJRtwDq2YAZ6jC9hfdldGcKku7tQAlaaqeEXskKZNsQ6Wn6ngbMTeGRXmgVtiz0fuhpjN++KZLzec5PrUZqyVSI=;24:AK/tnXNsQ8/IB4+Knx9rXL4KaZXnsWrfa6YrSn6zBFEt4N8+PlaRfv7vzYpXeXdqv5wQrOg6Sq0jwWhPQ/hSGG+aW02H8ZCbRmtBzV2Dwrs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1723;7:ashrpaHSqzsbr8m4u+hBroYrRLOlyM2FiZ6wUUGgidy6tY328bdA0N8FwzEVaxxCrHZrvZ76dK18cKUXWlzi6zonIjPIFKySUeydUsMqyFJldrMocUMbQyrExFe7eH/Xh9dESfjrSi2b+0z75V5I4db/85dAnXeirBNbozBenhGshYUVxXH/Y2aylfV9qbhOmDbsiYpLZTKr91uPndD8C2msf+A3Fy/WI9kxYSo4Owl8GevsS3HsgHBn+FjvM8Xn;20:13WmWF7Ww+wsgRG3nNFf80cUPQjzjuwWO4NQzfTQ84pCillF8ovTF+D7vxt9uDCnHJuRz3Ib5b5RQQluksEwEBQbSC1Uxv0rIpts0AE02ujmh9e2sqG4fp321gZfIbZWEI1kml5cMNkNrWUTNGgOLDz8F6t8aXYq1sMe5SeKe3I1/3Q4yoOB/aUTmaXgmh/FpN2HvcnlxG0/NW03STm61WN/YVsp4lOrwdN2toSZB7VydkUCSTl3OjE9cqdSfi5Y
X-MS-Office365-Filtering-Correlation-Id: 22b025f3-712c-4a98-4508-08d5b022ae3b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2018 11:48:52.2127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b025f3-712c-4a98-4508-08d5b022ae3b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1723
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.04.2018 um 21:28 schrieb Andrey Grodzovsky:
>
>
> On 04/30/2018 02:29 PM, Christian König wrote:
>> Am 30.04.2018 um 18:10 schrieb Andrey Grodzovsky:
>>>
>>>
>>> On 04/30/2018 12:00 PM, Oleg Nesterov wrote:
>>>> On 04/30, Andrey Grodzovsky wrote:
>>>>> What about changing PF_SIGNALED to PF_EXITING in
>>>>> drm_sched_entity_do_release
>>>>>
>>>>> -       if ((current->flags & PF_SIGNALED) && current->exit_code 
>>>>> == SIGKILL)
>>>>> +      if ((current->flags & PF_EXITING) && current->exit_code == 
>>>>> SIGKILL)
>>>> let me repeat, please don't use task->exit_code. And in fact this 
>>>> check is racy
>>>>
>>>> But this doesn't matter. Say, we can trivially add 
>>>> SIGNAL_GROUP_KILLED_BY_SIGKILL,
>>>> or do something else,
>>>
>>>
>>> Can you explain where is the race and what is a possible alternative 
>>> then ?
>>
>> The race is that the release doesn't necessarily comes from the 
>> process/context which used the fd.
>>
>> E.g. it is just called when the last reference count goes away, but 
>> that can be anywhere not related to the original process using it, 
>> e.g. in a kernel thread or a debugger etc...
>
> I still don't see how it is a problem, if release comes from another 
> task, then our process  (let's say Firefox who received SIGKILL) won't 
> even get here since fput will not call .release so it will die instantly,

And exactly that's the problem. We would then just block whatever task 
is the last one to release the fd.

> the last process who holds the reference (let's say the debugger) when 
> finish will just go to wait_event_timeout and wait for SW queue to be 
> empty from jobs (if any). So all the jobs will have their chance to 
> get to HW anyway.

Yeah, but that's exactly what we want to avoid when the process is 
killed by a signal.

>> The approach with the flush is indeed a really nice idea and I bite 
>> myself to not had that previously as well.
>
> Regarding your request from another email to investigate more on .flush
>
> Looked at the code and did some reading -
>
> From LDD3
> "The flush operation is invoked when a process closes its copy of a 
> file descriptor for a device; it should execute (and wait for) any 
> outstanding operations on the device"

Sounds exactly like what we need.

>
> From printing back trace from dummy .flush hook in our driver -
>
> Normal exit (process terminates on it's own)
>
> [  295.586130 <    0.000006>]  dump_stack+0x5c/0x78
> [  295.586273 <    0.000143>]  my_flush+0xa/0x10 [amdgpu]
> [  295.586283 <    0.000010>]  filp_close+0x4a/0x90
> [  295.586288 <    0.000005>]  SyS_close+0x2d/0x60
> [  295.586295 <    0.000003>]  do_syscall_64+0xee/0x270
>
> Exit triggered by fatal signal (not handled  signal, including SIGKILL)
>
> [  356.551456 <    0.000008>]  dump_stack+0x5c/0x78
> [  356.551592 <    0.000136>]  my_flush+0xa/0x10 [amdgpu]
> [  356.551597 <    0.000005>]  filp_close+0x4a/0x90
> [  356.551605 <    0.000008>]  put_files_struct+0xaf/0x120
> [  356.551615 <    0.000010>]  do_exit+0x468/0x1280
> [  356.551669 <    0.000009>]  do_group_exit+0x89/0x140
> [  356.551679 <    0.000010>]  get_signal+0x375/0x8f0
> [  356.551696 <    0.000017>]  do_signal+0x79/0xaa0
> [  356.551756 <    0.000014>] exit_to_usermode_loop+0x83/0xd0
> [  356.551764 <    0.000008>]  do_syscall_64+0x244/0x270
>
> So as it was said here before, it will be called for every process 
> closing his FD to the file.
>
> But again, I don't quire see yet what we earn by using .flush, is it 
> that you force every process holding reference to DRM file not
> die until all jobs are submitted to HW (as long as the process not 
> being killed by  a signal) ?

If in your example firefox dies by a fatal signal we won't notice that 
when somebody else is holding the last reference. E.g. we would still 
try to submit the jobs to the hardware.

I suggest the following approach:
1. Implement the flush callback and call the function to wait for the 
scheduler to push everything to the hardware (maybe rename the scheduler 
function to flush as well).

2. Change the scheduler to test for PF_EXITING, if it's set use 
wait_event_timeout() if it isn't set use wait_event_killable().

When the wait times out or is killed set a flag so that the _fini 
function knows that. Alternatively you could cleanup the _fini function 
to work in all cases, e.g. both when there are still jobs on the queue 
and when the queue is empty. For this you need to add something like a 
struct completion to the main loop to remove this start()/stop() of the 
kernel thread.

Christian.

>
> Andrey

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbeA3PGu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:06:50 -0500
Received: from mail-ve1eur01on0129.outbound.protection.outlook.com ([104.47.1.129]:58053
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751360AbeA3PGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:06:47 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=eshatokhin@virtuozzo.com;
Subject: Re: [PATCH v5 0/3] livepatch: introduce atomic replace
To: Petr Mladek <pmladek@suse.com>
Cc: Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, jpoimboe@redhat.com, jeyu@kernel.org,
        jikos@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com
References: <cover.1515786085.git.jbaron@akamai.com>
 <c9064c38-9f04-f6d3-c28b-593a0bb74488@virtuozzo.com>
 <86cac2eb-0de4-bae7-f633-5ad03297880d@akamai.com>
 <20180126102326.u5jscbbgburrzatp@pathway.suse.cz>
 <adf9b91f-e9e9-9d9a-8b28-5754c16c0782@virtuozzo.com>
 <20180130140303.6xmjgnbdemovzif5@pathway.suse.cz>
From: Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Message-ID: <54c06e8c-2749-7c53-5a44-575c0ba69551@virtuozzo.com>
Date: Tue, 30 Jan 2018 18:06:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180130140303.6xmjgnbdemovzif5@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0701CA0060.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::28) To AM5PR0802MB2436.eurprd08.prod.outlook.com
 (2603:10a6:203:9f::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e50c190f-1d3c-4b84-b811-08d567f3133c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:AM5PR0802MB2436;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0802MB2436;3:346s5tL2SAyylLtT+AUin1fvL1RthaAnIOSYxeW3c43IMfGgqGzRXf0k6J8ofOEgTg++YQ41UUfwozft0zoulQByB5UGOrVbWgpaYUUGUG3mOy1uIioQPXz1K4dVPxKzw2jZSmyk57S+2shWUe6imjiLirNmyZ5yyO4BYLli94jdvJMcgZSbe57u6wEhwsDIszjkMojLUEm44BLgiEfjzQb1PNqnGaTRNZnMW2LCW4m5DYzDdgYbZsNU8Z0uD92N;25:MuEi0omeY+ux13iz7iSMihQb3uY2OukqY5LqE1gI7kAALZsdPEfpjDniYjeIawIOoyDA1ZpplAMeYDxYSHB6zpUsN1WbTk/rOYa9GLl1jz+GeT/gK3kdV1vupv6H94SObXvnkTuz2r4TMAycpNUBGyggEg3BDQZt34pqa16i9wFMXUuNaAdFFcmWc4pdi7eEc/82Zn7J5a+qirEiX7wSdubHGMvpcG164PXN+f8XkYuzShdtXZoA1wFzhV8Bbld+9QteARff5LNrSp1/AOkNX96gS4vZe2fqd0E7sw4bkxbLRFcRcDtZzytd7FK7Bx1hjduwZ/P40MkSJnmIuENs0g==;31:dDx3kqE8t72A5R1/7ExvNRG9giEhjVLuNA5A33UoYiM4WpS5piTe44TF8O05Hp+LsfOrPu/K0eekSv7DRoTZKFubdB0gNRM/4UNUNcX7PRMsXgZJv+QGt9UWMXsRftbYS0gy8Fhbqy/Zv4fKzMxwH+dDoCz8w7uJiDfRinKv8neZAWALGZloH4gMexOTxPlMavrecDrYbGegn9B14OD/Lg5SqCXCc2QXNVZsQB5+LNM=
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2436:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0802MB2436;20:e+hgqXmk4+oPDeuErXrvVavwkvR1glY39i5jnYY/rrSpIYIJc0j5ZIjk1DJuyTyxaoL6U1P/U15hJEnVdtxqR/9/JoO/14YG44ccRojDWwR5RI9qxL94szOtuXevvlOpl7oVDiz0M/ToYVlSvOftxrVeHvEZTnzJ9/D4dMmgmSUp0byWyUyOoj+dMKgiuA9indXJlcuBwi+xUPyZcUjeZkCjFL/uEvHv8gtGHdUKgyCTSoWYZHLj0iP3bJ1VGT/UPf+gcFEFq2QrFwCPEJvmqNLFVJUkQPrtnNtF7Rd3y1CLnDcnb3iMRK3qPC9MwWsr5GZ4J5O/2cSuJn6wu12yRTVOQPBv09guHlidSAA8QvWV0/aq8cwuyLJPR33swOaiS9j69Niqy2HVz4CkltqYFPhdND0J2RWjaX2Td69Iyg4=;4:5d+ob/3l2oX5/FqTLBLhkMTWWP3PxSnYisB7QRA/ZCTzp85yhMfoR7sYEmPmRZvCIkCMvtXDvC1QTRsOut+kghFDJYLUxhSwcti5CVbz2q4xh2Qa16qUrBcyh06FRxmkuPr32ev9bNXrR+yhOdRPM2VcWbzS0PyD3iPRm0yLCxeRfMtGWM84r/YyxJNiXUr6sBR4OP2vxzHYNo6jK6FBHTxIdFWizKxw8b4WtLp53u/BHjorAos2JVzC29K3W6VdXOsdwSPqm2jkPb4xd24WYmJ13+0bCkhOUU7AYE+jI7JQ8zSLqfLYBjBWj105UXVb
X-Microsoft-Antispam-PRVS: <AM5PR0802MB24368FEBD0C34DC418D52AB8D9E40@AM5PR0802MB2436.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231101)(944501161)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:AM5PR0802MB2436;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0802MB2436;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(346002)(376002)(366004)(396003)(39380400002)(199004)(189003)(377424004)(54094003)(7736002)(6246003)(81156014)(478600001)(386003)(25786009)(50466002)(47776003)(105586002)(6666003)(106356001)(6916009)(81166006)(2950100002)(55236004)(4326008)(305945005)(93886005)(58126008)(8676002)(83506002)(316002)(31696002)(53546011)(3846002)(65806001)(16576012)(8936002)(66066001)(65956001)(6116002)(67846002)(31686004)(76176011)(64126003)(68736007)(2486003)(52146003)(52116002)(23676004)(230700001)(53936002)(26005)(65826007)(59450400001)(97736004)(16526019)(6486002)(86362001)(229853002)(2906002)(5660300001)(77096007)(186003)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0802MB2436;H:[172.16.45.27];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDJNQjI0MzY7MjM6OXlybWlvR0xJWDMxcHhRUUh5dWRDemRO?=
 =?utf-8?B?amR6bjhaMVg0RFFIeUNYcThuR3hYeUtRYkF5MUREMG5IOGdISmZBSlhXWitR?=
 =?utf-8?B?MzlVU3RiNWJlQWl3am9NRUEvNUNLdTUzSVFmNHdDemt4alBWc0lmOW1acmF5?=
 =?utf-8?B?bXZadm9SUVdFTCtONk9ab01ZZTVrN3M5RGoxMUtCOEFPVFhybTVTdysyVks3?=
 =?utf-8?B?QldRV0pacGJ6UC9qcjRnK3lic2x4QUVQZjFoeTk4Z3lwaEpvNmVYVFZFb1Bj?=
 =?utf-8?B?T2p2dzBXWklpMUdWaHZxdmhVUFNPb3NFZ3Y3VDFxRC9SYTE3TUR3Z3NLcnM2?=
 =?utf-8?B?NUJUL1NpeHFKK0xGSGNXQ3B2STRPQlhHcHNKNU1TUklyOWRvSkZzWXRaWit3?=
 =?utf-8?B?MDliZUgxdDU1LzZveVhQV0x6NjBMaUJuZVFTNm00OVRtTnFUSVlobkY3T3ZY?=
 =?utf-8?B?U1FQck9tTlNIVUxZZXgvblBhUzZDZVcyN2VyZmZvbXpkK0xTNldJNjlJK0sx?=
 =?utf-8?B?U0J4ZjZocTFrR1lYYnJ0cnZZZE5oS2RySi9FQ0pDWmdLOE9SaTdTeXZpQXp2?=
 =?utf-8?B?cGM3RWNkRXpmaU5tSDhWNEJTb2JSNS9NdUpBNE15b2ZjYmQrQmJvNFcrRTNJ?=
 =?utf-8?B?OEk3Z2VaWUZGRkR3eTdkUWNHWWp3dndxTEpqWmM0TmJZOVJqbDVMc1dVRkYr?=
 =?utf-8?B?eTNZYWdpNGw4aHptZDAycDRIMkY1UzdmNGxCaERtdGtnTHFMM3N2cFhteHc2?=
 =?utf-8?B?dmkzQ3duTjRydlhQOEc4MEtMZEtKTkxiZWxnWXF6NkU1eFVmcVdHRS9qOS9u?=
 =?utf-8?B?Z1BLVCsvN1NIS3BQNmxJRmRUS0l0TkdhYzVtQXl2bHc2MEhMT2x4WTF6ZDAz?=
 =?utf-8?B?Vkx3L24zanB2RFdvL29lZFArQlpSTnZyMlFCZ2xaYTk1Y0pyaHd4SVhhdWpW?=
 =?utf-8?B?R3VmTFVPY1oxZVByQmF3L2x6Vnl1a3RkRjYxZDY1ekk2S0hOREFxM0Z1OUhP?=
 =?utf-8?B?eE8vYUllbFo2ZW9VSFRYRzN1QlpEOVR1aWY3WHE5aVpZMEY2UFdvMzd5cHMw?=
 =?utf-8?B?T21ycXJvUU9PK2tsbG05MXFaMnhDOHVvSS9SQWpQVEZaWFFraHlHdkptdkdo?=
 =?utf-8?B?VFlmcWpVd1Y0NDNrWkZnWC8rK09ZMmxTd2tqMXJFWHVXUG9FYUkxdEVLMDl0?=
 =?utf-8?B?Y2pXUWxZWjhXU01pWU5PU1JUOUxIeG8xNmo0VjdVUVpPRlp0TW1FcnhLYnJ4?=
 =?utf-8?B?cjdsSlpuZWN2NTROUWVsa2lIVVR5eWgvK0FCWTNNUEFFTzEweEVWNmhueCs5?=
 =?utf-8?B?VHpsY3NKazVORVp6ZTk3TzlKV2hzempZT1Z1R2tlUklYQ2RJQU1iWnlEU3Zl?=
 =?utf-8?B?ZnN5N1lYdVp1dDd3RXNUWTVJYUh3cVBQbTVGdldzSjYybkVKM20rTU9vRG5W?=
 =?utf-8?B?bjZaaFpmRE1qQWNkS3l3YmEzZTBEKzZjMjVWUG9CcXM0MEtPZklLSHZIYU03?=
 =?utf-8?B?bFdTMk1KL3lGbjZ4RWRDWmVVdE8yUm1DU3JqWHFXMjBkTE9nb3ozdmdkalg5?=
 =?utf-8?B?V3FWSzd6N0s3eDUvY1MwQnpMSVNmd01RT0g3WkQ2aytFYTZTUk4yTXZvUmdD?=
 =?utf-8?B?blRpbHdBVkU4SXlaUWdITCtpNEwxOGdPdjd2bTljSVdXaFVvVTlucEdwbGND?=
 =?utf-8?B?OW40bFU2RVY0K1hGcWFVTjRoQzFLbHpEa1lhTVZrbmJDWlNzR0o0cThwSFF4?=
 =?utf-8?B?bW9QREhyZGw2NnhjSEZDZktsUm53R2lBSUZNN1l5V1NGaWZzS1pLRXBYcVFw?=
 =?utf-8?B?dVJCaUJKTlVOTnVCUzJWK0FIV2sycHNBT1ZsWVFpTTJUZnovd3JTL0x3ckpn?=
 =?utf-8?B?US9pTWx2Q0JwUWtZSXd1a2ljckNJRW1mc2EzeG5VN3k4TytRUllVWlFyMjNX?=
 =?utf-8?B?dzE0Y3VlRG1mR1BGQ2x5N1ZqclhwV3F6ZXd6ZXp0ZEgxbHdXQ2toZ3pKcDJU?=
 =?utf-8?B?ZzVaeHM3ODE0MURob2lnZEZSck14TzhjSFVJaW9RPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0802MB2436;6:e7rXoKfW+ckyJUTvj24m2t9KzVGMp8GmuZrXxjivgfzkjvefrEYLSuL1s1kKnQOe9ivE2vC3r7S6YdUOOwUYnxkKY7OdParZMC/7nMYrMoo92wM66hCvFQhMt5PSvLN2x3oa/xpU9bCexLS/dfb4yQp/E/gvG6Q9vCzuhW7nY6BuJycMDPLMbSvqShHVgrRAo8hckpSP72Nks8KqtvUcPbe9mfNqpgr6ac7pQBiv2bRfOXXUB7AvpWituya/SX3TT3qcxd4npkMUqbzrxKZlrTkhLZRObm1LGt/OXUIlDf+uoUq8zdxmaPFidqKf9MK1KRCbfydQn0J4hf4mVnIMSOvuQAww7JxcHKDXWHHsjVQ=;5:N2PO6DjYrY/GK3xV6eKPgmkSrdlgan8QDSnyWZwuh5uX6+5iyhVLjhokM7e9fzhPe7AtEqQ4XNvyuSGRzCiiW6JowecB1ecUM2XmErMzFqMipzR6B/fP0hrrIj3ysGUkPamvRYbQb4e74Bmkzfz2mqSgY/y1Qf6mqhSjYjrTIzQ=;24:RHPqssTfvwPlVrIrxgi7nE7vQ8MH64gCu4vTrjwfVHJVGWL/VSE96Zq4K1ucFPLecEvnwnM21Qv6rZ7CA6hGlM4pwkec55Iwm7BxbNwTNiY=;7:F0f+GQoyU59cNcF+RWHOtoiXC5yt5EWosZVnJsGYjdT0CwoAiy1O2YhiBvURJewr3EmNaeXT5Uokib1sn3O449N0iNvep99XXFOuRabcHpAD6UtrAEI7vbws2j/ZetSP4pcZKxqGI9v+zS2DO/Ryvb6JNzvEmp5Vgir4RvTvd+JAa6lmGEXUa8qAquMbyJjOsmw59rByGeX6s0agvploH65ol0mzv7AUNPuyxcVQrDtRWxLZUc1DvL0fD8jJAieU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0802MB2436;20:Z+xaqZwaKHXS8sWRjoGsi0SlP8qj38VBV9fTWYKAk9LljhchvXKTyiH+tGsrnq6LYVel/14/pxKJlzKFEvlMzr2qXzVEA9zYdiH48z21U0N5RviqCAMxLqz63ft8Sm/DwIZ60root28iR0E+MfUcWre161BYNuHU7en//hT6jzw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 15:06:43.3065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e50c190f-1d3c-4b84-b811-08d567f3133c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2436
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.01.2018 17:03, Petr Mladek wrote:
> On Fri 2018-01-26 14:29:36, Evgenii Shatokhin wrote:
>> On 26.01.2018 13:23, Petr Mladek wrote:
>>> On Fri 2018-01-19 16:10:42, Jason Baron wrote:
>>>>
>>>>
>>>> On 01/19/2018 02:20 PM, Evgenii Shatokhin wrote:
>>>>> On 12.01.2018 22:55, Jason Baron wrote:
>>>>> There is one more thing that might need attention here. In my
>>>>> experiments with this patch series, I saw that unpatch callbacks are not
>>>>> called for the older binary patch (the one being replaced).
>>>>
>>>> So I think the pre_unpatch() can be called for any prior livepatch
>>>> modules from __klp_enable_patch(). Perhaps in reverse order of loading
>>>> (if there is more than one), and *before* the pre_patch() for the
>>>> livepatch module being loaded. Then, if it sucessfully patches in
>>>> klp_complete_transition() the post_unpatch() can be called for any prior
>>>> livepatch modules as well. I think again it makes sense to call the
>>>> post_unpatch() for prior modules *before* the post_patch() for the
>>>> current livepatch modules.
>>>
>>> So, we are talking about a lot of rather non-trivial code.
>>> IMHO, it might be easier to run just the callbacks from
>>> the new patch. In reality, the author should always know
>>> what it might be replacing and what needs to be done.
>>>
>>> By other words, it might be much easier to handle all
>>> situations in a single script in the new patch. Alternative
>>> would be doing crazy hacks to prevent the older scripts from
>>> destroying what we would like to keep. We would need to
>>> keep in mind interactions between the scripts and
>>> the order in which they are called.
>>>
>>> Or do you plan to use cumulative patches to simply
>>> get rid of any other "random" livepatches with something
>>> completely different? In this case, it might be much more
>>> safe to disable the older patches a normal way.
>>
>> In my experience, it was quite convenient sometimes to just "replace all
>> binary patches the user currently has loaded with this single one". No
>> matter what these original binary patches did and where they came from.
> 
> To be honest, I would feel better if the livepatch framework is
> more safe. It should prevent breaking the system by a patch
> that atomically replaces other random patches that rely on callbacks.
> 
> Well, combining random livepatches from random vendors is a call
> for troubles. It might easily fail when two patches add
> different changes to the same function.
> 
> I wonder if we should introduce some tags, keys, vendors. I mean
> to define an identification or dependencies that would say that some
> patches are compatible or incompatible.
> 
> We could allow to livepatch one function by two livepatches
> only if they are from the same vendor. But then the order still
> might be important. Also I am not sure if this condition is safe
> enough.
> 
> One the other hand, we could handle callbacks like the shadow
> variables. Every shadow variable has an ID. We have an API to
> add/read/update/remove them. We might allow to have more
> callbacks with different IDs. Then we could run callbacks
> only for IDs that are newly added or removed. Sigh, this would
> be very complex implementation as well. But it might make
> these features easier to use and maintain.
> 
> 
> Alternatively, I thought about having two modes. One is
> stack of "random" patches. Second is a cumulative mode.
> IMHO, the combination of the two modes makes things very
> complex. It might be much easier if we allow to load
> patch with the replace flag enabled only on top of
> another patch with this flag enabled.
> 
> 
>> Another problematic situation is when you need to actually downgrade a
>> cumulative patch. Should be rare, but...
> 
> Good point. Well, especially the callbacks should be rare.

Yes, we will probably use them for the most important fixes only and 
only if there are no other suitable options. The patches with could be 
more difficult to maintain anyway.

> 
> I would like to hear from people that have some experience
> or plans with using callbacks and cumulative patches.
> 
> I wonder how they plan to technically reuse a feature
> in the cummulative patches. IMHO, it should be very
> rare to add/remove callbacks. Then it might be safe
> to downgrade a cummulative patch if the callbacks
> are exactly the same.
> 
>> Well, I think we will disable the old patches explicitly in these cases,
>> before loading of the new one. May be fragile but easier to maintain.
> 
> I am afraid that we will not be able to support all use cases
> and keep the code sane.

Thats is OK.

I agree with you that the current behaviour of the 'replace' operation 
w.r.t. patch callbacks should stay as is. Making kernel code more 
complex than it should be is definitely a bad thing.

I cannot say much about generic policies for cumulative/non-cumulative 
patches here. In our particular case (Virtuozzo ReadyKernel), the 
cumulative patches are easily recognizable by their names, they have 
'cumulative' substring there. Patch version is also included in the name 
and is easily obtainable.

So I think, I'll update our userspace tools (based on kpatch) so that 
their 'replace' command worked as follows:

* Explicitly disable all loaded non-cumulative patches first.
* If the new patch is non-cumulative, just disable all loaded patches 
explicitly and then load the new one.
* If the new patch is cumulative, explicitly disable the loaded 
cumulative patches that have smaller version numbers than the new one 
(if any). Then run replace as usual.

This way, the in-kernel 'replace' functionality will only be used when 
upgrading cumulative patches - and we can design their callbacks (if the 
callbacks are needed at some point) according to the current behaviour.

Patch downgrade operations should be very rare and could only happen if 
something goes wrong at the users' side. I think, it is acceptable to 
disable the loaded patch first in that case. Its callbacks, if present, 
will do proper cleanup. Then the older, "good" patch can be loaded 
normally. If such things happen, we'll have to investigate the affected 
nodes anyway.

Same for the custom (non-cumulative) patches. We sometimes use them to 
"patch things up" quickly before the cumulative patch with the 
appropriate fixes is officially released. It should be reasonably safe 
to disable these patches explicitly when loading a new cumulative patch.

So, I think, the current situation with 'replace' & callbacks is 
acceptable for us.

Just my 2 cents.

> 
> Best Regards,
> Petr
> .
> 

Regards,
Evgenii

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeCTWIs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 18:08:48 -0400
Received: from mail-eopbgr50134.outbound.protection.outlook.com ([40.107.5.134]:59566
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751372AbeCTWIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 18:08:43 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBbUEFUQ0hdIG1tL21lbWNvbnRyb2wu?=
 =?UTF-8?Q?c:_speed_up_to_force_empty_a_memory_cgroup?=
To: David Rientjes <rientjes@google.com>, Michal Hocko <mhocko@kernel.org>
Cc: "Li,Rongqing" <lirongqing@baidu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>
References: <1521448170-19482-1-git-send-email-lirongqing@baidu.com>
 <20180319085355.GQ23100@dhcp22.suse.cz>
 <2AD939572F25A448A3AE3CAEA61328C23745764B@BC-MAIL-M28.internal.baidu.com>
 <20180319103756.GV23100@dhcp22.suse.cz>
 <2AD939572F25A448A3AE3CAEA61328C2374589DC@BC-MAIL-M28.internal.baidu.com>
 <alpine.DEB.2.20.1803191044310.177918@chino.kir.corp.google.com>
 <20180320083950.GD23100@dhcp22.suse.cz>
 <alpine.DEB.2.20.1803201327060.167205@chino.kir.corp.google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <56508bd0-e8d7-55fd-5109-c8dacf26b13e@virtuozzo.com>
Date: Wed, 21 Mar 2018 01:08:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803201327060.167205@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [84.47.128.244]
X-ClientProxiedBy: VI1PR08CA0211.eurprd08.prod.outlook.com
 (2603:10a6:802:15::20) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e38c6cc-16c1-4cd3-2a6d-08d58eaf2352
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3258;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;3:1Py/3GHWKpHL36uL1NbhRH/qx2sVkyJ2sKmBFIPOe9pewf+4aJ/IarIU/7uyRn0fRMteBUU4J76fSbSJQHxT8LL66I6gzJ7kSGiDP9Mx0nX8VijpKAAS4Xws0Y/DwOWnKtoixQP0zR0mZ4MLKO/oUYOqPYg8895JUNwfr7W+xQ4u+R7AwfCbBrjm6e589GGLgrOVsIULlq7z+Np+RDoLom0Ip9F6H1oJT3rPXqrKBP2XLGfAu4vGZsEwlYlDWwhX;25:cqvdTA214cc5sPTt3JOrrMJ/R0FHaAAnNxtN0aXjxxNQsKjydwKLgdFLBbH31GV6tidiYmR+ODTZEZCPM85A1MRn7pgREUZXejUlJSC2mDImInsw9rp8fcs0crPYsXfgi7n3kNrMdBJ0EEEDPUG2ZjBpymOm4EO4K7mHiUXAESAJGbQtF/gQpsbuUL2pkTGCtCO0fecK+p63A8zqI/e9DIF0II/nfZCmFAtNMttwhczhenaLLRoQtfwPsWMBgPkhw6xwzDIZ94tAEAGITARUuTn2r0b9iZ5UnyjEn3khYlFn3qtp9g9qCymotojA+1xzPbFUcwjCpT37pUuDzN883w==;31:y1WbeLJV/ew+2fQcaC+eIw6Mr5z0nejTQz8WRyZqx7TQIPHUu52ZMwCBieeSds7bpc8P1ceEU38knFE7UA7CNJf0dpk0MqzmIGfXDwk2/MvCOkcvs+sRJo94TOoRJb8yocpV8sY5WW9OwCKVSpGE0vAM+qyrVE26n433WuuKHoeBbQY0Y2bvwPXmOJ/7mM5e+6h1NC2xxWJbXF20MLvebqrpNQ3w85xUTELppMwKwjw=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:Uqu46cmnTiK98aQoQhUK0mhit+xkDNMOgfF1FmXhazuiyrxvd9kwuiuXwNJlk4qJ27bt2i3WTPg8QSqBUqvNy+Yps0B9FVeRA7GYSiubtCycKGljD/u5vLEXBW4zqjpr8kgriPnxUPGjK4U8n3uhYT/UIriygqP/1sn/zQBPOS9rxMRPix2YHUFNgvctYTbNrV8bQEjYlDHBRUWU5KSlGxbryol1EYU1eDA/swIWTEpbuiZ+HnK2ZWUZIoubJcGtfIbVqKP8plM4NLoJwkp/hzD9EW9rnTClsGR6IijFaBuF36heUP4WNQZk+OGcoIcgk4Mvjwwp6YJ9jynqwylKHTJ/J0HwIY1t9lSIPvgQ45TLmKThus1ZoE0MIdmwsGDGLH00ui6kfMrSQOAlkXMsvzh1uiI7iZuNh4PAsxzwTrm0yhnJ4PujYnVY+qmIhGI4Vwi+/w2se40/ToOImbkqtBr9ps9z1F16pF/Tq9lBigYdPLeL6SHoGABQ78cIeMwC;4:n/zQNsd8YkCUi9tOWyAjBo6A395JzX5HfjjIRPfNOhNQe/7w0qkjdsiR7MBaZ2RIVfJbSq6x31cy+4Febwct/7cg8bujkHPjNOA0yGd4/kgYkXiMWuBjbJVzBQBPVvSDR+05ZynS56xsw1DGHVLspDnAHthtQ8Oh0WW0pBFWmJ+lxKRIDrTy55X8pD5M/6rNbdUcfPfjLZH4XXjWjCu7dWWOWDjUK+Eb8pKW8+VF1kGMuYdgbTU53m5YHHZgtEo73qAfxMhnkhQ0QvS5rbM5IA==
X-Microsoft-Antispam-PRVS: <DB7PR08MB3258985E84BD3525773A9E63B0AB0@DB7PR08MB3258.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DB7PR08MB3258;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3258;
X-Forefront-PRVS: 061725F016
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(366004)(376002)(39850400004)(396003)(39380400002)(189003)(199004)(86362001)(2950100002)(230700001)(36756003)(16526019)(316002)(186003)(26005)(77096007)(53936002)(6116002)(3846002)(229853002)(6486002)(6246003)(31696002)(54906003)(2906002)(6666003)(52116002)(52146003)(23676004)(16576012)(2486003)(58126008)(76176011)(47776003)(59450400001)(53546011)(7736002)(97736004)(65956001)(65806001)(66066001)(105586002)(8936002)(68736007)(65826007)(50466002)(81156014)(386003)(81166006)(5660300001)(106356001)(224303003)(110136005)(478600001)(93886005)(4326008)(305945005)(31686004)(25786009)(64126003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3258;H:[10.52.82.105];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU4OzIzOi9NNk5yZGRPZzRXSzBYVEhXQ3NDQjZsQ1I5?=
 =?utf-8?B?L01Ba1dnU2RGZms4eE4wWGRCZmNOM0xwRDJ1Q1pYbWdHb3g3MWZlTVpqM1FF?=
 =?utf-8?B?d1lwZkVtWDlBdTlBQmtreWlxVHdqY05OQkVzWmZ3RkQvSllaaDc3SGxKWCs3?=
 =?utf-8?B?TVFQeVUxeXhiaURBc0JGaWxKQzUwdjZ4Rmc0Vy9SU0NURlFUbDd3MUxFdVBw?=
 =?utf-8?B?SDdKWmJQdC8vWWVLTjVNczNkOUpTWms5L1N5MGw0N3MxekNLRHZyZkxPazdO?=
 =?utf-8?B?QUVhTi9GM2d1MDRSNGMyVjlid29CK3dFSGFtOEt4U1Z4eU5kNXF5Y1RkTnZr?=
 =?utf-8?B?ZE9hTDdoUFVWcTUwVjRPajAwcGc4cGFUT28wWFdTSC8zVldsWkFHTjdUb0dj?=
 =?utf-8?B?clVEK3lYL09ZSmZ4WGFaNGxBVzl4SEFHZkUwSUo5cjVsczAxdXZ5VFZsdlE3?=
 =?utf-8?B?enJ1MU9YNHhNdVgzM2RERGF1SmxhYTRGeXd5UjRWSVFTdmczZm1HR3lkRUlU?=
 =?utf-8?B?cVRubmRWdWV0U2V0N0lqSEVCUkl1MGd5RDVHRGxHbkJNUTVjVDJRdjlJb3Nq?=
 =?utf-8?B?Q2RuYjN0NVVaRTY2dnR5S0J5eWx4TTZpRlVxaWZaRXc5V2NIamxzZnZJTnRu?=
 =?utf-8?B?ZUdPMlQ2ZVhMbEhCV2RYK2Z2WVpCdVRBOFpnNkoxcWZ1SENmZTlaQ1FpVXRl?=
 =?utf-8?B?ZkJsTnpmOUJGUjFzalBabVN3R0xHRUszeTJvRDBaakdyTXBHMHdKZm9yaTRK?=
 =?utf-8?B?ZmZTcGFwVkZSYzVZTHJOWlpuYjBCeWRiRWZuUlpTMlVMNmVnVWpVWmhGbDI1?=
 =?utf-8?B?bXU5alVpeWlzdlB1TmwyU3RnYjN5KysySDJPTUV2aW9kdkZ6K2VBZDliV1Fv?=
 =?utf-8?B?cGlHcmlUcE40ZWdhR3NxeXFvZmc2M1l1RXdweDhVZkkxNGdRaWE4Ykd4Tjgv?=
 =?utf-8?B?c1lManA5RmVHZDVBNGllTW5HRVN0YThTZE9sNE9KREZRdUZsMXJXRkp4YVJs?=
 =?utf-8?B?NGFhUS9XSkxTODdDTXJmbVJNaGU0dEpvb2s2UVBabUI2WG5jUFhUYjBRU1N3?=
 =?utf-8?B?QVFaWVBZa0pBbWhwdUUwWU9iOXlKb1dVQU9DVk1SUzZtRXNuZmVhZGx6Zjcv?=
 =?utf-8?B?N3JkQVpvaVlJNVQ0WTNoRlNNTUVhTlNYRWErOHk2VWhoYnhoSFJmeDg5YVBa?=
 =?utf-8?B?d2NYTEhtSTRMemt5RVNpallRaW00UG1Yc3Z0U1NKZXF0Z3JmTGFkWkNxenJ4?=
 =?utf-8?B?R0w4SkxHOUg0SEFSc3I0aU1rK3NPdkdVVytoTi9tclZlankrbnMybGhkckNL?=
 =?utf-8?B?U2d1Q213QUJ2TUpiWU1uYnlwb2NSUjdaRlByd05NdENncEllUVFtSStHelQy?=
 =?utf-8?B?K2xXeEMzbnhkT3JjbnNtZmFveWw1VVF3YmdlYXpwdzNwQzZrei9rQTVsTXB2?=
 =?utf-8?B?aFVIUjhWTGFCZ1NOSDBCRXJ5d2RNSHYrL2R5aE5Ca0ZaK2VkN0w0N1RFTzFY?=
 =?utf-8?B?S0hWb3QvRldaVHA2VW1NWlpDTkMwWjBlWEY5RmtCdVdEbWxLN05lY2JBSDlZ?=
 =?utf-8?B?eUl6aXVsbkZya3NDeUtHZjVpUDBMYmpiVGx3WnVpU1FseGZLUXliNEwrTVVZ?=
 =?utf-8?B?QWIyWnMzTjBmdEQwNGQ1NGd6a0oxcFJtbmZTcGp3VXJRSkl3d3BnWXgrQkIr?=
 =?utf-8?B?VHdYWE9CVHdkeCtHckZ0aS9lOVlFMkg0Vm9EUFo1WVFYUEJKYmltcUNhYnM0?=
 =?utf-8?B?VTFnMzJvNnlTQks3S09EczQ5QVhaRkI3SFBjM3ZkNFFHbHFKc3dqZTBNSkYz?=
 =?utf-8?B?MGp3dXlQd3hoMThubkYrcEhROXV2UU1zM0VXcGowVExFQm1TZGtqUWdVTksy?=
 =?utf-8?Q?yYze3AH4RZoFpbV5ANG3FNb++qRW8Nt5?=
X-Microsoft-Antispam-Message-Info: UlB8OZUobCEatwEXLjCXCUsQcqGYXVG0XrwPwUbBWrk/T+5ZwS/blwgOYBTDKOLKz/80NEQ0TvZwACHR1oOqqSC10z5OqpO9tYcoO9SJZUz/vFowLAnj6R7IQJe+WwHnjW/pKm/duTBZqjisrdsKNtED8nLmm5pAHQRdS4r3FPrdU3ITPDeZN/L1FM48q4uo
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;6:DjGvSaYBnaLK+GjGaaw+UPi4BuZo0slyd3ESTM7e1Qh4PMuDLikCNfEobwi1264N5nPMt7IqH7iE2Y1dUJqe2z7iC9SqsG7ZBzbZCkLpd1zwPIn5G+viGh57dWsXPXaBtEbRH4Gd16vizJ3nXyWsQB0VlTrcYNFi9oQLgU5deFG6+iNveJWnZgM912Q/xmI0G0b1MhURpwWhM+Ja5LDBf2MDoKuCGGff+MgI965lkgrFUpB8maJ6GHKqh2mJYa9Iudtrt0092MC1hQ5yM5cYaySaeNv6UhbvlUloYq5EMgvznoYWm6Xu3CPFLqX7CiiWVBkD3PUuF5JZsJPi0eOW5RGJCv7uKU/SAuREjAIrkSQ=;5:WcQG71+tLg5rNsp9yVjaViGqXFoblqpyzDxju576TlBBEIkPrO2lyNVXPmm1kKGWpLj8/RM6W+QS7lZSz4o1sunziLDO6ClnTJrTuYJSlxDd+1tvuELF9nxHR1rOc1qPcyxD7wo9IHPOjLIEvh+0CV5OudRsXmW/5mGiQ8hI3MI=;24:pvw0osa2CEovFn4w8IU2N7dhON6ggWJ9bHgrx0IsS1C93/WBr8GDnnSNz0dpbGxWXXrfIlfK6sUlf9hp+ytVjOIFtnXfkpOjc+ewc5nEty8=;7:J78Rf8zixrhogb1J1BY7Lytc8+NCOAZtwt4BygiGNvwJkZKkwTA1OLPGzIVQXVm055n3sRAEhpn9MoxeE5nZ1CXbAHfecyskqpJ/FYlx/Lt1VkQpQO7TEhSnUk7TaBJ8ht+LiDmlRb4Aw0xTqX7XJMKPGeN6VgqymBoCSsmlqrwzVMurW9goVZL3UF4SEYImRANp9Re6UhN7Vn6r16P7vEJocZAtm8sJiPvmpJ4gbeodWbFCg90X1/47nZKRRheZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:X77yc5jq/NQJSVW6aJMZcT3hITVKrHI3lFqNTgw7NNcpVieRSWh1MrBFR5hch6rcHbSP/+LFTsDFSVS/wZVUUcHRFHXw1m+BBjCUXeiAwes4RxeHN9xxo/rGW6lAGYqjicPi1BYRvCRMFt119c/911o7V8LRpgmM0vypx7vFs0k=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 22:08:39.5332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e38c6cc-16c1-4cd3-2a6d-08d58eaf2352
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/20/2018 11:29 PM, David Rientjes wrote:
> On Tue, 20 Mar 2018, Michal Hocko wrote:
> 
>>>>>> Although SWAP_CLUSTER_MAX is used at the lower level, but the call
>>>>>> stack of try_to_free_mem_cgroup_pages is too long, increase the
>>>>>> nr_to_reclaim can reduce times of calling
>>>>>> function[do_try_to_free_pages, shrink_zones, hrink_node ]
>>>>>>
>>>>>> mem_cgroup_resize_limit
>>>>>> --->try_to_free_mem_cgroup_pages:  .nr_to_reclaim = max(1024,
>>>>>> --->SWAP_CLUSTER_MAX),
>>>>>>    ---> do_try_to_free_pages
>>>>>>      ---> shrink_zones
>>>>>>       --->shrink_node
>>>>>>        ---> shrink_node_memcg
>>>>>>          ---> shrink_list          <-------loop will happen in this place
>>>>> [times=1024/32]
>>>>>>            ---> shrink_page_list
>>>>>
>>>>> Can you actually measure this to be the culprit. Because we should rethink
>>>>> our call path if it is too complicated/deep to perform well.
>>>>> Adding arbitrary batch sizes doesn't sound like a good way to go to me.
>>>>
>>>> Ok, I will try
>>>>
>>>
>>> Looping in mem_cgroup_resize_limit(), which takes memcg_limit_mutex on 
>>> every iteration which contends with lowering limits in other cgroups (on 
>>> our systems, thousands), calling try_to_free_mem_cgroup_pages() with less 
>>> than SWAP_CLUSTER_MAX is lame.
>>
>> Well, if the global lock is a bottleneck in your deployments then we
>> can come up with something more clever. E.g. per hierarchy locking
>> or even drop the lock for the reclaim altogether. If we reclaim in
>> SWAP_CLUSTER_MAX then the potential over-reclaim risk quite low when
>> multiple users are shrinking the same (sub)hierarchy.
>>
> 
> I don't believe this to be a bottleneck if nr_pages is increased in 
> mem_cgroup_resize_limit().
> 
>>> It would probably be best to limit the 
>>> nr_pages to the amount that needs to be reclaimed, though, rather than 
>>> over reclaiming.
>>
>> How do you achieve that? The charging path is not synchornized with the
>> shrinking one at all.
>>
> 
> The point is to get a better guess at how many pages, up to 
> SWAP_CLUSTER_MAX, that need to be reclaimed instead of 1.
> 
>>> If you wanted to be invasive, you could change page_counter_limit() to 
>>> return the count - limit, fix up the callers that look for -EBUSY, and 
>>> then use max(val, SWAP_CLUSTER_MAX) as your nr_pages.
>>
>> I am not sure I understand
>>
> 
> Have page_counter_limit() return the number of pages over limit, i.e. 
> count - limit, since it compares the two anyway.  Fix up existing callers 
> and then clamp that value to SWAP_CLUSTER_MAX in 
> mem_cgroup_resize_limit().  It's a more accurate guess than either 1 or 
> 1024.
> 

JFYI, it's never 1, it's always SWAP_CLUSTER_MAX.
See try_to_free_mem_cgroup_pages():
....	
	struct scan_control sc = {
		.nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754681AbeDTLVj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 07:21:39 -0400
Received: from mail-ve1eur01on0118.outbound.protection.outlook.com ([104.47.1.118]:1056
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754549AbeDTLVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 07:21:37 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH] sched/rt: Rework for_each_process_thread() iterations in
 tg_has_rt_tasks()
To: Juri Lelli <juri.lelli@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org
References: <152415882713.2054.8734093066910722403.stgit@localhost.localdomain>
 <20180420092540.GG24599@localhost.localdomain>
 <0d7fbdab-b972-7f86-4090-b49f9315c868@virtuozzo.com>
 <20180420105852.GH24599@localhost.localdomain>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <54eef2b3-ac54-aeac-9b2c-6cc6f7132170@virtuozzo.com>
Date: Fri, 20 Apr 2018 14:21:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420105852.GH24599@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0245.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::21) To VI1PR0801MB1341.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:/KglDkNM0m415uM9bUoBIWXTpmD0jOUqoduXlHzUzzmyihU7yPCfaBOwMs2RmpOzCi+/KBfDHoY3zApoMQY9lpVlyhTj9hsZV+vOKG6KyfqoVwS5IcMAb2UiKTMEf9wCHAExF8DigscFYxG7X7npXgXsI8yZoDo183+xL4MH96mrisb0uGCN9oDVuyZJGCm10/9S+pU7qCxSYEjKeL+yFAhQepG0ZJPpi3aYmNzSp6VAfsWXko9iSLV7MqdhnivS;25:84P8FNNlDQpbr07BJsSMlx6+hY9/Vrton9c7dG4W7JCTzHJ+ThVcj3KNtaa1IjVNR4KsLaRayTe+nOfwY6ZYT50R/ZCisbtlNukaycmHnLMrZf+dXRViH7Px5KvEaLDkyX+16lO2wgV6bzMHWVlpD78ZxaGVqgLQMRgDmwPcZNyXiGRi3SlfxVfBXOw0BeaBAImwocnpHaetcS1gDl9/AhSV6biM9WfdkHu4BHNuwkBRbT9xeqs5pK+2Gc0D2loYLs4cIu49dpF4iFh8zwYCTnmsGfog+K6l7H5uh7e5rWmXBa++u1JR7Db5Ri8kcl97LSIB0I6TJfA/DSlBn91kog==;31:TSLoWblQ7xYYBDKv2rECLd+80GIyfEJuHj9hmuT4NSV8ZvwDEKULdQbltEMCUQzTQVIHfQiGN5eSniCCeYFNqShwmE4Db505QOt6L5WNjVrHaxeBuQYy38N9/uocKScHRsL8mD5MHfoaUyfEfd1Sz/7c9QO9huzL6wL0JMaA4HVlMhrXXyzht3OVvCFn9+OaD5p6bXnwAFgT6tqrtFgjJ4Mf+9AohomlLs20tSSV4IQ=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:2zYuW1ceOF8wQTWbm7T53TOZhYHaOshX7J4AlPZm5F4/6zjp63kW0ulaj/bVyQdYyuAwLovb/6House6w479qrf4scjo64iQhRCi7qbAcQgZX7zYUwa5iKvBv8pPPPQP10d9KxIhRKPDlTNt1pKZrqY3ZkYX0WTG+Amah5/oXHSs8mMkw7EaBD5Z0jrbATYPusBZOND/QteBK/VGQQ9tUTKP1mreIbl7g4th3MeuxZN8M7GNvL7acMgX9kXY5a6ixFYaL91snu7rdEHgmgnfrqHxrd52pwDq7VubTREec8jn/9TiTVaeMHkLW0Dn8aKvFYTpZMBIQRLNjshhiHVcIPdOTILTBfP40dJeXE0v29PzFSx3wcRsCOW55AKkgYT8zD/rcFhWZIGm8gZXTH4lwr55gkuUGMic85eWjp9kru6p/JEd6OIdWZ6xDd9eRveGwnEstUL+VB2kQgAid+Ahs1U9RpkiYKPxy4ZToM/Ju7yX6WCHjEg2Dbcq0xRSXRj1;4:0ZpsO+34GdDA947RmYmYGWtBqu4M/vaEesxsTYqO8GWCmIRqkKVWFG9F+hbqFsTBW0xpBEwmchZs60Px7YiJLyoKZiHeYTD4sE2vY7U72ZWiBvquhlhDZNWeKPS+drgNokQhqNhVRaSTn5Z5qwj4fjERO930cJHmGF/2/k1JTMrnzIJ4GNbG/XLHk8D3WtJVusePuVGIFd9QCGLJgxQhh7Zqk60BKzxqN0QNliFWNkNTgO+F2KwWKcITZelSiaTWi+OfnS8mkBOkeZ+UXXttgg==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13413E9D6676AA55E6670D07CDB40@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231232)(944501393)(52105095)(10201501046)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(366004)(396003)(39850400004)(346002)(376002)(16576012)(58126008)(16526019)(3846002)(478600001)(52116002)(2486003)(26005)(6116002)(77096007)(59450400001)(6486002)(25786009)(305945005)(2616005)(8676002)(186003)(23676004)(31696002)(7736002)(316002)(11346002)(229853002)(93886005)(6916009)(52146003)(76176011)(55236004)(476003)(956004)(230700001)(446003)(386003)(53546011)(86362001)(8936002)(65826007)(4326008)(39060400002)(31686004)(64126003)(36756003)(65806001)(66066001)(6246003)(53936002)(50466002)(47776003)(65956001)(2906002)(81166006)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:[172.16.25.5];FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6K0FDdDZJZGpMZldmUE1GcDU4SDZsZVN4?=
 =?utf-8?B?SWRPSlBEYUNyQVpFWG15ZGhsYkJqYVpnb0NQaGNPNXo5R1A1dHA5dnJvdWwy?=
 =?utf-8?B?WGEvZzlmZGRlQWFyVnR1ancrekkwaEdjSmJ3NHFMZDJSL2Rpb1J1VDFmdE5K?=
 =?utf-8?B?Yit5NG1BNnZSc1NkN2dwUWpiSm1Dc2M5ZUFLZzNTQ1JyYWtWUnFKSHc3bXN1?=
 =?utf-8?B?TnFtQVdLVmxkQi9ienI4dGdTRUIvNjg4cjNaVXB2eC9nMUZ4QTlCWC8wUU02?=
 =?utf-8?B?cnd1ODBHbHRnQ24rWHg5WWJ3cmxENis3UFh1OHR1Ukw2UEF2SWl4V2Zoejhs?=
 =?utf-8?B?NVAyUlh4aDBmcCtLdlJWT0Qzd1ZMQllCaWdkZEc4akwyaWlGc0lOSXBmTWdh?=
 =?utf-8?B?bEh5UlVIME9aT2wrMVFmTnp2SjVnbFJqL0pGd0xPWlZwdUg4d1J3bFNLUG82?=
 =?utf-8?B?Q1dpVGtLNFMrRHRVaXoxVm5xeHhaT1M2VnJzMWUyUG5MSmVKR2srV1E1TzVv?=
 =?utf-8?B?QmMyWnlzbzFVaVBxMmxETExIQWw1VU9ZVGhkTjNZemhKay9qdXlNcEQvTTVC?=
 =?utf-8?B?am96MG1YUHNjSG15WVIxUHNubmh5R0Z5cjRLaUcrTlpNYmVuTGt3QkxjUXAz?=
 =?utf-8?B?dThnNkNFZ0VGM2FLczhwOTNDakFISkNYcWxPbyt3ZEJLSlJBZDJ1Y0pvcnhT?=
 =?utf-8?B?OUw3aE56ZnpXbnQ3a3loaStnODJnRzU5dmZ5TldDWGJNR1BtYk1DZCtDc245?=
 =?utf-8?B?T2dVMmp1dW9hRmcvZjFTMTROd3RhekppRS9aQ1RRQy96TjR2TGtMOUZjTnpp?=
 =?utf-8?B?UVYxdjlsR296RE1reHNiUERoUkxlRmlVK2VrdERZUzFGdUtra2YxNW4rd1lv?=
 =?utf-8?B?NmdjYkswaDc4ODNOSjI3K1JBaUNrYVA3cWdLR3JJN3pONVl0T1MvbzBYaWs0?=
 =?utf-8?B?RVNlOCtGUEw4ZktSNEs1TmlTVmwxcDM4Sm5yV0psS2VLR244Y1BucTZpUXN1?=
 =?utf-8?B?L2VpNUVPK2NuTmRTOVBKbEZLTmw4TGpZTDdGVnNKS1JKYjgzL2tvUDdYajB5?=
 =?utf-8?B?Mk1uK0dNTWVGYXNHUW5MMkcrUFRWTCthWTJsTkJzY3NBeHlObUloa2l6Njlk?=
 =?utf-8?B?VTNOK1ZOQXFZelcrV3BVUTVKRzk0L2tlNStxU1FrZnUvTWMrUHQwaFdCOFcr?=
 =?utf-8?B?NjA5clRXVUoxQ1FqNlMwNkVHVjJEZUNRY0lwTTRZaHhER1o5bU1UZzdOcGQ5?=
 =?utf-8?B?MkxSczl6MGxWZklvUWwzbVpoUER5ellKNFBFcHZubjljVk8zWXRtdjVZcE0w?=
 =?utf-8?B?N3RnVmQvT2NQWGQwR0IxNCtXbVFPL2k2akJMYVZudGR4cjlVN0tSc1V2YlBZ?=
 =?utf-8?B?UmN4U1d0cDdLSkRCWVJGTlJWQ2x3eVRaY3o2eDFpSkdaSFhjUkVCcFVXb2hL?=
 =?utf-8?B?Z2Jja24wcXQrVERMei9FR0ROaUxudy96a3c4ekVtZnJ3QjhOR2tVOGNzWnMy?=
 =?utf-8?B?c1VQOG41VnBxRUhJcTdHbTRPMldxN3VVdHV5Ty9KNnUxM2taakU4YXk5bzdi?=
 =?utf-8?B?S1RXR1ZBc1o1OW9VV0VVQUdpVE0zTXp5aWMrSGFITzRCdmtQeWRMekcwNzFp?=
 =?utf-8?B?TFpIbG90cmFHU1UydjRYeUhWaTlyZ2VFNW1VTlQ5VVZ6Q29LYnhGZlpyK01M?=
 =?utf-8?B?QzEwL1ZKQVJ2T0dHa21Td3VKYVFNK3N1R3RHOTlEQmxSRnEyYWpIbXhCTVJj?=
 =?utf-8?B?MmhUNEJNU3U2OUg4dVl0aTVFaUxCNU1JRUVmd2J3L2pYY2RiQzNMQTN6K3o2?=
 =?utf-8?Q?va5vERyXi4LaRgC?=
X-Microsoft-Antispam-Message-Info: 6BNZK2lokM0sHd4LFRM6ITVUMC+ugHq9qFMxq/H3v6sOC8hrknlQ0x6BPkuJTu11LX5EM3/K6TCx1HevQqegyojyAojTAnyMTQfgCgJGjEKWfucBDHubws7CGbKBN9OAKXvjFvmlUxBRXxrwYmHWqlBmyC377yhpDgBjj/9Cm/e8e4MhWV0TAAyKxOmar2MV
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:qKKhCXDDmp8k0S1x8JTgrRjOAciXH1ENbWMAoaeazztz9v6qcw/33uauiZia/UK5rEPFIw74LboJIcqlNmN+bj41Ihp59a4W8fN0G/n76CMenaYeVJQOcZ+KlsgG0vp4ULnwL+NCdXd2f4XHL/tHHckddzcIr8bsWtCco6tB3LRgPmkzPm/A73feG3fAI/E5vIZl2AbiujjPY6SPgtsbCGwv96SjUsssf/ce20+njB9C8wYXYj10u3tnUfvbTHfn80WYtTRblP8ktK1rWJnqCzEVL1oYGWMNTR81OSJGtRt72cuirwqzggb4JuJO839htFiffXfKpFnqk8uHkolpNogDFxXcaBQ4R2EbyG/+VCGRiau5Ew0rhoG9JPqLGiQb8Czht6shGcxvwi/l9IG4DbxVpeOsqmYuw9nnfcdl4I4QHiDanywd22ORVqsaWLOLzUhsO5PFezhqRKgssJINOA==;5:5JJOSGjWg6sqafhpbM8XZbpcqJkVUQIv1PWbGkoKaN1zBQkDKn1Nwq683OKktxl+i1SeHBDsZZ63jtz5oJaYnwj+IziVb5pI4THBRThdHbOmv4lP6li2Rf0+5RK5s0ssry5WUEUhkjo4Du4S/vjVzVXt05NAUfQk3u6IBWLbDAY=;24:DrTb3t+HzZTMvBSqluJ7RH48xoblTblNfUI4o2FRMzAG0ooaEo8cE62cwtpkXCaDiN3RhjD/GwFA/h/IqRFJPlvNNNC3i/HEcNd8KW2IkdQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;7:8VwmG5uktmRptTkgw/IKaLgUeILfBN3OhJ5u+2oyV0YzEaad2aoBWhmj3d43aw1YQtKysAAhs+bOyrbGjoJURufs4dDwDfzQQrQmcdWLbngrXGKy3wI312cdfzgg5r25QNVZ/zRvKZc8GYRKbAsmWN9KhvntXdXzVbAmY+bozHVlUgZXfc/rQQjv5JDern7uyqRZs3xU354ym2oh59UILSEEeRUGpPPCevnPfWDr3HneUwNruIzbs0yS79DpUvMH;20:fRIeVg74+ZKRckn5Fkio86tWLWfO7LTgCT5JcC1AW2f4J+M5CK8zIMsgtsPgI+yDod4Nxb0sqqpXGx5YV7OHPgttcs+E9fNnoJK3jTMUQ4g3maO7kHUKg4Ijssfry2D9GiyQHO339kSaDHmXb37cXa908Qmc5Wl7ERhNKitTjuI=
X-MS-Office365-Filtering-Correlation-Id: eb4336cd-d6a8-4fdd-ce30-08d5a6b0dfc5
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 11:21:33.7468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4336cd-d6a8-4fdd-ce30-08d5a6b0dfc5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.2018 13:58, Juri Lelli wrote:
> On 20/04/18 12:43, Kirill Tkhai wrote:
>> On 20.04.2018 12:25, Juri Lelli wrote:
> 
> [...]
> 
>>> Isn't this however checking against the current (dynamic) number of
>>> runnable tasks/groups instead of the "static" group membership (which
>>> shouldn't be affected by a task running state)?
>>
>> Ah, you are sure. I forgot that rt_nr_running does not contain sleeping tasks.
>> We need to check something else here. I'll try to find another way.
> 
> n/p. Maybe a per rt_rq flag linked to "static" membership (I didn't
> really thought this through though :).

sched_move_task() does not change any rt_rq's fields on moving a dequeued
task, so we definitely can't use rt_rq to detect all the tasks.

> BTW, since you faced this problem, I guess this is on RT_GROUP_SCHED
> enabled boxes, so I'd have a couple of questions (not strictly related
> to the problem at hand):
> 
>  - do such boxes rely on RT throttling being performed at root level?
>  - is RT_RUNTIME_SHARE enabled?

This is a machine with many fair_sched_class tasks, while there are no
(almost) RT tasks there, and there is no "real" real-time with throttling.
They are not interesting from this point of view. Very small number
of task group may have rt_runtime != 0 there, and where so, rt_runtime value
is small. The problem I'm solving happened, when rt_period of one of such groups
were restored, and it hanged for ages, because of enormous number of child
cgroups and tasks (of fair_sched_class) in system.

RT_RUNTIME_SHARE is not enabled, as it's RH7-based 3.10 kernel.

Really, it will be very difficult to provide real-time on machines with
such the big number of tasks, in case of tasks allocates some resources
(not all the memory are pinned from going to slab, there is some IO, etc),
since there are some tasks-to-solve even in !rt case.

Kirill

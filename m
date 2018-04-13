Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753978AbeDMLtm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:49:42 -0400
Received: from mail-db5eur01on0124.outbound.protection.outlook.com ([104.47.2.124]:37184
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753126AbeDMLtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:49:40 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH] memcg: Remove memcg_cgroup::id from IDR on
 mem_cgroup_css_alloc() failure
To: Michal Hocko <mhocko@kernel.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <152354470916.22460.14397070748001974638.stgit@localhost.localdomain>
 <20180413085553.GF17484@dhcp22.suse.cz>
 <ed75d18c-f516-2feb-53a8-6d2836e1da59@virtuozzo.com>
 <20180413110200.GG17484@dhcp22.suse.cz>
 <06931a83-91d2-3dcf-31cf-0b98d82e957f@virtuozzo.com>
 <20180413112036.GH17484@dhcp22.suse.cz>
 <6dbc33bb-f3d5-1a46-b454-13c6f5865fcd@virtuozzo.com>
 <20180413113855.GI17484@dhcp22.suse.cz>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <8a81c801-35c8-767d-54b0-df9f1ca0abc0@virtuozzo.com>
Date: Fri, 13 Apr 2018 14:49:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413113855.GI17484@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: VI1PR08CA0219.eurprd08.prod.outlook.com
 (2603:10a6:802:15::28) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:aFfFyfPUIRiM3bEMJ9kAxbIyx5MDroSk08NVMYrygoQo8cg/UjxvJ0FaqK4F2uaIz5mNcU5nAp743JojHMGvz/2sZAIJd+UVY4v9FEJw+5bednvNHDyE/RpZvno7wppXNDjNSHRsZscfRbct4gGegWOT/PR4yIY8VAf+cdnXb7SuDiA//vJ30s5MQwVfYGbJZ4radWvLe65i7hQcsLZB85wnokcFgcF+l5gdnJAYvkxT3U+aT70tzWOqmFNWR6pu;25:UjMzA2FeUWgLeQCkDbeYjqs1zkpqLPit1BcSbZ5HpvBT3ecPOTpcCCumKKDJcbV4VIU3O6yjjVSmf7iuRB93TsVxfWQRryfNPnAwE0qAJv2lfy14ouD2IxaA0xKQn9N75C16GTEly3OpiUxHFcEwumzKahFcqQN62o/Ca38h8ZgkCNpakrJB+NKGch4NZOhhHBQmaVmsCMX9AUqnKZ3C2mquP0CF0rFE47xOOlOo7mtxMlCAbu7nM4RjZk/uXoxc5jO8LZHOfMyxzJCoa3DN/fKwJ+BFwHYOSAW7GoGYL+sD0P7BbPwl0ooNioQlkeKUOt9hmlcnVnIbfDU1uTBYTw==;31:3WhwAk6U868yLh6AKFlTMkkcnYYI9BW6ymdNdhY8CxpHtyfmUgmA+dCabSQOAv4jWPcxe/eldOTKnwjPWFA1maSqd5CleTveFVXLw4IbjjrdzReMtUddfMqICOQjH6LwsO8SecTFdV15xbnu2sfZrjm25Ylq1amMSGXNjYKIdQMUSI2OPVkYwDYIqPhBtsUvY6aKgKYMtUSTzKEs9wnTjyvSc9CbtkzowyCqX6Idt2k=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:j0oEkiLOlkdH65xGq7z8xM3COmTb9/JpLKRA3DVawjRl2npVGgMIv+EhbN4uurEY0njzFIHVMElPHoZWakrVy4azPVBtBYvaNKsygunO01Rwf3+mkBVIXOrH36VU0Pw9zx789YD6Ax5097fJr2pi3a3fwJ94I+85T0ScV13eQgSCjWMVs571zS9zA0dTw7GBLf5QjHVXsaCc3HyL+WHIyTkYvFY4Xj6a1EEmBNhgJRo9eBO+N3Z2vP+PdYpH6cEYwrbn2QJaJgmXJOqd7N6WV6kL5agTYl0yCKKU3g203dCin6MGT1+lScNeAW7c1t57f34HgvhCrHVpZPVJGUI2R4IXVbzJCy4kieq6Tf+mefpjhfCq2Ecv62mgUlI6vyGcc1Wtd3RxBZ3g5RdtDnBhWkETzQEb5wbD3/+WKQT1PWdvMYRmvPTnsMSn8Z23dF08R9ap4xjUnRJ3TJndNcKkhGb+Vqhoje6QA5zGpvHcJaeU16d8S9oP0gvNMTcVQTWK;4:0r2Aek/sYUClDm2E4Y/qHqduzRrd+9bosuqxOHY6Fm+yQ6fKbsSjzJ5BGkyNttl0tUBHM72rcA1OvkH/pf8NEziY0bPsDpAjbdr4ue4lI1ldG56f521nJf3Nx/sDoyr1slvh49PVIJSbBhyJiyN4NWH9gHsvIaNlvkhCbQgZkW03XR9iQ+NA3BqfvJnl5B8n5jkctjvRt3GISkBEg5pPTSz0sbpUGCQfAkQRmYn2FTh06xF/fxTq5LDWP5/zOT4S0fb0UcSYd3ExJs8iWFlUvg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB133860DC9360CA502BAF9328CDB30@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0641678E68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(396003)(376002)(39850400004)(39380400002)(366004)(189003)(377424004)(199004)(52314003)(50466002)(2486003)(81166006)(316002)(93886005)(6486002)(229853002)(66066001)(55236004)(53546011)(65806001)(65956001)(81156014)(59450400001)(6916009)(5660300001)(3846002)(65826007)(58126008)(16576012)(7736002)(39060400002)(64126003)(86362001)(386003)(76176011)(305945005)(68736007)(47776003)(25786009)(77096007)(230700001)(31686004)(186003)(6246003)(52146003)(36756003)(26005)(478600001)(2906002)(486006)(8936002)(23676004)(446003)(4326008)(6116002)(11346002)(476003)(2616005)(97736004)(6666003)(106356001)(31696002)(956004)(8676002)(105586002)(53936002)(16526019)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6NnhJb0FIL2pkelM0QVhqeDEyd0pLbzl5?=
 =?utf-8?B?N2Zja2Y2OUd4WjdONGlKOW1qbjd3ZzllMFphNk50SmlLVHMxZmFLLzcvVVNo?=
 =?utf-8?B?OWU4a09ocFJmdHRZczREaDJaL01vbkJXdWlsK0ExOGsrNk9QM25ORTBENFE0?=
 =?utf-8?B?Y0ZybjNPTkozT3JuTGExWXRVQVNIR0YvZlVlUWVaREI4YmhVY0NxemVDb0ZB?=
 =?utf-8?B?cGRQQ0QvSXVQaVp4VGtMTHplZ00zUUlhWjZpN1FxT2NyVTc5dzF6bUtsbHVE?=
 =?utf-8?B?WmZsOEE3eEFwK1FrY2ZHbGxwRCtQclZiUlBFclN4d1Y0TjZwbzJ1K2xja0ht?=
 =?utf-8?B?dGd3ekJ5R1J0Y1ZZNnNLS3NkYzZ6bHRkRnpDWElkRzdKNkhCcDlmc2sycWRF?=
 =?utf-8?B?WTBTclN6L1JvNkl2ZCtqdDhyaVNiWWNUeGFkTGRoS25vbFZTd25na2NibWd1?=
 =?utf-8?B?Wlp6NGZkY0FKUDZ4cXcvbFgrcE5kMERQSWhVcmZsTHJQaE5jYUs5RWkvSEhH?=
 =?utf-8?B?eUwySGIvZGRBNmtTWk56V0p1SVdOclhocE1ZbWJqWVliNXFLWUlaOXVZWlRz?=
 =?utf-8?B?T1poM21Yc1lVaTNmQk1BRUJLRFBkbWFwWVBwYVpEM0FPUFJlaTZDRXhaMndj?=
 =?utf-8?B?dlN1OE9JT3M0djU4VnVEVmt0aS9oVE0wbHRuUXpEaHI2bEViOXJ4ckhnSXdj?=
 =?utf-8?B?WnNDeWVFTE5Fc2NRSXBRSFFOYW5ZVGlBTEloN1c1TlZHTU13RHZFdHZ2dmVC?=
 =?utf-8?B?TjV6dUNDclJHc2JyTjdXOGt4cUtHMXlMN2E3MTY2eHVTUktPSlZwS2M2VHF4?=
 =?utf-8?B?cDN1T2U5VllOR3FrWVdGeFd5dEpGVHB3ekFNa2lVNlgrV3ZSVTQ0Y0pZdXZG?=
 =?utf-8?B?d1JIcHpmZldSQlloSU1zQ2xRWHIyQ01oZm5jMjljN0M0SnRoTmhybzAwVUtK?=
 =?utf-8?B?cjA3cm5jK0lGU3JSbHphTmltaDhIWXhYZzdGYmZudm93VXZpcVhkWVA2RjNm?=
 =?utf-8?B?MldUSzU0T3lmR1pEb1IxdEJ2NGZBWHdDSmhwM1FGOW5DL1pob3R0b2VPRGZB?=
 =?utf-8?B?NXJkckpHSzlBZ1FndDFISHI0bG1UMEJQTmtvWUowak1RM08vZjFTd2FucGIv?=
 =?utf-8?B?YStJWHpobCtKVVJqYlQ2MGZPMlpDU1dlbjFFQWtlVDlyYWNKTFM5WjNCWHNZ?=
 =?utf-8?B?SWRFd3pVUXQxWmJ3UGZTcjNNVkRDY3JrL1UzNzFvZ1FGbUcwbTVBeVJxT2xm?=
 =?utf-8?B?Rnc3VitNSFBObGlhS2JzeStzNEREMks2TGQ2bWFXQWxJL0szSGxhTmlJNDlS?=
 =?utf-8?B?YUZnVlRFSHpFOVgvUDdTRC9rbENweVdoWUo0VGFlWUk4NUhobFlHZUN2cmo0?=
 =?utf-8?B?blNQVVZCSjd5eUtVeWFONlBIOVNCWUprMWxJbUt0ZVZQaXdtUzVuTlB1Z3k5?=
 =?utf-8?B?d1BEbkFFRGlrUEVFb0h4eFYrYWh6bkZQanRWQ0Q1VUtmZE5yWG9LeG9EV1lw?=
 =?utf-8?B?UUVXNnB4cHp2M0VnaUdGZGc4Q0c2SlJORTk1cU9Udjg0STVGNHFlYmJNVjZC?=
 =?utf-8?B?R0cvUGxWL0x5QldKMGxob3FwUUtMc2xvS0RGelVLd0dkZzVZZHlja0gzZ0tZ?=
 =?utf-8?B?Vjh4L094TlZiYWhNREpSZDhvemlvNC83NXZ3SG9Yc2x0SGN6WDRkQkZNUFl5?=
 =?utf-8?B?ZUwrU2xGKzl5c2p5cjFDTlZ4WDBDNzZ3QzVzV0swL01jQko3T01ObjZWazFW?=
 =?utf-8?B?VkxVU3oyWWpGbUhpa25nOFVKZzFkYTc5azVEN2orNUJURytUUGhuTm5Sb0RV?=
 =?utf-8?B?aERNaUk0WWxrbmVlTEZ2azRGL2J4RDZOK3J0aUNCQkFHbGFQOW1acnpvT2xp?=
 =?utf-8?B?dFlLa0k4K012Q2ZzLzdHSy81bWdvK2RvZVlhR1E3b0xwQWpDQU15UC9aY0c3?=
 =?utf-8?B?bWZRWVhlTGtHNktoSlJWdmhnZFcyWnpkRDlnai95bGlTb0FVVVZZa2Y1c3A2?=
 =?utf-8?B?MHFGM01aRVhrYjlISVo5cDd0MjFFc3FOSUxOQzF0S2lkaWVreXNaWE56VUVB?=
 =?utf-8?B?enpRSi8zNU5XYzZOd2M2V3FNcGlxS0R1bVE0cDBLbUJGa1RWczhFTDNPN0Jv?=
 =?utf-8?B?cERsdz09?=
X-Microsoft-Antispam-Message-Info: pvSBKO0anPbQr8ciwM07TTgalCMkQAqtQO9IQ7lpQPHeaamhOf4Kbvg0njoWY6lINK9p2HBeFULOe4uRPUVTzZJOCKhRD0NmUpg0mFez+cAl4by31DZbQCblT2k6/+KIa3fckEWDDFM+RlGr/c6+M+8ZSwfubzh4Wk6ayzxNSH6clpgB0Z1dxXTIJ9jfyUFM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:JW3qoxeN/s4Q6amjP530OZ5rlHLdIen+DVsa6cPgbh5Op88V070WoaJy6kUQwiImtyKWM7/RgI8MaoydFYm+3zhgsg2ae7e2EuwYxM4FlXnyRWPtFHzDr9kGqq9sB8yy2wPxkLjVVy1m1KCYvL7vKR9ducQgdWeQ3Ow76J+CDF4hsXBaEjQwuUR5V6qhgrMQQo4/6Xm46C4daC1MI0xWxLCEk8u9qMGUCMllt3tiNzkI3Y6I1c1xym8GssYQQYkPVHst/zWSYKb57DukAlyzt0DKdqKNoxGgZyC/TcH/3HQbWdzOIqBkcnABW9AzZwz2QzI8RWoRZ2Fb6VKxF4Gq02o4vJ932bj61QYHMJ25ZuaMCudFRWH/N52tUQRA0LSptDlKRjmPnx9zqhE2s5913WFrn5mLQf7E1xqvKM9oEy+LsWTBdastGDSghex9eX2nMaajNjWl9HDafrcD8LIwTA==;5:CmCQ2A4axgQoQjW0q1BMGPa2+uOog8LLKFKz61liTOuTqLirIDYdRq5+Ik1fEnHztEFfUWxyJGVcqGwbhst8MRqR34KxQ0vcd+1nm1i11sE1+NdJlqFecpZdSE9oQ2KEj7a8VqulZDMwt8EZ0mZEqn6AhxgQPBkvVsAjzi3d1OU=;24:6PIPWZjsS/DfwY2Rh/Ujnlx60z+mTzEERIA4pevOKxAy/VtYbwYAWgle4lDyle/dKwUsIfhvFSN4B2PO+HregTvaazurxQXdWAiFH/6uRew=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:bjk1I0IVXJIkswbYrKapWQNXdagSH78Sn2/hbAkNw59DirlQlL4o1L7RBqwvg8tFwxH3Lv1Du9ZpspkLK8SbnripPYb8aZCh5KwtYCZQi1TnmpSo7fFqKH6/lDgWJ/qvp6xKdY38eRvDZYMZn1sJC9FoXE83WpBQnFXuOmoLGY5gNPMhVEtDzFpfv+JkQh8GFBUfwVkrRmYyKj/SF7NF5YXnoMci67+F7NIJPZdRRy4FPofBeq1SGGlZQaxgOkZn;20:BmcsxR2/1g0QZX5CVaIQ9RpMa6dUrcbI/gpC0YS0PAlw1YQc90j5cB8wAIEtGBd5Uy22Ukdhgxjr/noOCK0a6vrTv+w3umwV1KTi6wF9wNuqyZRhAHJxnBbBmYsmVS2GGOmBkReA0z9ADQPUukqZNgKNdocWQUoe76y3GzOIAAc=
X-MS-Office365-Filtering-Correlation-Id: 9733ffd7-2ab4-4b6f-6cf5-08d5a134a239
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2018 11:49:36.2805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9733ffd7-2ab4-4b6f-6cf5-08d5a134a239
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.2018 14:38, Michal Hocko wrote:
> On Fri 13-04-18 14:29:11, Kirill Tkhai wrote:
>> On 13.04.2018 14:20, Michal Hocko wrote:
>>> On Fri 13-04-18 14:06:40, Kirill Tkhai wrote:
>>>> On 13.04.2018 14:02, Michal Hocko wrote:
>>>>> On Fri 13-04-18 12:35:22, Kirill Tkhai wrote:
>>>>>> On 13.04.2018 11:55, Michal Hocko wrote:
>>>>>>> On Thu 12-04-18 17:52:04, Kirill Tkhai wrote:
>>>>>>> [...]
>>>>>>>> @@ -4471,6 +4477,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>>>>>>>>  
>>>>>>>>  	return &memcg->css;
>>>>>>>>  fail:
>>>>>>>> +	mem_cgroup_id_remove(memcg);
>>>>>>>>  	mem_cgroup_free(memcg);
>>>>>>>>  	return ERR_PTR(-ENOMEM);
>>>>>>>>  }
>>>>>>>
>>>>>>> The only path which jumps to fail: here (in the current mmotm tree) is 
>>>>>>> 	error = memcg_online_kmem(memcg);
>>>>>>> 	if (error)
>>>>>>> 		goto fail;
>>>>>>>
>>>>>>> AFAICS and the only failure path in memcg_online_kmem
>>>>>>> 	memcg_id = memcg_alloc_cache_id();
>>>>>>> 	if (memcg_id < 0)
>>>>>>> 		return memcg_id;
>>>>>>>
>>>>>>> I am not entirely clear on memcg_alloc_cache_id but it seems we do clean
>>>>>>> up properly. Or am I missing something?
>>>>>>
>>>>>> memcg_alloc_cache_id() may allocate a lot of memory, in case of the system reached
>>>>>> memcg_nr_cache_ids cgroups. In this case it iterates over all LRU lists, and double
>>>>>> size of every of them. In case of memory pressure it can fail. If this occurs,
>>>>>> mem_cgroup::id is not unhashed from IDR and we leak this id.
>>>>>
>>>>> OK, my bad I was looking at the bad code path. So you want to clean up
>>>>> after mem_cgroup_alloc not memcg_online_kmem. Now it makes much more
>>>>> sense. Sorry for the confusion on my end.
>>>>>
>>>>> Anyway, shouldn't we do the thing in mem_cgroup_free() to be symmetric
>>>>> to mem_cgroup_alloc?
>>>>
>>>> We can't, since it's called from mem_cgroup_css_free(), which doesn't have a deal
>>>> with idr freeing. All the asymmetry, we see, is because of the trick to unhash ID
>>>> earlier, then from mem_cgroup_css_free().
>>>
>>> Are you sure. It's been some time since I've looked at the quite complex
>>> cgroup tear down code but from what I remember, css_free is called on
>>> the css release (aka when the reference count drops to zero). mem_cgroup_id_put_many
>>> seems to unpin the css reference so we should have idr_remove by the
>>> time when css_free is called. Or am I still wrong and should go over the
>>> brain hurting cgroup removal code again?
>>
>> mem_cgroup_id_put_many() unpins css, but this may be not the last reference to the css.
>> Thus, we release ID earlier, then all references to css are freed.
> 
> Right and so what. If we have released the idr then we are not going to
> do that again in css_free. That is why we have that memcg->id.id > 0
> check before idr_remove and memcg->id.id = 0 for the last memcg ref.
> count. So again, why cannot we do the clean up in mem_cgroup_free and
> have a less confusing code? Or am I just not getting your point and
> being dense here?

We can, but mem_cgroup_free() called from mem_cgroup_css_alloc() is unlikely case.
The likely case is mem_cgroup_free() is called from mem_cgroup_css_free(), where
this idr manipulations will be a noop. Noop in likely case looks more confusing
for me.

Less confusing will be to move

        memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
                                 1, MEM_CGROUP_ID_MAX,
                                 GFP_KERNEL);

into mem_cgroup_css_alloc(). How are you think about this?

Kirill

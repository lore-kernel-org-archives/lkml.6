Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeDFLn0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 07:43:26 -0400
Received: from mail-ve1eur01on0133.outbound.protection.outlook.com ([104.47.1.133]:37808
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752370AbeDFLnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 07:43:24 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH v2 4/4] mm/vmscan: Don't mess with pgdat->flags in memcg
 reclaim.
To: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Cgroups <cgroups@vger.kernel.org>
References: <20180323152029.11084-1-aryabinin@virtuozzo.com>
 <20180323152029.11084-5-aryabinin@virtuozzo.com>
 <CALvZod7P7cE38fDrWd=0caA2J6ZOmSzEuLGQH9VSaagCbo5O+A@mail.gmail.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <72db1bfb-aa79-3764-54fd-2c7ddbd07bea@virtuozzo.com>
Date: Fri, 6 Apr 2018 14:44:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CALvZod7P7cE38fDrWd=0caA2J6ZOmSzEuLGQH9VSaagCbo5O+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P190CA0036.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::25)
 To AM0PR08MB3249.eurprd08.prod.outlook.com (2603:10a6:208:5e::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b29b041-4898-4b4d-7110-08d59bb39872
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3249;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;3:69YWI7cBANNFzHMoj8g4ym9rYp699GWnVfv382DwuFqQkvmfSGvMWnedJEJdHu3sCV7I5GRjf2C53+idQVmqDlf21ixcA1a9gMll5TMVSDYjVvEdywq9Ejk+yg2m7R6Ms1crJPLb4G+oEWZk+BeS5/kJBoQqFlHm2HSxGcLSJbJ3SGapQrv1BhlCf/UCN8DL0vgqGqNR8Xd7MbpxBlPF6rRX/ryhax8pISnoB1S9MlCp7Fzg91cOWifbrPWb9RdQ;25:ctB0IyfNr7qnJu4FPD+YPBj5ns1ilXaQYl/0xqpXTbZ1JP8bavvhzcAAtqUgS6rH6sghMgV8OmKT2SCibi+jVyReYSyEm4NjmFa0letBdG9XesxdMxYG0PPsTib91++Fpl3FNaWT6mWWzzymOyYHAjlm807qkRG8/l/dBck6YGc5I64S4pZDjIvKbIEkkiXGTf58tzCvB49M+n9fK+EbxDM8pvveQB/XbZYhVTK1VOasqYXUog7JpZeh4R/IFVQ+a87dBh9yczkkuxEDWhFLPkcPQ4lJ7dDShe5aknRcQLr1ZlBAhfiRCpQfB58+cnQ8sB4i6wF3wExPNvkxEDP0ng==;31:el/ZI8Xhv/30Ho2vPLh982dHqcwmqxzECMWWw9gP8Q+8/P2P4vnJ4wQFiiPj9Rf+1nDAys214DEqME0UaXKYfi5lk/HbG21fnUO+fr56qDfSqzxJR0KxIwYGeiJYa+D246WgmWssOMxROW6Y37ni85ZGFaPxC82BJRvZi1x2qahsXVWPo26o3zA364uphxdXR1jMIN+ruVRrTTm340doUR2iBJ4aug93Za9WuuMkfug=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3249:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;20:m/MhcyNbLqd56PdUbZRzNhhwRwoPA/dKMxaUwxJryjwCCJqOrXKVggNb2bwkf8JFVr7WAQgxayYoBI3fJ7HWHbmQdKjxHOL4DhOLrMBl6NHnjcZGrngPrm7ZaHFH8kgZ3PMZwgpR57VJa+brtI7+A4OnSeCgxZPGLDbPWfhifVCIb0+zr54bRr+3hokW33wBCkkXRDv9AEiXWnS1DGnWHrUpuLibj9bI8hunH8OsuprSeqMuPIpR1aZ3maYhubrOYpznbib0XVh7aM7bZkz9sk6QxeHoRE/GuozEX2RzWFpNKoixkrqoNnuoRH7d7Or1wcSrmPIqNxlESNunswDnz4gQXhBmVTYMStcw3s+nYQkHxepScVoLBooKnVPuV11MVn3Sz4+smagvdMtrFGfjo0TxQm94LLCJf9RzDJZ55bZk0bu+DWjLsvlf03qHqxIJ5VuZC+zWxpG6RFssQetqoOIH/5cwz4K1VYwm/eOMSMgcAnkyILBK0X027yXGmGAc;4:QK4f50uwak0qVyv3Tp+uqY0ItXY/e2Pu/GO2RCI/queyWiHPhpTZbp4Pip+DBjNi48BPOy6LFvztxyR/D6Ut2DXSIZ+JTR44AXc+O1Rlu7Xt1Ip6ws8sqpV6c916DXTbgshqWAull5p/IxYEMRKG2uPEyrOEEwd+INIiQZ4t8f+L0y80/AqZTgTk4jEeeSHSCAmckfneYFj6g4/Ar8SgZGZT6xBr3hV4Fz64j00aEoMl9W3BD6eduG60qHuX3CGtkVnjH/ZpFu74vvkK4Ulan0km4AVOKJ6NrP2l1OCUm09xTsJC1FJ6fgTftZmB5OnT
X-Microsoft-Antispam-PRVS: <AM0PR08MB32494F83DCD33C684BC11D2EB0BA0@AM0PR08MB3249.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:AM0PR08MB3249;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3249;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(39380400002)(346002)(396003)(376002)(366004)(199004)(189003)(2486003)(52146003)(23676004)(105586002)(53546011)(64126003)(97736004)(65826007)(6486002)(76176011)(52116002)(55236004)(68736007)(386003)(50466002)(106356001)(65806001)(65956001)(47776003)(66066001)(6246003)(7736002)(31686004)(305945005)(5660300001)(36756003)(7416002)(6916009)(6666003)(53936002)(229853002)(478600001)(476003)(230700001)(26005)(2616005)(3846002)(6116002)(25786009)(4326008)(77096007)(186003)(446003)(11346002)(956004)(2906002)(31696002)(81156014)(58126008)(54906003)(16576012)(486006)(16526019)(316002)(8676002)(81166006)(86362001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3249;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMjQ5OzIzOnVCVVVVQkFyVnZzaFQ1Vmc0a29iRGZ6Y3lN?=
 =?utf-8?B?QXgvQldQUkR2Mk5NVWxsNlBiRTd3UUJjcy92WlJyeVcxWjNvRGtaWUNGRGVp?=
 =?utf-8?B?dkluZEh1OVU4TXlBcnAyd0dSZTJJUVVQdmEzdU9Qa3lITTl6ekU3dkkvK0Fs?=
 =?utf-8?B?T2FzbU8wbG4rbUYxZmNvRlZKMTR6dXVMTTJ2U0VvaWtUQURYbklKZGJrSFp2?=
 =?utf-8?B?MkhFd2xGUG1kbHBxOFJVUE5GRVlpNTVXaGx6elhtYVBlL3Z2Z2xNZG11dG54?=
 =?utf-8?B?NHdVYjhXYW9RRStTWmRpNjF1ZklnTDJoMCtBOHl1Qm4yY2JOc243S3dFWGp5?=
 =?utf-8?B?WGRZL3hOZDFBaTQ4ZTJRcEVRTjdsT0ZqaDZCVW1YZFAzQ0hQZnFGbmNtUUV1?=
 =?utf-8?B?N0RvR3RnZm9HRm0vSWo2b3BZUHNFcjFMVm80YVBvUVlHTEEvbzJYL3AzKzFu?=
 =?utf-8?B?UXcyTk1Wc0VZVVUxU05ta0o5ajBqOGhqazlUZi9oOHNZRXZDRFAzNVpvVFFn?=
 =?utf-8?B?QWFPZm9PZFlTL2w0ZXA4Uml6OS9DU2JRNUhCSWE0NkZ0V1VPMGJaVGZHSWxJ?=
 =?utf-8?B?cmpPanhLek1ZUnZXdEhVZStkbDNkWVhvT25adUhsTXU5UEJaNGZvYzJZZjgx?=
 =?utf-8?B?ZU4xUHhsMWtmQmV5OWVtWlZlb1VUd1VMSnliMWJ1eGNXRU9uTHFxMXgraGN6?=
 =?utf-8?B?dGNtV2htQkN6aGRTVk55U2ZyeWpYekNrZDVYQmxIV2ZwZVFINm9PaThzT01l?=
 =?utf-8?B?UUEwOWNmTGYzL0MwVDRmUGhEK2ZSQURPWVZ0akljSHlyOThwN1h3azNNNUpQ?=
 =?utf-8?B?d25xYmlpRnh3d24vRVpWSjNVYXFwTDI4c0orNDlocExyRStIeUwzYU9rMEdm?=
 =?utf-8?B?clZGVGtyUEtBZEx6dUFza3lWTnorUWtlK2x5UE1oSE1pNGJGUkIrelhYWDdO?=
 =?utf-8?B?MDlud04vYXBaOXIvWHZ5NmF0UUxrUVUrTjB0RTFoTlA5MnZLWFFsSTRsOGc3?=
 =?utf-8?B?eEkrZHdUNy9POHB3Uk9sOWxVV1FDSTVFMUo0STRTU0xCSWFISXFTRkpRcGs1?=
 =?utf-8?B?cjdHaHNONnpvYlpYZGZic2xTWjNpMUFZZjM4dWFQektyZjhncmFHTmQ2c0Nx?=
 =?utf-8?B?bnlCZmk0Zkw2Y1JzeEFxT2k5UW5hb0QyVUIwa0VkUlVGazlGRFgyRS9sU0J0?=
 =?utf-8?B?cGNnSlo5cEprb01MSEVvRnVhVzFUZ3l3bktDWTRURHpEU1Evd3lqYzlmSkt0?=
 =?utf-8?B?Mm9vUEI3Sm1tcUVEQmVoZFV5ZUI0cXZJMW9rM0kzNDdrbnh2MlBGNWZYTE1D?=
 =?utf-8?B?aUxhNU1aL1doekxpOTY4TDhxMkw0cllDV3U2aVppUWl4Wm4xRTB0UG85TFNP?=
 =?utf-8?B?M2YrK0JoNStDNEJoODJYZVNDS2kzRUhNMC9nUXVEako5MFh6Kyt2SGI1b3lB?=
 =?utf-8?B?UlBZclBjSDhkaGxOeDNyVDlIblMzaUtzdU1GYlZqZjZjMUl3Ni9EMDM2V1gr?=
 =?utf-8?B?VEdDVkZla0FSVWFjMnFlQWdYTFdWWFg2OGR1bWw0dHorMXB0KzJ4YVBkN2Nw?=
 =?utf-8?B?S3lkZW1LZHo1ZGxONHZtWFhYdjh5eGlUbm8yYkZIZ3k0bWFyd0ZLemVYTEpY?=
 =?utf-8?B?MGhRL0MyMHp4czlYajl0Z3BxWEpFRTFpNDQyY2ozNWx3SkxtZk5heEN4amVV?=
 =?utf-8?B?OUFMYk92SWNTRjRIYjRxRDQ1WXMyMGhGMFNQOUxMYjloSHp0R3NZVUJrclh1?=
 =?utf-8?B?cGdhVzRQdWptT2J2VEtDR2RQc2hDSFdFLzNIWjk3amxVVDhnNG1aVmFQZ3Vm?=
 =?utf-8?B?U05YQitubTBVYUJOdDAvVUprWVhrbG0zM2xxdTF5ZENQV05wK2RFbXc4K2I4?=
 =?utf-8?B?YlpKejNMY1JuMVFuUUlpK2tMbkxWVjJlQUVwUXZEQ0VWWmY3S015c244cDc5?=
 =?utf-8?B?NlJqNzdjWjF3eldrZGRvUVlXZUZORHBna3F0QllkSjRlYS9KeEdTeE5yaFFj?=
 =?utf-8?Q?t1cI5I?=
X-Microsoft-Antispam-Message-Info: wjUtSuen0DJE2GL6btDwR4pX/6ZJQU6Tn5qKeoIFSJdiYr1kLjJMiSHjIsPTCk3w5cpt9aHuzySI3sG9iBP2y80JNU36zpDT6WvxRrzqTQk3L5AXTywCRyuXGRJXvM46XdTMiAAldM5Noa19TCHliedzFau94lJzb/bYmMTWQe48RcF2rUpvBx8xoQnuoXLx
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;6:kmnKYu3tilPW9bYjSK6xCqGtF2PYD19mBjn6DyLusVNtAU/DAT0iqbYDWjkKb6zP0ApE+5VmJohJsqyiO2H4LP3Gpm67CGAgyQSzzTHeJauRgZrsizq7e4xdiow6xMi8yChNiYB3QYIghTKZQ0q0UV1+wFhIjR70tMQKKJZ840rv6TARtRUkiAgy59efxsmoiS+iUVWZAfa2ePvpSUZ/iP+9iODSEGRUEB0KfNXVuZQ2FbakdbM9YbOVyp13yt1yIOLLz/ckj8Oe/5w5SCVC4uJ+K+kZso5pjUojORkaLLU8CwRhQLuTOcwWtX2LXT+s/cNEl/PLVviOs6g2SxerFKbhu/foxmBcXkJIZULRtdAcHSobKbt/nQEP2v5NbbpuHboWsPLsYZFRMLCANF58ZFiTwedie/KRbMelVdo+FjZZk01aH6vLtw9r/Yn2uYN1FKaDKc21JWw73gUDtgBAYQ==;5:K63AFl4pqtWSpE2wZYOUq5DrjAhmva2naLc3m42StfXdgmBZyxbtKeNw4mFmzosYuZO9oZzb1TAJ14TKYwW27vFbxoaByxGnQtQOT66vwOaHiyyCq3fwy5lucoGcVgjhFruOwVVQTLfQjqc7TJNnLbDVdlQUsxpnZEHjhyv5LSA=;24:laqxEHEmcQr7zXiPelDDeSEY7zbCosZl76nGLgvcFN/GRUWPyR8krMS1J4Dj+i2FV6sIFxjXCw5+uotXyl5VMG6SEH1BFFJbbvWMoEf/jS4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;7:ZA2Y4HUr5tY1ZhsrrsUjUF1jnvPBMuSgzVwR2ITVQmpeum2HandwU5GBg51C7lP8DnHaBCVmG15rvY0sAv90wgWMVPbfg03MmD9ziggaByW+wEpKJ8QXLEu5htqgG7upr7/BCHp5OWNufgYLGyL3A6Xb0ISw24AEHMg/fwNcDJZC5S4nFVi6hib/DW3GpH+Vyj9KAzfxBD1462jeoDgpR4Q4Zs0wSHkjRPaqlo9kuj44xXcoi/EV1wtIcXqtVI/e;20:sd9v39vhjfeStzFVEYbDUNurnpVJTS42mkTsSMkb34mbM5qB9GPCJVSnt1qK/9hxYrA6N7QcvX4E3pHC2k8mxVg5XyaPP/DKlQmapEC/0uXJWZ7fWl++Mmmn6YAnyohuUnUu3/4w61h0tSJk6XKQQbPLOZCVyqEZco1ZfKwv+ck=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 11:43:19.4716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b29b041-4898-4b4d-7110-08d59bb39872
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3249
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2018 05:13 AM, Shakeel Butt wrote:
> On Fri, Mar 23, 2018 at 8:20 AM, Andrey Ryabinin
> <aryabinin@virtuozzo.com> wrote:
>> memcg reclaim may alter pgdat->flags based on the state of LRU lists
>> in cgroup and its children. PGDAT_WRITEBACK may force kswapd to sleep
>> congested_wait(), PGDAT_DIRTY may force kswapd to writeback filesystem
>> pages. But the worst here is PGDAT_CONGESTED, since it may force all
>> direct reclaims to stall in wait_iff_congested(). Note that only kswapd
>> have powers to clear any of these bits. This might just never happen if
>> cgroup limits configured that way. So all direct reclaims will stall
>> as long as we have some congested bdi in the system.
>>
>> Leave all pgdat->flags manipulations to kswapd. kswapd scans the whole
>> pgdat, only kswapd can clear pgdat->flags once node is balance, thus
>> it's reasonable to leave all decisions about node state to kswapd.
> 
> What about global reclaimers? Is the assumption that when global
> reclaimers hit such condition, kswapd will be running and correctly
> set PGDAT_CONGESTED?
> 

The reason I moved this under if(current_is_kswapd()) is because only kswapd
can clear these flags. I'm less worried about the case when PGDAT_CONGESTED falsely
not set, and more worried about the case when it falsely set. If direct reclaimer sets
PGDAT_CONGESTED, do we have guarantee that, after congestion problem is sorted, kswapd 
ill be woken up and clear the flag? It seems like there is no such guarantee.
E.g. direct reclaimers may eventually balance pgdat and kswapd simply won't wake up
(see wakeup_kswapd()).



>>  static inline bool bdi_cap_synchronous_io(struct backing_dev_info *bdi)
>>  {
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 4525b4404a9e..44422e1d3def 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -190,6 +190,8 @@ struct mem_cgroup {
>>         /* vmpressure notifications */
>>         struct vmpressure vmpressure;
>>
>> +       unsigned long flags;
>> +
> 
> nit(you can ignore it): The name 'flags' is too general IMO. Something
> more specific would be helpful.
> 
> Question: Does this 'flags' has any hierarchical meaning? Does
> congested parent means all descendents are congested?

It's the same as with pgdat->flags. Cgroup (or pgdat) is congested if at least one cgroup
in the hierarchy (in pgdat) is congested and the rest are all either also congested or don't have
any file pages to reclaim (nr_file_taken == 0).

> Question: Should this 'flags' be per-node? Is it ok for a congested
> memcg to call wait_iff_congested for all nodes?
> 

Yes, it should be per-node. I'll try to replace ->flags with 'bool congested'
in struct mem_cgroup_per_node.

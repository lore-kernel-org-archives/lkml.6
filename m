Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbeCURA7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 13:00:59 -0400
Received: from mail-he1eur01on0136.outbound.protection.outlook.com ([104.47.0.136]:19215
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752417AbeCURAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 13:00:51 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH 6/6] mm/vmscan: Don't mess with pgdat->flags in memcg
 reclaim.
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20180315164553.17856-1-aryabinin@virtuozzo.com>
 <20180315164553.17856-6-aryabinin@virtuozzo.com>
 <20180320152903.GA23100@dhcp22.suse.cz>
 <c3405049-222d-a045-4ce5-8e51817d89b6@virtuozzo.com>
 <20180321114301.GH23100@dhcp22.suse.cz>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <d29cdc69-718c-7c7e-bffb-d716d343a154@virtuozzo.com>
Date: Wed, 21 Mar 2018 20:01:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321114301.GH23100@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0145.eurprd05.prod.outlook.com
 (2603:10a6:7:28::32) To AM6PR08MB3253.eurprd08.prod.outlook.com
 (2603:10a6:209:47::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcb3fb8c-f5c7-4c58-9a78-08d58f4d4ad6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3253;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;3:iZMcNPtXQlIiSsDh0xyZ54qX6somk7kRYT+fOeiNJvFQ22QYV9Obb5EU6RoUv9eCRPSHKnCrAF3q5THMTsupRuEOTS6SYeSroZ+XOe2YYCDxRYENmxoBt7dtTPl3Sh0xIWJddoMYcN59iuQkUuVmJ5+qjhY27z3BzvOJ7f2H4YHp3TU66Av0jLW4NKjAvJzcqWTtDertkEC24bNIE4XTORr9x45XK/9SbpUIUHl7RXwUwTOJaMG0vdRthan6VB1I;25:ZTeFtQ3K5SozQWYSrh9/eV53YiWDD4GaSjo8ip1RXl3PVEA9ab8y9mehURbAyyv7etBOf35hH0EQmQMuPHnGk6cIoM3bqaRRGHI27SnqLp7ULl9mF8CRdT7p9Sc00tkUhb8mc05gkuMes8Mbqnz0Fth+XoHR3DFHx3IG6nafupqpMbaL4+8tIf4gMsiMYRr4eeRxDFP2jYtyxo8pc1Pl5dGM22/+VXjhaSOS+gUU54lGM0Nz8GFJCTfDm8GaA/anNnlxP/mNaKaZo+2wFo85h0wYEA5thtf0X4XRjoCjl6Ktnyc8I1BdCvEzoaGsgqSYQDL/davOxIzo1xSRPTEDgw==;31:XBsgJU4yuPtJRhX1LNCsoZImLHRMnC4RBLIU9y9sdsSsQ3ZuUVYXMnH44KPtPo+EJhbje8dqvRWw6Z65z8yEuJsgQK2TEqtEdfSSMvrORAbN5mZB4n8iXs3KU4gB6hd2OQXzoVYRg4cq35pb0Yv3xaoAtOU8wEwMSVspsmv83xHGSOZ3fqkFpzdAtrZVW+D42QHAPn9kSrNewHEk0gqGLVruKWWCoRxAwh8hVM62N2A=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3253:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;20:WOdNaQBvlM49g174GFAaV8GVwOdUOxcukfHDJOZij9kH0vwAdS3TJOISfOcp+XDmBuh75njOHK5hHo17Hub62JYRzFX6sWt+u3GJZ5am1DS7uyGnca0BLtOHg8+mJcf4EBNvxoLtEtCH9UELQF+5dKlABGCRJwQDPgAR3l/oq5Olnl07aPhBkhNtX9xkH96wCFE9KYmLVHvWtwBHn1bzH7D+FHtQnDI0Kuizpw41Z4dwGBV7A8Tk0WkF/DLCMZ1kDgHcBNMYJNa/uI2V6Kfq/HDQUReJ6X2WxPwXmuNejB5lDLhucdYoOzuUPwIWWYjfiB5wpL7KBLu6DX1vs7fIE+v1oeXNrAIhOummG1anPgNBOZcZ5YjqZiHD7tmVBLXUNJL/P98nOn9T3Ii+xqZz8uU/uLNh5UmigIZFt0s+7L9V2xE6f1ExfvFNtobM8eRpM1RjbJKvRlIRQngBkJPfEvcuB3zfJxQGvRjuYOr0mLJ9SGWNGuQ7btkO/y3TS9Wb;4:SP4l80xd8KrzvCzRZ2rt59IIftZiCDUKbGHXUOOz3Q+MDU9vXBVU54B+nvutLTb61lwWGn/M7wzqKmecwpYf0xK6p6jtwG9pUphrWPBgcuv6Y+umuIFPFiYAzFyPtbwZxK9HRS8a7Ss6nmBqvT74UGHD/oMOvVoeVRs8tS9VRB2lXz6KXYMJdkj/pDOru0/00NCfhDcuux81KH762cPiYyzOFM3lvSmk19t1LInJv2KtljQOIOvJ4QCe2GZusmUnkeDucyj1toNCOy+b8f5WoA==
X-Microsoft-Antispam-PRVS: <AM6PR08MB3253EF531D40E440FD02082CB0AA0@AM6PR08MB3253.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501325)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM6PR08MB3253;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3253;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39850400004)(376002)(366004)(396003)(39380400002)(199004)(189003)(377424004)(6116002)(25786009)(81166006)(316002)(305945005)(2906002)(8676002)(81156014)(36756003)(386003)(5660300001)(106356001)(65826007)(2950100002)(58126008)(52146003)(52116002)(23676004)(186003)(26005)(16526019)(76176011)(77096007)(93886005)(55236004)(53546011)(16576012)(54906003)(229853002)(6666003)(8936002)(7736002)(6916009)(2486003)(68736007)(105586002)(65806001)(50466002)(97736004)(47776003)(31696002)(31686004)(3846002)(86362001)(230700001)(66066001)(6246003)(6486002)(478600001)(65956001)(53936002)(4326008)(64126003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3253;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjUzOzIzOnhFaE5Bc1Z2OCs2SDM1aWJvZTV3aUlxMGhq?=
 =?utf-8?B?R2ZnaWZIR1kzWGcweEZsbXpCdm8rR1pGejVETmdZNGNnTENid3FwRVhHSUd6?=
 =?utf-8?B?MThrN0g5VkNmUU42N0JSSG1zN01sVU1XakQyWnE1enM5Sjk5M3FUUW0yMHNh?=
 =?utf-8?B?UDI2UzRGSEY3VGVKN29Qa2FHcnB6N2ZxQUZLeFBGS3hVNmx1RElUek15ckVH?=
 =?utf-8?B?cUJvYnFFODVWcTJVNC9mbkxSbjJaL0NHdkh4enhhcUFhNXBEVXM4YmFBTEFv?=
 =?utf-8?B?MlFRWnJZZ3gvbldpeFJ6d2NUekhGSlJwVFNNeVR5SEpLdWN0aTh6RVFKbmRr?=
 =?utf-8?B?ZUd3elNLY2FOQTh5Z0dBQW5vZUVrVzlkc0hWQ3VwT21WSFpWUE9nRHRlVW5E?=
 =?utf-8?B?aFl0N1pKSWJRQW4xc2tYQksrV20yYVovQk82QjZMVFNMUE5FVDIrV2p2dFht?=
 =?utf-8?B?aXVnZ2NwUXpJMlMzUjdVOHhsUWV4NUUwRnB6NWFwVEhsOHdHcjBQSWhaZ0VT?=
 =?utf-8?B?cFFFVlRpNm9qYmk0c0p3cDdoQ2k0RzU5MHpMcnpBYzhWUmtqQXRpK1JjQmFy?=
 =?utf-8?B?N3ZkaktSa1QwSGJHZ2I0MGhKN1U4TDdtWVkxTmtibDBjZlgrbk94VFJDc2lW?=
 =?utf-8?B?TUthdFFER3IzQXlXd1V2QXErblhDS0tIWUpnNXk1cTBGdEFXSE43eHRVeTB6?=
 =?utf-8?B?RENHOVNnOGdDZVB2RWE0UU9UM2p1VDUxMitjWGxZZHk1NmRTZVFtaENocFE3?=
 =?utf-8?B?clVNZEg2cFFtdHd6QVgxV2U4UExCTy9FN1prNmNSdG9md1pxSGFqMFE0ZFJX?=
 =?utf-8?B?Rk9aZXErcnZIWkxXR0JkOWRqTkQ1RDJnV0Q1QU9YSVB4Y3BzcS84OEZEZHhU?=
 =?utf-8?B?WjhNWWNyNUtnNkloNXM4VFZvNTBLN0g3c1BQTWlqaTd1QnIzMnh2UzFCczkz?=
 =?utf-8?B?S3FxZlZDeTk1UHJhN2FXVUFxcTBjMVBKKzR3dldoODkvVlhBN1RIRjRuenFw?=
 =?utf-8?B?TmF6dTZIWmdBYzRiMTgzSTFyMGo3d1ZmdEhMbzVOajZOV1FjUnVNY2g3cjRP?=
 =?utf-8?B?TjErbmNnUVpjMGRHMThoTk1BdUpFRWthdGNYV0NDMTFQRjZKT1o5bktqYUt3?=
 =?utf-8?B?RUt5V0xZNEFranhyRnhWZ3hneWp5RVR4bE9sVkRtc0pRMHcrN3VLQTNNR2d4?=
 =?utf-8?B?cXNmOWRLMXlxVG50TjlvZ0VDaWhTQVNMM3cyckZBckx1MEZPYmlHSyt4ek1j?=
 =?utf-8?B?ay9NQXdmSFdqblV5Ty9iTXQ0bFluZ2RPOXo3WEVZQm9LOUFndkswajhxS1lS?=
 =?utf-8?B?NG1tSnFXY3BVeFFQMFZJUDNocUpyWXh3RTR6TXBuRld0R3RSYmppRElVTEtF?=
 =?utf-8?B?SzVaSlQyWk5vQkZCSWlRK0lVVXhZdXdyaUwzTG4za1ZaYTdRSy9aS2xKNk1Y?=
 =?utf-8?B?Sk1YLzN2YnZuSGFQQUxjYnJNSHdRaGFrQWw2UnMzVlFma0Z6Y1JGaTYwVDRU?=
 =?utf-8?B?aU42aFZ2ckV4aU42c1lia2NGK3pGc1JHZlBOeXIzYWh6bDRYVFk0ZjhRU1FI?=
 =?utf-8?B?K2c0MXRaalRGbzltL2xYMjNzSUp4ZTVPajJaL0JJaTNsWEZ5YmRCeHB4WjQy?=
 =?utf-8?B?U1ByRkRoekt0Ti8vNXRISjlZRFdrSFNuYWlTUDVNQ2wxcSs5Tko4QldjY25u?=
 =?utf-8?B?elpSL2k4ZjlYemVFcTV0QllCbUs3UDBUTVZGNW1zOHgrVGtLYWVzRzcybGhN?=
 =?utf-8?B?M0NLK3N4ZGtXZE9MQUdFK21WUG5maUl6WTJpNWpGelVIa3I5Y0thbjFPY2hP?=
 =?utf-8?B?cmZESHo0eHRqRU5xVjhXVUFCQnl2SWxaazVtV0EzYXMzNnlkblFRZG5LWWFj?=
 =?utf-8?B?b1BlRHZKc1hSTG5qNnQrRUw0c2g1UFc5WlFEelZDQWQ0UmJwQjJPcFRVaHhJ?=
 =?utf-8?B?WnZmaWE4QWtnPT0=?=
X-Microsoft-Antispam-Message-Info: rTqg0S06p4Dzbg+hNVJZTYFPb6ciSQjGpbaTmbGE/Lc42QLjHuefgDPVQuRlDJ9EBpqm0HWuF26KokdUo+UVL7QUxTfPdDAKp7SFjqeWn4HGLrpmHGH7cfRzOCFN4QRfx3F43VDSjaS+ucKUQ6ABd3egwWwudQSpBye4fLDKIzrwoh/GMOvQSJ566Cf+adoK
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;6:xgPZFoUM5YsFyCMll4xy22kxqwqS2n+Zp+YEyTzt2447fecbOnOvaMHsqL4Z+kz4Tz+NLOsAg30FnZ5JJzWEXLQ2StA5upXCcMBSoppihsIcJplCj1Y6zLWhS3UQyiM7zF6Oo2R+Wc7JrqYTT9Ws3qhsj4cn4AVFi3car9u8C2gSbWiBD4VTG4gof2XDkbnhjk1yvrC/BJVJNgrN5u1rssbDImPOgL+uoHm9mpz2PLZ7Eh5G5i6ndjFOjto9sTUOCmNu/1CVAyFiR46cDD22EqpTVml1fqAMRFHmFy6xAHSw3vPRcSsVXXeccfPDMAKIjVrjNRYDg6yyaORkJ5o19nqforB6YrvMDbG87yWufqw=;5:4gUIqUcqYQc8//ciNGYxugG5Mrv9MvYuwF9kT8NprDbyKrYdv02hJ085v5XXWrLTahjuL1JHs6v2JfthFXpwsIQVXa6eguv4dx34MCLJoD8Jtb8FH37sL2M8E7R7UlcnY1M3fzFfBWxAYL8p4pC+aiEtofArrt6WZ1GZ0TOVPrQ=;24:jV5x2tTsGd9zp+OgkbJRxZm50ShRjPERGwAqwN11ijw0I1XjlRJzpz/dvgID90S64/pwM0Hnb9YKAERwV3KEJAnM/vem5fKPIha9Km4YauQ=;7:m2pu8gEOtNoE1xFOs1NP39iF8jyobGoiIuR3+LFBXzc+ZdppemiwrbNLaMm9yUzvPSINKviBT70BP1GSQYm8SCGJzt9hpbrO3SPMWL79OIilLgqZ6k36l/rDvRxvrtrmamjXrcjDib2sY2hMzcA1sJPHCje6E3Q97QnLBRClON3jrVstEU3R6nIHEqyhx2t5dr7WzmNUOn3MQdxB9r89GO+gR58yzhE7N8IqGKOmGyB5p6hJZaD3A3eUOYl4+zzu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;20:AKHZqJY7Qgp5RRQIdV9fkwb+dBVyc/3y7Vq2G+DgjXQO1a2CEWba2tMyeBEOzsWGaAngbpZ3txtbh5DgPEC3ZiESU4KWVlpCKLyeTh3t/T5OHSvIbAeBD2tK4/Y+0pCF/bGsW7c+ieYr1jdZSEfvw1GxhxWSqr6tSeq+o6sM0vQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 17:00:46.7843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb3fb8c-f5c7-4c58-9a78-08d58f4d4ad6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3253
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/2018 02:43 PM, Michal Hocko wrote:
> On Wed 21-03-18 14:14:35, Andrey Ryabinin wrote:
>>
>>
>> On 03/20/2018 06:29 PM, Michal Hocko wrote:
>>
>>>> Leave all pgdat->flags manipulations to kswapd. kswapd scans the whole
>>>> pgdat, so it's reasonable to leave all decisions about node stat
>>>> to kswapd. Also add per-cgroup congestion state to avoid needlessly
>>>> burning CPU in cgroup reclaim if heavy congestion is observed.
>>>>
>>>> Currently there is no need in per-cgroup PGDAT_WRITEBACK and PGDAT_DIRTY
>>>> bits since they alter only kswapd behavior.
>>>>
>>>> The problem could be easily demonstrated by creating heavy congestion
>>>> in one cgroup:
>>>>
>>>>     echo "+memory" > /sys/fs/cgroup/cgroup.subtree_control
>>>>     mkdir -p /sys/fs/cgroup/congester
>>>>     echo 512M > /sys/fs/cgroup/congester/memory.max
>>>>     echo $$ > /sys/fs/cgroup/congester/cgroup.procs
>>>>     /* generate a lot of diry data on slow HDD */
>>>>     while true; do dd if=/dev/zero of=/mnt/sdb/zeroes bs=1M count=1024; done &
>>>>     ....
>>>>     while true; do dd if=/dev/zero of=/mnt/sdb/zeroes bs=1M count=1024; done &
>>>>
>>>> and some job in another cgroup:
>>>>
>>>>     mkdir /sys/fs/cgroup/victim
>>>>     echo 128M > /sys/fs/cgroup/victim/memory.max
>>>>
>>>>     # time cat /dev/sda > /dev/null
>>>>     real    10m15.054s
>>>>     user    0m0.487s
>>>>     sys     1m8.505s
>>>>
>>>> According to the tracepoint in wait_iff_congested(), the 'cat' spent 50%
>>>> of the time sleeping there.
>>>>
>>>> With the patch, cat don't waste time anymore:
>>>>
>>>>     # time cat /dev/sda > /dev/null
>>>>     real    5m32.911s
>>>>     user    0m0.411s
>>>>     sys     0m56.664s
>>>>
>>>> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>>>> ---
>>>>  include/linux/backing-dev.h |  2 +-
>>>>  include/linux/memcontrol.h  |  2 ++
>>>>  mm/backing-dev.c            | 19 ++++------
>>>>  mm/vmscan.c                 | 84 ++++++++++++++++++++++++++++++++-------------
>>>>  4 files changed, 70 insertions(+), 37 deletions(-)
>>>
>>> This patch seems overly complicated. Why don't you simply reduce the whole
>>> pgdat_flags handling to global_reclaim()?
>>>
>>
>> In that case cgroup2 reclaim wouldn't have any way of throttling if
>> cgroup is full of congested dirty pages.
> 
> It's been some time since I've looked into the throttling code so pardon
> my ignorance. Don't cgroup v2 users get throttled in the write path to
> not dirty too many pages in the first place?
 
Yes, they do. The same as no cgroup users. Basically, cgroup v2 mimics
all that global reclaim, dirty ratelimiting, throttling stuff.
However, balance_dirty_pages() can't always protect from too much dirty problem.
E.g. you could mmap() file and start writing to it at the speed of RAM.
balance_dirty_pages() can't stop you there.


> In other words, is your patch trying to fix two different things? One is
> per-memcg reclaim influencing the global pgdat state, which is clearly
> wrng, and cgroup v2 reclaim throttling that is not pgdat based?
> 

Kinda, but the second problem is introduced by fixing the first one. Since
without fixing the first problem we have congestion throttling in cgroup v2.
Yes, it's based on global pgdat state, which is wrong, but it should throttle
cgroupv2 reclaim when memcg is congested.

I didn't try to evaluate how useful this whole congestion throttling is,
and whether it's really needed. But if we need for global reclaim, than
we probably need it in cgroup2 reclaim too.


P.S. Some observation: blk-mq seems doesn't have any congestion mechanism.
Dunno whether is this intentional or just an oversight. This means congestion
throttling never happens on such system.

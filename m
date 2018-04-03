Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755471AbeDCLRQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 07:17:16 -0400
Received: from mail-db5eur01on0118.outbound.protection.outlook.com ([104.47.2.118]:27298
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755337AbeDCLRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 07:17:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: general protection fault in __mem_cgroup_free
To: Michal Hocko <mhocko@kernel.org>,
        syzbot <syzbot+8a5de3cce7cdc70e9ebe@syzkaller.appspotmail.com>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com
References: <001a113fe4c0a623b10568bb75ea@google.com>
 <20180403093733.GI5501@dhcp22.suse.cz> <20180403094329.GJ5501@dhcp22.suse.cz>
 <20180403105048.GK5501@dhcp22.suse.cz>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <a91a520d-f56d-56bf-d784-89fb4562ef3c@virtuozzo.com>
Date: Tue, 3 Apr 2018 14:18:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180403105048.GK5501@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P18901CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::32) To VI1PR08MB3261.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5bf4324-5fe2-433e-c3c9-08d59954725b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3261;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;3:qzckuw1JT/QzQxeYgLMa0Ratu2D5fMpbUY4KJkgdcf9RJEpIPcKZH98HmunGtAuIQMSDaeOLExNXlvh+oWq2PNo5Hou27iNCgJ9F3YAfMRfbVarqUiupS6B5WYI4Qe9JWuh8sFHk3Uq6GLheVcYh7j1tHC5uP5dxSWWb70/ahkZKNu88JAiFTzKUeqFWS1Cfs3YYgqOBdIlXjxPOOj+NkkbWncKvhYM0i38eGMht7x2/GZuob5ZJ3MmrxNkQ3ZOR;25:sS4zexnqfiYJuHuCBl5Qz7g3SoioSHUIBpIJIyFxcV9lc8StuqgWO/QCAAUxu798SZAbYxi8peXZiyvVwmdQEU2sIHlLnEcK1HBmRgw1ZL0pS0kIRBXZqYI66p0zs7Gvjr6auBzNE5eJUtWUyeGjU2gD3JPGzA0lHLMHdNfNImuON42tvWHkISKwC9IhPgGr3ME+g9POoClb461JBXOvRXJolK4JfkSNR4iFEN7vfR79GUovn5hORg7wiq7t2RkEmJa87CRcTOUF34pMwaWIoBDOGmgUQW9TjXuOBKIpPTLvKBJyDZPqLsOd4Zu7NGYieYb/xf2qtMr04/BldiaNpw==;31:mj0WRJHSWvTynz67YfKJL1hvQnCJHuIO+dnsl9HLe9A4J2pbAebR/7wChkYwYJR3kedEoCuwkgQ5wYzLURJWXccOBVXnPJHT+fR8ePApjH4AkA/yAwY6TolzA3R5Yf78bwsmwLiHof6eyr8mGOxU4v3GRorK+hvktIx9WyDdqWxSMtHXlJ19gvTpDK/TIt311yMDGWNwEfET8gWzUhaURDPhzk2Ok4IzbGzacyf9qmI=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3261:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;20:NpLZyvDyzrglPIYgIogaI/Hxa/ViuPRv5tcE4TO2p/y4MCcockjYzzD/AdLB+e87v5ZIrcF3AU5a98iJRtJ2xa2tv09WsOROGaun58FwB8aU0J9uYCxPrkYfncqezzw/dup7FanLlBJA18/syl0zEdSYOIv5lLP0x9Fygf1en4aakCTKndc8HLEmmPvZvIFOQqBXsYB3M8ZYHVF01Lwh+p78p3s/0tPz0wCWXIGySsReebHM/d6Kgofg0rRqFyaGHj9frSzTOnx/6X0hW1QERALu56t1NeLcUn/5OIyv+dESYpE8M1+UlMWX5JKO7Y0xIlamuONK0GO24XD+KWI8oJNAlrB85qS4N/5KeS88AGJw0mC4Hbe/0FhbQPvy9VMmFSZeMHohRDUesLEyVYKrhuxZF5p8KfKfsOD6nhULjJUib49FErEGZuXTL7h+H2/ybH15Qn6WIGqoSvGRsbB0EGsN4dMy6YCQdHvnT5bwnwX2UlSUsNpfU2RAuDcE54wW;4:0wzATlp7iJB0L9Xgl1qmYqr/iGOxiW+YTrj0v1VX3z44SpRnl0FYOc4CApotJcnqmGgLd++JD4bos36M/ZvoVCcdaVSqNOt2gfzTaNNQH/4kc5X2trXnBVmD0dPZNvLtLoZjg0t2j0BBi4YAXP5Rv2eEa9bTeXBbicZPVqi2+n//4N8sDZfvggvk8NBSW8Be1uqpQk3SsqMGM7HpwyGUlxB2JjhpCVPShJhLHViDhAPSW9yopzpIz+URzaUHF0BKRLLKpr1SzT0sRZ34UkHb4Q==
X-Microsoft-Antispam-PRVS: <VI1PR08MB3261ABF087456B2894774F88B0A50@VI1PR08MB3261.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR08MB3261;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3261;
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(396003)(39380400002)(346002)(376002)(366004)(189003)(199004)(16526019)(81156014)(2906002)(66066001)(81166006)(65806001)(65956001)(65826007)(8676002)(478600001)(59450400001)(7736002)(76176011)(53546011)(386003)(6486002)(64126003)(186003)(31686004)(77096007)(52116002)(86362001)(39060400002)(47776003)(25786009)(55236004)(31696002)(305945005)(68736007)(229853002)(26005)(575784001)(4326008)(8936002)(6666003)(93886005)(6246003)(476003)(36756003)(110136005)(16576012)(316002)(23676004)(11346002)(53936002)(105586002)(6116002)(5660300001)(486005)(446003)(3846002)(52146003)(106356001)(2616005)(50466002)(97736004)(486005)(230700001)(2486003)(956004)(58126008);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3261;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMjYxOzIzOlNxWHE5RjNjUDFUc0tEaEhEYW9wbW9KK3J1?=
 =?utf-8?B?TjU2cTY4Z1ZZRFp3Vjl6NGlaSVVicVJBYXBScG8xTUhxQ3h2czhoUVJNV1pZ?=
 =?utf-8?B?ZU16ZVhvdWpvcnhkS1Q1N1lNeHhNS1g5MjZKWUZYSkkwdS9QYm5nOHFsaHJm?=
 =?utf-8?B?UFQ1Y1poZGVQUWpCSmpnVDNlcUpFOStXeGJmam5yRU9yUURsekpCQnBNTmVS?=
 =?utf-8?B?ckh6M2tIK0dJbHpoaFlNamtTSUxDVGFtQVZWQXhGV1EyMkVrbHVwM3EzNGVK?=
 =?utf-8?B?OWk5aDhWaUVIL2x0OUJnaVNEUDYrN0I1TitmWmtqU1pySExzeFQzN2NCQXh5?=
 =?utf-8?B?S251eTE1UVNtc1RwNDYwTldHaVltdzIzckcxblJmSnhaMTFuVE5OVFN6Tm0z?=
 =?utf-8?B?RklYMzRDbGdVVHlyV2JxdERVT1hsN04wSWhWbXBXMFBrUCtzcmQ2dWJweFRo?=
 =?utf-8?B?eEkvQjBKY2hweWNIYUQybnc2RzdZOUhjTU5wTGFGeFNaNGk2SUFTbUswcmR3?=
 =?utf-8?B?NDdzb1lvN1FJWThQZ2VLQXE5Nlh5NzVOYlBCalZ6amxLUXA4cWtxUGFpcjgz?=
 =?utf-8?B?bnVoMUlqYmRlQ05wUlVvVXNlbkY3WEhrSlNVUXVZRk9FZWRlU0piRXJoRFZq?=
 =?utf-8?B?a0ZXWW8xZjc1K2NsR200a0IyY0pOb1FSWTBVL2p5Q1FrSnhKYi9xZHlVNkpT?=
 =?utf-8?B?a2M5OTdRZHp2QkthSE82VmJWWjNiaEZ0cTJ6cXRZTTdMbHdtdlJwVUFScUNG?=
 =?utf-8?B?QzZnZlQ5UGsrMUR5NkFIRzFzQis4aHpVK3k3bXlKeTBSU2g1ZlJxWmIxZjRN?=
 =?utf-8?B?c2lQZ012Z0NWb1ltUXZqOHJWK0hvaGYxb2RRVjN6Sk1PYUFRT2tyL3dpV1c3?=
 =?utf-8?B?UWxxd0xTaDJ5VmRKSmVsaWdxMHhoejZoSFB3QkFPMTNKZTZHci9aU0tsdTd0?=
 =?utf-8?B?azUxVnZ2djBjTVRjR3k0RHluVmpwR3hMWkxMNGFvY3pZK2xaaWtwVUhnR1do?=
 =?utf-8?B?TEpPcHAydktEcUFpRVJ0Yy9ROXhNOFBXdWtFeitsMzdCYjQwam16Sm1JdWxr?=
 =?utf-8?B?WEluNVp6Skt0dTY5VmI4bHlieTl4VVdZOVN1OFF4QTFQd2xHQ1lpUFhNNU9G?=
 =?utf-8?B?VHVMYzNVMHM0ejkvUzhrQkVvbW9JbThoeGxjdFdCM1JPYVVOZkxQdjI2bk1F?=
 =?utf-8?B?am5vSldCcjZ6NDJmVEMxYndHVzJqUjgwT2xHYldianF5empLRkZwSFpGdXN1?=
 =?utf-8?B?N3lGYWtCY1lwYzBtRjlBMnpjWHorN05nSVcxQ2JVN3hkSDVRcnlYd2ZoajFM?=
 =?utf-8?B?SnJWaFdEZ2ovd09ycTFtZUtBM05xS3k4SjZwMitPbzZXNDFtdDJHMFdYUW4r?=
 =?utf-8?B?UlVsVXZlVWxNa0F3Ylo3TitaRWVYWTdPZ1Q1ZDhON1Nwb3ZTdkpVbTlBZ0M2?=
 =?utf-8?B?Sjl2c1duRFpQWVpEckdJa1ZaY3YrUjluSGxiKzBSdy9Kdm9vVVFXTW1SaUgx?=
 =?utf-8?B?cVJPd0lzWWFZSW9IeE9wTDZVQ0ZBTVlNTEpheGpxcUJNUjhaWFRsbzdUOFhQ?=
 =?utf-8?B?OEVsZWEyQk5uRVlMNVRpL29CK2JBWkxtWlpuZUtJa0RFMVlpRFIrTHlhRWo3?=
 =?utf-8?B?RGM4YmJmdHN3UFBqRGF4em5lQVdsdDRUa1NXTFA1NFBuOG9TQUZoekprZDFT?=
 =?utf-8?B?N1FkZHdDUmVUTnIwMUxCNFJqVjdHOTF6Vmt3Tnh4dGFQNWpJYk9DdDFTU1V3?=
 =?utf-8?B?TCsrdGpMUmc0RTJPYUpHSlZURzVlRkozdkNGdjh2Mko2c1VTaWVldU1hOFhR?=
 =?utf-8?B?Y2JYN0FqUW94TCs3VkdYanYvRUd2S0t5dWVXdS9pM3V6MnVyU2t1eitoWXRH?=
 =?utf-8?B?ZDFvaVFNNFAxamlkcExQUmpGejFsZzJVQ3Y3STFnSUdiZWUvdTlXVG9LOWxL?=
 =?utf-8?B?bkhCUzJ5LzVxQ2w4dFIzbkZibTJUNU1lVGgra1J5Rm9JVm1SVC9qRnlQQTFr?=
 =?utf-8?B?UXpTQWtMMC91SENnZ3VSVnZrL1pTeU40elZwMCt2OXlpTS9UUWViU3J3cTJ4?=
 =?utf-8?B?MW5Ock9Ia3NBcXpBY1N4ZitGUEhhSDhhejlieVZ2aTBrdkdXS0oxZGhZRkhq?=
 =?utf-8?B?ZVE9PQ==?=
X-Microsoft-Antispam-Message-Info: LWwI9vSyRcJNrN/b8qSocmvwhWhkJXJvzHUenM99ZsOpiGe6a/UM7gxVv6E1JEKpPpS1RSCk49MikYpnVfmT9ets9gEwBezoqvs3ITjzykacwdHRH6LE55fpdvjHoFrkk8j0MXO2YiI7MZlpLyUQ3sL901gitdz1hla2ihulNp1OJ+StasvZ99Pq/nC6RzIN
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;6:HP/8Zs4O+58dpUVofMeLWoTEXNnogE8AO02FlICqDWksJLwPg0CJPUbleaDaT4PNmUZ452ZQBCOAyvnHhJ15VvPdlGKE15EYOQlQaBMsJS5S88gfbpXMUp/9nohaExf1miNdbKgywhCuCeprPjINlcG15DPpjCk9azUitJUfpASgkbYv9OCXk2f/1hFSvggU0QJam5eF2D/63phWYeVQT8mJw8uCLWudiEYdakJYJKp0RKbO0kTG1MSy88P02LTTqQPGVHI0VbsmfKF4eqH8SuvQdJW/tqHAG5zRD3oVgeIuveI8gPKsJ7B3F7AKQ4wikEue5V3R+xqF7w/oDGEpyaQCSLpn6AcGLLoWwJfzkC2p9o3fOxtwq+iXcLUXKVhtdUghwOvp2NpDO/x9YEcq1sLC/NXdq7V5rKZTEYTRfybPXXjOTNPRtrhrza7fd0CwdRxZTU15AqXW4fRMQ35nIQ==;5:FYLWi7nPCRcuC/xKZvxSRNspdlrVGcvsh9j4nrxkAOiQRz2RkbKPtIjnRUd1lQGKwyh3GRnhr80S6F4Fvkw9rF17Q85DlUA0g+/im/mk+RZgENKt2L3Oo3P7maMIc3eGrxHAgmeOjUofmPJJUAgc/Punxpvyrkamp+HlExMVheY=;24:cSti1ZxSIylqmIgRj/pN1somJKPsbM9HA2INWKfXDcij4OHsNyo780PnzIqSl+psy4a2LoRQ9ZH/VnKhNI8/UVNSpfHOyf8XFFd+n+u+EOw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;7:DUN+LGo3VStyBrDDG0PF/G/1Elu+/oWlAm6YOW0I3+MeZBSMmnyOhtqJz91CPBIMMAcgNHQ7RS0u2S+jhbJrJWwNVmz6YM0Li9mg8lw7mO5XNmCDbv+FMHtCyzu1Yn5RSLW2N6SZ1nmp/qQ6+O++HnK+LwtQeMrwCXMZIP4LdiQthQiwcgGDPbC9CkteGclmWm3bZncWTyyAdV5cDlZb4Sq0PLa0ixwXUj5HU7I1aOgy54tvz3F49QiPaJgUQxHO;20:HdPLY+LZlzrVqY7WPiCgWgA1RaCinrGREymGFmpaYDeCCsCjHP5jcNRzLJlBc3dnwwRqkFI3zqBupQwMNh7Iz8rYuPPsScELwGL9qmlthTHUxPSPB2SI80Kh9zDwJQRyW7Y8BkMtuVWA6PKTm7jk//XtILtPWaiaDQg5xBrrejE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 11:17:11.0837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5bf4324-5fe2-433e-c3c9-08d59954725b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3261
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 01:50 PM, Michal Hocko wrote:
> Here we go
> 
> From 38f0f08a3f9f19c106ae53350e43dc97e2e3a4d8 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Tue, 3 Apr 2018 12:40:41 +0200
> Subject: [PATCH] memcg: fix per_node_info cleanup
> 
> syzbot has triggered a NULL ptr dereference when allocation fault
> injection enforces a failure and alloc_mem_cgroup_per_node_info
> initializes memcg->nodeinfo only half way through. __mem_cgroup_free
> still tries to free all per-node data and dereferences pn->lruvec_stat_cpu
> unconditioanlly even if the specific per-node data hasn't been
> initialized.
> 
> The bug is quite unlikely to hit because small allocations do not fail
> and we would need quite some numa nodes to make struct mem_cgroup_per_node
> large enough to cross the costly order.
> 
> Reported-by: syzbot+8a5de3cce7cdc70e9ebe@syzkaller.appspotmail.com
> Fixes: 00f3ca2c2d66 ("mm: memcontrol: per-lruvec stats infrastructure")
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

> ---
>  mm/memcontrol.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e3d5a0a7917f..0a9c4d5194f3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4340,6 +4340,9 @@ static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>  {
>  	struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
>  
> +	if (!pn)
> +		return;
> +
>  	free_percpu(pn->lruvec_stat_cpu);
>  	kfree(pn);
>  }
> 

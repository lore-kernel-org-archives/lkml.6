Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753902AbeDMJfb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 05:35:31 -0400
Received: from mail-eopbgr20119.outbound.protection.outlook.com ([40.107.2.119]:63903
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753185AbeDMJf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 05:35:29 -0400
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
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <ed75d18c-f516-2feb-53a8-6d2836e1da59@virtuozzo.com>
Date: Fri, 13 Apr 2018 12:35:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413085553.GF17484@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0802CA0023.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::33) To HE1PR0801MB1337.eurprd08.prod.outlook.com
 (2603:10a6:3:39::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;3:Bu5gwkwwT94WHfAk++9ygxTLNNw+oY1dLVd71OoeMU7VwNeSbmPG73JfxCYh9Ab5f/9N0Uhb3ZJeS7Fs5Syy4z/jlYblsELp9PDdrEfDwYhUs1266yTfid2nCIPubt9EY0VS63nkko+2KTQpUOj164BJqjLiOvrbpVWDQoSOincZlFtYnuUr6joC2hXMymLXvVY6sMdv8Lja7I0MtplBhL+tomIDLKwiKChV5oAeI9Uxq0VyfNrOW4ZLBf6X3bJ7;25:P0nbAEadODJySGEoNLF9HOp9k5KQjGDYrfzkuWBRlfihj5//FGE7CJlnpbj8fpXrM8mIcVXfknew59Yg8nzO2py5FjDQ/POBonC0F0B6ZcjjgEONyZPc2G1PHbYysEiPnDsllyTnS8P17hT/bRPQv6X/lskOD/42G5cw3QLQcd3EMAwRa0B0ws3yb1bl6wGCHlZWa0cS7xXHpUWSvMTZE1H+Z1AvuCOeY6fNO7b5r6Z53elWavOAV0KqeBtXMxVLcVJSUtVZnkUyxrQK/2OZfMnfp8MZ3hAW97xKvb7epiQoVxmMcLrOgRI36BlvuMg+tpXOjQAoXks49FWtHKnLvw==;31:qWQFqnWa4NXB9mg6T7XCsKfHBYoWub7kk8Pz73oYQXrESJuKmU/rHoJTBHkbwfcnNzLWp0suM7NNsG+cknEg9vyrFKzh/yBTAEAp/GOwxOgiCElR1JHfKhOsNo2Tjyg8UsoOkntfa3qReRlljc62wmcS4/YNroC6UxGOTJ0Ri4V+nxX/RWRzTPu7ZHqW6a7jR4JXM+jJ9hjvrgKvgl4zmpmGUN/CfraBsgzJzepDBM0=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1337:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:ILB7pE/s8X5jZquzKhl4hb1AfyEaCMmOC8H/0l0vYx5T60n2DTs5cNN2gbsezVT9daXks8/lT4Bv6ylJt3uAy8Y/1feaXTBhhM9buTeRK4DAf7K+fI0BJrnnqcgmpvzwv749RQgtEMPLwTq4jmrla0RHP8AEIGW8xzZYU1WXmIp+pPhet/+wYdJfC7RP2RvNyfSz1yBcxnRB7EruK4XIL89HavlPi0Rp81Hix3MyXuOJZhq8Q09+LdtdAt9Ap9teYYy61zidKzWagtYwvU4Q21cvkv50uw9LBrtJpNrWmbduHsCr4WhccBq9mQYK7T1AtTila2sympev684+WzKhldeMsg1Cw89RbgRREAetjuFuhCLPYOv7soezSwL03Ny/R5D+FSFHPmmh3oZAd3ah6/0ZxJah9q8bmFlliKTIe7rBc5geMF39c4Yaqk8vRPSYCeqBho0uBRigfBzBJz+rLTRMqkjUHp16AQmWqGPGHIzLwoKfvDdzB9IckXLS/yzY;4:bu+rceFpcoa/vyuoNQOhpQgHzfkEkdXvzrKzm9scvlGJFmqLg+TeDNehwNJ672W2ll3QPArANNMRGZLB4yS2EzlwAhed7OssGTytlT34XpHzXusfIVnTdvFp9E0nLd19wI+dR4CEPVKW7e63cvrRfb57/ahmJWmFsoim5tgNiAU4+8SDWVIcusBC7ER+B3k/9SUPhz996EpLz/LMU79kxoIGgQlkv2aqLEPRkAGlXdGa+UsiR66YhSsgn8ik/ZoDYrHR4EEQGtGkNxjqLt3K7L7Zdxfnv7Czpb6hdC6iOqW3wmdF95ESgDqdo2b1aDN2
X-Microsoft-Antispam-PRVS: <HE1PR0801MB133725DD1F2A2C8916FB2814CDB30@HE1PR0801MB1337.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(265634631926514);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0801MB1337;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1337;
X-Forefront-PRVS: 0641678E68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(376002)(366004)(39850400004)(346002)(39380400002)(189003)(199004)(377424004)(8936002)(58126008)(305945005)(55236004)(81166006)(64126003)(5660300001)(39060400002)(65806001)(478600001)(97736004)(4326008)(65956001)(65826007)(386003)(66066001)(59450400001)(50466002)(47776003)(2486003)(36756003)(76176011)(23676004)(316002)(2906002)(25786009)(8676002)(52146003)(52116002)(81156014)(77096007)(3846002)(105586002)(68736007)(106356001)(6666003)(446003)(16526019)(53546011)(229853002)(86362001)(6116002)(7736002)(11346002)(31696002)(6916009)(16576012)(476003)(6486002)(31686004)(6246003)(956004)(53936002)(26005)(186003)(230700001)(486006)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1337;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzc7MjM6ZHd1T0pHZTRucCt0ZWZuKzNoUkZnSGdU?=
 =?utf-8?B?YzEzV1pWNkdZSkdWUmdIcDdIVEw4ckN6dkpSUjk2UTdVWmlZV0VHak9YdHVN?=
 =?utf-8?B?aWY1UGZVNXpreHJ5SHVCUW1NMDV2Z29rcmdrbGF0Q25vUkVEZTdKODRUVFc5?=
 =?utf-8?B?VEFxWHpHeFJHVHpKVGtINlZCU09OWFZkeDBpYk1YRlNOeWg5QytMamE3aHJQ?=
 =?utf-8?B?VlpKZURKczdJWS9XOFA0Z0pMVkg0TmJGQjB2cC9ZVUJXdVBRUlVIVnc2VlQz?=
 =?utf-8?B?R3pFMjd4KzNuQ3M3RUoydys3aGNPS2VhQ21OYWN0TGo4TXZFaUpqMk5jak9G?=
 =?utf-8?B?bUdEZ2d4N1ZxZDhHS2xkTjNQUEJLZEMwNlVDQjNjaWtTTm5qc3pUa0ZZVFlv?=
 =?utf-8?B?eElYaXBINGJoM21IdnAwZHBVSXRNOElkenplQkpybzdCUlFSR0Q0Q0RxZlBu?=
 =?utf-8?B?R2d2bGsvUVNjdDNJSnNSQzdtSDB0b3NIaDRJZkZJekppdzlCUjByZmRoUGFX?=
 =?utf-8?B?QWVuOGxXVWFlZVluaE9hNHdJc1FGaXl6M3k0a29yRlRzSVpoS0MzRFhUNE1k?=
 =?utf-8?B?MGxsSlFhMGlFcXUzWS9nbTVuOG0zWkRQY1owc3ByRkFWS0g2UXY1WitxWG0r?=
 =?utf-8?B?TkExM1RmdGdtOSthaWZIU2c5WXVuTi9BVnlGYkc2MlZBNmR5UWhVZXpBS0Yr?=
 =?utf-8?B?SXFuUlBocTZwd2poZHpSTlhyeitzYkNBK2REWHFKR3A0THB1a1d1TSsrMmcx?=
 =?utf-8?B?YzB3Rm42WDVteW1aYzIxT3hSTjczVHN5b0tYcUpvVWo1OVhjTEJselVPMllO?=
 =?utf-8?B?OEwyU2Izc2VpWFNGWVYyT290NmJTVlRzbkcrZDQ1d1NYeXQwblpWYjcwYzZs?=
 =?utf-8?B?OU1SQ2ZZUTdOYWtwZkdPcTBJck9PQ0x0cmNXZlhQckVOUERCaFRtRTY3YUwy?=
 =?utf-8?B?M1lIdUg0cHNJMVFzMDI1SDh5R0pUaGlzM005NzBFbGgxd3NFVFFRWmhnTTdQ?=
 =?utf-8?B?UmEyWU1ONlVIckdvRndhekZKMjBBZ0dUek1kVnJ5bTVQWktHc1FHaWZHZ013?=
 =?utf-8?B?QWd1RWFHUXRQb1NCZmwvK3hzY0k1QnJuNzlnS1g5bXJUaVl5VDVROFROK21l?=
 =?utf-8?B?djhWMDhlQWF0ZlA3d09Ha1IzVWVuM3diM3hsMGx0MWpjRGNEa050QkRZV2ow?=
 =?utf-8?B?RjlwTzAvR092QmpyWHNuN0Z5WkZQdkxsSC9SV0NWUGoyYld4ZTl5RStyeTFR?=
 =?utf-8?B?bTZsUkFKdzNXd3hKVzlpV3JCcWhPUEZNeEdWVjdpNGdoQXRiVTJnQzFrbndC?=
 =?utf-8?B?bWxEekNrRXdWaXlIK2l0MWJSYVVJVE13SjVqTHR1NUV0TkZwSVIrYWFVVHlU?=
 =?utf-8?B?bCtnQU9xbjl1NW11NmFURnB5YkF3NU1WT2oyMWtWUnY1SkFYeTF4RjA5ZXVW?=
 =?utf-8?B?ODlMQm90Kyt3OWJodUtPemp2aC9LUDhtVzBjNWwyOEkzWS9oZXZTZXdOMS9Y?=
 =?utf-8?B?SWlHMXRacVRvMy80NDRRaXMxeVJMU1R5QUtYZDJWUGNvQ0RxR3BtR0hEck50?=
 =?utf-8?B?Z1MrUFZMTHlDemlsZDliR3JVb2l2UnRDZkxBOU5TKytabHlCRVF0Z0VSWmZ2?=
 =?utf-8?B?QWx1bC9DUnMySVF5VDNNSzh5Smhub09NTVJpR2poZHpwbWo0ZkY5ODR1bjJY?=
 =?utf-8?B?Vi95SWhpYVUzQ1BKSWlmYStXc1FIY3pVS25CYmRpN0VEeEdRZCt2bEV4VEVr?=
 =?utf-8?B?am92UXJCZEI3eXB3Y3J1T0JwbnNRWkxiWlZIcjljd09iakF2NlBLUXlWUElp?=
 =?utf-8?B?cndsYzdsWElUc0R3dEgrdzVaRkRmRUVSZUltYmhtWG9FRWhxOXN2T0Y2aVJF?=
 =?utf-8?B?anRhMFNxZDJBUTArczZIQVA5TnIzRkVMek5zTUVVOWk2Zyt1QTQwRGZXdWpR?=
 =?utf-8?B?SDZkYzFUcDBldzZFZ3hybnB3cVI5TTlDRktrVlVlZVhmRzZRRXgwbVRzQ1d1?=
 =?utf-8?B?N2E4WW1meVc4dkM3bk9FT0FHaWhQZUl5WS9MTnhvb0xoVlptSHY0d3h5OWFG?=
 =?utf-8?Q?GB5jvI=3D?=
X-Microsoft-Antispam-Message-Info: l2BsELflJ59Gssc8LEPc9GfMTo2P+F5lWin98R15rwGywKKpyDqyvQUTlR7LiEEeRwxVD75XB4XLhswW1kFxPdoNCyKtlaepJCzi+DyetPZBEJvKpnZ683ma0Wbb2AePjCeeWG42e8JEFi9VqEbw8c8DqtPiGEfFxQD1m4tgwpZW78rG5H6Ky/pUFHQ9FIST
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;6:aY6MRa65BBEHIl++mXLN3pVmBNGieqSLuIGCs4LK7cogJ8+NrPOnnz4J9xBL278/EOzUv0/dKTk+u+dn54O3sQECdKgS327oaMm/T45HHSJ6ZmNWEJO1YVGJ98YcopcFhHXiCR66dGJ8xSomVYIeiKjwHDDfp5k3zfBAb3fPIK9RANmu1tkAQrN0lP7BN7wbvC7xgBQglBMomsvAV5ud/WSbHTHGrTFl3TJhVLQJ7nugih654V9eRuQwJbqAvPdA1Nng0xjoMSR7V96y/RvvmFe59JaZ3NtY7EQHKaXWqqlWYJD+hM4YFIWLCsWiETXqyiDIFudeXMfZ+QqGzVddnfIsDyZe0tukkcW20STORAopLTBK54VsLy5vOZ52m8f4jICyyrgwxgv48APwB1319FaUsstk/t/foCsOyHmObe5L7IN8sDcC51esqIXxK+8U9nsqBB/3/pwRbAvuG/Hlmw==;5:X8fKGCuIpShWHEn6WoD0TnOttODtAQioPszueSFvbeSc9uTIySPvxzDdvdcCR9Ibc4dqokprlSbCUraTFI0Hvgkd2kaneh3rbEX/LdXHxLq0Mn+zanjLkBOxSR62vlRn6rLS2tgkm2+QNcwOhQ7hnFBdbpjz1UswMcZHtNp1y2I=;24:y488GP9TZicuCVca3rXEgYvWu/5SqyQ+6VS4y513a4a/sSds4tqLKG3Q0ieCIXU0DZrJPSrH9Ynm2XfAW2nPJIYdHwjy3qm539z1CYp5Sok=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;7:oMHe9hLK7ttf+BR0lJIE+VC0YyxBDEprBSH3j4XIgMFyKU/aG87RNgvM/Qc49cR1nKuhAUknQP9ronKPjCHViEL9D4ylasnA9tM6Bc35FwDP5WNwmLu7RDWl+c7UlFSHDunH1AHTrN19U4DJztYGAW9I6PEF6U7zkeIn2VyaniYO0E+FAo8j67ILlnpSrv/3k9xNNtWAofqwHCFqB5TLdxqHMXvH5dWi9s4qAF6SVrgiufeD7OXGmQFrHUdr8hPY;20:sXXndiEo+CbVd9Q00NBa+46mVkJcmLPWQM43yDuBf1ZEWm8nZRHCV1b45fNAxC3nGwcRUgcCRtQXpea1pVNa+Vj9IDyFWeKczLUzXlnPpEB0CQPp09+UY5PNE5RimGWCERtZSPjmsc9+lnA3qwB3/HDl6BETq/IdVAZsfqEzy2Y=
X-MS-Office365-Filtering-Correlation-Id: 9a2d5749-8934-4854-d632-08d5a121e307
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2018 09:35:25.4914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2d5749-8934-4854-d632-08d5a121e307
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1337
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.2018 11:55, Michal Hocko wrote:
> On Thu 12-04-18 17:52:04, Kirill Tkhai wrote:
> [...]
>> @@ -4471,6 +4477,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>>  
>>  	return &memcg->css;
>>  fail:
>> +	mem_cgroup_id_remove(memcg);
>>  	mem_cgroup_free(memcg);
>>  	return ERR_PTR(-ENOMEM);
>>  }
> 
> The only path which jumps to fail: here (in the current mmotm tree) is 
> 	error = memcg_online_kmem(memcg);
> 	if (error)
> 		goto fail;
> 
> AFAICS and the only failure path in memcg_online_kmem
> 	memcg_id = memcg_alloc_cache_id();
> 	if (memcg_id < 0)
> 		return memcg_id;
> 
> I am not entirely clear on memcg_alloc_cache_id but it seems we do clean
> up properly. Or am I missing something?

memcg_alloc_cache_id() may allocate a lot of memory, in case of the system reached
memcg_nr_cache_ids cgroups. In this case it iterates over all LRU lists, and double
size of every of them. In case of memory pressure it can fail. If this occurs,
mem_cgroup::id is not unhashed from IDR and we leak this id.

After further iterations, all IDs may be occupied, and there won't be able to create
a memcg in the system ever. You may reproduce the situation with the patch:

[root@localhost ~]# cd /sys/fs/cgroup/memory/
[root@localhost memory]# mkdir 1
mkdir: cannot create directory `1': Cannot allocate memory
[root@localhost memory]# for i in {1..65535}; do mkdir 1 2>/dev/null; done
[root@localhost memory]# mkdir 1
mkdir: cannot create directory `1': No space left on device

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3e7942c301a8..5e17bfee9e6f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2156,6 +2156,7 @@ static int memcg_alloc_cache_id(void)
 	err = memcg_update_all_caches(size);
 	if (!err)
 		err = memcg_update_all_list_lrus(size);
+	err = -ENOMEM;
 	if (!err)
 		memcg_nr_cache_ids = size;
 
@@ -4422,7 +4423,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
 	struct mem_cgroup *parent = mem_cgroup_from_css(parent_css);
 	struct mem_cgroup *memcg;
-	long error = -ENOMEM;
+	long error = -ENOSPC;
 
 	memcg = mem_cgroup_alloc();
 	if (!memcg)

ENOSPC was added to the second hunk to show that the function fails on IDR allocation.

Kirill

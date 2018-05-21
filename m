Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbeEUJbo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:31:44 -0400
Received: from mail-he1eur01on0102.outbound.protection.outlook.com ([104.47.0.102]:23392
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750922AbeEUJbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:31:41 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH v6 12/17] mm: Set bit in memcg shrinker bitmap on first
 list_lru item apearance
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
 <152663302275.5308.7476660277265020067.stgit@localhost.localdomain>
 <20180520075558.6ls4yzrkou63orkb@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <2a0ca70d-12bb-8087-9897-9cb33f676177@virtuozzo.com>
Date: Mon, 21 May 2018 12:31:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180520075558.6ls4yzrkou63orkb@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0005.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::15) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:LDeLSg4g0Qesd9S+1YVO23bGvxZpwHzHwpuA748yVJV3v56gLXD+GRf8ofOHTdRLQtBEF5l9R+1uypvjZjaRimJhnATy+GY0hgDY+Iu29xVP0+KW7AgqIy41V/A7+o0Md/8YMRxzegMDTaZ0lSDmEIjYu5lxug0FDNeFAxUV+kvM81zTyqc1x4TU+5RtXFCcOm9ZOTtusoYe0E8carOOi5gasfudNcpPDwMUVBX0BldHwveR06dsM3lAfH6cZ7h8;25:8k+7eXuwQhRemVCSS+PGfiaw+nbQt+03eOzQSlN3qy1qpH7Ak/rnj9eCbB6mtMi1jI7xmGYsP1jYSPPV5jVFxxOOnLOJstgIZEYjM9/Rnm5fJheYiZF4m6s3RvFmSSUoBaT99CqxU1ELVIv8gS+poqm4YhbIk96mQxT65xY01uIQMwE4giOpAtQ+RAtjbsrYFgx00gAobW5EYoK5EMlOcwj90M1x6nyxoGYUVOj9ldZ968i154K1qYN3QJOiKVXnzSHil8bJ30nXknTa9O1iOvKhRpVtLSK3Hh3RfejAuBaeQiNLDARxwXz/B8O479KGMf0Qe3RaG+NQvwSoCox8rg==;31:6OE5B0H2Cb//iVJ3Woyf+cQ0rCZ8qAkIyig/WG0+zd44lgjA80sr7iLhRTnPqPqIQ6g6DF3XoUZPpIJfQsZg846rVjBt8C7PEtxVOvTjWtRElMyssxNTlEZFLwqn7yPfhCpjLJ4b5VY3Nr1Qy7U6uAaUAembRTaiStIHB8DyD/EOi620iTDknFcGeGnx5Ktzz2XThbxYQCj4i1OJ3MkpOlckIvPIiyoAO9tQoWYv02w=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:R15mPVDa/FbtPwdgFEIh301V7nZLK0+Pj9Z0zwCfNcITNh+8P/GdhPMNiAnp5iJFdzQwAp1cxHUo+BsUGH0/nhzPls3mH8dT+lKd34F8wmqgGticl4irKg/NC3OOmRog/Vd21xMTEDtEey7Tw0Vy1tSQmupypn7vK0BFyqJkbEUPg9MpSlH29Ks/6v4PPsDFgwA3fA8hZ4q5DBSC8iUo+gJJGgS+/41Nxp3Bk4onNeJFKXcyf1f8n+FDC4EAMB1nEkZb4Rq2v09cYKPPC1vjbTFJ6hyQgcXHlJBLDJN4XLti/iyGGdCMEzSmYdLz+xLCqsUqN8El8dvVPtDrmC0jCtJZFUy4ye7IP3ogjBniGJmdz/fjMtVRox/nFKotFZTYu7ZdPdlMJpj4wAMl3f2j665wlzIj2EGNiYyzcCiW648bO1PEMZPgr/zBkOd2Z05tu6iU8Sz9tEaXTfaS3SFd1uqrQHpR9R4kxpBdZJCaaqka3oZZZKCPgNxrT6YjU20a;4:Tnd+FPpK3mex1Wog0G7MsN8ee34qsafxSlMqArV8FP2f/CTjSgRM6sYFVl+q7ecSq+x9k3QvUunJLjjUULNVuWrw0+paEntfQ2hcD97xPDiMkTWuDLsknbOgnX+GtaAi0vuz7f/BYGiKj/U3g5lxGZmH3YT/GH2TbRBhleHkaBMO3YE5aHeTYGL0cKd7OIluFrmyuaiKMR0XsVOhcIcaTcCCD9Ozp7qOukRwAiDUb0CGv8Orewd29uraCP12V8GrHxVc9FKjsf0MnmtYSzaogQ==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338FA81831903CAB7F73D64CD950@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 06793E740F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(366004)(39840400004)(396003)(346002)(39380400002)(189003)(199004)(8676002)(2616005)(3846002)(105586002)(81166006)(6116002)(6486002)(81156014)(106356001)(68736007)(6916009)(25786009)(305945005)(36756003)(486006)(476003)(956004)(86362001)(23676004)(64126003)(2486003)(52116002)(11346002)(31696002)(31686004)(575784001)(52146003)(50466002)(446003)(39060400002)(2906002)(53936002)(5660300001)(76176011)(316002)(97736004)(7736002)(58126008)(6246003)(16576012)(107886003)(7416002)(478600001)(386003)(8936002)(53546011)(47776003)(65956001)(26005)(66066001)(65806001)(65826007)(4326008)(229853002)(230700001)(77096007)(16526019)(59450400001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6VnYxWi9veDhIMEhhOUhpMUNOb3owZlFB?=
 =?utf-8?B?NjNPSVd4S1dGK2ZkRkxod0VrMjVCbVp0RFZsSWZqWXZlbzhHK0Mwa0RNZUM3?=
 =?utf-8?B?YTk5aGlReG0raUFjVEF2d2RkYVFJUU5pK1dyUEFCSENDc05nZmhzbTYrQ0F5?=
 =?utf-8?B?ak54MHJHYzhNVjYwSVN0bFhhOEhMNGtvTUR3L0prZUE3OGtwRG1PaWJsblVm?=
 =?utf-8?B?K25Jc0t4TkRUMktEMGdGeE5TZnJQZjE5QTBoRkdlRHZSZzhoa3lpVWNpc2oy?=
 =?utf-8?B?cnVtQ2NpcVZLTDVpTFRiVWhqL2k3MmFPV1E0SS9KdjFaeEJ1cURGdXZSSW9w?=
 =?utf-8?B?QU8wMU1WdUFaRzRzMGVyYUhsd05mK1B6ZVlxbVZ1V0xYTWtQT3ZsdGdzRzE0?=
 =?utf-8?B?RlF3ODNVS05zWTdIQlRoaFM4a3V6NS9tNTF5cHpCWGt6bXh0bEMrSkhxeXMv?=
 =?utf-8?B?d1hLRTJWVnd1NGJ4NndYaDdvN0k2N1FZSU5nWWJIY0RBdURyeHMwQzZWRHMv?=
 =?utf-8?B?SWd6OUhHazZTcy9HMVQrTGo0VWc1QkR1SWwwaXcvVm1naEhPcUxtc3FMSWxM?=
 =?utf-8?B?ZE5yVU1QTDFHRUFWQUh5ajlBUDQ3aFZ4c2w3eGRsc3l4S3hORERscG1qUHR2?=
 =?utf-8?B?OTFTN1gySGhZWk4rVEdaZ1hoK2w4bER2ZWpYV01TNFA4QU5zMFhaZStHNExk?=
 =?utf-8?B?U05oTmxybzE4SzNZcDJqWUR2Yk9RYzBxODhteGVZam9OZEFGQzlBcUVrSEZw?=
 =?utf-8?B?Mnd5TWVnbXpndTgyNjlqUGRGWjFGaU5YYXpmeE9iajNyd2dkM21PQWtuWWhQ?=
 =?utf-8?B?cS94cE5ZZTBWdUZncUFsd3UzcVZjalJJMGxSVDBmUHhDN3hvOVFKdThTMEZi?=
 =?utf-8?B?TFdCRGhYRzRGWHhvWE1qam5kQnRzbGJKSWxtaHpJQ1RlQUNFMTQ2WVo3NWVY?=
 =?utf-8?B?WDF5ZFpOMnlWWXUxWTRkbGNRMGRCMGtjZTloWFBjWDdPYnFvZU9vbTZqajVz?=
 =?utf-8?B?c2JOTzhVeHN5YWx4SzhMVitLanBXa2xHcHlnRmdvWXQwbDJoeUVmQU1QWUFu?=
 =?utf-8?B?THd3cE83MmZoU3B6MFRzV2tWbGNFcEJSL25aOVJ2M3h6S2ZFY3dXSVB4N05M?=
 =?utf-8?B?Uy9YWnEwL0xOYzQyYVRmTnQyczFuQlIwd1QzaVVXNk5jYTVlVkJuMkdMQXhV?=
 =?utf-8?B?K2ZTS3BlWVc5ZHVVeUVNOHpzYThGOUZ0QmlzKzdQaktwUmkzRDhoS1kyYzJV?=
 =?utf-8?B?Z0VYRUtFWUhvY3FCbURzS3Q3eWpjaEQ5ZDdRQkJJWTRwdENVVTF3bVhLL0ND?=
 =?utf-8?B?MFNOTndVSFBVZ3I2eSt4ckJqaFJmdmdocVdzTDdiRndxNjgvSFBKL1Iwb04z?=
 =?utf-8?B?cG4xYTJyMXpqMEcyNGwwczhTTEtZUFRVcTA1SkJ1QlZRcDQySmpmeW9ZbExP?=
 =?utf-8?B?SzVQUzJvWFJyc0FZTWZXRUV1OWIzckpKWThLemJudUdtQ0xyT3RlWmkzRll6?=
 =?utf-8?B?YUc2WmRuRUl4cFYzZk9YOGg1b05VdFNpck8rVW5sY3VPb1Z5cEFMOXFTajlZ?=
 =?utf-8?B?dlhMNzkzaFdXVGU2WE9wWFBDYTN6RUxiWWxQb2lXRG9Pa092SFp5V1ZKeW9y?=
 =?utf-8?B?ZmRSVDRWR0QwdTAvTVErdVRpN0IzMThQQTFUdmZyM2VheDVvalBiNXVxZkwy?=
 =?utf-8?B?N2N1UzFpSlZtdWRNOFQ4T1RpMUhudlRabnEwRXM5d1M5NGQrYlNQMzRtOUlZ?=
 =?utf-8?B?UDlxZ0dtS2F1TXlrd01jNXFrS3ZlS0NYWjVDdEN6RGQzZnRYTzhVT3VrWGVj?=
 =?utf-8?B?c3RFUnhudVhURzFMc3lnQTR4aG9FdTJjWGVqdU1GdUNKcGtOemdFN2p3Vmt1?=
 =?utf-8?B?d3VQUnJTQ2Z1MVVLOVkwaFhSV1BySUxxdmJSczV2OWorM3JjMFU4SWZ0ZUdz?=
 =?utf-8?B?Y0tEaWNWcUx1UnAvZHNDcVgzbWptSlBTYU9FbTY4WGduRjFocEozbjhvd1FS?=
 =?utf-8?B?UTAvS1hOMUJMSC9QOHZaNVdXOURLcmozeVY0bjRnPT0=?=
X-Microsoft-Antispam-Message-Info: XbGLvUxN8mACCF3Onx/TWD0QUMy1jxgKoNX5Mp4wIA/mSkMk1bhjTOOrVD8RQxQSsK9oRtaP6XngcrsZrfB2AB4Llgv1lK2K+YZXRAwfSS4PYeuRVNgBI/JVxmS9pX1XgJWPiVdgm4JjOy6ITMBvsDUDO3uwBIbgf4D/uqTA34rRu58d+vGE7redRiwEo0T1
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:/EMHfTgcdAzBiTL3YHcNi2CZdvmT9qRJjOBjW7Mkszz8uqW7Ri/0FT5LljIEwgiXItYMVQqmRWG/oGEUI9u/O+ubo6xKBnkoi4NYS9tUqefj8OvoH9wQUcHVkh1Nz7jhFi/bADgcOpg9U7qJWHgEIf0Zk726Dc3kx0YrHYlCuOUSYEOgjSnF1o1dJptYbjZVst4Nxl+xnXnWozOfAIXzHdsNbEcgdd1l5sg3EsGGJEyTYPVx3HQ++j+Vc3xFyx2bROeZqf/QMaS7IUnIVvkML5kem0Hu4+MkapZvqn3IQUodEZqX9hPlvxahvDLBS71IMl2srgCUoA3Uzrvscd9p98hzwhmO+NoVbW2cuoQg8QQHv+yk5mCUtUbQtUq5XNNLu8tGUe48WfXjZTw7No8tNUFpdoOu6gyxVXTQoeidlzbZnLGXv7Q+qpTnnR40UrC9wGOsE/g21d0L7BW//X5ulA==;5:VW4m1EDkcfmm8xMyRicnfeWvFMsNFPQcVpU/wsPQdUc5DmWzZiJpMp70121ZNWojwMZBH+J87Yv3BeEg0/knSytNzfixtSD4J0+sI1h1yla0NAW3gz8Ur4knSEVyIz2VOg1VgJ1nNyiJ1FLDCXd+GCf7D1PRlgNhlUiZaXGKyxU=;24:AtSYCgw+6NEjRq1ThELHjLJPBQDirV0Btxa/cMcoRbuft6lNwQNMkR4isnrjjBWbTZuG1hKtOr2zcr7b82nmtSVAkQDJIqk56xplhf4IpMM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:K0mthkZQLr+Ub1DrKR0+1BQx5XLceadTNQTlAohVB3rNhcXRC+sVMS7iL5Y6hwNgI7vP/vt6AzH+IOmjKSMcvAok8ymcgaKiDyuIWqf4u+8mzI3rcbavx2kjqPzie7YtzmzFeoU1pV39BraziT3iunMUrkLJwQKkgjXPssOF0SQRmhC9ndJegqGTHHpzXNpUPVQLyq8wO+9KL3ANw2njwDhHogq/iWp769VVUsnasrko+4DdzS8EQPuuWk4H8DzC;20:gT33ga8G8UAFOznox3eM4ucUBm7sqEWAawuEA31BJRQVQUaIHHOvQsSkAOgO8ey95o+VEQoTFYQ//YVB6ee6gsEHGpr8cvUf627umhyN/dKdD0w3Btr9JYGhSHrmkbTKJSZjkpooYOmi853iKAsj93Bchwa3QkU0uVL2rkuv8/o=
X-MS-Office365-Filtering-Correlation-Id: 62ea24b8-74e8-4960-9b92-08d5befda730
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2018 09:31:36.8932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ea24b8-74e8-4960-9b92-08d5befda730
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.05.2018 10:55, Vladimir Davydov wrote:
> On Fri, May 18, 2018 at 11:43:42AM +0300, Kirill Tkhai wrote:
>> Introduce set_shrinker_bit() function to set shrinker-related
>> bit in memcg shrinker bitmap, and set the bit after the first
>> item is added and in case of reparenting destroyed memcg's items.
>>
>> This will allow next patch to make shrinkers be called only,
>> in case of they have charged objects at the moment, and
>> to improve shrink_slab() performance.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  include/linux/memcontrol.h |   14 ++++++++++++++
>>  mm/list_lru.c              |   22 ++++++++++++++++++++--
>>  2 files changed, 34 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index e51c6e953d7a..7ae1b94becf3 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -1275,6 +1275,18 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
>>  
>>  extern int memcg_expand_shrinker_maps(int new_id);
>>  
>> +static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
>> +					  int nid, int shrinker_id)
>> +{
> 
>> +	if (shrinker_id >= 0 && memcg && memcg != root_mem_cgroup) {
> 
> Nit: I'd remove these checks from this function and require the caller
> to check that shrinker_id >= 0 and memcg != NULL or root_mem_cgroup.
> See below how the call sites would look then.
> 
>> +		struct memcg_shrinker_map *map;
>> +
>> +		rcu_read_lock();
>> +		map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
>> +		set_bit(shrinker_id, map->map);
>> +		rcu_read_unlock();
>> +	}
>> +}
>>  #else
>>  #define for_each_memcg_cache_index(_idx)	\
>>  	for (; NULL; )
>> @@ -1297,6 +1309,8 @@ static inline void memcg_put_cache_ids(void)
>>  {
>>  }
>>  
>> +static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
>> +					  int nid, int shrinker_id) { }
>>  #endif /* CONFIG_MEMCG_KMEM */
>>  
>>  #endif /* _LINUX_MEMCONTROL_H */
>> diff --git a/mm/list_lru.c b/mm/list_lru.c
>> index cab8fad7f7e2..7df71ab0de1c 100644
>> --- a/mm/list_lru.c
>> +++ b/mm/list_lru.c
>> @@ -31,6 +31,11 @@ static void list_lru_unregister(struct list_lru *lru)
>>  	mutex_unlock(&list_lrus_mutex);
>>  }
>>  
>> +static int lru_shrinker_id(struct list_lru *lru)
>> +{
>> +	return lru->shrinker_id;
>> +}
>> +
>>  static inline bool list_lru_memcg_aware(struct list_lru *lru)
>>  {
>>  	/*
>> @@ -94,6 +99,11 @@ static void list_lru_unregister(struct list_lru *lru)
>>  {
>>  }
>>  
>> +static int lru_shrinker_id(struct list_lru *lru)
>> +{
>> +	return -1;
>> +}
>> +
>>  static inline bool list_lru_memcg_aware(struct list_lru *lru)
>>  {
>>  	return false;
>> @@ -119,13 +129,17 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
>>  {
>>  	int nid = page_to_nid(virt_to_page(item));
>>  	struct list_lru_node *nlru = &lru->node[nid];
>> +	struct mem_cgroup *memcg;
>>  	struct list_lru_one *l;
>>  
>>  	spin_lock(&nlru->lock);
>>  	if (list_empty(item)) {
>> -		l = list_lru_from_kmem(nlru, item, NULL);
>> +		l = list_lru_from_kmem(nlru, item, &memcg);
>>  		list_add_tail(item, &l->list);
>> -		l->nr_items++;
>> +		/* Set shrinker bit if the first element was added */
>> +		if (!l->nr_items++)
>> +			memcg_set_shrinker_bit(memcg, nid,
>> +					       lru_shrinker_id(lru));
> 
> This would turn into
> 
> 	if (!l->nr_items++ && memcg)
> 		memcg_set_shrinker_bit(memcg, nid, lru_shrinker_id(lru));
> 
> Note, you don't need to check that lru_shrinker_id(lru) is >= 0 here as
> the fact that memcg != NULL guarantees that. Also, memcg can't be
> root_mem_cgroup here as kmem objects allocated for the root cgroup go
> unaccounted.
> 
>>  		nlru->nr_items++;
>>  		spin_unlock(&nlru->lock);
>>  		return true;
>> @@ -520,6 +534,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
>>  	struct list_lru_node *nlru = &lru->node[nid];
>>  	int dst_idx = dst_memcg->kmemcg_id;
>>  	struct list_lru_one *src, *dst;
>> +	bool set;
>>  
>>  	/*
>>  	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
>> @@ -531,7 +546,10 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
>>  	dst = list_lru_from_memcg_idx(nlru, dst_idx);
>>  
>>  	list_splice_init(&src->list, &dst->list);
>> +	set = (!dst->nr_items && src->nr_items);
>>  	dst->nr_items += src->nr_items;
>> +	if (set)
>> +		memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
> 
> This would turn into
> 
> 	if (set && dst_idx >= 0)
> 		memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
> 
> Again, the shrinker is guaranteed to be memcg aware in this function and
> dst_memcg != NULL.
> 
> IMHO such a change would make the code a bit more straightforward.

IMHO, this makes the code less readable. Using single generic function with
generic check is easier, then using two different checks for different places.
Next a person, who will modify the logic, does not have to think about particulars
of strange checks in list_lru_add() and memcg_drain_list_lru_node(), if he/she
does not involved in the change of maps logic. Memory cgroup is already fell
into many corner cases, let's do not introduce them in new places.

>>  	src->nr_items = 0;
>>  
>>  	spin_unlock_irq(&nlru->lock);

Kirill

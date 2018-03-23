Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeCWPuF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:50:05 -0400
Received: from mail-db5eur01on0091.outbound.protection.outlook.com ([104.47.2.91]:30896
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751897AbeCWPuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:50:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 3/4] mm: Add free()
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
References: <20180322195819.24271-1-willy@infradead.org>
 <20180322195819.24271-4-willy@infradead.org>
 <6fd1bba1-e60c-e5b3-58be-52e991cda74f@virtuozzo.com>
 <20180323151421.GC5624@bombadil.infradead.org>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <e5805e2b-9076-0f0c-8d3f-5fdc1520861a@virtuozzo.com>
Date: Fri, 23 Mar 2018 18:49:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323151421.GC5624@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0202CA0008.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::18) To AM5PR0801MB1330.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd4c1e0c-62b3-48e4-c973-08d590d5ba6b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1330;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;3:HgA3OX24jP6PR0HSUoGiUe2jhlnZn2x8EWr6mowUJWSB56TD0j91J0lEBkICYgw+4wqyEvAYYBRdFlIHn/9HjMre4OPe4iryo15I6sWMKCAMrykwJFhMFmA4t1OemyecE71lrrudLHLVib24aN/JEOnDcO1Plv8wMXnRy+p1/YPu2Tzfu4+/r3+hT+0hl9PbXGwr+tbQQUB1m4gleNfFk0SAbz4U/EP7jBkeV9MQf8L0UyWFnzinYcyP3NU98Wxk;25:sRS0fXwcn5Af6iN9V1dEg9O1vCwEIt2RS2G1BEFFF5wgYJv4Xn1S+J3oe94EJooFXVS3hQyYpouAaTbiMWlqqK9AbEHensw2QU6MlVAUOkfkBbCkaIKH31sXgmyFSUCaY/qMitChhCwIwO29t8nScoAJaAe+B/JxFnL3nSB8EmwIztMJZAkKkX2lka/KHtaSazq+5ImweDYuUqnkEuKUdVCfYdmZyi52DVsVZxl0LXAAoi3STyj+K5kA+vWd4EYT1e/bYzS1zfUBxyq1ZOPxgTZkpGqFVNQvrPjIcL/DhD1oduPBsDBsDQLUb86TLxeFz+W5sRFjeuTdDHvyh8Hbkg==;31:4jltWBMCzQOyS24yjGNwUvXFB3AluWhvtwKlDQsWL5gpHwvq3RRcPzNPCAPbzwpDzM8RyxhC0/YyGL5GpIGjGQe5/oJFSM1SMVkSVJjW5Kmu2mMQcPGvJtJwgJg9Tw9ht0CyY/TrxcOav1Zvs1Qq2wU9UjE9GnjDJQB4ffpPiQliHTHRaBEQLZec8vmccZmXS/urLx0xDqanCZAdOUDHDqsM1SVo1nBd1GiEEJKy3Nc=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1330:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;20:5hyr/1L9ZBEe9ifdBLMYwV5SMYMwJ0WRZTjqAgKGtSiK8mtvfhoH83+4csxObF8vyBuDrK3E5gLtk6T83I4cfgQj0jxdcnQ+M8D/gdkkXvN6W4FSbnTWOyBdb1vAwJa/4ejsuU0jg3CV6lE/QyrybEVp6cqHp62Y45ZYwuRHgqq/rLSycsYsczkT4aVXxFGAh4LiPhdbIgX+K7IrNchYpol6rToFlmhUcwUhhcr8lz00F1Qjacv2BGF3aD1n3PNaW2VSO1NYNzwbMeKtv7n3OiR9f0QaV+T4s0xyMV9Gc1/Qm9ZMRcQHwgaeiyjXbWeDPSgdiGdKWLQEuA6JwCVp0PGJPs1IQsR1izk6dCwOcCHT/qJ0sMCQXfN7uJbib/YGnus/ULPMRJd3ZsMr4Wh5OBjKK0WO1/OeVP+pdHZyndMRuUHJ1WITx0ORB9ZVoh7ibHXscmj1gtyS43fymBja6McoFEHryXrDp+xDALTyTknBcBC3kAA4pvN+wM/FPJe8;4:ywU67gJlh5ik4gUinH3+3htdrzIMs8L8vBCEZw8xDFzMnfprV4aXb3HTLb0XKXgUuTY5wkNgohbPxF1QT1HxiCbHCJrnKxXsshAnU+gcRZjRVfORObdyVil/Ov42KtK9G1gRtyH4KEjaf/S8yvsuNoSLo6xJYHKzflfS8kO4EWW/lSEttK7AhzmcVWcB82zc+/U/tpz2mfsD4Q0/V+VruzcWqL6PGb+ZmW7gi1WemFdwnku/6O9HJ1uYaoKXzYWauMfIhpadCKaTEsKbjIsfJSwts7JflNbygQpSWgx6+cRk7Az9jEZavJeofXukQOD1
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13305278687FDC0026BFD380CDA80@AM5PR0801MB1330.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(21532816269658);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:AM5PR0801MB1330;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1330;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(376002)(346002)(396003)(39850400004)(366004)(199004)(189003)(31686004)(16526019)(186003)(305945005)(53936002)(25786009)(6486002)(7736002)(47776003)(86362001)(97736004)(106356001)(6666003)(8666007)(6246003)(11346002)(5660300001)(26005)(65956001)(77096007)(50466002)(55236004)(66066001)(6916009)(81156014)(2906002)(81166006)(23676004)(4326008)(386003)(229853002)(52146003)(2486003)(52116002)(65806001)(68736007)(64126003)(8676002)(31696002)(54906003)(93886005)(105586002)(58126008)(230700001)(65826007)(76176011)(3846002)(6116002)(316002)(478600001)(36756003)(59450400001)(446003)(53546011)(8936002)(16576012);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1330;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzA7MjM6VTZ3dHZjajU5aGc0b0ltdGNPTFZFcWta?=
 =?utf-8?B?SktmcXR3Q1pZV3NtYURiMnh4OEpmRjZ6Q3BGL1Y4cHUwaXJGc05vT0JGakY4?=
 =?utf-8?B?MGdka01BeWVaYWZLZFN2aVBmb1Z3dDRadytCeVl2bnZDOHNRc09tUTJXaEp1?=
 =?utf-8?B?V1JlbzZyMHk3NTlSZ0x4QU9zSEFsK0pVVnNMd3RvaXNIbmh1L2Z4SFdsalNE?=
 =?utf-8?B?SjlLWUZzZEhmWW8wd0VHYWZXM3BTTEp4UjA5Z3EzOS93ZGZDcmJuMUd6dS9Y?=
 =?utf-8?B?djdlcm8rKzRPQmQrdko1T3YrdmlKblprNEVVWmF4Vm8ySTdNdDd6NE1yN0JP?=
 =?utf-8?B?LzlvWWdNekdZQXRMNVpHTHVrbUR6YUFZZ3RaalRJSnRIQWU0a1RhQ3hYUGRM?=
 =?utf-8?B?L0NWWVN0dmNxb1dDVDVzZWZRczFsSFVaeEV2U0xpWEV1TzVVU05WYnl2VnpO?=
 =?utf-8?B?Wmh6TGw1V3hBSnlpZHN2STdDd29mSHRWOVJCV3drVkN3YkwvOHVtZjdrdDND?=
 =?utf-8?B?azJIYlBkRldqM3dtblgvNGNKTmhnViswbjFCeWhHL3prTDE2ZGM0UzdMRURM?=
 =?utf-8?B?VU9RNnhtMXJyeFhWdGowanlSbVV6aFBjWGFlSjBSVDAwWU82TnByZloyeXZB?=
 =?utf-8?B?TkVYUGFob0g1d3BNc0JjR2RMb1JjSUNyV1ByeGNHc1daQUVCUnlicDRkQjBG?=
 =?utf-8?B?Z25HWmEzbHdYZlE3bWg5L3kzNUhvUnRPYVhKZ0JIMzM5bmVTWkdZWjRlVks2?=
 =?utf-8?B?d0JMZ2JoaTRqOU5tVmFaUDh2d01XcEkwc2V4bGw1WUdoY0ZyN3FqeHlZd1RW?=
 =?utf-8?B?WEtFZkZLMVlhZ2Q2WGVQMW9FZHNkai9TY2VmZ2xpcWN2KzJWNDdLRmxzaGs2?=
 =?utf-8?B?TFJHYXliNnJCT01aQU0wZVhhajVzSkNsa3Fla3BvelhGai9EQ0FjZDBaT0pX?=
 =?utf-8?B?dDZTam40TVZDZ053aTI1SXhHanJIb0k0aVFNT1UxUHc0Yy9odGIrdzJvZG5r?=
 =?utf-8?B?V25CL0pvT2xDb0JRZDRyR29MV1ZsUUJRUGRCUjE1K2QyMmVJRGNpcDN1anNH?=
 =?utf-8?B?SkJvMHVvbUFwd0tBL25ZY2N1NWc3ZktEa1lSejlXa21WbU9xZkNqQnBwZkl3?=
 =?utf-8?B?UjViTXVlTC94TFZLeTdhOEc0S3VuSmFzSy9TWDBGd0xMbkhrdGxhN2RvTHZ6?=
 =?utf-8?B?MUxaVzQ2UU8wZEtDZGw4S2p1Y01pYnZCaWhOTnVwalVaMmM5SmozbXZuaEVn?=
 =?utf-8?B?VjFhaHpXYmJLQjhQeFcwT3dpZ1BQYzlmMmt1dG52ckZsWENNbHJEVjJobW80?=
 =?utf-8?B?Q0lVeUdRNUY4ZmlCRFdkVjNTaFVNcGYyRG5vYTR3Mk96OE50UTFjWGE4Vmxr?=
 =?utf-8?B?ZzNEUWd0QUpPcTNNRFlWdm5LR3FLWFdxQktzRVFrdFdoWWRzUHFrRGMrK3ZK?=
 =?utf-8?B?ZEhmQ1pIREttdVpXMi85ZlBDanYxenNxc3ZxeGZSUjZjYk9GZXRTNEhEK3BO?=
 =?utf-8?B?YjBUWGRMay9CczFzNVRWM042UnlmbGtqNnNCS2FGOGdFOW85SThCTFVpVXo2?=
 =?utf-8?B?ejNYSWRFRGRUdG10enBqYWd2bFBRNHYrNml4cGc0NThWeDFXSW0xbUVobXpO?=
 =?utf-8?B?S3QybzZVUThYa3QzVlVZYVhMWEVGdUdWYzhBMndObzVEZjhRQm85TEozZXJI?=
 =?utf-8?B?SWRTTlRtQzNVbzZWMDlxYnA4S3QyR0x6VDNjak55RGp6dHhiaExWZ1BUSnl3?=
 =?utf-8?B?UnB3V3pqMi9WTVRoTnRFR09qUG1EYnlrUmd3RXhLUXFFMzdKeUhkYlFERmtj?=
 =?utf-8?B?SDhtZGVyb1o1bzgzMkJ4bXJqN0FrdUhza3ZZRGZ1amlpUGYrOFF4ckJlZEx4?=
 =?utf-8?B?YU1qNERrTFkvdkhiUUxlYTNIOW9PdEZhQ3JydENpRXJ1cEpUWEZua1duV0t1?=
 =?utf-8?B?RFoydVRtZXNnQXRZcm4xaTFGSm5nb0RhcGVmU3lQaXdFRHl6TnpQYTlIcU14?=
 =?utf-8?Q?a7T+RER8?=
X-Microsoft-Antispam-Message-Info: 3qo3VVqJxlapkHo/jLjkFS858lCWrCbFQmkCx+mEz0C33BdxMnZ+QpIbhd9WHUOdpjJ+hzJTP3dL+h96MSnDvmmWwMETqhDY2J71+jscdeRNK9/uC8g2IRVZqSL197Tuz1hC6GiAo0jmWHbHWAoqHcIY//dbOq4X5qyfRXQLkNgkjcNbvO8A9aEopyFC7AcG
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;6:w4QGNTVZYleTJUiL/0ffen/Oel1cMISBbgVEGBRKiSh/K9DThMNv1ev3BHLDkU0ltewgWNHcbVX6Xm4pSXYuv6enBhmZ0UHgmrk3YvYQihRRcJWkPCOICs4jJlYw5UbUigZ4TJ25vXPycsjCViBrc7/uVNnCetdnWxdnAS7vavfXjDaHrSL/KfdUb039bgopYp+OQk2DInEjjj2ksQ1JtWtJYnvXsy1i5heZG/DbWMJfrEC9KM0JEwZ83FPqlVeHCMStfJZgBflIS0m+dnYcuvLFRTzSStfAkkW9cRx7+VSNJDqGGgWzTmiAnzGTfx+DnkJDS3XkzO9EcbM2op8BZa9kHQO2ddQCbkqrOtvNftUZ62mOIRYwFOy/LrvEQJN8b4MCEutvdkhc2Cl8MC4rTHdEm8oL3jJutzcsjmq1Jygg/AFZmkkAamLoKmXkp0h4mitnpOJc/v+azaj87nBr3g==;5:yDb5aLyqBLlUsyMG41ESohpQprqf1oYM7QihLkCKjfwkXQcAcWnzDDfJQ9Tne5gNrQFk8IhshBYy3YGpuVepud9osRmw4pLwkX75N/Fz/dJgyFPDEie8z0vl72JYOqtR4GCyjAcDDJ5cAEZHxJYPGEdY5AU9a80k5QntkCJ4Yek=;24:rS6nizC85NsgFe2E6QU2Fd9BE/Ff9haWO6sszVnvXq+xpS73X9TM98HivVCVrfp1D8xCM7aB3zNKCs9BZhG/15FgqxkkmLljTPOClMy3m04=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;7:4GLjEEsByZ/nmUOzRCSpZIVN6ZSDIKHMEnawWPJKPS221Y7qVkjJ+dHF6r6keuZwzF5oehJ3V6pXhyvoBoE68rNq5P5wR0RL1B8zrEOX3X6ULxPtQjB5o5zVQ7tDa1/LGVA2NUmDa3YKigJ1btlqRUfEk5nfaYAk1DhiB3i3zuDdJttalKZrNfC391Md2+P8tYbp+NfpJ4UjuiW1gHgipAJOkChC1jR6CQuGgMGXAQOnKZzELY70yOcfhv9MN8X3;20:LlF/n2qkqzbOb7WUYi2i0qE3WzM7TmX54kHmP019IkAsmD6EeeQD+CMRTqhsakM9bhTVv0s6jLKMukfHnbaMRNWUgb+02Y3DKd4UCU61xAR6cwBRYS0kZJz3PmgtmBQwL5C6QKDLRuTPPLVsu2yuSfm2XLf5Iz2YZhE4nsQvCy4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 15:49:56.8477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4c1e0c-62b3-48e4-c973-08d590d5ba6b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1330
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.2018 18:14, Matthew Wilcox wrote:
> On Fri, Mar 23, 2018 at 04:33:24PM +0300, Kirill Tkhai wrote:
>>> +	page = virt_to_head_page(ptr);
>>> +	if (likely(PageSlab(page)))
>>> +		return kmem_cache_free(page->slab_cache, (void *)ptr);
>>
>> It seems slab_cache is not generic for all types of slabs. SLOB does not care about it:
> 
> Oof.  I was sure I checked that.  You're quite right that it doesn't ...
> this should fix that problem:
> 
> diff --git a/mm/slob.c b/mm/slob.c
> index 623e8a5c46ce..96339420c6fc 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -266,7 +266,7 @@ static void *slob_page_alloc(struct page *sp, size_t size, int align)
>  /*
>   * slob_alloc: entry point into the slob allocator.
>   */
> -static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
> +static void *slob_alloc(size_t size, gfp_t gfp, int align, int node, void *c)
>  {
>  	struct page *sp;
>  	struct list_head *prev;
> @@ -324,6 +324,7 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
>  		sp->units = SLOB_UNITS(PAGE_SIZE);
>  		sp->freelist = b;
>  		INIT_LIST_HEAD(&sp->lru);
> +		sp->slab_cache = c;
>  		set_slob(b, SLOB_UNITS(PAGE_SIZE), b + SLOB_UNITS(PAGE_SIZE));
>  		set_slob_page_free(sp, slob_list);
>  		b = slob_page_alloc(sp, size, align);
> @@ -440,7 +441,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
>  		if (!size)
>  			return ZERO_SIZE_PTR;
>  
> -		m = slob_alloc(size + align, gfp, align, node);
> +		m = slob_alloc(size + align, gfp, align, node, NULL);
>  
>  		if (!m)
>  			return NULL;
> @@ -544,7 +545,7 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
>  	fs_reclaim_release(flags);
>  
>  	if (c->size < PAGE_SIZE) {
> -		b = slob_alloc(c->size, flags, c->align, node);
> +		b = slob_alloc(c->size, flags, c->align, node, c);
>  		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
>  					    SLOB_UNITS(c->size) * SLOB_UNIT,
>  					    flags, node);
> @@ -600,6 +601,8 @@ static void kmem_rcu_free(struct rcu_head *head)
>  
>  void kmem_cache_free(struct kmem_cache *c, void *b)
>  {
> +	if (!c)
> +		return kfree(b);
>  	kmemleak_free_recursive(b, c->flags);
>  	if (unlikely(c->flags & SLAB_TYPESAFE_BY_RCU)) {
>  		struct slob_rcu *slob_rcu;
> 
>> Also, using kmem_cache_free() for kmalloc()'ed memory will connect them hardly,
>> and this may be difficult to maintain in the future.
> 
> I think the win from being able to delete all the little RCU callbacks
> that just do a kmem_cache_free() is big enough to outweigh the
> disadvantage of forcing slab allocators to support kmem_cache_free()
> working on kmalloced memory.
> 
>> One more thing, there is
>> some kasan checks on the main way of kfree(), and there is no guarantee they
>> reflected in kmem_cache_free() identical.
> 
> Which function are you talking about here?
> 
> slub calls slab_free() for both kfree() and kmem_cache_free().
> slab calls __cache_free() for both kfree() and kmem_cache_free().
> Each of them do their kasan handling in the called function.

Maybe not KASAN, I never dived deeply into sl[*]b. But they look like
just three different functions, doing different actions...

Kirill

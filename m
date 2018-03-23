Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbeCWNde (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 09:33:34 -0400
Received: from mail-eopbgr10139.outbound.protection.outlook.com ([40.107.1.139]:33292
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752169AbeCWNdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 09:33:32 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 3/4] mm: Add free()
To: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
References: <20180322195819.24271-1-willy@infradead.org>
 <20180322195819.24271-4-willy@infradead.org>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <6fd1bba1-e60c-e5b3-58be-52e991cda74f@virtuozzo.com>
Date: Fri, 23 Mar 2018 16:33:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322195819.24271-4-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0102CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::20) To DB6PR0801MB1336.eurprd08.prod.outlook.com
 (2603:10a6:4:b::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0de5cd6-1082-40bd-d83f-08d590c2a9eb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1336;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;3:6IuGx3adY2kz68+FNf2uu3ZCrZSZFrpwKNsL76o0F5QpxP1tk+bOsoHFBYSXvXdKUzmxyqPg/yDw/mu6m348LoihymJ7YT+WEOs+sf+aWs+yR+5tWGZvCXriZbwer7zZdPHBUDdHH+M363jgw8Rv83iJC6nhobEeOb696iU2Ojk4GNXF8Udduf4Id/1LE9wP9tMWqv24op0eR4Vc4JQlJntl2zDNH18qO1lnVuzTzN7xE8st4npEXKfbMPtAYsQf;25:qJSg8HdDUpN4H09OfffY2OPp+9MDIMtQ1nKiQXqanWNJOXWDe+Z4qYfFd6w1SGdM51J/3WiNk5qHJYx43RMZ7X0EiD2pr/3zv79tE1c6mSR0VYwxwhkZUCHsoerklWrg6j1kkQDt/vZU/tjnycpWEqKwzQcq+T0+nf3c7ddpKrEwzLXM/VmgOXLF7TCHcHjod/012B6IfsFWyflK8+9wCsWNYvKoKKJagWDOONAX7CUvmHcvrR42mrhqQWp3nHARMbcOAg58ShswpgUzJv1AuCwCyPepKphDY1Kj9DWS3YFwPhyIrj3GX4yGakKSQP6HdPOdTCjbQ0lDfJI5arTSjQ==;31:tG0/vnOw/v+R/Kd80wM2UspXCZJoiNgE+ZcdnvCCW22RFtiloCCcMgbzV8OguM1EZPdV72Ecpr8GgIJJwKEDcq+TEEhj3LlQkNgGlT8Xm2rHF4K/FjIgTK4fkLZqbUHno5CO16ehkuTbWOPmYx+ZoeEfHp8fTHUSO+FpEJ1IhFQBwaoim8QRzr51wYgPALn4rH9+X8iQz4Tju+x4ZUUbzoHDbAyknVC8w8goCBzgj1Y=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1336:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;20:uqSMNyCbZw65Ehp0K7y/Q+7VGqBaZsaxDgSxRJBAluewCiaj3NWkjHB4kfLePUDy3PB0WQ9x9jCvMYiGa9taJYS9fB9lTDCvzkG8sY87zH7awZ2lE2LUK8DOOLh/yky/n+Mfx8zHfrzNFoUcrZj003R0wXcckLhRquU524dzy/G94TdPi43JSjQyT72yUW1pZoph91tKe4ejmr9V0Of/KeC0RQR2vDHm1ecNWQD4YebnkjBni+w7xiUi8aBpSLvUVyMeVJcu/2dBVuQPW496MZavpkfej8f/dEtxABEuYduNWVYbh4sr5K4YSfVg/IOlhj7GPieFSVYQn25CFFmNc8MF8FGWPtinTiFJ6MfytFTdPnzjkZsolfP/kLcGszaZqd9Lv1MphYNYXQgQ38ZY8u0ugnVfouJgXVbKxIUuj8WP9O85KjTMEk3msgH7+BtG5MWiVOqZA9+p+WqVsOpuwpfssRUjSfAq60SPjCsFQExK3ZxsvVHbZNNQYbnouPTg;4:Pm+ZjKLMKE5fLs2rN4pDBFhfQP6MMuc4XEtJ3EP4Ao/AzlJXoD4dretfYriOJlC3zi38aCOs34mEovHc2oxL0ly4nDagYLqCcOehNjGbMAuFjDIZlwqivnJV16GALB/1xmLUS4iNgDL+ohygb8JWoippEfTqafQC8ejBuM4MuWMtaAPC7TMJyGR8Sqy/y0/prGdl3YzBmAaif8xM3aGJezowSjzcXZSiv2OUM8ZK/49tHL89ilgvduy7cAHjFhS0fCP8Lzk3hUWaZdk4FeM1wS/gKGZtLBiG7G6D2EVRo4WTG25sdCecIgxztlXfyZGmEVKUCryXFN/1q5NJy5P5ynU2GoRyQG0Xjreu+Okqjf1YUCs3iticxrageHDbl6G2
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13362CB257E4DB0B47C2F18BCDA80@DB6PR0801MB1336.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171)(21532816269658);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DB6PR0801MB1336;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1336;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(346002)(376002)(39850400004)(396003)(366004)(189003)(199004)(66066001)(55236004)(2486003)(23676004)(53936002)(36756003)(478600001)(229853002)(316002)(5660300001)(6116002)(47776003)(86362001)(3846002)(106356001)(105586002)(59450400001)(6246003)(2906002)(305945005)(68736007)(52116002)(31696002)(16576012)(7736002)(65826007)(76176011)(65806001)(65956001)(584604001)(52146003)(6666003)(386003)(446003)(8676002)(8936002)(53546011)(81156014)(77096007)(81166006)(58126008)(25786009)(54906003)(26005)(4326008)(45080400002)(97736004)(64126003)(50466002)(31686004)(6486002)(8666007)(16526019)(186003)(230700001)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1336;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzY7MjM6MzlNRXJIZ0dFMnhZOXg0eGhVbVRUMjZj?=
 =?utf-8?B?NVlBaXRXZ1dwUGVqZW9xK3dGUUYxV1pGMVNCTUtZWm1vdGZWVUdtUkNKVFkv?=
 =?utf-8?B?OHgvVWpScGxhRG5iWW5lVHBhQlFUc2RQcVRaR1UvdHRBU3NMd3I0cmg3TG5R?=
 =?utf-8?B?Q2xuZHdjWUpkRDVtZ3RSREltZ3dwbldZWmIwbWtPck5hajhWU2FQaGNRZ2dD?=
 =?utf-8?B?cDRydnFYcG5sRm5MVEpTWDdIWnRQSTNnVFIxWk1kUkd3Y04xNnNoVlNSL0VJ?=
 =?utf-8?B?czcrYStHVXc5UWIyUk9RdUY5ZDFOS3dWQ2VpbURac3BIbklVeXY5V2puekpa?=
 =?utf-8?B?OHQ2OTZUeFFGUmZCQXRLY3pFWGszK2xnY3ZwcFVwalp3NWdSNUkvcFB4M25N?=
 =?utf-8?B?dWdTMGF1Um45M2EvTk1aSnZDLzZ2V3lJL0lYUXUwMFhqdnM0TkZXeWQ3eDVG?=
 =?utf-8?B?S3k2OXNmMnVNeDdLNnFPaHhCTjJaVXhnYlJaRmY1a1lVOVZtK21MMWtXR1Yy?=
 =?utf-8?B?cU13aGsrRjRndlVQb1JEeVdIeHF1eGJoVXFFdjVHbGxramhaNFd5M0EwYXp5?=
 =?utf-8?B?U1NCb3NRZXJyL2JWbGwrQmhQSGZhS2NBYXVzd1BYY2VRRENad3JnQVdFL01i?=
 =?utf-8?B?SXZiNThOd1RTaFlwK01id2tXUGtsVnlSZkhrN3o1eWt2TS8yVk5iNE5YTHpW?=
 =?utf-8?B?aGJJYnJQaGhsYmRpUlpwaXUwelFBTzduVmJrL3dYRHhqR085bnRtNnpVcmZh?=
 =?utf-8?B?cDY5ZkxKbWgvNDdkNWtaYVltMmNNaEc5SFhnSUVVNXhUMmExNm1kaHAwMFJt?=
 =?utf-8?B?djMrZHVFTVdtUkxIVEZRNWdaWDFnOElFVEEzQVF0ZFdkOVlzTTFsdVVNMFZq?=
 =?utf-8?B?aHZpZkV5ZzBkaWxOU21WOVVLaG9heU9jSkhQY0NrRHphRkVqQ1M1SjZWMXhx?=
 =?utf-8?B?UXU5VHcwYW5hV0NsRWt5ZEo3eVlaeE1RLzZxTXcwWFBhVFE2dmNlVFhKbEVx?=
 =?utf-8?B?V2g5UXJTYzg5NlBZYk1VeUlpb0pPUDF4OC9YcCtyRS9GZTVlczhzRytXbHpC?=
 =?utf-8?B?dmlNcktYbjllM244dGMxY2ZOMDJjdmt3QWJtN1g2OVdISWNSbnJqMUU0OFZy?=
 =?utf-8?B?U0t3aGV2ZXZGQ2VGMXNPdnhDRUZMYzh2N3FUc2o1ejBWNHhPNUV0Nm13ZTJZ?=
 =?utf-8?B?NmhzOWxCNmMrZlhLaWJnQjRGcnJKTjJacmVySjdOV1NaZ0dqeVRCVTdqZ1hQ?=
 =?utf-8?B?bEtzTWtZWm8zWDJvaGRJLzdndVJDOE1OeVFhN3BZRGYweExkaHU1YjcvbVJW?=
 =?utf-8?B?cDU5bGZHTkxwOXZOc0tNNDA1MjNPVmtCd1IzcnJOaEozNnJDMHRKVjJBVmRE?=
 =?utf-8?B?cXBPVnhBVG5uS2tqWnprV1J3alB6Wnk3OFRjbWZDTnlVSE5aaEMxa0VUUStN?=
 =?utf-8?B?RWVONk8zRVBrcGozWHJjem1tSzh1TDdOQVVvZnlYRi91WFY1UVJFN2YyZ2hC?=
 =?utf-8?B?ME1OOWxyK1ZiSmpoZnQ1WTI4aW81bUlxeVBPZ3BmeDhvNmJjSWt4U1J2Z1FH?=
 =?utf-8?B?Y3NmRkFpZXlSWDhVT3NpNWNYcE5uZ3FTdHhvYkppTlJRdDFGb0E0UmRPSnVv?=
 =?utf-8?B?bURuRFNMTGk4TnVnREtIbEo2Uk96MTJteThEQUx6d0U5b09taXc3NnRoM0sx?=
 =?utf-8?B?V0FqVnU1WUdZSHIxVkFBbEloV1pLSmlVVUprSGR6SWtFZ2IzUVVjNnVhcGF3?=
 =?utf-8?B?SnNqMk1TdnpQSFd0WkZGWWJKR2dzQ3dENVFhcjh4TWdxeU9OVUJmM2JHNXhs?=
 =?utf-8?B?dEp3QWlvajlkRytkYWUrcWtDQVhzWFZvOENKdDIrK2dhTlZheDFTS0FUbkVP?=
 =?utf-8?B?dU82eDBJczlWOGgwYjlzM2hjVmxSeUt5TlRJellma25lVjZMVFdUSHlHNmpk?=
 =?utf-8?B?OU9WWHJJaFFYeW92VVZ0Wit0UnBOcUtqVWk5dE9yK2lyd1BxV1RtUThobm5K?=
 =?utf-8?Q?4++x8/sY?=
X-Microsoft-Antispam-Message-Info: I0w6Ae8qPtkVmBjeT6DxiBD8LeBdyvICKI6lS8xBrwKwsB0fCIxZOM6FQPHM7BnSRCjdJ2xngptXPZkSUxPs7wNzY0U27E3IVA52Uglwu8nxcA5iwddapgfCOQ1Dv6Bs/Ti2FR1SIqCbabgVMbrsijVkv2hxzgdbQGgoIoYf9ewxS3bNFauHqwR3EimfBdt1
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;6:EdtMyI+hFBR0xwcJuG34h4czNR2DGoiT9QpFhbCZX/w4+d4JOU/3IwPy6wmqpp5/gkuA606OzLINMMQxIAESJ0qJyqg+SF6eoDFasfDLpqjZVhqkDAJE2h77r+9rH0xgI20uHFMHoiT/WvvsKz9M4o+sKVCTjkPii0+NJSmFdACCzrMksb76UB8aM4Ynu4QEyuS9RphrE2FCPKZpS3ZL9god848ZF6+ld2N8DS4aBRtDkj6OUEMihr2HsV0flBeUDZVM3uFpgJ3Wn0LbdwiMVHtNr+/pO61bhsue4hWQ+FO4lbJNplTa52N+Tv89djJyZc3xcwQTHRs+2HRwmxvZz9IfF0TfQPX9b6N+GIb+5fyW/0TdhqzRNJnD+XG/NmkcuG69KwaUS2C7QMxh9JVKUc8CytKvgBGA8gQdw2VIgsYJ6iniRiARpR8/HHr5Qgb8IzrFi0im7z+CS6p9h+ehng==;5:Ch+tGTD4V8+ZqRYQ6xiUg44Z2MJmoruqposYGvpY94GBUfNZBYMQL8AhGb1qvuZLZ4+pCr4pErjwjHMfIky5dGXEee5d3cG2IN9M4xs9Wd1LqXG445r4xOsc5p0zhX5zNjKtoamECSCA9Zvtlnw39qZ4opRIMYCk3Vq/z380vu0=;24:ZIO6P20fRqn1YkczcAWpCbJHVreND1NMnkUAL6jacDZmMSBzdTiL0xYlXWoCOs3rftkPWgXI9UcdniYlvDpd8gC3f7DOMV2Q6tVSsdZjTFs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;7:OCQMQTg1L6Hln/AJ64dbuiwaJ7LarmpINdUZRL4N3kzJ1rS7A9nWdkHOJF3QVsfWHMLegIBb2jFBd9JhpCpfQdoyiion7YgOzeyYpiqMma8odx7HjrfNb+eiPgFh0MXtxcOXQIZc9QjHcFHFVeajrO9VRJo3ZIrTnUcj8qHourMeYY7QqAn7QmKyujwF4aRDM5iPbLe3ewlmCu5rEBa5+GJJiReL2XlKYw5BxFgU4U3+ZtMSEFdTiN4nULhDt+mN;20:bqk+MrcRGI+N0M5Z2thOtwhaOLbUOV0amKTqA+6y8RbV8bGVSCdzl/xVcBsYNDs+R177U9rV7Ip+iLAT2iXob/7fJ+cXVy+qXjEt8Ltl8wZXg4QKp8YQLR1qPfyJy2/byC6+CYUvJ6p2EDHmbqpxri89xrzERwiMxxXCvEGk1GU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 13:33:28.6185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0de5cd6-1082-40bd-d83f-08d590c2a9eb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1336
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthew,

On 22.03.2018 22:58, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> free() can free many different kinds of memory.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>  include/linux/kernel.h |  2 ++
>  mm/util.c              | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 3fd291503576..8bb578938e65 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -933,6 +933,8 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
>  			 "pointer type mismatch in container_of()");	\
>  	((type *)(__mptr - offsetof(type, member))); })
>  
> +void free(const void *);
> +
>  /* Rebuild everything on CONFIG_FTRACE_MCOUNT_RECORD */
>  #ifdef CONFIG_FTRACE_MCOUNT_RECORD
>  # define REBUILD_DUE_TO_FTRACE_MCOUNT_RECORD
> diff --git a/mm/util.c b/mm/util.c
> index dc4c7b551aaf..8aa2071059b0 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -26,6 +26,45 @@ static inline int is_kernel_rodata(unsigned long addr)
>  		addr < (unsigned long)__end_rodata;
>  }
>  
> +/**
> + * free() - Free memory
> + * @ptr: Pointer to memory
> + *
> + * This function can free almost any type of memory.  It can safely be
> + * called on:
> + * * NULL pointers.
> + * * Pointers to read-only data (will do nothing).
> + * * Pointers to memory allocated from kmalloc().
> + * * Pointers to memory allocated from kmem_cache_alloc().
> + * * Pointers to memory allocated from vmalloc().
> + * * Pointers to memory allocated from alloc_percpu().
> + * * Pointers to memory allocated from __get_free_pages().
> + * * Pointers to memory allocated from page_frag_alloc().
> + *
> + * It cannot free memory allocated by dma_pool_alloc() or dma_alloc_coherent().
> + */
> +void free(const void *ptr)
> +{
> +	struct page *page;
> +
> +	if (unlikely(ZERO_OR_NULL_PTR(ptr)))
> +		return;
> +	if (is_kernel_rodata((unsigned long)ptr))
> +		return;
> +
> +	page = virt_to_head_page(ptr);
> +	if (likely(PageSlab(page)))
> +		return kmem_cache_free(page->slab_cache, (void *)ptr);

It seems slab_cache is not generic for all types of slabs. SLOB does not care about it:

~/linux-next$ git grep -w slab_cache mm include | grep -v kasan
include/linux/mm.h:	 * slab code uses page->slab_cache, which share storage with page->ptl.
include/linux/mm_types.h:		struct kmem_cache *slab_cache;	/* SL[AU]B: Pointer to slab */
mm/slab.c:	return page->slab_cache;
mm/slab.c:	cachep = page->slab_cache;
mm/slab.c:	page->slab_cache = cache;
mm/slab.c:	cachep = page->slab_cache;
mm/slab.h:	cachep = page->slab_cache;
mm/slub.c:	if (unlikely(s != page->slab_cache)) {
mm/slub.c:		} else if (!page->slab_cache) {
mm/slub.c:	page->slab_cache = s;
mm/slub.c:	__free_slab(page->slab_cache, page);
mm/slub.c:		df->s = page->slab_cache;
mm/slub.c:	s = page->slab_cache;
mm/slub.c:	return slab_ksize(page->slab_cache);
mm/slub.c:	slab_free(page->slab_cache, page, object, NULL, 1, _RET_IP_);
mm/slub.c:			p->slab_cache = s;
mm/slub.c:			p->slab_cache = s;

Also, using kmem_cache_free() for kmalloc()'ed memory will connect them hardly,
and this may be difficult to maintain in the future. One more thing, there is
some kasan checks on the main way of kfree(), and there is no guarantee they
reflected in kmem_cache_free() identical.

Maybe, we will use kfree() for now, and skip kmemcache free() support? If there is
no different way to differ kmemcache memory from kmalloc()'ed memory, of course.

Kirill

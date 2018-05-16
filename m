Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbeEPQp5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 12:45:57 -0400
Received: from mail-eopbgr40116.outbound.protection.outlook.com ([40.107.4.116]:24832
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750759AbeEPQpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 12:45:55 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH] lib/stackdepot.c: use a non-instrumented version of
 memcpy()
To: Alexander Potapenko <glider@google.com>, akpm@linux-foundation.org,
        dvyukov@google.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20180516153434.24479-1-glider@google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <f8a737c1-8cb9-15e1-2d98-454a4cafc1ed@virtuozzo.com>
Date: Wed, 16 May 2018 19:47:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516153434.24479-1-glider@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0701CA0075.eurprd07.prod.outlook.com
 (2603:10a6:3:64::19) To AM0PR08MB3249.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::18)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3249;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;3:39wV8Du/sy/VTIEL6W830v9Hkj1+QSxhgmoWlfTtqDnhMQyyvo+kxnrsFBqs2gt0I+XR+Q1dDYEYIgSFx78sID7VWn0oVt8P9ZeAyFyWXS0dWRATbMyGvceVVBwVw/UmPQqcUIAAr8eZs9+PLfURtEibBf0Po0pkaDLSxo3Z4m1ibFUiDt2CFBzbF4yp+uGZekbqoTNuDBPfDzGcPxxAQmuuu7VLbjz9LQMd/0PGcbeQSfftDN8CfvvAJGSM35z1;25:DfQb9LSSz79W4BdMdBgJ//uiTZDR9PIA8L4+4YWQYhD2pBTVus9f0gMVp8Zi/38AZS8dP/3L4j4cP0nJWdqHC3mjXlIaohHM0mB3L4fZXb6M1fmx7PW1JAT+sJlNxKJLxo7/yf3LAg5yq8GgDOCFDJWQOd57igNXvdzouqvo6WuPns2ZRQCPzn6vrOgSWF51G7pzDAWAsOAc2/+rsuCXqcZNbfGHR3UdglaqzR+BPmOAFTR3zZEu6+foz4cvLP4FeeE+gBrTYQG3lzZeSlpVL1eqLt9WVdAXAPcu916FXJI3YOn/nbu2aPHDtIwfTeZKOLZYZ8b2FRiUkpquwzdWhg==;31:vF5UEXxRjUQI0qqM/AXRePvnG7jK39V/ActFBzcDM40g9+/1MRZ6uZbptMXfpMuU1NA7NnPAOWjz3JF3XpNKCbkIlyGZPK1N0sfLWunfAPrlN66MtuUTrEIxDSSsyGgI373dYdSneEGfJelleSgL4qsZmC4OicYjMbcqo3xUhMQdNMd04Y/thmBzTnIHPiJbE6CxKvjZeMOf2V2pzP1FNCIVRQ1z+CCTEn8Oc7D3geI=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3249:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;20:V9zRDUlSqlvSYUINRkGvZyBXpzXcn1QF8vPk1KTPHX++Up4SI2WbV8MVStXFQKsfhNxzFMOJcSk+P/42TXXbYWvlKWw8f3G2W+VwKm/5wt4RF9khPRlxv5gMB8uN9fxdfq19O30B4c93x+vB5Eb/XU3Ur9JLkhB0UgOjncj3r20DasubJETH/y2cebKAUCwGc+5d6eSg+xLeBbRJzEZWd0e0CkYSz15DQegSB8L2+IqaMZdEswgIO2RKwUVx9oEI7y8Y+/i2ZeMans0QKMEzT8mUbNjBmrQiTEfNsMh5zpgiX+w+0sa7D+7KQ/tIglfqmTJtGRD/pcUnNsAuBwog2WevV9ScZOmcY3SyNSmMUvgs+CTchrZI8g966tPaeMPmyd+uQsBSQ4SVyYZ3wLZlgq5KhqbMrH3qFRSjX1X0NWeCUrLXhS/7Qi73nv4oDQ9WvTXk4SV8GdaCB1PZZhT66aMSxKcsJrhJib8qWXUdoP95T7n5OiIk/DMLRwTInRwL;4:5+aEMxa126+64uCmIHAnzib+Q6VgEoYYVpfRjr7lXEXfZoUqa5tL/XlwTIJrm00t3UFQ+tw856ahOcLpaBn5fQJm8su7TUlBS2W74Urgez3tv0Svx88WnPRW+Sbr7wum2+7GeLhVNQ5BVNukR8rWjCDz6LrYWHDPienEtSI0d7uwsB5RkamK6eoV73kJNIi2lB5zqiuM9sUJGCFyAMgUreN9S7AIwUIgIquQAgek7X4SoC55KNfIKogKtkxHd70NN2hgXPUez9StfqDvhTvf0v/jC5+eze0YUhp3qJho9Gh/z2YYiWwovibmuaXYrMN1Ca6JAjDzluyDShAEkbHFKo5tYCUhZGU1JD/bdFSPrGY=
X-Microsoft-Antispam-PRVS: <AM0PR08MB3249F60FD6B8D7A5246A7341B0920@AM0PR08MB3249.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM0PR08MB3249;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3249;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39380400002)(396003)(366004)(39850400004)(346002)(199004)(189003)(8676002)(52116002)(105586002)(97736004)(229853002)(7736002)(6246003)(2486003)(52146003)(23676004)(55236004)(58126008)(386003)(16576012)(53546011)(4326008)(6116002)(3846002)(76176011)(186003)(59450400001)(26005)(81166006)(230700001)(8936002)(77096007)(316002)(53936002)(16526019)(81156014)(6666003)(65956001)(65806001)(478600001)(68736007)(66066001)(2906002)(47776003)(64126003)(446003)(25786009)(86362001)(2616005)(476003)(50466002)(36756003)(486006)(106356001)(6486002)(31686004)(31696002)(305945005)(956004)(65826007)(5660300001)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3249;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMjQ5OzIzOmxZeTdEaTJscXJuR3pnZ2VoNWFhR0FweGVG?=
 =?utf-8?B?V1paeVRISy9MUzdHdU5mTWlYTWVYQnRtY2pncmxVWDErcEdZRGpCYm8zRkVy?=
 =?utf-8?B?NFhEd3JycG5ENU0yZHZHMFU3T2luOFJ0UkhhRFdYcnAvTVliRVpEZngrditK?=
 =?utf-8?B?TGJOcnBkZlVGUitGL091VGR4UXhOY1JOYnQzSW9mTVNHTVJoaGQ3Umo0WEQx?=
 =?utf-8?B?NVJEYkhwaThCbTQyZlM1NFRnSWxyVUgzS2hpVE1GbHFZUVU5WGJQU1JmUEo1?=
 =?utf-8?B?TVA0MVdYT3I3U2hWYmlXa3RUSFJZYnlscTFIK0Z1NW5YQXFleGRlNWRYV24z?=
 =?utf-8?B?eS9KRzhzc3ZDQ0tvaWpFV3QyOVBqRExTdW1OY284Nm1iT09LaVJhSVRXWDEx?=
 =?utf-8?B?TjZ5MEVJRi8yamxUV0JlWVdoVWwxcUpQQmtiaGdjZDBFQndwSHYxZEVpL3Fm?=
 =?utf-8?B?cE4reDFiYmVEQWVOWVN3ZkVvWGhoZkZTWGp5RS9CUklrWi84b0Y1QUZBbld6?=
 =?utf-8?B?bzZiaE1tNk5RREZaSWFtZE9HSEdyYXhWd3l0SWlScy9sQlI0SHFpb0FzRnZD?=
 =?utf-8?B?b3Q5TEozczhQQXIzU1pkSkNnTEk3NmJsTjBDRUNqbHFNc0pSWGkyK0t4WDRC?=
 =?utf-8?B?cGU4azlKcitBVlhBVXVUYUtBd0cwWXhGSi85aFIvZkVHUXVMalhBVjROZkps?=
 =?utf-8?B?aCtDeUZXOHdtcmFYSTdYcVlFVnU1eElNdHBHZGYvbW45dUdiTGRqUWtyeXBq?=
 =?utf-8?B?WVpNNmNiTHg0SFlnWnlNZm50ZU1xSWE5cjZmZlM3QWcrWFAzbWhiY1E0cDAx?=
 =?utf-8?B?Y1RIb2Rka0F1emJlNkNTUkdBRlpLNTEvMW0yY2twck1ENDN6dGZjcnYzT2ZK?=
 =?utf-8?B?cTRMTkpaY3d6Y2YvSkhvZFA5WDVlRi9lVXlXL0NYcFJ6UFJLQ2Z5aVZwNm11?=
 =?utf-8?B?allqSWVtNnp2ZG1uaU5NbEdwVEFxWU1LTzBna3RibUdyV2xvU0s3aG1Vd0dF?=
 =?utf-8?B?ZGNGV2hMNVAwUUpMM0F3Vno0cVN1RHVocmRFQXZEZG1jcjMxWE1vSnREcVdy?=
 =?utf-8?B?MmJpZzhIZCtlS29HSFp5bWdTSTJVTS9pQ3BWMlJldXZBRWkwSWI0UUdsQVV5?=
 =?utf-8?B?OWRIN1YrQzZtS3JCZUNtek05WXVsclVVUHk1bUZhK3BiK0NLWllEbHI3SU96?=
 =?utf-8?B?eTA0RHk5L2tLWTA5L3RMZmE0cmU5TWt5dUhPcUhJelp3bkdTWEZYOTFnWDZZ?=
 =?utf-8?B?UHZjT3BBWkJNYlBzUW0zQWo0QUQzYVZHMkZIQmtNekpjSHcwVDUrOE9CZ2Vv?=
 =?utf-8?B?cUNvMTFjSm5LZDYyRjFWRTRFOXdMbDBNcjZlb3hHUHdJK2hSQUF4MjJKOEM3?=
 =?utf-8?B?Ty83RWRlU1lVbzVCNytPQ1NyZjRwbHhRWVlsYXo1MFJxRkJUbkpicFRnTWlm?=
 =?utf-8?B?RC84K3VKcjdQUXhpcmdZK2FWNFpaQW1rNmN2UVhvbnkyZUtqemdFZFpCREFS?=
 =?utf-8?B?dVJtSUlTd01SSWE2U2JnYmdFOXZDa0lNZnlhc05RQk0xcEt0Q0NoZGd4azh4?=
 =?utf-8?B?Q01FRlVweHdDaUxvMU1WOUFSSjg1QUswZHkvTlB5M1UxWFRPWjAyY0VBKzJh?=
 =?utf-8?B?eDdRbzljWDVtMGxhRjZCUHlFTERqaWtZSXZrTGdUTDRSbko2STNmbmk5UUdx?=
 =?utf-8?B?Z3grVUtVeVl6dkdMU1RjVzJQQVFYaHJWZDU5SW40RGQyNGtmbnVWUXgxMklk?=
 =?utf-8?B?clVDSWNpdk9VdGhjR3BpYU8ybHhBWDhZckkvbDAyeFFVenFiOTFLZW0rVkht?=
 =?utf-8?B?WjFUdlMwTytmK09yYnJ0VDJDc2ExUzRCRkJCK0FpN1BhenBPTVhwVUFhdnFZ?=
 =?utf-8?B?d0h2YUhybUNROFJTZXZ6YnplWGtjTWlENEJ1OE9LWnBTTkdhcXFZWExId3o1?=
 =?utf-8?Q?d1iAOnfgSZGFjvPQwGKbplFofhxlfE=3D?=
X-Microsoft-Antispam-Message-Info: R5fJBSaV6otJ4mmbNsT0wFhgDqJ83gSOW3CIh3rBP3CUNrCgM9zi7AjuKim2lTatrIyWl1HQCPkfx5mQ1m1cV0ii+MNcvhV4wpPme7WOMqrbc9/BTdWjHb3/h2+K/D0YIpeSeDq9V/IxWcXQ+t1vGw+ihEJiNNxhbDiJburZzoxEQk9uQy0lY2dIJ3xGVQYf
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;6:iU2iZI/W5jZ8Xknlkl1GBPSrwvm5/IMOTsiyVbjeFboYraO08P9fdrqVj3MwwBIlpEJQWyc+UcdOvWybNSbiE3bhQ3Bw4KBm25bXUWH8AdUH42ZYbAaybka58+bvH48ZUSOZgFxNwGMuN98xhfkPiYgmDB9SI5/iDuRbn6IBmip7SI32Fi29Ej9iuAKMGGna8Tc4BhNWQ0aRke7hAfLVYLiDUo+HQdM3jCfncOGqIXtbla7SDafALCrdqGRYs+r+Pbx8zJNrOHh7QwhMnKhhfgtjSSVulas3PtGj2chxteGrIe2xwBfri/BvFFyD0f2kfkCxePNQmCZuv/knqYL0A9Qua3iiygsnpRIpy5lIxELCUMW9IfAw84sBXfVE3RgkoSDh+hUglM8vqufrTUYOu3J4fQRgjZG4xpyT4UZ7BSiM6XFIqHDKTI1apXbV62MmUgEuU39mWG9YjJnIs5PbbQ==;5:hQkhQ9Iz8/FX15paMSr90ceD1k8URsQSY5ByIC4QGB/6gpwb0JiN3Ps3s8UdhGcyel7Cur72g3Nuv2Ure2/l4bcj2uZrlxe3MWmyCbWUQD5wK45jEGr6zmDNuN1nN148ZIvMv8NPbs90lDxcl3YJKkzBIIV0gpUOu4VsMavrMeA=;24:dqrIvkYZA36DTrW2v9MCoumlhhxjLZqWifp0ZO+y+q5kvQ1v3h5oulPhO9Lfbzt4PxjEicejCN4GZW6Fwk2MWInhJZfC0A+3/cOcMlnv8Lo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;7:zz6bfi609jVPYET5AJdpNcnitxgnNzziyx3m9Bt8WPT3DUYBhPsIQgZOmq7amzTIw6X5LdPx1ivooNDPvOkZ5hzgl20mul3jM5bHbuvTTkhKaTS2m1aEOe7cG/E79RU5crJzcJZ7cDgaH+o2R2Ce1byLK5lJJoLzYjjIqNUw6p53XAQsdWmn18NN2jGeMc21jHR7dJ5zxVcRfMPhfS3TXk9tTkya8ETPUNS/32gnkGkdRTZK1IsJmpKw8JjguRhH;20:s4QpsiyzX4XHgIdegiJORMYZbQxKOX4L/5mmj8YZWv3RpAcJJOwpD3AtWaHbFZRSb4SfOhFMCFnTkUJuDBSjzxoflnR4IVriu3zXWeWDRPkQ0pa3DfRuTUF8dOXDMrUW6fuIRWhc2LorRVsziFN9N8Fw2LkX5h59uYYNmhlsl6g=
X-MS-Office365-Filtering-Correlation-Id: d7f581b9-3f70-477f-872e-08d5bb4c7bca
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 16:45:50.7269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f581b9-3f70-477f-872e-08d5bb4c7bca
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3249
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16/2018 06:34 PM, Alexander Potapenko wrote:
> stackdepot used to call memcpy(), which compiler tools normally
> instrument, therefore every lookup used to unnecessarily call instrumented
> code.  This is somewhat ok in the case of KASAN, but under KMSAN a lot of
> time was spent in the instrumentation.
> 
> (A similar change has been previously committed for memcmp())
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
>  lib/stackdepot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index e513459a5601..d48c744fa750 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -140,7 +140,7 @@ static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
>  	stack->handle.slabindex = depot_index;
>  	stack->handle.offset = depot_offset >> STACK_ALLOC_ALIGN;
>  	stack->handle.valid = 1;
> -	memcpy(stack->entries, entries, size * sizeof(unsigned long));
> +	__memcpy(stack->entries, entries, size * sizeof(unsigned long));

This has no effect. Since the whole file is not instrumented memcpy automagically replaced with __memcpy.

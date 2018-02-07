Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753419AbeBGH5j (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 02:57:39 -0500
Received: from mail-ve1eur01on0116.outbound.protection.outlook.com ([104.47.1.116]:42144
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750815AbeBGH5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 02:57:37 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 0/2] rcu: Transform kfree_rcu() into kvfree_rcu()
To: paulmck@linux.vnet.ibm.com, Matthew Wilcox <willy@infradead.org>
Cc: josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        mingo@redhat.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, brouer@redhat.com,
        rao.shoaib@oracle.com
References: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
 <20180207021703.GC3617@linux.vnet.ibm.com>
 <20180207042334.GA16175@bombadil.infradead.org>
 <20180207050200.GH3617@linux.vnet.ibm.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <db9bda80-7506-ae25-2c0a-45eaa08963d9@virtuozzo.com>
Date: Wed, 7 Feb 2018 10:57:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207050200.GH3617@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P189CA0022.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::35)
 To HE1PR0801MB1338.eurprd08.prod.outlook.com (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d71ddee2-bf82-4d3e-ccff-08d56e00729b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:qq1ex+4xKfPY3pzcC9TE1/Hy5zpjr+Lt80lgo2hVgnrypoDuVf06dig1h4nQp7nZ0pA2tc1O1YZZlKVd/Y3FhHn1Xm1Zxlu2Z2msB899prW9oKtVIgcbiH0IjqneHPYsALqQd2Mu/ZSTazZ35IebEHa3FqJ0XrZM/aCZLZatmp3R5IDjOLvf7FkLxdemUuEMrPut39pvMzt1YtOI+rMHQBNx5cbaENiXBPlV3gYxvaRXfP8PSgV8xX8A6UYMFAF9;25:KbDxcjW7pqPCEZIh1LM5kXLYbMEg9pJ/jo5Nhf+imp68vREa8TmrCZOnlnobKT9QkMUbAnCd4/BIwNkLZtSKsUDrtRrNih95able51/xwfla8nBxSVNsJ4E6Bl2wBoIiahp9oPS4JPzpKMyBFGwO7/YLexfRy2wZIU5Tv3eHBRNNnwi7QKUQdPhpub1GrROoF7qAgSfAGwbJLbIaZWPQuwmz6nwE04vRxJ4zZBlSSmU2TRpEJ+esW2YhY3fWLg4hfFLi7T9yPbY3FtU2ITgIc4kFERRxbj3PyOBsMwhEYnYK3lXAZp+lgRNsO++t3oQUNjX77gSOPt/nis27GUPpTA==;31:QVXoyXcY7Q4t5EvgiQnQCa6AFb+CD5AOm95VP5pY21u0ophV4cy9bUoOfyylljsurs4PQgSHW5bYC0anYBEEE+xBd8XN/aYdp4ifsUXTb/xUoPa8YclLLoR+cMEY0aDtuHWYEF+SZhB+mPuXogTcyAgAznF+JKqjAZnuBY71ZCMq0RDo/En5VSBCdsXGnt3PVPM/Lp9jFhpgBpccRMUgMCZmpX3MAKYbSA/27hlz4tk=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:HrVtVDu0zyx//XyNIcDe0Fc4VfJ6ftT7k7iJg2w8mG1aRH/Gg8L38P9zDEyeQVgZJ/F2K71CDf3R8O0hhNyKg/6NaZIHcysO09CyagVEWirJCEyFua/JgTDdyBauOS1J7VlCezTtybR51tt62+pVkmdnFznO4y++v+HaQSWforuPHGSv3D4kw5QETVi6Xf8Zzmr7rv9cR5JxhjP8wxmXaE/UoPMgPumy3Vh4RRQdUE4aLdQ85A79Ca3dY0YXCvVpX8lpDKSfzwtv1Rfz7gCmjFgSzXbKOchKAmBv3oM9CwgxhchI7WfSlIeZMO8i9iSXSmYTAUc46U7pD26mJs6B3W4TOQoRCaCHTeVHjUMXwioTXxIdi4U3VO1UKEPGLcyny5G+OVFOs3kjzQlgs/KM4C1uAhOlcXHm9vRBcHKUUEo=;4:5/eYqs2XlgwC7B0xkXOED6KcBVJ8pXYZNJBXCBd1VQEtCnmpCiazNLODKZOsLEHZXTV4h6Qj35a6jdKH9tjzeOIr89PnuBpSIL0RfaYrBuOZRx2ns6PXmkrvLyeaLtJYqUizy9tbJFzUvzdeTOyT3tlVGvlTAucVjwjajrVXSMxtt7X9Jtc+FcRQFZ1tc6k+DZsk80WuxQkgNhAduy6q6rJYBvn8lzxpzmY//emakk6w5ZgafiR+qHsczpntl1oUlh3P4kfNS0ILSw4B1SMEHA==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13383722B359FECC30663BEBCDFC0@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0576145E86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(376002)(346002)(39850400004)(396003)(366004)(199004)(189003)(65956001)(66066001)(16526019)(4326008)(2950100002)(6666003)(6916009)(64126003)(6486002)(93886005)(25786009)(186003)(6246003)(50466002)(97736004)(86362001)(229853002)(81166006)(31696002)(36756003)(230700001)(8936002)(68736007)(105586002)(53936002)(39060400002)(478600001)(7736002)(106356001)(7416002)(55236004)(76176011)(53546011)(316002)(52116002)(26005)(8676002)(386003)(2486003)(52146003)(23676004)(77096007)(58126008)(16576012)(5660300001)(81156014)(47776003)(65826007)(65806001)(3846002)(6116002)(305945005)(2906002)(31686004)(83506002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6YTR5R0Q3c2IvYzhEeWp6R3JHRXI1bjFt?=
 =?utf-8?B?ZVhhTUdkdW5xWHRsMmQvcDFFTGI2V3lEb0ZpZGdMN25vdTl1bEliN1VHM1Ex?=
 =?utf-8?B?RFJVZExUR0pFai9zd2lOczd0US9Ed3VtVTE0SmlYcnVzcFkzUkFUZGEweTVG?=
 =?utf-8?B?c1FLZlJqeTBSNjNPWFNrTXZvOTlDT3BDNXVXcklOaG1kMnpzU3Ntck0reEFS?=
 =?utf-8?B?SkVZRUZQT2hSNG44MllHUXpzYXlLQy9HdzViNStwUE5Pb3F6d1B2TENyalRO?=
 =?utf-8?B?QVVwU3NRLy9XeEhub1k3VTh5KzhnNFo1TDdkQVdGT2pYUG9VNU5GM3paOU1s?=
 =?utf-8?B?VjU4YXZtRTRkaThSZ0tNQ3JCN3Z4OXlTbFRPbGVMbDltSXFER3NQNStaaFhQ?=
 =?utf-8?B?UnQ4bjVWYTA0bmhqQWY4MzdZTEVFcGNjaFhMcFp2ZUhWZ0g4bkdrRmZSWU9v?=
 =?utf-8?B?Z20xTC9mUHRlODE3WWs2TThhWkxoZHlqcmNvM2ZhTGpjTHJiN3RWT25yT0hs?=
 =?utf-8?B?anJ4STBoR3kxWHo1Tk95T2gzd0tLbHg3cjd0NERGdzB3aFJ5TU1PTC96K2ps?=
 =?utf-8?B?QURWM0pRZkNDRHVzbnlsYjVZeGVDTHJxN3VKbFg0bnliS2J2YVdpNk5SWVFx?=
 =?utf-8?B?Sk9zMXFUSis1Rk9ta1JjRGYrTjJxbG43b0VMcWlnbDhvZysxVXZlN2tFNnpa?=
 =?utf-8?B?UGFpZnlKcVN1QXNtZTZIam9GK1FEYURiNVNJVzJGNWVrSTlpcWp5VTlNbTJE?=
 =?utf-8?B?T3N0Z040a1dFcEpQY29ER1N4dW9URndQK3FUQ2FFZWU3UWZ1SlNXQTIxVnJ2?=
 =?utf-8?B?eGxiWXppWHBDV3pwR05UY0VQWEZzSEFBMlZQZUExUkVQZVR6cWI5Qjc4cExL?=
 =?utf-8?B?Nk9lOHNLQVRMeWgzY0tPQUgwTWFqNXBVaGVOaVV4WXhyUFhCZXNIMUtVeTg2?=
 =?utf-8?B?ZFo2KzhqN2NjUUk0L0xnUG5GRFVMQmVRYklnK0VQWlpSTm9TMVVwM05sMGpw?=
 =?utf-8?B?dStEa3g0QjhOUHNkdnEwZXdBTllnRUI0MVh1UWRPYWpZUUEyWi9IV3JMWnVQ?=
 =?utf-8?B?RFUzTi9OMEtKeGErZVpIaXVpdUNNVjNmZi9LQ3FwWThTcmJtYk84SXRWVUhx?=
 =?utf-8?B?KzBZY3l5dXFONUNqY3pkYlZkdHRxU1hLQ1ludS92U0hhN3l4bUZlYUUvdVh0?=
 =?utf-8?B?RjduczYzZ1lSN2IxdjJqaHQwQ201cXBiZ3QwNnU4a0F0V1hITjM5RHc2L1pi?=
 =?utf-8?B?YWpvWVJNYjFuSFZBaDJPZHMvbG5jeUxBUlN4RGVHN3hCb1l1SDJOdVh1TW42?=
 =?utf-8?B?V1hINUtJb1huTnl5WEhNbSsyV3NubFBZWlRHckRvZEtmOWpzWS9tazk0WVZn?=
 =?utf-8?B?RzMrUTB6RUxKbnZCK0tsRThGWjhvTk8xNkt6VUdPTzBvdEp6UGsrL2NDeFVu?=
 =?utf-8?B?VVdPVG0vUzNiR0ZqTURQWC9IOXpIOVRwd2pEdVRIQlR2V0RhTzNDUlNSQUt5?=
 =?utf-8?B?OXlWWEhOdG9pdGVoRS9nL3NuSnV6dE0wUS9jZnpHZEViVGN6em1Ja3RxZWdO?=
 =?utf-8?B?RGFoU1FkZHYzWEYzZ2kxOWNkVEV0bkZaSHVLUmRJV09wU0NlVnV6aFhOZ0gr?=
 =?utf-8?B?QkpHcDBQMkE3OWRZQnF5VW9YTXY1aDBDajl0UEZZVllubUQxRVNrcGNXSlpK?=
 =?utf-8?B?MXB1Y29Cdm5KTjlDaUhjblA0eHVlYS8yaTJSVFVYSGNhd0lSUXlLNU92dDBY?=
 =?utf-8?B?blV4U1QrN2JiTEpQVkI1RHFsOHhNc3ZHZTlGcnQ1RGFGbVJwbG0rRE9CRkw0?=
 =?utf-8?B?VEdTc2U1UGFtZnpRbzdyYWo2NEJCaEdQVUY3bDQ1MWlPU2M4Y1ZJbEcxdXRK?=
 =?utf-8?B?S09OOXFaamFaTTdtd1JaQlR1TzJxci9CUXcwOEVhTmQzQU5YMklTTllGRVhI?=
 =?utf-8?Q?vyS1/y/HATVuidzT6GUEqUJn17OB5al4=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:8scAZAhZNJJ+J9Qy05cx3n8qXv/QL+eN5QaMR7ZhpSKBGLMQB8ukk2QGynj7wWP0icQmyUzGwxyOWcul7g1w+zCHUTn4i1GMuSffJo2gbKKtK5WtAiVMNnm0czWj8QH6XYR+GqZuJiaCtoApO98hc5X15xX8/m91G86UR4JY3V/ZuVCgfY4mg/v0bz8uGIYRi4pGZeuBCs8mziYnsMAqRqrLcmnzrkHspLTTiKFgh9TlrxDVrScRkRMnnysz9tCj3OwT6ctCg60K1irmj/jx2NiK76DLjloD2iJsur41hyPAvQ9TC3+EolfE0ZlyhUrMLi6AY4x9MX9QQfWIAkzTM6PHf+qET1ewcbgKx8DkaJE=;5:+q38wcEKjZdFf2TC1/YfMY82P15gHn8NKKnEbNTeahQuL7JfI9DeKH6WTM8uhZz9Z9U0JZpNMl5h8JMrf4jaOV4XPZ7olOl7uMwxbVk4r7/JpZqWLdqWXcPQFYkId3aFm+kq7r5XArY/14mkD6vWBblSqpolWF49yoNtlDmJQTk=;24:YIOEaiAJpPQxdGz8OyVPZwYhMSBEsen2bkvWtgIO8zb3ZNn2TUblyTAxFxjw8Laa2hngLv/uZxBFQ2zKtb3vfSM/W8rXTmdeBfn+RDpC62Y=;7:/7kFZ5zB1bEoVOTQtr6237EYVs4EvW3B1P6QUjJlzuLhIvwH5H5vy6pTA39x6n4nQu0s3ynQo47CqclayMI0hoOBGy6jB15PN8g/2dI8F4VqGM5oDyIXMb+DyzCsh0sdIABR73CldKTgaPOn/l6XlE0QZngLHPFpaZqng7cxtMk6jPq6BNVwhAvgvGIoDtgSYkRj8VIvghnxIvv8C7WsOQ37ZGN8CLbWD1buLOCmt8yfaksIjhg74btM0gkCG3ZP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:oRsY9ddjsKb2plm2yqTYFnLKjTi5wx3cxkt/OXtFfA23/x4Hm2hyHcjHT2CggKK/58P6D9/GTqEox1pVzxwEnrvNKn9uUyMgQBSDcIXC96qw73N+0te9aycvU5x8QNiEdO4ar0fgiW7YPq7Ga5bb5D1VVgCOQ/4rN5Z5pkPRAqE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2018 07:57:33.9036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d71ddee2-bf82-4d3e-ccff-08d56e00729b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.02.2018 08:02, Paul E. McKenney wrote:
> On Tue, Feb 06, 2018 at 08:23:34PM -0800, Matthew Wilcox wrote:
>> On Tue, Feb 06, 2018 at 06:17:03PM -0800, Paul E. McKenney wrote:
>>> So it is OK to kvmalloc() something and pass it to either kfree() or
>>> kvfree(), and it had better be OK to kvmalloc() something and pass it
>>> to kvfree().
>>>
>>> Is it OK to kmalloc() something and pass it to kvfree()?
>>
>> Yes, it absolutely is.
>>
>> void kvfree(const void *addr)
>> {
>>         if (is_vmalloc_addr(addr))
>>                 vfree(addr);
>>         else
>>                 kfree(addr);
>> }
>>
>>> If so, is it really useful to have two different names here, that is,
>>> both kfree_rcu() and kvfree_rcu()?
>>
>> I think it's handy to have all three of kvfree_rcu(), kfree_rcu() and
>> vfree_rcu() available in the API for the symmetry of calling kmalloc()
>> / kfree_rcu().
>>
>> Personally, I would like us to rename kvfree() to just free(), and have
>> malloc(x) be an alias to kvmalloc(x, GFP_KERNEL), but I haven't won that
>> fight yet.
> 
> But why not just have the existing kfree_rcu() API cover both kmalloc()
> and kvmalloc()?  Perhaps I am not in the right forums, but I am not hearing
> anyone arguing that the RCU API has too few members.  ;-)

People, far from RCU internals, consider kfree_rcu() like an extension
of kfree(). And it's not clear it's need to dive into kfree_rcu() comments,
when someone is looking a primitive to free vmalloc'ed memory.

Also, construction like

obj = kvmalloc();
kfree_rcu(obj);

makes me think it's legitimately to use plain kfree() as pair bracket to kvmalloc().

So the significant change of kfree_rcu() behavior will complicate stable backporters
life, because they will need to keep in mind such differences between different
kernel versions.

It seems if we are going to use the single primitive for both kmalloc()
and kvmalloc() memory, it has to have another name. But I don't see problems
with having both kfree_rcu() and kvfree_rcu().

Kirill

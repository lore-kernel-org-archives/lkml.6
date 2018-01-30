Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752800AbeA3W0M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:26:12 -0500
Received: from mail-by2nam01on0082.outbound.protection.outlook.com ([104.47.34.82]:51949
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752529AbeA3W0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:26:10 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCHv3 1/3] x86/mm/encrypt: Move page table helpers into
 separate translation unit
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20180124163623.61765-1-kirill.shutemov@linux.intel.com>
 <20180124163623.61765-2-kirill.shutemov@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <f1005ed5-c245-b64f-fe4b-64fff5790172@amd.com>
Date: Tue, 30 Jan 2018 16:26:03 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180124163623.61765-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR1601CA0012.namprd16.prod.outlook.com (10.172.93.22) To
 DM5PR12MB1147.namprd12.prod.outlook.com (10.168.236.142)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 439e8bf0-665f-469f-dc68-08d5683075e6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1147;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1147;3:4ii5XwZc2OoYJCPOy3l/BNap75em5xNoyoB5GwPsKozoOOVSkIjWfoEDTMLZNamRZVbGKFFYegUIJ04xbIzbg6iRZHwEbPeTCYSQYxT16gnN+qyQI68kE8ejUXIxWeNjXqN+106zTtfpcegc8Y+mUot1j2GWhFzqdXz5hfkdXhWVPhQ0eN8CPlmYOPr5dziIdHywT/tTYZaDqNqWKUdEs7u3faAcobpOOF4Yc4eANk96OHwV/9ao6QC1vWxEZZFc;25:ZIRvidsZ19rTCWNHT5L5SDkXNrsMDeeamORLO3Q3dKcsq4C1+/mHrcfYSuCGsDiKUTwoV3K8BRA2uQQmoTmGRwzK5irSm52MLF3BlSJtmfovq5tesTYGRdSJ/M9b8YcO/cOWTTAgGXVErOWDstv2YgR5YV8NTSUKK7CKNQFLFKZwAac1qaVpoBgxO81GdlU0UjrJT5d33vc7ODxebpe7sOlMCcaucrUxL7rZxEB7UL863NyCEUvDqoUHR89pRQKP7inHwfE/YXTgKseO+Kc37k8pK0RpT/ORvR2LaqEf5W13tdhOUyFSQinaZ/ODlbK+2hCLXoSoZ/TFtNveqrY8ng==;31:KmSWEVh5dAoH7NcqniBcLt1psYh+X8LyQO0YqyO06ngaSVfsmaTQOWg9j/LHSwje+r3oCInIFZWyc2C0cj/GQ5aS5JMNMIydHsuANXPoEmqaOxZmTtGGwiRc63CNOGYmkz/9q1vdjrIzA7mqCwUrlAAQHS3fpA3mguTFFmhGaDNowghN1JNmC2mYE7+BQ5/b7WqwGziIrDt7Sbt+NmrItLBqnCPnp3apcFrVCUbYsEY=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1147:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1147;20:1TTAnGzPlEEyYSJmN8s5tYBQBpl5e4Q8DW1oa7ClYtWj8hKiAzWo26TCG8c+PrmgjSjwpo1OLJ+4A/Y/1LtodAN1kNXFKXJZlQeLAL82rLF9HK/P2GZ1kxuUhgLwblIpixdfKYz5F0s/nNKL7eKFQOH+HmMnsPZmJ36RB31KlDOvn/I4dsWKq1GC0o1gVyTNy66WQ+5myk8s6cDNlciqlCDZ++Sp7x7VapRzq7l/gifpXYZIQAidxn7WsdJPj6xL27+/shFAVvXv+K8o5LH32caf6hJIwUNqiQ9PKJtfO5rEFCXgwZFRU1C6efYeAs17qzC1B25pnBBpc6J7jZndEQM8nLKjXNxXGUFOl0pDVuLoiKPvSaCVeVYwewjVyzTd9NLFQ462qLqH0K92f/TvquBZ8o36g5ulFjUPbFp1QwxdicwUupHV/PqcfOoFtNWqmg6OCLGtajNfSuDHHDcsjL+K5RiXsy8/Ym1o/Kg+3ACfGC+UwD1VmLRxOIXCPRtD;4:TAriFrvHLDBWarr75OdlFnXlHhLvDH7PbNT/SdMDre5lr1wi4MccYdPxz2zbsXVpQxUj+b1T8TVeV0d/R6EGR3cYoRQMbHKycGMh5s/2lHcHwXGN/p+seAwrnuxInYpA+vTgE0hJUvzc5T8VKP/A1J+vJr9zaLPykQWoYxoI2nadS3qjoEfWKQVYgeAa8irVQE9oVKF8z4oMFJClHs33T1GQ366xwmmD0N8Vl0whbKbkSKRtVuqri4vYR/0J05zgtyFq61FrYWMkSKD3TxSL8v1Vx99ahUH9tDanqT5ESX3HiBjejEQma18JJtLhbV0jaqRe690Wf3tQur/dpo2+Kg==
X-Microsoft-Antispam-PRVS: <DM5PR12MB1147A02971F665BE1AAFF935ECE40@DM5PR12MB1147.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(944501161)(10201501046)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB1147;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1147;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(39860400002)(346002)(396003)(39380400002)(366004)(189003)(199004)(3846002)(229853002)(53936002)(8676002)(81156014)(53546011)(97736004)(8936002)(66066001)(386003)(65956001)(6116002)(81166006)(2906002)(47776003)(105586002)(6666003)(50466002)(230700001)(2950100002)(31686004)(5660300001)(305945005)(65806001)(65826007)(86362001)(478600001)(4326008)(68736007)(7736002)(36756003)(16526019)(26005)(52146003)(72206003)(6486002)(106356001)(16576012)(31696002)(23676004)(6246003)(186003)(316002)(3260700006)(83506002)(59450400001)(64126003)(90366009)(2486003)(54906003)(77096007)(52116002)(25786009)(76176011)(110136005)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1147;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxMTQ3OzIzOjJIbTZlbkh6V1FnR2hTb2NPTzRxZGd1KzVW?=
 =?utf-8?B?RFlRRURINTNyNEFUZUhwWk9NK3dMSzE2YnFETnptNnBCN2loMXNzYUlMSjBx?=
 =?utf-8?B?MDA3QjZ2RXYzQXhMSkJQanR1b0V5RDk4LzA1MS9mYzlkbU9MUGJxSVY1b0xH?=
 =?utf-8?B?Q1pHZk84K1JBL3N3N01aTzQ2UWNkS0RMbHF4YXpOWmV6K1FCOC8veU81SFlB?=
 =?utf-8?B?UTlVZmo0d1JvT1diK2wxRlZlMzh4akhyeUlTSlVPMVNjUWRhL3huS0dvKzJM?=
 =?utf-8?B?WGZKbTFxcnE3ZmxNYkNkUFd4ZVQ1VFFZbEt1U3FiczdIaUN3VjhhUXpYTkVF?=
 =?utf-8?B?RWNhQlhMelAwNnJFOGRvUzl6d0pLL21aYVF5MkVxOU5PZXQ5M1NQWUF1eDBB?=
 =?utf-8?B?YUYzc011MGFYU2JadEZ3Qkl1NGQ1MmRKdFVGbkxuZVZDdXArakZkeERSWnhM?=
 =?utf-8?B?LzBZbnhLWTVPcTFoNkF6L2ZXVjJEcEIzbVdqZ2FhQnlncXEyRzY5R2prT3dW?=
 =?utf-8?B?NnJQeHFXME1ZbmxoRnUvSmIyVmdaYmVGNmd4VFlEWU9YTGpxd0hXMjJhMFlD?=
 =?utf-8?B?ZHhDK0wvOTVDM3dxWm5BbE1ZNnZJZGY4MW1rY053NmVtNG9ieTU2eVd1dmpO?=
 =?utf-8?B?OWJqcjFMTnpHeVlEM1hNZlRJbkt1aWJlVUJ3MU9MakJ3b0tCVjB6VXJ3bmo0?=
 =?utf-8?B?MTJ5Q1pIS3FPWkdrNm0vcjZ1a0NyQXZzMC92Rm83QzdhdDJzRlZtZ3ZpdTY5?=
 =?utf-8?B?QXFBdFlqTml1R2lUTGRHUUY0aGNkQVNGU1ZZbUlvU3hKd1docEJBa0pOS0o3?=
 =?utf-8?B?MzAvUTBOVE5RWkh6K293T2JwRTZvaTIwU2RlSzJRK0NrdWNoeVo5WmhmeS9h?=
 =?utf-8?B?Tlpqb1BGSmpRUG9SamFueEs1WXpuY3hJcUdJZDBsZVlYQzlnejJGbjRvWVZE?=
 =?utf-8?B?YkRCUWQ1VUZhM3kwbytqdzZlTXNRM1hieHN4ZllsMWliRHNTdzgvNTNYOFlS?=
 =?utf-8?B?RnRxMGtNRDRVbUpYMi9WWktvSFhaMmNTa1FpRzlFd3FITTQ0UjhBdmVEVjVZ?=
 =?utf-8?B?YmZLZk9zK29OZzBLRytGWXlKN2I0UjlwUWUyVk1HdFZQOHdzMHkzM2lqZGZh?=
 =?utf-8?B?YktWR3lzYkFBM0NkcUVJZ1hSU0ErbWtJTGFPVkxuZi9nTkZUV085ZjJWRldj?=
 =?utf-8?B?K1p2NUFaaTQrRlJlWGhXbDNWN05jd211T3FPZEsrR0JsV09DS1k3Rjdrdmpw?=
 =?utf-8?B?RkJWWjlrV3U2bU0xRkQvem8waU9rRmlnTUdubklsUHRadDVueDM2UzQxMmNX?=
 =?utf-8?B?YnJVa0RCT0NDaU1HMURrdmpjVXU4T2FHbmlYTE1qNkp4K0hCR2FONit4QkZa?=
 =?utf-8?B?RGZxZWhGR2pMOUFWdm9CcmJKYitaWTk1cXRSVG9ML1BGRU5aZE4zT3h3OFBn?=
 =?utf-8?B?ODhuSkk4ZURWaWZXVWI2bE05cDI2enVmalJabi83c0V2MU91N3liZC9RL0hU?=
 =?utf-8?B?Rm1lTEJGQjg1dUJmT0lwOHE0YlFDa2ZOUTdqTDFUVU5pQ2svSGxSMURyTzZU?=
 =?utf-8?B?REF0c3QyNWI3b25JVThLV3RJYUdadWZVZURWcjc2WW1SdzRjUzdTYlgyRHY3?=
 =?utf-8?B?UUVxdFh6TFlmeXRhamdjREhJaGlDVEpIMW1Cd1E3WjI0WFNUSmNNSk12Q0U5?=
 =?utf-8?B?d2g5RWwwQ25Kc1dSYmF0dmExOFVNY1Nyd1RvMlNOUnZ3c004ZWZyK0hmNkY0?=
 =?utf-8?B?VmVLZlNNaGZHYUtVVVBtaWlER3d4cUdJS20va2hmWkp5QUFMM2Jvd3VRaDdW?=
 =?utf-8?B?b2diS0dSQW1oVGxTSmhHaFFlaVkrU0pRTEs1clRWK2hocDNWcXRWQjZxSVV2?=
 =?utf-8?B?cDUrNENoMXc1OWoySHFYRVIxNGJvU1M0KzlQbmQ5UzNBRzZLbzFBMURWWnpt?=
 =?utf-8?B?ZkI0WWMwNnZ1K3FmN2xHekc0Ni92YTZxbWEzQStEK09UVkpmM0s5VWxyaTNH?=
 =?utf-8?Q?in+9DD?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1147;6:3zoaZszpu7GS8qnn+JKxhlfEUL3/DmmEwdWKXeYWIYWWYxAEM9Yj7fFV/cnVtwOylPEirK8ii4/pN3Lrc4okAZL06gCHDpc4+xnZ+Y0MnteqogaJzwLzebOdI1FJEh6EmgZ99RRa/+M3Z2KDsV9InkebQyzN2DlMCx0cy8htkRRU33IedDjaUOfqibX81xyXDJRFPWm3oIe7AIjLkCqOsMxYzDLJxoHicSELPgf2UMSkZ7eYYvbapuvkouphdZBGII07J5txg8+I+fJRJq1a/9FuLzJrQRzOqylPf0bSJxFY4KVo65uZmfeaQshaCn7RsdFlfw2p7AsBi0v6mRJFGueVcmxQQn2TDpaR/w1FXvg=;5:AW/63gGojyZO/hwmXXl2raorkTlhrtAkO3IdTIvxFN+aBE3CR9BhdgjhuG5XUeNfioYGFBQkxG7EPMiNYc/RQVwIgw/hXNPoxjXu7+Ux/1yjJmMWHhftKEl95cZYhREylye6NklS7x7UndQG+8fKND8BfrI/aY09sUPf8G+RzTs=;24:9NQfMZSQ9bexgyJo4UDp21Sg789dGoId3v2F/fxUgKAhm/mMgCok78NMZ9r7UUHtjWOpTEFUNG3hCqMt2cwDXG/eIYNVRf4sYEwXpyfqAB8=;7:8WrVqmeYZj7HCUkrybKCyu7iOaHtiBM78sTU2ywPiD4Is3/WzVuSV0VpMP757W7kuqbNvjPsP2eoC7ZoH0cPiN/Yrq9YuuD436i2ApGP8mUM4CZEKvP9NABz0Zn8IBNSHJJEpK6BS6fDW7YG9guwwx1DWd6B/DHxoPJHUqLdSqUS3oywIQc7VaSGTTj43SoB4NEgkLOJ6adO1o+TQ0JqcNqBmDJ0chgjCB/5S7s4lq2YpIXVh7kyJjboOzoFJGmq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1147;20:PLNpYz2dnQLYzPeVN7EXw0KRTBW/yS32gVR2IYXocyiYfnJ5SSCHWt0vPAd7b/ct2fYCoT3Rl3/wRZ4rYlKCJ6HE5n/qyeI59pZ/417Brj4kyiEmvRY1hs2QiV9z509PoEcaiCDWJukKN24J4wVnB2+tNQViqTB4kA6f3sOsLL7R1s6AuhbS8fFEe5oLpJzt7BlwsWEE3qWBvCUT9sTli3JQXekHsrTZFHBvPsOX1MzUdTC3H5KQtOCUAYAVf3fc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 22:26:07.6076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 439e8bf0-665f-469f-dc68-08d5683075e6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1147
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/2018 10:36 AM, Kirill A. Shutemov wrote:
> There are bunch of functions in mem_encrypt.c that operate on the
> identity mapping, which means they want virtual addresses to be equal to
> physical one, without PAGE_OFFSET shift.
> 
> We also need to avoid paravirtualizaion call there.
> 
> Getting this done is tricky. We cannot use usual page table helpers.
> It forces us to open-code a lot of things. It makes code ugly and hard
> to modify.
> 
> We can get it work with the page table helpers, but it requires few
> preprocessor tricks. These tricks may have side effects for the rest of
> the file.
> 
> Let's isolate such functions into own translation unit.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Just one minor comment at the end.  With that change:

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/mm/Makefile               |  14 +-
>  arch/x86/mm/mem_encrypt.c          | 578 +----------------------------------
>  arch/x86/mm/mem_encrypt_identity.c | 596 +++++++++++++++++++++++++++++++++++++
>  arch/x86/mm/mm_internal.h          |   1 +
>  4 files changed, 607 insertions(+), 582 deletions(-)
>  create mode 100644 arch/x86/mm/mem_encrypt_identity.c
> 

...

> diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
> index 4e1f6e1b8159..7b4fc4386d90 100644
> --- a/arch/x86/mm/mm_internal.h
> +++ b/arch/x86/mm/mm_internal.h
> @@ -19,4 +19,5 @@ extern int after_bootmem;
>  
>  void update_cache_mode_entry(unsigned entry, enum page_cache_mode cache);
>  
> +extern bool sev_enabled __section(.data);

Lets move this into arch/x86/include/asm/mem_encrypt.h and then add
#include <linux/mem_encrypt.h> to mem_encrypt_identity.c.

Thanks,
Tom

>  #endif	/* __X86_MM_INTERNAL_H */
> 

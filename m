Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966786AbeBNEKa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 23:10:30 -0500
Received: from mail-sn1nam01on0041.outbound.protection.outlook.com ([104.47.32.41]:30331
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966705AbeBNEK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 23:10:28 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH] x86/mm: Decouple dynamic __PHYSICAL_MASK from AMD SME
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20180208125524.88795-1-kirill.shutemov@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <5199949d-6795-aa55-888c-7ba8abd406e2@amd.com>
Date: Tue, 13 Feb 2018 22:10:22 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180208125524.88795-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR21CA0047.namprd21.prod.outlook.com
 (2603:10b6:3:ed::33) To CY4PR12MB1141.namprd12.prod.outlook.com
 (2603:10b6:903:36::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb7efbf4-fa7e-4bbb-81cb-08d57360e0a3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1141;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;3:dtg1f1s4ZaCXdGQTqWS7/uxu0iOGJCTbn4NfrCcNg3+qWdnjXLq/K4cqTO21vLU0/fDYIyUcR1A20/E2ttf9kBYAqHhphN/IXlyLJbqeXXbUztq37bDtggD+/WAG+p//rpTpgE0oJsy2H4g+wrCGr7mZ/PtWl7RlpkFWp9TR/xBOj3uFAib+4o65QW04RoxzzTSXnz8KaTyzl56JQa4aMVBS65OyRzLXW2Gy1VKwCMA2SsNT6PAzAbe+YzIVLgOE;25:huB7j4Zs6Vg6HP3XyyZ1s+BhhF8MmideuGF7Uf2QJLnwpXdEvYbyLWdWa64CQM7DvkYfJ5dfbT7yGI7rq42U5rPKO6PmSrPzTO25DI33+rfjHZpYNBBQTkxKdZxO2hS5OGWbb9PlHoWRbuEPBg5CcZjCRRK/ciAV+3R6ZaZWDKn07b4pIzoUCGOOJbQcSawZxmq1tpVKYnEA52vJcwSPQrq7zW8zuScx2uqB4mv6012eiUcHT6CxdXbLMEEYkwgp73NHMjt+gBOiGKkRfW/AHRuTZLKCGQFsE3R5s3A3kLQ4bI5ucXmvva0KexQ0U32Eov9PTik1nWiH8JhBuLflWA==;31:4VQ3hzdl171fVKaBemvagchgrP6F1D6BvbW6R8hIXBfnqcRlSK5610QJlFl1FesPNB1/KDOnca2mTuytCW6LgEiAZkYJ98n+dZL40EyKEEn1eWIF67GU+7upSdvw6uTTo9LIF9Tt106AroPq+hBu8UVW+GGJMBz7dtDDjfg5BvBI2tk/Hw85Xlu+3QRRWzQxuo4AjhdVKOOw1LVdB0xS8y38pieg0K3ncvBFs67nY78=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1141:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:U3lqDp1y/uTXV4JGsWLyZ0dU6e8JfLXPeIpYS8Tnl5c8XOhhvrw0yuKbljUKKyW0O0+sXdvDv47NJmm2UoUgdpHgqnDRMUjMb27r2FYuci+8hXnk3bqIEPewegAlO90hIgcVjzEjsFOsYCKy27ylEFxC4hekPRcUR4eY/KBzAlgij4sC4BkuxIN1qCWb0kF8OGFBglpR1bsD0Uhtxrw02Xme9nUzm9W0cvWMWyVGQtJ/iyNBa5W3p3YwnNa/1JA/+cTB7+GdOqXUkTC9ouAsyjGycvxcq4gezCLNxtUa375pVcUW23Uh7gPmI4gTlyCDYZOrrJLZSqHEURctrqgmfMW0+3972xPzdQD81xN7aaZERj+/+s4dARVaZh50/RjbfCakOv9pEuL51yBTgEqM1h8ZN/cWGYM4FdvMfri32WlotRwAvefZWDmz7NavNX/Jk3entjHZyB07wc249GbvB8yixIIIWP8mn6Ior3Xe/RbKIXQ2hivqCVIhFeidenBg;4:bAhPPEDc5jxy8MOiyjVbK09CiH+94SudD7dmijTzjW6VPyIUz1+03NhpBbrt3pkIeq+INf354+Ynr8VrziJ48dAO9CzrRsgV5FqAO2v5LeGeI5xJK0Kdw2APg5wsQnFou/XCxZkeh8EYi4KGLEUarcahK32rGHOIwFAJeirPF6gY0XIddFdMofYOQw/8B60jDQ+y7Yvzzyav/x1lPKOttw78wJVf2x5UPIMxA98wDXIclPC8HUEuo79z5eWhCniq0KRj7nCMYTeQUAgALR8+rsgvCU2xL2Bw+vejbVJca02Ef77+/NS7IPYT3U4hCzgT
X-Microsoft-Antispam-PRVS: <CY4PR12MB1141A796E8ACF8E403CDDE5BECF50@CY4PR12MB1141.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231101)(944501161)(3002001)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR12MB1141;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1141;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(396003)(366004)(346002)(39380400002)(39860400002)(199004)(189003)(52146003)(66066001)(52116002)(65956001)(65806001)(229853002)(64126003)(8936002)(6666003)(68736007)(16576012)(81156014)(8676002)(81166006)(50466002)(97736004)(47776003)(53936002)(65826007)(2906002)(2950100002)(5660300001)(110136005)(6246003)(83506002)(58126008)(36756003)(53546011)(76176011)(230700001)(72206003)(386003)(186003)(6486002)(31686004)(16526019)(31696002)(6116002)(3846002)(23676004)(2486003)(59450400001)(7736002)(54906003)(316002)(4326008)(105586002)(106356001)(3260700006)(575784001)(478600001)(305945005)(26005)(86362001)(25786009)(77096007);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1141;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQxOzIzOjNxSktwai9tTXdSeUZLcTIxdEIvakN0bEZn?=
 =?utf-8?B?UTFwMXZhbkpMUkNVWFRQc1g0ZDBYOXlwVUdEdUM0RFBRV3BRdnp3dUNpUUcz?=
 =?utf-8?B?UTVKR3E1TnBNT1p4Nk4xdktpdE45NzFXOXF5Tm1JVlRQOHRvZ2NnUzBkK3lx?=
 =?utf-8?B?MmNwWDJXZS9TaWExc2JIMlp0ZkpuV1dreWJqNTFsM1liMDRLdVAyRnpxTitK?=
 =?utf-8?B?c1ZMNnR5T0NaMkYzSk1MWENZNTVLSkNvamd2aDBCS0ZBWm5PSmUvbFlreTVO?=
 =?utf-8?B?WnNCWm5BR2Z2eTdjVWxCRWRsVlh2djBPYTladjB6YVlXUTI4SkRlUHpOWmIv?=
 =?utf-8?B?Y1BkY3VqMVkybnRVc3Y5T2xxeE95TmlnQ2FNWi9sY1l3Wmg4OFMyMFhoYjVG?=
 =?utf-8?B?d09NcEtEb0lES0Y1ZUQvNllGVDhVdjlwdm5JWEp3Tm4xV3V3MlZ3TUdmOEpC?=
 =?utf-8?B?RFFzejJCdWJTd3d1TnZNdk40ejRzbENBVXNkOE94N0hiek1uNlJSUlNIbWJ0?=
 =?utf-8?B?Q2dvQlh3Nk8zbHk1SjhmYkpBckdzdVNWRWI4WVVnSndmMW51R2RsbVU2MTRT?=
 =?utf-8?B?d0hZb1BxUXpsNWFwaytGczRNK21vbEZlU0gvbUdWeGNna3U1VHBvRXM3MHl5?=
 =?utf-8?B?TncyV2hncXdYS3ViSHI2NmdnQThuSG1jVjNvQU1oNTJwaWlSWmZHeG9wUC96?=
 =?utf-8?B?ckt6QjBBNWRTaTBFL1QrVXdtNTJZeEhaT0RPUVJzdXJBUlZ0WlI4N2lSZGJu?=
 =?utf-8?B?WUdpNk5aMmxSSDY0YXhPV2d4R2ptdjBsdDdOeFExNlNjeXZrWjh6aEZyaXMx?=
 =?utf-8?B?Rm1nMWRkK0dKYzBqVmFQRXZmK0RMOXVTY3ovRnBKYmxoWjRlREJiTVg4eVB0?=
 =?utf-8?B?dWN1c0dPejM2T1cwT2QwZUNFUlZpMWFyRkdwLzVjVmpDTjhZVzJ6eGJpRXJr?=
 =?utf-8?B?RGFCUkdGc0E5UFE4MHB3RGJZUndpdFJOYWxKUDRwSzhoeWVrcXJoK2ltdS9P?=
 =?utf-8?B?L0FSV2ZrU1U0UW0raW5lQytGay85N2t4VzJSaVFqTk9GN3h6dlViMDAvWUdH?=
 =?utf-8?B?cE14cmVrNDJ0VEI5cmNNRnpMK0k5V1pwbmdoWHpPUVFBMEhJdVlQZG8xd1FZ?=
 =?utf-8?B?VHo4NjFCMVFaZlBkNHFxQnVNcGFBUkJWRXpyRU5aRFg3TWJnWldFeTBGUFN2?=
 =?utf-8?B?ZjFOSVhJcHc1djZTa2lXZFloeUZjS1RWV0RObFVxWXJ0Q2V6d1BiajVmc05L?=
 =?utf-8?B?ZzJQWW5MSlcxTmk4YmlEbm93c0d1YmZYeFNXV2hyeE5XQkg0RkpGRkt2bnBj?=
 =?utf-8?B?V0JObkFNdnpickdnVDhuQmJBVXRjVG9DalFEZS9YWHVxSWxqWGdsTFk2emlS?=
 =?utf-8?B?MzJXNWZ3YjNHSGlONkViUnRia1MxWDRDdGxLNmQ1TUdSM3pTMTR0bTN5Z3BO?=
 =?utf-8?B?ZDhSWU12N2UrR0tWUkk4VitPUHREVjg2SXRLbjF5cjNyRm9OOTRuTlUydlVo?=
 =?utf-8?B?QkpGL25KdjdoRGVZeWx6VitlTFJlaEc4MENNbEJ3TWtuSUZvVXRXV0RNc1NE?=
 =?utf-8?B?dzZsVGlNQ3lHblBrVksxRHlWZWJTV0ZtbEN0K05lQzliVnhJanVwR3BILzFw?=
 =?utf-8?B?cWo1R0hnYkppN3FiUTU1WU92b3FYaURhbHQ0ak1sYklTeFZIQ2F6K0dNQVRk?=
 =?utf-8?B?dkw4c2EvL2N3WExhUnBGKzBadHZTRGN3SzVSZkE4WXYxT1FJTjBkZk1tK0Fh?=
 =?utf-8?B?UGFMZFV6dXJ5aVFyZEEwcU4rc1MrMnJVRmdXSHhiTG12MHkwcy9yRzZHWUx4?=
 =?utf-8?B?Q0tOK2FwRkxaS1dCY1VnVmJtNlV5cXBFZS9LUDJJYWt1dWdDMnRqT04rejla?=
 =?utf-8?B?eVgwcUpkaTQ5K0ZGNStPM25XY1lJK3JDK1ZOamJmYlV6dnczYkk5TEFWdzM0?=
 =?utf-8?B?MURSU3BWR3NOMjBpSGxiUTVyWHl4eWV6SDhCRnF0MWsxdXJCclFIZk53Nm4w?=
 =?utf-8?B?Q0FBOUxrNWwya1ducmpiaE8yQm9KajlySVF0UT09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;6:qHUFcwZqgXePgzV10V9UjMVEiWlGLr/cjitkn6NsaTE6cTDOOzUTvspmPX37AMAQpiZ/wKz3zWtKoDB4/2ZXIBw4FmkU+X4gc36CVJCQPSsAtidhRdcEDhnjVHR3sBQENXhkhsHnimRzuRjN2LdR31mwnCTzqI1cnO5LSmpypD5/LbDFfqeh9pHjyO52Hwzrh59CYk4jRdsy1xziZ9uFuQIi6xT6kT3I5B1LRSnn5Ia7Gv6YGpYbu3rJ3QNSQL9wqLLlui9T8HVoIRCU8+tlMF2PCCry0yQOQZMUWlFDcOEAjpa/HmCvyzrtjQNlCehjI93hJIabpH6kEw0fLOK4a3S4WvQ/2si1C96zjh4XSXk=;5:nN6aJUXshMaSwAuLYDv8tdCfZIzUopNNURfzYWNpL+BbLoHb+9Q+nl2NZsBFmAxCIxeOXDspYt84DZW+lJpoPzLjMFLwbM9o1e2dtQ/s9NpWV1WOHrVqaEO8cMqwQzK/zXUNrxBHPHcTpS0NSeJHaY6drc66ceyOLtpojdmDXUA=;24:TiyN1753MVbY/s30Bu+pVYsuXJWpvHZo+q7fPIk/ga5wKhcsJoKbdpWYG+MV0Uj/troBiQ/b1RosKTc0Ud7hIM3wi5pIsk7GKEE4vCrYH4k=;7:BpKgmyFgrMlwJ7XFtSnWIS3KZ9BD/bBIjqg3LTVgbFGJdhd6Bn15NE1OnusLlCjZhAGxUL/vXdaRK37Zcby7sb16XHbWP2ocPiFMa2M1Di43nl2HYRQGGRGj2SgPrV6TQhrtt32kf/0jF6zdF5ovn2wg9tQ57C2jfE3HCbGPV1cR0yg/tZHfWcXRdbYOZ1njQXshaPRUsblJ6ALx4tih7FIwizIeI1SxRqvdjAIfRRhkApGpL+mGgwInWEafJDmm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:NTI5c6Mz1TtkLb/9COgIeEms0vG8MHyzzAJLMDCgyuUKkrR/R0tro9TBz/L+2q6qBKHO0kO2prKLDaKw/veMLxOiqE2GDmHK01F26N1iXEI1UHxCje4RWNjftf8TR8lbuNs0cnWlMxRwaEE248zYgg6q6PWgQAyjeJeuplfFCKyaCjOLwD8l0lXv3L+UC0vgREVyHuFLY47cLL3Zha+Czz3Z6Lq2h+xR2J24xWqBcCiafTERWUN0zOFw7ldGZTxI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 04:10:26.1128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7efbf4-fa7e-4bbb-81cb-08d57360e0a3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/2018 6:55 AM, Kirill A. Shutemov wrote:
> AMD SME claims one bit from physical address to indicate whether the
> page is encrypted or not. To achieve that we clear out the bit from
> __PHYSICAL_MASK.

I was actually working on a suggestion by Linus to use one of the software
page table bits to indicate encryption and translate that to the hardware
bit when writing the actual page table entry.  With that, __PHYSICAL_MASK
would go back to its original definition.

Thanks,
Tom

> 
> The capability to adjust __PHYSICAL_MASK is required beyond AMD SME.
> For instance for upcoming Intel Multi-Key Total Memory Encryption.
> 
> Let's factor it out into separate feature with own Kconfig handle.
> 
> It also helps with overhead of AMD SME. It saves more than 3k in .text
> on defconfig + AMD_MEM_ENCRYPT:
> 
> 	add/remove: 3/2 grow/shrink: 5/110 up/down: 189/-3753 (-3564)
> 
> We would need to return to this once we have infrastructure to patch
> constants in code. That's good candidate for it.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/Kconfig                     | 4 ++++
>  arch/x86/boot/compressed/pagetable.c | 3 +++
>  arch/x86/include/asm/page_types.h    | 8 +++++++-
>  arch/x86/mm/mem_encrypt.c            | 3 +++
>  arch/x86/mm/pgtable.c                | 5 +++++
>  5 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b52cdf48ad26..ffd9ef3f6ca6 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -332,6 +332,9 @@ config ARCH_SUPPORTS_UPROBES
>  config FIX_EARLYCON_MEM
>  	def_bool y
>  
> +config DYNAMIC_PHYSICAL_MASK
> +	bool
> +
>  config PGTABLE_LEVELS
>  	int
>  	default 5 if X86_5LEVEL
> @@ -1469,6 +1472,7 @@ config ARCH_HAS_MEM_ENCRYPT
>  config AMD_MEM_ENCRYPT
>  	bool "AMD Secure Memory Encryption (SME) support"
>  	depends on X86_64 && CPU_SUP_AMD
> +	select DYNAMIC_PHYSICAL_MASK
>  	---help---
>  	  Say yes to enable support for the encryption of system memory.
>  	  This requires an AMD processor that supports Secure Memory
> diff --git a/arch/x86/boot/compressed/pagetable.c b/arch/x86/boot/compressed/pagetable.c
> index b5e5e02f8cde..4318ac0af815 100644
> --- a/arch/x86/boot/compressed/pagetable.c
> +++ b/arch/x86/boot/compressed/pagetable.c
> @@ -16,6 +16,9 @@
>  #define __pa(x)  ((unsigned long)(x))
>  #define __va(x)  ((void *)((unsigned long)(x)))
>  
> +/* No need in adjustable __PHYSICAL_MASK during decompresssion phase */
> +#undef CONFIG_DYNAMIC_PHYSICAL_MASK
> +
>  /*
>   * The pgtable.h and mm/ident_map.c includes make use of the SME related
>   * information which is not used in the compressed image support. Un-define
> diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
> index 1e53560a84bb..c85e15010f48 100644
> --- a/arch/x86/include/asm/page_types.h
> +++ b/arch/x86/include/asm/page_types.h
> @@ -17,7 +17,6 @@
>  #define PUD_PAGE_SIZE		(_AC(1, UL) << PUD_SHIFT)
>  #define PUD_PAGE_MASK		(~(PUD_PAGE_SIZE-1))
>  
> -#define __PHYSICAL_MASK		((phys_addr_t)(__sme_clr((1ULL << __PHYSICAL_MASK_SHIFT) - 1)))
>  #define __VIRTUAL_MASK		((1UL << __VIRTUAL_MASK_SHIFT) - 1)
>  
>  /* Cast *PAGE_MASK to a signed type so that it is sign-extended if
> @@ -55,6 +54,13 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#ifdef CONFIG_DYNAMIC_PHYSICAL_MASK
> +extern phys_addr_t physical_mask;
> +#define __PHYSICAL_MASK		physical_mask
> +#else
> +#define __PHYSICAL_MASK		((phys_addr_t)((1ULL << __PHYSICAL_MASK_SHIFT) - 1))
> +#endif
> +
>  extern int devmem_is_allowed(unsigned long pagenr);
>  
>  extern unsigned long max_low_pfn_mapped;
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 1a53071e2e17..18954f97f3da 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -999,6 +999,7 @@ void __init __nostackprotector sme_enable(struct boot_params *bp)
>  		/* SEV state cannot be controlled by a command line option */
>  		sme_me_mask = me_mask;
>  		sev_enabled = true;
> +		physical_mask &= ~sme_me_mask;
>  		return;
>  	}
>  
> @@ -1033,4 +1034,6 @@ void __init __nostackprotector sme_enable(struct boot_params *bp)
>  		sme_me_mask = 0;
>  	else
>  		sme_me_mask = active_by_default ? me_mask : 0;
> +
> +	physical_mask &= ~sme_me_mask;
>  }
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 004abf9ebf12..a4dfe85f2fd8 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -7,6 +7,11 @@
>  #include <asm/fixmap.h>
>  #include <asm/mtrr.h>
>  
> +#ifdef CONFIG_DYNAMIC_PHYSICAL_MASK
> +phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
> +EXPORT_SYMBOL(physical_mask);
> +#endif
> +
>  #define PGALLOC_GFP (GFP_KERNEL_ACCOUNT | __GFP_ZERO)
>  
>  #ifdef CONFIG_HIGHPTE
> 

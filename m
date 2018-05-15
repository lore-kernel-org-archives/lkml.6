Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753371AbeEONYf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 09:24:35 -0400
Received: from mx142.netapp.com ([216.240.21.19]:35104 "EHLO mx142.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752453AbeEONYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 09:24:32 -0400
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="253917795"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Boaz.Harrosh@netapp.com;
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
 <20180514144901.0fe99d240ff8a53047dd512e@linux-foundation.org>
 <20180515004406.GB5168@bombadil.infradead.org>
 <cff721c3-65e8-c1e8-9f6d-c37ce6e56416@netapp.com>
CC: Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rik van Riel" <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Amit Golander <Amit.Golander@netapp.com>
To: Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
From: Boaz Harrosh <boazh@netapp.com>
Message-ID: <6698c486-56e7-1fc2-567c-69cc446a58be@netapp.com>
Date: Tue, 15 May 2018 16:24:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <cff721c3-65e8-c1e8-9f6d-c37ce6e56416@netapp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [207.232.55.62]
X-ClientProxiedBy: AM5PR0601CA0032.eurprd06.prod.outlook.com
 (2603:10a6:203:68::18) To BN6PR06MB3075.namprd06.prod.outlook.com
 (2603:10b6:405:3f::33)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7193020);SRVR:BN6PR06MB3075;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR06MB3075;3:tn7JXtpfoOPO42X1Jy+OGIiWM2rKJT/Ar+2msKFsuVkuMGKE/wDavy+RySxhJL9MRaFR8ye2t8GW/DbFnEC6QakA1zBLKXXsrvT7R58RpaaJiuvr/d/0mghqAoy3oW9m2RKHUV627rD9pbbsn5896GhkwI2qhoKh5RcwRz5KdsVSlJy7v9bb3xyiTXRE1EPP5Oeo0gqJhQYOVAdkI/lbbnPE+FGGa+pfZGoWAmnFaHOdkz1dBA/zJCVSDnv5aJX/;25:KUv5PBMEk6rx2BN8VyDmbHmJ0V9kA6JL81I6jaJ4YIfMGX6cUnztaEplCcsWkE3fR2X1yOZcXkCbcjS8F9g/yUWtFLfMABtM0ZysDGe5WL6zU2p+nZXVLOCLEs+/JWKb8bFYd9kfgkgeqDuVL9ClcrbZLvpc2cz+tzgS5KIV4vQKT//wiPmDQUUrAfJ3OXXJcWA67iUo2H4+uaCZqr1gFqVdw5ED2sSG0Ne7olLdmfwzYM3XXPS6iXPv8Pr3UMvwj7v9/e9r+/5Kzkjj7si15vP8lzGM/a3iLjd/gu9PzYeWr4aYpMRa9bOIkXpIl+/1d3+C7J5w5bmWZD90ivHCMQ==;31:IUur9jCnW7CpwqXYYqCpC1X/+GY1Opk6HBFluul3Zh/aXUP9tqg2nG5/yLgmctZlbUZP6aj4V9psqDEzUes7TdTex+5G7NSjZfURe/ryWLFSLGDz0SfK4eci7hkeiTzTVfkNIlUDYBVUWu8FVfJ3O5zybT1Rj1emNsQQ4axBQHcfezdVm81wJW6hHsgUEDSadsgmRoI5pV+squYsTgD0bO/nzaKZNEPLJ5jl34H1HVI=
X-MS-TrafficTypeDiagnostic: BN6PR06MB3075:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR06MB3075;20:8A3NpRihoUZyrt/blqbl9DBe+FZgVFB1fbhDWU4cyO8Ll5d0M31EQRsknCYVrMjNuYIf3xBZW+ThsM+C5xHoLWNeIsfWDSvPYZZsnDc/I4mI0XMV4r1cwFCXZJh0wHQyQTqSlB4cwX4AFPP2oSdpqGuLdZRNxjz+UWD7+u2bym9GgtvfwXtmOihHJH9vCxFtQUj7VF9fbaISJ6i7AXzeErgGfSqqz6P4TtmJzYsmYFsc+R3qzQSxns3XdST1DQp624oJ4EOvTjFkZiYgizyKzm9kaSbbJkAmLGU1OosbgZqWtYGEITdJ+MCsgyio/pKqkdqU+jE3g/CINVrVNsUhiro/5kUqVqxgsTViBDuarFC83g7QycAN5Du3ttVF0yJ5loFtRORqhMf02TppCcUtw/vVAWrO1mWViwI5yiyy2v9OxS6moZ+Yxd3hb25ivo8L85mLrSA6S8pvL5m7NA+bvASeop1wgai8kHEpGeXbqLMiosi4REeQuoutvJvUEXgR;4:d9CG6+VpPcpGef1re9sLgAdIJo0i9F5BwmWCG7LXl+veY15MohEy5k5sPRKiwLF1T2aga8MPupM/j/7fYaZ7xdwVjKFGm/z9GrO49uMJu9g9spgUDKwBA5L/K58cdlIcsuAGhcLx2b5ZKjrOz5BokfEvp+XAjhkM2TKgLQybVh20NqechjrYOij4KkLbT06/zWmMsMEnCF68JtY62ltjR+RUHw4/Obi/lJ2YZdoiRlmkgxpI2fvIkKi/PzHbb7rHtr9/UAQ3aWvi1e1VTPawJgT1g775illalNXNSUHjMK1kEUWoWlqFTppUyi7RxJPz
X-Microsoft-Antispam-PRVS: <BN6PR06MB3075D751219DE0545CB00C76EE930@BN6PR06MB3075.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR06MB3075;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3075;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39380400002)(39860400002)(396003)(376002)(346002)(199004)(189003)(316002)(36756003)(110136005)(8666007)(7416002)(97736004)(68736007)(230700001)(31686004)(65826007)(58126008)(54906003)(16576012)(5660300001)(31696002)(105586002)(229853002)(25786009)(64126003)(93886005)(6246003)(106356001)(6486002)(107886003)(53936002)(6666003)(16526019)(50466002)(8676002)(8936002)(72206003)(81166006)(476003)(956004)(2616005)(65806001)(65956001)(66066001)(52116002)(2486003)(52146003)(47776003)(23676004)(446003)(486006)(11346002)(77096007)(386003)(26005)(7736002)(305945005)(53546011)(6116002)(3846002)(2906002)(4326008)(59450400001)(478600001)(81156014)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3075;H:[10.0.0.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA2TUIzMDc1OzIzOkZLSUowMWt1YUNPWlJjVHJQaGVBY0dFV2p0?=
 =?utf-8?B?RkNLeFVKYjFSbDZlbFVCdWpZQ1dHaVl3V3V0bHF6NW41MGI4QWxPU0U2NS9V?=
 =?utf-8?B?UEQ0aEgyK3Q1c2QxVkZEM0EzcEpxeHpDT1B1NVcwWk5oLzdXSjl2ZndmOWVK?=
 =?utf-8?B?emwvR0s0bHRNb2RrT2JXL3FiTFBPOFN3QjZPazR4WFI4dmkxNlFqak9kdVRF?=
 =?utf-8?B?ZmRqOUhYZEpaY00zdm9MR0dRVEIzWEkvU29rMzQ3NXlLVVdSWjM5NWlkWU0y?=
 =?utf-8?B?bG1XRFAxeWZyNHFxZVpLTDY0R1dWdi9xYVlURTVraWJ6T3JPSjRPbExkQ2xZ?=
 =?utf-8?B?Ukh6bVlUamFFWHNSVEVZYXM3MEUxV2JtNFpWRzRFRURmOE12UzFySUVISVJ3?=
 =?utf-8?B?WjMwT2FqRll2TVRtYzluOG5CY3hOb2JWRHVyUjNuWWw5QzY4S0tWMmlEUDZS?=
 =?utf-8?B?cjhPOW1uQXBVdU5scXRNN0paOHN6QWNJZ3ZaY0RVRUVMVmZFYnN4dkkxZ3pN?=
 =?utf-8?B?ZzU1ckMrdFNTTG9TL1ErdzhZdE41dGFYNnB4d21ZN3BBZzd0VnE3MCtRQU9I?=
 =?utf-8?B?VnNoZHcwMSt3TGtDc0ZPRmQ2a1Z3a3VrWFYrWjl6ZEpzTmNMUVp1UkVVRGZX?=
 =?utf-8?B?UEZqSEt1VzE2azY4N1R4NWM3MU5aZWxEWERlSk5tR1U5VnI1Z0xsZk8xODIz?=
 =?utf-8?B?bVB3Z000ODcwZk1XUlI1TWlVL1puRGlyWGlVQjBRVU1lc3JZU1UvbWNudWcw?=
 =?utf-8?B?MFF6bDF2VzUxK3ZkWkVQZFNSSlJoNDVtc3N1eVJ2TXdwbEg2NkF6SDA4RUp6?=
 =?utf-8?B?aUgrQzAvaFFOSmY1YkYyMkVkTTFHZ0IzanBkcnA3RWM1Q3huVk8yOWY2Ynlh?=
 =?utf-8?B?QTJlOGpMbzZWVml1Ym5XOExYZUVGa1ZSVmxSVGJvYjBnRVhIckRja2d3QmRM?=
 =?utf-8?B?dGdjMG5aQ3BLMjhCbDBERGtFUmN1TnJxcitmbmpvVkpTU0ppbWxKNFJaUkpr?=
 =?utf-8?B?b21VUzZDbGdDcHI1STdib05RYmhIdm40TzNEZE5XVWp0TjFEUnFjVSswclZL?=
 =?utf-8?B?QVJIbXI1VFdCWW1hRWJBdDNXMitWMHFSWnBMY3lKUVBNTVBoK0hFSUdwVFpE?=
 =?utf-8?B?M1VSMTFsSTluek44d1JaUTJWOTJFOW1Ka3I3K1BKaXQrbloyL3lOdGlqTlhq?=
 =?utf-8?B?R0hxcUxvbmtIcWpaTjFESkxDUXlHelNRelFYejR5ZlVQZHVZNFhXSXcvL2g2?=
 =?utf-8?B?elBYRnVDWkZ1anYxVlViazdpRVQvRk1ubkpFVzBjaCtHUGR6dkE4dmdUQ2Fm?=
 =?utf-8?B?aVQybjh4VkhQQlFWV1lTd0NQYSszdTdZbGlGbVJwaWN0aWk3R05NeFMvWW4v?=
 =?utf-8?B?UWpqWXgvelY3S1p6eG1XRHNlUjV4dnM2S1RRbDRBS0JFcG1kdCtvcVdrVmxG?=
 =?utf-8?B?QUc5TkdmWnlOdDcyN0xvUGJCQ1dybm5vM3IveU9yV1BjdW96dlZNNCtCMHpE?=
 =?utf-8?B?d2I4TTVWTERtSm1oak9iSUIwbmpFNVpidjl4TDREZ0k3WUhaUThNRjZVT1pn?=
 =?utf-8?B?bWpJY2VpWGF5b0dIZ0J1QjJHQmY2T1pHS29LU1A4eGRmOWkvdklzc3hsUVF5?=
 =?utf-8?B?T2VLVkN4Um9MRVgwdllFd0VwNGZBVWl6Y3c3SVphV29JM1Y3M01wVCtJbHQz?=
 =?utf-8?B?ay9TV21sR0FIMWZ4ejBJTjY3UmNSbVNQSDlnZGhkeWJQb1k3YVFGZFlVV2g2?=
 =?utf-8?B?cGZYNEdNTEJFcDRma05GS1JZQ1VLeGdNaTNJdlBTWE9yc0huOE80N0hZbzBX?=
 =?utf-8?B?aUFyeVN6bG90bis2SG4wOTZZbXhYWFhZeUI1V1l4d0JlTEZZNjd1VEo2SE1J?=
 =?utf-8?B?enBxQlJsbkcxQlF1bEIzZFdBa1YveHRrSU9LbjQzcVRxTjNZbkV0SjJpcVF6?=
 =?utf-8?B?SkUrWmFSWWRoZ1lFUFZhcFdLUDFxTUFQMy9FS0hXMHNZaEhzVW84RTYwMWcz?=
 =?utf-8?B?TkpGVXBlbW5Sdkxudy9LcFVFU3FZN1hYazlVZjg3VHk2eStyRGtTSHdWRTJX?=
 =?utf-8?Q?YSpVRpWmn2sTYQoDQ+2FwFZa3?=
X-Microsoft-Antispam-Message-Info: V7w8M+3Z3AWu7Mr6Lfw93gEQGwsRYIp20GvN8YNf0uzvjAz3/M0n8eLXumBU8nmgQBLnkKSt2zpQ/AsvL9DOg3VOA67fPKwPXTEXJ84kkK2LE6dpdjhypgXdZoIXepPDnclsuF71scAYtC1FdxVtrqaDHOtJIZjz6Eqpt3b8MmbwI3M9bGNUcPDA0oCKR32U
X-Microsoft-Exchange-Diagnostics: 1;BN6PR06MB3075;6:Ba8vxH9HkGyCqk8rR1vlJEF53c7ncFR+kR4Q0Cf0wHcT+0dKQ/xzJZn716zlhxrDV3NTxvCp5Jsa+KjRXXlaudO+c5JGgeOb0pTyT1ZSp8+vLdm4XT84u2TMCee47XsPq0neiLDRRc9lZQH4pJI0dOvyjLZnxjTYGjixISwu/EWHA0jHZrpqVprXivoHT5ZEhZKE2VVsw39g5+gc4qQ6xapLJKDDXZlIMu6zFXFz91hSpb5pFZYk92HsIlYY71vSssUxBRDIU7cVe86QkNKYhoUXl4q+BOhsm1TIQBTLs55uNixwZa0eYqDKQhUbBwBSy/N2c8SCNZUAgGLZTi74yzEa7Edufy8hDlbyDaPJQxyDgcfdbCxlFCKF2skR8lW/PKCCbbld+KoB1oboepBJElMqVGOpiUbZyY1K6utdUmhY82PGX4aTFlZZrdmJMAhOQKUPQdC+CV+RlyATPAkipw==;5:+x85XmxQVV8lhpfIXAFivUVI8sW0v2FLuh5QN/cL3t2+o7dxKrxEbuzBWMgtRpkibLrd8TOTcTeJZnQnf6VP9UtkuzlUO/asjITlkSy7E1OIbCJubiZdEr24xkbVopT/ktxo5sCLG7kU+jUx4fYnp6gWLmxx/Vy+nNf6DecuTpI=;24:CEUvScyadLJSx5+iAB7BlT84nbCff8oGxkwyWm83uI3NeyesDONFJnnG8pIbponhbM9sVWQYYAqtcsPKaSB+rYOi2wGsqhX8qVXjLu/yuTY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR06MB3075;7:xTLaRRRv57RDga2R/qK2L9m6oX60av+MUTErkw88dcbbJuvwt/lJdf6Cr9+vmJ5z4BXfxZFIf4dAXE8+Nh/xoCi1LchBxcjMmrxauPOXGEwP2JO5N2CRefHE0NXMT6+GbVKaflr1aMIFmVVwHlYvtlFRwfW2rkSyovyPifD627LBrXFavadsjM/kD0aTdD2SOoPVKJ/O954IoQdwPPh9J6daPFLu6mwun2tFfD6XPNOkgM7O7dQC7rFEGdgyj1je
X-MS-Office365-Filtering-Correlation-Id: 500543a9-3c34-4cfd-5cad-08d5ba673043
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 13:24:20.6913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 500543a9-3c34-4cfd-5cad-08d5ba673043
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3075
X-OriginatorOrg: netapp.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/18 14:54, Boaz Harrosh wrote:
> On 15/05/18 03:44, Matthew Wilcox wrote:
>> On Mon, May 14, 2018 at 02:49:01PM -0700, Andrew Morton wrote:
>>> On Mon, 14 May 2018 20:28:01 +0300 Boaz Harrosh <boazh@netapp.com> wrote:
>>>> In this project we utilize a per-core server thread so everything
>>>> is kept local. If we use the regular zap_ptes() API All CPU's
>>>> are scheduled for the unmap, though in our case we know that we
>>>> have only used a single core. The regular zap_ptes adds a very big
>>>> latency on every operation and mostly kills the concurrency of the
>>>> over all system. Because it imposes a serialization between all cores
>>>
>>> I'd have thought that in this situation, only the local CPU's bit is
>>> set in the vma's mm_cpumask() and the remote invalidations are not
>>> performed.  Is that a misunderstanding, or is all that stuff not working
>>> correctly?
>>
>> I think you misunderstand Boaz's architecture.  He has one thread per CPU,
>> so every bit will be set in the mm's (not vma's) mm_cpumask.
>>
> 
> Hi Andrew, Matthew
> 
> Yes I have been trying to investigate and trace this for days.
> Please see the code below:
> 
>> #define flush_tlb_range(vma, start, end)	\
>> 		flush_tlb_mm_range(vma->vm_mm, start, end, vma->vm_flags)
> 
> The mm_struct @mm below comes from here vma->vm_mm
> 
>> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
>> index e055d1a..1d398a0 100644
>> --- a/arch/x86/mm/tlb.c
>> +++ b/arch/x86/mm/tlb.c
>> @@ -611,39 +611,40 @@ static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
>>  void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>>  				unsigned long end, unsigned long vmflag)
>>  {
>>  	int cpu;
>>  
>>  	struct flush_tlb_info info __aligned(SMP_CACHE_BYTES) = {
>>  		.mm = mm,
>>  	};
>>  
>>  	cpu = get_cpu();
>>  
>>  	/* This is also a barrier that synchronizes with switch_mm(). */
>>  	info.new_tlb_gen = inc_mm_tlb_gen(mm);
>>  
>>  	/* Should we flush just the requested range? */
>>  	if ((end != TLB_FLUSH_ALL) &&
>>  	    !(vmflag & VM_HUGETLB) &&
>>  	    ((end - start) >> PAGE_SHIFT) <= tlb_single_page_flush_ceiling) {
>>  		info.start = start;
>>  		info.end = end;
>>  	} else {
>>  		info.start = 0UL;
>>  		info.end = TLB_FLUSH_ALL;
>>  	}
>>  
>>  	if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
>>  		VM_WARN_ON(irqs_disabled());
>>  		local_irq_disable();
>>  		flush_tlb_func_local(&info, TLB_LOCAL_MM_SHOOTDOWN);
>>  		local_irq_enable();
>>  	}
>>  
>> -	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
>> +	if (!(vmflag & VM_LOCAL_CPU) &&
>> +	    cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
>>  		flush_tlb_others(mm_cpumask(mm), &info);
>>  
> 
> I have been tracing the mm_cpumask(vma->vm_mm) at my driver at
> different points. At vma creation (file_operations->mmap()), 
> and before the call to insert_pfn (which calls here).
> 
> At the beginning I was wishful thinking that the mm_cpumask(vma->vm_mm)
> should have a single bit set just as the affinity of the thread on
> creation of that thread. But then I saw that at %80 of the times some
> other random bits are also set.
> 
> Yes Random. Always the thread affinity (single) bit was set but
> then zero one or two more bits were set as well. Never seen more then
> two though, which baffles me a lot.
> 
> If it was like Matthew said .i.e the cpumask of the all process
> then I would expect all the bits to be set. Because I have a thread
> on each core. And also I would even expect that all vma->vm_mm
> or maybe mm_cpumask(vma->vm_mm) to point to the same global object.
> But it was not so. it was pointing to some thread unique object but
> still those phantom bits were set all over. (And I am almost sure
> same vma had those bits change over time)
> 
> So I would love some mm guy to explain where are those bits collected?
> But I do not think this is a Kernel bug because as Matthew showed.
> that vma above can and is allowed to leak memory addresses to other
> threads / cores in the same process. So it appears that the Kernel
> has some correct logic behind its madness.
> 
Hi Mark

So you see %20 of the times the mm_cpumask(vma->vm_mm) is a single
bit set. And a natural call to flush_tlb_range will only invalidate
the local cpu. Are you familiar with this logic?

> Which brings me to another question. How can I find from
> within a thread Say at the file_operations->mmap() call that the thread
> is indeed core-pinned. What mm_cpumask should I inspect?
> 

Mark, Peter do you know how I can check the above?

Thanks
Boaz

>>  	put_cpu();
>>  }
> 
> Thanks
> Boaz
> 

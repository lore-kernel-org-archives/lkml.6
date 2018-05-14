Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbeENS0k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:26:40 -0400
Received: from mx141.netapp.com ([216.240.21.12]:19093 "EHLO mx141.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750760AbeENS0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:26:37 -0400
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="273619046"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Boaz.Harrosh@netapp.com;
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
To: Boaz Harrosh <boazh@netapp.com>, Jeff Moyer <jmoyer@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Amit Golander <Amit.Golander@netapp.com>
From: Boaz Harrosh <boazh@netapp.com>
Message-ID: <1d5f676f-b5d1-3ad3-c7a5-25b390c0e44e@netapp.com>
Date: Mon, 14 May 2018 21:26:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [207.232.55.62]
X-ClientProxiedBy: AM5PR06CA0010.eurprd06.prod.outlook.com
 (2603:10a6:206:2::23) To CY4PR06MB3079.namprd06.prod.outlook.com
 (2603:10b6:910:58::33)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7193020);SRVR:CY4PR06MB3079;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR06MB3079;3:myGUzPp+RyAJ1S00tt5bNtQq9xljEjoOygl3wmfB+hEQpcWKLMIi80JwOzRFkbjsQJF1Rb9NoQ8ronQ/df1ro6Bp/NNRl1HzY71r/JB4/ynVUdXvkIOmNTYAG9jIjwoZd+NwWpa75V3Tx8fL47iDdPZhDwNCh274/dE6QvHtE/ZC8EaIJyFdHYo2W912vMptwEWt7EDb4oJ7pNVWhVoBq1+RsHDmALHYYQuBr9sxyM7lPAOc1G2kUePMbYzOMZ7g;25:F7tsLffPeJGbjxE1coOleaVS/EC79E7uTbuN/6Kea2TfjfSgfHDVbEJ6Dhm4GGJc9J1Y3FWco8wVm1G/ND7zHJJ1DzfCr6wKU6Yl+OwvYOHfrZp4wTyuqlrThOjTgemQsLKbB2b1VL1bTGb/KIdVtwg6QbZfjcAN9Q4sBnt1uA/W2MomVayppDuN0KzWJFaEwdzoOD4BbhHSl5keidRU2D8k+fbTdOeIP0431HbeBY6uwS+58z3gKR0lGxLnim2o1kEbePxvRQa0o5cvn79bZ5nPKLgR49RxtLaBz58N89tJihJb0qPMMBZVdhDJkplsA++tiZIzkhJs55TBAeb3UA==;31:9XTM5SNwQcQAAxT3bALaofbwAEDAkk2Hh4iuIj5qgBhiqlcISmaZJ1qyHAuUtMbnrpHIdViXw/0J6Qg+2MRW1Lql5DPQNLiDbUF3c4G/nX2zHFLmrLBpZ79+rVFZE2ABA2CRVQoXNAwUcx/Di8fwbKZZR7GpKQQNb0tS7SIINJv1MCWtplly8DvOWpXb7kvenC0O8hc/pi79PeSgkzWCoK0MdXtG+hfExZng9P5J8vM=
X-MS-TrafficTypeDiagnostic: CY4PR06MB3079:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR06MB3079;20:zVb5Nlt/bFENrcHpZbzUwHzzAZGABwUG2Ivc968ZXVu0n58H+9Tm1WSW4uZZMldi5kkn6EFY6KJLfjnCUFGShe9doAA8d3eMM8rC6ASLdftR9eQvdCvMlQeLPXQJI/tDlYrXIh6hjOy/rfTQScAPVw65YP176Ub/ylKYGo2gWs7/NFrQ8twf6gxhpRDBQiO647MJ0MXIWYboGNHxv0L1WofMWC7yV8Thz/J22SgQx9jXRgRSdJv2yz0Pajnildawpfc+V6UPnkA1uuncyWlKN17pzrDQL8gwAwJUiO97Lh7aZO/Qz9kqU98DqVhWwRlH0q3XbqE/xW8/gdVUIlBTmktGZNAYeTss+Mnh9UMv7A4ArGJk3EVb0sGOy1tKBK3HmRNFnOEblOunXy0TtaLyjPNwDiuprI0r9bdw0vTR2XTn1t0dDWLQpAB/x6wY/YcOiRfTk7/K83yrz5/1Q3yz6NPOEUruc3UdH5qdNwkiapGFXngk/cyXjd3ZxcI5wlZE;4:ukkpEsqbQCAANtb0UfNbRPZZyLtjcuUaicE51Q1bd5Onx0gV0bhqFIPhr+FN7fYerWcQrwS/36d6emorKCz4GiiQ4LNxsAcNNI1BlQT0bjgtDdZO1Tb/UXN/ZvD/KXywds3NVS0DObmyKiFAI+TLr7QZOHS06aKG+IeR3lCfssHqSatJohi6u/Kju353fWGbbkTkr8fvwjGc/E0zoI4zyXBhz0wk00RQd5OBxVdik5JwQG65NZxZRZ8ofqX8+F1so0VWFuvAmlNt5ryfVo6WCLSRQM0PcLfG2Nn7A2Ve6yatJIjHGw4zbogBnQK+6YTk
X-Microsoft-Antispam-PRVS: <CY4PR06MB3079359187B60288AD645DFEEE9C0@CY4PR06MB3079.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR06MB3079;BCL:0;PCL:0;RULEID:;SRVR:CY4PR06MB3079;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(396003)(39380400002)(376002)(346002)(189003)(199004)(25786009)(305945005)(229853002)(65826007)(31686004)(2501003)(8666007)(6486002)(97736004)(47776003)(66066001)(72206003)(105586002)(65956001)(65806001)(478600001)(106356001)(7736002)(7416002)(476003)(486006)(26005)(77096007)(107886003)(16526019)(81166006)(81156014)(3846002)(58126008)(446003)(8676002)(52116002)(23676004)(76176011)(64126003)(230700001)(386003)(53546011)(68736007)(2906002)(6666003)(16576012)(31696002)(59450400001)(50466002)(53936002)(316002)(6246003)(5660300001)(2616005)(956004)(54906003)(36756003)(11346002)(110136005)(4326008)(52146003)(2486003)(6116002)(8936002)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR06MB3079;H:[10.0.0.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA2TUIzMDc5OzIzOkxPYWFvNDV5Zm9iYThRb2R3Q2lRaU5nUFhH?=
 =?utf-8?B?WnA3Ym93eUVFL0xXSUZhYnhzZFRnUzdnSnEvdjViYm92NE1YaU1wNFE4ZVBn?=
 =?utf-8?B?NHhOc1dsYzlGSEttOHBKTjVza2ZCOC9aaVYwbk5mQWtUU2NRblJrNTExRUlS?=
 =?utf-8?B?K2tnelBPaHNDdjhIYnBZV0doOFdMZXJmWGNQUXBiU3puMVlWaWFNd2J1VW1J?=
 =?utf-8?B?UHpuYm5iRUpTMVJUUitxVkFIMTk5dkszMlJDM05hSEJhblpPa09iczlIR01j?=
 =?utf-8?B?c0lkQ2NaRG5IRlVYdU1iK0N1OURnaU5DN2QwTHBtUHdvb2p5T25jcGREajJp?=
 =?utf-8?B?Y2lDcTBKYytZMHFaWlNIWERaVkIrVkhSZ3FEYzI3WkdJRWhJWDQ4aTJwNmow?=
 =?utf-8?B?YnhndEtBVHhEbkFiaWk0Y3phdmFZbU5SVGk1U1NXSkRXb3dDUlRFWXMrNGZW?=
 =?utf-8?B?NnhiYTBWNVcwM0xYaloxc2ZMd2VjWUR4V2RFYkxZVURPM1BnT1VqMy81S3JX?=
 =?utf-8?B?OXV4WlJha3p4dmdSdjNNNEoySzAwMXhubVQ1b3IyWWdrdXBWVGVnMVlIVlcv?=
 =?utf-8?B?TDZVckRiTU9IVStlYlVWYkVPQnhrYnlyVTZBc0RaOW9oOXVZclRITUZtUlZ0?=
 =?utf-8?B?VFVsdUozM216WU8vVFFwT0xhWU8rZVk0VkIvLzRUaE02T3M0bFNCVldtMjVt?=
 =?utf-8?B?eGVmTThUSmltcTJ2bWJGcWRKd05ndEdvTnh2dlpBODVvTnpFK3FaWTlHSjJ2?=
 =?utf-8?B?bjlTcVVkTzUvYlBrRDhia2h2Z01zQ1F0UTdtL2tEM1BWa3ZxL3VTZnoyYmpN?=
 =?utf-8?B?WXI5UjhyaGR5YVN2SHZoa2YxdVJrNlFUc0ppWnR6YVZqOTJtQjhvTHp1NG1C?=
 =?utf-8?B?RFRYcnI3SmEycHZjYjB0NDllVjUxc3lFeEdtdy81Nkwvd0JGaC9PSkQwb0J5?=
 =?utf-8?B?Y3pac3BQQzBaZ0wvdEt3WlFDL1R1MW0vb0xmK1Voa1ZTY3lUZGxSeE1BK3la?=
 =?utf-8?B?ZC9mcjFHWlQ5RUZzaGpTUzhRbExGbjFrVHpQamMyM01ocVVZN0hySjMrSDFk?=
 =?utf-8?B?dlAzeGpQUGtxVmp0MDNqQ0o4aGVseHNBcU40SEk4bXpsc0t4R0JUMHpmWEpj?=
 =?utf-8?B?MGZuRytSa2RIYkpFQi9hZUEwSEcrVTRIUk1Wem9udG9YcUpWbC83Ui9VWG9v?=
 =?utf-8?B?TjR5TThWdVF2WlRMMi9ab3BMRndTeHF0bjI3SjU5d1RNSTNLRWJPVTVkNEJm?=
 =?utf-8?B?QTNYUWhKcHEwU2p0Z2tBb3RLY0x0Rmw4YUl0V25pYnkwZWZQcXNUVHQ3bHEx?=
 =?utf-8?B?b1FKaUNkWk1MOE5KL3NEbjNaeUozZ1pBYTNrUzYvUTZpRG5KNFhVM2wrNksr?=
 =?utf-8?B?OFB0T3BFay9DK2NVRkhiRDhYNk5oSHFaMkdFQzFpdmgvUSt0eGUzUFNWQkN1?=
 =?utf-8?B?OVVQdDZEeklFR2l6RmI5aHBTc3VHMjZvNVNMOGw2WGQyWUdLaXpLRk94NEZG?=
 =?utf-8?B?eWZ1UXNWalFmTm5GLzNPc2h5cXgzeHIrRmRzSy9LRHROTStjRkxJNFFOQmht?=
 =?utf-8?B?K0R6amZUbU1xRkN0MWVNNzc3NFVRMlJVU3c2YXQ4TlEyTmNHNVVnQjRpcmU5?=
 =?utf-8?B?OEFQLzJqUFhrckh0TjNMWGJJNnFXL1k2WlU5aG1wRWNWakFQUDNwaVVQb21m?=
 =?utf-8?B?Z2U3eS9NZFVGZkNOaGZqT0NJc0xPNnlGV2MrNzBaY3VPNjZ5TTBvRy9URUk0?=
 =?utf-8?B?UjlQNlVPQTdOUk52R1RMano4TURjRnlQWHVQcDJWY29vUmxUKzQ4RjhvVnpv?=
 =?utf-8?B?ekpqVzd3QS9mUmlJRkp6TEFjS1lTVllWZ1dieUJQU2syS0N4UFV1V2xocFRr?=
 =?utf-8?B?NmNGOGtpbDMrSWd6ejVNVUZWTnQ4M2x2V0c2S0Y3bmovazYvLzJJcFVReVNz?=
 =?utf-8?B?cEE3c0l0RnM5UDZOcURZN3hqTjl1elhxenBQVTdPUmJ6d084SVgrQnZLeWc0?=
 =?utf-8?B?VndmRUJrQ25lTnZuNStJTUpERmUzUDRlbzFsNzJJWk54NXdtS3cyaGZTQlpk?=
 =?utf-8?B?LzN0SEhSdmxmRVRzWmtodFIrR2JBUW5RdCtEL2pPdVRGVVBrVHZkbW9vUGtr?=
 =?utf-8?B?TXc9PQ==?=
X-Microsoft-Antispam-Message-Info: UzznBoSxQKV9GT8ZnBDHdvyjYXuMNE+gvHgsOsy43M+YFeoiZru5XllD2h0nAJDrl/7UhgW3tuk2memlkmaeVLdbPFsTMqvmSbYwmH1v1FdRSe6AFfWEnho6+K+sO2utTj9FyqadMGi2T9NH+UZ3CrfzZQRydQLPb3O4qEoPnF4lAJpzuf6mW12QtwDVaq/X
X-Microsoft-Exchange-Diagnostics: 1;CY4PR06MB3079;6:bTYcycvh20w8okr6uaddWiQRIuo83G6rixAL1Cf8zGdihHOYysayf/6bVj2JvIdyn2lhHjN/VjDSLwi8MBZ2rCWrYST3pSlHqgTE9R6N6YS6Hd3Qsc04ET47GQtnhe41g1jHafJx+3lwtopQdtRccnrT8tgzpoNgiOWHhgE3zLZhfD7YzXYTPqEzNrXFcxA2I5/cHLloI18eFRfGapSWN5igEHUvnVBtrbXoX8W4AYZh3Xr9WfL15BwM3fYo3x7Agc5PNtTFTKn0TAmbVH4xBDAZjt4AboIPoznQoJJado34vl5qGeCsvQFAM4M3lPmClHZUS6dYAmcNehpSsh6fRy83IbqnRBM/32CdjU5wdNYse6EE48zUWUtA6joisEwRqvjqppYl22orRmeeP/uQMkq06Rl5VsFLtdQWpsa9IWquPnHnh7FcIpiQMRRWZGhKmfK8TP/4+c2+hGVyalDNRw==;5:RSscVchpn5bYVu0gJ5812Akp38+w6QBsOwKaPHeW4SFiON8mRFxANX1XIV0FHrCis6XcqO9JCMURY9z4230X+0edGHjW0VoNv9L9jXNtU9eF6knSoBOkKH2gYpv06cdfVZwcANTfC7X+/5SmeX3li4OQ8YUZxHDcrVAuTPKWYKg=;24:0AHERev9VaAmwx4E56dkGKmiTquRLwSgziY2AryEule1dicJx9DikRiF76pfCcB20KXSUiDp1werfl0srSWwfUjug3zm9RmoYONNSQbnZkI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR06MB3079;7:qslGYxSh1lNTBwR7wOgdDXnTo8Sq8SvKR53yeDZjyrWiJ3xAsrWbiQ1ZEbgmqgadABF+QWhkbjR4gGMlxH2D3VROqTr8PwLTMj6b3XNeXwwPnlK3yjfglTobrUek/dCIF+3bOtdt2OGyjuKm35XiV1aCJoFLWfdSdlG7eIaCjoj8HU00aGdBflbu74SUlja4dLsbPSVF1kwKhhncpMkPIQqvqeZZ8PmReQgPw3tq+xaiR2T1Elcbo0LH6DkPcIYx
X-MS-Office365-Filtering-Correlation-Id: a70843d6-7ffd-45ec-c7e9-08d5b9c8387c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 18:26:28.3998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a70843d6-7ffd-45ec-c7e9-08d5b9c8387c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR06MB3079
X-OriginatorOrg: netapp.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/18 20:28, Boaz Harrosh wrote:
> 
> On a call to mmap an mmap provider (like an FS) can put
> this flag on vma->vm_flags.
> 
> The VM_LOCAL_CPU flag tells the Kernel that the vma will be used
> from a single-core only, and therefore invalidation (flush_tlb) of
> PTE(s) need not be a wide CPU scheduling.
> 
> The motivation of this flag is the ZUFS project where we want
> to optimally map user-application buffers into a user-mode-server
> execute the operation and efficiently unmap.
> 

I am please pushing for this patch ahead of the push of ZUFS, because
this is the only patch we need from otherwise an STD Kernel.

We are partnering with Distro(s) to push ZUFS out-of-tree to beta clients
to try and stabilize such a big project before final submission and
an ABI / on-disk freeze.

By itself this patch has 0 risk and can not break anything.

Thanks
Boaz

> In this project we utilize a per-core server thread so everything
> is kept local. If we use the regular zap_ptes() API All CPU's
> are scheduled for the unmap, though in our case we know that we
> have only used a single core. The regular zap_ptes adds a very big
> latency on every operation and mostly kills the concurrency of the
> over all system. Because it imposes a serialization between all cores
> 
> Some preliminary measurements on a 40 core machines:
> 
> 	unpatched		patched
> Threads	Op/s	Lat [us]	Op/s	Lat [us]
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 1	185391	4.9		200799	4.6
> 2	197993	9.6		314321	5.9
> 4	310597	12.1		565574	6.6
> 8	546702	13.8		1113138	6.6
> 12	641728	17.2		1598451	6.8
> 18	744750	22.2		1648689	7.8
> 24	790805	28.3		1702285	8
> 36	849763	38.9		1783346	13.4
> 48	792000	44.6		1741873	17.4
> 
> We can clearly see that on an unpatched Kernel we do not scale
> and the threads are interfering with each other. This is because
> flush-tlb is scheduled on all (other) CPUs.
> 
> NOTE: This vma (VM_LOCAL_CPU) is never used during a page_fault. It is
> always used in a synchronous way from a thread pinned to a single core.
> 
> Signed-off-by: Boaz Harrosh <boazh@netapp.com>
> ---
>  arch/x86/mm/tlb.c  |  3 ++-
>  fs/proc/task_mmu.c |  3 +++
>  include/linux/mm.h |  3 +++
>  mm/memory.c        | 13 +++++++++++--
>  4 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index e055d1a..1d398a0 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -640,7 +640,8 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>  		local_irq_enable();
>  	}
>  
> -	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
> +	if (!(vmflag & VM_LOCAL_CPU) &&
> +	    cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
>  		flush_tlb_others(mm_cpumask(mm), &info);
>  
>  	put_cpu();
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index c486ad4..305d6e4 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -680,6 +680,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  		[ilog2(VM_PKEY_BIT2)]	= "",
>  		[ilog2(VM_PKEY_BIT3)]	= "",
>  #endif
> +#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
> +		[ilog2(VM_LOCAL_CPU)]	= "lc",
> +#endif
>  	};
>  	size_t i;
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1ac1f06..3d14107 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -226,6 +226,9 @@ extern unsigned int kobjsize(const void *objp);
>  #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
>  #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
>  #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
> +#define VM_LOCAL_CPU	BIT(37)		/* FIXME: Needs to move from here */
> +#else /* ! CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
> +#define VM_LOCAL_CPU	0		/* FIXME: Needs to move from here */
>  #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
>  
>  #if defined(CONFIG_X86)
> diff --git a/mm/memory.c b/mm/memory.c
> index 01f5464..6236f5e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1788,6 +1788,7 @@ static int insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>  	int retval;
>  	pte_t *pte, entry;
>  	spinlock_t *ptl;
> +	bool need_flush = false;
>  
>  	retval = -ENOMEM;
>  	pte = get_locked_pte(mm, addr, &ptl);
> @@ -1795,7 +1796,12 @@ static int insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>  		goto out;
>  	retval = -EBUSY;
>  	if (!pte_none(*pte)) {
> -		if (mkwrite) {
> +		if ((vma->vm_flags & VM_LOCAL_CPU)) {
> +			/* VM_LOCAL_CPU is set, A single CPU is allowed to not
> +			 * go through zap_vma_ptes before changing a pte
> +			 */
> +			need_flush = true;
> +		} else if (mkwrite) {
>  			/*
>  			 * For read faults on private mappings the PFN passed
>  			 * in may not match the PFN we have mapped if the
> @@ -1807,8 +1813,9 @@ static int insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>  				goto out_unlock;
>  			entry = *pte;
>  			goto out_mkwrite;
> -		} else
> +		} else {
>  			goto out_unlock;
> +		}
>  	}
>  
>  	/* Ok, finally just insert the thing.. */
> @@ -1824,6 +1831,8 @@ static int insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>  	}
>  
>  	set_pte_at(mm, addr, pte, entry);
> +	if (need_flush)
> +		flush_tlb_range(vma, addr, addr + PAGE_SIZE);
>  	update_mmu_cache(vma, addr, pte); /* XXX: why not for insert_page? */
>  
>  	retval = 0;
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeFED5y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 23:57:54 -0400
Received: from mail-he1eur01on0070.outbound.protection.outlook.com ([104.47.0.70]:50549
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751386AbeFED5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 23:57:52 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mika.penttila@nextfour.com;
Subject: Re: [PATCH 6/6] x86/vdso: Move out the CPU number store
To: "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1528140269-26205-1-git-send-email-chang.seok.bae@intel.com>
 <1528140269-26205-7-git-send-email-chang.seok.bae@intel.com>
From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <8a41304a-3517-003a-badf-1ba8f7ababe4@nextfour.com>
Date: Tue, 5 Jun 2018 06:57:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528140269-26205-7-git-send-email-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.157.170.35]
X-ClientProxiedBy: HE1P195CA0001.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::11)
 To AM4PR07MB3329.eurprd07.prod.outlook.com (2603:10a6:205:a::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR07MB3329;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3329;3:CrmLpfj8RC1hqlG+Uyf2lTlX2d9fEzyx9ORSI9VWI+GtUxKW3piM6TNIOvhkH3VSEcFgV4tQZO47qNJdeLlLOb47ieqj6qk0kzaPzxhDRjA7uY80c+kT0XS9itAzhdpl1MyXHnupegbudIW+rZD20YjjUSJERYTYsGQt4jacgfYFAyD9U85x7Zo0bFTV+MOF7pmT00WJQm7/Zxk9xUxSrlYXQTDvcOy2NphxNviy5XiKE7+B5QhouDTpqN+4tXFa;25:jy+8JVFimqCQbnxD9mRPQq8yc8nUxueeVy90lMZ8dDfcwmy0pB91a/Ir5gnWsk6J7HAsmq+TMQgAEyuk1gCEMYnDnQ5RNlsjuh1HemL1bkDA5ZxyVLKDbBHBbl53KDM9ruarbhQil+DFxDrMo4XhjJ7Mpdsueue+/dnfifPVUvBUYoFlwr2FwO3ubX0mzlZpj+fiHnA8C0ZWkqcl1sFFmxHQXNHQNxDljeccgcnvkwigGe+ZTivgrnUyFQ4cx9QYfd/NueVevp71y8JFbvGl/XrnKUmV7sEQMQwmCSW+faGZ/DKOMvF8YjAWcb2IMoczFtTjJUyW/ERvrY0G12PjFw==;31:FJ5Kc25EFFukgsR6vd1YUHZHWh6EN4fbNmy1wdaR47GnQoOMxeNK0KjTRpRs/Amr914X/a6jxk+xW+RWhcoZDB94InI3/e9EV6n9FsaDM/hOf9ZdgpBZ5N3EQrYx8HqTjA6IqhF63KTayTt7uIA2KWjjvW+xhCbVFYIXlUy6JzxoQqt038wjAt57++9H2ShRGei5pU3wuufDWAEu3uC5d6A0XN8XgPCbPbk6mCHdyP4=
X-MS-TrafficTypeDiagnostic: AM4PR07MB3329:
X-Microsoft-Antispam-PRVS: <AM4PR07MB33291BAF55BA42B97499E94183660@AM4PR07MB3329.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:AM4PR07MB3329;BCL:0;PCL:0;RULEID:;SRVR:AM4PR07MB3329;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3329;4:yYwYXTzyrk4gCze9QNrl276m+mJ/bTNgrie396imC461piXDh6/Ds4lU+DB5SYBfEExeFguHaMXRyN9fql2qIiR3PXlSynq0TM/gBGz9GZyFHocOlGG4KDg/56prCHXJwWj/7nY0MTZev+IxZHvBvg9kd1L2nQzpT1Ca20l3cuWjdM7pg/ONKXEQXw59AEezJPnPILYFkvj0t2lDr/+T0SvErgXiT3zROG//W9h51bGZHcwp5WT5+RorffUQ1zQKmRB1qxxUf00ecY4V2zGOMjnJmiDQ8+dm8E8xRMnIyW72UdOyXdfFfXRUT7QOogMX
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39830400003)(376002)(396003)(346002)(366004)(39380400002)(189003)(199004)(229853002)(31686004)(6486002)(105586002)(64126003)(106356001)(7416002)(2906002)(58126008)(97736004)(6666003)(110136005)(8936002)(478600001)(316002)(65826007)(16576012)(50466002)(25786009)(54906003)(6246003)(53936002)(4326008)(5660300001)(68736007)(305945005)(486006)(7736002)(476003)(81156014)(446003)(11346002)(77096007)(2616005)(956004)(26005)(36756003)(6116002)(81166006)(3846002)(76176011)(31696002)(386003)(53546011)(2486003)(52116002)(86362001)(59450400001)(8676002)(186003)(52146003)(23676004)(230700001)(16526019)(65806001)(66066001)(65956001)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR07MB3329;H:[10.10.10.110];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA3TUIzMzI5OzIzOkYxYjRHSUp0WUhicVk5VXA2STdOVlQwSGw4?=
 =?utf-8?B?M3hpWmdFeUZibEFUcjFibFh2TGdsUms0RDFEZW0wK3JsMFZqTUJrMEErVFFt?=
 =?utf-8?B?bXZrOVJ0aVZrY3lJa21pVGhhQjRobi91T1NENm9oS0hqMlhCQWtUa1pOQjNV?=
 =?utf-8?B?cHdGYU9hZ2FzRVZHL2h2bll5VkF4bEUveVloR3N6SW5makd3a3Bla1VVb1hM?=
 =?utf-8?B?M09jaGRxS3VGVGhYTmJIajZNRmxscjJBR2NNYUdLT3AyMThPMDFzM0FxdFZs?=
 =?utf-8?B?eWpiZFErQzVKUHpvbzlIWVBybEMzOUJBaWdwaDZxNHUzNjhXUXdqZXp1MkdE?=
 =?utf-8?B?cEUyNTUxTy9UVUs3NDBsVXVaSEVoak5zdWZxaUtndVRNazZqZXltamlYSUpl?=
 =?utf-8?B?YmlleUNTVnNncE5CM2hPUTd0ejVOU1JCczZhdUdINTY5UG1uQ2IvNlJ1MlFF?=
 =?utf-8?B?S1lEM1IrNmtiVHhaS1Y1aThMMno2SkpNSjRpc0VnL1dyYUpGQ1NuWk5wMWIr?=
 =?utf-8?B?OXZBc09reVNFZi9LRUFtOVk3SDRYRjV3UTlERDFzdG9yY3hDdjFKMDRxcVRD?=
 =?utf-8?B?QURtZVdhbkZNZThISVM0VUlSUE83dzAvczFiV0RQamYzS3QvaUJUbjQ3bHNE?=
 =?utf-8?B?QXpROWs4ZGZxM1FDSUlXaU9kUDQ3a3lCcjlWaEpsSnNEZHJnNk5uVzBqZjd1?=
 =?utf-8?B?U2pYSHZSNTBBUTZBSUFML08reFdxRGQzUTNBKzZibU9VOHdrYU94RHRNeHE4?=
 =?utf-8?B?akI0NnUyd0ZsT0crT0lJRDkzTEh2QXEvTUo0Zk50TDZxT0k0OXFHa3BFNXdO?=
 =?utf-8?B?YWxyZGZiWnNVMmZxWXlLd09vOTJ3ZHhtUG1xV0dUOXVYWEJiSjNHRjFMK3FY?=
 =?utf-8?B?dnVRaGE0S0U2Y0kvOFVVVndtK1hZaENnRGxBTC84MStWTW5RV04yVU0rNFNW?=
 =?utf-8?B?bVlHaTk0TDI2OTZQRTlJd2loQSszdnpLbjhsVVg5YnNPQWE2VmJXOHErSnBo?=
 =?utf-8?B?b2tZRk5YN0ZWa1pUWTI3d012WjV2cW1sMk1SNWtEMGlmSjYrbDI0Y3lJd2N3?=
 =?utf-8?B?dXMyZSsyOG01eWRwNk9LYklpVEVWSVlCVERoczM3bWw3ckExakhXRytSWHlM?=
 =?utf-8?B?MFdMWFN5bUJobFp3bzVoZkRsRG9yTjI5cGxESUtCVmQ2b1pKQ1FaYXpjNlo3?=
 =?utf-8?B?cDJsYU1RdGlhdGdpTmdoeXNzcHdZOVBKeFpmbXZyaEVpdVhNMFFRSDJINlQv?=
 =?utf-8?B?OHZlbElLdUwwdnJ5azFrNXBkNEMxWlo1aWhvMnFkMmpnenZSUDExNHFPeU51?=
 =?utf-8?B?SUtDYUJiWnZKSFk3V3Mwcmt1cEZacXhTOVVWVG1TdzRZSittZUl1MmFycGJO?=
 =?utf-8?B?RExKcktBK2N6RHBQc21aeDZ6Y29nUFRBRjUvYWx1NTk3WTBTOXJLR3VBeHp5?=
 =?utf-8?B?N2pGdmxKZDRxeEhWcFVpNEpObHJEdDc5TWI4RlMvdW1UeUhmcmhTUUw0aTFM?=
 =?utf-8?B?eWd3S3BWUXh5aXlVVzdpWisxWDlCdTdxNnR3WnJGOGxCenhmUmJoZGlXRWFG?=
 =?utf-8?B?Qjh1VHN2Um1vVXlSOGhweEZIaFhXQXNGSWRxTU1PRnBYemduYSswaGkvb3FV?=
 =?utf-8?B?c0N4WVJhZEl1MTQvU0YwdkNGTzh3Nk51S09aenlJekUxWkNoUmpkeWQrOTZJ?=
 =?utf-8?B?ZFgwbEpycWJyeUMxZ3d2WEIwM2xSYzNxaWJVUzZsYnVTSG1DdWh2SVlwbGJH?=
 =?utf-8?B?VmtsSWt0Y1l2RVI0NXVRcjI3SytCMTEzZEV6Y2MwVGZYZ1hLSTJ5YUJqM3BY?=
 =?utf-8?B?bUIxNEE0dHk1azJSbk52cGpqaXRBK1BoWFdYTlJubWNhU2hMMDU1Zk9reG12?=
 =?utf-8?B?bTBxMkhVbFo3TUt1Sk1WQlI1RERPMm1jTWY4bStLQ1lxTmJuYXdOZkM3ZnUz?=
 =?utf-8?B?ampibkZVd3h3bkR4UkFpTU1FVGJ0Nkt3cWFzYVgxc0RKRzU0MVJUdVhCWXBM?=
 =?utf-8?B?RG9kZkdSUk0wUUsxcGduSnljSk9hVVMyY0wwdz09?=
X-Microsoft-Antispam-Message-Info: NOpIGEQhm6qXyQrDwEeFRTOhii18HuGNIG4e5er1bf6eMQ6Dp5on3Kqff/mfBpI1VriNuu4/88i2Rji8XAuM0RFdNyLTI0XUaOYrpYCogvdZkiFaTB2nwXVTXhErBwR6mRAFBLA6jZI7dUCc9Ze9hIJVqBfo5CdhbfFMEB3TPkBOQPqITzNPQWYvu842YVJF
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3329;6:HB3o7k8z44TK4zXxLdyny7AacPjkZz6B4I7EHEFNcmi0Yh1j1XfWNqZYuNEW2iG7Pbp9QlHMkcF7vedlRz6LgKzulBUT5T3L8+Xm0iLAVicayRtMI+6uyVyJ7h8I/EkscyoLxjpvOCmCqBURhKv1pJvexY7smjzjLdyOHhNXHyb6VnhLLudpqOlCvwou/GARgibrgDs0uhib2OkLrnZBVgJtxSBo6TgBQ1b3KA6Ym/zTZMdhRx6fEEA3oUt1EXN0ZBSnSAcdzEj/m+ElCCoSQv5tAg961+ZBYpgc/P0360jG0krsc9WyjGtG4TC3Gk/li7nq99Xf7xb0yfBafjND1FThDPXMWZA4Wafdj/ZF0SuJS+nfxwmDgStzHTUlMLWw7TnQqMyMht4EXFlvjhgpQm5iNm0Qll2ZI+vdvBLK+mTaUlom54DRU4dHdRIOxlwA+7WEC1+Ny2ilZgOrcCuB1A==;5:g0/q47jehFBWSE0FDZwZSzs6q+MTcIpguh/CnXo1XbLIqtUt1ogNh/W4q+ke323t+WU7pQuh6h/dLQPw80MbYRICPmv6CwXwu3HySwG8eeceR1ELQNkRt/mgrI9vYD4pbkwFeVeeN8zSmKfEhGM2bu/8nZx8NIkvOgYhPRIYSOw=;24:UBxmUTf667GOmz1GwMkJ8zz11lOQe6JLu165k9THqeE9w1SMj65UQrXPq0NoJ8VJrTMdXqGnk/aGxpTr4Xg8RUqUQZcGznCs4NxCKc9rrpw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3329;7:Aw4i1++5PiNUUx0mEbUvRaFw2FjTcRz/Sa9TXvwnmOCS8x4iRCww8X0wz5hh1NJ28c3ou+j8EsotKM49NgtXr6iQLxNf1618mjIumX7XUwp7Nb76O02dZXbSfVQB8tCrSnG86ozSEa8c4ssdyTxIj0RQJlGf+lELmD0UchTp5L0q65iP/vOfexns9J3fycxRwdye+7nL9lBsgKk9HrKwQ+xkto1Rf6riDkKS4PYlRXd4tu7QsVkhEknhUTZBC3dV
X-MS-Office365-Filtering-Correlation-Id: 3a4acfc1-2c1d-40ed-9d80-08d5ca988095
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 03:57:46.1422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4acfc1-2c1d-40ed-9d80-08d5ca988095
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB3329
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2018 10:24 PM, Chang S. Bae wrote:
> The CPU (and node) number will be written, as early enough,
> to the segment limit of per CPU data and TSC_AUX MSR entry.
> The information has been retrieved by vgetcpu in user space
> and will be also loaded from the paranoid entry, when
> FSGSBASE enabled. So, it is moved out from vDSO to the CPU
> initialization path where IST setup is serialized.
> 
> Now, redundant setting of the segment in entry/vdso/vma.c
> was removed; a substantial code removal. It removes a
> hotplug notifier, makes a facility useful to both the kernel
> and userspace unconditionally available much sooner, and
> unification with i386. (Thanks to HPA for suggesting the
> cleanup)
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---

> diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
> index ea554f8..e716e94 100644
> --- a/arch/x86/kernel/setup_percpu.c
> +++ b/arch/x86/kernel/setup_percpu.c
> @@ -155,12 +155,21 @@ static void __init pcpup_populate_pte(unsigned long addr)
>  
>  static inline void setup_percpu_segment(int cpu)
>  {
> -#ifdef CONFIG_X86_32
> -	struct desc_struct d = GDT_ENTRY_INIT(0x8092, per_cpu_offset(cpu),
> -					      0xFFFFF);
> +#ifdef CONFIG_NUMA
> +	unsigned long node = early_cpu_to_node(cpu);
> +#else
> +	unsigned long node = 0;
> +#endif
> +	struct desc_struct d = GDT_ENTRY_INIT(0x0, per_cpu_offset(cpu),
> +			   make_lsl_tscp(cpu, node));
> +
> +	d.type = 5;	/* R0 data, expand down, accessed */
> +	d.dpl = 3;	/* Visible to user code */
> +	d.s = 1;	/* Not a system segment */
> +	d.p = 1;	/* Present */
> +	d.d = 1;	/* 32-bit */
>  
>  	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_PERCPU, &d, DESCTYPE_S);
> -#endif
>  }


This won't work on X86-32 because it actually uses the segment limit with fs: access. So there 
is a reason why the lsl based method is X86-64 only.


-Mika

>  
>  void __init setup_per_cpu_areas(void)
> 

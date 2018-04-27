Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758819AbeD0QfB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:35:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47348 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758785AbeD0Qez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:34:55 -0400
Subject: Re: [PATCH v2] x86/cpufeature: guard asm_volatile_goto usage with
 NO_BPF_WORKAROUND
From: Yonghong Song <yhs@fb.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@kernel.org>, <ast@fb.com>, <daniel@iogearbox.net>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kernel-team@fb.com>
References: <20180415042738.1788215-1-yhs@fb.com>
 <20180420081936.GD4064@hirez.programming.kicks-ass.net>
 <fd14097e-31c5-0c0e-cbe5-d399299ca489@fb.com>
 <20180423105209.GX4064@hirez.programming.kicks-ass.net>
 <3a6e6348-fb23-c2f9-5bd8-928b056b4722@fb.com>
Message-ID: <8bf96497-2fc3-8d11-1c40-cb027eae44a6@fb.com>
Date: Fri, 27 Apr 2018 09:34:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3a6e6348-fb23-c2f9-5bd8-928b056b4722@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:200::6:dc2a]
X-ClientProxiedBy: CO2PR05CA0098.namprd05.prod.outlook.com
 (2603:10b6:104:1::24) To BLUPR15MB0065.namprd15.prod.outlook.com
 (2a01:111:e400:50b8::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0065;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0065;3:dIyFWoxo3AD7tIBPjjxijegSmmZxKJUiRIwN41XCwXWjH9pxUKpPzrjQ7iCifeIfPp/KZa7cYKcsAl2Xpd1p0JwPXux0QF1U1RE5ZRE24vLCv4UKYZdR1lV9zvai4hoITLj2tQp9QfvK0ejmmoQqSFu31Ysz0qSVl1SmQOL8mV6aXZvq/gDvlkxPi1H9dDNAhUlLrtlkaepycTuW6JQPQxcWHuZXvUqMvo5CEkeBxgCzeNv9pA9rp4sXHbMLDXQX;25:ii3xHKj47mKG3mG+ceOF021VxDj2G2CqSpL4ShvBnt3L4dNBmLNxrZRCYuqOUSsCVeCIdUfRHS37NYLJywImLam1ZFLD3TB5mj4Lp7B3xDFEOnuvKRnhDPFz4uuo2ojfkC7GZDyMYadFYHfCKfuPd26aQRYGpEIJvREDurr4J83XdT0npyLN3knUg/CKR5ydEWlRsd4wjtqr1bCULAXoyNE4mKKK3HkSDjNOcoTw5VT1qG3XSwVzrMGJFEDeNokCpjSDf74H31ngpphKAaYusOzh1BYcrYrvZtvBfF9NYFjpJa8noEZYHXp3Epl9t9eWGp2i2Sbs7aOQ2HdUvQhiWg==;31:rlx673oisbHWsniBZgp6ja3nWAjBZAg2VVaxkHPiNVa/ElaUF5PBEhBmn5XFwIa9mL0BOyPOqarnoB64Hhie0Pu/hWsYhbAJtil46gQ8fhCvScbkjWfdHN5ygZYEq4MDdP+Ns5+Tk//IqcODEoNp7AkOvBy6G/v5q+j5zIDS9eGuXpEvCbR2tjAmwZ9LEfCPRlGM2Q9M+Cz0wb9ZGJT7qZpYdlwUbGv33+HKOEJz8DA=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0065:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0065;20:/FRf8WTZmNyClHCtA5SOvYXpaoYtcqSc/1+Ay/TW658Gjvg2lHjT5aQ3uZvH7FMhCRkFEKzNI8e6tBbAFj2FsUduj7SdioRNMY+24gVqnEbHzoLhXCaaBvqXvpQf4S0V/BBJ0fiswgZfElUkqwoxNb4U6GjNRGbQKTGooULgfm6aQ6fj7EAYDPNrEDjwwwPCvAkif4Ghpg109+CECPn/gpoL+J3+s7HTNO0Y+nNhobFVME/NXySJFB0dSJwxpePMn1PhLfVvDtbMxSoX4CKcdrZJmaILqKFIxvOXjFV/UufNzFhE28WxuX0lcfTBKtnJ5BrprcLS7rPj+m7ZF74Cp8jaqiipv5Dp7KZo6OgaKBIwqq65AcOJfjI7WwJSr0br9TQBO+5jwEDPvBxCZj6NVQDXH7rSea/fmCJb8zC8CXVkwk0Sfj4Zs6xiBlTCTE6BVXGBQaYOP9BGNzp1TCMRoc2vHcvzmFNypajWpXSCOgNHlYYYcsvfo2wBdRbkKpY3;4:ToImYj9jQDcwqXdP/tY60+p7RuucYdvZOUvFBIAZZMzeVzbARrmYLL4lcAHdPablu7yvBeaFln6kEZFEQMXPR2TrJ2vIQxrSC7gOEwm20alUWzBFUACh2mknP5WC0f1FtqEIQPx6KsujuscOWqVxKcPkXil2IZYc1bezFuvEWW+c+KedHqIGhKX5a/aLskjYIGhtdytzJU5kCf9uTIspO0PATt+IBHDxtIUEqE7/JEdDtfEcC2U94REqkBuTU+FcMzrO9OpEXQM1pykJhrDI0w==
X-Microsoft-Antispam-PRVS: <BLUPR15MB006590D87F47B36A3B5F1505D38D0@BLUPR15MB0065.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231232)(11241501184)(944501410)(52105095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BLUPR15MB0065;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0065;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39860400002)(396003)(39380400002)(199004)(189003)(6666003)(6916009)(305945005)(7736002)(6246003)(2616005)(476003)(53546011)(486006)(386003)(93886005)(6506007)(446003)(11346002)(4326008)(97736004)(36756003)(46003)(86362001)(16526019)(58126008)(52146003)(52116002)(2906002)(76176011)(316002)(67846002)(52396003)(23676004)(2486003)(65826007)(2870700001)(31696002)(5660300001)(68736007)(31686004)(6116002)(25786009)(50466002)(47776003)(81156014)(81166006)(8676002)(53936002)(6486002)(64126003)(65806001)(65956001)(105586002)(106356001)(478600001)(229853002)(6512007)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0065;H:macbook-pro-52.dhcp.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjE1TUIwMDY1OzIzOm9Va1lUQnRqS2k5dWVhb2hrV1R2VmpCaHBK?=
 =?utf-8?B?Rit2MWd1aDJYSWFPM3dab2pwWWU4OWlhVmhBd002RzBROVVJRmtvS0V3ZjBP?=
 =?utf-8?B?bHJvN3l5MlUzK0hwUnNSWUpaY0Y3OStKTzlkdDk2dVdncFk3Zm9tbHVuZGpN?=
 =?utf-8?B?VS9ma3p1M3lhSWgzT05vZDhmM0MwNWRBdmpnS0tFZzg0eUJWS0Q5T1p3aThx?=
 =?utf-8?B?eHJNK1Q4MEpmVndNdXdrNG45U0tsRGxKckRTMk95NU53RmVuN1VrVnBHZWJy?=
 =?utf-8?B?QU53VEV6eGd4NURsem9MSWhrRlIzNUxDOFNCMDVicGtmSDRxTFVyNlFnM0Vp?=
 =?utf-8?B?YXEvUW4rWnhaaGlhbmVxZkI1eXFZeiszT3lnM2ZnTWkzU0pNTHFqQVVsUnd0?=
 =?utf-8?B?Vzd4TThuNmJpQnRwdE1wTERqUkFoNmg1WG9lL3FPTkdIaUtINFRLa0ZqdDN2?=
 =?utf-8?B?RW5UcVZQcEsva2FraU1WVG9VMkdTT0Y4WlE2ZGtyOEJ5RTdidmZhZDQxc29X?=
 =?utf-8?B?UDlVOGorZGZGdXFhOU0rMWdSTWIxZ1k2WDVhOEtvV1piT1pjRE1RUi9wRVdq?=
 =?utf-8?B?b1VhWm1PSXhpM2cxMjVPTFhreDF5Ny8rLzg0cVlVUzhNUGtSQUtGb1FITVdz?=
 =?utf-8?B?NFFQZU1Qa0NIVDZHYk5yL2t2M3h4Y2JNWnhTRDh1T0dPMHRqZ2k0alFhRFJI?=
 =?utf-8?B?VnBadVA3L1NzQTFhOFZNbU5PVHBSdU0vWG1TSmNhSWxoQzA2Vzl5WGUrRE5k?=
 =?utf-8?B?MFI4REtkbEhXeDlldUtlSWVaTXhpc29mdWRaNVJobStoRkhITFdGbmtlV1ZT?=
 =?utf-8?B?SkZwcWk3SUwvcGI2TUc5QnFaaDlIQk9sc29GdTdDQ2UxSmx5VGJpU1RCUHlW?=
 =?utf-8?B?V0dxSGtJOTV3QjVTenU4RWNneER6SnRseEFMczlEa21kUks5RVNaVmVwZUdo?=
 =?utf-8?B?RmVuU255S2dCZEtwK01OaVgyNFAzaEZIMFR0UGlhQzJoclZUQmNHMUJXMTAr?=
 =?utf-8?B?azhyMGhJNC9QbnMzMnAxT2FZZDI4VTRnSktycWVDMUhNZGJqNjFqYjNiT1RX?=
 =?utf-8?B?OGdFbGJoUDQyaTRhMUZiKzZ0RlFPa2p3Z0hDcFI1NHBtVjkwSkxLTUVrdGFZ?=
 =?utf-8?B?LzRFeU13VXNVRzN3cS9QS1Zjdmh4NU4rOWp3YzRBTTFXZHJNbVlWKzdKQllG?=
 =?utf-8?B?dCtNQ3dPV2xUb3ZNSUl4UUg4bVVkUWhSNmRMbTFPZytNYzRUODVHczEzUzNi?=
 =?utf-8?B?OE5tUWFwS2xYQlZTQ1ZBV1lCYlk4U0xtdTdPYzFYT2w0R0hOY0s0U2tNY01R?=
 =?utf-8?B?RzAwbnN2Q3kwbFpReDJ1M0xSYkp4ZHVMUHhsUnRFRmRGdmU2aUYxYnNBUjBq?=
 =?utf-8?B?QmlQUFJrTUdLNXVBb3BCWUxQL08wcVVUbzhZcmE4T2xYWGhzSkYyTTFENExn?=
 =?utf-8?B?UkJwNFVTQkV2dVM0M3dnZzltazFUZTRLZGpuVTlsaXZWTEh4SDY1elRWSWVO?=
 =?utf-8?B?Z0VuZVBhMHI4ZC90TDhqSWZmaFV0eGJoaXJNN0NIanBRdkU5VFgvMHFLdE10?=
 =?utf-8?B?VThWWkpWeFNTKzc3anpQckFOa2tnSzBkaFZ6S09JdzVUM1haWElER3NHUmRR?=
 =?utf-8?B?UnRNa0RrZDFNaTlPYTV4VHM5MmVTUHZRNUlQTllwNi9GeVV5WW4xdksvZExO?=
 =?utf-8?B?UVFIQnk0UmVLdHlWTXRHNmtxR042czRlZGZONkNOQUw4TkVySGdackZhY1ZP?=
 =?utf-8?B?UGc0RHBnZ3RyRFlBNHFHVzZTOU4wMnowcEZZVDYwRDdKa0V0eDRBTzk1VEkz?=
 =?utf-8?B?ckp4ZlM3WUxiaFQzQ1ltZzRmQnEwVUpkcnF3OTE2M01NVG4zSWhrdStncVhk?=
 =?utf-8?Q?Tmy2OYa6f2WFbWFJ5qLR/5gMHhsrrCYC?=
X-Microsoft-Antispam-Message-Info: PrcmOelS2HmFkYC0jsEEEfQvj+vQ8kOBFcXxG4sgrIqt9JMJ+cAsw6HC3Fc+Co4SoEytISncU/+z30LBX8B5a5JjMEFTNv2N6eBwSvtsw8C/nleaQB+/9FK/G4N5OAjPfCmfxaup46FXF86xw1ErpLsFs7BWCUbctwB0jgivvdgU+1GipSQIdh0p9qF+x75q
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0065;6:H7A6z5+vQjF2GL/48wpIUyJ/fARV92UdiOJXxUiUe8AyvKj30NB+6xaiREfi2cis6l7APcM5GEqR+soqoLHdbxVBYO/AhXu00oxXijov9s6e/nFagk29INl7Z7sADUztTPnzEFg0l3hiDtSw4gVvNLZTMW4lh5oQkyZB0ylh1389oPA/djMYMSXXWjYx947PkxWnESAtBBsH2wtbX5e/nNs3OLbtg0RNuA7VNdnWAexmfzdRullLXcrwwrU7q+b4jMKj2Z5/jsRnQeoJG7u1n7ZmNxOAZElFvq3NRx45WaGigJ3DgYzwvMHl1EB3t4E2R/wGtDcV7rVV1lSjbTz5iWM285MNscbfwbElypYZ6xMacp16yrVjzBM+JBPBtDGP2+tsw2gDYA6pTfa1TK9FEFLdjfqvXZ93gLKfhgUNVN2sW8PugbnGYWBORd7aTId2I5LlX2wg9idjYqmyzE0L3g==;5:C8LN7rrXP6J2UUtwp4Akov1oeronPhpbjf0wo0lrT78/g953+GmQnOx0Xqvvch2jrooV+2k2xav6bpVAIZj2SmwS0akI5V6AeQm1eU4cu2bREpWJ84K0C+f01Trp6STVMPAPnAXNZ7/vcVksrIDv7JiufT2R7wCupFg0dTUDG+Q=;24:KJ+x5yznicYtAK6ZxR9Xod2yXAEua0Bz8qv+rEYu3I4gs7GzPOzUUKMGfDlvBczOnZ+7oxTfYuq+YSQ+/nYHqf5+axjRczHZVxffeVRlVW0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0065;7:hKWtXo4D/kVNf88a+RrqXiwVmIgt99Y8agjWy7zeAGG5HXTEnEI0VCq8thrHZaYqPUbq4DOU2DB8VPeSILp0YFLWPiuNgXwcDKYHLv5Hwbf0VrSLw9m71S4QDCJBBwCHUEvi6xKcmbvUOlXW02LQD2Ig+O2NqJNnRvtBAvWPBvsil9r/6lq8ms8hZZsMzgYOYGbXnWuLw6muZa5wl9tWjpgLC2J/vH/AkJ9itrA+xdLrc16AZDV+NnS6hCz/S4aL;20:UpKzSvhrSZMHVq/sLTGo0u1/BSnmlgo0vgy0gHY5SFVq36aTf+UFfj7ohnubG2SQSZSvlOZrNtjGmOviu9EH+HHnnr1pnYHKykH+z5sAOoazvgIi/YZ9hTwUuK7lTxn83MWxL7LlBiH9L6eQ5CnKkcjC9OHuZwnbKJIRHgjYn1A=
X-MS-Office365-Filtering-Correlation-Id: 88d82e7b-e888-4ff1-a518-08d5ac5cb432
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 16:34:09.2820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d82e7b-e888-4ff1-a518-08d5ac5cb432
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0065
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,

Just wanted to ping again so that you did not miss the email below.
Please let me know your opinion.

Thanks!

Yonghong


On 4/23/18 9:50 AM, Yonghong Song wrote:
> Hi, Peter,
> 
> Please see comments below.
> 
> On 4/23/18 3:52 AM, Peter Zijlstra wrote:
>> On Fri, Apr 20, 2018 at 11:06:03AM -0700, Yonghong Song wrote:
>>> On 4/20/18 1:19 AM, Peter Zijlstra wrote:
>>
>>>> Hurm, so adding __BPF__ for BPF compiles isn't an option? It seems 
>>>> to me
>>>> having a CPP flag to identify BPF compile context might be useful in
>>>> general.
>>>
>>> With "clang -target bpf", we already have __BPF__ defined.
>>> For tracing, esp. ptrace.h is included, "clang -target <native_arch>" 
>>> where
>>> "-target <native_arch>" can be omitted, is typically used.
>>
>>> The reason is the native architecture header files typically
>>> include a lot of various asm related stuff where "-target bpf" cannot
>>> really handle. We relay on native clang to flush out all these
>>> asm constructs and only bpf program needed stuff survives
>>> reach to backend compiler.
>>
>> So because 'clang -target bpf' is 'broken', you do a work-around using
> 
> 'clang -target bpf' is 'broken' in this case because the x86 arch has
> a lot of inline asm's in the header file where bpf target cannot handle.
> For most networking related bpf programs where `asm` is rarely involved,
> `clang -target bpf` works fine most of time.
> 
>> 'clang -target <native_arch>'. But because that doesn't set __BPF__ you
> 
> `clang -target <native_arch>` should work, regardless of whether __BPF__
> macro is setup or not. The reason it doesn't work now is due to its 
> lacking asm-goto support. So to use `clang -target <native_arch>` is not
> really a workaround for `target bpf`. It by itself should work.
> 
>> want to add NO_BPF_WORKAROUND to the kernel instead of adding __BPF__ to
>> your build rules to better mimick -target bpf, which you should be
>> using.
>>
>> How is that sane? Why not use 'clang -target <native_arch> -D__BPF__'
> 
> To workaround the asm-goto issue, the suggested macro __BPF__ can be 
> added to user space and kernel. But note that `clang -target 
> <native_arch>` will not define the macro __BPF__, so this requires
> user space change.
> 
> Also, to make sure people understand that this is a WORKAROUND for
> asm-goto issue and is not a lasting thing we want to support. I have
> the following change for cpufeature.h:
> 
> diff --git a/arch/x86/include/asm/cpufeature.h 
> b/arch/x86/include/asm/cpufeature.h
> index b27da9602a6d..c832118defa1 100644
> --- a/arch/x86/include/asm/cpufeature.h
> +++ b/arch/x86/include/asm/cpufeature.h
> @@ -140,6 +140,7 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, 
> unsigned int bit);
> 
>   #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
> 
> +#ifndef __BPF_WORKAROUND__
>   /*
>    * Static testing of CPU features.  Used the same as boot_cpu_has().
>    * These will statically patch the target code for additional
> @@ -195,6 +196,9 @@ static __always_inline __pure bool 
> _static_cpu_has(u16 bit)
>                  boot_cpu_has(bit) :                             \
>                  _static_cpu_has(bit)                            \
>   )
> +#else
> +#define static_cpu_has(bit)            boot_cpu_has(bit)
> +#endif
> 
>   #define cpu_has_bug(c, bit)            cpu_has(c, (bit))
>   #define set_cpu_bug(c, bit)            set_cpu_cap(c, (bit))
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 4d6a6edd4bf6..b229e5090e4a 100644
> 
> As mentioned above, user space needs to add this new macro definition.
> Specifically for kernel/samples/bpf:
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 4d6a6edd4bf6..b229e5090e4a 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -255,7 +255,7 @@ $(obj)/tracex5_kern.o: $(obj)/syscall_nrs.h
>   $(obj)/%.o: $(src)/%.c
>          $(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) 
> -I$(obj) \
>                  -I$(srctree)/tools/testing/selftests/bpf/ \
> -               -D__KERNEL__ -Wno-unused-value -Wno-pointer-sign \
> +               -D__KERNEL__ -D__BPF_WORKAROUND__ -Wno-unused-value 
> -Wno-pointer-sign \
>                  -D__TARGET_ARCH_$(ARCH) 
> -Wno-compare-distinct-pointer-types \
>                  -Wno-gnu-variable-sized-type-not-at-end \
>                  -Wno-address-of-packed-member -Wno-tautological-compare \
> 
> Please let me know whether this approach is okay to you or not,
> whether the name __BPF_WORKAROUND__ is better than __BPF__ or not, or we 
> could use the earlier approach which does not require user space change.
> 
> Thanks!

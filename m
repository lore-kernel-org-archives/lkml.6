Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbeEBOCZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:02:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32774 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750954AbeEBOCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:02:22 -0400
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
 <8bf96497-2fc3-8d11-1c40-cb027eae44a6@fb.com>
Message-ID: <0bcea2d8-c088-f8f5-ae76-4ce5f974e291@fb.com>
Date: Wed, 2 May 2018 07:01:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <8bf96497-2fc3-8d11-1c40-cb027eae44a6@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:180::1:661b]
X-ClientProxiedBy: DM5PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:3:117::15) To CO2PR15MB0075.namprd15.prod.outlook.com
 (2a01:111:e400:5068::25)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:CO2PR15MB0075;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR15MB0075;3:fvXTqELvntDpBPesuBmmTux00jMwjrKrlJwuwEuN/dTwVUsIZsEPSYaW+BARbyJrOdPzy7TL7OIYhv7YvZ7Tho/P01obCbMg4yfxDDvu04/FhCsNYTEviZP+6soaLzVaAt68LOgZJk+oiL7+pbqW7kvJjZIaN4AF0+lGlOvGmG35MbML/aWSqyEl/W661goJ0Z/iKrHDz5Ak83JqrtQonXeaYiQDzEv50gDurFxduVIhpjtjL9HnIKmKXP0O29+8;25:fxnbCf1UwloQJXjPXvs4RKoFFO0I1I6R3FHsux4jspd/U3PS77cQMKfDubdaAXEGrVkQ9n5g6h98943WkMbGXymOe4yOl/v1VAA9djv+B9ezbdHtF9D/+YjFRFm9fo2DT/84zYfeNe9rcdP7SV4yEeUfErgQJkQvFAbdYT5p13AaqTyr4HNd/tnEk40jnZbcgFcn8EbziGnRJJ47ZrzhX6vlC8HywLGupvMpPwr3mbUOnZU/6JwXT4a3WKjWuw7e+JLWtLGH3DvPfyyHLLk5j5RQYQ2GsRjd2PjPm2GQTXxGip3SSqo/BEE4EN5Y9H34CHlUCPDe2Wg+Ne6F38xqDQ==;31:YeX9qn+82mlfsJ+LSqkguG4eJ8MjIzCE2EU6f5swp9/KzF3b3MrIDgnrJd801KeX6wwwxRxZZ273ECTQlt/OuhrGDoDqcU2Z5pJOqI9liH8AJ1+FEr0QVZOhTDyFfVeMRgZHmvyiW/bFcxthgjCPyb0vVj0+GSR1mq717w6m/B4I0Mgjyp2mDGjuhKYztH99XLaO2WxDBlkT5WVF9x7c/O7OBTwCaFgRoKLcI4PRNgg=
X-MS-TrafficTypeDiagnostic: CO2PR15MB0075:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR15MB0075;20:7Fydh/hWvVd6dh2sX2qJCSKHljAWBYpU5QP8Uza3smIfgbi/IoMlY0pJyDjZyZLPuX+quk5ibV4DAgAyV5AG+NCtU9loiiX8rNgi6Ap3qh52XPqoNcB6FN9mV1X6smQ+AChm0mqHoUyMZFv9LpqiWo229NtR1m1ZgSD/yjzjxzslKfrg0livs3omgSuDr+tC15yHL9byryOk+tmXxMNn6vGcNydHHF53ytwWsfi3JWwz8dbO2yQHwfJH2cfoa/Dq9dcbma/dH3pap8X+XsGw+UG7A6iwI1J3Tp5zNpkdTq7bTUVe6vZWzWDSF7N9DDTZkGjREX9DqlUPLLhRy4yHFdN/pZnWGesvGW5JN4atb98wrhGZOxYwL2D6y1717aOBnf4sYAVFDthvG/tQI+aE4OwwT6SeWaTuGt61582u2avzQoRjmQ9HA2HV0x4u6FJL8+9sFyyulXnexSQE3Lthsiatuxw75d6B2BVArz501wfduf3Fuc6uEgWJwVuW6tiA;4:YAN0Rnk3NPqCd7qRIOiXrgyr1Xru7UrJAhmAEaAEGs+TiuGgLOImVLf3WL8XisVHGahlNYHjKKxzzU6DLlcQoym1PfV1K1RhtdqjA1FWcOSrEiFOVBs6/5LfIIQ0DmMAIAFLP/2nePI2OZ3kCK9PKH0DqcJcZDZKlomyRZSeqO2yoRxNlzCg7vbQgkhkqySwfHA4FBkkfEZ2OeGQLQzUbMzNBNJTOcv8Ayb1B/8NMKaO66WI6rVLQREfhz2AYW6Mk1BzWNwwnSdVI+j6mV6l1g==
X-Microsoft-Antispam-PRVS: <CO2PR15MB0075DFB78662EAE95161A95FD3800@CO2PR15MB0075.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:CO2PR15MB0075;BCL:0;PCL:0;RULEID:;SRVR:CO2PR15MB0075;
X-Forefront-PRVS: 06607E485E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(346002)(39860400002)(199004)(189003)(53546011)(31696002)(64126003)(7736002)(2870700001)(6116002)(50466002)(8676002)(6916009)(67846002)(386003)(8936002)(86362001)(105586002)(6506007)(6246003)(476003)(65826007)(305945005)(2616005)(478600001)(106356001)(6666003)(23676004)(52396003)(486006)(52146003)(93886005)(6512007)(53936002)(52116002)(2486003)(76176011)(2906002)(68736007)(6486002)(229853002)(446003)(25786009)(58126008)(31686004)(65806001)(81156014)(65956001)(36756003)(11346002)(97736004)(47776003)(5660300001)(16526019)(316002)(46003)(4326008)(81166006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR15MB0075;H:macbook-pro-52.attlocal.net.dhcp.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDTzJQUjE1TUIwMDc1OzIzOnJyZ2VrazU1RnlsTWR1eUVYU2hVR000MGpS?=
 =?utf-8?B?OVBld3VBTnhFS2YvQnhtNElVcjVzQ0dlYW5GWE40RUl3Ti8wMlgzSWU5WHV3?=
 =?utf-8?B?YnJZVzlMLzJueHF5L0tCREZOd1RSMDVCZHhhSDlDMWFSOUsrdkJTNW5xSGNK?=
 =?utf-8?B?eGpKRmJqVEtuZUZSV0ZKakxTVzRPS1htblgwZGM2aTc4N0FDMURlVlpSQnVS?=
 =?utf-8?B?bUhoVTdVV25HK3BYNDBrblV0OE92SFpvek9UNEtXdTlaTGJ3RXJ1c29PTFY2?=
 =?utf-8?B?TjA1ZDFIcXlvTTJKM1g5cWl4RWlTSDZiNXRrajJqelRzSnRCalpBMUN2Rzda?=
 =?utf-8?B?T1ptTnRwckZpdXplOEJMKzNyNWtlRkVPTGRMZDJNOURUaVBqR2tvNzgwUUwr?=
 =?utf-8?B?R3o5eEIwajVzakhGT3BhaC8zYlQwZXFqbVhzUGxZTnR0WGtOYjRBSGZ4ZVJP?=
 =?utf-8?B?Q3RlNnM0QVBHQjk5YVpKMXdXUkFORzA1d1I4QjlIcXF3d2ZRRFFFcjBYeHJr?=
 =?utf-8?B?d1kzS1hkVWM1aURyNWhER2hLdUJLU3BtVTB2aXAvMENqUzI4WkNpdGxkclNG?=
 =?utf-8?B?a2R2amxtUHhGZHFtN2JxeFlMbTdweVp1Rk5ERzg4VzhzbEJCbTBqNWlZSU5G?=
 =?utf-8?B?dzdPMURyUlQ4UmF4dGR1OTlPVVo0NGUraEs0ZDNLTjkrS3NDYzg4WEltcXYw?=
 =?utf-8?B?ME9tRW81Y2NCY1JxVGE2SkdLejVuek45L2J6ODlMdi9DYkgya0NlOWNSTWxJ?=
 =?utf-8?B?b0lwVWJ4MkFaUEdRK280Mm5FL2E0VERNU09OQkFBVTZ3ZHFJSFdTVU52THQ5?=
 =?utf-8?B?SXZkZ0lSZG5iWGJ2TDlSZUU0Y3pBakVtWENlRVhvaTlIMlZ4Vkh0QVRRdmdp?=
 =?utf-8?B?RU4rVjdyUFpEYWkxSkw3TGtPSUREa21remMvcEN3T1E4ZnE5cTBuR200c2p6?=
 =?utf-8?B?M3J3NXJ5OGNYM29tdjU4KzF1cmRwMitQWkpQUkRoN2drS1l3VGhOd0hMNEds?=
 =?utf-8?B?VVVscUhXenY4NDhKa2Ixdml6VU9mbFE3dTZRQ1FpQmlUVXdDVnVzV3ZaZEtm?=
 =?utf-8?B?UlhKbkNDTlliMlBKWTJ2NGgzVnlOM3EvdHRncXJkaE9kZ1YrNElybzQrT2s2?=
 =?utf-8?B?UlJxcFJBQkxEUDUrU2xkK0xrSXVtWVBEcXRWME9HcGZUWG1zVnZGbWtWVVRH?=
 =?utf-8?B?OXdCZ1V5TzR2SGNSdWtHWFVwcTVzTG9ZVmVrSEdmUVFGRlNWbExMa05XQTdD?=
 =?utf-8?B?VGxTaTRrcEJOckcvbWozNlRmeUZXMjVub1BESGdVQU5UOHRmSVppanNScUtj?=
 =?utf-8?B?YmN6R3ZJZGYwUTJRLzRDaFltdzMxNnpWTjMwdENVMzJQbGhyVWFySUFVSzRx?=
 =?utf-8?B?anR6UVQrUWlEeWhlbCthWU5nSHVtVmF1RytNaUNVU1piejVKNFlKdXY1Sy9R?=
 =?utf-8?B?ZnAyS3MxYWVScm1Kd2M4MEFMZ1BDekJ4emNqaFJDaXlxUVBML2tDZXpNbER2?=
 =?utf-8?B?elg3MkFGYlVJY205VWIyM2dlY3Y0QWw2R2pNWS80bjZqNVBDK1dUOFU2UTNl?=
 =?utf-8?B?L1pRdktsOCtwK1hpeXZ4aW9vQXBXTlljMnRNdEl4MktxcGJVVmRPUHlmK2FG?=
 =?utf-8?B?R2ZVc0ZaaStCc2xXMDhLN2RrbFA1QmtHanlrVUVoeGp1d3BCbUo1bHlLZi8w?=
 =?utf-8?B?ajNkeXhraERvSTIxUDBjU2dDTmFSeVFLZFlDdFNQZjB4LzNLN3VGaVBFaUcz?=
 =?utf-8?B?a08rSkszZG5JTVQ0L1F0Y0dmajNsamd0L3VOd094Y1pIRFNBTTZta2lNWloy?=
 =?utf-8?B?MFlhMGo1TEUxZUYwZ0RreE5DLytHL0IrWmhyamtlNVpEL2dsMEc4cVkrcnBE?=
 =?utf-8?Q?UCy6YRCE2/NrSiQb9ZtiGoxRH+ISroXt?=
X-Microsoft-Antispam-Message-Info: gWtEcdknJtzoyOwuwa/11pF803NI2/YpSCbQi3IBc+veNh06V1aHppDrTfihuOZwEs8U672VaWdBVOeP9jIHWcGVJfQddDIU9tsF3NKX36e/5zny3FH5+AxP4h0MvogPJG8GtozSNHqUbNqrR9/OmXSYpvUOWsVVD7nAXXRhTGiYW+i3NRS4Dy9cwNa/Vc0C
X-Microsoft-Exchange-Diagnostics: 1;CO2PR15MB0075;6:o0KXiH66yEVRAsfT8iEplCsZ4Jauu+A2UkSwDEXFRPEGc/8mUFgw3X4Na3kBIERuptOoGdEYUh1htL82iuOv23Nf1RJ9VC6CKj41eZ0VrVwK1Cblz+LzwFO0QyQEnyNVWcT04q1mhNecW3ZpHm5MWKqZibvz5/YXV/o46mAa5a6ZD3z94aJMtde+zn2b5SkjJhcuW0+BCwz61Np/p1KEYkCnE9WROhzVNOpwtVZhwqDYDvCuBO/SvIm4ij66IjI9cAlVmawyrd17tlziPr+LZXnjKD/rW8zzqw+N8emG/zhG4WcMU5ivn2FoVjmFLxZpys+0mI/NgsDKfDBP/7RT//24c1kGiMiAGZWJfBUh39QhkqCAWt4k31JPyb5icc7NWFg7KqpX+a+2N7VpNxMQYB5ScKVzT9YSxUriztIegJgnbSeFVc66NP34tg8151H2aA3z96HqL7wpumvU5YDbPw==;5:xgrEQJ//dr4TmcAzkXHYHE8oRrXFUHujUdYlYYqiNuUjoHgkpsmjAAaYD4+l69SuGLoHJEKUVXlUD6PAYUabSWVqvrVAuoTWVBWE1sHkCca+QE7A73Og4rjYBzaaJWId6+Ffo8bJoECXonNpmkyt/wcO24klmCedVk56jLu5XeQ=;24:48GM/DkxqIGU8V5E5chcblPKw/RJu91msIn6q6aNV5OP4IBB9++mK8aM4JvCohxwOB/WBr+M0sE2zJ2htE+BHLEAsM45BWHeUNY8ciuM9lE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR15MB0075;7:uj2nzGUcmAYrXBcRud5MFVvUJTcosHogfX8hyMfJAWY8tYUE66wlEH8iBkxa7QgOUjeTiRRgmETSJbQ1c7DXHSoDYRiqt+FlHkOC/3xXkl68fyH52EH+z6J3uYnJyCSqVS655+eBenqabyBD9L0L4ldz4McsJ9NPaXZ8/+7I9OeK8Z7mK5PRs4EegSCxoyHO8rhcycK8yGZd5nmipn0G5EZTOcIWBe4dLCWD/v6Q0LDQj/AkWjmSAnS+cieJJiYw;20:AvEw/V3YlhRHO2Hds7voFgbOkTRUlBy7YeHSaUvN4Dw4z7Nlsyg0uK8B6bHAbTdsYL6tEESMOi8zh31gni0nSChZkOuB8KAB3DEc5UEJ7Ku9YeMfzjhew8MQZ56MddJ3lBolAXRI15zRXoCM//tI7vbUUsLIIt/WEtDsyFpFtbk=
X-MS-Office365-Filtering-Correlation-Id: a045ef54-38bd-49e4-03e9-08d5b035361b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2018 14:01:31.6850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a045ef54-38bd-49e4-03e9-08d5b035361b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR15MB0075
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Peter,

Ping again. Did you get chances to think about this issue again?

Thanks!

Yonghong

On 4/27/18 9:34 AM, Yonghong Song wrote:
> Hi, Peter,
> 
> Just wanted to ping again so that you did not miss the email below.
> Please let me know your opinion.
> 
> Thanks!
> 
> Yonghong
> 
> 
> On 4/23/18 9:50 AM, Yonghong Song wrote:
>> Hi, Peter,
>>
>> Please see comments below.
>>
>> On 4/23/18 3:52 AM, Peter Zijlstra wrote:
>>> On Fri, Apr 20, 2018 at 11:06:03AM -0700, Yonghong Song wrote:
>>>> On 4/20/18 1:19 AM, Peter Zijlstra wrote:
>>>
>>>>> Hurm, so adding __BPF__ for BPF compiles isn't an option? It seems 
>>>>> to me
>>>>> having a CPP flag to identify BPF compile context might be useful in
>>>>> general.
>>>>
>>>> With "clang -target bpf", we already have __BPF__ defined.
>>>> For tracing, esp. ptrace.h is included, "clang -target 
>>>> <native_arch>" where
>>>> "-target <native_arch>" can be omitted, is typically used.
>>>
>>>> The reason is the native architecture header files typically
>>>> include a lot of various asm related stuff where "-target bpf" cannot
>>>> really handle. We relay on native clang to flush out all these
>>>> asm constructs and only bpf program needed stuff survives
>>>> reach to backend compiler.
>>>
>>> So because 'clang -target bpf' is 'broken', you do a work-around using
>>
>> 'clang -target bpf' is 'broken' in this case because the x86 arch has
>> a lot of inline asm's in the header file where bpf target cannot handle.
>> For most networking related bpf programs where `asm` is rarely involved,
>> `clang -target bpf` works fine most of time.
>>
>>> 'clang -target <native_arch>'. But because that doesn't set __BPF__ you
>>
>> `clang -target <native_arch>` should work, regardless of whether __BPF__
>> macro is setup or not. The reason it doesn't work now is due to its 
>> lacking asm-goto support. So to use `clang -target <native_arch>` is not
>> really a workaround for `target bpf`. It by itself should work.
>>
>>> want to add NO_BPF_WORKAROUND to the kernel instead of adding __BPF__ to
>>> your build rules to better mimick -target bpf, which you should be
>>> using.
>>>
>>> How is that sane? Why not use 'clang -target <native_arch> -D__BPF__'
>>
>> To workaround the asm-goto issue, the suggested macro __BPF__ can be 
>> added to user space and kernel. But note that `clang -target 
>> <native_arch>` will not define the macro __BPF__, so this requires
>> user space change.
>>
>> Also, to make sure people understand that this is a WORKAROUND for
>> asm-goto issue and is not a lasting thing we want to support. I have
>> the following change for cpufeature.h:
>>
>> diff --git a/arch/x86/include/asm/cpufeature.h 
>> b/arch/x86/include/asm/cpufeature.h
>> index b27da9602a6d..c832118defa1 100644
>> --- a/arch/x86/include/asm/cpufeature.h
>> +++ b/arch/x86/include/asm/cpufeature.h
>> @@ -140,6 +140,7 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, 
>> unsigned int bit);
>>
>>   #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
>>
>> +#ifndef __BPF_WORKAROUND__
>>   /*
>>    * Static testing of CPU features.  Used the same as boot_cpu_has().
>>    * These will statically patch the target code for additional
>> @@ -195,6 +196,9 @@ static __always_inline __pure bool 
>> _static_cpu_has(u16 bit)
>>                  boot_cpu_has(bit) :                             \
>>                  _static_cpu_has(bit)                            \
>>   )
>> +#else
>> +#define static_cpu_has(bit)            boot_cpu_has(bit)
>> +#endif
>>
>>   #define cpu_has_bug(c, bit)            cpu_has(c, (bit))
>>   #define set_cpu_bug(c, bit)            set_cpu_cap(c, (bit))
>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>> index 4d6a6edd4bf6..b229e5090e4a 100644
>>
>> As mentioned above, user space needs to add this new macro definition.
>> Specifically for kernel/samples/bpf:
>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>> index 4d6a6edd4bf6..b229e5090e4a 100644
>> --- a/samples/bpf/Makefile
>> +++ b/samples/bpf/Makefile
>> @@ -255,7 +255,7 @@ $(obj)/tracex5_kern.o: $(obj)/syscall_nrs.h
>>   $(obj)/%.o: $(src)/%.c
>>          $(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) 
>> -I$(obj) \
>>                  -I$(srctree)/tools/testing/selftests/bpf/ \
>> -               -D__KERNEL__ -Wno-unused-value -Wno-pointer-sign \
>> +               -D__KERNEL__ -D__BPF_WORKAROUND__ -Wno-unused-value 
>> -Wno-pointer-sign \
>>                  -D__TARGET_ARCH_$(ARCH) 
>> -Wno-compare-distinct-pointer-types \
>>                  -Wno-gnu-variable-sized-type-not-at-end \
>>                  -Wno-address-of-packed-member 
>> -Wno-tautological-compare \
>>
>> Please let me know whether this approach is okay to you or not,
>> whether the name __BPF_WORKAROUND__ is better than __BPF__ or not, or 
>> we could use the earlier approach which does not require user space 
>> change.
>>
>> Thanks!

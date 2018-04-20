Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753571AbeDTSGv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 14:06:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48200 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752749AbeDTSGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 14:06:48 -0400
Subject: Re: [PATCH v2] x86/cpufeature: guard asm_volatile_goto usage with
 NO_BPF_WORKAROUND
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@kernel.org>, <ast@fb.com>, <daniel@iogearbox.net>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kernel-team@fb.com>
References: <20180415042738.1788215-1-yhs@fb.com>
 <20180420081936.GD4064@hirez.programming.kicks-ass.net>
From: Yonghong Song <yhs@fb.com>
Message-ID: <fd14097e-31c5-0c0e-cbe5-d399299ca489@fb.com>
Date: Fri, 20 Apr 2018 11:06:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420081936.GD4064@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:200::5:bd22]
X-ClientProxiedBy: CO1PR15CA0112.namprd15.prod.outlook.com
 (2603:10b6:101:21::32) To CO2PR15MB0073.namprd15.prod.outlook.com
 (2a01:111:e400:5068::23)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:CO2PR15MB0073;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR15MB0073;3:O1Am9BOb2KXYvKf63xFgXOp/5OAaT+yXPEwTPLGh/2+V2zFqlnCQf44Dvs9KWFNyo2Q582HFGXo/ap4ldt965N8jwnJiv4+kfHio0mXL9wT/k08cZUBqiZPS7mZdi7pGXwegm087wAUlsPUSKRMA1U+TYB90rGGM0WiY1j7airncin4d5ES36JBhkufvomiHwzYx9kSjFsvr2xqpxpWMt5mGVApOVUci5P70dqpY9FoY9EgHlyhq6kEsRyEK5l6h;25:NHiGvhq+B+7QaeZhs5YiKm0/eeTOJ31QN7zg9ebhDd3S5O1yQteGXujrKF1AwgsLElrMCNkUqWsP8meuVD3SQXdnfi7QrhxGkv5l/pR3ePpchjPHfqXVoBA7EFYFh64PmWjs2THznrh2eITy1xCSxcc2oU0+YVLhQSgEjzumtheDxbpGX5uu7xDmZZUDv1ctJ6VWA3GDnJfWBhqTYowv/H2fv0SZtgWjp5J1Jg8s4TnI9DYoj0rwMwUaiCCbtprjWRvzoj1NP1qTCPY6wKNB4DAz0ihVBsI5BersS57W0yyWX+F7drNdUyG5XgMnlWMLC4tb/lLzY/X6meDUKZXgPw==;31:m1hxjoxfRHFoDkgoVZd7ameMJ3snB9cr2WJJLFnPFJQnqGFqcLMG2FfPdv8sqKuraqYT2gBngkuEJizvWFG+h8nvLNENYdPLfS8406dYbMLSrdWwpEJ6v2EWiVFY61ZR8/BVRgiZG+aE6n3UiQ0WwaNjvNn/v49AvOdT/P/W8ZHh82QyKP0k08XKp+hXpGi9NL/I/hX1wNI3sUj6s8lPejYU3pwxOQvW8f49j/y9yhE=
X-MS-TrafficTypeDiagnostic: CO2PR15MB0073:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR15MB0073;20:AMDacv2Ac6X0DdPYo/Bz20p3r+V0bWoYd2n3NEtYQue+RLVw0L/nbKFb+kTbQYWGBThMQFjB+/3cKGhA4wipItb97GQ/27rjaa50Nsr8i2yAJ6ijlpifhv9fUoKXgJ9lIRIs1TZxMUUu4jLOaGpOEtm5nZ92y6rryX0OfrLLzgpA7/kFzHFd1As9AXPidLj3k4Fbn32jHF4noTv79aizTiyuNjMtAW1c2Iv4vD3J8iQCN9e2NdZCL2t8ts3W+bTwNMJuP25pYewO+RK5GMzUo5sH3OU5RHe1t2cYswpexAre86TsIUUlndThr5/2kwucUImladfl8qEXm7IBBbk6VXmreweRoANIsd8hlMtlekZC+Gm9boKB8ak+/Fp0BdESsEOfN53iIjnjXwyuuGTBJpAc19U9zSrdkEb6CGqAdUuwh/+Ovt6ILHh0F1Q8u/CkcEgBaD/fQETrL4ogwIcxdfjc5UVuEB5VCXs7tYfzBZGtIH8UNpPDdzIf6SYYv/8m;4:AkaZj+pdTK+V6sLj5Ifn7QGiOMMH1ZuQ7ixUPq+oYiYHJXBVUFTIeyeUBAWxjYWpCXj0snfyDZQS09OY8m01fK7Duh3NJqXZ5VhDaCbaz3lO9Sd5lThtnE2PKE2ekyuab/FADyxKzH7SyeJcJ9N8mTMKCZ9lAuVhviDceQVMQTarUn5Apk9WPwTV0ze5I111L0Ivd81FtjKGT1nh0sFGBVoComjbGRCJ3PhnfFM3iHQO/pcTv7KcAiSXNXkYafXEgm5Ol+3S94hvfeSqT1xSFQ==
X-Microsoft-Antispam-PRVS: <CO2PR15MB00739D6B2B7B28AAED3F6A62D3B40@CO2PR15MB0073.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231232)(11241501184)(944501396)(52105095)(10201501046)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:CO2PR15MB0073;BCL:0;PCL:0;RULEID:;SRVR:CO2PR15MB0073;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39380400002)(39860400002)(396003)(446003)(6512007)(81166006)(53936002)(31696002)(25786009)(47776003)(11346002)(2616005)(6246003)(476003)(6666003)(6916009)(305945005)(5660300001)(8936002)(65826007)(4326008)(478600001)(86362001)(7736002)(8676002)(2906002)(52396003)(52146003)(23676004)(2486003)(46003)(230700001)(50466002)(67846002)(76176011)(6506007)(53546011)(52116002)(6116002)(36756003)(386003)(16526019)(6486002)(31686004)(316002)(229853002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR15MB0073;H:macbook-pro-52.dhcp.thefacebook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDTzJQUjE1TUIwMDczOzIzOkR0UlRPOU1Nck5pTXZmWUhVUDBHeUZZMmJs?=
 =?utf-8?B?SGRtdG10elFET3ZNK3cvdGpjTTQzcGRWc3JTaUhYblBWQ05Xd2ZjekVGQ2FX?=
 =?utf-8?B?cGY5M0hIMitXSWo4NnJiWXloOXJIY3BSMkhkeUcybkdSQVdBMzB3c0E4U3Jm?=
 =?utf-8?B?WWVvYnN3ZlFFa2dreWpNQXNndUl5MzMyN25kNE91WC9EN1Q5WHZSaVV0R25B?=
 =?utf-8?B?dEhZbUpFZHVydVdqNWJNa1BYWjA2VTZ4TkFrbXhBTHlYYkM2enh4NDFKR2tt?=
 =?utf-8?B?V2xQb2pYVFZoOW1rRnhQWUFqVTE3VFQxWUFnT1Z3WGJQMVZIclYxQ3E1RE5J?=
 =?utf-8?B?dExSelVkaVltbzVKbFNEVFBHVWNSQ3o1bEMydkRQeWZwMW9mL3NZVkRMb3lk?=
 =?utf-8?B?Y0N5d1ZlZ3hRYjBRRWZaRjg0RjE0TFpITlhqQVhnb0srem44SW9JeTRQNzJT?=
 =?utf-8?B?WkR3OU4waUU5dGZ5eW5lWUdvUzM3UG9TVjhySlYyTjJsMFdJY29OTG0vTGk2?=
 =?utf-8?B?SjJqNk1NT1hOUHZhamViaE9wNURrYnFrWGZjTFVWb3docUdyejZEZU1iNGVa?=
 =?utf-8?B?WXFZa20xWnV0cVM2VkVadkR1bjNac3RmMngveGl0bnZldGQ2TXNwcTlvdEJu?=
 =?utf-8?B?U0x3enNaaHVUNVdpTGJFSWZqV0MwazBVckZ1V3ZxKzIyeWhsNzhQMGNCSjN0?=
 =?utf-8?B?Q1JTVDBvVWxOcHFDVjJDU1dKb2dxTEtNYjVMMWFaTHQ1WnJuQzU5UWNSdTZ6?=
 =?utf-8?B?ZGk5WXNZQkc1WDRTNmVwWm95NDNCWW5QSXV6bHp1S1hRN0RSdDVud09xYnky?=
 =?utf-8?B?d3NGT0RTNEZsWkZiTDlXYjVrUGFXV1ZOUUFTQ3dITFZBR0RadU8wTkxkUEpu?=
 =?utf-8?B?cUN2aUFiMGtNOFNXOC9DQnVyRlVSa0JTaG9vODVLajNmTkQ3ZW14a1JCSE84?=
 =?utf-8?B?QWhHWklVM2RCeTFEbkYyYkoxL0tETk5DM3M4T1ZUQWlTV3VUek8wdXF2Tzhh?=
 =?utf-8?B?SUcvanZOOVBNYStnWXAxaHB6NjNZVFE5NkxIRm1Nd1piYkh1THEzcHFQdFJO?=
 =?utf-8?B?QitUb05Vci9VUDJQVFU2S2hHUXFndzM0TDJONmNvN2E2eEtxTnBCQWc5d3dV?=
 =?utf-8?B?anJIVS8yamxrRzBydi8yckhMV1FpNkMwL3YxQWRoR2lHaFhFMWtWbWQxMUEz?=
 =?utf-8?B?MmxXNmp5c1RNRXcwWjQ4V3VnUmo1blc2TTZYWW4wd0ZxZWJsNDJ0aFlaVUlF?=
 =?utf-8?B?VFZTL2s1WFg3Vm5YdURaL3dTT1lDWElCRStTRjMwL0dSVjRoUm53d0U5VUw5?=
 =?utf-8?B?ME1rVEI5S0ZPWTA1d3l1WThSbXdiWHY5TGh6YWFpS1dHNUhhVytXa1BHTnNi?=
 =?utf-8?B?TERVYUhhcWx0dDM5cFNZUUl2SGwxWmsrUzZYSXdrOEtYYjBEL0k5ai8rQjlq?=
 =?utf-8?B?Y2tEVDVhRFU0cHU3bDVvRXY4Q0ZndDc1V2wzK3JmMW1sdnZKRktaaS85aWNF?=
 =?utf-8?Q?IcVbdWgN20FF2oqK/ciWPZTUnXaYr3KYfjmLJZMd8pZqFf?=
X-Microsoft-Antispam-Message-Info: fvhig9DdGmVCU7eOESFIFuc6YooffpODWNS1hNmifdQ1fl35LgF6FmJoutllGsMcDzswdOXPpVjDGopHJOtaS3saKxx9xIpiCLlg410jeHGl+kW6/wNU3g5WGuWQM5lexh6R0Ne198ivT3mH2GUB56RjExGbQl6D2VAmF0vn1Z/fsANCIJg6ZLrs2IHDWA3o
X-Microsoft-Exchange-Diagnostics: 1;CO2PR15MB0073;6:A13VGDo/fnNEJU+KIN2AbexZFTFfaVuc2fAlXxXU6xkxsM7TzdVG+9gVLiKoBwMy1ef56OyItTRpKT8WwMpij01SBBHBnWnpKbZh8X9LkW9b2jfFyNUcNfVKNhMaogcozCPnxCldP2mtpG2uZUGmH7GzcWzE8zKh90dS5xbGrzSF+TYCMbg8s/l/3THQsN+vJNjBjXEWzBf1uvCztfHvVzO1T0Cc3dINJugmv04cciVnzEgoguXSdoESmIXnmZuvSOTRzloerYZ6vvY2Mo+DUSJ1mL7RGst3oduhO98RzU+cLemRHrMIW2ukDYYxDu3oXDKEwVxZxG69MVglwixaFnjzprGz/r4l/9SCR+mqjaWlCLGrYTccF0/svn9x0yc94uDSY1l4SreUMAXDatANUx98fAt41fDOdHS0KEKzuhUV5iPborufWbitIQqc/4iK11DOtewNs2ERsgj07Yqfow==;5:0sbac0A3OB8MqGnLNHLb4vB4yqmO8NcG6GZleI6RKaism423WPikREZqTyrOv4GM340UgyztcsrAHN3ASZhWBU+v5LWzffjaNi+BoZkec4VP7iDm7L3YQqt/XvgfiZvhGvE1yoB2xGs8nkxNndyPt1gfNcM9s2ffpSO9gTOEBJ0=;24:GKuBXguffHNGyJB9nnkn5qB4ZqXC9pXl3WTMAefdMrvdhCjeOBF7qy7OQIbaE3uQ/eQPWYkLn6+0mq5nAExEIMPPqmIs4hYhd7+XOySZO8c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR15MB0073;7:D1qoswwRBPd02sxMY8XsvZui+irrxu0F/qK0Mk1+Kwgf9trZvV8/eAxqxHPIqz/u0JlzymnKYUTVlsczSahYgk25dkos4c/LvfVsGkMDBH76FMoyOsGslMDvjOcmpNGwBXZKUezvygz3lS4yfllpk/RJBXQvHUpG1lBLHVzwXBYjnQt6cH0awjnjLn0JsFTj8o6dtoCht7t25bcP/dbj+UKwSwFWMy5A1iTLBPPJPk4e+LZBzRX0IhW/qZ+5AZtP;20:SqmCckRCk20S5s/Zdrz6XBBX7MQjdOMyZGDXCoOcBezrbbu+gEE9FiroObaYoUn87JJi3Tylxzhf3ZtRz8ZkBuYf3htWuf3DvIrhq6QKp65YU7Fcqcc02097KEB6UxAjXgMtFsQyMO3unqzvX/v12Q5xwJD7Z4SzhgzSZnSdkNM=
X-MS-Office365-Filtering-Correlation-Id: 8cb2a86f-eb31-4176-2af1-08d5a6e963f1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 18:06:07.3383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb2a86f-eb31-4176-2af1-08d5a6e963f1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR15MB0073
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/18 1:19 AM, Peter Zijlstra wrote:
> On Sat, Apr 14, 2018 at 09:27:38PM -0700, Yonghong Song wrote:
> 
>> This patch adds a preprocessor guard NO_BPF_WORKAROUND around the
>> asm_volatile_goto based static_cpu_has(). NO_BPF_WORKAROUND is set
>> at toplevel Makefile when compiler supports asm-goto. That is,
>> if the compiler supports asm-goto, the kernel build will use
>> asm-goto version of static_cpu_has().
> 
> Hurm, so adding __BPF__ for BPF compiles isn't an option? It seems to me
> having a CPP flag to identify BPF compile context might be useful in
> general.

With "clang -target bpf", we already have __BPF__ defined.
For tracing, esp. ptrace.h is included, "clang -target <native_arch>" 
where "-target <native_arch>" can be omitted, is typically used.
The reason is the native architecture header files typically
include a lot of various asm related stuff where "-target bpf" cannot
really handle. We relay on native clang to flush out all these
asm constructs and only bpf program needed stuff survives
reach to backend compiler.

The backend compiler, llc, will have option "-march=bpf" to do
right thing to generate bpf byte codes.

So the patch is really a workaround for "clang -target x86_64" with
intention of using "llc -march=bpf" later on.

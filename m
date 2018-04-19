Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754038AbeDSQhR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:37:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52102 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753497AbeDSQhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:37:14 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Subject: Re: [PATCH v2] x86/cpufeature: guard asm_volatile_goto usage with
 NO_BPF_WORKAROUND
From: Yonghong Song <yhs@fb.com>
To: <peterz@infradead.org>, <mingo@kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
CC: <kernel-team@fb.com>, netdev <netdev@vger.kernel.org>
References: <20180415042738.1788215-1-yhs@fb.com>
Message-ID: <41651b53-7e99-4394-7edc-13c17b3bc9dd@fb.com>
Date: Thu, 19 Apr 2018 09:36:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180415042738.1788215-1-yhs@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:200::4:6dc]
X-ClientProxiedBy: MWHPR0201CA0024.namprd02.prod.outlook.com
 (2603:10b6:301:74::37) To CY1PR15MB0078.namprd15.prod.outlook.com
 (2a01:111:e400:5849::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0078;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0078;3:/X9O3lz/G6xSxYDAXae9mLHxBIqub4RqOF7q8NAVnlJwDEHc3b/vpLWfWqkW7ifVYMRPLjJIsYVawe8Nurpl3yXhi7PJ5YEYgq4g//PhkAXGsRX6AEPDUAkDxyNXEhtbq5tSgH8aT0LdhNXiM5MviDlaK+TigiKJpoc4uXOVbzBtjhDra5qpf+0SlbRJjfJpdIKO73svPSyLdWb2Xl1dyhac03XWIiovCgVq1okHaY8JggF+2Xorf0NYzQjeWQ0e;25:rRULN8NO6/5oX3KjNZcBnn8UvQ2boD2WWHpAyQIdnKxvRlLP5BbkzjhV72nwOtFEVTO3q+NcfdZ8wl2uJGtmdCv9rLLb0KHDhBfZDdOIdggtuB80rrduoaCnafWG97rqS/+Y3umMRhAKJTk/V1AxbWgOpdKwdh9rNJ5kiOUgyuTns+F7BLZ2L4Yjxn5tHugp3peL8Hc/Eu0Tr0h7+CauiWQUn+n6IdnA3N9bLcpbgkE7cwPfor8x3IcokgB1Z0zhdVuVXhf5psuijB/QJxcafQWex2TWKtAfsHRkI9itRb18+ULi59m4yMjYMCuG+LPpS1bIHqJP1lGhUas3yNmMSg==;31:A9nnjMpa0YRlQ8Ja4gVkrf9wniT9xlG0W1iImAQOgNtWr8qqk4s3l04TpPPsEjKpZihsnkzfYJOfvC0TXcGH2GAwdhm96M1eZVHklJyP1kIK57/eDoH51SYIBlv0XU72gPrJ+dBW/lMuP7jqJflJYpT4iEpd+hFlsze1WTMcRHS6xVoN/WHgYrvZCzkV0sYxWPueFjKBxxaR5pwRUGY1KfNo2I9JEuvUVcpS/rRv5Ug=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0078:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0078;20:0mAut51QjilxA8PkdOeUjJ/inRVM5zGPcTP3f+NsrFHI1dN5UmumV6vLXCqk3TfCgV3eKRfhYjm0a44kJdtUBy77HI543zyqPSkZSqOKpMM49kMITjx1pKd/q5yMCQPdyth0+GquQNHw2pCqKyoWimZLeYdgaQUUSLVmc9QT5a8rklXcCeHNZEt56paoXbZcgdHJY5Jm7cJRwbjjEk5B64aHOPCQFlC7iFtWLQ9ohQJNC6HDgXEK2odL+GEKwfOERyYaAbZrKhK7oOkowAxFnCNYqfBXsJzynCl0drjtrSdQ5KIK4Kylz8RjtRArNECdMn0nDS8zV/961qNRgmF5FEV9ZQuk3sm6l66GViBzCeCyiyhhZnW6N7rpkuohAKmD/cuTSOXVqniW38424gTyacXbtlofKmp9Ebb1FEi0teiIUzELFVH0IEuoL9VnpY5EQAa0mh8McZJA6G7hbE/1O3JilzsCWKutVRVKdYg6ir3FUke71Tv84kOOvFyCOG+k;4:zc1pe7zkOTI8d84jgDCQ0RKSHhiMmx+WPXBnnaOKvHbIWuT1OxBldUtsCde3qwE3+f0zbcE4VCcY0gWq5tfu7zGChEDMglXFcMp9CSt/I/ZC95gTLneaQDCIq0O7LxeChB13J5mciym/u7X0w2WyeliS8llpPlFdV1yk8ID6Uxa0h86H4qBcXv5TbpRI+uIQj4rPlt6Vu+UNSuBOkT26xhv8EjOO2+rEoUCwrS+DauI2JOPAMNDDtT34FOiJpzaKE+r8toS4P6wDmLF2oYv08bdeRlNCfXV1yWmlUxPbvVXywLgrZ5/4PmfEJ17UUPtN
X-Microsoft-Antispam-PRVS: <CY1PR15MB0078D874ACDEFD38C475D585D3B50@CY1PR15MB0078.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231232)(11241501184)(944501327)(52105095)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR15MB0078;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0078;
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(39380400002)(346002)(6506007)(76176011)(47776003)(53936002)(6486002)(6512007)(31696002)(7736002)(305945005)(5660300001)(36756003)(86362001)(23676004)(65826007)(478600001)(316002)(6246003)(6666003)(230700001)(8936002)(186003)(16526019)(67846002)(229853002)(476003)(31686004)(8676002)(2486003)(386003)(53546011)(50466002)(11346002)(446003)(52116002)(25786009)(6116002)(46003)(4326008)(59450400001)(52396003)(81166006)(2906002)(52146003)(2616005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0078;H:macbook-pro-52.dhcp.thefacebook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjE1TUIwMDc4OzIzOktGRlNVUnp4L0J1Zzl0K0NCNXB1MnRWZmpK?=
 =?utf-8?B?VGZEVDNWbmk3QjZjVUFrTTFCQVg4Q2M5MzI2WXhhQmc2QVdqVnBQSmlEYkRj?=
 =?utf-8?B?cm9ReVpZU3QwdFc4bUdHbkc2UytFRTZramlqOG9tR3VoSlNTcDQ0ZVUvbURk?=
 =?utf-8?B?MTVZcUFjYy9BTFZJTWtUdTU0NmphRkdlaURhWUNxa2JMR212NlY0SjZraHZJ?=
 =?utf-8?B?QkpjVVhod0xkdnlZakcwV2VMTWFZbTVxM3dBaDRZL3hHRXBxb1VDME5yTlZp?=
 =?utf-8?B?RytENDhLY3FsUFBodncydEtmME5paTRESnlkYnJOUkxTU2RUbmpTbFBscGJU?=
 =?utf-8?B?VWUzMGpxeUllckNyckJ0bmErNjhCTjJWTWtYOWRrcHgyMjJZdEZORzZ3YTV2?=
 =?utf-8?B?bVR3cVZPR3pyUUZvU0RLT0NBaHlmTmY2a3puRVljVFhua1hFZlRNWFhuY2Rq?=
 =?utf-8?B?ZTBEK1RzdnFNZ0ZGYTdIVUJDSkZXbHFsV2NTa2J5K1FCMW9EMEludUFpT2VP?=
 =?utf-8?B?eFV0WTg3c0hvMkVpR1FNbU44a2lnM1ZKN0dUSWJTT2lsUDJxZ0RWckNkSzFS?=
 =?utf-8?B?bTB0TlFTYkY3NHUrdFF4ZzZvcUc0OXBscnc4NU4wQkM4YXZGMi9DVy9sait0?=
 =?utf-8?B?WUdkNWkrSm5kSGVSTFN5emF3WmNwbnVPdkVETFJ2Yzd6REJVRDlOeWtacW5M?=
 =?utf-8?B?R0djNlRnU1dPd2xuTHRHeDB6QzZZaVNHNDd5QXU4SjdRb005RVVVcEpGT3kr?=
 =?utf-8?B?Y2VaaGNZcUdiTXA3YXdJYks5R2VnRnU4R2w3WngvQmNxVHNNclExUFpwbUts?=
 =?utf-8?B?ZjVTeE05UVJZZHhNYTZTYjJvMU0ycWREUVc5dHVSNmZsTEdOUG1hZnB4U1U2?=
 =?utf-8?B?dkFsMktEMlRNQ0h2cEptQ2NmekR2VEQ3MktZYWxyY2dsVUw2dksrcDljcG1G?=
 =?utf-8?B?OEtHUzhoMmNmL0YxTGZNakkyWlRRbkRlQyt4eG4yQjFNckhwamxUZHk4Q2pI?=
 =?utf-8?B?YjJURXIxc0pVcktPbFBWT2UxUzY4OGVCQ0F5Y2gyaEJvdTMwOGYvQ2JQUVBC?=
 =?utf-8?B?QnIyN0F6Tm9jVTJWNjhuRkREQ2JiekVoVnhjM0JZd0xuTURMRXF3ZytmYy9K?=
 =?utf-8?B?UytVUDc4QWtIMCtmbGh0V1QwaFVWMHN4U29QL25sSVlTZ3lvbHFKN2FjRDZq?=
 =?utf-8?B?RmNBbHpZalVDT3JvaTQraE82a3lBdTNxNHhVeTNzV3daaVhHOUVSQzVQallv?=
 =?utf-8?B?V1JqMVhBTkhCZnZMMVl2TmhOY1BMUk0xTytKd3lRdCtyemEzejJRb0xONDNX?=
 =?utf-8?B?eW9aQ2VwekVmc0s2UTgxNlhmSlZVRzV1MGRVZUFSQlE3eVpsNGxub3JkMFM3?=
 =?utf-8?B?M2Q5Y0RGSlk1eXFIK05MS3NlbmUyTGVVQjVrODZIZlErU3E4clh0bFRFMFQ0?=
 =?utf-8?B?ZnBZSXlPRHFjdWNweFpOZU1sNnErUVdWdmRLS0tFQWdPWHdYSGRRWFQxcEVn?=
 =?utf-8?B?MnM3cFppeDNHZzUxUi9JV3I2S3BUYW9mZDBBYnFVOExtc2x6bzJzVkpscDBJ?=
 =?utf-8?B?Rzl0WkJzcG5RZ1hkNHdMSWwwcTdlL3c9PQ==?=
X-Microsoft-Antispam-Message-Info: 1LJabM5KuO75Fl6B+VajXatyKsfn2edDbtkqCshykZ8JTCJLT2/5f9YziGFp+zNzDxc2HpGU6lkLsVFgiwgkRXVgekTWuU73ELH8n0vsb9QJ8pYYrdPiJ0OXRi5qYywSOtfgRyxPsdZtZjHKojzHCcAMyF1GOQRgoIaZvclKtID6yqYI4t/k3V0zbV5wunbN
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0078;6:N4W0kmxijhwxTV2Mqf3wHg27q2IU3wch32L6QwpO1BUWQMUFbOdkirtY2ffA0QINsK+a0ZXb2FzEhvXWh/9I4G9gZcR8ACxvHS/hdLWje+0M3ZBqVViON8kVqKUvCpYMvWKqMOnJ+gk070lOwZVFAuLKrK8zEUQ7Lag1b3A9N1dfdqB6pGs6y0AXvfFkqQwirHAX0aYegJma8wtcEjezyzt4fYRFpmtpx51qHFqA84xOpGnSIf599fLgwyFk3RwICn/TKuMwOQsXrz6tIj4a2dXabm8SCFoBOYeki7pAk26jIJ3YfoljntBwfXja4wl6u0CjBvXGZf6rdTjhsmvx+ERo7UFyfO8qwIx1FWFfNK8r4ChodahjflDd++SHj/hjck9kd2KMM4e3EpkQ9rUm7ub9LboHy7QuHWA3/IEzEKls0SZvzHximXW4RlG43quDh1vHfrcb+enHKuCD4mG4Ng==;5:80flP05Udtn0ys6D4QaemuYBtq3w0BFtAaSQ6wpha0dAzlef18cGMJR3PhMpExHPFy7oKPjjTM89MBTOcNY3/usniUL/h3xOkRwjC2JzGramjLwbUOcS26eldIAMG9jvpqbkJxT1uGk6yJVj04GyAiC0T/hjjvrK0LuJt93mzkY=;24:vOa65P1iP0EwYZsnvmLSnCFfIT631XPUe5lrsaCg5XPqTrKhPVqWlAHjr6b2pxpI2P3yEGXm7gqzSNPKv+aW4MzPzcNsMq+IGPHuyYzqdMs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0078;7:HmNAGrkhELgyM81w778lyQ+xPnW3cCgCnrW6R4OsGuzKKb9NbZAj4DO3Fm7OqDSFLYjNGx5IN09P1pdvNVeRuFjRFOKs/Vix55/Eda50vwj0Lu4EGj56jwUQZ+bKmIGho3aQI1hpD+caNriddJTHmdmhIW7KBm2qyNbJkwNxK0Iu7t3X727WCNyE7cPYau1pQ7jlUJN3GBpZQRaI7qlXRP8ogZq96JUHTnb51J4LV3d6qB/H/jPydndNu8Kv4KeN;20:R6aFP7XE+4VoflNhOYQurO/sDRiEMtc5ZRhzalVnp54n4vQ1MbiXzzkpffkqSPgqSeWBkT2CtKQNSBQVXJFA7FNRsuQHhWSnnwQdtEyXVZiImqsq8klTac9Resx1CddJwGIE/YBK/OJ4g8VptRMrOAs8eJYLwrM6f2h/ahUUZws=
X-MS-Office365-Filtering-Correlation-Id: 3d75fc98-9088-408f-3a62-08d5a613a637
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 16:36:05.9613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d75fc98-9088-408f-3a62-08d5a613a637
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0078
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Peter,

Just pinging. Did you get chances to look at this?

[ cc netdev as well so folks are aware of the issue. ]

Thanks!

Yonghong

On 4/14/18 9:27 PM, Yonghong Song wrote:
> Commit d0266046ad54 ("x86: Remove FAST_FEATURE_TESTS")
> removed X86_FAST_FEATURE_TESTS and make macro static_cpu_has() always
> use __always_inline function _static_cpu_has() funciton.
> The static_cpu_has() uses gcc feature asm_volatile_goto construct,
> which is not supported by clang.
> 
> Currently, for BPF programs written in C, the only widely-supported
> compiler is clang. Because of clang lacking support
> of asm_volatile_goto construct, if you try to compile
> bpf programs under samples/bpf/,
>     $ make -j20 && make headers_install && make samples/bpf/
> you will see a lot of failures like below:
> 
>    =========================
>    clang  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include \
>           -I/home/yhs/work/bpf-next/arch/x86/include \
>           -I./arch/x86/include/generated  -I/home/yhs/work/bpf-next/include \
>           -I./include -I/home/yhs/work/bpf-next/arch/x86/include/uapi \
>           -I./arch/x86/include/generated/uapi \
>           -I/home/yhs/work/bpf-next/include/uapi -I./include/generated/uapi \
>           -include /home/yhs/work/bpf-next/include/linux/kconfig.h
>           -Isamples/bpf \
> 	 -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/ \
> 	 -D__KERNEL__ -Wno-unused-value -Wno-pointer-sign \
> 	 -D__TARGET_ARCH_x86 -Wno-compare-distinct-pointer-types \
> 	 -Wno-gnu-variable-sized-type-not-at-end \
> 	 -Wno-address-of-packed-member -Wno-tautological-compare \
> 	 -Wno-unknown-warning-option  \
> 	 -O2 -emit-llvm -c /home/yhs/work/bpf-next/samples/bpf/xdp_redirect_cpu_kern.c \
>           -o -| llc -march=bpf -filetype=obj -o samples/bpf/xdp_redirect_cpu_kern.o
>    In file included from /home/yhs/work/bpf-next/samples/bpf/xdp_redirect_cpu_kern.c:10:
>    In file included from /home/yhs/work/bpf-next/include/uapi/linux/in.h:24:
>    In file included from /home/yhs/work/bpf-next/include/linux/socket.h:8:
>    In file included from /home/yhs/work/bpf-next/include/linux/uio.h:13:
>    In file included from /home/yhs/work/bpf-next/include/linux/thread_info.h:38:
>    In file included from /home/yhs/work/bpf-next/arch/x86/include/asm/thread_info.h:53:
>    /home/yhs/work/bpf-next/arch/x86/include/asm/cpufeature.h:150:2: error: 'asm goto' constructs are not supported yet
>          asm_volatile_goto("1: jmp 6f\n"
>          ^
>    /home/yhs/work/bpf-next/include/linux/compiler-gcc.h:296:42: note: expanded from macro 'asm_volatile_goto'
>    #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
>                                             ^
>    1 error generated.
>    =========================
>    ...
>    In file included from /home/yhs/work/bpf-next/samples/bpf/tracex4_kern.c:7:
>    In file included from /home/yhs/work/bpf-next/include/linux/ptrace.h:6:
>    In file included from /home/yhs/work/bpf-next/include/linux/sched.h:14:
>    In file included from /home/yhs/work/bpf-next/include/linux/pid.h:5:
>    In file included from /home/yhs/work/bpf-next/include/linux/rculist.h:11:
>    In file included from /home/yhs/work/bpf-next/include/linux/rcupdate.h:40:
>    In file included from /home/yhs/work/bpf-next/include/linux/preempt.h:81:
>    In file included from /home/yhs/work/bpf-next/arch/x86/include/asm/preempt.h:7:
>    In file included from /home/yhs/work/bpf-next/include/linux/thread_info.h:38:
>    In file included from /home/yhs/work/bpf-next/arch/x86/include/asm/thread_info.h:53:
>    /home/yhs/work/bpf-next/arch/x86/include/asm/cpufeature.h:150:2: error: 'asm goto' constructs are not supported yet
>    ...
>    =========================
> 
> This patch adds a preprocessor guard NO_BPF_WORKAROUND around the
> asm_volatile_goto based static_cpu_has(). NO_BPF_WORKAROUND is set
> at toplevel Makefile when compiler supports asm-goto. That is,
> if the compiler supports asm-goto, the kernel build will use
> asm-goto version of static_cpu_has().
> 
> For clang compilation for bpf programs where only header files
> are accessed, NO_BPF_WORKAROUND is not defined and asm-goto version
> of static_cpu_has() will not be accessed, hence the above compilation
> error will disappear.
> 
> If later clang compiler starts to support asm_volatile_goto,
> the change in this patch can be reverted.
> 
> Fixes: d0266046ad54 ("x86: Remove FAST_FEATURE_TESTS")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>   Makefile                          | 1 +
>   arch/x86/include/asm/cpufeature.h | 5 +++++
>   2 files changed, 6 insertions(+)
> 
> Changelog:
>   v1 -> v2:
>     Use NO_BPF_WORKAROUND macro instead of CC_HAVE_ASM_GOTO
>     to make it explicit that this is a workaround.
> 
> diff --git a/Makefile b/Makefile
> index c1a608a..7b81f1f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -504,6 +504,7 @@ export RETPOLINE_CFLAGS
>   ifeq ($(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
>     CC_HAVE_ASM_GOTO := 1
>     KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
> +  KBUILD_CFLAGS += -DNO_BPF_WORKAROUND
>     KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
>   endif
>   
> diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
> index b27da96..638417b 100644
> --- a/arch/x86/include/asm/cpufeature.h
> +++ b/arch/x86/include/asm/cpufeature.h
> @@ -140,6 +140,8 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
>   
>   #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
>   
> +/* this macro is a temporary hack for bpf until clang gains asm-goto support */
> +#ifdef NO_BPF_WORKAROUND
>   /*
>    * Static testing of CPU features.  Used the same as boot_cpu_has().
>    * These will statically patch the target code for additional
> @@ -195,6 +197,9 @@ static __always_inline __pure bool _static_cpu_has(u16 bit)
>   		boot_cpu_has(bit) :				\
>   		_static_cpu_has(bit)				\
>   )
> +#else
> +#define static_cpu_has(bit)		boot_cpu_has(bit)
> +#endif
>   
>   #define cpu_has_bug(c, bit)		cpu_has(c, (bit))
>   #define set_cpu_bug(c, bit)		set_cpu_cap(c, (bit))
> 

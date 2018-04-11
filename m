Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeDKXW7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 19:22:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33454 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751925AbeDKXW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 19:22:57 -0400
Subject: Re: bpf: handling non BPF register names in inline assembly with
 -target bpf
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
CC: Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <c8b0b3c0-6687-1be2-66d0-95b20662145d@fb.com>
 <20180411183902.GC12166@redhat.com>
 <613f0a0d-c433-8f4d-dcc1-c9889deae39e@fb.com>
 <20180411194729.GD12166@redhat.com> <20180411231733.GB24386@kernel.org>
From: Yonghong Song <yhs@fb.com>
Message-ID: <3a379d97-81f8-945a-abfc-af62da076c5a@fb.com>
Date: Wed, 11 Apr 2018 16:22:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411231733.GB24386@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:200::4:c80c]
X-ClientProxiedBy: MWHPR19CA0077.namprd19.prod.outlook.com
 (2603:10b6:320:1f::15) To CY1PR15MB0078.namprd15.prod.outlook.com
 (2a01:111:e400:5849::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0078;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0078;3:QaM5np2X02PebKZSFmfqKYRC2MmLnDnvcc6/DxyGAJJqsbLj4ijOfvYoLaWMRrWRZUfzhJFI5rC1hHWyoEutPvcxQBXIDdRgx61Ulwx/RbZUmoqAV+Jj070sAmMbkxUsJ6BJ/9FiJQyNnHkIuoxcF6yLTk8+WkAIeztbRdMSDvvXZWLKHByV840HcEtm2U1z9d+4jsX+O+oc7DFzW+hWDyKBSaJTJ2vpJu5RSEVqcVWBIA2MrUzQTGBXIJLTZt+n;25:yL5UJofm/2+y/GFmUbUALHJuePNrdpaD2CVueQmDLomoFAeg969m+DKhP/he5IZI9EyGn7V21xiptd2FC8tLriOi+2UMuwcPVsRmggP0+HYYqYIR2qC8Ghebc2kfh5ceScphA5qt1dlqUFJe/fBdS0J07e2dHfHuFJtkBNm6KECXsp3t4EZFl2QbsaxxDXxNlRqfJ5MkRbsFa1cgwVCcE94R6Xz3zAfOGVZJ6uO33WBYqfFmZSP2tMp/LdK/glPu5WMV5iBRQHDmbYG2h559v7+GA5Kuj1B7S4/lys5dMaRFdFF0no5f0kBD9BnF91J/zVglKfL7BqtCxzk28MksOw==;31:W2BytLxow63FUkO5HaZVx5GPByx6XZARYQA3J2iQFGACTi2H+PTgYcfxKfmBaTnEjueuzkiCeo8uwp4N4Yj3iol+fyoAVg3haTmXSaCnBCW9VMnqyLbNBdwjEdUo6Tsmt14iBiHEbII1SH/G9fjOf3/LHyMJN64GXdk9NByh1GBT4z7kE71+D93kS4NU2axmz+dSKt7B9RMlLErKjXvj90XpGrZYUDWm72evGkNoCoU=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0078:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0078;20:zT+fQNvJTfSB0URYbUgG34KgZI7FOfgH93Yg66lipfiVJWKwZkGlYPL0azyyD7zVXfx20MHWCWrhePIcxTM8SsPB5HQSkmPU02YKsNwSx+HHhrveB7nKzyMG9x15WJGK5kmjeiR+neqXsinVkajDxfbTnpEdzGfQctEft+oX1772HScQz2oJss2bV1QPaubwOfO+OZF5+Tw5Uv/MsSRsW/UQk0r11aVAy+5brUr4/QcTAN1KttHX0Nl6zOog22rxj2aYAygi2mw37ijBPDJ8R4jb1sqpttyNDXhYpEoymd0eP5Qp7GlCC1YciSCPXINniZlujvYNyej92b6Y3Hi+1VQaDo2JBBtOYi1KJAkPkTOFTrLghWICJFtJ8/uy1hTnyYCSy9h/dx1FYc2vkaYnoGvt9IFGkThmt6sGw8C+ewYWN+F7v0xrXPgdUn3n3Tyj/eEnSn10JKtjiVrh7ENoZU0BUHuLubeQeFsc6hcUbTDUXC4RueruWxjY91oWN2BZ;4:TMxvpMrN9WH8zhc7irOY6rFV3vkWr9mfFj+AS9sjQMkcxBi9JCfkTBDstzQUSVBWa7JpFeMPyOaGg08FHu1xlOpNE+1Lkgj+9FoORaEwJjw+xdBZMSArWlbcTgBPDPfaV4ZN1v0qQaMuvbhWo+7P/6t5MArhtAUIL3aUyWmTqXOospvjngPWRgjV/SAdPXe/2VTZrJCCjKhDZdDVR8bXqnYERCOp4EtDK+oJv+2GrgXbkkfG4b/AkLVJKhKyJUPGaWI/qc/c4zjKrH0yGiZY8V1q+2KzCuk8AqVy9CCuBMKm/WC3z98LQSrcaNE5FJvgZPHbOlrRwr3jWEqA3fh3UQ==
X-Microsoft-Antispam-PRVS: <CY1PR15MB0078F876986477E5EC9B5F4DD3BD0@CY1PR15MB0078.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(15185016700835)(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(11241501184)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:CY1PR15MB0078;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0078;
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(39380400002)(396003)(199004)(189003)(186003)(8676002)(386003)(478600001)(2906002)(446003)(76176011)(31686004)(50466002)(52146003)(52396003)(25786009)(52116002)(229853002)(16526019)(5660300001)(68736007)(23676004)(11346002)(4326008)(46003)(54906003)(81166006)(2616005)(316002)(486006)(97736004)(81156014)(476003)(53546011)(64126003)(110136005)(6116002)(36756003)(58126008)(966005)(230700001)(65826007)(31696002)(2486003)(67846002)(6246003)(105586002)(6512007)(53936002)(6666003)(8936002)(106356001)(6306002)(65956001)(6486002)(93886005)(65806001)(305945005)(86362001)(7736002)(47776003)(6506007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0078;H:iphone-409c2846b52f.dhcp.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjE1TUIwMDc4OzIzOjJwcG04cWlPTzM1RVU5R3M0emJCdHZCTWdK?=
 =?utf-8?B?SlMwM1pRcm44aVRnL3BsZ2NPQ1MrbXRMMFZRQVVXV0h5MVVXQlhoWGFta2ZS?=
 =?utf-8?B?d1lUU2x2RkRkaWxibys4SVNzZlJRcUJMdFZvYWxaMTQ5TzNrZlA0cmtKSnV6?=
 =?utf-8?B?RlU3RUtKc214L2t4ZFBxN2poSm9icUphWDBqakRKbUtEdFJwNExYY3FhTWgz?=
 =?utf-8?B?amdvd2tyc05NOS9idFNZWjlQN0R5MDdCZVluNVpBcDFSM3pCdzNKVVA0TXVp?=
 =?utf-8?B?QlZHSXZsU2NDc3BEaTk1bW0xTk9kNnFkYVM5Vk43bWEzbDBYM3d5NGZ3bHJO?=
 =?utf-8?B?NW85aEN4enpheGorbVdlamJVR3FQdlNzK0pqakM1eXV0VEMyQVIxUU5YMHlJ?=
 =?utf-8?B?ck1ZY0t1OUN3Q3lxNWtMUW1MUnBxSzVZYWRIVDAwVlBzb2FBNCsrck5zN25h?=
 =?utf-8?B?L0QyN2VXRTNhYWI1djh4c2hjTkdQbWhOWjU0bm9VZUNrMmZTdDlJQU1hUE5z?=
 =?utf-8?B?czRDKzRzcDNlMWUwb0I3ZFdwL2NldExIR2c3WmlnZTA1VDYwRFRsZ3hxcG1N?=
 =?utf-8?B?QnlDNGV3cEpTdHljcXR0Z1JEdVBWMHUzM1hIcml1UTgvVVZCVGhHSS8rOXkw?=
 =?utf-8?B?d2ZMM0lBa29QWnBwczIvUE50VGVjUlNmS3g2UWc4VW92MXM4NmhVL0xQUzIz?=
 =?utf-8?B?NjYrcDlGbEkxYWoyVjJ5QnRqSlJWVGpraW9aeGpnQVNTSTNXekxUNXdOVGdk?=
 =?utf-8?B?NmNHMWlPRGF3Uk1jMkhBcWpYaWNXSUtsVFk2T05oTjJkRERMc1V3Vk5zZG5R?=
 =?utf-8?B?dTAxM3hrM3RnbEVrNHZPMk5FUUFiOWxPU0tNR1VEMDhMTmszK3h6eUxCR2Qw?=
 =?utf-8?B?dU1PbTZQS3dsRjJ2c3hDUzZCSnpyRXNPT1p1SnZ1Sk8wZWdEb1RkaHlHWlE0?=
 =?utf-8?B?RXZ5VFVFVWhCa09BV01vaERlTFExbVhDWFFIWGVwK1Bpcm9oZEpXRDBHTWFj?=
 =?utf-8?B?ZEQvR2FBSFdIeFRlOHhoTWIrSjNIcjlrUHZCdnM1cWFFK1QwdDkyU08xb2tr?=
 =?utf-8?B?cVEyMFA2UzVFOVJadngwOENrcVdzcFArSWpqcjJ4NG84NkxBeEhncFVaSnFS?=
 =?utf-8?B?Qm9LYk9HVDY3YUU1aWNXUS9XbEdHKzVqeVZlRlBTelNMelBnV3ZoN1k4WkVi?=
 =?utf-8?B?dFcxT2VVK2ROM0sxVU54bGpDYi9TYktHcXdoVWNaMEM0RCtkSlBhT2s3THhQ?=
 =?utf-8?B?cHlOSXNBS3VzTTd2NWg5Z2trZzhLbTEwQ0NkOU92Q0NKSWpvSVNqYnFsTU9N?=
 =?utf-8?B?WnFNYkFFdndwRGQ3TzNlOXp6TTd2QTlnd1ZiZTdOclJKTEcwd0U2bkYwWVBw?=
 =?utf-8?B?dG01bmROeTVsa3JRZHA2RFlOdndCaVNKUDhucTRvbEhvQUphSkNJVjJ1cUpv?=
 =?utf-8?B?bWlqOXMzRVZhTWxrSEEzRGthc1ExelYrdWhnTElaVnNHbjRKaWhWK0Q3QTcz?=
 =?utf-8?B?SlZWemZoTFMwWm4xb0hSVnZDN3poQUtLTnd2WFh5Z1pLaGtXZWFJMXJ4WXIx?=
 =?utf-8?B?UW9PeDU3SjFMRzRVdENpNFh2OGkzTjBGT3ZtckdBdUs2dlBBWnlQNyt0anh1?=
 =?utf-8?B?S2laaUd1eTFieklVTlV6T0ZaRjU1cHM4Z1Q4TFhoakVyeFUxNTUwN29IOGoz?=
 =?utf-8?B?L0Vpc1BtdnRzaHhmTlhvOUx5dHIzdzZ4Mk9vRW42U1gxWFYzaTV6YmJySm5S?=
 =?utf-8?B?alVWRnRzRm5TZHpQZUl2OHlMMjRnUGQyUjJVUmtxR01wVTErSUY0Uk0yNEo3?=
 =?utf-8?B?d25vSExjVGtBL3p0SU81Mm81b25sRGlxWjRURWZPN2VPOUlUT2xPVkxPdlVT?=
 =?utf-8?B?WXY2RHJmNFdLL256Q0FMdkhKNUNZTUFmSEZlS1NjeFVmbm1CWXdvVEtaNTVR?=
 =?utf-8?B?OXQ5UjhlM1FTL1JUc3YrcjZ3ZEQ3Tmg4bzVZdWVoWUxIMWF1enRiMEFXWURp?=
 =?utf-8?B?RVZaTXIxMHVVajNXRkpwMzVvTyswbUFxbWduQT09?=
X-Microsoft-Antispam-Message-Info: TDxgxm+Vh5l1/sF60jqr12JE6afVtOFi6BKuTToRV0I3awtAHb6UC6V0ct9zrQ+0nHYNZOGlHn1I+NVKJzvvtI1RuyZHR1TYqBA1szikFWzDhKcWxyp7eKcBeO+tp8mNM/vCT7QZd9Ges5WGHscAjmayhZisKqpSijmGzg7EdFmYf70vPOTU30YSciXUhn6I
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0078;6:fbh62rzbItKpPBdDdW7ngmM5d3uo7Be9/UJ7SlISkpBUC5EE0V25/5ugA+oAnaV+mfNAYx3kYNa3Lg51Xo5Q6DYWaXkLSmobOn0Ws1b9gM0KjOTg3bEdGlv69Y65fMJHCJojqKZQYnkfisJeGBe1SWEyp4LAQHiL8gXoX4a7oSIYnxoT1mXRHZwSoW2tgRBZWOBQqCgAk/3WkLa8b25c3cCX/GinZX5Ozbj6Ddeyj93ILoUa59NQqryWNwtYVrhp6kJj1YP/3jXDreajqVGOY2RTxDQfzVtZBxMVFXibG1wBXjfEevGlkTrtK2y2ghS+H8YWQ7W/deVfTaix1NHXPBATcEGaMrYVJxCAS//HfBCozt+SW+EZ71UqB6kM4ceCo6983jmH83CUqkwE1KEMs8k34l17nhWIdERyt+4hQZeN4iev/8Dxj1GHHqf9H5IydbQ+DC2oee8xSVmTie3mSg==;5:Mhbr3qJxKFlbgS/MnvFtofA9YLi1QNlwFp1F28RvGOROVn7TeGRcpK1SydjVjnbOOMD4JsBUBmDRRw/wXkgw3Y/AJEiPx3RBuIOcPQOlP+CUYfj/nwommWHdh+l8Jl9YSI9AR4l4hJyK45Mo4+MLRfFqEQbmA4gaZiKy7Bm/r5s=;24:iKRQa0s3DEuqlRhYtbVBLAGiGoBhalSj3wNMeVgbGqIRCfwloPDneRIR4fu1/i1fHMwx3rVbx7LKYKqZX9iCFcVTieYxLIrSzpa6SmTYGoU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0078;7:WsvTnrFP7wTyvn9S6cZiC+bb0EGpjsaXrqOY1XGVNdXvdiL0fM3lJS737XnQhrAfrkcpHXSwfmdmsgMUSyJrVqEGXAKqX5mB0CjiG59zc38t5BQZQYWpCLOvppEdP2ByUcMEypYF8cnpePmbepnjwYoXR9WoEKAbjizfGVy9nSbRxeQquxAWMK/Wih7aUR/bzG4N/Uee/lbqfWY1OuXItB9rnejeKju2NRrJrCVUtpN11NX10WZuFsAYQc6XKDf/;20:BJsZxJ5/Fp4geRM8oUfNqCkSFXHI7SMdjhBbgZgDIOjprl5C+gc8zi78w6YAB4C3CU5zf0TQ1jy/s6zr3q+DtWhf+Yfv7CfHO5mF6+yHCNSMTjUKoglKzBIEULg3egRu7oD9D4IQTyr6Y3tYbKmW+TgsO8vQwFeMRKMMiDYUXLE=
X-MS-Office365-Filtering-Correlation-Id: cde635a8-56b1-4a02-6324-08d5a0030e6a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 23:22:12.3429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cde635a8-56b1-4a02-6324-08d5a0030e6a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0078
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/18 4:17 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 11, 2018 at 04:47:29PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Wed, Apr 11, 2018 at 12:22:37PM -0700, Yonghong Song escreveu:
>>> Look at test bpf-script-test-kbuild.c, I think you can drop
>>> uapi/asm/ptrace.h from include file list. This way, you do not need
>>> __BPF__ in x86/include/asm/asm.h. At the same time, you can
>>> remove __BPF__ as well.
>>
>> That's even better, I'll try that approach, that code was done by
>> someone else, so I ended up not considering looking if removing a
>> unnecessary header would fix the issue, I'll check and if that works
>> I'll revert the patch that introduced that ifndef __BPF__.
> 
> So this is what I've pushed to my perf/core branch:
> 
> https://git.kernel.org/acme/c/707ba03243d2 (HEAD -> perf/core) Revert "x86/asm: Allow again using asm.h when building for the 'bpf' clang target"
> https://git.kernel.org/acme/c/4364203f5563 pref tests bpf: Remove unused ptrace.h include from LLVM test

Looks good. Thank you!

> 
> Thanks,
> 
> - Arnaldo
> 

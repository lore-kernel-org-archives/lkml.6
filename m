Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932603AbeDKTYi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 15:24:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46732 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755724AbeDKTYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 15:24:34 -0400
Subject: Re: bpf: handling non BPF register names in inline assembly with
 -target bpf
To: Arnaldo Carvalho de Melo <acme@redhat.com>
CC: Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <c8b0b3c0-6687-1be2-66d0-95b20662145d@fb.com>
 <20180411183902.GC12166@redhat.com>
From: Yonghong Song <yhs@fb.com>
Message-ID: <613f0a0d-c433-8f4d-dcc1-c9889deae39e@fb.com>
Date: Wed, 11 Apr 2018 12:22:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411183902.GC12166@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:200::4:c80c]
X-ClientProxiedBy: BYAPR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::22) To BLUPR15MB0065.namprd15.prod.outlook.com
 (2a01:111:e400:50b8::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0065;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0065;3:mImPyDDKrMATKDNYj/iO7gblTjv/yT6C1QeYJlf0zhyiD9Om5HBZsiWX7RHihnEZVo+3L+Gwkhg27gf+fO8szB9tiX3Kr9L0RTPvejRWp70ql2fZhNBsR+zz6CqEURsQgh6w5K4o/qJ5P/m3kzvNcw2nSMZB3nOc3yXna6qwLvkLt54eHCu/TNe7vqY1kC5WjLvJbGLu/+QiAVXKdpRbmFTxe9lD1mJPQWhKjJux9l40PQhPN4QMaYKRVg/x9jL0;25:5ix4QvvH8AU0sJ+6sHjtF3I7MnYpTxBlXo9s+Mc78jthQl6xITOPxaW2hsNW0tfvjoxnR+rfrgZ+ox1xlEkWsZTRuhSyRtDynBLwh+HPh4MS2SUp8jTGmaWEbSAwX/lyd1ReEGFkSjHhEWSboe96hUK+z7a3G5VnR2crmYOeylP2VMOju9zPJjsY9xXUfTi9YKXmpiwk+8fCXar+3oHjM17ydG78nXb0CyTsQth2LgrHHTn0JCA9Y7eqfaHACEAjUdraQ0lQ6h3tmIoChzTmV9hzPmZif+aeSfkfsRBZVZuTBjITmX7pr9wlK/vcR2N826xM63z0K12sp0Bhz6Q6sQ==;31:7v4BOvJsp7TFosoQhMv7elNTTjnnt6myVErosQQgzGtXnVMsenP92Eg5uMAikFFf1lRdjadaWyOPnhK3tvZD95SlwqKuaxGduMtpOIeJD/gJkWLPbf1VuGEIsC8qyk7rhdhBRsI7rgJxdJSTHfVxyfybZs5zgQBIydr1v3LYYr4rpR20LUIsu1yJckSaLuIktKl8DegSVyypPUpOWCl1zUnaCasrYU8GZOtTXsir9q0=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0065:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0065;20:Qa5HJUouBXp9iH+EHsr1KnqqMSSCvtsQIwBEEchdY0pdsDUyG+eayPS8R8uvUIc+9WAA6sWrqE37eV/9kt6VIlYluDqJf12oTdIsI4My9FQX4k6A3zWP8MTvy6CrdAcMpymTtQ5WioDW+2mDm9+q8tUzeYAlbNVah6mCC7yTw+o7XUNz62H9ZBAnDUkPZ7bvBcUyG0cC5mNoAz04ZN4GWemn+KiRXj5pPid3rHV6Sw7SvlT0JdqhMdbh/qAYdBXteM2xi/sjg8qybPtJw04Ys1YnaRIvhukTFd0Hj/LVau0U9nubKPdOmc2YVsuDcygb9APFXYax6sRRYm3lvni6PlLgLdSBTidyYyUfdKxe7V1lgiM7ZgMzzHPwrjXp9P2FtK2X1yxV2cH9clQEksI3F3jT4u3zRCmvd4fQwoF1iZe6wf10VjxGgkoGCi1r5Gx63Gvgqj8vTh+oCZDAb+6iAexiXbPfdR2O+yo3Ko4fzsG1en/Unx6Tv7jR2PEQqmHK;4:VNdw2lGCcAX2KubdYdpyutBuf75iepxkl+x8/zgZqDSV61ibtpAxL+rYUMfaL5c6RSCDx8IFke7LJ097kKO2+Z7JiX1Wrirwh/sANbSLr+FbI9nk/otWdtxeUNOiBfjkdTcuulvtGBNyU1teI9zEBSGdLGpD2slpiJvekYt4BiVkCrrMTmLJW9wi/V7HVkSI5SgXtLmo9PR1GEqLonCK0cfLkI7IZS0bd0lbyXytCDKutUFcfgOCz+Y7algB2IyOWYXSXRyaZV/x0g6hCmtg+3sEiSmF/zsxfTXydRGmP7s+6csTODGA6FQklFe1NkwZEjp8aUyjkxtsjKKbl50Kq7nkZwykOQa5relov6vcJRwoVIo7Wf514DxUKeyOepWX
X-Microsoft-Antispam-PRVS: <BLUPR15MB006500E1CFCBC2C97E13568ED3BD0@BLUPR15MB0065.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(10436049006162)(15185016700835)(262104967686372);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(11241501184)(944501327)(52105095)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BLUPR15MB0065;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0065;
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(346002)(376002)(39860400002)(199004)(189003)(31696002)(4326008)(50466002)(486006)(36756003)(2906002)(575784001)(67846002)(65826007)(86362001)(476003)(478600001)(2616005)(229853002)(6116002)(52396003)(230700001)(76176011)(6246003)(81156014)(81166006)(54906003)(966005)(305945005)(65806001)(8676002)(52146003)(47776003)(7736002)(53546011)(6916009)(58126008)(6666003)(23676004)(25786009)(316002)(31686004)(106356001)(105586002)(8936002)(6506007)(97736004)(53936002)(16526019)(186003)(5660300001)(6512007)(2486003)(64126003)(52116002)(6486002)(68736007)(46003)(386003)(65956001)(6306002)(11346002)(446003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0065;H:iphone-409c2846b52f.dhcp.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjE1TUIwMDY1OzIzOmhqWWZvaDBUV3JkbWFLTlh0UDZRYnllSXFj?=
 =?utf-8?B?Uk9YUHoyNCsxN2lUTlVqQU1qUnowNExVS1BLQ25OaGNHUGV4OHJxc3B3cVhD?=
 =?utf-8?B?UTVpTk9pcVZ0aFgwRDVkNWZ3RnV1VFBuQXF5MkJSaUhxUTg3THhjV1U4aktS?=
 =?utf-8?B?Y0pBSkVkbDVQaHpOMVhuVkZlazhXWGxlTzBXSnpQNlUzVDd3ekE1WjJxNHJ1?=
 =?utf-8?B?aUovNXh6RXNsSnFiQ1ZMN1B5WkRmSXdNc2xHem40QkVUWkRZQ25HU3FsTHU1?=
 =?utf-8?B?SElpVHNMQWttTUVha0J5TmhxRXJZM1ZuWGtjV25KRnIyRkZVaHdvdk02ZkdK?=
 =?utf-8?B?L29SamEzNnRNSmhyVVdGZ3RRNHJkQTVkM1dKYjJlSXZDK3FFTlFyWFBhRHRL?=
 =?utf-8?B?dStvZXRkdFBPQzRidnAzVlZIVjk2OTIvelozZUZHYm5RcXR2VEhrTzYrVndT?=
 =?utf-8?B?SWUveStiUHRDTTBuNzdSREl4eEFJaHRNWDJwSHdHZHNHMnRjd1FVaU0xanZj?=
 =?utf-8?B?eUtVR05pbzBxeWtFWk9xb2pCRnF1V0NqMTIwdWRvcDQzODAxYlVXTmlabmFZ?=
 =?utf-8?B?Mm15SUhSQ3ZoWWw5NXVqSkxpT0U2VldWbGxoZ2swYmhiQlQ1ei9vQ05NT0U3?=
 =?utf-8?B?S0xmVlBKMVdYZnRVMGVFamJwU0w0dUZzL0RSdi9hNkdHNUlCWEhKYTJNOVM4?=
 =?utf-8?B?WkFtd0F1OStObG1VZ28rbWNPRHRuc3ZzL1UyNktFTkZ3MG1qTVhPUzVvejFW?=
 =?utf-8?B?ZnNJRkpvMklva1RaYlVycHRueFRsVGlydEVpUURzUmtRSGdSOWY0Qm9FTUZY?=
 =?utf-8?B?TVlTM1pSQVBjTkc3cFp0QzBIUnRRZTdSK3ZHK2Z5NU0rcGJwQU5lWDhGR0VP?=
 =?utf-8?B?YUdRMlc5dXVQZG5udWllWkUwdnMyM1dwYUE1ZDJLbkh3M214azN1K010NEs0?=
 =?utf-8?B?bzF5aVB0RVZxOVlRSFBvNGpQeTZPSWNJY3JCTFlhbktkcVBObDVXbHQyUVdy?=
 =?utf-8?B?SlJXOFZ2anJMWFgyalgyeCt1MmNXQ2VMNHdQeWFwOERFMmJXRHl6SUlJempG?=
 =?utf-8?B?NjgzRlFrbTMwd2JlV2t2T2pERDd1YWhPSmhITDVsL2tTRURTdzRpTUtRakxP?=
 =?utf-8?B?KzAzcFZGMDJmMkhSblY0T0dneGtPbUV2NEhnT3ZHVENlcG15VldWNzMvYVVs?=
 =?utf-8?B?a2QwazJWR1BhMGJpdnk2NU9xYnlSdWRwS0VJUUJYdmFyRFJ6KzNhYW8ySVZ0?=
 =?utf-8?B?SGpwRlIxazRWeXFwRlFDZk51NEpJV09PTlVITmxLRExVSlVYRnhsem9scEhu?=
 =?utf-8?B?ODh1RWw1OEVnQkxDd21HR0tJbFVHU0o2NWtsbFl6UDZJR2t3VUNmRWw4SjI2?=
 =?utf-8?B?UXplZ3EvTGFzR1FZMkZXeGpQZ2twNjFoVDVSM2NUNk51dFlzWDJUeVpFaVh5?=
 =?utf-8?B?WlVNYWtsOFA2Y2xWVUQ2MmpCaDRhSnZZaVdheEF4UTRVMEZlR1pvWjBDUmNa?=
 =?utf-8?B?S2NPYUF3NEQwZWxxRG1yZzhlZ1YvM0l4dWhaeGRlSEhjaGhHR2drdldpTlpx?=
 =?utf-8?B?TUpLTzkveVJTSlFHRUFzL0sreGg3cjg3Y2cwTHc1dXczUzM4TnZqY2tIelcw?=
 =?utf-8?B?SU1tcDllTEVFVE4vYjFBNnhpdm42YkdhNzgvcmhMS21Tb3RjZ2kvdWVia3FP?=
 =?utf-8?B?cmZyQkNCZGxlMUw3L2JDdWdQWWxJQmtwclIzUDVNcGxMSTFFeVJ6ZFB3L3Ur?=
 =?utf-8?B?bjE1eTV1UmY0S0t6TFJkYW9xSTZodElmMUhtZVZXU0E0YlFnOVpPUFpxbkcw?=
 =?utf-8?B?VkpUUUlXb0JWMEtLK1BFNWJyTjBaMW1hT1VMRXFmcUxoNThCbjlzV094RFQv?=
 =?utf-8?B?VkZnNFRIOW5hZHRKQkk2WUxXOGgrVUc0VkpxRGlyS1h5NnlNa0dndk1qa05x?=
 =?utf-8?B?dGdUMnlUczgyRjhJOEtqZmJnYjR2OVorRlI4VmkwY3ZPMGpVSHp1M2pBRVll?=
 =?utf-8?B?S2JnOXNpSnFYMjZjb1NqVmEvbitlSTZ4NGFIZz09?=
X-Microsoft-Antispam-Message-Info: 9dBlPmW3ZZWwNqyhsrbFGRaNbqJytVtFP/oBITJXbISjVCwxkVt7gOCK9mGcyr9KQxWmFWfoHcXQJ1iiH9FESdKK7ruugqkDwnQr0+jvgagkZ+GND2fzlSBncoS+JfFEduDuOHqWjAk7T/bEO6fFYYU1zGT65YZgXRIEs1h5nAgceAYwFsBYeknaALmy+blc
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0065;6:tO5Kht1yRhV3/2tSkDg81bXaRiPYKVA/zbz4KG91RXt8ptrqS78kjXbbZVzbZ6N8lDh0e2kgyqsUTV2aSFK0h5xvAIWB8vUPJoWGQZ3K+/WrFLUquDiinr8JY2uaLZdQlhfRHqRvAtwZLsMbq7V1b/3XQnjVGCEi0CiUEDMD/zJ56jIh6RIooDhpCmucoGzegKieT6day157f0TbohHCc8Nx1zuZhLuXwVVzhFuDnzCFasoq1aEAszIYKRYUoZIl/EThuTqjKsB4zydgviWJtLmvck0yAk/9Vhh6dcVG+db6IAls9krSGQuvLB8eEwXAaVT2jsARR6gFfcGgfac1JpQpwLzx+RKONo4Hbx4ZXAtsnlssFQT1h9f3q9eK7q2HyqPnF9JY79NFeZLRQf8D1wRjyzkvCgKfDicMQaJwhltMfoSXvnKKerVNsTa7QUhKUS0zvC3dOi/bEoeI7R5uYg==;5:d2UH1KWJnHNoDYP5AAmeSyWd5T7jpKhIUNIYH+b/zysaZ+OQnWhLJCbb/qaH9As48sl6lhBjcQFUmFEm/dq2MCmw5t0mESmMOdlFnqKku0CGnFCudMtyGHddVfDCRIKDa4JcG45c5kEU2sfAl1NLnbGD2q/sr/qKtMZ+61G3owo=;24:U5S1HmoW0kNztmcEG6Q6gNQkAaHM+zLuIVatqsH4lKyAeEVzsmpTJcbEdAcMNmUSUjP5NJ/LQHaIi5GqG7GktEzUqrLGZQ7PhDRglH8D7wI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0065;7:r6zHUTSwL8ZgJz6iVVTY6JpfgmHZxFKwg6sg/o9ENAKDDhM3kIdW9p8qaBDybgx75q6tB4rAO8qYqDiXQZMPiCaVQGcB0QL/x8lGkeDnKzW8yC/DJg0SnyzfoiujSjilAI/zccubkOcR3TNmHNgFTZez/AgquT2S+VSs0he5/N2j/4fyayapZx07dh0yjSdW+kROXy3Z3ZsfNUJEcNIiTfy6S1q7Qctw8CnIyT+tUTUD7ShVbabcrVhQ57GS/CIV;20:MRPCq42G7VeLxiQiXpDiDbh70odNCAasuvEp0cK934KBOufp9eXxZQ035vdmpGdxdKSNFdrbxCr7HX11nhupp8zG/IQCWoP+0cu59vA0l3hihncN+kgoy4nbYAPq6c2iu5zEiCVnK3TedLjMg86f1YC/yyooGkCtYY5iiY78wAs=
X-MS-Office365-Filtering-Correlation-Id: 870045c4-9d51-47ae-cd53-08d59fe199eb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 19:22:43.0019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 870045c4-9d51-47ae-cd53-08d59fe199eb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0065
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/18 11:39 AM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 11, 2018 at 09:37:46AM -0700, Yonghong Song escreveu:
>> Hi, Arnaldo,
>   
>> When I studied the bpf compilation issue with latest linus/net-next
>> kernel (https://patchwork.kernel.org/patch/10333829/), an alternative
>> approach I tried is to use __BPF__ macro.
> 
> You mean you used an alternative approach that does _not_ use the
> __BPF__ macro, right? I looked at the patch and yeah, looks sane as

Right.

> well, since the kernel build process already defines that
> CC_HAVE_ASM_GOTO, checking if gcc has that feature, etc.
> 
>> The following patch introduced "#ifndef __BPF__" in
>> arch/x86/include/asm/asm.h for some inline assembly related to x86
>> "esp" register name.
>   
> 
>> ==========
>>   commit ca26cffa4e4aaeb09bb9e308f95c7835cb149248
>> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
>> Date:   Mon Dec 4 13:08:47 2017 -0300
>>
>>      x86/asm: Allow again using asm.h when building for the 'bpf'
>> clang target
>>
>>      Up to f5caf621ee35 ("x86/asm: Fix inline asm call constraints
>> for Clang")
>>      we were able to use x86 headers to build to the 'bpf' clang target, as
>>      done by the BPF code in tools/perf/.
>>   ...
>> diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
>> index 219faae..386a690 100644
>> --- a/arch/x86/include/asm/asm.h
>> +++ b/arch/x86/include/asm/asm.h
>> @@ -136,6 +136,7 @@
>>   #endif
>>
>>   #ifndef __ASSEMBLY__
>> +#ifndef __BPF__
>>   /*
>>    * This output constraint should be used for any inline asm which
>> has a "call"
>>    * instruction.  Otherwise the asm may be inserted before the frame
>> pointer
>> @@ -145,5 +146,6 @@
>>   register unsigned long current_stack_pointer asm(_ASM_SP);
>>   #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
>>   #endif
>> +#endif
>> ...
>> ==========
>>
>> I just landed a clang patch (clang 7.0.0 trunk)
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__reviews.llvm.org_rL329823&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=DA8e1B5r073vIqRrFz7MRA&m=1D1Hmeg3QWPTsbr6rIHgNpk8Fiqk1jkAvrluQQsjk2Y&s=P5EaOqBvaqpDpx3di0Qm1W2fMKaooJJ7b6IkiGD6NU8&e=
>> which will permit bpf clang target to accept ANY register
>> names. In this case, the inline assembly will be accepted by clang
>> and will be thrown away since variable current_stack_pointer is
>> not used in bpf programs.
> 
> Ok, then that ifndef __BPF__ above will not be needed anymore, but only
> people with clang > that version will be able to build tools/perf/

Yes.

I have a suggestion, not sure whether it works for you or not.
The whole issue you needs to introduce this __BPF__ is because
you included ptrace.h with "clang -target bpf ...". Typically,
when people include ptrace.h, they use "clang <native_arch> ..."
and "llc -march=bpf ..." since ptrace.h and its dependent header
files added a lot of assembly codes and asm code related constructs or 
maybe other arch-spec #define as well, which bpf target cannot handle.

Look at test bpf-script-test-kbuild.c, I think you can drop
uapi/asm/ptrace.h from include file list. This way, you do not need
__BPF__ in x86/include/asm/asm.h. At the same time, you can
remove __BPF__ as well.

The clang compiler change I had is just a bonus. It intends to
help "clang -target bpf ..." users just in case their bpf program
header files contains some host-specific insn asm codes with host-arch
register names, for which I expect most users won't hit this.

>   
>> If the inline assembly is indeed for BPF program, later llc
>> AsmParser will do syntax and semantics checking again.
>>
>> With the above clang patch, the above "#ifndef __BPF__" can be removed.
>> You can decide when is the appropriate time to use latest clang compiler
>> and remove the above "#ifndef __BPF__".
> 
> So are you proposing that we have something similar to that
> CC_HAVE_ASM_GOTO check in the kernel main Makefile, to define something
> like CC_HAVE_ASM_REGS (or some better name), i.e. something like:
> 
> # check for 'asm(_ASM_SP)'
> ifeq ($(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/cc-asm-regs.sh
> $(CC) $(KBUILD_CFLAGS)), y)
>    CC_HAVE_ASM_REGS := 1
>    KBUILD_CFLAGS += -DCC_HAVE_ASM_REGS
>    KBUILD_AFLAGS += -DCC_HAVE_ASM_REGS
> endif

No, I am not suggesting a kernel change like this.
If you can change bpf-script-test-kbuild.c file and get rid of __BPF__,
it will be good. Otherwise, we can leave __BPF__ there for a while
until later clang 7.0 becomes mainstream and then we can remove it.
I just want to you to be aware that there is a clang feature to solve
your problem.

Thanks!

Yonghong

> ?
> 
> - Arnaldo
> 

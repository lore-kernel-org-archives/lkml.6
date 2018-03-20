Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751843AbeCTQGO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:06:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40314 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751448AbeCTQGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:06:08 -0400
Subject: Re: [PATCH] test_bpf: Fix testing with CONFIG_BPF_JIT_ALWAYS_ON=y on
 other arches
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
References: <20180320125851.19650-1-cascardo@canonical.com>
From: Yonghong Song <yhs@fb.com>
Message-ID: <4a497245-1864-3036-074e-107134e4b9b5@fb.com>
Date: Tue, 20 Mar 2018 09:05:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320125851.19650-1-cascardo@canonical.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:200::5:ba97]
X-ClientProxiedBy: BN6PR11CA0008.namprd11.prod.outlook.com
 (2603:10b6:405:2::18) To BY1PR15MB0069.namprd15.prod.outlook.com
 (2a01:111:e400:507c::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24d41c9f-8c61-449e-3a64-08d58e7c61c0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY1PR15MB0069;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR15MB0069;3:ch2fD7JNQ4rQCzm+A42H8WgLLb6CbBWBmJqRjd89jsfznGsz2s2flx8l7e6zCh7UKkYKcXqpiSl3b/sLtvFnLhJF38CE7W2fzPzN8cvaidLZH/n/n4BYmg2/VZlvkouznShir6a4HdFnzjWdDQftIGku+EdkqgrJdsLk32SDucAr72cXqXatlAXbl4SCzaCq1VD7IVGfVIh+C6U7pnJhoGdjd+k3SOzcONfVnOutzB/l/OfTW/tZa+hKAV90LIFl;25:odYy1ldZx5QBhHxmMbexkJXWjhp22lHMrVMseAsIiGrQJuEgPRwJWjz9kzk6ASfiIAvCJ9CGKuoFyiZ3SkDb77tC+UGAEIGSFXlmMC5jkuS6/m+GBTVOEd9WD5W5qTc5RO3QkHFkIosEpyeSEEGvev18+IIuRlVvQeDGo0IOLCsPCrFwpNy3LzLziiv9j7ng0IATHOzGpm/9l+YoDAHUx2E5wvnJyZJaYW/Po1vJE3U4SoSijDNdU5t3SXMqzsuulazDrNhZ/9CILaT+330fAitA6pNnWl1Dis0HeeoccT3WBV2hYa5BEzJxN7lTv8qj6hJBrM/uASMjBNEgSF6H3Q==;31:SWE4Mj56+i/36QFpmMH99gZ04z+Ict7qKwxTdB1OP0el+oht6oxKdWyZ4xEqqprx4wRsH0+kIvq6Qm4sx0vKPTqUKK3a0VbFemJmKjvZ/Ej8gBPMBLE6iwGSAvmz5rFhw0dSJuK3E7Ou/1PtkMWhxIRk+92LUX6RtLIEbMoZ58n9iYpJzq6bjx2Kd4Zx293I9FSxxuakwG+T9KvBfqKTiavE2I8D7ziPjpPph/zzcSA=
X-MS-TrafficTypeDiagnostic: BY1PR15MB0069:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR15MB0069;20:hKo46miFURkqdQhqaPNdXMq/MtJRUIo+LEu6qklGWUFmH5QN4YxRvmQHZhuVUzMgeXnD9+mwQL398M0Y/eRw6k+M39inC6nbNY0U1TjhBOlGmgQXoJLW8tZoHe9+Yz1qzx0ipsE8ZMI6VmYwZCbE/UDTMn2fr8fTkcknaszhNkQQ9USk4eCMXQ3qCXywPjdaSEzhzeH26wW9psiDBkRsxa1wp1ombcrkDRWi8LjFgAANBbUJmK7BJ6s0o9B8kmu17qVaPZfHBStDwj6r6CdH3WKWUxLi2troQ9dwMKoUJaDLJZyhQ/NDjGkJEFM51/qz+G9DHaVjmBwl7z1HTUOCHXjXckarxxWgXvvW/cv66XwfRLkdp7lnGMpuDLhsF/DGqCKaxIKRB/cIxYNSoSa2TS5T7o5o/6tpYhVNzzYVjBlYtvQJh7p9i/y4nP0BTC+ThjwgUA+XMjCYbqO1P7jw5VLp/5CNqr0AZK7wnOL6iU7sYvIMnUZJtzGtiU4FpSx+;4:Xj/7uxWptcjkdOCodeRQP0hAyq+uHcz/QmG3LsUmuCbv6KVATF5IAKJe4YSfR7Y+F7IviyKheAoROimlLI5zusOGwnfHkEWM2mpeMhIkztaxWNzSfCrlZWvETosxMBO4uu5FN9d+UcofIyhL5ZEtbhwVjRk5UqqmEMdg/vP2xTX3mZU/ggEP3eBQodSEDRoT9SQHVOgoSSv489fJWsCE08D2NXO3/ziAwd8C8hfvZgpih4hw6SH7xLUsALuPUlBa0kJ5lKlazWkb4OXjOH0lLvabpX8UplU2F9ZI0njBrJ9vjjMYlk52/0Zs5pO1cuvl
X-Microsoft-Antispam-PRVS: <BY1PR15MB00696E3D3AE66588179320BDD3AB0@BY1PR15MB0069.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(198206253151910);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(11241501184)(944501244)(52105095)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BY1PR15MB0069;BCL:0;PCL:0;RULEID:;SRVR:BY1PR15MB0069;
X-Forefront-PRVS: 061725F016
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(346002)(396003)(199004)(189003)(186003)(36756003)(230700001)(6116002)(86362001)(6666003)(386003)(53546011)(5660300001)(6486002)(52396003)(97736004)(23676004)(52116002)(106356001)(229853002)(6506007)(59450400001)(31686004)(54906003)(2950100002)(52146003)(2486003)(67846002)(65956001)(81156014)(7736002)(6512007)(46003)(53936002)(65826007)(76176011)(58126008)(64126003)(50466002)(6246003)(105586002)(65806001)(47776003)(2906002)(31696002)(305945005)(478600001)(8936002)(81166006)(68736007)(25786009)(8676002)(16526019)(316002)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY1PR15MB0069;H:MacBook-Pro-52.local;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTFQUjE1TUIwMDY5OzIzOk54a29sNEZUaklmblRtVjlGeElqWVFva3Z6?=
 =?utf-8?B?bkM0SldJTGMrK3VMbHdOODhrZWdLa1dSWmhnMzlraWlKWVJBb3VzVGI5MmxB?=
 =?utf-8?B?Tzd0S3AxZHhxWCtpaGRzd0k0dFJsaXl1a1FINVBOL3N1TzJrbEZXNmVNbXVo?=
 =?utf-8?B?N2dtSW5lbTlxdmVrY3U1YkxicWRhM1h1d3FGQk9Mcm9pWTQ3aXYyNzFYVnJq?=
 =?utf-8?B?bkxzTW9pNkFhZDZBc1BSTWxhMkR3THM2bC92aXFodnZTbEJhczdTRDRYS3hn?=
 =?utf-8?B?K2V2bmFQL1I2Ylo0NW1vN0QvajZwRVhid3FuOEpNUUxiWmI1RHVaOTRyak9N?=
 =?utf-8?B?WnBBVWtPTWZpd1dsZWJONVVqRDhyelYxcjRQbE5xdXFDSS9VZ2NBL0ZXN21t?=
 =?utf-8?B?S0hZcUNvUTVDMi9zVXBLUHBsLzRvMFNjOWlwaWxrb0wwcUtSekgyd1RVZ2Nu?=
 =?utf-8?B?Q1l5ZWpCVEFXaE44L01RM2ZYYzVOejRwR21sWmdtVWJwZm1OSmpnTEVZMHNo?=
 =?utf-8?B?RXJjZ0ZaOFpBMW1WYWFINVN6N3BvaDFQME51dUN4Ky91SHR3Y281N3RYaXhk?=
 =?utf-8?B?R1l1UDdNaGRZTkd4eDREK25Xd0JCS1FWeWNtVSt0SWJNUE5sRFA3eDJGbGhj?=
 =?utf-8?B?elozcVpnbmFuVHMzTTRKclU1NHI1ZXV0MHBlcGxabC9WQUtQWEppcmdJbmRI?=
 =?utf-8?B?KzdZRkdic1FVd2FraFc0cXpXdW5tTlJraXg1dVBualNTeE9NZFBEL1UrUHJq?=
 =?utf-8?B?alJOYm8zWDVBOEVTS0NBYnVFL24xZlVLUnhNdGNWU1VjR1hUWkxuTmtvNVA4?=
 =?utf-8?B?bWVFbXp0YzViYUIxVlJhZ2lGRU5MSDdYVzRQS0FWTXJEOEZPS0RqQmpyZXFW?=
 =?utf-8?B?ODduU29LRWtTWG5wVFdLcWd5SVVPb3o0T3EveGxIQkluUFl0NG5RSlJSa0Nz?=
 =?utf-8?B?b2dDaTZYM2NodFBnYzY1dmphZlFGVnpZM2h3R0VvbGRFWGJFZU4zWkZLUE9u?=
 =?utf-8?B?cnNZUXBUNTZqL0FjeURnVWxmcm1GNEV5YTRxd3JrWVBPZlBML2o2NjZPaEgv?=
 =?utf-8?B?SUM2c2x3NmJ2aGlNbU44MlpMdnRYVnd5OTVJajdFTVA1blNRdUtzQzVZWHJJ?=
 =?utf-8?B?cG5pbW9sMUw5amEvK3J5cmMwRG1yaVdmd0VyVzREcHZON2svWXlwejBIaFVR?=
 =?utf-8?B?QzRLZDRkSzZCcWRpS01UWW02eTZCTnBnZjZLemM0OXVFRWN6alhmbGdlVHl4?=
 =?utf-8?B?RzJvNndodWNZZ3ZTL25KK2FVL1phTVZnSWhBV2JyWDhBVkhyUk5qempOSzhu?=
 =?utf-8?B?N3NESHVoR1I1NURBd3UvWDcrMjVOYkRRRXFIU3FDaHVGUjYvaWdjVkFkS3JH?=
 =?utf-8?B?cDcvNHJCODNOdVJUQjFmV3hTWnJNTk00M0ZUNHFsdlpPc0x5M0JvZ1N4WW1s?=
 =?utf-8?B?TEFpQWN1MjBYbS8vRG5RZHFETzYxcnFnTXduUWJRayttcEZWTy9lRFE1UERT?=
 =?utf-8?B?Rm1ycmxJNnZRZ0QzY253WHRhalZkaVdXM3h4Q0R0dkQ1VERiOVFWdzF5YjJI?=
 =?utf-8?B?dUxGa1NkOEVPazFkWElaZFlSL1NrVmQ3NXRoWkk4NWNtc0pqSU1tNWZzVWRw?=
 =?utf-8?B?QjJ2dEpLRGRITHNSRjhqYjlFbEQ2cWNYOExTellhT1dsOG5kVUZodHpWUGFz?=
 =?utf-8?B?VTJBbmw4ZTFreHJQTmp5OHd6czBUUGZnY0h2ekhhL2FUWHcxa3ZaT0tjcFVk?=
 =?utf-8?B?aFYxYWdjeHR2cFJyRmRqaHVYL0dNTDZtQkV3MEI2cHhaMmlZOWNFSi9ORzVM?=
 =?utf-8?B?aU82c0JUQnMrem8wb3B2cjZoQ3hGWjF1U0pUbTI5OWtBenc9PQ==?=
X-Microsoft-Antispam-Message-Info: /qXZswp4ZGb9iL52SNNIAks5EuTP1C3gERBb82SR9iX04BxI/aZIHJQCYVYHfFXlZ1/a7R7GbLtEHbLyZ90pJDDGymf06DRnaOoFX94tmA7JKT1rTxHRqxRuTbCg5uJYCxMYekR906NLXDCNuM2YgWbDmB8KAXRILvpf6TmQ0BChKGSJ52X9+XcoG+Tlr+Ku
X-Microsoft-Exchange-Diagnostics: 1;BY1PR15MB0069;6:LyF08EjBw/0MlsinOQsPAM3cylodD3drJoziKth31s9ksmVY5VXCduW0Z7X53j4xYUVtbG5yzsjBgxv5TxwizRDxosiaBaCYTXbUSwq3NPjhv6x3wHvFBkmRYKjInkfgypHPVVteunYrYzVOcdHmVYui2xMSTygaBOqJXOHy8OQdpDZ508Tj+1a/PAjQITjPGGwlGQ0LW00bNPReuFktReV1gn+tkc+80pnP/heI8SnZGx0ijd++yDPS5XR3PG/YPvGEZ1o07Lcojn+vG5cVQ+E58iRasVHO8CNOcc/9v8vuJr1pajYY3Tjc4ZFGAl+jXpzSA8Webh5rPETtLDKuwxxIPtdrIUjC2OvNkNBOw9Q=;5:gbBSV40NHxAY23mLBvQrW0ZpZhBa7GLhMWAsXKYNuwb7dUUY82RckkTltrcSt5m/z3gIsOoC1i4YOYAnGV+SCY6yqSmvtRESEuEcNKUDcCqmrfBXojQ11WjCRZqZlLOe2RDmLV04z4XY8oFRyXfLlEMUPs9sKLS0/sbw7lVOBG8=;24:FEEBI7/Z9AlPsYEk26INCE8ztdDLYgk8/GdtL1sKUfGy4fA2/0OIPMg2UICXdmookVT0WzgiCSkZ2pOXgao0wzzyJ+Prl5SOtj8V5+sCHd8=;7:U2CxkjjwWZrLJLEIgZ9j56Eiw9UChelU9E1G0MG7tKtSYlpdeR8OInbruIjUbz0treY9j8pUFEnSpGKOQI7+zR2HprubEPVPTC4fvf78o0mJt1R0ZX/gKSpMBKNUxQ77ezjwdxSngX1fEckA2KZRhomc/KxNCdwA3SWyk7HDrY0Wp4JPT2eIdhu98aAN5y5gU41eX5G72a4WDgRDzwhnIZZEemWed626KEeWWxb8GWm3kdZqbVZXUP8B5KihZkNp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR15MB0069;20:huRz/0rYmNgiEzLfsYMOBL8u0fpxaIi2NBq82+FnPW89XoTPdtWEAVMkkHE2Ur7Fs9T90h5GeVuJb22+mBLXw1UbotZNUpDzhycIVMNVSQhP9XL+j8/TmDH635vxVRmAsni9cuyMqJIIfJyLy47SLWWg4LXjxueDXN8o7HsEQG4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 16:05:19.8619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d41c9f-8c61-449e-3a64-08d58e7c61c0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR15MB0069
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-20_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/20/18 5:58 AM, Thadeu Lima de Souza Cascardo wrote:
> Function bpf_fill_maxinsns11 is designed to not be able to be JITed on
> x86_64. So, it fails when CONFIG_BPF_JIT_ALWAYS_ON=y, and
> commit 09584b406742 ("bpf: fix selftests/bpf test_kmod.sh failure when
> CONFIG_BPF_JIT_ALWAYS_ON=y") makes sure that failure is detected on that
> case.
> 
> However, it does not fail on other architectures, which have a different
> JIT compiler design. So, test_bpf has started to fail to load on those.

Here, you mentioned that it did not fail on other architectures. Have 
you verified all of them or just looked through the algorithm.

Could you give a little bit details about other architectures are okay 
while x86 is not? Maybe, x86 JIT can be improved some how?

Thanks!

> 
> After this fix, test_bpf loads fine on both x86_64 and ppc64el.
> 
> Fixes: 09584b406742 ("bpf: fix selftests/bpf test_kmod.sh failure when CONFIG_BPF_JIT_ALWAYS_ON=y")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> ---
>   lib/test_bpf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> index 2efb213716faa..3e9335493fe49 100644
> --- a/lib/test_bpf.c
> +++ b/lib/test_bpf.c
> @@ -5467,7 +5467,7 @@ static struct bpf_test tests[] = {
>   	{
>   		"BPF_MAXINSNS: Jump, gap, jump, ...",
>   		{ },
> -#ifdef CONFIG_BPF_JIT_ALWAYS_ON
> +#if defined(CONFIG_BPF_JIT_ALWAYS_ON) && defined(CONFIG_X86)
>   		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
>   #else
>   		CLASSIC | FLAG_NO_DATA,
> 

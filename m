Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeFDUn3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:43:29 -0400
Received: from mail-cys01nam02on0085.outbound.protection.outlook.com ([104.47.37.85]:40333
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750950AbeFDUn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:43:26 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH v1 2/3] x86/bugs: Add AMD's SPEC_CTRL MSR usage
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, andrew.cooper3@citrix.com,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Kees Cook <keescook@chromium.org>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Andy Lutomirski <luto@kernel.org>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
 <20180601145921.9500-3-konrad.wilk@oracle.com>
 <fa831d0c-3e7b-b5ab-17a0-5d3b1bfd6142@amd.com>
 <20180604202024.GF5867@char.us.oracle.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <2f325eea-5ffc-70f5-43d8-59ceef73d04d@amd.com>
Date: Mon, 4 Jun 2018 15:43:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604202024.GF5867@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0501CA0071.namprd05.prod.outlook.com
 (2603:10b6:803:41::48) To DM2PR12MB0169.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0169;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;3:8ZHziyCqzO35EqfhfKcSZhHxcYjlbOGYDn8qHb1E2dbNXS7Qb8WKSclvXfdZ7nD/LVOA1v04rfSQMtoisAZGct0ArNhQ7jJW7MMxUCsHEaHU+Jbeou0OjrQI73NPjF/ll3BQ+rfW/3fiUa3fgiREI0oBvX7MG77CfzDwkQXeH+jBGpbzh0Jmc0oDa9WCsdyHjSMrJl2hWQah/nOAo6XDp9TwB/ibODx3EmLQR0+vxicBpKbOk8mWyiXFhH7x3Z0s;25:VxPKD4lF5YiSsNIPWI3JYKaCuP/MsHne63tZCqZ/0SbrsHQaMMBz45JNd9qir8CWdO/yNW8BSArJNhE/vv0R9dF7I86uHZo22vV8NitaO9mQb/aZsSHmmjHK9wiDFn7e/vvXC+e7fBltXpj27nSfO8sc3LdV2EoQvQq2xwkEXcUyb7M1mGrdds6BP9at3dUvoTgKMMDONwZHxlyIze/gLm0RvowCMSLQgBksVIy5BQ2VjBAReTN/FHaJkLmGumFq+f+it0luLUsPzNAHPbs4/1aL6jS78OnCVZwLF/yZD/Qykl5C4SpwQo8JV9hf2TYKMc8nckolnkVHMHNvYmw7fg==;31:SF4nuoZ4MOYTw9vE2WJAvTMI/Ti37kQ9ytvcX6+LceVOwCQTmSDB2FQ9OHFeWdzIWxGFrI9S0HRK2p75N8gtZNB/ZC/OkkuBXObp253slFgi3Y+jDmojrQ1HUY7e/Td5LhBEpgwfln+nQkuPZMRgjIpAcfRFh8jhcuU8fzoFYgb3KmesbQGK+4lELDXL0KZe8UhSLlK02+zBILiZr9VwJRWBWwCkpQpBKFV7s1/KEqA=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0169:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;20:CqtN8195uQsswy2EG3Xf73ghc5DuZqGAISvVkCSVp0jcsCRNoCnP6sewjA8iyjUv6lLMnSyJOp6rXzaycPeEURljD+PZ8tKBQituPgEq+TV93ZVWEmkv0CqGGaZtzZ0xW4uGNtRm6Xvz789wqqrb9Q5z7a6Ux2GbVvY3WZcBATP3v6rQ0xBDpNyOAA0ZFGzCGQMgbpmDBq8C1jlPxFsCfq7n8GDrCH747RMsbLCvMgtUx1tQhI/rjDHDHiWM2e7d+vfdbDXyMfpYMCC3H61YJ0O9ARlllK0DLrDkcx4s6LKFTHSBzopQBJ+ejlx0mzXyDGQrktOckSzJoa6NwK+rt0hYiocJY3wDmLu95QQi+t9/I/pyAtVGwSiz3AuyS0KZgSXUuT/4HWnBLTjPNruIk1iPilzGvf75brnmGRJzPFjfm5lIxQhw2HJAdCLvvPjpUKl8Teodb86Jg3tplHAwBOktns6hZkQwA+ue4LVltvHzFxGVCBybelDq836JtYAR;4:lnpKdROyPwSrruKJzjOfmSvAC9r49mHwZnYD3kce9xbvuBHp9EtJxh6ui/bkWnv1f5kRXGiqJhBmPH45B01nId/Up0YAIzqN8zgGZUgRbzlWjwuyg1T5XWtZVzYYfM1L/RAqK1d37Dqtjim2XxXxNjPYBAi4kf3EH5bMysKNyBaXwNg1m2HeJ4qPyC2mKVUVALEq6LVOvS3YqVest4lbzkIvczYBnGgx/73Q+njeQEgG7/FKJ0SXj0PvYeRCXN3g5g2HAdQUNgEBBwl81G0f9g==
X-Microsoft-Antispam-PRVS: <DM2PR12MB01695C225E33652D2B9DD91EEC670@DM2PR12MB0169.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM2PR12MB0169;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0169;
X-Forefront-PRVS: 069373DFB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(366004)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(2486003)(6916009)(316002)(65806001)(23676004)(65956001)(66066001)(7736002)(81156014)(16576012)(305945005)(93886005)(31686004)(58126008)(105586002)(52146003)(68736007)(3846002)(77096007)(386003)(11346002)(106356001)(52116002)(76176011)(186003)(53546011)(47776003)(54906003)(230700001)(26005)(50466002)(956004)(6666003)(86362001)(6486002)(36756003)(97736004)(8676002)(31696002)(65826007)(229853002)(7416002)(2906002)(8936002)(53936002)(6246003)(25786009)(81166006)(5660300001)(446003)(486006)(8666007)(6116002)(476003)(4326008)(64126003)(16526019)(3260700006)(72206003)(2616005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0169;H:[10.236.64.67];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTY5OzIzOmdUWm5UTERldkdpUFdVbGNaVEpFZFVtL3Q2?=
 =?utf-8?B?MlNXcUlCSFRidTdkLyt6Q3BHQWdHTk51TGs5cTV5dFZSeElTdFQzRzFWQ3dw?=
 =?utf-8?B?ZjRqdjk1aTNFUTBZZXV4bXVVdFR0ZGpOQnArWGZTeG51YXVYNDltWlVGSDJD?=
 =?utf-8?B?bk1DQzB0QTlJdTdROE9iazdOMWUzenRJMDVZODkrM1hmUjNpWWl2SnhyckZR?=
 =?utf-8?B?eGw4RzA2ekI4Rmo3a0srWVFaazBaL3hqKzA3Nml1dWxTUTlUNmJBZVdVaWJF?=
 =?utf-8?B?ZERXM3l0NndNdjZPNXI3UkxLTVpBVUJyaHJvUHl6MzBvWDU2YmlJNDJ2QTZo?=
 =?utf-8?B?ZHZhWkQyQksrNjlnaWZDakhCWFJCNFZxMkp5K0RkR3l5b2RNVEtuaVJGUkI5?=
 =?utf-8?B?cHdZSzNZd2drSHhQSGd3Q0RyQ1cwUm1oRFlHQXFCVEFzODVSejNGdURNZHli?=
 =?utf-8?B?UHVyQ3Vxd25Oc1RnZSt1SHdYT1UrQVU0L25CSHA0bkZzNGJMUUlmMVhmcXgv?=
 =?utf-8?B?czgyenJiQ041M29ZalpyOGM2NUcreVY2dDYvd2FjWVp5SmcyT2dnRC9aakkv?=
 =?utf-8?B?ZHB0NUJuUFlreTNkNW9nUmlYWnVBZ3FiU3FjTlpqMjNvQkdHdFJBVG40U0JW?=
 =?utf-8?B?aGpibzUvemZmVnd3SVAwSHplTmliRER3alhSUnZ1OC94c1ROVzF5SXlLajJn?=
 =?utf-8?B?YXB5MDFoWFdUQkpPN0dHa1AzbEVKQU5hTWlLUWNuTWVEUEJ2Vk96TlllQmQ2?=
 =?utf-8?B?cEVjSnFxbkx1K1lyV1JOT1VqL2dVa3NYMFJsdUR3YUhxMkNib3hkbzRab0hi?=
 =?utf-8?B?SmYwRHVPeU56QVJoNlEwYWt4Y3RISWpWdWpDVUtmTlJMZlg4Y2tvc2wyQm9m?=
 =?utf-8?B?ZEhGZllmN1RUQkJRYjFXSHZWQnZ6WDZjbTR3NFVHaDZsY0pCenBobnpRblow?=
 =?utf-8?B?Tk5BR0hHQmZQQUsyZ0dCelJ0UlNZZ3BHTjR2UVlyVEorNk1qT2VMaTRKZWhW?=
 =?utf-8?B?K0k1aTB6NkpJdWZoaUxHV25COTc2SkNCVURvRlY2RWxGa0YzZzdEZVFzU1Jz?=
 =?utf-8?B?RlJJSFI4dDV4MGZKSndMTnpRaDdZWDVwMUZFVkg3MjVEdkhKRjY1NkxISnFZ?=
 =?utf-8?B?dWE3c2I2MmF6eWdMcHNkclVOWjl4ZzlRU3Rmc0pKeEFBdGN0WTQ3N3k5QjVH?=
 =?utf-8?B?VVJmNjg3VTlTR3hMYUQxaEtkS2syMTgvS2hQNmZwOVJXbUl4VWdWaXhJbUc5?=
 =?utf-8?B?QjFDb2JENjVjM3hNMzBnZ1d3VUptbmhVQ1BidDc4SHp2Qk1TSTAxa05BdzdH?=
 =?utf-8?B?eVhCN08rN0lMc0k4bVJHOG53SHdsZjZVcFpVcUdMcE05Q3RvTHllTEpManBu?=
 =?utf-8?B?dTNlS0lxZi9STlBCeDhYNVljeHpuVkU3VWlwaXV2MlcrejRuK1JmaHkyajRD?=
 =?utf-8?B?L2F1aGFGOEFHZ3Z6Sll2d3R2bUpGQ3EzRDZmODlNVitTdVVTR1J4amNwVThh?=
 =?utf-8?B?OElacXp1emVBUnVRRXVEWkc0RU5wWXdiZTZvcUdySUczNGVZRElhcS82SEky?=
 =?utf-8?B?VjV5K1FsWVJqczdrWUtoNTUrS2xWNThzQ1pwSHVPbXIxN1JUY1F1dyt5SFEv?=
 =?utf-8?B?OE9yVjBHUVU2ZTVpdndEZlVBSHhYSDl3aHRPYkRRbVlSYy9XbWkxSlU5Qkgx?=
 =?utf-8?B?b3F0RGk3YmlGSkpvZUkwSFNnb2FPeERSc21lYXg3K3R2TVlQSjU5NzlQdTQ5?=
 =?utf-8?B?WkVMTm1ZT1RxMTVBai9HaWpVZGZkR1NtL1c0em01NXQ2d1c3SG03YUZLZk04?=
 =?utf-8?B?VjhVaG5HOFVDWlVCQU5uNzJQV2JlcEtzRTBMVDFJbVlCM1ZaUGMzN0FIakdH?=
 =?utf-8?B?YUcwS255SkZvYi9mMVBRS3JIaENLQ0pnM2p3TS9qUnVJYnBwSU1USmxBTnJz?=
 =?utf-8?B?c2pLeFBqZG1HalZnOWNTQzJzb2ZZQVdWYzNhUWhGM1FxVUN5b0t4Z0hmR3I0?=
 =?utf-8?B?RkxsdWJnYlc3YzNBdHR1Sk9HYjNJNWdnOFBnem1PM1lJeE9VNnVMbVp5M2wz?=
 =?utf-8?Q?+fPiZZNa93tNMtsftKEOaDea3?=
X-Microsoft-Antispam-Message-Info: KepFO38T4MRHchzM01l9O4ztr2b/hm8vPxWgwMvFqzHALh02/rpQX6dpwVT0253WkPii1MmBZ0s3nCjryuR6ZNEaUlmIAjm8RN0zhBY2/coH9dBUvf6Sxi/UaxvC7F8lXmaZPJVPjunrpu3Z6b9N2S72l8HL5vHaY1I3OUr3TaVIlft8Brw5vFe7D7ktZKV9
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;6:vaR7m8m9C9M04AsUeM1jJ+qaJtn5COcQGkWboqfg3xwiUBX6pNXA5vUbTpgbYf6xFa5XFslYfd0GJCMrkgGfxUQH5tUkY8jkpoSnRCbuw/UynSsRmwNU1UtlQpbeS2kQNFVhyNZN0xj+MpUxbkhNdV3h8Qg+cPWtexMprQCxg7Sud7QUExBYK5M6fJbpwyHYDvFIqVdJvCajxRdYjhVy3X8d/Z+Yd8Hp151iymH4SPPHWcTDoscS6KypeQY/D6dl4MNEnR7eDSdVZMxgoLAwF4SH0tEVljuM1We0/dcXGs3h3d66XoBF3AMdz5AzZLKjc33JdAlzccjPUvBoAPVCfYUmugAXRhMU/KbFYVqAP3Jv8nKNB5hycNUS3rPSNc8bW+3oQ1rk6LZ9yHndtA9H08mYHXKYU5IJGD/m3giozPxZaSY/OxPv3YS8NK3LLPIZlJCAaLSKi3C2ct65u4r8cQ==;5:hpFWEqLkecTRxnrOKZf+iNmsHbT3lN6O8yO3TKidfV6fq3hRnB8/Tke/H0Qy5ebcAI5jHFIXT9QHjZjDeAP5glJJKF20ZV9qPQCG69YFhaMJhUsTgqiPA2cO1vPMJ009+vsnlzGQJxjhMPUU02yRnTyz23e9UlHbOnmakrAYWPk=;24:iC1tT9vxB2XIxyBgfx6EAb06ZVAcVGM8WpB798RFQp5tQJYg3U+U/aM6adR2vvKrJgjG6v3hGH+/ODCFGYO1hpcinwfsShy4tkxkAxkNf2o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;7:Vk1xV6gDcsx/8UHXDFUumYIPhfe63MUZJI/oE7cUlmDWVcOG79B4b0H8YnGKI7I6kzkhrUAv173N804jfdf3+bG/sh32l26OuXvoAQEGgzAL8uszISQdloNe/9B9B23BrDpeGTotcJga/bXNVpljVAzpafsyQznTGOMpVJ72VhDGetZ1eSP1+JdJi5cqeMlkNPjpTAdlB88IV5JffurOVdZeGuA7KGdJDRxqNFWabSLTeBmIjr4lv0JQL3BYaFu8;20:ThuLofl7iqXpNyNBH+cmvvlyXl16mB2O0MR6ToYu6txbp1FwN2lhxQ7xJt3GrZo5GV06qOgNpQrjDm6GAeyidB71225yBYaPD86S0YaUbWPfJjqJbDAdGMCvW7pLSomTMoSMTl006ItxdS9u9bVKL+8JIJCAxbW59tiAjQn5/KpOgzTPBJA244iCl9/2iv+w3hwcvat9DDe3pJMYIffnLEtAtZVU0OCQ7tnOfVR5wcI80f+g+T5AvX6hAu48XqPy
X-MS-Office365-Filtering-Correlation-Id: 18cd2d5b-c5ab-482b-770c-08d5ca5bd029
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2018 20:43:21.7099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cd2d5b-c5ab-482b-770c-08d5ca5bd029
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0169
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/2018 3:20 PM, Konrad Rzeszutek Wilk wrote:
>>> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
>>> index 26110c202b19..950ec50f77c3 100644
>>> --- a/arch/x86/kvm/svm.c
>>> +++ b/arch/x86/kvm/svm.c
>>> @@ -4115,7 +4115,8 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>>  		break;
>>>  	case MSR_IA32_SPEC_CTRL:
>>>  		if (!msr_info->host_initiated &&
>>> -		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS))
>>> +		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) &&
>>> +		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD))
>>
>> Shouldn't the IBRS/SSBD check be an "or" check?  I don't think it's
>> necessarily true that IBRS and SSBD have to both be set.  Maybe something
>> like:
>>
>> 	if (!msr_info->host_initiated &&
>> 	    !(guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) ||
>> 	      guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD))
>>
>> Does that make sense?
> 
> The '!' on each of the CPUID and '&&' make this the same. See:

Doh!  Yes, I don't know what I was thinking.  Just the end of a long
week I guess.

> 
> 
>  AMD_IBRS set	|  AMD_SSBD set	| !AMD_IBRS && !AMD_SSBD | !(AMD_IBRS || AMD_SSBD)
> 	0	|	0	| 1 && 1 -> return 1	 | !(0) -> 1 -> return 1
> 	1	|	0	| 0 && 1, continue	 | !(1 || 0) -> continue
> 	1	|	1	| 0 && 0, continue	 | !(1 || 1) -> continue
> 	0	|	1	| 1 && 0, continue	 | !(0 || 1) -> continue
> 
> Meaning we will return 1 if:
>  the host has not initiator it or,
>  the guest CPUID does not have AMD_IBRS flag or,
>  the guest CPUID does not have AMD SSBD flag
> 
> I am fine modifying it the way you had in mind, but in the past the logic
> was to use ! and &&, hence stuck to that.

No reason to change, it's fine the way you have it.

Thanks,
Tom

>>
>>>  			return 1;
>>>  
>>>  		msr_info->data = svm->spec_ctrl;
>>> @@ -4217,11 +4218,12 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>>>  		break;
>>>  	case MSR_IA32_SPEC_CTRL:
>>>  		if (!msr->host_initiated &&
>>> -		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS))
>>> +		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) &&
>>> +		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD))
>>
>> Same question as above.
>>
>> Thanks,
>> Tom
>>
>>>  			return 1;
>>>  
>>>  		/* The STIBP bit doesn't fault even if it's not advertised */
>>> -		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP))
>>> +		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD))
>>>  			return 1;
>>>  
>>>  		svm->spec_ctrl = data;
>>>

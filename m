Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeFBBEj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 21:04:39 -0400
Received: from mail-sn1nam01on0071.outbound.protection.outlook.com ([104.47.32.71]:20448
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750916AbeFBBEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 21:04:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH v1 2/3] x86/bugs: Add AMD's SPEC_CTRL MSR usage
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, andrew.cooper3@citrix.com
Cc: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
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
From: Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <fa831d0c-3e7b-b5ab-17a0-5d3b1bfd6142@amd.com>
Date: Fri, 1 Jun 2018 20:04:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601145921.9500-3-konrad.wilk@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN1PR12CA0062.namprd12.prod.outlook.com
 (2603:10b6:802:20::33) To CY1PR12MB0168.namprd12.prod.outlook.com
 (2a01:111:e400:50f6::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0168;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0168;3:4vW1K1D+2XMD5oleNv7ISDcgEd0OKlaxS/CaE14RP3rdbl2vqiQTYcrakfVdMMHoZu2p5eICbWp6R3OA+B+yEytO/4U43bOaKTNRJeXB8gYsM4F+R8ajfx9aWTCkYUC17yldlkeJGf4b5HI5G97nHwOJtohjM0KQV9O7BBlstq8OS5A2uiIGAy1NWwEVop9xjKQtau7/x8tFqsGuLPIZqrOVz4avsE7ZNgEoby7AcxoMnVxTFWoS73bSOP62u1UD;25:DbHV1zqvIqdqfKIssrChd9hACksgQ0UGdPXvV1kqSxabtqvnmiCELhumvOW1uGvoFNP97tY+ExOA7DXnX4foQOC2wLZCxirE1s2saixj2nYSXgD+SRB1ffB/tGU9CwDkl9EVNPc3s2uRWdeLFxtUgX3l6IK9Mo7rmSe8Zz+Jmr28zCrnOxdZJ7EOC3t2AtM8fiEjqja82Q6/xfp3z9YmYIjx7e5t+esFHsiJW/CS9UGV/RzT0rJml8iAry15OCIMHNbxldVM7HQX6IhxW8IotthFJGARBqV9OHfA5J3XCnJNwGmOIJWcE3mEvFv7Qzudyxnrqov8jy4/0w8ou+UZww==;31:/hijRd/7kOfeAS1py1DX+RkPsTelrBwLnZYmAx3a/EzHAXIO7pOR0zGcHZIFnPhdcT3yVFWwfSBESHpwV/GhWbzaK2Bbl2t4H+gCcNs4moRa1R1BUQlmNjhh/QsfDqh4c4GgzkuK+VKkDsxdbqUxAXAr9w+N9krCBYIitRDPyfP/eR+Eq0HRAACn1USuXrhmMHNzdmEdBrLfqvsecKW4ZTzpQgb3scY4c9OTz8ono24=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0168:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0168;20:8HdIM9OhsQ2jNT5bEiLZ+B/UJ/O8WDycp1jubugzaoeb4hbRF6Siles3ya6VSIE3KkV79kOVes8FG+aKXNkTrlldaGro2AIg4asIUF34/fav9QMZylTTukYmcbiGY05ImikMh0w7IyoBD4SOKRk1tmbxXpzqjtehb5McdFy0p3ubWr/VW45tsUP3UBqeLf1UPdM753wIU/E/bY12mUV/GRYm8yPVKVrXN9g+PRF/ZPCukVR7Qk5+V8/e3E/2F0cBqbr8RGTWPbmykMdEJmRNF1CDEwX+xXhIlKGP5KFplIPKd5d45hFsLQ3rO109H28Jk3onB2H4JJ6NeB0Ja2yuDYNE0GNGS/RHo9B1IP5PnQnHfNzPbYyXUZHedLpvMY52wbpWPJUVy1a9ed6gOchvTsAbM7mEHgy7jeeP49+eZ+x2YoYBcsePf5Xjci8+tS8aOvcMTaMdU4QfuxPRx54atUITNIaF34iFp54j+ZqD8YSjtuKrmxUo7DUQXAKTLpmn;4:RVM3Ojd0TAkR2G0KmUjgvnDrhImZz+M/Nv8Ml355sv5pN9tYX30v/srX8FzCg+fIiLxuO3sR1Yntqk/WBOPEvJoPrwEFMBPmXpdM8uj7+DxCStg5w/+1WcRAEz5ZlDlrQx3QITzQS9lcZayBek6+sRubQEW+H7sjVz2iTkCQPHbBjZS/jBcd3PYTAzg6ohQuwuo4aUOGPnuKWtobe6QJCrqlCkOFQtMYMmPE0vqUrCcYriNL2Tvcg0cKDsBckD95YgA7H54cUu6c/NvW77XBOJT9YMf/Vh1xvmCa0oGOjVsYmQpM9z7v20DN6KZYWItNTRh88z7X8BF0Yey2AaviegwGHugods3lWxkAbtHaBKa1JzR4pG2nav5logh/m98L
X-Microsoft-Antispam-PRVS: <CY1PR12MB0168424187C3C8750804C13EEC610@CY1PR12MB0168.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(146755900322472)(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY1PR12MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0168;
X-Forefront-PRVS: 06911FE69E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(39380400002)(346002)(376002)(396003)(189003)(199004)(81166006)(16576012)(305945005)(6666003)(6306002)(316002)(76176011)(26005)(8936002)(47776003)(386003)(58126008)(6246003)(59450400001)(8666007)(446003)(54906003)(64126003)(23676004)(2906002)(11346002)(97736004)(81156014)(2870700001)(7736002)(476003)(186003)(16526019)(2616005)(7416002)(52146003)(53546011)(65826007)(52116002)(5660300001)(8676002)(2486003)(77096007)(86362001)(31696002)(575784001)(106356001)(229853002)(36756003)(65956001)(478600001)(966005)(31686004)(68736007)(50466002)(72206003)(956004)(6486002)(3260700006)(66066001)(53936002)(25786009)(65806001)(6116002)(486006)(3846002)(4326008)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0168;H:[10.236.64.67];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwMTY4OzIzOkZiWGx2SWNRRFl1ZFh4ck11Tk1xQXNpN2VW?=
 =?utf-8?B?aUJyQU9mZ0ZzMk1GbWlZUnZ2SFhZVUpXVHlpbmVqQVR5VGFlamJQQVk3Ui9Z?=
 =?utf-8?B?eWdJb2NhdjNIM3lqM3NuMVA4NG9FOHpvNVpGMGFoMlU0OXhFVTc4Y3MxODlT?=
 =?utf-8?B?WlBLVGVpUFZoMjV0NEd0eHZOdHdRbWVud3lib0IvWk9FUXJWaURDUHM5bmU1?=
 =?utf-8?B?MTJvUGIxYVlaOStPbEVuMXNka1N2Nngza2xsVHFBOW9qdjZNSVQ3UVUxQ1M0?=
 =?utf-8?B?NWVkbC8rS3lnbzh6dnBLWDBnRVFVNXhXSndJR3ZFYUYrVG5iaW9US0JvamdJ?=
 =?utf-8?B?T24yOHFiRVVkMm9MWDduTFZtMjdBMjRsYWYwQTY4cS80dWZleXpEMmt2MnFu?=
 =?utf-8?B?UjlucHFmMk1jU3FxeFR0Ny9qcWtHOG0zaWpQMURiaE9KTkw1bzZPYm9XdkNG?=
 =?utf-8?B?WkxoTFE1UlA2ckRPekw2dG12RThibkdRVmhiSktFWTZ1cHNYMjJhR0d3NGxQ?=
 =?utf-8?B?M05FelFqd2FBYnZuOVdJZ2lONEQwN00rWHIwRDhhRnRUZGRVVTl5QnlRLy9Y?=
 =?utf-8?B?cnlFSzhmZnhJS2NyWjNFcHN2MEkyNEs4cXFLU3ZWZVU3V0NoRXdzMm1SRnBa?=
 =?utf-8?B?eE5Hd3JFYWQrdTNoaEJEK29pcUw0TWJNdTZBMGZKMDFXb2hiejlxTmVTV2FS?=
 =?utf-8?B?UDFYa0orWitPeHc2V0FoaDB1TWJDbjd0YlI2MEIvQkxSOEE0S0xvVW4rUkFO?=
 =?utf-8?B?QW51VjlLM25kQWpiVDdmR1lueXZPRGovRU1PM0Q4UnM5dHhZQlFlM1NPbjE5?=
 =?utf-8?B?OFVrM0IrQ0pyK0ZqYzRZQkpldVNPYzQrak1DaUxVaVZMdzV6Z3YxNkh0N1Zx?=
 =?utf-8?B?aDJHZjd1U2wrWEJQUzBwRVc1WUV3dHhOUzFyN2RvM3ZST2MzYlFnN2o2UFBR?=
 =?utf-8?B?RkNwSXF0MVVqMzBKM00xMzh1VytLa2lmdmdDdFp3Zm03V3FSZ1BzZmdHUmxN?=
 =?utf-8?B?Smt0MjRyTFovS3hwSFA4WXBDUGdEVzlWa3BaL0x1V2M0V1dwdmJPVUdCZTNM?=
 =?utf-8?B?NXg5c0xOQ3hsQmFINVcxSTNKWU5BK2RSbXYycGxCekt3VkFWRHVRV3hYL2VY?=
 =?utf-8?B?YzlJbXJ0Q0puaFkreENMdFFqSWxmblpQQVZvb083YkMwNWdhbmdFM3pwSmVJ?=
 =?utf-8?B?eEpHV2hDTHFvd1owQmNSNHRiR09IeUsrNTdkWS8ycncvcm9uc3QzTzluOFdZ?=
 =?utf-8?B?dlJzWjY5ZVVqclk1cHpXOGkrM05rNmswbVdUSGRqUmFwdDJqdy9zbW1kV1l1?=
 =?utf-8?B?eUhROXdYMGhzdXgxbCtkVk5jL0pNWVJMOE12a1Evd1VNWkRWSmlOejd0bUxD?=
 =?utf-8?B?alMzSzRRVUdoOWYzMVNDRlAvSnNBODNaYWl4cDVDcWRFZTFXMmhiL21Ndkw0?=
 =?utf-8?B?dnZRdklTWERuWkRRVEhNMTZhRDdRK2JISWsxQ0d5ZXFsVHdVTWZyTC90VEYz?=
 =?utf-8?B?WDdWT0FFK0ZPRkV5a1A2YlVRTldrSmN0WVFvampXamFpVmd3TGRmSTBqV1o2?=
 =?utf-8?B?R2VxT1RvL1EyMHR1WG91VWE0TGZPTWdadEllTFRoZWlaMm9ZdXNIYU5hVk1o?=
 =?utf-8?B?dzcwdis4ZWp6VlNVWWU0VVhrVk1RREFmUVZjT3ZDTi9ocmNxajdJMllaL2Zs?=
 =?utf-8?B?dzJCTmpLK281aW9UckM0eG5uWHBFMFU4VzBUUWZSUVJhZ3luNUp5UGJCTVQ0?=
 =?utf-8?B?M1dQVE8zVVcxa25Sa1FWUFhCUkFOQWkvcGJTWnZlMGNvUTZ2S3hNNHBvdDdO?=
 =?utf-8?B?VWV5RHJjcE9TWW9sMENPUlRXcnN0UzRQeFpzdjdvMzZUMllYZEdqN1Q1WjFx?=
 =?utf-8?B?Y20xR2JlWVR5SUxHOEZiRDQzSTdPVVFFdzRYMk5oTWM1QUpLV21vcjZJT0ZJ?=
 =?utf-8?B?RmEwUElQTnpXVE9paklsODQyTUJrcnJCYUFLVVRnSlo5R3ErN3E1ak5yQURE?=
 =?utf-8?B?T1hGU2pwUGFDMFpDTVJqTi9vbHordXpXbkEyNERwZjE1RGtUSTZOeUwvQnFG?=
 =?utf-8?B?eXIvc2tQM3JoV1pDejZmcG90bW9LaGxJU3pGVmkyZVd3RTFjQVErTGQ1M0tW?=
 =?utf-8?Q?MK45vxxo3OOnIM8aWEELo+MfOjIVp2WYNneRKvMqiiZ9?=
X-Microsoft-Antispam-Message-Info: xLXcFSXOdWo7QkddXux7aqLUEEoAD2pNJtWZw34LBV8YZdxaEgbFueLSWiM1NCoEhF1Y1dLybLONuIydZpESNIK7vyJFW6yjTxH0aS0V4b+/iuDTtcMmY6EkmrUgY9TzTPZl+z04rWB4MRvrvdfzYeAJnBXRvnK+6GlHJprjwleGNDobTXbgqrPVfCFylUGF
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0168;6:vDJcJBcqK4VmP42wKkTk0kb3oPs3VZitxcYe+XXPhF2Zt/24AM90oTppg4QnJEtT6abny672oS7xmWCkahVCyA/9gv4dYhxLBgrK667tVNLE5J45ek/wOKVIUXPaAKZznXZUsnf9FoZbR8kohP1VpVEg5VsMX9zaZaK8fMXTNYW+agwHeLs50dd9xVj8iwjoGF50RayPEjsIgmhbyvTkHI84fTMinYtdXalpVpbwb+fC4IPR49vQQwlIhNo+Pseboud9X3SJdOx1fwbOfPIkDtMS0kgU2FQG2EF1qRsXclJgLV1YmlhCOC0bGjnBOw5GUeR191Bbfjr+5hdfvM1t4MULdKmp3rrp4M7C4yI46yHJ/PGA1FFMisOdWgttzKa3h6H6BU2UydYIrtVj5twwJJnfsO4IpNW9ioDxKv4kIIhpXYfiXvN8vqLTsGQtA3ZTV5PQKHcd3snKFtVNV/ma9g==;5:eMSkF/wJ1q7wkMC61pQ94sXo4kUca+n3/Ey6zibiwUJ2kJuC/s8gocVNQvmiHq7y9U75P1mNJlXBnvoVBqvw5rSSOdQANPzejtejuj0eYIo27fS1xvextSiQkDtWiVf0VAl5J+doH2/ZJuUWHc6JH7u6STj9+0BupWKrhCKgKts=;24:Av9XqDBxApcPnfLYZMyvySzAD0cqsZIKgU/uTaVn7GHzD/1Rg3ELm/DPNHUiiAnR8n/0nVjA72wyWVCbRet/nbBT6HJ3AbLqwEb0CRqyNG8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0168;7:g+robr1Sr26whSeDrDgRv+2+lrgLVkC10JoLa9IdvpJjj6RbaA+x4B7OLovamwDjc2BNeUmGPYFaBCr7wlglzPUH+SBw5awjd6rrlQAo2vK/4VAZXCOg0F5wqdL1PeJ56hr5Z3FcTCEYlVc9+Fz5biuOThqpM3OtCuEKOu5IjSTn9buGsunSWkaY59Iub1sQNapiVr2tTGhs8+H+U+/IGFjaVyPQSN7vZ04iJzyJFxE8FXMi4HOTf0NpGZthTb3N;20:1iryUM+S4NLb2L2SGAaXTpRB8Q7azMzFsQf5F2LXbrsjGFUt/MwQP3YCmcJr6nogckpcH5iUXym1lzAkDiDa2Ghplnd4wzVO0dXNEJLQdXR0bu2OKPmGoPWaMwNvRsEeZuvIPM59BjjfmTEJA+Y+eg8hPLAwZKrQdYlrhF5/hh0y48N7jFqbnFijczjdtTaKS9p39yYt8uDV6PfeW97oGWkFh+00mSGBBKUX3/3QyrQ62c3MPQQXKfhcr1VXyPjN
X-MS-Office365-Filtering-Correlation-Id: 994ad1d4-dd46-4ce1-f3e8-08d5c824cb1c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2018 01:04:28.5468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 994ad1d4-dd46-4ce1-f3e8-08d5c824cb1c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0168
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/2018 9:59 AM, Konrad Rzeszutek Wilk wrote:

Hi Konrad,

Thanks for doing this.  It was on my to-do list to get this
support out after everything settled down.

Just some questions/comments below.

> The AMD document outlining the SSBD handling
> 124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf
> mentions that if CPUID 8000_0008.EBX[24] is set we should be using
> the SPEC_CTRL MSR (0x48) over the VIRT SPEC_CTRL MSR (0xC001_011f)
> for speculative store bypass disable.
> 
> This in effect means we should clear the X86_FEATURE_VIRT_SSBD
> flag so that we would prefer the SPEC_CTRL MSR.
> 
> See the document titled:
> 124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf
> 
> A copy of this document is available at
>    https://bugzilla.kernel.org/show_bug.cgi?id=199889
> 
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 
> ---
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: KarimAllah Ahmed <karahmed@amazon.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/include/asm/cpufeatures.h |  1 +
>  arch/x86/kernel/cpu/bugs.c         | 12 +++++++-----
>  arch/x86/kernel/cpu/common.c       |  6 ++++++
>  arch/x86/kvm/cpuid.c               | 10 ++++++++--
>  arch/x86/kvm/svm.c                 |  8 +++++---
>  5 files changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index b6d7ce32927a..5701f5cecd31 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -282,6 +282,7 @@
>  #define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction Barrier */
>  #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
>  #define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
> +#define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
>  #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
>  #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
>  
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 7416fc206b4a..6bea81855cdd 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -529,18 +529,20 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
>  	if (mode == SPEC_STORE_BYPASS_DISABLE) {
>  		setup_force_cpu_cap(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE);
>  		/*
> -		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD uses
> -		 * a completely different MSR and bit dependent on family.
> +		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD may
> +		 * use a completely different MSR and bit dependent on family.
>  		 */
>  		switch (boot_cpu_data.x86_vendor) {
>  		case X86_VENDOR_INTEL:
> +		case X86_VENDOR_AMD:
> +			if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
> +				x86_amd_ssb_disable();
> +				break;
> +			}
>  			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
>  			x86_spec_ctrl_mask |= SPEC_CTRL_SSBD;
>  			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>  			break;
> -		case X86_VENDOR_AMD:
> -			x86_amd_ssb_disable();
> -			break;
>  		}
>  	}
>  
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 494735cf63f5..d08a29bd0385 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -783,6 +783,12 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
>  		set_cpu_cap(c, X86_FEATURE_STIBP);
>  		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
>  	}
> +
> +	if (cpu_has(c, X86_FEATURE_AMD_SSBD)) {
> +		set_cpu_cap(c, X86_FEATURE_SSBD);
> +		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
> +		clear_cpu_cap(c, X86_FEATURE_VIRT_SSBD);
> +	}
>  }
>  
>  void get_cpu_cap(struct cpuinfo_x86 *c)
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 132f8a58692e..f4f30d0c25c4 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -379,7 +379,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  
>  	/* cpuid 0x80000008.ebx */
>  	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
> -		F(AMD_IBPB) | F(AMD_IBRS) | F(VIRT_SSBD) | F(AMD_SSB_NO);
> +		F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_SSBD) |
> +		F(AMD_SSB_NO);
>  
>  	/* cpuid 0xC0000001.edx */
>  	const u32 kvm_cpuid_C000_0001_edx_x86_features =
> @@ -664,7 +665,12 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  			entry->ebx |= F(VIRT_SSBD);
>  		entry->ebx &= kvm_cpuid_8000_0008_ebx_x86_features;
>  		cpuid_mask(&entry->ebx, CPUID_8000_0008_EBX);
> -		if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD))
> +		/*
> +		 * The preference is to use SPEC CTRL MSR instead of the
> +		 * VIRT_SPEC MSR.
> +		 */
> +		if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) &&
> +		    !boot_cpu_has(X86_FEATURE_AMD_SSBD))
>  			entry->ebx |= F(VIRT_SSBD);
>  		break;
>  	}
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 26110c202b19..950ec50f77c3 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -4115,7 +4115,8 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		break;
>  	case MSR_IA32_SPEC_CTRL:
>  		if (!msr_info->host_initiated &&
> -		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS))
> +		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) &&
> +		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD))

Shouldn't the IBRS/SSBD check be an "or" check?  I don't think it's
necessarily true that IBRS and SSBD have to both be set.  Maybe something
like:

	if (!msr_info->host_initiated &&
	    !(guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) ||
	      guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD))

Does that make sense?

>  			return 1;
>  
>  		msr_info->data = svm->spec_ctrl;
> @@ -4217,11 +4218,12 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  		break;
>  	case MSR_IA32_SPEC_CTRL:
>  		if (!msr->host_initiated &&
> -		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS))
> +		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) &&
> +		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD))

Same question as above.

Thanks,
Tom

>  			return 1;
>  
>  		/* The STIBP bit doesn't fault even if it's not advertised */
> -		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP))
> +		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD))
>  			return 1;
>  
>  		svm->spec_ctrl = data;
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeB1Fzk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 00:55:40 -0500
Received: from mail-by2nam03on0070.outbound.protection.outlook.com ([104.47.42.70]:57376
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750756AbeB1Fzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 00:55:37 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH v5 2/2] KVM: X86: Allow userspace to define the microcode
 version
To: Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>, Nadav Amit <nadav.amit@gmail.com>,
        Borislav Petkov <bp@alien8.de>
References: <1519788874-16561-1-git-send-email-wanpengli@tencent.com>
 <1519788874-16561-2-git-send-email-wanpengli@tencent.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <f9517b28-b782-d213-384a-b0811bf7e4fb@amd.com>
Date: Tue, 27 Feb 2018 23:55:30 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519788874-16561-2-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CY4PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:910:4f::36) To CY4PR12MB1141.namprd12.prod.outlook.com
 (2603:10b6:903:36::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d66ebe65-4e52-453c-9d37-08d57e6fe2d3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1141;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;3:z9bgyiLXYc9gxbxpceuB1z5vDTf8OqTAg/DUJn9m1LNNoow4S/VkR7wsVNTghTF13xk4Lc/+WTPdgtGJfOToe4E/jEVsHkFb+XzVt/2YNrogEwkTE+gCnTWVUFhzVj8Z2FuM96dZNsHXNPLBiEIgstCjcNSW+ts4lTSfdIfiWLmQ2QjDGPjYiT0/Ns2ISRfpZ9la/lMZsjYiFbeusbp2mf2ULpBHFPF6z3kMC2nx3ivsUzU/4U9z8SZlJpdV3+0b;25:ysak5aa04uojXzjf3UBex+S5juTsVpAhRAaCEsa+SxrjZQD/RqhtUD4yXziTynxRub+NtfAgp/6vQDggv9kt6t4Ai+D/ji/jdumTU0EMfrlfE/Ab4QSHc051bZqPGSj3NjkWYyzYR1tCs/7StqVlBae+tDjqR2JpkBAB5lp4bp+iTVOe/J3t0QBVrjz8o/nFUoXkQWi6UNZdnLbo3hh0ggb383L9Yhu5s1yfPOwsuEaSGrf44MdXFBkmPVhZaENv9lCjCbfHr8ile0Shfo0qe3frvtZBdSExdexuLvb14O2gX7GnCU+8/OJuWn431oplG0d4GundrppMDfvgC+kITA==;31:+RBEe0Yv4+ks02XATyb0NmGO7M1Ch7iSIviDPsbp3/gXBbL6N8AeM6wrIw1EWdpTQ62Jx2aGggOtbHWevZogNxfP0NeFLbAmt2eSYyxjQ5EM0L81c7uHAt1SMfd5cJfW1k9Z3qnbvT0j7Qj/L92fgBBANybloJ8tpFy2mEIMms5cvA5/Xe7AhAWB4G6CLINN6YdGa9rIQmocUVNXDoNndU/NSV87Gy3sB/zike0T2hM=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1141:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:+h7bs1u1h0k0hHlsW85k6/xNYzZHBNX9UsXgpDxxdvtgEKbDPySlGgzKF8fbRXY8KIZ9E5Ip0Etr84h37hn5w37YUHb6r1x2xdz+m56A8PumvJFuk6Z7EZh1y2zePW1fWL8ZLUX0tOCA9iAfap6c2QmlIZEjEtZlBNt1/ElBpNK6TLu6Wgr8c6P1GgDoVr5Jka4qYqDyAEKpUuUswFI2tq0JDZpu0pXy6Tj8ucFmaZA4oDpCqORLMn88X91/m6EgNRozGxVTCAKlj5GISVPEIbjgllFMBhVAFlu47gMhxpnSTIMDq64wTIcC5RtSAjrtNBS2nhNhpGUxN74ADCCy7W5/xhGuuWTqYJ+fycS+X6rtdFQAjG9W1BKhPZFPomFDLbylMSWosYlCj2nxZ5Wl089COCeZ0l/sBe2S3qeBNS6p+bTHRQ0zbRXK+/FjaD2eDVImj/46HyABcZDLSto3N1HlLjGNRgqopFH301rH5290SllVaIwXWXxKax7XfL0L;4:Zl0MP3Si5N5XyZ+m+3UZ5FKROuNehZO9JXfCBLbiu0T+L8bMPZR59BAMEwO/Byk9+bfgfI9/4lynid3xbwSvWNfZjbYpMvb+teVEDEdQFoJmIcZHmblBykSe4OCaBa/+3UOHM8okIuBJZOo1cyrhkDQqdGC1TAXyoX03d73nfJmWgdW7wm7StL4ZVnJSZuh+PKgR20YB/E2DY65dh3Qx4EIN7azmO0kioHd11ivPsWX1gwq4bO4kdpjqqBANcFEhZNfGCDBomiXejhStODFlyzcqTf1Oml+COBklP3Rp9TslPTQEkhKTYS5FwEnZSLF8xh6apT/Zkl1qHHwmxi+WkifcB2JqMd7Os/v180okdLVBMNTqSPJwkfWwJElKf7KL
X-Microsoft-Antispam-PRVS: <CY4PR12MB1141B8E3D8E1A69475232EACECC70@CY4PR12MB1141.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(767451399110)(146099531331640);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501161)(52105095)(93006095)(93001095)(6055026)(6041288)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR12MB1141;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1141;
X-Forefront-PRVS: 0597911EE1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(376002)(366004)(346002)(39860400002)(396003)(189003)(199004)(3260700006)(16526019)(39060400002)(50466002)(47776003)(53936002)(66066001)(105586002)(25786009)(8676002)(6246003)(65956001)(4326008)(5660300001)(31686004)(65806001)(478600001)(97736004)(64126003)(72206003)(53546011)(386003)(59450400001)(26005)(68736007)(186003)(2870700001)(305945005)(2906002)(316002)(77096007)(106356001)(52116002)(76176011)(52146003)(23676004)(6116002)(36756003)(6666003)(58126008)(7736002)(2950100002)(229853002)(86362001)(54906003)(3846002)(81156014)(81166006)(31696002)(8936002)(6486002)(65826007)(2486003)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1141;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQxOzIzOmorUXczL0xCVHNaVVFPcWpMMEFaejhHMTdO?=
 =?utf-8?B?aDRUY05RNzd1RWxReEtaemR5KzFtSnhzUDJPYnpYNDIvaVhsZURaV05YK3No?=
 =?utf-8?B?U3VyYlFLSTNSQkFZMGpnenJhdFlSQ3pXdmpmYUdPS2NWRFg4YysxMlk1eFBX?=
 =?utf-8?B?bnJFak9tZXlzNTFBczFGWFpZNFBqWUZUSnZnRFFpczJGRFgzZEFpSzBPVkdK?=
 =?utf-8?B?VHF3RHpSRHpSWERsb0piTG9jWmx0T29VV01xTWdXVit3clhGcjhSb2ovZnE3?=
 =?utf-8?B?dEJEbjlvb0lkZURJV3dNQldUNk9LbHRxZzZVOHpWTjNhNjBXeFNYZGM1WTZk?=
 =?utf-8?B?T1RteXE3MnRwOXIvdDJzdEVhM0VHeE5vYTQzenpMdUpqVFpEM0ZFWGpReHlv?=
 =?utf-8?B?Qm9GVTJOWW9mK1p0N1VvNGd4SFpUeCtsRG1MNjBqU0ZjUG8wR2xRaGVzVDQz?=
 =?utf-8?B?aXQrOVhWY0RHaWNsR3R0UmhoSlJhQUdUVGhVQUlrRldsNk41VDZvQlJUZkMw?=
 =?utf-8?B?QVhjNmkzRnR1L1BPSW9vcjBzcFcyMDlkbWp2VlBaZDJrVnFldU02Q1hMZ2p6?=
 =?utf-8?B?ZVZlcGZZZjhtdHZPcEYxQkFDWDFhVXRmc20vNkpSSWxtbEpyell6YU5nM2JE?=
 =?utf-8?B?aHpTTzdrRFpBTUdPVDlzbFFJQS9NaEVRbkY1bUtXNDBaODVJZWhTRG9Vc2ZS?=
 =?utf-8?B?VmhaVXl1by9kQnZjWGJUYWd6VkNBZksvTlRsd1RwKzlUdFU2VDdYSlpVazBU?=
 =?utf-8?B?SDZBZlFiNXBMY1k4b2pRZnlORWkxaWIyTzlrTzk1OXJoakRUeWVydVVuL1pw?=
 =?utf-8?B?dEFUZTdiV0o3d3RYNlNydHprMVFoK2tHeU13cDNQZk5UUTJUalVhTXFjWXZt?=
 =?utf-8?B?bGZPZWFhMUJQcXF5eVdsRW5aejlzNGpJUE80aXNURkNBbnVvUWp4VFJTZW8v?=
 =?utf-8?B?RzZHc0h1MkJCWVQ5SDdHWmdWVGJIQnBEWTllUEJWbWZnWU9kaUgweHlaOTF5?=
 =?utf-8?B?NDB5dG9YRHJLNmJPWXJYejFqSCtYaWVlVHJTVlRGZ0dPVFdRTWRzV0ZVN1cx?=
 =?utf-8?B?TDZaclVHa3JMRjNqc3pJVGQ0cHJTSUliSGdSUEZ0SHBIa0dRaVloaG5oU1o2?=
 =?utf-8?B?RHJkZDJFRzh6OHEvOUdYY2pOL2p0aVZ1SGpJRjJya01KaGd6Tk10U2ZtVjJ2?=
 =?utf-8?B?VnJRNUtjTFVWWHJTeHlkMGI1STRTckRkUEJxM3IvS3ZVMkR1YUlha0lIa3Q5?=
 =?utf-8?B?MS82TnlPc2NzbndtNkZ2UjRnZ05iUmJPWjRVSlluRlZKNjR0RnhlT25EUVRD?=
 =?utf-8?B?NmpxMlQ3Qkh1Ynd2eE50c3kwNzFPMmZJOGpYdFc4NEhEYkxYdWJhS3IrSTZO?=
 =?utf-8?B?Z2FkTmNKZVdrQVQ4Q0FqNE5heUFCTlJieXd6Q2FWUTFIaTY4aFlWT21QelJ5?=
 =?utf-8?B?K1grdGpxTFExWDVsMGxsZllESk9DeFVoUGU5ckZMWXJuWi9TK3VPN3dxK2JV?=
 =?utf-8?B?NkRkM2FzeSsxWnF6RlZ0L0hFMVF5UzBnZEUrb05GSWYyYlp2WWEwUkM3VE1m?=
 =?utf-8?B?NGxralRxaTJCaWo3aElCYXRwQWJqTEthckJtenI4V2hqbTJ0ekdlZ0dwMWF3?=
 =?utf-8?B?eFdlNURvakFGNFNwYXlGQVdJQmVuT2w2MHQwdEFKdS8wSlRLamJ0MjVDNFBH?=
 =?utf-8?B?L1Zqa3kzNW5JcEltMGt6R2ZhNDNUclJhUjhZazk0ZEwxWVdENmhNWnBORDBq?=
 =?utf-8?B?QnNlc05PLysxUlUvQ0c0dVpSMVBFcjVNWi81TkpFZEFLbzd2U3gxaHdIZ21H?=
 =?utf-8?B?MU0rdUhtRXhLbWVLbTVSQ2xXRXJqb3dHS0h0aG5HTm9IVEhJcnArNStlblk3?=
 =?utf-8?B?UzB1bWo5WnZiSnp4UDhQTVRuSE5yNVNRSDVkcGY5SHNXNU9vTXlpL1ZJZkFl?=
 =?utf-8?Q?C7irRvLApESdOoLYiDSMLGIGoc+80Q=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;6:7cIsj7X94j8c17K4NphRTnlYHMq6jv1crfkkSwK6Avt2XVS1ROJEGFj8PGDxlLUTrlwbJzCeu/6FO+KNiI9A1F8pjMQ9h3umct1oiYzaezNOTCrkVjIHqNWQ6ACPTnPcOT8PPACIIp/64tllPAoTozxWExCITFNJsNds06+TwDNHOS4OtLIo+fplrhqPz4Qz5P+dgzGFYS3syvrWFvtzljYMlqETvCo7JS6UWlELhYZaXfe191XdZTfNFGOTEXphVaGR4u21GT7WwIZ6WaMsMOdkN0m6+OgO4hh4QuFU9+oIA7zxEaJQ1ITdfx+Kkyn0Zw/SdFoiQZeb/sGxzao9BA==;5:fH4tLYMbLUzgtCiLqp9v6wndBqm8OguWQOsF+g1dEh/HdbkY9SouM/ivFZ0pX8+MkPro7dXq/vNuYiAeuyxH8Ojr7tN4cYaJRj2xMPDDgFia4m4bDD6V1+UqFzLRkZ7RExFGogMIVS6TwfHoBCp2zDBUZIXy7ths4Rafydv9UgQ=;24:44jhOiL1I2upk2XdOQIr55sr+p+gx0TilGMMQq2/SYPRvnjPftgmm4b99ObdpXs8QJj5l6y2FRsK9A/M6dfoYYko0Ke2sjIwU99kp0z5vsI=;7:IvRJLnuS3+jPc3Taoi2uw7Hk6q7/rhzufllBWu7Aum8WRwNOtBb+2J2mc5O2VEmUOZcQLCePGCh0aJW3+iGle3i/eO6kC8qRwQ7BPBgHIOdbU8Wsb02SrzZW7RoDKJJ20PG/n60zifRu4qhHIFcYhhpm9kjjY/5guBMta7F1Ad1jCvSZvh8no4niXoKTx1JH1O/GnsoMKX5kxOdAlajJsRjmiuzurEiOVbwmNLbmkaJQGlZB8ienBO0SlsUU3E90
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:xCygcDA3r1WlXkcvzsSGuClj3mo/tYZiD7c2L0wb+ieCvebbDveagf3aHkzQxC9JJUTZ/8kmKKhsJSN/8a7NIxdUrjqqai+5qm4zM+xEYuZaAK9bQMFLEYp60SwT0aOvCTPMh47qj9xkANyKd+osvg/9fg0Fn+IWd9o/S+E3jV2reP3fQ0wXrvOm2/AdAeh0h/76b6mVALtwEN2LkPPPmZH0QFmqerDlMCRuEWYqKzBqIedHYgqUGYWkMymenVKy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2018 05:55:35.0094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d66ebe65-4e52-453c-9d37-08d57e6fe2d3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/2018 9:34 PM, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Linux (among the others) has checks to make sure that certain features 
> aren't enabled on a certain family/model/stepping if the microcode version 
> isn't greater than or equal to a known good version.
> 
> By exposing the real microcode version, we're preventing buggy guests that
> don't check that they are running virtualized (i.e., they should trust the
> hypervisor) from disabling features that are effectively not buggy.
> 
> Suggested-by: Filippo Sironi <sironi@amazon.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Liran Alon <liran.alon@oracle.com>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v4 -> v5:
>  * microcode_version be u64 and initialized suitable, remote hte shifts
> v3 -> v4:
>  * add the shifts back
> v2 -> v3:
>  * remove the shifts
>  * add the MSR_IA32_UCODE_REV version to the "feature MSRs"

I think you lost this part from the patch series.  I don't see where you
add MSR_IA32_UCODE_REV to the msr_based_features array.

Thanks,
Tom

> v1 -> v2:
>  * add MSR_IA32_UCODE_REV to emulated_msrs
> 
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/svm.c              |  4 +---
>  arch/x86/kvm/vmx.c              |  1 +
>  arch/x86/kvm/x86.c              | 10 ++++++++--
>  4 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 938d453..df6720f 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -507,6 +507,7 @@ struct kvm_vcpu_arch {
>  	u64 smi_count;
>  	bool tpr_access_reporting;
>  	u64 ia32_xss;
> +	u64 microcode_version;
>  
>  	/*
>  	 * Paging state of the vcpu
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index f874798..312f33f 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1907,6 +1907,7 @@ static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  	u32 dummy;
>  	u32 eax = 1;
>  
> +	vcpu->arch.microcode_version = 0x01000065;
>  	svm->spec_ctrl = 0;
>  
>  	if (!init_event) {
> @@ -3962,9 +3963,6 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  
>  		msr_info->data = svm->spec_ctrl;
>  		break;
> -	case MSR_IA32_UCODE_REV:
> -		msr_info->data = 0x01000065;
> -		break;
>  	case MSR_F15H_IC_CFG: {
>  
>  		int family, model;
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 9968906..2cdbea7 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -5781,6 +5781,7 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  	vmx->rmode.vm86_active = 0;
>  	vmx->spec_ctrl = 0;
>  
> +	vcpu->arch.microcode_version = 0x100000000ULL;
>  	vmx->vcpu.arch.regs[VCPU_REGS_RDX] = get_rdx_init_val();
>  	kvm_set_cr8(vcpu, 0);
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index efc8554..52a09df 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1065,6 +1065,9 @@ static unsigned int num_msr_based_features;
>  static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
>  {
>  	switch (msr->index) {
> +	case MSR_IA32_UCODE_REV:
> +		rdmsrl(msr->index, msr->data);
> +		break;
>  	default:
>  		if (kvm_x86_ops->get_msr_feature(msr))
>  			return 1;
> @@ -2260,7 +2263,6 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  
>  	switch (msr) {
>  	case MSR_AMD64_NB_CFG:
> -	case MSR_IA32_UCODE_REV:
>  	case MSR_IA32_UCODE_WRITE:
>  	case MSR_VM_HSAVE_PA:
>  	case MSR_AMD64_PATCH_LOADER:
> @@ -2268,6 +2270,10 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_AMD64_DC_CFG:
>  		break;
>  
> +	case MSR_IA32_UCODE_REV:
> +		if (msr_info->host_initiated)
> +			vcpu->arch.microcode_version = data;
> +		break;
>  	case MSR_EFER:
>  		return set_efer(vcpu, data);
>  	case MSR_K7_HWCR:
> @@ -2563,7 +2569,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		msr_info->data = 0;
>  		break;
>  	case MSR_IA32_UCODE_REV:
> -		msr_info->data = 0x100000000ULL;
> +		msr_info->data = vcpu->arch.microcode_version;
>  		break;
>  	case MSR_MTRRcap:
>  	case 0x200 ... 0x2ff:
> 

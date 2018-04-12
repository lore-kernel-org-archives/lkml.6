Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbeDLNI6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 09:08:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751448AbeDLNI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 09:08:56 -0400
Subject: Re: [PATCH] nvmx: Check exit qualification RD/WR permission for MMIO
 accesses
To: KarimAllah Ahmed <karahmed@amazon.de>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1519841208-23349-1-git-send-email-karahmed@amazon.de>
 <1520158592-16952-1-git-send-email-karahmed@amazon.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <af854c7b-0df7-6334-346f-b25c01af1b02@redhat.com>
Date: Thu, 12 Apr 2018 15:08:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520158592-16952-1-git-send-email-karahmed@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 11:16, KarimAllah Ahmed wrote:
> Validate that a write MMIO access that follows a read MMIO access would
> have the correct access captured in the exit qualification.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> Message-Id: <1519841208-23349-1-git-send-email-karahmed@amazon.de>
> ---
>  x86/vmx_tests.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 48 insertions(+), 4 deletions(-)
> 
> diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
> index 598dd88..a72af1a 100644
> --- a/x86/vmx_tests.c
> +++ b/x86/vmx_tests.c
> @@ -7,6 +7,7 @@
>  #include "msr.h"
>  #include "processor.h"
>  #include "vm.h"
> +#include "pci.h"
>  #include "fwcfg.h"
>  #include "isr.h"
>  #include "desc.h"
> @@ -28,6 +29,8 @@ unsigned long *pml4;
>  u64 eptp;
>  void *data_page1, *data_page2;
>  
> +phys_addr_t pci_physaddr;
> +
>  void *pml_log;
>  #define PML_INDEX 512
>  
> @@ -1041,6 +1044,9 @@ static int apic_version;
>  
>  static int ept_init_common(bool have_ad)
>  {
> +	int ret;
> +	struct pci_dev pcidev;
> +
>  	if (setup_ept(have_ad))
>  		return VMX_TEST_EXIT;
>  	data_page1 = alloc_page();
> @@ -1053,6 +1059,13 @@ static int ept_init_common(bool have_ad)
>  			EPT_RA | EPT_WA | EPT_EA);
>  
>  	apic_version = apic_read(APIC_LVR);
> +
> +	ret = pci_find_dev(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_TEST);
> +	if (ret != PCIDEVADDR_INVALID) {
> +		pci_dev_init(&pcidev, ret);
> +		pci_physaddr = pcidev.resource[PCI_TESTDEV_BAR_MEM];
> +	}
> +
>  	return VMX_TEST_START;
>  }
>  
> @@ -1101,6 +1114,16 @@ t1:
>  	vmcall();
>  	*((u32 *)data_page1) = MAGIC_VAL_2;
>  	report("EPT violation - paging structure", vmx_get_test_stage() == 5);
> +
> +	// MMIO Read/Write
> +	vmx_set_test_stage(5);
> +	vmcall();
> +
> +	*(u32 volatile *)pci_physaddr;
> +	report("MMIO EPT violation - read", vmx_get_test_stage() == 6);
> +
> +	*(u32 volatile *)pci_physaddr = MAGIC_VAL_1;
> +	report("MMIO EPT violation - write", vmx_get_test_stage() == 7);
>  }
>  
>  static void ept_main()
> @@ -1108,12 +1131,12 @@ static void ept_main()
>  	ept_common();
>  
>  	// Test EPT access to L1 MMIO
> -	vmx_set_test_stage(6);
> +	vmx_set_test_stage(7);
>  	report("EPT - MMIO access", *((u32 *)0xfee00030UL) == apic_version);
>  
>  	// Test invalid operand for INVEPT
>  	vmcall();
> -	report("EPT - unsupported INVEPT", vmx_get_test_stage() == 7);
> +	report("EPT - unsupported INVEPT", vmx_get_test_stage() == 8);
>  }
>  
>  bool invept_test(int type, u64 eptp)
> @@ -1187,7 +1210,7 @@ static int ept_exit_handler_common(bool have_ad)
>  	ulong reason;
>  	u32 insn_len;
>  	u32 exit_qual;
> -	static unsigned long data_page1_pte, data_page1_pte_pte;
> +	static unsigned long data_page1_pte, data_page1_pte_pte, memaddr_pte;
>  
>  	guest_rip = vmcs_read(GUEST_RIP);
>  	guest_cr3 = vmcs_read(GUEST_CR3);
> @@ -1249,7 +1272,12 @@ static int ept_exit_handler_common(bool have_ad)
>  				data_page1_pte_pte & ~EPT_PRESENT);
>  			ept_sync(INVEPT_SINGLE, eptp);
>  			break;
> -		case 6:
> +		case 5:
> +			install_ept(pml4, (unsigned long)pci_physaddr,
> +				(unsigned long)pci_physaddr, 0);
> +			ept_sync(INVEPT_SINGLE, eptp);
> +			break;
> +		case 7:
>  			if (!invept_test(0, eptp))
>  				vmx_inc_test_stage();
>  			break;
> @@ -1305,6 +1333,22 @@ static int ept_exit_handler_common(bool have_ad)
>  				data_page1_pte_pte | (EPT_PRESENT));
>  			ept_sync(INVEPT_SINGLE, eptp);
>  			break;
> +		case 5:
> +			if (exit_qual & EPT_VLT_RD)
> +				vmx_inc_test_stage();
> +			TEST_ASSERT(get_ept_pte(pml4, (unsigned long)pci_physaddr,
> +						1, &memaddr_pte));
> +			set_ept_pte(pml4, memaddr_pte, 1, memaddr_pte | EPT_RA);
> +			ept_sync(INVEPT_SINGLE, eptp);
> +			break;
> +		case 6:
> +			if (exit_qual & EPT_VLT_WR)
> +				vmx_inc_test_stage();
> +			TEST_ASSERT(get_ept_pte(pml4, (unsigned long)pci_physaddr,
> +						1, &memaddr_pte));
> +			set_ept_pte(pml4, memaddr_pte, 1, memaddr_pte | EPT_RA | EPT_WA);
> +			ept_sync(INVEPT_SINGLE, eptp);
> +			break;
>  		default:
>  			// Should not reach here
>  			report("ERROR : unexpected stage, %d", false,
> 

Pushed, thanks!

Paolo

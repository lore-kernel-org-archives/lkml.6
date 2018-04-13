Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeDMBip (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 21:38:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:40487 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751891AbeDMBin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 21:38:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,444,1517904000";
   d="scan'208";a="46538238"
Date: Fri, 13 Apr 2018 09:38:24 +0800
From: kbuild test robot <lkp@intel.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kbuild-all@01.org, kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] x86/hyper-v: move struct hv_flush_pcpu{,ex}
 definitions to common header
Message-ID: <201804130744.OmQesC9s%fengguang.wu@intel.com>
References: <20180411172126.16355-2-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411172126.16355-2-vkuznets@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitaly,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kvm/linux-next]
[also build test WARNING on v4.16 next-20180412]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Vitaly-Kuznetsov/KVM-x86-hyperv-PV-TLB-flush-for-Windows-guests/20180413-025205
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git linux-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> arch/x86/hyperv/mmu.c:107:22: sparse: incorrect type in initializer (different address spaces) @@    expected void const [noderef] <asn:3>*__vpp_verify @@    got struct hv_void const [noderef] <asn:3>*__vpp_verify @@
   arch/x86/hyperv/mmu.c:107:22:    expected void const [noderef] <asn:3>*__vpp_verify
   arch/x86/hyperv/mmu.c:107:22:    got struct hv_tlb_flush [noderef] <asn:3>**<noident>
>> arch/x86/hyperv/mmu.c:107:20: sparse: incorrect type in assignment (different address spaces) @@    expected struct hv_tlb_flush **flush_pcpu @@    got struct hv_tlb_flustruct hv_tlb_flush **flush_pcpu @@
   arch/x86/hyperv/mmu.c:107:20:    expected struct hv_tlb_flush **flush_pcpu
   arch/x86/hyperv/mmu.c:107:20:    got struct hv_tlb_flush [noderef] <asn:3>**<noident>
>> arch/x86/hyperv/mmu.c:194:22: sparse: incorrect type in initializer (different address spaces) @@    expected void const [noderef] <asn:3>*__vpp_verify @@    got struct hv_tlbvoid const [noderef] <asn:3>*__vpp_verify @@
   arch/x86/hyperv/mmu.c:194:22:    expected void const [noderef] <asn:3>*__vpp_verify
   arch/x86/hyperv/mmu.c:194:22:    got struct hv_tlb_flush_ex [noderef] <asn:3>**<noident>
>> arch/x86/hyperv/mmu.c:194:20: sparse: incorrect type in assignment (different address spaces) @@    expected struct hv_tlb_flush_ex **flush_pcpu @@    got struct hv_tlb_flustruct hv_tlb_flush_ex **flush_pcpu @@
   arch/x86/hyperv/mmu.c:194:20:    expected struct hv_tlb_flush_ex **flush_pcpu
   arch/x86/hyperv/mmu.c:194:20:    got struct hv_tlb_flush_ex [noderef] <asn:3>**<noident>
>> arch/x86/hyperv/mmu.c:286:28: sparse: incorrect type in assignment (different address spaces) @@    expected struct hv_tlb_flush [noderef] <asn:3>**static [toplevel] pcpu_flush @@    got h [noderef] <asn:3>**static [toplevel] pcpu_flush @@
   arch/x86/hyperv/mmu.c:286:28:    expected struct hv_tlb_flush [noderef] <asn:3>**static [toplevel] pcpu_flush
   arch/x86/hyperv/mmu.c:286:28:    got struct hv_tlb_flush *[noderef] <asn:3>*<noident>
>> arch/x86/hyperv/mmu.c:288:31: sparse: incorrect type in assignment (different address spaces) @@    expected struct hv_tlb_flush_ex [noderef] <asn:3>**static [toplevel] pcpu_flush_ex @@    got h_ex [noderef] <asn:3>**static [toplevel] pcpu_flush_ex @@
   arch/x86/hyperv/mmu.c:288:31:    expected struct hv_tlb_flush_ex [noderef] <asn:3>**static [toplevel] pcpu_flush_ex
   arch/x86/hyperv/mmu.c:288:31:    got struct hv_tlb_flush_ex *[noderef] <asn:3>*<noident>

vim +107 arch/x86/hyperv/mmu.c

628f54cc6 Vitaly Kuznetsov       2017-08-02   87  
2ffd9e33c Vitaly Kuznetsov       2017-08-02   88  static void hyperv_flush_tlb_others(const struct cpumask *cpus,
2ffd9e33c Vitaly Kuznetsov       2017-08-02   89  				    const struct flush_tlb_info *info)
2ffd9e33c Vitaly Kuznetsov       2017-08-02   90  {
2ffd9e33c Vitaly Kuznetsov       2017-08-02   91  	int cpu, vcpu, gva_n, max_gvas;
84d437db6 Vitaly Kuznetsov       2018-04-11   92  	struct hv_tlb_flush **flush_pcpu;
84d437db6 Vitaly Kuznetsov       2018-04-11   93  	struct hv_tlb_flush *flush;
2ffd9e33c Vitaly Kuznetsov       2017-08-02   94  	u64 status = U64_MAX;
2ffd9e33c Vitaly Kuznetsov       2017-08-02   95  	unsigned long flags;
2ffd9e33c Vitaly Kuznetsov       2017-08-02   96  
773b79f7a Vitaly Kuznetsov       2017-08-02   97  	trace_hyperv_mmu_flush_tlb_others(cpus, info);
773b79f7a Vitaly Kuznetsov       2017-08-02   98  
2ffd9e33c Vitaly Kuznetsov       2017-08-02   99  	if (!pcpu_flush || !hv_hypercall_pg)
2ffd9e33c Vitaly Kuznetsov       2017-08-02  100  		goto do_native;
2ffd9e33c Vitaly Kuznetsov       2017-08-02  101  
2ffd9e33c Vitaly Kuznetsov       2017-08-02  102  	if (cpumask_empty(cpus))
2ffd9e33c Vitaly Kuznetsov       2017-08-02  103  		return;
2ffd9e33c Vitaly Kuznetsov       2017-08-02  104  
2ffd9e33c Vitaly Kuznetsov       2017-08-02  105  	local_irq_save(flags);
2ffd9e33c Vitaly Kuznetsov       2017-08-02  106  
60d73a7c9 Vitaly Kuznetsov       2017-10-05 @107  	flush_pcpu = this_cpu_ptr(pcpu_flush);
60d73a7c9 Vitaly Kuznetsov       2017-10-05  108  
60d73a7c9 Vitaly Kuznetsov       2017-10-05  109  	if (unlikely(!*flush_pcpu))
60d73a7c9 Vitaly Kuznetsov       2017-10-05  110  		*flush_pcpu = page_address(alloc_page(GFP_ATOMIC));
60d73a7c9 Vitaly Kuznetsov       2017-10-05  111  
60d73a7c9 Vitaly Kuznetsov       2017-10-05  112  	flush = *flush_pcpu;
60d73a7c9 Vitaly Kuznetsov       2017-10-05  113  
60d73a7c9 Vitaly Kuznetsov       2017-10-05  114  	if (unlikely(!flush)) {
60d73a7c9 Vitaly Kuznetsov       2017-10-05  115  		local_irq_restore(flags);
60d73a7c9 Vitaly Kuznetsov       2017-10-05  116  		goto do_native;
60d73a7c9 Vitaly Kuznetsov       2017-10-05  117  	}
2ffd9e33c Vitaly Kuznetsov       2017-08-02  118  
2ffd9e33c Vitaly Kuznetsov       2017-08-02  119  	if (info->mm) {
617ab45c9 Vitaly Kuznetsov       2018-01-24  120  		/*
617ab45c9 Vitaly Kuznetsov       2018-01-24  121  		 * AddressSpace argument must match the CR3 with PCID bits
617ab45c9 Vitaly Kuznetsov       2018-01-24  122  		 * stripped out.
617ab45c9 Vitaly Kuznetsov       2018-01-24  123  		 */
2ffd9e33c Vitaly Kuznetsov       2017-08-02  124  		flush->address_space = virt_to_phys(info->mm->pgd);
617ab45c9 Vitaly Kuznetsov       2018-01-24  125  		flush->address_space &= CR3_ADDR_MASK;
2ffd9e33c Vitaly Kuznetsov       2017-08-02  126  		flush->flags = 0;
2ffd9e33c Vitaly Kuznetsov       2017-08-02  127  	} else {
2ffd9e33c Vitaly Kuznetsov       2017-08-02  128  		flush->address_space = 0;
2ffd9e33c Vitaly Kuznetsov       2017-08-02  129  		flush->flags = HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES;
2ffd9e33c Vitaly Kuznetsov       2017-08-02  130  	}
2ffd9e33c Vitaly Kuznetsov       2017-08-02  131  
2ffd9e33c Vitaly Kuznetsov       2017-08-02  132  	flush->processor_mask = 0;
2ffd9e33c Vitaly Kuznetsov       2017-08-02  133  	if (cpumask_equal(cpus, cpu_present_mask)) {
2ffd9e33c Vitaly Kuznetsov       2017-08-02  134  		flush->flags |= HV_FLUSH_ALL_PROCESSORS;
2ffd9e33c Vitaly Kuznetsov       2017-08-02  135  	} else {
2ffd9e33c Vitaly Kuznetsov       2017-08-02  136  		for_each_cpu(cpu, cpus) {
2ffd9e33c Vitaly Kuznetsov       2017-08-02  137  			vcpu = hv_cpu_number_to_vp_number(cpu);
2ffd9e33c Vitaly Kuznetsov       2017-08-02  138  			if (vcpu >= 64)
2ffd9e33c Vitaly Kuznetsov       2017-08-02  139  				goto do_native;
2ffd9e33c Vitaly Kuznetsov       2017-08-02  140  
2ffd9e33c Vitaly Kuznetsov       2017-08-02  141  			__set_bit(vcpu, (unsigned long *)
2ffd9e33c Vitaly Kuznetsov       2017-08-02  142  				  &flush->processor_mask);
2ffd9e33c Vitaly Kuznetsov       2017-08-02  143  		}
2ffd9e33c Vitaly Kuznetsov       2017-08-02  144  	}
2ffd9e33c Vitaly Kuznetsov       2017-08-02  145  
2ffd9e33c Vitaly Kuznetsov       2017-08-02  146  	/*
2ffd9e33c Vitaly Kuznetsov       2017-08-02  147  	 * We can flush not more than max_gvas with one hypercall. Flush the
2ffd9e33c Vitaly Kuznetsov       2017-08-02  148  	 * whole address space if we were asked to do more.
2ffd9e33c Vitaly Kuznetsov       2017-08-02  149  	 */
2ffd9e33c Vitaly Kuznetsov       2017-08-02  150  	max_gvas = (PAGE_SIZE - sizeof(*flush)) / sizeof(flush->gva_list[0]);
2ffd9e33c Vitaly Kuznetsov       2017-08-02  151  
2ffd9e33c Vitaly Kuznetsov       2017-08-02  152  	if (info->end == TLB_FLUSH_ALL) {
2ffd9e33c Vitaly Kuznetsov       2017-08-02  153  		flush->flags |= HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY;
2ffd9e33c Vitaly Kuznetsov       2017-08-02  154  		status = hv_do_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE,
2ffd9e33c Vitaly Kuznetsov       2017-08-02  155  					 flush, NULL);
2ffd9e33c Vitaly Kuznetsov       2017-08-02  156  	} else if (info->end &&
2ffd9e33c Vitaly Kuznetsov       2017-08-02  157  		   ((info->end - info->start)/HV_TLB_FLUSH_UNIT) > max_gvas) {
2ffd9e33c Vitaly Kuznetsov       2017-08-02  158  		status = hv_do_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE,
2ffd9e33c Vitaly Kuznetsov       2017-08-02  159  					 flush, NULL);
2ffd9e33c Vitaly Kuznetsov       2017-08-02  160  	} else {
2ffd9e33c Vitaly Kuznetsov       2017-08-02  161  		gva_n = fill_gva_list(flush->gva_list, 0,
2ffd9e33c Vitaly Kuznetsov       2017-08-02  162  				      info->start, info->end);
2ffd9e33c Vitaly Kuznetsov       2017-08-02  163  		status = hv_do_rep_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST,
2ffd9e33c Vitaly Kuznetsov       2017-08-02  164  					     gva_n, 0, flush, NULL);
2ffd9e33c Vitaly Kuznetsov       2017-08-02  165  	}
2ffd9e33c Vitaly Kuznetsov       2017-08-02  166  
2ffd9e33c Vitaly Kuznetsov       2017-08-02  167  	local_irq_restore(flags);
2ffd9e33c Vitaly Kuznetsov       2017-08-02  168  
2ffd9e33c Vitaly Kuznetsov       2017-08-02  169  	if (!(status & HV_HYPERCALL_RESULT_MASK))
2ffd9e33c Vitaly Kuznetsov       2017-08-02  170  		return;
2ffd9e33c Vitaly Kuznetsov       2017-08-02  171  do_native:
2ffd9e33c Vitaly Kuznetsov       2017-08-02  172  	native_flush_tlb_others(cpus, info);
2ffd9e33c Vitaly Kuznetsov       2017-08-02  173  }
2ffd9e33c Vitaly Kuznetsov       2017-08-02  174  
628f54cc6 Vitaly Kuznetsov       2017-08-02  175  static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
628f54cc6 Vitaly Kuznetsov       2017-08-02  176  				       const struct flush_tlb_info *info)
628f54cc6 Vitaly Kuznetsov       2017-08-02  177  {
628f54cc6 Vitaly Kuznetsov       2017-08-02  178  	int nr_bank = 0, max_gvas, gva_n;
84d437db6 Vitaly Kuznetsov       2018-04-11  179  	struct hv_tlb_flush_ex **flush_pcpu;
84d437db6 Vitaly Kuznetsov       2018-04-11  180  	struct hv_tlb_flush_ex *flush;
628f54cc6 Vitaly Kuznetsov       2017-08-02  181  	u64 status = U64_MAX;
628f54cc6 Vitaly Kuznetsov       2017-08-02  182  	unsigned long flags;
628f54cc6 Vitaly Kuznetsov       2017-08-02  183  
773b79f7a Vitaly Kuznetsov       2017-08-02  184  	trace_hyperv_mmu_flush_tlb_others(cpus, info);
773b79f7a Vitaly Kuznetsov       2017-08-02  185  
628f54cc6 Vitaly Kuznetsov       2017-08-02  186  	if (!pcpu_flush_ex || !hv_hypercall_pg)
628f54cc6 Vitaly Kuznetsov       2017-08-02  187  		goto do_native;
628f54cc6 Vitaly Kuznetsov       2017-08-02  188  
628f54cc6 Vitaly Kuznetsov       2017-08-02  189  	if (cpumask_empty(cpus))
628f54cc6 Vitaly Kuznetsov       2017-08-02  190  		return;
628f54cc6 Vitaly Kuznetsov       2017-08-02  191  
628f54cc6 Vitaly Kuznetsov       2017-08-02  192  	local_irq_save(flags);
628f54cc6 Vitaly Kuznetsov       2017-08-02  193  
60d73a7c9 Vitaly Kuznetsov       2017-10-05 @194  	flush_pcpu = this_cpu_ptr(pcpu_flush_ex);
60d73a7c9 Vitaly Kuznetsov       2017-10-05  195  
60d73a7c9 Vitaly Kuznetsov       2017-10-05  196  	if (unlikely(!*flush_pcpu))
60d73a7c9 Vitaly Kuznetsov       2017-10-05  197  		*flush_pcpu = page_address(alloc_page(GFP_ATOMIC));
60d73a7c9 Vitaly Kuznetsov       2017-10-05  198  
60d73a7c9 Vitaly Kuznetsov       2017-10-05  199  	flush = *flush_pcpu;
60d73a7c9 Vitaly Kuznetsov       2017-10-05  200  
60d73a7c9 Vitaly Kuznetsov       2017-10-05  201  	if (unlikely(!flush)) {
60d73a7c9 Vitaly Kuznetsov       2017-10-05  202  		local_irq_restore(flags);
60d73a7c9 Vitaly Kuznetsov       2017-10-05  203  		goto do_native;
60d73a7c9 Vitaly Kuznetsov       2017-10-05  204  	}
628f54cc6 Vitaly Kuznetsov       2017-08-02  205  
628f54cc6 Vitaly Kuznetsov       2017-08-02  206  	if (info->mm) {
617ab45c9 Vitaly Kuznetsov       2018-01-24  207  		/*
617ab45c9 Vitaly Kuznetsov       2018-01-24  208  		 * AddressSpace argument must match the CR3 with PCID bits
617ab45c9 Vitaly Kuznetsov       2018-01-24  209  		 * stripped out.
617ab45c9 Vitaly Kuznetsov       2018-01-24  210  		 */
628f54cc6 Vitaly Kuznetsov       2017-08-02  211  		flush->address_space = virt_to_phys(info->mm->pgd);
617ab45c9 Vitaly Kuznetsov       2018-01-24  212  		flush->address_space &= CR3_ADDR_MASK;
628f54cc6 Vitaly Kuznetsov       2017-08-02  213  		flush->flags = 0;
628f54cc6 Vitaly Kuznetsov       2017-08-02  214  	} else {
628f54cc6 Vitaly Kuznetsov       2017-08-02  215  		flush->address_space = 0;
628f54cc6 Vitaly Kuznetsov       2017-08-02  216  		flush->flags = HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES;
628f54cc6 Vitaly Kuznetsov       2017-08-02  217  	}
628f54cc6 Vitaly Kuznetsov       2017-08-02  218  
628f54cc6 Vitaly Kuznetsov       2017-08-02  219  	flush->hv_vp_set.valid_bank_mask = 0;
628f54cc6 Vitaly Kuznetsov       2017-08-02  220  
628f54cc6 Vitaly Kuznetsov       2017-08-02  221  	if (!cpumask_equal(cpus, cpu_present_mask)) {
628f54cc6 Vitaly Kuznetsov       2017-08-02  222  		flush->hv_vp_set.format = HV_GENERIC_SET_SPARCE_4K;
628f54cc6 Vitaly Kuznetsov       2017-08-02  223  		nr_bank = cpumask_to_vp_set(flush, cpus);
628f54cc6 Vitaly Kuznetsov       2017-08-02  224  	}
628f54cc6 Vitaly Kuznetsov       2017-08-02  225  
628f54cc6 Vitaly Kuznetsov       2017-08-02  226  	if (!nr_bank) {
628f54cc6 Vitaly Kuznetsov       2017-08-02  227  		flush->hv_vp_set.format = HV_GENERIC_SET_ALL;
628f54cc6 Vitaly Kuznetsov       2017-08-02  228  		flush->flags |= HV_FLUSH_ALL_PROCESSORS;
628f54cc6 Vitaly Kuznetsov       2017-08-02  229  	}
628f54cc6 Vitaly Kuznetsov       2017-08-02  230  
628f54cc6 Vitaly Kuznetsov       2017-08-02  231  	/*
628f54cc6 Vitaly Kuznetsov       2017-08-02  232  	 * We can flush not more than max_gvas with one hypercall. Flush the
628f54cc6 Vitaly Kuznetsov       2017-08-02  233  	 * whole address space if we were asked to do more.
628f54cc6 Vitaly Kuznetsov       2017-08-02  234  	 */
628f54cc6 Vitaly Kuznetsov       2017-08-02  235  	max_gvas =
628f54cc6 Vitaly Kuznetsov       2017-08-02  236  		(PAGE_SIZE - sizeof(*flush) - nr_bank *
628f54cc6 Vitaly Kuznetsov       2017-08-02  237  		 sizeof(flush->hv_vp_set.bank_contents[0])) /
628f54cc6 Vitaly Kuznetsov       2017-08-02  238  		sizeof(flush->gva_list[0]);
628f54cc6 Vitaly Kuznetsov       2017-08-02  239  
628f54cc6 Vitaly Kuznetsov       2017-08-02  240  	if (info->end == TLB_FLUSH_ALL) {
628f54cc6 Vitaly Kuznetsov       2017-08-02  241  		flush->flags |= HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY;
628f54cc6 Vitaly Kuznetsov       2017-08-02  242  		status = hv_do_rep_hypercall(
628f54cc6 Vitaly Kuznetsov       2017-08-02  243  			HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX,
ab7ff471a Marcelo Henrique Cerri 2017-10-05  244  			0, nr_bank, flush, NULL);
628f54cc6 Vitaly Kuznetsov       2017-08-02  245  	} else if (info->end &&
628f54cc6 Vitaly Kuznetsov       2017-08-02  246  		   ((info->end - info->start)/HV_TLB_FLUSH_UNIT) > max_gvas) {
628f54cc6 Vitaly Kuznetsov       2017-08-02  247  		status = hv_do_rep_hypercall(
628f54cc6 Vitaly Kuznetsov       2017-08-02  248  			HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX,
ab7ff471a Marcelo Henrique Cerri 2017-10-05  249  			0, nr_bank, flush, NULL);
628f54cc6 Vitaly Kuznetsov       2017-08-02  250  	} else {
628f54cc6 Vitaly Kuznetsov       2017-08-02  251  		gva_n = fill_gva_list(flush->gva_list, nr_bank,
628f54cc6 Vitaly Kuznetsov       2017-08-02  252  				      info->start, info->end);
628f54cc6 Vitaly Kuznetsov       2017-08-02  253  		status = hv_do_rep_hypercall(
628f54cc6 Vitaly Kuznetsov       2017-08-02  254  			HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX,
ab7ff471a Marcelo Henrique Cerri 2017-10-05  255  			gva_n, nr_bank, flush, NULL);
628f54cc6 Vitaly Kuznetsov       2017-08-02  256  	}
628f54cc6 Vitaly Kuznetsov       2017-08-02  257  
628f54cc6 Vitaly Kuznetsov       2017-08-02  258  	local_irq_restore(flags);
628f54cc6 Vitaly Kuznetsov       2017-08-02  259  
628f54cc6 Vitaly Kuznetsov       2017-08-02  260  	if (!(status & HV_HYPERCALL_RESULT_MASK))
628f54cc6 Vitaly Kuznetsov       2017-08-02  261  		return;
628f54cc6 Vitaly Kuznetsov       2017-08-02  262  do_native:
628f54cc6 Vitaly Kuznetsov       2017-08-02  263  	native_flush_tlb_others(cpus, info);
628f54cc6 Vitaly Kuznetsov       2017-08-02  264  }
628f54cc6 Vitaly Kuznetsov       2017-08-02  265  
2ffd9e33c Vitaly Kuznetsov       2017-08-02  266  void hyperv_setup_mmu_ops(void)
2ffd9e33c Vitaly Kuznetsov       2017-08-02  267  {
628f54cc6 Vitaly Kuznetsov       2017-08-02  268  	if (!(ms_hyperv.hints & HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED))
628f54cc6 Vitaly Kuznetsov       2017-08-02  269  		return;
628f54cc6 Vitaly Kuznetsov       2017-08-02  270  
628f54cc6 Vitaly Kuznetsov       2017-08-02  271  	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED)) {
2ffd9e33c Vitaly Kuznetsov       2017-08-02  272  		pr_info("Using hypercall for remote TLB flush\n");
2ffd9e33c Vitaly Kuznetsov       2017-08-02  273  		pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others;
628f54cc6 Vitaly Kuznetsov       2017-08-02  274  	} else {
628f54cc6 Vitaly Kuznetsov       2017-08-02  275  		pr_info("Using ext hypercall for remote TLB flush\n");
628f54cc6 Vitaly Kuznetsov       2017-08-02  276  		pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others_ex;
2ffd9e33c Vitaly Kuznetsov       2017-08-02  277  	}
2ffd9e33c Vitaly Kuznetsov       2017-08-02  278  }
2ffd9e33c Vitaly Kuznetsov       2017-08-02  279  
2ffd9e33c Vitaly Kuznetsov       2017-08-02  280  void hyper_alloc_mmu(void)
2ffd9e33c Vitaly Kuznetsov       2017-08-02  281  {
628f54cc6 Vitaly Kuznetsov       2017-08-02  282  	if (!(ms_hyperv.hints & HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED))
628f54cc6 Vitaly Kuznetsov       2017-08-02  283  		return;
628f54cc6 Vitaly Kuznetsov       2017-08-02  284  
628f54cc6 Vitaly Kuznetsov       2017-08-02  285  	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
84d437db6 Vitaly Kuznetsov       2018-04-11 @286  		pcpu_flush = alloc_percpu(struct hv_tlb_flush *);
628f54cc6 Vitaly Kuznetsov       2017-08-02  287  	else
84d437db6 Vitaly Kuznetsov       2018-04-11 @288  		pcpu_flush_ex = alloc_percpu(struct hv_tlb_flush_ex *);

:::::: The code at line 107 was first introduced by commit
:::::: 60d73a7c96601434dfdb56d5b9167ff3b850d8d7 x86/hyperv: Don't use percpu areas for pcpu_flush/pcpu_flush_ex structures

:::::: TO: Vitaly Kuznetsov <vkuznets@redhat.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

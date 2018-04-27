Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-87399-1524828134-2-17498175366890738637
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524828133; b=IIcVtCfMXgiCxjfv7nCkM6qGDuba1CTxGEnzmD/8neMGMhvC4A
    afDEdVQlLjCXoBSzJP4lbozGboyFToMc3Abc/eeBb0mSAp4hVBlkDXLC64TdRO6W
    qa9WJOOAk4ljhFyTJ+9S3uR/blf1outaeHi7nPeCKO3zdGMmP6o8bXCPYrz22PRv
    95iVLvSPCphOEw8zDU73WfvKEI7h+/NHuV6mVAGigJ7u0dPmeZNZKmfi0GiKon8P
    2L+tf/UuimegKbg6wRwu/YGDPAVxeqj8E0VckCr5exGTrE9p34kOVMR582p6WiJl
    7snaqLnfYpN7Wk2MbtmnkmZRzvKa+x11fpXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524828133; bh=Vhb78
    mH1rYV9ahP2BuluI6o+oYBDmcF7v8uDoTwSD7c=; b=ezs8ZOxvl8N5mnZyh14AG
    sLCnANPlvHWtTsSrSig1QxaglYgXdmNEKt9ZMV/JSGrZWDZzUO+sAR6B6b/aoPiV
    lqafPYkJL+jr0axL8DVsNjFPNbNM3iPHYic2pNkqU5DGBrsbKJmvL8bcPV42neMB
    ufhb1RxAuAwtrl4/fwE6axDPoJuJaBSIM3O1DFDZ+ajPTGsNIJ9tflJtORiEZvPY
    RBymmbP20tHooUA8X/tYAeTQsqxmIkqUmT4xaXIRKqF96a3AUPXMhCqx8veAkLdT
    AaQ2du6a6VqPzb6mD0LFk1pUsPId41MVRNOQOEnD8FJpOc94zGsMAQZqQ3cdmnmz
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfORjA2sxANWgszr5rtrzbgndH1JutH3hG1v2DhUGXM5X0KBxYWW0VIGXFfhdUq/PyGz9Iej3c+ZcFUU1ZA3cPJ468CdP5m1cDwiMQUfaFLXV4dR5rG1R
    MSlLHYExaYErUFaPbRvUjnLgV1jfFsefkonk7DuBF5aKTEYYScJa2NLokwJ4ffMu4q7zLnw3sbqbxbUd6T+nljjXRi1nA5KTR9f9+WfpaJtDmMb3l8J1Er8m
    /3ZCv2da9uJFNfH5Yu8EWQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=NEAV23lmAAAA:8 a=i3X5FwGiAAAA:8
    a=DDOyTI_5AAAA:8 a=3dP8h4rEvbteZLHVfecA:9 a=w43Br9QpIWmhDkUV:21
    a=c3XUmtPQbJmsXplA:21 a=CjuIK1q_8ugA:10 a=mmqRlSCDY2ywfjPLJ4af:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,335,1520924400"; d="scan'208";a="35085652"
Date: Fri, 27 Apr 2018 19:21:06 +0800
From: kbuild test robot <lkp@intel.com>
To: kys@linuxonhyperv.com
Subject: Re: [PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments
Message-ID: <201804271906.Qc2E5PIb%fengguang.wu@intel.com>
References: <20180425181250.8740-2-kys@linuxonhyperv.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180425181250.8740-2-kys@linuxonhyperv.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: olaf@aepfle.de, sthemmin@microsoft.com, gregkh@linuxfoundation.org,
 jasowang@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 Michael.H.Kelley@microsoft.com, kbuild-all@01.org, hpa@zytor.com,
 apw@canonical.com, devel@linuxdriverproject.org, tglx@linutronix.de,
 vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Srinivasan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on v4.17-rc2]
[also build test WARNING on next-20180426]
[cannot apply to tip/x86/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/kys-linuxonhyperv-com/X86-Hyper-V-APIC-enlightenments/20180427-114416
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> arch/x86/hyperv/hv_init.c:105:30: sparse: incorrect type in initializer (different address spaces) @@    expected void const [noderef] <asn:3>*__vpp_verify @@    got const [noderef] <asn:3>*__vpp_verify @@
   arch/x86/hyperv/hv_init.c:105:30:    expected void const [noderef] <asn:3>*__vpp_verify
   arch/x86/hyperv/hv_init.c:105:30:    got void [noderef] <asn:3>**<noident>
   arch/x86/hyperv/hv_init.c:229:30: sparse: incorrect type in initializer (different address spaces) @@    expected void const [noderef] <asn:3>*__vpp_verify @@    got const [noderef] <asn:3>*__vpp_verify @@
   arch/x86/hyperv/hv_init.c:229:30:    expected void const [noderef] <asn:3>*__vpp_verify
   arch/x86/hyperv/hv_init.c:229:30:    got void [noderef] <asn:3>**<noident>
>> arch/x86/hyperv/hv_init.c:275:31: sparse: incorrect type in assignment (different address spaces) @@    expected void [noderef] <asn:3>**extern [addressable] [toplevel] hyperv_pcpu_input_arg @@    got addressable] [toplevel] hyperv_pcpu_input_arg @@
   arch/x86/hyperv/hv_init.c:275:31:    expected void [noderef] <asn:3>**extern [addressable] [toplevel] hyperv_pcpu_input_arg
   arch/x86/hyperv/hv_init.c:275:31:    got void *[noderef] <asn:3>*<noident>
   arch/x86/include/asm/paravirt.h:150:9: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
--
>> arch/x86/hyperv/hv_apic.c:118:41: sparse: incorrect type in initializer (different address spaces) @@    expected void const [noderef] <asn:3>*__vpp_verify @@    got const [noderef] <asn:3>*__vpp_verify @@
   arch/x86/hyperv/hv_apic.c:118:41:    expected void const [noderef] <asn:3>*__vpp_verify
   arch/x86/hyperv/hv_apic.c:118:41:    got void [noderef] <asn:3>**<noident>

vim +105 arch/x86/hyperv/hv_init.c

    98	
    99	static int hv_cpu_init(unsigned int cpu)
   100	{
   101		u64 msr_vp_index;
   102		struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
   103		void **input_arg;
   104	
 > 105		input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
   106		*input_arg = page_address(alloc_page(GFP_ATOMIC));
   107	
   108		hv_get_vp_index(msr_vp_index);
   109	
   110		hv_vp_index[smp_processor_id()] = msr_vp_index;
   111	
   112		if (msr_vp_index > hv_max_vp_index)
   113			hv_max_vp_index = msr_vp_index;
   114	
   115		if (!hv_vp_assist_page)
   116			return 0;
   117	
   118		if (!*hvp)
   119			*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
   120	
   121		if (*hvp) {
   122			u64 val;
   123	
   124			val = vmalloc_to_pfn(*hvp);
   125			val = (val << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) |
   126				HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
   127	
   128			wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
   129		}
   130	
   131		return 0;
   132	}
   133	
   134	static void (*hv_reenlightenment_cb)(void);
   135	
   136	static void hv_reenlightenment_notify(struct work_struct *dummy)
   137	{
   138		struct hv_tsc_emulation_status emu_status;
   139	
   140		rdmsrl(HV_X64_MSR_TSC_EMULATION_STATUS, *(u64 *)&emu_status);
   141	
   142		/* Don't issue the callback if TSC accesses are not emulated */
   143		if (hv_reenlightenment_cb && emu_status.inprogress)
   144			hv_reenlightenment_cb();
   145	}
   146	static DECLARE_DELAYED_WORK(hv_reenlightenment_work, hv_reenlightenment_notify);
   147	
   148	void hyperv_stop_tsc_emulation(void)
   149	{
   150		u64 freq;
   151		struct hv_tsc_emulation_status emu_status;
   152	
   153		rdmsrl(HV_X64_MSR_TSC_EMULATION_STATUS, *(u64 *)&emu_status);
   154		emu_status.inprogress = 0;
   155		wrmsrl(HV_X64_MSR_TSC_EMULATION_STATUS, *(u64 *)&emu_status);
   156	
   157		rdmsrl(HV_X64_MSR_TSC_FREQUENCY, freq);
   158		tsc_khz = div64_u64(freq, 1000);
   159	}
   160	EXPORT_SYMBOL_GPL(hyperv_stop_tsc_emulation);
   161	
   162	static inline bool hv_reenlightenment_available(void)
   163	{
   164		/*
   165		 * Check for required features and priviliges to make TSC frequency
   166		 * change notifications work.
   167		 */
   168		return ms_hyperv.features & HV_X64_ACCESS_FREQUENCY_MSRS &&
   169			ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE &&
   170			ms_hyperv.features & HV_X64_ACCESS_REENLIGHTENMENT;
   171	}
   172	
   173	__visible void __irq_entry hyperv_reenlightenment_intr(struct pt_regs *regs)
   174	{
   175		entering_ack_irq();
   176	
   177		inc_irq_stat(irq_hv_reenlightenment_count);
   178	
   179		schedule_delayed_work(&hv_reenlightenment_work, HZ/10);
   180	
   181		exiting_irq();
   182	}
   183	
   184	void set_hv_tscchange_cb(void (*cb)(void))
   185	{
   186		struct hv_reenlightenment_control re_ctrl = {
   187			.vector = HYPERV_REENLIGHTENMENT_VECTOR,
   188			.enabled = 1,
   189			.target_vp = hv_vp_index[smp_processor_id()]
   190		};
   191		struct hv_tsc_emulation_control emu_ctrl = {.enabled = 1};
   192	
   193		if (!hv_reenlightenment_available()) {
   194			pr_warn("Hyper-V: reenlightenment support is unavailable\n");
   195			return;
   196		}
   197	
   198		hv_reenlightenment_cb = cb;
   199	
   200		/* Make sure callback is registered before we write to MSRs */
   201		wmb();
   202	
   203		wrmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *((u64 *)&re_ctrl));
   204		wrmsrl(HV_X64_MSR_TSC_EMULATION_CONTROL, *((u64 *)&emu_ctrl));
   205	}
   206	EXPORT_SYMBOL_GPL(set_hv_tscchange_cb);
   207	
   208	void clear_hv_tscchange_cb(void)
   209	{
   210		struct hv_reenlightenment_control re_ctrl;
   211	
   212		if (!hv_reenlightenment_available())
   213			return;
   214	
   215		rdmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *(u64 *)&re_ctrl);
   216		re_ctrl.enabled = 0;
   217		wrmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *(u64 *)&re_ctrl);
   218	
   219		hv_reenlightenment_cb = NULL;
   220	}
   221	EXPORT_SYMBOL_GPL(clear_hv_tscchange_cb);
   222	
   223	static int hv_cpu_die(unsigned int cpu)
   224	{
   225		struct hv_reenlightenment_control re_ctrl;
   226		unsigned int new_cpu;
   227		void **input_arg;
   228	
   229		input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
   230		free_page((unsigned long)*input_arg);
   231	
   232		if (hv_vp_assist_page && hv_vp_assist_page[cpu])
   233			wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
   234	
   235		if (hv_reenlightenment_cb == NULL)
   236			return 0;
   237	
   238		rdmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *((u64 *)&re_ctrl));
   239		if (re_ctrl.target_vp == hv_vp_index[cpu]) {
   240			/* Reassign to some other online CPU */
   241			new_cpu = cpumask_any_but(cpu_online_mask, cpu);
   242	
   243			re_ctrl.target_vp = hv_vp_index[new_cpu];
   244			wrmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *((u64 *)&re_ctrl));
   245		}
   246	
   247		return 0;
   248	}
   249	
   250	/*
   251	 * This function is to be invoked early in the boot sequence after the
   252	 * hypervisor has been detected.
   253	 *
   254	 * 1. Setup the hypercall page.
   255	 * 2. Register Hyper-V specific clocksource.
   256	 * 3. Setup Hyper-V specific APIC entry points.
   257	 */
   258	void __init hyperv_init(void)
   259	{
   260		u64 guest_id, required_msrs;
   261		union hv_x64_msr_hypercall_contents hypercall_msr;
   262		int cpuhp;
   263	
   264		if (x86_hyper_type != X86_HYPER_MS_HYPERV)
   265			return;
   266	
   267		/* Absolutely required MSRs */
   268		required_msrs = HV_X64_MSR_HYPERCALL_AVAILABLE |
   269			HV_X64_MSR_VP_INDEX_AVAILABLE;
   270	
   271		if ((ms_hyperv.features & required_msrs) != required_msrs)
   272			return;
   273	
   274		/* Allocate the per-CPU state for the hypercall input arg */
 > 275		hyperv_pcpu_input_arg = alloc_percpu(void  *);
   276	
   277		if (hyperv_pcpu_input_arg == NULL)
   278			return;
   279	
   280		/* Allocate percpu VP index */
   281		hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
   282					    GFP_KERNEL);
   283		if (!hv_vp_index)
   284			return;
   285	
   286		hv_vp_assist_page = kcalloc(num_possible_cpus(),
   287					    sizeof(*hv_vp_assist_page), GFP_KERNEL);
   288		if (!hv_vp_assist_page) {
   289			ms_hyperv.hints &= ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
   290			goto free_vp_index;
   291		}
   292	
   293		cpuhp = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/hyperv_init:online",
   294					  hv_cpu_init, hv_cpu_die);
   295		if (cpuhp < 0)
   296			goto free_vp_assist_page;
   297	
   298		/*
   299		 * Setup the hypercall page and enable hypercalls.
   300		 * 1. Register the guest ID
   301		 * 2. Enable the hypercall and register the hypercall page
   302		 */
   303		guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
   304		wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
   305	
   306		hv_hypercall_pg  = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL_RX);
   307		if (hv_hypercall_pg == NULL) {
   308			wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
   309			goto remove_cpuhp_state;
   310		}
   311	
   312		rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
   313		hypercall_msr.enable = 1;
   314		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
   315		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
   316	
   317		hyper_alloc_mmu();
   318	
   319		hv_apic_init();
   320	
   321		/*
   322		 * Register Hyper-V specific clocksource.
   323		 */
   324	#ifdef CONFIG_HYPERV_TSCPAGE
   325		if (ms_hyperv.features & HV_X64_MSR_REFERENCE_TSC_AVAILABLE) {
   326			union hv_x64_msr_hypercall_contents tsc_msr;
   327	
   328			tsc_pg = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
   329			if (!tsc_pg)
   330				goto register_msr_cs;
   331	
   332			hyperv_cs = &hyperv_cs_tsc;
   333	
   334			rdmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
   335	
   336			tsc_msr.enable = 1;
   337			tsc_msr.guest_physical_address = vmalloc_to_pfn(tsc_pg);
   338	
   339			wrmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
   340	
   341			hyperv_cs_tsc.archdata.vclock_mode = VCLOCK_HVCLOCK;
   342	
   343			clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
   344			return;
   345		}
   346	register_msr_cs:
   347	#endif
   348		/*
   349		 * For 32 bit guests just use the MSR based mechanism for reading
   350		 * the partition counter.
   351		 */
   352	
   353		hyperv_cs = &hyperv_cs_msr;
   354		if (ms_hyperv.features & HV_X64_MSR_TIME_REF_COUNT_AVAILABLE)
   355			clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
   356	
   357		return;
   358	
   359	remove_cpuhp_state:
   360		cpuhp_remove_state(cpuhp);
   361	free_vp_assist_page:
   362		kfree(hv_vp_assist_page);
   363		hv_vp_assist_page = NULL;
   364	free_vp_index:
   365		kfree(hv_vp_index);
   366		hv_vp_index = NULL;
   367	}
   368	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

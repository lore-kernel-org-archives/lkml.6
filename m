Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757708AbeD0LzO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:55:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:51031 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbeD0LzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:55:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,335,1520924400";
   d="gz'50?scan'50,208,50";a="223877971"
Date: Fri, 27 Apr 2018 19:55:04 +0800
From: kbuild test robot <lkp@intel.com>
To: kys@linuxonhyperv.com
Cc: kbuild-all@01.org, x86@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, apw@canonical.com, jasowang@redhat.com,
        tglx@linutronix.de, hpa@zytor.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com,
        "K. Y. Srinivasan" <kys@microsoft.com>
Subject: Re: [PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments
Message-ID: <201804271859.knaN67cE%fengguang.wu@intel.com>
References: <20180425181250.8740-2-kys@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20180425181250.8740-2-kys@linuxonhyperv.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Srinivasan,

I love your patch! Yet something to improve:

[auto build test ERROR on v4.17-rc2]
[also build test ERROR on next-20180426]
[cannot apply to tip/x86/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/kys-linuxonhyperv-com/X86-Hyper-V-APIC-enlightenments/20180427-114416
config: i386-randconfig-s1-04271426 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   arch/x86/hyperv/hv_apic.c: In function 'hv_apic_read':
   arch/x86/hyperv/hv_apic.c:73:10: error: implicit declaration of function 'native_apic_mem_read' [-Werror=implicit-function-declaration]
      return native_apic_mem_read(reg);
             ^~~~~~~~~~~~~~~~~~~~
   arch/x86/hyperv/hv_apic.c: In function 'hv_apic_write':
   arch/x86/hyperv/hv_apic.c:87:3: error: implicit declaration of function 'native_apic_mem_write' [-Werror=implicit-function-declaration]
      native_apic_mem_write(reg, val);
      ^~~~~~~~~~~~~~~~~~~~~
   arch/x86/hyperv/hv_apic.c: In function 'hv_send_ipi':
   arch/x86/hyperv/hv_apic.c:155:3: error: invalid use of undefined type 'struct apic'
      orig_apic.send_IPI(cpu, vector);
      ^~~~~~~~~
   arch/x86/hyperv/hv_apic.c: In function 'hv_send_ipi_mask':
   arch/x86/hyperv/hv_apic.c:161:3: error: invalid use of undefined type 'struct apic'
      orig_apic.send_IPI_mask(mask, vector);
      ^~~~~~~~~
   arch/x86/hyperv/hv_apic.c: In function 'hv_send_ipi_mask_allbutself':
   arch/x86/hyperv/hv_apic.c:174:3: error: invalid use of undefined type 'struct apic'
      orig_apic.send_IPI_mask_allbutself(mask, vector);
      ^~~~~~~~~
   arch/x86/hyperv/hv_apic.c: In function 'hv_send_ipi_all':
   arch/x86/hyperv/hv_apic.c:185:3: error: invalid use of undefined type 'struct apic'
      orig_apic.send_IPI_all(vector);
      ^~~~~~~~~
   arch/x86/hyperv/hv_apic.c: In function 'hv_send_ipi_self':
   arch/x86/hyperv/hv_apic.c:191:3: error: invalid use of undefined type 'struct apic'
      orig_apic.send_IPI_self(vector);
      ^~~~~~~~~
   arch/x86/hyperv/hv_apic.c: In function 'hv_apic_init':
   arch/x86/hyperv/hv_apic.c:204:16: error: 'apic' undeclared (first use in this function)
      orig_apic = *apic;
                   ^~~~
   arch/x86/hyperv/hv_apic.c:204:16: note: each undeclared identifier is reported only once for each function it appears in
>> arch/x86/hyperv/hv_apic.c:204:3: error: 'orig_apic' has an incomplete type 'struct apic'
      orig_apic = *apic;
      ^~~~~~~~~
   arch/x86/hyperv/hv_apic.c:217:3: error: implicit declaration of function 'apic_set_eoi_write' [-Werror=implicit-function-declaration]
      apic_set_eoi_write(hv_apic_eoi_write);
      ^~~~~~~~~~~~~~~~~~
   arch/x86/hyperv/hv_apic.c: At top level:
>> arch/x86/hyperv/hv_apic.c:39:20: error: storage size of 'orig_apic' isn't known
    static struct apic orig_apic;
                       ^~~~~~~~~
   cc1: some warnings being treated as errors

vim +204 arch/x86/hyperv/hv_apic.c

    38	
  > 39	static struct apic orig_apic;
    40	
    41	static u64 hv_apic_icr_read(void)
    42	{
    43		u64 reg_val;
    44	
    45		rdmsrl(HV_X64_MSR_ICR, reg_val);
    46		return reg_val;
    47	}
    48	
    49	static void hv_apic_icr_write(u32 low, u32 id)
    50	{
    51		u64 reg_val;
    52	
    53		reg_val = SET_APIC_DEST_FIELD(id);
    54		reg_val = reg_val << 32;
    55		reg_val |= low;
    56	
    57		wrmsrl(HV_X64_MSR_ICR, reg_val);
    58	}
    59	
    60	static u32 hv_apic_read(u32 reg)
    61	{
    62		u32 reg_val, hi;
    63	
    64		switch (reg) {
    65		case APIC_EOI:
    66			rdmsr(HV_X64_MSR_EOI, reg_val, hi);
    67			return reg_val;
    68		case APIC_TASKPRI:
    69			rdmsr(HV_X64_MSR_TPR, reg_val, hi);
    70			return reg_val;
    71	
    72		default:
    73			return native_apic_mem_read(reg);
    74		}
    75	}
    76	
    77	static void hv_apic_write(u32 reg, u32 val)
    78	{
    79		switch (reg) {
    80		case APIC_EOI:
    81			wrmsr(HV_X64_MSR_EOI, val, 0);
    82			break;
    83		case APIC_TASKPRI:
    84			wrmsr(HV_X64_MSR_TPR, val, 0);
    85			break;
    86		default:
    87			native_apic_mem_write(reg, val);
    88		}
    89	}
    90	
    91	static void hv_apic_eoi_write(u32 reg, u32 val)
    92	{
    93		wrmsr(HV_X64_MSR_EOI, val, 0);
    94	}
    95	
    96	/*
    97	 * IPI implementation on Hyper-V.
    98	 */
    99	
   100	static int __send_ipi_mask(const struct cpumask *mask, int vector)
   101	{
   102		int cur_cpu, vcpu;
   103		struct ipi_arg_non_ex **arg;
   104		struct ipi_arg_non_ex *ipi_arg;
   105		int ret = 1;
   106		unsigned long flags;
   107	
   108		if (cpumask_empty(mask))
   109			return 0;
   110	
   111		if (!hv_hypercall_pg)
   112			return ret;
   113	
   114		if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
   115			return ret;
   116	
   117		local_irq_save(flags);
   118		arg = (struct ipi_arg_non_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
   119	
   120		ipi_arg = *arg;
   121		if (unlikely(!ipi_arg))
   122			goto ipi_mask_done;
   123	
   124	
   125		ipi_arg->vector = vector;
   126		ipi_arg->reserved = 0;
   127		ipi_arg->cpu_mask = 0;
   128	
   129		for_each_cpu(cur_cpu, mask) {
   130			vcpu = hv_cpu_number_to_vp_number(cur_cpu);
   131			if (vcpu >= 64)
   132				goto ipi_mask_done;
   133	
   134			__set_bit(vcpu, (unsigned long *)&ipi_arg->cpu_mask);
   135		}
   136	
   137		ret = hv_do_hypercall(HVCALL_SEND_IPI, ipi_arg, NULL);
   138	
   139	ipi_mask_done:
   140		local_irq_restore(flags);
   141		return ret;
   142	}
   143	
   144	static int __send_ipi_one(int cpu, int vector)
   145	{
   146		struct cpumask mask = CPU_MASK_NONE;
   147	
   148		cpumask_set_cpu(cpu, &mask);
   149		return __send_ipi_mask(&mask, vector);
   150	}
   151	
   152	static void hv_send_ipi(int cpu, int vector)
   153	{
   154		if (__send_ipi_one(cpu, vector))
   155			orig_apic.send_IPI(cpu, vector);
   156	}
   157	
   158	static void hv_send_ipi_mask(const struct cpumask *mask, int vector)
   159	{
   160		if (__send_ipi_mask(mask, vector))
   161			orig_apic.send_IPI_mask(mask, vector);
   162	}
   163	
   164	static void hv_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
   165	{
   166		unsigned int this_cpu = smp_processor_id();
   167		struct cpumask new_mask;
   168		const struct cpumask *local_mask;
   169	
   170		cpumask_copy(&new_mask, mask);
   171		cpumask_clear_cpu(this_cpu, &new_mask);
   172		local_mask = &new_mask;
   173		if (__send_ipi_mask(local_mask, vector))
   174			orig_apic.send_IPI_mask_allbutself(mask, vector);
   175	}
   176	
   177	static void hv_send_ipi_allbutself(int vector)
   178	{
   179		hv_send_ipi_mask_allbutself(cpu_online_mask, vector);
   180	}
   181	
   182	static void hv_send_ipi_all(int vector)
   183	{
   184		if (__send_ipi_mask(cpu_online_mask, vector))
   185			orig_apic.send_IPI_all(vector);
   186	}
   187	
   188	static void hv_send_ipi_self(int vector)
   189	{
   190		if (__send_ipi_one(smp_processor_id(), vector))
 > 191			orig_apic.send_IPI_self(vector);
   192	}
   193	
   194	void __init hv_apic_init(void)
   195	{
   196		if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
   197			if (hyperv_pcpu_input_arg == NULL)
   198				goto msr_based_access;
   199	
   200			pr_info("Hyper-V: Using IPI hypercalls\n");
   201			/*
   202			 * Set the IPI entry points.
   203			 */
 > 204			orig_apic = *apic;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--KsGdsel6WgEHnImy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
zqHuvCqcAQA=

--KsGdsel6WgEHnImy--

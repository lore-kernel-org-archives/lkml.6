Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3800878-1524810318-3-3752417226406745415
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii', plain='us-ascii'
X-Attached: .config.gz
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524810317; b=JPpjGWomsnEq/UPZJkqAZCZCQZw+O2cKR2iCq6LXOFuZ+KvZbi
    NVXrTx8tpgbJ42XIDL5CZ1hycGAyE+CU0xreE2x2+LRIir3dCqRl3iMhYPzqdoKY
    R2wQpsQweph3TzUFSgKCPvAIRq+tpQu7fwJ8jBiAKSLKtOKwlU0ZqMGvR2POvZii
    ea7AHs55HGRmr476SrhZA3U6BC9wSVyF3v2X4r351Z3i4fhUq+8iFqNkPWHTealZ
    Vuibs3fdO0Rly5ur4TZpCdcARgoJVkI5oiDrAzcmnoax96AUFk2hGi+TBm6kZ+CO
    NbmYqtknNckFWGM0JgMjpNUQ18CawNDshtQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:sender; s=fm2; t=1524810317; bh=FsHHSrrQdIeRM
    Y3Jhj6p7MxHAD5DgSGUNEzRJTz0bi0=; b=caIym2ZC5CW5fmk2FBJB8X/Dp63xc
    7SDESMmLkxUmZZXdf5LVK2lfkxs66R9RK7EnkSRcoKZjAeclU9go3gZeTCyqXA9b
    WuiQ7NDnvPiklg48kLVr3xi07wRMGK745eOAYwF2V2odmTBRUVN9QI1c+nt6rIWE
    hLVt0Nq+GNeo4xa5tttGtGKClIORqHrM3Z7V2em4vyE4wcjziP1+yA8+lQpm1Qwj
    xyrfae5sQkgjzRRxOIM0O7ssV7LIl7UL9MRQdvXc8TSQp8UR9/ru18jkuxJcPU8D
    mY0/7G+ZDgK2rAvy5ziukwvi3aV0jeL22tCso+wEE7UlDVt1kstr4/Pbg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfE8eAl17UVtZVbKPs7tkERxKP/zcCPOa0xAWGLRSFFH3T+ub5l8/rUMiEJM0Scg/urqnL/1XojlJgrjzXtuEbURjM5/Vb2ZomCfOL5fJUdpbzfn7QXud
    LPhkeSwcH5DakBG2vJsmPcb5JOSl+8Z/OWagraMSbSjbB2SFg4h50rrqZrIj3Ew6lXCQuCY5GpGW50iKAH1R9ftH+bLY8jyAB8UimfM/LHRC4wBWmz8eNrPK
    pXON96QlckrPI32Mv5AgUQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=NEAV23lmAAAA:8 a=i3X5FwGiAAAA:8 a=EluMrl-fEcsROhT4BwcA:9
    a=9AwkodyJcjAqEYL4:21 a=xo3FtjN-ac_EaBbL:21 a=CjuIK1q_8ugA:10
    a=zORqCcw79nBHG9HtAM0A:9 a=49ladYHvHUoA:10 a=DDOyTI_5AAAA:8
    a=w27ZC7bHMYj9Vt11HkIA:9 a=pC-h2on8RWMA:10 a=mmqRlSCDY2ywfjPLJ4af:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,334,1520924400";
 d="gz'50?scan'50,208,50";a="223811517"
Date: Fri, 27 Apr 2018 14:24:44 +0800
From: kbuild test robot <lkp@intel.com>
To: kys@linuxonhyperv.com
Subject: Re: [PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments
Message-ID: <201804271433.yEzcFoiD%fengguang.wu@intel.com>
References: <20180425181250.8740-2-kys@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
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
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Srinivasan,

I love your patch! Yet something to improve:

[auto build test ERROR on v4.17-rc2]
[also build test ERROR on next-20180426]
[cannot apply to tip/x86/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/kys-linuxonhyperv-com/X86-Hyper-V-APIC-enlightenments/20180427-114416
config: i386-randconfig-b0-04270034 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   arch/x86//hyperv/hv_apic.c: In function 'hv_apic_read':
   arch/x86//hyperv/hv_apic.c:73:3: error: implicit declaration of function 'native_apic_mem_read' [-Werror=implicit-function-declaration]
      return native_apic_mem_read(reg);
      ^
   arch/x86//hyperv/hv_apic.c: In function 'hv_apic_write':
   arch/x86//hyperv/hv_apic.c:87:3: error: implicit declaration of function 'native_apic_mem_write' [-Werror=implicit-function-declaration]
      native_apic_mem_write(reg, val);
      ^
   arch/x86//hyperv/hv_apic.c: In function 'hv_send_ipi':
>> arch/x86//hyperv/hv_apic.c:155:3: error: invalid use of undefined type 'struct apic'
      orig_apic.send_IPI(cpu, vector);
      ^
   arch/x86//hyperv/hv_apic.c: In function 'hv_send_ipi_mask':
   arch/x86//hyperv/hv_apic.c:161:3: error: invalid use of undefined type 'struct apic'
      orig_apic.send_IPI_mask(mask, vector);
      ^
   arch/x86//hyperv/hv_apic.c: In function 'hv_send_ipi_mask_allbutself':
   arch/x86//hyperv/hv_apic.c:174:3: error: invalid use of undefined type 'struct apic'
      orig_apic.send_IPI_mask_allbutself(mask, vector);
      ^
   arch/x86//hyperv/hv_apic.c: In function 'hv_send_ipi_all':
   arch/x86//hyperv/hv_apic.c:185:3: error: invalid use of undefined type 'struct apic'
      orig_apic.send_IPI_all(vector);
      ^
   arch/x86//hyperv/hv_apic.c: In function 'hv_send_ipi_self':
   arch/x86//hyperv/hv_apic.c:191:3: error: invalid use of undefined type 'struct apic'
      orig_apic.send_IPI_self(vector);
      ^
   arch/x86//hyperv/hv_apic.c: In function 'hv_apic_init':
   arch/x86//hyperv/hv_apic.c:204:16: error: 'apic' undeclared (first use in this function)
      orig_apic = *apic;
                   ^
   arch/x86//hyperv/hv_apic.c:204:16: note: each undeclared identifier is reported only once for each function it appears in
>> arch/x86//hyperv/hv_apic.c:204:3: error: 'orig_apic' has an incomplete type
      orig_apic = *apic;
      ^
   arch/x86//hyperv/hv_apic.c:217:3: error: implicit declaration of function 'apic_set_eoi_write' [-Werror=implicit-function-declaration]
      apic_set_eoi_write(hv_apic_eoi_write);
      ^
   cc1: some warnings being treated as errors

vim +/orig_apic +204 arch/x86//hyperv/hv_apic.c

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
  > 73			return native_apic_mem_read(reg);
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
 > 155			orig_apic.send_IPI(cpu, vector);
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

--MGYHOYXEY6WxJCY8
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--MGYHOYXEY6WxJCY8--

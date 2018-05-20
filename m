Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2730981-1526809600-2-8165430371275954367
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii', plain='us-ascii'
X-Attached: .config.gz
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526809598; b=NyPsj0FRygsg59xuKq+SnjH0p2UiQPdMvRtr/e4F05GpfA8I0/
    SQDMmstAQIdgG5at5O42i1W8K3UwMyNF7sk992Y0wzH6mS1k4vldf/RW7Iqn9KeD
    MGXWTLo1C99thINsL5twDpZfZ3HwM8t5M5K1bbwQ/8VrYFZFbWRH0VCUuptMs3oq
    jWNQIwIfnG+nERMdhwAPZm4LiQ637MxRH/OdUfzNtwqKtMP48TJg6bu1lOHVRu8V
    /JBrAa2vrDpqfFlthnRs7Sbvlnkwx7gwRZ80Rg4dhuspoqN8sqP8tV7spYrK7ZZ+
    1c2swDHr3lJM4HrvO1IaPSa0dvbJuQf0kmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:sender; s=fm2; t=1526809598; bh=HDPLTjL4tQWyp
    8os96VCCrkVl7g37CWKyQAbb5W3qH4=; b=O6wVXe/q+gdS6nG/XK5MrH4dhcIg1
    o8fQpqwVwhekW0YMAE6aObD/eFVh2Xi+KfCyuJfWh4Q8X/Itf9OMxlRU9qPZ1aGu
    RS30HzlWmtRmwOU8XYrq9IWjr2b1WynrEUjXlGBgeHtz9+aq8s9FEch4uy7pZ6Nw
    2l8cZrxCCIg1APyEuCgMUNvIHOYTVD4j3mlwtkVLYlfoMb0b9mEnJ4UTZUnrY3iT
    JVeQWemrtwDirG3yMbRZ/d6Ly9IjHUssCSnTTjRj2uEtDNdJnMJb4BLI/4ttbmSP
    x7fkNoWdbVrscG2gjp4vF8LDfbx/v57WoSVm/JG7XjhRrj95ox5hhV49w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=intel.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=intel.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMIw6oETfUZgQmcDSyGp9y4qbWUe7m8IkyfCMkMPXE+3vSo596PZs2mrJhFxd7N0FNjsWLGJCKG3u++HngaaA8K7FDXQyPIFhMLXsFSP2t5n72jsWuOt
    TQUdyDL76C7U/EuOx3Irm1zxFP4uajJJizpnSZ0ZXNgW+IdDAQWuM3dM/njGrCQgUC9yjK6xhNt+0akph5xtYbdsB/QWH8n9m4T6tTyA5N8q8jSvvpGsMZGv
    /QOFAoBZLaABDg1XQikL/g==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=NEAV23lmAAAA:8 a=i3X5FwGiAAAA:8 a=doPAdroC1e4Pv6TCzSIA:9
    a=j6f0b_a40gOvRsyr:21 a=52JT0efpLKaSTHOW:21 a=CjuIK1q_8ugA:10
    a=9pUlKvUlxV49anso9_wA:9 a=49ladYHvHUoA:10 a=DDOyTI_5AAAA:8
    a=w27ZC7bHMYj9Vt11HkIA:9 a=pC-h2on8RWMA:10 a=mmqRlSCDY2ywfjPLJ4af:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,422,1520924400";
 d="gz'50?scan'50,208,50";a="230152174"
Date: Sun, 20 May 2018 17:45:26 +0800
From: kbuild test robot <lkp@intel.com>
To: kys@linuxonhyperv.com
Subject: Re: [PATCH V3 2/5] X86: Hyper-V: Enable IPI enlightenments
Message-ID: <201805201745.7QoORuAM%fengguang.wu@intel.com>
References: <20180516215334.6547-2-kys@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20180516215334.6547-2-kys@linuxonhyperv.com>
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


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Srinivasan,

I love your patch! Yet something to improve:

[auto build test ERROR on v4.17-rc5]
[also build test ERROR on next-20180517]
[cannot apply to tip/x86/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/kys-linuxonhyperv-com/X86-Hyper-V-APIC-enlightenments/20180520-040432
config: x86_64-randconfig-s5-05201710 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   arch/x86/hyperv/hv_apic.c: In function 'hv_apic_read':
   arch/x86/hyperv/hv_apic.c:70:10: error: implicit declaration of function 'native_apic_mem_read'; did you mean 'hv_apic_icr_read'? [-Werror=implicit-function-declaration]
      return native_apic_mem_read(reg);
             ^~~~~~~~~~~~~~~~~~~~
             hv_apic_icr_read
   arch/x86/hyperv/hv_apic.c: In function 'hv_apic_write':
   arch/x86/hyperv/hv_apic.c:84:3: error: implicit declaration of function 'native_apic_mem_write'; did you mean 'hv_apic_icr_write'? [-Werror=implicit-function-declaration]
      native_apic_mem_write(reg, val);
      ^~~~~~~~~~~~~~~~~~~~~
      hv_apic_icr_write
   arch/x86/hyperv/hv_apic.c: In function 'hv_send_ipi':
>> arch/x86/hyperv/hv_apic.c:154:12: error: invalid use of undefined type 'struct apic'
      orig_apic.send_IPI(cpu, vector);
               ^
   arch/x86/hyperv/hv_apic.c: In function 'hv_send_ipi_mask':
   arch/x86/hyperv/hv_apic.c:160:12: error: invalid use of undefined type 'struct apic'
      orig_apic.send_IPI_mask(mask, vector);
               ^
   arch/x86/hyperv/hv_apic.c: In function 'hv_send_ipi_mask_allbutself':
   arch/x86/hyperv/hv_apic.c:173:12: error: invalid use of undefined type 'struct apic'
      orig_apic.send_IPI_mask_allbutself(mask, vector);
               ^
   arch/x86/hyperv/hv_apic.c: In function 'hv_send_ipi_all':
   arch/x86/hyperv/hv_apic.c:184:12: error: invalid use of undefined type 'struct apic'
      orig_apic.send_IPI_all(vector);
               ^
   arch/x86/hyperv/hv_apic.c: In function 'hv_send_ipi_self':
   arch/x86/hyperv/hv_apic.c:190:12: error: invalid use of undefined type 'struct apic'
      orig_apic.send_IPI_self(vector);
               ^
   arch/x86/hyperv/hv_apic.c: In function 'hv_apic_init':
>> arch/x86/hyperv/hv_apic.c:200:16: error: 'apic' undeclared (first use in this function)
      orig_apic = *apic;
                   ^~~~
   arch/x86/hyperv/hv_apic.c:200:16: note: each undeclared identifier is reported only once for each function it appears in
>> arch/x86/hyperv/hv_apic.c:200:13: error: 'orig_apic' has an incomplete type 'struct apic'
      orig_apic = *apic;
                ^
   arch/x86/hyperv/hv_apic.c:212:3: error: implicit declaration of function 'apic_set_eoi_write'; did you mean 'hv_apic_eoi_write'? [-Werror=implicit-function-declaration]
      apic_set_eoi_write(hv_apic_eoi_write);
      ^~~~~~~~~~~~~~~~~~
      hv_apic_eoi_write
   arch/x86/hyperv/hv_apic.c: At top level:
>> arch/x86/hyperv/hv_apic.c:36:20: error: storage size of 'orig_apic' isn't known
    static struct apic orig_apic;
                       ^~~~~~~~~
   cc1: some warnings being treated as errors

vim +154 arch/x86/hyperv/hv_apic.c

    35	
  > 36	static struct apic orig_apic;
    37	
    38	static u64 hv_apic_icr_read(void)
    39	{
    40		u64 reg_val;
    41	
    42		rdmsrl(HV_X64_MSR_ICR, reg_val);
    43		return reg_val;
    44	}
    45	
    46	static void hv_apic_icr_write(u32 low, u32 id)
    47	{
    48		u64 reg_val;
    49	
    50		reg_val = SET_APIC_DEST_FIELD(id);
    51		reg_val = reg_val << 32;
    52		reg_val |= low;
    53	
    54		wrmsrl(HV_X64_MSR_ICR, reg_val);
    55	}
    56	
    57	static u32 hv_apic_read(u32 reg)
    58	{
    59		u32 reg_val, hi;
    60	
    61		switch (reg) {
    62		case APIC_EOI:
    63			rdmsr(HV_X64_MSR_EOI, reg_val, hi);
    64			return reg_val;
    65		case APIC_TASKPRI:
    66			rdmsr(HV_X64_MSR_TPR, reg_val, hi);
    67			return reg_val;
    68	
    69		default:
    70			return native_apic_mem_read(reg);
    71		}
    72	}
    73	
    74	static void hv_apic_write(u32 reg, u32 val)
    75	{
    76		switch (reg) {
    77		case APIC_EOI:
    78			wrmsr(HV_X64_MSR_EOI, val, 0);
    79			break;
    80		case APIC_TASKPRI:
    81			wrmsr(HV_X64_MSR_TPR, val, 0);
    82			break;
    83		default:
  > 84			native_apic_mem_write(reg, val);
    85		}
    86	}
    87	
    88	static void hv_apic_eoi_write(u32 reg, u32 val)
    89	{
    90		wrmsr(HV_X64_MSR_EOI, val, 0);
    91	}
    92	
    93	/*
    94	 * IPI implementation on Hyper-V.
    95	 */
    96	static bool __send_ipi_mask(const struct cpumask *mask, int vector)
    97	{
    98		int cur_cpu, vcpu;
    99		struct ipi_arg_non_ex **arg;
   100		struct ipi_arg_non_ex *ipi_arg;
   101		int ret = 1;
   102		unsigned long flags;
   103	
   104		if (cpumask_empty(mask))
   105			return true;
   106	
   107		if (!hv_hypercall_pg)
   108			return false;
   109	
   110		if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
   111			return false;
   112	
   113		local_irq_save(flags);
   114		arg = (struct ipi_arg_non_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
   115	
   116		ipi_arg = *arg;
   117		if (unlikely(!ipi_arg))
   118			goto ipi_mask_done;
   119	
   120		ipi_arg->vector = vector;
   121		ipi_arg->reserved = 0;
   122		ipi_arg->cpu_mask = 0;
   123	
   124		for_each_cpu(cur_cpu, mask) {
   125			vcpu = hv_cpu_number_to_vp_number(cur_cpu);
   126			/*
   127			 * This particular version of the IPI hypercall can
   128			 * only target upto 64 CPUs.
   129			 */
   130			if (vcpu >= 64)
   131				goto ipi_mask_done;
   132	
   133			__set_bit(vcpu, (unsigned long *)&ipi_arg->cpu_mask);
   134		}
   135	
   136		ret = hv_do_hypercall(HVCALL_SEND_IPI, ipi_arg, NULL);
   137	
   138	ipi_mask_done:
   139		local_irq_restore(flags);
   140		return ((ret == 0) ? true : false);
   141	}
   142	
   143	static bool __send_ipi_one(int cpu, int vector)
   144	{
   145		struct cpumask mask = CPU_MASK_NONE;
   146	
   147		cpumask_set_cpu(cpu, &mask);
   148		return __send_ipi_mask(&mask, vector);
   149	}
   150	
   151	static void hv_send_ipi(int cpu, int vector)
   152	{
   153		if (!__send_ipi_one(cpu, vector))
 > 154			orig_apic.send_IPI(cpu, vector);
   155	}
   156	
   157	static void hv_send_ipi_mask(const struct cpumask *mask, int vector)
   158	{
   159		if (!__send_ipi_mask(mask, vector))
   160			orig_apic.send_IPI_mask(mask, vector);
   161	}
   162	
   163	static void hv_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
   164	{
   165		unsigned int this_cpu = smp_processor_id();
   166		struct cpumask new_mask;
   167		const struct cpumask *local_mask;
   168	
   169		cpumask_copy(&new_mask, mask);
   170		cpumask_clear_cpu(this_cpu, &new_mask);
   171		local_mask = &new_mask;
   172		if (!__send_ipi_mask(local_mask, vector))
   173			orig_apic.send_IPI_mask_allbutself(mask, vector);
   174	}
   175	
   176	static void hv_send_ipi_allbutself(int vector)
   177	{
   178		hv_send_ipi_mask_allbutself(cpu_online_mask, vector);
   179	}
   180	
   181	static void hv_send_ipi_all(int vector)
   182	{
   183		if (!__send_ipi_mask(cpu_online_mask, vector))
 > 184			orig_apic.send_IPI_all(vector);
   185	}
   186	
   187	static void hv_send_ipi_self(int vector)
   188	{
   189		if (!__send_ipi_one(smp_processor_id(), vector))
 > 190			orig_apic.send_IPI_self(vector);
   191	}
   192	
   193	void __init hv_apic_init(void)
   194	{
   195		if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
   196			pr_info("Hyper-V: Using IPI hypercalls\n");
   197			/*
   198			 * Set the IPI entry points.
   199			 */
 > 200			orig_apic = *apic;
   201	
   202			apic->send_IPI = hv_send_ipi;
   203			apic->send_IPI_mask = hv_send_ipi_mask;
   204			apic->send_IPI_mask_allbutself = hv_send_ipi_mask_allbutself;
   205			apic->send_IPI_allbutself = hv_send_ipi_allbutself;
   206			apic->send_IPI_all = hv_send_ipi_all;
   207			apic->send_IPI_self = hv_send_ipi_self;
   208		}
   209	
   210		if (ms_hyperv.hints & HV_X64_APIC_ACCESS_RECOMMENDED) {
   211			pr_info("Hyper-V: Using MSR based APIC access\n");
   212			apic_set_eoi_write(hv_apic_eoi_write);
   213			apic->read      = hv_apic_read;
   214			apic->write     = hv_apic_write;
   215			apic->icr_write = hv_apic_icr_write;
   216			apic->icr_read  = hv_apic_icr_read;
   217		}
   218	}
   219	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--tThc/1wpZn/ma/RB
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--tThc/1wpZn/ma/RB--

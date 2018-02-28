Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965163AbeB1Xen (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:34:43 -0500
Received: from mga18.intel.com ([134.134.136.126]:56524 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965012AbeB1Xel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:34:41 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,406,1515484800";
   d="gz'50?scan'50,208,50";a="24078724"
Date: Thu, 1 Mar 2018 07:33:47 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [tip:x86/apic 1/2] arch/x86/kernel/apic/apic.c:1507:2: error: 'i'
 undeclared; did you mean 'if'?
Message-ID: <201803010737.ZyGCouzm%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
head:   ea5dfef5a890c9e6e47bdddfc23c4a4ba0c1bea1
commit: 2066f4d67e7d9cbe44e451d782cdcc0a0d12e5d3 [1/2] x86/apic: Move pending intr check code into it's own function
config: i386-randconfig-x007-201808 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 2066f4d67e7d9cbe44e451d782cdcc0a0d12e5d3
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   arch/x86/kernel/apic/apic.c: In function 'setup_local_APIC':
>> arch/x86/kernel/apic/apic.c:1507:2: error: 'i' undeclared (first use in this function); did you mean 'if'?
     i = early_per_cpu(x86_cpu_to_logical_apicid, cpu);
     ^
     if
   arch/x86/kernel/apic/apic.c:1507:2: note: each undeclared identifier is reported only once for each function it appears in

vim +1507 arch/x86/kernel/apic/apic.c

2066f4d6 arch/x86/kernel/apic/apic.c Dou Liyang         2018-02-26  1460  
0e078e2f arch/x86/kernel/apic_64.c   Thomas Gleixner    2008-01-30  1461  /**
0e078e2f arch/x86/kernel/apic_64.c   Thomas Gleixner    2008-01-30  1462   * setup_local_APIC - setup the local APIC
0aa002fe arch/x86/kernel/apic/apic.c Tejun Heo          2010-12-09  1463   *
543113d2 arch/x86/kernel/apic/apic.c Dou Liyang         2017-02-07  1464   * Used to setup local APIC while initializing BSP or bringing up APs.
0aa002fe arch/x86/kernel/apic/apic.c Tejun Heo          2010-12-09  1465   * Always called with preemption disabled.
0e078e2f arch/x86/kernel/apic_64.c   Thomas Gleixner    2008-01-30  1466   */
b753a2b7 arch/x86/kernel/apic/apic.c Dou Liyang         2018-02-14  1467  static void setup_local_APIC(void)
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1468  {
0aa002fe arch/x86/kernel/apic/apic.c Tejun Heo          2010-12-09  1469  	int cpu = smp_processor_id();
2066f4d6 arch/x86/kernel/apic/apic.c Dou Liyang         2018-02-26  1470  	unsigned int value;
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1471  
f1182638 arch/x86/kernel/apic.c      Jan Beulich        2009-01-14  1472  	if (disable_apic) {
7167d08e arch/x86/kernel/apic/apic.c Henrik Kretzschmar 2011-02-22  1473  		disable_ioapic_support();
f1182638 arch/x86/kernel/apic.c      Jan Beulich        2009-01-14  1474  		return;
f1182638 arch/x86/kernel/apic.c      Jan Beulich        2009-01-14  1475  	}
f1182638 arch/x86/kernel/apic.c      Jan Beulich        2009-01-14  1476  
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1477  #ifdef CONFIG_X86_32
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1478  	/* Pound the ESR really hard over the head with a big hammer - mbligh */
08125d3e arch/x86/kernel/apic.c      Ingo Molnar        2009-01-28  1479  	if (lapic_is_integrated() && apic->disable_esr) {
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1480  		apic_write(APIC_ESR, 0);
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1481  		apic_write(APIC_ESR, 0);
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1482  		apic_write(APIC_ESR, 0);
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1483  		apic_write(APIC_ESR, 0);
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1484  	}
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1485  #endif
cdd6c482 arch/x86/kernel/apic/apic.c Ingo Molnar        2009-09-21  1486  	perf_events_lapic_init();
89c38c28 arch/x86/kernel/apic_64.c   Cyrill Gorcunov    2008-08-24  1487  
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1488  	/*
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1489  	 * Double-check whether this APIC is really registered.
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1490  	 * This is meaningless in clustered apic mode, so we skip it.
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1491  	 */
c2777f98 arch/x86/kernel/apic/apic.c Daniel Walker      2009-09-12  1492  	BUG_ON(!apic->apic_id_registered());
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1493  
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1494  	/*
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1495  	 * Intel recommends to set DFR, LDR and TPR before enabling
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1496  	 * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1497  	 * document number 292116).  So here it goes...
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1498  	 */
a5c43296 arch/x86/kernel/apic.c      Ingo Molnar        2009-01-28  1499  	apic->init_apic_ldr();
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1500  
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1501  #ifdef CONFIG_X86_32
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1502  	/*
acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1503  	 * APIC LDR is initialized.  If logical_apicid mapping was
acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1504  	 * initialized during get_smp_config(), make sure it matches the
acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1505  	 * actual value.
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1506  	 */
acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23 @1507  	i = early_per_cpu(x86_cpu_to_logical_apicid, cpu);
acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1508  	WARN_ON(i != BAD_APICID && i != logical_smp_processor_id());
acb8bc09 arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1509  	/* always use the value from LDR */
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1510  	early_per_cpu(x86_cpu_to_logical_apicid, cpu) =
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1511  		logical_smp_processor_id();
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1512  #endif
6f802c4b arch/x86/kernel/apic/apic.c Tejun Heo          2011-01-23  1513  
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1514  	/*
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1515  	 * Set Task Priority to 'accept all'. We never change this
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1516  	 * later on.
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1517  	 */
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1518  	value = apic_read(APIC_TASKPRI);
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1519  	value &= ~APIC_TPRI_MASK;
11a8e778 arch/x86_64/kernel/apic.c   Andi Kleen         2006-01-11  1520  	apic_write(APIC_TASKPRI, value);
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1521  
2066f4d6 arch/x86/kernel/apic/apic.c Dou Liyang         2018-02-26  1522  	apic_pending_intr_clear();
da7ed9f9 arch/x86_64/kernel/apic.c   Vivek Goyal        2006-03-25  1523  
da7ed9f9 arch/x86_64/kernel/apic.c   Vivek Goyal        2006-03-25  1524  	/*
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1525  	 * Now that we are all set up, enable the APIC
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1526  	 */
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1527  	value = apic_read(APIC_SPIV);
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1528  	value &= ~APIC_VECTOR_MASK;
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1529  	/*
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1530  	 * Enable APIC
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1531  	 */
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1532  	value |= APIC_SPIV_APIC_ENABLED;
^1da177e arch/x86_64/kernel/apic.c   Linus Torvalds     2005-04-16  1533  

:::::: The code at line 1507 was first introduced by commit
:::::: acb8bc09c6185e4d3d582d0076aaa6a89f19d8c5 x86: Add apic->x86_32_early_logical_apicid()

:::::: TO: Tejun Heo <tj@kernel.org>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--Nq2Wo0NMKNjxTN9z
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
lAEA

--Nq2Wo0NMKNjxTN9z--

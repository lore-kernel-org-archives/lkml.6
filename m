Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A3CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40B120C03
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40B120C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391596AbeHPQCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 12:02:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:40472 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbeHPQCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 12:02:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2018 06:03:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,247,1531810800"; 
   d="gz'50?scan'50,208,50";a="65400241"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2018 06:03:39 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fqHwA-0003Ic-S9; Thu, 16 Aug 2018 21:03:38 +0800
Date:   Thu, 16 Aug 2018 21:03:25 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@01.org, tglx@linutronix.de, palmer@sifive.com,
        jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: Re: [PATCH v4 3/3] irqchip: add a SiFive PLIC driver
Message-ID: <201808162025.rHQQ8gBd%fengguang.wu@intel.com>
References: <20180809075602.989-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20180809075602.989-4-hch@lst.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christoph,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on v4.18]
[cannot apply to next-20180816]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Christoph-Hellwig/dt-bindings-interrupt-controller-RISC-V-local-interrupt-controller/20180810-014110
config: riscv-defconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=riscv 

All errors (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/ptrace.h:18,
                    from arch/riscv/include/asm/processor.h:19,
                    from arch/riscv/include/asm/irqflags.h:18,
                    from include/linux/irqflags.h:16,
                    from arch/riscv/include/asm/bitops.h:22,
                    from include/linux/bitops.h:38,
                    from include/linux/kernel.h:11,
                    from include/linux/interrupt.h:6,
                    from drivers/irqchip/irq-sifive-plic.c:7:
   drivers/irqchip/irq-sifive-plic.c: In function 'plic_handle_irq':
>> drivers/irqchip/irq-sifive-plic.c:156:17: error: 'SIE_SEIE' undeclared (first use in this function); did you mean 'SIE_STIE'?
     csr_clear(sie, SIE_SEIE);
                    ^~~~~~~~
   arch/riscv/include/asm/csr.h:124:38: note: in definition of macro 'csr_clear'
     unsigned long __v = (unsigned long)(val);  \
                                         ^~~
   drivers/irqchip/irq-sifive-plic.c:156:17: note: each undeclared identifier is reported only once for each function it appears in
     csr_clear(sie, SIE_SEIE);
                    ^~~~~~~~
   arch/riscv/include/asm/csr.h:124:38: note: in definition of macro 'csr_clear'
     unsigned long __v = (unsigned long)(val);  \
                                         ^~~

vim +156 drivers/irqchip/irq-sifive-plic.c

   > 7	#include <linux/interrupt.h>
     8	#include <linux/io.h>
     9	#include <linux/irq.h>
    10	#include <linux/irqchip.h>
    11	#include <linux/irqdomain.h>
    12	#include <linux/module.h>
    13	#include <linux/of.h>
    14	#include <linux/of_address.h>
    15	#include <linux/of_irq.h>
    16	#include <linux/platform_device.h>
    17	#include <linux/spinlock.h>
    18	
    19	/*
    20	 * This driver implements a version of the RISC-V PLIC with the actual layout
    21	 * specified in chapter 8 of the SiFive U5 Coreplex Series Manual:
    22	 *
    23	 *     https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf
    24	 *
    25	 * The largest number supported by devices marked as 'riscv,plic0', is 1024, of
    26	 * which device 0 is defined as non-existent by the RISC-V Privileged Spec.
    27	 */
    28	
    29	#define MAX_DEVICES			1024
    30	#define MAX_CONTEXTS			15872
    31	
    32	/*
    33	 * Each interrupt source has a priority register associated with it.
    34	 * We always hardwire it to one in Linux.
    35	 */
    36	#define PRIORITY_BASE			0
    37	#define     PRIORITY_PER_ID		4
    38	
    39	/*
    40	 * Each hart context has a vector of interrupt enable bits associated with it.
    41	 * There's one bit for each interrupt source.
    42	 */
    43	#define ENABLE_BASE			0x2000
    44	#define     ENABLE_PER_HART		0x80
    45	
    46	/*
    47	 * Each hart context has a set of control registers associated with it.  Right
    48	 * now there's only two: a source priority threshold over which the hart will
    49	 * take an interrupt, and a register to claim interrupts.
    50	 */
    51	#define CONTEXT_BASE			0x200000
    52	#define     CONTEXT_PER_HART		0x1000
    53	#define     CONTEXT_THRESHOLD		0x00
    54	#define     CONTEXT_CLAIM		0x04
    55	
    56	static void __iomem *plic_regs;
    57	
    58	struct plic_handler {
    59		bool			present;
    60		int			ctxid;
    61	};
    62	static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
    63	
    64	static inline void __iomem *plic_hart_offset(int ctxid)
    65	{
    66		return plic_regs + CONTEXT_BASE + ctxid * CONTEXT_PER_HART;
    67	}
    68	
    69	static inline u32 __iomem *plic_enable_base(int ctxid)
    70	{
    71		return plic_regs + ENABLE_BASE + ctxid * ENABLE_PER_HART;
    72	}
    73	
    74	/*
    75	 * Protect mask operations on the registers given that we can't assume that
    76	 * atomic memory operations work on them.
    77	 */
    78	static DEFINE_RAW_SPINLOCK(plic_toggle_lock);
    79	
    80	static inline void plic_toggle(int ctxid, int hwirq, int enable)
    81	{
    82		u32 __iomem *reg = plic_enable_base(ctxid) + (hwirq / 32);
    83		u32 hwirq_mask = 1 << (hwirq % 32);
    84	
    85		raw_spin_lock(&plic_toggle_lock);
    86		if (enable)
    87			writel(readl(reg) | hwirq_mask, reg);
    88		else
    89			writel(readl(reg) & ~hwirq_mask, reg);
    90		raw_spin_unlock(&plic_toggle_lock);
    91	}
    92	
    93	static inline void plic_irq_toggle(struct irq_data *d, int enable)
    94	{
    95		int cpu;
    96	
    97		writel(enable, plic_regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
    98		for_each_cpu(cpu, irq_data_get_affinity_mask(d)) {
    99			struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
   100	
   101			if (handler->present)
   102				plic_toggle(handler->ctxid, d->hwirq, enable);
   103		}
   104	}
   105	
   106	static void plic_irq_enable(struct irq_data *d)
   107	{
   108		plic_irq_toggle(d, 1);
   109	}
   110	
   111	static void plic_irq_disable(struct irq_data *d)
   112	{
   113		plic_irq_toggle(d, 0);
   114	}
   115	
   116	static struct irq_chip plic_chip = {
   117		.name		= "SiFive PLIC",
   118		/*
   119		 * There is no need to mask/unmask PLIC interrupts.  They are "masked"
   120		 * by reading claim and "unmasked" when writing it back.
   121		 */
   122		.irq_enable	= plic_irq_enable,
   123		.irq_disable	= plic_irq_disable,
   124	};
   125	
   126	static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
   127				      irq_hw_number_t hwirq)
   128	{
   129		irq_set_chip_and_handler(irq, &plic_chip, handle_simple_irq);
   130		irq_set_chip_data(irq, NULL);
   131		irq_set_noprobe(irq);
   132		return 0;
   133	}
   134	
   135	static const struct irq_domain_ops plic_irqdomain_ops = {
   136		.map		= plic_irqdomain_map,
   137		.xlate		= irq_domain_xlate_onecell,
   138	};
   139	
   140	static struct irq_domain *plic_irqdomain;
   141	
   142	/*
   143	 * Handling an interrupt is a two-step process: first you claim the interrupt
   144	 * by reading the claim register, then you complete the interrupt by writing
   145	 * that source ID back to the same claim register.  This automatically enables
   146	 * and disables the interrupt, so there's nothing else to do.
   147	 */
   148	static void plic_handle_irq(struct pt_regs *regs)
   149	{
   150		struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
   151		void __iomem *claim = plic_hart_offset(handler->ctxid) + CONTEXT_CLAIM;
   152		irq_hw_number_t hwirq;
   153	
   154		WARN_ON_ONCE(!handler->present);
   155	
 > 156		csr_clear(sie, SIE_SEIE);
   157		while ((hwirq = readl(claim))) {
   158			int irq = irq_find_mapping(plic_irqdomain, hwirq);
   159	
   160			if (unlikely(irq <= 0))
   161				pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
   162						hwirq);
   163			else
   164				generic_handle_irq(irq);
   165			writel(hwirq, claim);
   166		}
   167		csr_set(sie, SIE_SEIE);
   168	}
   169	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--azLHFNyN32YCQGCU
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
LuzOg0oVVt8oI1gZ6IYYmY6vg/4P0I+qeRoMAQA=

--azLHFNyN32YCQGCU--

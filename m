Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032421AbeCSVxf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:53:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:59065 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032389AbeCSVx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:53:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,332,1517904000";
   d="gz'50?scan'50,208,50";a="35150768"
Date: Tue, 20 Mar 2018 05:53:21 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:irq/core 12/13] drivers/irqchip/irq-vic.c:295:2: error:
 implicit declaration of function 'set_handle_irq'; did you mean
 'vic_handle_irq'?
Message-ID: <201803200516.SWlP9b4m%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Palmer,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
head:   ba63053f018721a0ad60b083e21a15e324a4a8c4
commit: 886d70aac148f6015ae3d1379c81b98af3e70981 [12/13] ARM: irq: Convert to GENERIC_IRQ_MULTI_HANDLER
config: arm-netx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 886d70aac148f6015ae3d1379c81b98af3e70981
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-vic.c: In function 'vic_register':
>> drivers/irqchip/irq-vic.c:295:2: error: implicit declaration of function 'set_handle_irq'; did you mean 'vic_handle_irq'? [-Werror=implicit-function-declaration]
     set_handle_irq(vic_handle_irq);
     ^~~~~~~~~~~~~~
     vic_handle_irq
   cc1: some warnings being treated as errors

vim +295 drivers/irqchip/irq-vic.c

ce94df9c0 arch/arm/common/vic.c     Linus Walleij   2012-04-20  262  
bb06b7371 arch/arm/common/vic.c     Hartley Sweeten 2010-01-12  263  /**
f9b28ccbc arch/arm/common/vic.c     Jamie Iles      2011-09-27  264   * vic_register() - Register a VIC.
bb06b7371 arch/arm/common/vic.c     Hartley Sweeten 2010-01-12  265   * @base: The base address of the VIC.
e641b987c drivers/irqchip/irq-vic.c Linus Walleij   2013-11-21  266   * @parent_irq: The parent IRQ if cascaded, else 0.
bb06b7371 arch/arm/common/vic.c     Hartley Sweeten 2010-01-12  267   * @irq: The base IRQ for the VIC.
fa943bed6 arch/arm/common/vic.c     Linus Walleij   2012-04-20  268   * @valid_sources: bitmask of valid interrupts
bb06b7371 arch/arm/common/vic.c     Hartley Sweeten 2010-01-12  269   * @resume_sources: bitmask of interrupts allowed for resume sources.
f9b28ccbc arch/arm/common/vic.c     Jamie Iles      2011-09-27  270   * @node: The device tree node associated with the VIC.
bb06b7371 arch/arm/common/vic.c     Hartley Sweeten 2010-01-12  271   *
bb06b7371 arch/arm/common/vic.c     Hartley Sweeten 2010-01-12  272   * Register the VIC with the system device tree so that it can be notified
bb06b7371 arch/arm/common/vic.c     Hartley Sweeten 2010-01-12  273   * of suspend and resume requests and ensure that the correct actions are
bb06b7371 arch/arm/common/vic.c     Hartley Sweeten 2010-01-12  274   * taken to re-instate the settings on resume.
f9b28ccbc arch/arm/common/vic.c     Jamie Iles      2011-09-27  275   *
f9b28ccbc arch/arm/common/vic.c     Jamie Iles      2011-09-27  276   * This also configures the IRQ domain for the VIC.
bb06b7371 arch/arm/common/vic.c     Hartley Sweeten 2010-01-12  277   */
e641b987c drivers/irqchip/irq-vic.c Linus Walleij   2013-11-21  278  static void __init vic_register(void __iomem *base, unsigned int parent_irq,
e641b987c drivers/irqchip/irq-vic.c Linus Walleij   2013-11-21  279  				unsigned int irq,
fa943bed6 arch/arm/common/vic.c     Linus Walleij   2012-04-20  280  				u32 valid_sources, u32 resume_sources,
fa943bed6 arch/arm/common/vic.c     Linus Walleij   2012-04-20  281  				struct device_node *node)
bb06b7371 arch/arm/common/vic.c     Hartley Sweeten 2010-01-12  282  {
bb06b7371 arch/arm/common/vic.c     Hartley Sweeten 2010-01-12  283  	struct vic_device *v;
5ced33bc0 arch/arm/common/vic.c     Linus Walleij   2012-12-26  284  	int i;
bb06b7371 arch/arm/common/vic.c     Hartley Sweeten 2010-01-12  285  
f9b28ccbc arch/arm/common/vic.c     Jamie Iles      2011-09-27  286  	if (vic_id >= ARRAY_SIZE(vic_devices)) {
bb06b7371 arch/arm/common/vic.c     Hartley Sweeten 2010-01-12  287  		printk(KERN_ERR "%s: too few VICs, increase CONFIG_ARM_VIC_NR\n", __func__);
f9b28ccbc arch/arm/common/vic.c     Jamie Iles      2011-09-27  288  		return;
f9b28ccbc arch/arm/common/vic.c     Jamie Iles      2011-09-27  289  	}
f9b28ccbc arch/arm/common/vic.c     Jamie Iles      2011-09-27  290  
bb06b7371 arch/arm/common/vic.c     Hartley Sweeten 2010-01-12  291  	v = &vic_devices[vic_id];
bb06b7371 arch/arm/common/vic.c     Hartley Sweeten 2010-01-12  292  	v->base = base;
ce94df9c0 arch/arm/common/vic.c     Linus Walleij   2012-04-20  293  	v->valid_sources = valid_sources;
bb06b7371 arch/arm/common/vic.c     Hartley Sweeten 2010-01-12  294  	v->resume_sources = resume_sources;
7fb7d8ae1 arch/arm/common/vic.c     Rob Herring     2012-11-20 @295  	set_handle_irq(vic_handle_irq);
bb06b7371 arch/arm/common/vic.c     Hartley Sweeten 2010-01-12  296  	vic_id++;
e641b987c drivers/irqchip/irq-vic.c Linus Walleij   2013-11-21  297  
e641b987c drivers/irqchip/irq-vic.c Linus Walleij   2013-11-21  298  	if (parent_irq) {
9f2135419 drivers/irqchip/irq-vic.c Thomas Gleixner 2015-06-21  299  		irq_set_chained_handler_and_data(parent_irq,
9f2135419 drivers/irqchip/irq-vic.c Thomas Gleixner 2015-06-21  300  						 vic_handle_irq_cascaded, v);
e641b987c drivers/irqchip/irq-vic.c Linus Walleij   2013-11-21  301  	}
e641b987c drivers/irqchip/irq-vic.c Linus Walleij   2013-11-21  302  
07c9249f1 arch/arm/common/vic.c     Linus Walleij   2012-10-16  303  	v->domain = irq_domain_add_simple(node, fls(valid_sources), irq,
fa943bed6 arch/arm/common/vic.c     Linus Walleij   2012-04-20  304  					  &vic_irqdomain_ops, v);
5ced33bc0 arch/arm/common/vic.c     Linus Walleij   2012-12-26  305  	/* create an IRQ mapping for each valid IRQ */
5ced33bc0 arch/arm/common/vic.c     Linus Walleij   2012-12-26  306  	for (i = 0; i < fls(valid_sources); i++)
5ced33bc0 arch/arm/common/vic.c     Linus Walleij   2012-12-26  307  		if (valid_sources & (1 << i))
5ced33bc0 arch/arm/common/vic.c     Linus Walleij   2012-12-26  308  			irq_create_mapping(v->domain, i);
3b4df9dbd drivers/irqchip/irq-vic.c Linus Walleij   2013-11-24  309  	/* If no base IRQ was passed, figure out our allocated base */
3b4df9dbd drivers/irqchip/irq-vic.c Linus Walleij   2013-11-24  310  	if (irq)
3b4df9dbd drivers/irqchip/irq-vic.c Linus Walleij   2013-11-24  311  		v->irq = irq;
3b4df9dbd drivers/irqchip/irq-vic.c Linus Walleij   2013-11-24  312  	else
3b4df9dbd drivers/irqchip/irq-vic.c Linus Walleij   2013-11-24  313  		v->irq = irq_find_mapping(v->domain, 0);
bb06b7371 arch/arm/common/vic.c     Hartley Sweeten 2010-01-12  314  }
bb06b7371 arch/arm/common/vic.c     Hartley Sweeten 2010-01-12  315  

:::::: The code at line 295 was first introduced by commit
:::::: 7fb7d8ae1036f1002fe8b16c15cc26d32046df64 ARM: VIC: set handle_arch_irq in VIC initialization

:::::: TO: Rob Herring <rob.herring@calxeda.com>
:::::: CC: Rob Herring <rob.herring@calxeda.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--sdtB3X0nJg68CQEu
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--sdtB3X0nJg68CQEu--

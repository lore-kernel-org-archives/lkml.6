Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id o/ENOiimG1vUYQAAmS7hNA
	; Sat, 09 Jun 2018 10:04:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DC4E7607A4; Sat,  9 Jun 2018 10:04:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3CBD16032D;
	Sat,  9 Jun 2018 10:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3CBD16032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753119AbeFIKEV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 06:04:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:32792 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751344AbeFIKEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 06:04:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jun 2018 03:04:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,494,1520924400";
   d="scan'208";a="48536708"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga006.jf.intel.com with ESMTP; 09 Jun 2018 03:04:17 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fRajI-000CZs-Hr; Sat, 09 Jun 2018 18:04:16 +0800
Date: Sat, 9 Jun 2018 18:03:45 +0800
From: kbuild test robot <lkp@intel.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: kbuild-all@01.org, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH v3 03/10] PCI: Update xxx_pcie_ep_raise_irq() and
 pci_epc_raise_irq() signatures
Message-ID: <201806091725.uRBp8LOU%fengguang.wu@intel.com>
References: <b4eba65e4ae7b8d15a5770a31d6a339de518cea7.1527862777.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4eba65e4ae7b8d15a5770a31d6a339de518cea7.1527862777.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pci/next]
[also build test WARNING on next-20180608]
[cannot apply to v4.17]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Gustavo-Pimentel/Add-MSI-X-support-on-pcitest-tool/20180609-143316
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/pci/host/pcie-rockchip-ep.c:173:14: sparse: expression using sizeof(void)
>> drivers/pci/host/pcie-rockchip-ep.c:516:27: sparse: incorrect type in initializer (incompatible argument 4 (different type sizes)) @@    expected int ( *raise_irq )( ... ) @@    got int ( *raise_irq )( ... ) @@
   drivers/pci/host/pcie-rockchip-ep.c:516:27:    expected int ( *raise_irq )( ... )
   drivers/pci/host/pcie-rockchip-ep.c:516:27:    got int ( *<noident> )( ... )
   drivers/pci/host/pcie-rockchip-ep.c:516:15: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .raise_irq = rockchip_pcie_ep_raise_irq,
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/host/pcie-rockchip-ep.c:516:15: note: (near initialization for 'rockchip_pcie_epc_ops.raise_irq')
   cc1: some warnings being treated as errors

vim +516 drivers/pci/host/pcie-rockchip-ep.c

cf590b07 Shawn Lin 2018-05-09  507  
cf590b07 Shawn Lin 2018-05-09  508  static const struct pci_epc_ops rockchip_pcie_epc_ops = {
cf590b07 Shawn Lin 2018-05-09  509  	.write_header	= rockchip_pcie_ep_write_header,
cf590b07 Shawn Lin 2018-05-09  510  	.set_bar	= rockchip_pcie_ep_set_bar,
cf590b07 Shawn Lin 2018-05-09  511  	.clear_bar	= rockchip_pcie_ep_clear_bar,
cf590b07 Shawn Lin 2018-05-09  512  	.map_addr	= rockchip_pcie_ep_map_addr,
cf590b07 Shawn Lin 2018-05-09  513  	.unmap_addr	= rockchip_pcie_ep_unmap_addr,
cf590b07 Shawn Lin 2018-05-09  514  	.set_msi	= rockchip_pcie_ep_set_msi,
cf590b07 Shawn Lin 2018-05-09  515  	.get_msi	= rockchip_pcie_ep_get_msi,
cf590b07 Shawn Lin 2018-05-09 @516  	.raise_irq	= rockchip_pcie_ep_raise_irq,
cf590b07 Shawn Lin 2018-05-09  517  	.start		= rockchip_pcie_ep_start,
cf590b07 Shawn Lin 2018-05-09  518  };
cf590b07 Shawn Lin 2018-05-09  519  

:::::: The code at line 516 was first introduced by commit
:::::: cf590b07839133146842d2d3d9a68f804c2edc4b PCI: rockchip: Add EP driver for Rockchip PCIe controller

:::::: TO: Shawn Lin <shawn.lin@rock-chips.com>
:::::: CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

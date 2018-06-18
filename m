Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2C0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584E7208B0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584E7208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936804AbeFRTcj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:32:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:51361 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936401AbeFRTcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:32:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 12:32:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,240,1526367600"; 
   d="scan'208";a="238512533"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jun 2018 12:32:30 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fUzt7-00024x-TI; Tue, 19 Jun 2018 03:32:29 +0800
Date:   Tue, 19 Jun 2018 03:31:41 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     kbuild-all@01.org, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH v4 03/10] PCI: Update xxx_pcie_ep_raise_irq() and
 pci_epc_raise_irq() signatures
Message-ID: <201806190312.UKq0zYJ1%fengguang.wu@intel.com>
References: <5bfa0cf053878e0e859a8b97227ca03ea4d50e92.1529329262.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bfa0cf053878e0e859a8b97227ca03ea4d50e92.1529329262.git.gustavo.pimentel@synopsys.com>
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
[also build test WARNING on v4.18-rc1 next-20180618]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Gustavo-Pimentel/Add-MSI-X-support-on-pcitest-tool/20180619-004625
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/pci/controller/pcie-rockchip-ep.c:173:14: sparse: expression using sizeof(void)
>> drivers/pci/controller/pcie-rockchip-ep.c:516:27: sparse: incorrect type in initializer (incompatible argument 4 (different type sizes)) @@    expected int ( *raise_irq )( ... ) @@    got int ( *raise_irq )( ... ) @@
   drivers/pci/controller/pcie-rockchip-ep.c:516:27:    expected int ( *raise_irq )( ... )
   drivers/pci/controller/pcie-rockchip-ep.c:516:27:    got int ( *<noident> )( ... )
   drivers/pci/controller/pcie-rockchip-ep.c:516:15: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .raise_irq = rockchip_pcie_ep_raise_irq,
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:516:15: note: (near initialization for 'rockchip_pcie_epc_ops.raise_irq')
   cc1: some warnings being treated as errors

vim +516 drivers/pci/controller/pcie-rockchip-ep.c

cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  507  
cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  508  static const struct pci_epc_ops rockchip_pcie_epc_ops = {
cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  509  	.write_header	= rockchip_pcie_ep_write_header,
cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  510  	.set_bar	= rockchip_pcie_ep_set_bar,
cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  511  	.clear_bar	= rockchip_pcie_ep_clear_bar,
cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  512  	.map_addr	= rockchip_pcie_ep_map_addr,
cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  513  	.unmap_addr	= rockchip_pcie_ep_unmap_addr,
cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  514  	.set_msi	= rockchip_pcie_ep_set_msi,
cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  515  	.get_msi	= rockchip_pcie_ep_get_msi,
cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09 @516  	.raise_irq	= rockchip_pcie_ep_raise_irq,
cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  517  	.start		= rockchip_pcie_ep_start,
cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  518  };
cf590b07 drivers/pci/host/pcie-rockchip-ep.c Shawn Lin 2018-05-09  519  

:::::: The code at line 516 was first introduced by commit
:::::: cf590b07839133146842d2d3d9a68f804c2edc4b PCI: rockchip: Add EP driver for Rockchip PCIe controller

:::::: TO: Shawn Lin <shawn.lin@rock-chips.com>
:::::: CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

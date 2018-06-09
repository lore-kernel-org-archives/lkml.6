Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id o9EbKLehG1vIQwAAmS7hNA
	; Sat, 09 Jun 2018 09:45:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 88A90607BB; Sat,  9 Jun 2018 09:45:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 144AF6032D;
	Sat,  9 Jun 2018 09:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 144AF6032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753110AbeFIJpX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 05:45:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:65015 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbeFIJpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 05:45:22 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jun 2018 02:45:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,494,1520924400";
   d="scan'208";a="62627200"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2018 02:45:08 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fRaQl-000I5E-RH; Sat, 09 Jun 2018 17:45:07 +0800
Date: Sat, 9 Jun 2018 17:44:12 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: kbuild-all@01.org, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [RFC PATCH] PCI: dwc: __dw_pcie_ep_find_next_cap() can be static
Message-ID: <20180609094411.GA86347@cairo>
References: <299abe22c35db333dca228a48fdb03ecc662e247.1527862777.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <299abe22c35db333dca228a48fdb03ecc662e247.1527862777.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 797b96a7422e ("PCI: dwc: Add MSI-X callbacks handler")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 pcie-designware-ep.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index c7f2fa9..a498f1f 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -40,8 +40,8 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 	__dw_pcie_ep_reset_bar(pci, bar, 0);
 }
 
-u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
-			      u8 cap)
+static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
+				     u8 cap)
 {
 	u8 cap_id, next_cap_ptr;
 	u16 reg;
@@ -59,7 +59,7 @@ u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
 	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
 }
 
-u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
+static u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
 {
 	u8 next_cap_ptr;
 	u16 reg;

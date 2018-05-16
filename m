Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-354822-1526478585-2-11955493027721175737
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526478584; b=EKIitoOG0ueSD+1suYwdi0/uUIcdDAdO91Db9ub4FsPliDUlRf
    A8ZC7hEiiZr4W3aB35JieJYHMAyEIk9VY8wBwHqif0jc/nxgNv3BIkzx0BRE9oHC
    2Zr5RuJw8aKW8D76HBVFgZy+u3z1cn4Np3Xi1eJoYC2lmoia0Z0Bld9JgaarRAw7
    WBPEPavabxzDTskq5SFZlPKeAjIB+hNvmR3dUSbt1ZfN1WSYiU4VC+rQIuoEr/FN
    EymvwMDRN0pQCUpU0n+1qLXB4zYz6dh4KgD6Ios6iYd+Ajh/u1/FSN0OQzfpIU7a
    dge09A5Mplhgbrq74YxX325PUbuxJINSnTHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526478584; bh=uwdDJDgUhkealtamDePfpSbiCeVxNX
    /u8hAJDZ1ekCQ=; b=a5XZ2a93nGGFo4hFpdn80UyXD94DdpW6UMQ19DYTqBIIgF
    dSb82UgowTskhk4nxAwDSHhoEGRkJd5fOt1XXSnO13S0fOAD4y1jv9i7MvQQx9il
    ZcpG4GAQj57J52HDJHUlnRPtSQWd4fImKVjd0F25hByeEMuFvZssuCynfwWWcdns
    uDN/UjNsF9gEw6lB9iHldvOmRRi7aChsERj/7u/1LDO5d0+ykHfpQK4QgAIZiK+I
    iUHjc2O105UK5poQgA6VK7y/CTB9dVvNm/JhKB0OgV6EAtIU4QrQsVrWiadLyN+X
    uVnfRBmcbvPT7c6Ope4qezFbxiwTvIJAAl/7sX/Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGFlfvnjldLN3HErL4XhxfqrBLYZem2EtrXHSin9W6Tztryw3EzbfvkKamf36dUCRYxPzg5NNEG3WWKiUHX4cbCMSu6fuzke2yPgeqIXPipRzG7JQJ9B
    HtJ0pZ+3gVpbFcKxkOkPyZmROmS78CY8OMi18Go6EyhPCh4KuSMvhmDJFXHnI4Daao7u2kt+LXkbBuLGLNfvx+ixadcvIX6oa0WbGKb9Qnj/2yFiR70xd70c
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=Ikd4Dj_1AAAA:8
    a=VwQbUJbxAAAA:8 a=cZduRTctvJ0_DNFUyd0A:9 a=Pa8YmcNStrnW5nMW:21
    a=ezgwENQog8Z1QlbN:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbeEPNtM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 09:49:12 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13518 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752411AbeEPNtJ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 16 May 2018 09:49:09 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 16 May 2018 06:49:08 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC: <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 3/3] usb: xhci: tegra: Add support for managing powergates
Date: Wed, 16 May 2018 14:48:55 +0100
Message-ID: <1526478535-23760-3-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526478535-23760-1-git-send-email-jonathanh@nvidia.com>
References: <1526478535-23760-1-git-send-email-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Tegra XHCI controller requires that the XUSBA (for superspeed) and
XUSBC (for host) power-domains are enabled. Commit 8df127456f29
("soc/tegra: pmc: Enable XUSB partitions on boot") was added to force
on these power-domains if the XHCI driver is enabled while proper
power-domain support is added, to ensure the device did not hang on
boot. However, rather than forcing on these power-domains in the PMC
driver we can use the legacy Tegra powergate APIs to turn on these
power-domains during the probe of the Tegra XHCI driver.

In the near future we plan to move the Tegra XHCI driver to use the
generic PM domain framework for power-domains and so to prepare for
this only use the legacy Tegra powergate API if there is not PM
domain associated with device (ie. dev.pm_domain is NULL). Please
note that in the future the superspeed and host resets will be handled
by the generic PM domain provider and so these are only these are only
needed in the case where there is no generic PM domain.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---

Changes since V2:
- Add Thierry's ACK

Changes since V1:
- None

 drivers/usb/host/xhci-tegra.c | 68 +++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 437e08010587..c78fc2942bca 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -22,6 +22,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
+#include <soc/tegra/pmc.h>
 
 #include "xhci.h"
 
@@ -974,20 +975,6 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	if (IS_ERR(tegra->padctl))
 		return PTR_ERR(tegra->padctl);
 
-	tegra->host_rst = devm_reset_control_get(&pdev->dev, "xusb_host");
-	if (IS_ERR(tegra->host_rst)) {
-		err = PTR_ERR(tegra->host_rst);
-		dev_err(&pdev->dev, "failed to get xusb_host reset: %d\n", err);
-		goto put_padctl;
-	}
-
-	tegra->ss_rst = devm_reset_control_get(&pdev->dev, "xusb_ss");
-	if (IS_ERR(tegra->ss_rst)) {
-		err = PTR_ERR(tegra->ss_rst);
-		dev_err(&pdev->dev, "failed to get xusb_ss reset: %d\n", err);
-		goto put_padctl;
-	}
-
 	tegra->host_clk = devm_clk_get(&pdev->dev, "xusb_host");
 	if (IS_ERR(tegra->host_clk)) {
 		err = PTR_ERR(tegra->host_clk);
@@ -1051,11 +1038,48 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 		goto put_padctl;
 	}
 
+	if (!pdev->dev.pm_domain) {
+		tegra->host_rst = devm_reset_control_get(&pdev->dev,
+							 "xusb_host");
+		if (IS_ERR(tegra->host_rst)) {
+			err = PTR_ERR(tegra->host_rst);
+			dev_err(&pdev->dev,
+				"failed to get xusb_host reset: %d\n", err);
+			goto put_padctl;
+		}
+
+		tegra->ss_rst = devm_reset_control_get(&pdev->dev, "xusb_ss");
+		if (IS_ERR(tegra->ss_rst)) {
+			err = PTR_ERR(tegra->ss_rst);
+			dev_err(&pdev->dev, "failed to get xusb_ss reset: %d\n",
+				err);
+			goto put_padctl;
+		}
+
+		err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_XUSBA,
+							tegra->ss_clk,
+							tegra->ss_rst);
+		if (err) {
+			dev_err(&pdev->dev,
+				"failed to enable XUSBA domain: %d\n", err);
+			goto put_padctl;
+		}
+
+		err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_XUSBC,
+							tegra->host_clk,
+							tegra->host_rst);
+		if (err) {
+			dev_err(&pdev->dev,
+				"failed to enable XUSBC domain: %d\n", err);
+			goto disable_xusba;
+		}
+	}
+
 	tegra->supplies = devm_kcalloc(&pdev->dev, tegra->soc->num_supplies,
 				       sizeof(*tegra->supplies), GFP_KERNEL);
 	if (!tegra->supplies) {
 		err = -ENOMEM;
-		goto put_padctl;
+		goto disable_xusbc;
 	}
 
 	for (i = 0; i < tegra->soc->num_supplies; i++)
@@ -1065,7 +1089,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 				      tegra->supplies);
 	if (err) {
 		dev_err(&pdev->dev, "failed to get regulators: %d\n", err);
-		goto put_padctl;
+		goto disable_xusbc;
 	}
 
 	for (i = 0; i < tegra->soc->num_types; i++)
@@ -1075,7 +1099,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 				   sizeof(*tegra->phys), GFP_KERNEL);
 	if (!tegra->phys) {
 		err = -ENOMEM;
-		goto put_padctl;
+		goto disable_xusbc;
 	}
 
 	for (i = 0, k = 0; i < tegra->soc->num_types; i++) {
@@ -1091,7 +1115,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 					"failed to get PHY %s: %ld\n", prop,
 					PTR_ERR(phy));
 				err = PTR_ERR(phy);
-				goto put_padctl;
+				goto disable_xusbc;
 			}
 
 			tegra->phys[k++] = phy;
@@ -1102,7 +1126,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 				    dev_name(&pdev->dev));
 	if (!tegra->hcd) {
 		err = -ENOMEM;
-		goto put_padctl;
+		goto disable_xusbc;
 	}
 
 	/*
@@ -1198,6 +1222,12 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 disable_rpm:
 	pm_runtime_disable(&pdev->dev);
 	usb_put_hcd(tegra->hcd);
+disable_xusbc:
+	if (!&pdev->dev.pm_domain)
+		tegra_powergate_power_off(TEGRA_POWERGATE_XUSBC);
+disable_xusba:
+	if (!&pdev->dev.pm_domain)
+		tegra_powergate_power_off(TEGRA_POWERGATE_XUSBA);
 put_padctl:
 	tegra_xusb_padctl_put(tegra->padctl);
 	return err;
-- 
2.7.4


Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABDEECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EFA20874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIzzHVyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6EFA20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbeGWVGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:06:36 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39050 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387981AbeGWVGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:06:35 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so3397393oib.6;
        Mon, 23 Jul 2018 13:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mVN0/KosooXiwnBfEZP8VXUV6p1hNHyEazqP/6AlWtg=;
        b=rIzzHVyM/0bH9r1us+snWneP7TVtJFRHxr/9UsxrY2r19diLFL/zUAVqpdnZwalFy9
         3kd1walttxXIO9VGOl4aWS92Z/l3F1a5pmYVJ8YyOROV813aqEgYmwVfAkI5Drd+uId4
         x90VBv2ue9n1zxyiSHTJ6moPLl8vt3/b1tpcBjSPdAP5ukOi2w0ltQhxiRMLEgn9rdGV
         RfZO9ypU3CxFK5zg0hRQ+PrC+fISgkm7Yq6Cbduvh05aYZMP3a6L6fs3J2MEGoZsHIaA
         8s/niPhj44k6B2yuFJt9/9KEJo8t5Bi6n1+UUBSuYOVrtC06VQ0FZf3DqQkSt0F3RoHW
         Shtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mVN0/KosooXiwnBfEZP8VXUV6p1hNHyEazqP/6AlWtg=;
        b=H2lliqou3JMxwowZNK7gvbNGuOvGPYue39CVSOTsqxEr6K/7jo6q4fKT5OgEBCCyN0
         o/Cvz6Tfito+O8CfwoH+eE1wFfOJag+E5lyql8BLZpB1hn9dh8PLED3Qs/a4dG1BpJrZ
         A/3GzU5v2qAAChO6JutwfQHAeuz9f9kUWLRkyQ+LHWeyVzPckT7VHTshmDslIo4zMckf
         9xSPE5hsa6pUc7H1sEjcIGlz0L7HYO9A8GA0+M4rPrBH4aIoVhAil6Y8L5fjXEU60U6I
         bgxnqP3TvH5AZb/Ob1oqSGpfh1QJowmnX0sGztCTk3JPli3ePflYMTIL7maA6BWAb69V
         yFfg==
X-Gm-Message-State: AOUpUlEo/uIBXTMnCIYw5dxJxv8+RJ4Puw9VheG2uwc3WipQQ9lOpHzY
        1Xjoo8/qcLsTnM/ZBsOK19xBIbRdD2c=
X-Google-Smtp-Source: AAOMgpe9X3W0A9lV9YUyKObkEQD0xYWL3tdUKjmO8wbLXktXjv56GVA9gdiK14+ZX36uBBAw6TCBGw==
X-Received: by 2002:aca:190d:: with SMTP id l13-v6mr274168oii.216.1532376227492;
        Mon, 23 Jul 2018 13:03:47 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id n84-v6sm7530409oif.23.2018.07.23.13.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 13:03:46 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        jeffrey.t.kirsher@intel.com, ariel.elior@cavium.com,
        michael.chan@broadcom.com, ganeshgr@chelsio.com,
        tariqt@mellanox.com, jakub.kicinski@netronome.com,
        airlied@gmail.com, alexander.deucher@amd.com,
        mike.marciniszyn@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] PCI: Check for PCIe downtraining conditions
Date:   Mon, 23 Jul 2018 15:03:38 -0500
Message-Id: <20180723200339.23943-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
References: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCIe downtraining happens when both the device and PCIe port are
capable of a larger bus width or higher speed than negotiated.
Downtraining might be indicative of other problems in the system, and
identifying this from userspace is neither intuitive, nor
straightforward.

The easiest way to detect this is with pcie_print_link_status(),
since the bottleneck is usually the link that is downtrained. It's not
a perfect solution, but it works extremely well in most cases.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---

For the sake of review, I've created a __pcie_print_link_status() which
takes a 'verbose' argument. If we agree want to go this route, and update
the users of pcie_print_link_status(), I can split this up in two patches.
I prefer just printing this information in the core functions, and letting
drivers not have to worry about this. Though there seems to be strong for
not going that route, so here it goes:

Changes since v4:
 - Use 'verbose' argumnet to print bandwidth under normal conditions
 - Without verbose, only downtraining conditions are reported

Changes since v3:
 - Remove extra newline and parentheses.

Changes since v2:
 - Check dev->is_virtfn flag

Changes since v1:
 - Use pcie_print_link_status() instead of reimplementing logic

 drivers/pci/pci.c   | 22 ++++++++++++++++++----
 drivers/pci/probe.c | 21 +++++++++++++++++++++
 include/linux/pci.h |  1 +
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 316496e99da9..414ad7b3abdb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5302,14 +5302,15 @@ u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
 }
 
 /**
- * pcie_print_link_status - Report the PCI device's link speed and width
+ * __pcie_print_link_status - Report the PCI device's link speed and width
  * @dev: PCI device to query
+ * @verbose: Be verbose -- print info even when enough bandwidth is available.
  *
  * Report the available bandwidth at the device.  If this is less than the
  * device is capable of, report the device's maximum possible bandwidth and
  * the upstream link that limits its performance to less than that.
  */
-void pcie_print_link_status(struct pci_dev *dev)
+void __pcie_print_link_status(struct pci_dev *dev, bool verbose)
 {
 	enum pcie_link_width width, width_cap;
 	enum pci_bus_speed speed, speed_cap;
@@ -5319,11 +5320,11 @@ void pcie_print_link_status(struct pci_dev *dev)
 	bw_cap = pcie_bandwidth_capable(dev, &speed_cap, &width_cap);
 	bw_avail = pcie_bandwidth_available(dev, &limiting_dev, &speed, &width);
 
-	if (bw_avail >= bw_cap)
+	if (bw_avail >= bw_cap && verbose)
 		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)\n",
 			 bw_cap / 1000, bw_cap % 1000,
 			 PCIE_SPEED2STR(speed_cap), width_cap);
-	else
+	else if (bw_avail < bw_cap)
 		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)\n",
 			 bw_avail / 1000, bw_avail % 1000,
 			 PCIE_SPEED2STR(speed), width,
@@ -5331,6 +5332,19 @@ void pcie_print_link_status(struct pci_dev *dev)
 			 bw_cap / 1000, bw_cap % 1000,
 			 PCIE_SPEED2STR(speed_cap), width_cap);
 }
+
+/**
+ * pcie_print_link_status - Report the PCI device's link speed and width
+ * @dev: PCI device to query
+ *
+ * Report the available bandwidth at the device.  If this is less than the
+ * device is capable of, report the device's maximum possible bandwidth and
+ * the upstream link that limits its performance to less than that.
+ */
+void pcie_print_link_status(struct pci_dev *dev)
+{
+	__pcie_print_link_status(dev, true);
+}
 EXPORT_SYMBOL(pcie_print_link_status);
 
 /**
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac876e32de4b..1f7336377c3b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2205,6 +2205,24 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	return dev;
 }
 
+static void pcie_check_upstream_link(struct pci_dev *dev)
+{
+	if (!pci_is_pcie(dev))
+		return;
+
+	/* Look from the device up to avoid downstream ports with no devices. */
+	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT) &&
+	    (pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END) &&
+	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM))
+		return;
+
+	/* Multi-function PCIe share the same link/status. */
+	if (PCI_FUNC(dev->devfn) != 0 || dev->is_virtfn)
+		return;
+
+	__pcie_print_link_status(dev, false);
+}
+
 static void pci_init_capabilities(struct pci_dev *dev)
 {
 	/* Enhanced Allocation */
@@ -2240,6 +2258,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	/* Advanced Error Reporting */
 	pci_aer_init(dev);
 
+	/* Check link and detect downtrain errors */
+	pcie_check_upstream_link(dev);
+
 	if (pci_probe_reset_function(dev) == 0)
 		dev->reset_fn = 1;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index abd5d5e17aee..15bfab8f7a1b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1088,6 +1088,7 @@ int pcie_set_mps(struct pci_dev *dev, int mps);
 u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width);
+void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
 void pcie_print_link_status(struct pci_dev *dev);
 int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
-- 
2.17.1


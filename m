Return-Path: <linux-pci-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1780358-1528127737-2-16999716145692539943
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-pci-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127737; b=MEgV1h+cDXbV//uhvrVSUXRbErVpRryQtUMM6Zm2Y8pxe8TSar
    J2qoBD2GXpsKrNwlHyg32aqwVbNCUprikMGvWeTbP1bmT9YXrve+Yx8SPmB6Xwac
    8tNT8vqarxmzFKJqclj+xPZjAQzfb7YV/cEpc65oeSS83UkGxn0X9HtA1Y2NsKjD
    1fx3gI7T0fz7yXGtqtnC9R/LxQYXFT2rldIFQnUkpbc+SpZz2XroipZSrS5SBbC8
    m5xAlA6XYanrsWLdMjyHI9YTau3ET4WyECNz6JLK2jInGaFFrjGiZDNh27wLSsSy
    Y8Ii37R9LRaFTuBxaSPHAZlvnfZoPcfVM/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1528127737; bh=g9HeAxMVD2uQc2pxHBTrHkPYrMDEGd
    ejU+hvT5c5IVA=; b=OQYY5E/HyN/rDxQS2cRgQYdYhEfl9cKjPTyNrgvdKIydXZ
    AS7/m2JYg2hSe2VujBEWIIYEnBwIkXW5bA1pppldq1oG1MnP28OM4ooE3Rt6rHDd
    FxpG4Kzadb0x0ulxQkfbkfwxjZZzoly/WEDGs2DIQxWfhoV/3D476LaHEhhtbLOk
    iO/g3noFI+cuwR+nNgmhudi8xZV5xA5msNWQr6POwd85SMeNSTpfogVCfoGfjSjg
    snDbeAe/ImUR8GFHNC6Lm3BQp5rARGUlaEkhg/Fv8CV2Dji5qyVydNscKj++/RdF
    lXWg3hGUzQw2gdGtLwRSv4eVe4Zx6HzP9PonImMA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=abVk2I3L header.a=rsa-sha256
    header.s=20161025 x-bits=2048;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=Urxyyhw9;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=abVk2I3L header.a=rsa-sha256
      header.s=20161025 x-bits=2048;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=Urxyyhw9;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfONZR/hUsy2JIGJSNWMRZqQP2GQKynHViAZTbX8S+AjvkBQAXlYS+tCDa1bFzaSblbWHtmuZD8zFXkqhL4rgGR+M2u9vXKIlgf/v2gmHPfY1tS9d9TMm
    Zd7tEWOG6SQE8MoKeocaDTn3GpqFkBqJWkn5iANl19Ik58kkZ/zyal44eBJfllLZVpBKBc218ehLbTIf/V7lgMG3YEwhHJyR/XX1OMxGAmqRYz/6QzVQHehI
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=HD7KMnkBrDkA:10
    a=7mUfYlMuFuIA:10 a=pGLkceISAAAA:8 a=U2JvRWriFFnih6HN0y8A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeFDPzc (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:55:32 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39899 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeFDPzb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jun 2018 11:55:31 -0400
X-Google-Smtp-Source: ADUXVKLvKfCZDsWEfwCJBB0dh3okyiJHvvWxNL+0NvEGa1sC723hb0rrT6j8nG7ym9Z1ZAQxxnsTrg==
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: bhelgaas@google.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI: Check for PCIe downtraining conditions
Date: Mon,  4 Jun 2018 10:55:21 -0500
Message-Id: <20180604155523.14906-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-pci-owner@vger.kernel.org
X-Mailing-List: linux-pci@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PCIe downtraining happens when both the device and PCIe port are
capable of a larger bus width or higher speed than negotiated.
Downtraining might be indicative of other problems in the system, and
identifying this from userspace is neither intuitive, nor straigh
forward.

The easiest way to detect this is with pcie_print_link_status(),
since the bottleneck is usually the link that is downtrained. It's not
a perfect solution, but it works extremely well in most cases.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---

Changes since v2:
 - Check dev->is_virtfn flag

Changes since v1:
 - Use pcie_print_link_status() instead of reimplementing logic
 
 drivers/pci/probe.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac91b6fd0bcd..a88ec8c25dd5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2146,6 +2146,25 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	return dev;
 }
 
+static void pcie_check_upstream_link(struct pci_dev *dev)
+{
+
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
+	if ((PCI_FUNC(dev->devfn) != 0) || dev->is_virtfn)
+		return;
+
+	pcie_print_link_status(dev);
+}
+
 static void pci_init_capabilities(struct pci_dev *dev)
 {
 	/* Enhanced Allocation */
@@ -2181,6 +2200,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	/* Advanced Error Reporting */
 	pci_aer_init(dev);
 
+	/* Check link and detect downtrain errors */
+	pcie_check_upstream_link(dev);
+
 	if (pci_probe_reset_function(dev) == 0)
 		dev->reset_fn = 1;
 }
-- 
2.14.4

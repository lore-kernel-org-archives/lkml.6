Return-Path: <linux-pci-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1780358-1528127295-2-14147433489939389992
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-pci-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127294; b=D2iLO1Jar187qHY1W0LyTMDz3chCpQP0PaAaxpe5FrRsKmEApt
    l8a4Oit4yNLCoUC1ukQcayIWdKDccgHAgYScENkOGAtd+7uUGMIHcvPN5VUBokLA
    fMW1bOj/A8RMi/Mb7v7oLjAhF+7C+CZWJ2vKjx7e87a8DD9bbDKcrZjhg1SfOLY5
    BmD+n3jSQqiM3TAoo+xsREvu94iAZGjhu7AsnUHqcLdti+lLjD0yCAUuvFsDX2bU
    IND/qIdelDRf4UBaFXcYpm/5ZDL2SH5XowqACC0biAL+8mWlusvojpbhqPvWjAmU
    r8cdk/gV5By1EGx5R0DYoMRrramyUm+4Pjfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1528127294; bh=CXBosUokYaNnzSkufrEzxL6wgvi2yS
    lEAZ4FjJdGx5A=; b=QG2h2+95oLl6/e3+b9Vv6UnyurrlnAEJBEu6P+13WlPweG
    jLjPi6WVN2E6P/HNnKAxH7hfHnx13rxR3VTY15Uf0ltION7yXO3GmS2W/2e5Yp7e
    ZFU6BZyk+J/4hSR5BN/P9Mju9gnxJa2CR4+oadRM1IcifQSv9vtLxq19FdSV1LZ9
    W2P3nwB2Kir2sPxuldrWxJvm4Gkbs/ipnPt2xx1F/I5alvO/emarP0rOjsnTAf9c
    JhbLqt7uorquLUqPo6PN2XYvvO++pHGSLBQ85RkOfOQjj/rDheggd0J8hLjR/pNs
    oarh6pexhF2QzoYmhfG9CuSQIGr+b/utVg5xrWiw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=MQohb+yV header.a=rsa-sha256
    header.s=20161025 x-bits=2048;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=K9cJYdVa;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=MQohb+yV header.a=rsa-sha256
      header.s=20161025 x-bits=2048;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=K9cJYdVa;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLtKQheaw+mt80sgQhgZr596NdDDk4Fzt9Z/M1leTEyh7sxwsTJYCMbjFA2LlUA0OVZ8+ZzMKyLaK0WLbwnOnch4ynWry2xMjpfYLfINUMxk2nIANPHF
    hplUQKlrVAkQMY5PoNKD74g2744+Z5FEoxsAtmna8g/G7QrsRgyTyniZtXhaRT3QinFOtudnGAjKHNhTVxzRv8Fg5hxLkFv0mSJFn7DrgYFNNsBK872xmxMW
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=HD7KMnkBrDkA:10
    a=7mUfYlMuFuIA:10 a=pGLkceISAAAA:8 a=sNAnwfNFpWtAJGtwpmwA:9 a=WuClQknjDRsA:10
    a=8yXnmOKr1-5_0tuTD5Oj:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750934AbeFDPsM (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:48:12 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36902 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeFDPsL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jun 2018 11:48:11 -0400
X-Google-Smtp-Source: ADUXVKIZIzV2Jg8SBGEluJZSxFqu/6Lqqc9nH9Swe1a2lFMDcEqq9k4e12ytBQub+NA4bfD4UIRBZw==
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: bhelgaas@google.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: access.c: Piggyback user config access on pci_read/write_*()
Date: Mon,  4 Jun 2018 10:48:02 -0500
Message-Id: <20180604154803.14185-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-pci-owner@vger.kernel.org
X-Mailing-List: linux-pci@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

pci_read/write_config*() functions have several safeguards to prevent
stallling accesses when a device is removed. However, their "_user_"
counterparts use a different code path.

To make sure that safeguards are used for userspace PCI config
accesses, piggyback the "_user_" functions on the in-kernel
pci_read/write_config*().

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/access.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index a3ad2fe185b9..6db2a8713c85 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -223,16 +223,9 @@ int pci_user_read_config_##size						\
 	(struct pci_dev *dev, int pos, type *val)			\
 {									\
 	int ret = PCIBIOS_SUCCESSFUL;					\
-	u32 data = -1;							\
 	if (PCI_##size##_BAD)						\
 		return -EINVAL;						\
-	raw_spin_lock_irq(&pci_lock);				\
-	if (unlikely(dev->block_cfg_access))				\
-		pci_wait_cfg(dev);					\
-	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
-					pos, sizeof(type), &data);	\
-	raw_spin_unlock_irq(&pci_lock);				\
-	*val = (type)data;						\
+	ret = pci_read_config_##size(dev, pos, val);			\
 	return pcibios_err_to_errno(ret);				\
 }									\
 EXPORT_SYMBOL_GPL(pci_user_read_config_##size);
@@ -245,12 +238,7 @@ int pci_user_write_config_##size					\
 	int ret = PCIBIOS_SUCCESSFUL;					\
 	if (PCI_##size##_BAD)						\
 		return -EINVAL;						\
-	raw_spin_lock_irq(&pci_lock);				\
-	if (unlikely(dev->block_cfg_access))				\
-		pci_wait_cfg(dev);					\
-	ret = dev->bus->ops->write(dev->bus, dev->devfn,		\
-					pos, sizeof(type), val);	\
-	raw_spin_unlock_irq(&pci_lock);				\
+	ret = pci_write_config_##size(dev, pos, val);			\
 	return pcibios_err_to_errno(ret);				\
 }									\
 EXPORT_SYMBOL_GPL(pci_user_write_config_##size);
-- 
2.14.4

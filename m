Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02DCC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B40820844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQ0DPMso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B40820844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbeGYVGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729335AbeGYVGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:06:06 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCB9B20844;
        Wed, 25 Jul 2018 19:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532548376;
        bh=/aPUN7dGCiiRCkrX4auV3MW/MqwTvplIrO/rzaIwrx0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WQ0DPMsop4zvYvmmzZ0TWCJYbUbX2hE6VQd4I6FVqOmkgFuk0OHRjIPQ+9qH1+HWi
         yZ2HUF5b1aO65q+3y77CViL/JjqffE+PScgufp40BPdjyAR33wWneSSC2MWuDN4IoQ
         NA4IEikKk15JJTf2yVa4qMp1ACV2VVk01pMl1tcw=
Subject: [PATCH v1 4/4] PCI: Remove unnecessary include of <linux/pci-aspm.h>
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        ath9k-devel@qca.qualcomm.com, linuxwifi@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Date:   Wed, 25 Jul 2018 14:52:54 -0500
Message-ID: <153254837478.92573.14742111987549518973.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Several PCI core files include pci-aspm.h even though they don't need
anything provided by that file.  Remove the unnecessary includes of it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-sysfs.c |    1 -
 drivers/pci/pci.c       |    1 -
 drivers/pci/probe.c     |    1 -
 drivers/pci/remove.c    |    1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 0c4653c1d2ce..91337faae60d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -23,7 +23,6 @@
 #include <linux/fs.h>
 #include <linux/capability.h>
 #include <linux/security.h>
-#include <linux/pci-aspm.h>
 #include <linux/slab.h>
 #include <linux/vgaarb.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f5c6ab14fb31..7c2f0e682fc0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -23,7 +23,6 @@
 #include <linux/string.h>
 #include <linux/log2.h>
 #include <linux/logic_pio.h>
-#include <linux/pci-aspm.h>
 #include <linux/pm_wakeup.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac876e32de4b..1ed2852dee21 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/cpumask.h>
-#include <linux/pci-aspm.h>
 #include <linux/aer.h>
 #include <linux/acpi.h>
 #include <linux/hypervisor.h>
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 6f072eae4f7a..01ec7fcb5634 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pci.h>
 #include <linux/module.h>
-#include <linux/pci-aspm.h>
 #include "pci.h"
 
 static void pci_free_resources(struct pci_dev *dev)


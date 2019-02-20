Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35F2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F7721773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X3XX+67r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfBTQeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:34:17 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41441 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfBTQeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:34:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id m1so12102901pgq.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bJTqQVyPqTRoZmzEJxDokZKH2fjNCLF3wrzuRLWaY7o=;
        b=X3XX+67reBKkrMvXlNfWVFEU+fnIh7nMlqCJx3q+OCq+BwKowbHjaL3mPaFV5NP3bg
         DMu9VViwbDfzjm0K9RyV8zhs2vzVHgPodYEG4L+14ss9ZE1bm+Hj5h3pZxBeLx4GwuKN
         xaqTKHoXLOaCrUjYAeeENs32xVXdYhLRhubt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bJTqQVyPqTRoZmzEJxDokZKH2fjNCLF3wrzuRLWaY7o=;
        b=FjHFZwTWno18xTz096Klf3K6V77ewaGeiCINKRMFrEuC+ispNSfBA/U4+0flz3VTWC
         OMv0PiTDGY46E3KDfQyYVLqams3a6whVOUSHTpYXKTV/LSzxH+q5KCtM7sJQG/NcPl/v
         MZDBTGxxOgBneD59RW8uOYfujToMvy2758J2lu5LfIGIoeWGz7qMUhiLcFXiN5D8U0tk
         5LtxWeDUXRFE51HH9xUVjo0g4MDgDDrz38jmj0oP2Bo9b6Yfxy7t90/4IZzSQJVk/hMk
         lqC5i3P3OAecCiLOwhge2N0keIbvwm2plZHi87j4cpTw8GvkbtbdEkuCyxcHusdBlVRx
         Hn9A==
X-Gm-Message-State: AHQUAua8Re1jXS2BbBD87G09B98NXohz0ZqFrcM0qgjCdtoKdCNtzxX5
        KgJ1F2/5tswswvfe9pkd1Qo+cg==
X-Google-Smtp-Source: AHgI3IbWdOKn2kPVyPQZugoB9bJ8zsTbbKF6MSd1O++9KKKnaBS5MqwvPTgfHSG4QW1d4pK61uQzPQ==
X-Received: by 2002:a62:76d4:: with SMTP id r203mr36036679pfc.15.1550680454764;
        Wed, 20 Feb 2019 08:34:14 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t10sm26556717pfa.151.2019.02.20.08.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Feb 2019 08:34:14 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v3 2/2] PCI: iproc: Add outbound configuration for 32-bit I/O region
Date:   Wed, 20 Feb 2019 22:03:55 +0530
Message-Id: <1550680435-9706-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550680435-9706-1-git-send-email-srinath.mannam@broadcom.com>
References: <1550680435-9706-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the present driver outbound window configuration is done to map above
32-bit address I/O regions with corresponding PCI memory range given in
ranges DT property.

This patch add outbound window configuration to map below 32-bit I/O range
with corresponding PCI memory, which helps to access I/O region in IA32
and one to one mapping of I/O region to PCI memory.

Ex:
1. ranges DT property given for current driver is,
    ranges = <0x83000000 0x0 0x40000000 0x4 0x00000000 0 0x40000000>;
    I/O region address is 0x400000000
2. ranges DT property can be given after this patch,
    ranges = <0x83000000 0x0 0x42000000 0x0 0x42000000 0 0x2000000>;
    I/O region address is 0x42000000

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index b882255..080f142 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -955,8 +955,25 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
 			resource_size_t window_size =
 				ob_map->window_sizes[size_idx] * SZ_1M;
 
-			if (size < window_size)
-				continue;
+			/*
+			 * Keep iterating until we reach the last window and
+			 * with the minimal window size at index zero. In this
+			 * case, we take a compromise by mapping it using the
+			 * minimum window size that can be supported
+			 */
+			if (size < window_size) {
+				if (size_idx > 0 || window_idx > 0)
+					continue;
+
+				/*
+				 * For the corner case of reaching the minimal
+				 * window size that can be supported on the
+				 * last window
+				 */
+				axi_addr = ALIGN_DOWN(axi_addr, window_size);
+				pci_addr = ALIGN_DOWN(pci_addr, window_size);
+				size = window_size;
+			}
 
 			if (!IS_ALIGNED(axi_addr, window_size) ||
 			    !IS_ALIGNED(pci_addr, window_size)) {
-- 
2.7.4


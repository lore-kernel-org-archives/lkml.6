Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527F7C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068E224768
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMv1gMnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068E224768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752937AbeGCX2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:28:10 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43220 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeGCX2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:28:08 -0400
Received: by mail-oi0-f67.google.com with SMTP id b15-v6so7181605oib.10;
        Tue, 03 Jul 2018 16:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3MLlY4v8zjkPfZkn7Vfcx7aDErmyDIu9y+ikWj4Q3hc=;
        b=ZMv1gMnPtMN5uIZHZAiMbfD4ijorFnXKSHcWJ6HY4aYhJqb34BSw8RiYs05MEapY/M
         rkP8zwoRtrzU227elEhVQW52MRos5K2EtGmYWeJTy6XOV+aRrx051AGsq1T4uMX7IxxM
         HZ7V4Oi+Ym+to7VCpevEwD5X1ASOXs9LOhEHI4tPeEhs5Dmp4tAs0l35mAZ43KeFGtUs
         ONy8agLnqVJ38mLH5nwUXSkWBYZcjosBgXhMppev+2X7i54pS6aONwiVlMwcGkKREM0Z
         EItdO04RVk3ibRnK7gj/5TlLFCtCouzEwjLC2bA/v+XdBx3QZpjrk1nTZ9mbssz3i9Gy
         BV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3MLlY4v8zjkPfZkn7Vfcx7aDErmyDIu9y+ikWj4Q3hc=;
        b=RSzhrny9eCqhn2+DgW0EPUopuNIALFXbhTKV7Bt48Q0Xu4fNU6id4WrHSAbndaCfrT
         aHglZb72wW9URN8tg4CkAmF4Tiw4upcu9obxwjAeS5zuPH0cezrSH9aehPdDfCXUCJ8x
         C+33PXYdR6Ph/tnQPlqksMDZd21Rd2V6iDtU7fTYnNXvJpa2Ih2Hc81r4y7c8vRrPAxJ
         eVHmeuPnVzWg0QvbvMFC4L8FiSH+HZwrvw1yV9zRPZP3KFbjEh7WWU3Feey7egIwoyX0
         TCZYhAvmotfbZd3zh43tQgnsF4TF562OYepwxS9IvaAG5B/+YDw6Yoo5UjjnwqXg2VTx
         vjBQ==
X-Gm-Message-State: APt69E2xJstISpEJnBlnk9HnUF0p1xC94aaTHn/i4n7mN60gnFjw53P4
        Nub2t09lTUssNledjDb3P4I=
X-Google-Smtp-Source: AAOMgpd5DKMaizmcOvhcNegFoqR2n2P6XaSFKe6fow65PtOKuZd01LAh81D4I6P0qE40URNwAHlEHg==
X-Received: by 2002:aca:3f57:: with SMTP id m84-v6mr21469625oia.280.1530660487800;
        Tue, 03 Jul 2018 16:28:07 -0700 (PDT)
Received: from nuclearis2_1.lan (c-98-201-114-184.hsd1.tx.comcast.net. [98.201.114.184])
        by smtp.gmail.com with ESMTPSA id l188-v6sm1037501oia.56.2018.07.03.16.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 16:28:07 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com, keith.busch@intel.com
Cc:     alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] PCI/AER: Fix aerdrv loading with "pcie_ports=native" parameter
Date:   Tue,  3 Jul 2018 18:27:43 -0500
Message-Id: <20180703232755.2472-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180703163854.GA61685@bhelgaas-glaptop.roam.corp.google.com>
References: <20180703163854.GA61685@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the documentation, "pcie_ports=native", linux should use
native AER and DPC services. While that is true for the _OSC method
parsing, this is not the only place that is checked. Should the HEST
table list PCIe ports as firmware-first, linux will not use native
services.

This happens because aer_acpi_firmware_first() doesn't take
'pcie_ports' into account. This is wrong. DPC uses the same logic when
it decides whether to load or not, so fixing this also fixes DPC not
loading.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pcie/aer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e88386af28..63a66a3b2fb5 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -303,6 +303,9 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return 0;
 
+	if (pcie_ports_native)
+		return 0;
+
 	if (!dev->__aer_firmware_first_valid)
 		aer_set_firmware_first(dev);
 	return dev->__aer_firmware_first;
@@ -323,6 +326,9 @@ bool aer_acpi_firmware_first(void)
 		.firmware_first	= 0,
 	};
 
+	if (pcie_ports_native)
+		return 0;
+
 	if (!parsed) {
 		apei_hest_parse(aer_hest_parse, &info);
 		aer_firmware_first = info.firmware_first;
-- 
2.14.3


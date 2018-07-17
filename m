Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF6BECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98E020877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km16vpuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98E020877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbeGQQFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:05:07 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42966 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729657AbeGQQFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:05:06 -0400
Received: by mail-oi0-f65.google.com with SMTP id n84-v6so2798585oib.9;
        Tue, 17 Jul 2018 08:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xrsanRdLjNaIa5W58QfGTnIblsjPmqFD0nL3D5ylARg=;
        b=km16vpuWyMrdXwEgRXeq5qDA88P7zGjejI6ZynWbHF7OlLDdTK6qbK1HJzpeDt3E3x
         jV0yRH2rsIrgho6ogt7sP1kx+Q5ygMd8JPZ6B3M67zBXf441TLp2yxeQIXuaTPouawPa
         XO2RfiD+kMOLz32HNf91QkgBUiASActxpp51xMLz5AbMDuLErD0YfleIchGhNqAANxy3
         fncf9v/xiM9YIzpy28iXb6/hwz2D6Ewg8uwN7TLLweLPGj5W6AEX/vR2mI+O5sqUgJEX
         Ls3/F9SP76AEFmajJieOxnRCGDmN3oAC2erU2jJbmv2T2cjPZ+TUIfqsr7rpFGN432NS
         yQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xrsanRdLjNaIa5W58QfGTnIblsjPmqFD0nL3D5ylARg=;
        b=jDsAXFVHKF2ut07DYxxO0M8bSvnOtwXAstlhfO9oBL5BWimsVyqsgsqK7H1xB7TODn
         17E/qmT0SSkue0CRZQgM3wNo6+gWV29OORvv3AOjTKllMVRzZA7aIgjnESiRDAdDAWSe
         Xep18Lam2rd+Yqes2HdyH3jtRVbQKK1MJRU5gmiDRh6endAygjSCG7gigzVuchm6LLa+
         65V9eOCO/3rh2+esp3rTduzTLk7P+EcFWWevoCfzB52TNUIivc4cgQGax7DNjHwiuW+n
         QlaQyPCa2UCiNQzilOStFW6ruay+YCHyCtALJIoAZf6nG4HcRSMH6pClib6oDvBdkGcW
         e+0w==
X-Gm-Message-State: AOUpUlGx8oN/qK+1Dym6A+TtpuGIbufS1sytDid+Jac4DnJof+P9Izjv
        nLUCD8wq7yaWJdx5agVDduw=
X-Google-Smtp-Source: AAOMgpcJITbaRwMdIWC1HqWEORoWdESRpHVKFsmGxPk6sg3qlyvPmqy8vMLHo11ejbj1BXUV9edz5w==
X-Received: by 2002:aca:5bd5:: with SMTP id p204-v6mr2293879oib.91.1531841515901;
        Tue, 17 Jul 2018 08:31:55 -0700 (PDT)
Received: from nuclearis2_1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id a14-v6sm1819595oih.54.2018.07.17.08.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:31:55 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com, keith.busch@intel.com
Cc:     alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/AER: Do not clear AER bits if we don't own AER
Date:   Tue, 17 Jul 2018 10:31:23 -0500
Message-Id: <20180717153135.25925-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we don't own AER, we shouldn't touch the AER error bits. This
happens unconditionally on device probe(). Clearing AER bits
willy-nilly might cause firmware to miss errors. Instead
these bits should get cleared by FFS, or via ACPI _HPX method.

This race is mostly of theoretical significance, as it is not easy to
reasonably demonstrate it in testing.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pcie/aer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e88386af28..18037a2a8231 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -383,6 +383,9 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return -ENODEV;
 
+	if (pcie_aer_get_firmware_first(dev))
+		return -EIO;
+
 	pos = dev->aer_cap;
 	if (!pos)
 		return -EIO;
-- 
2.14.3


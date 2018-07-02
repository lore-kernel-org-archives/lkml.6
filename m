Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3646C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABC823DD7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMWnkjnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABC823DD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeGBQQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:16:22 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54219 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeGBQQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:16:20 -0400
Received: by mail-it0-f65.google.com with SMTP id a195-v6so12880015itd.3;
        Mon, 02 Jul 2018 09:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5rEpnULY8+b8WrkyLdPVDl/tma+nLZwVk04sUPAfu0s=;
        b=vMWnkjnRCX2GWD0pmRsYroNVRaGgMAxwxW2LLR53fh8qfHMePd2+/Wsfjjqrzcnw/a
         Fu/+sXOlq1UA/Ztj04nicpWpzhPM7/y2W8tpg65ggfj15b1JRHydpsWAmff1Gz518FNo
         41BkI895as7tUW0i9myIJ1G5Woxam5gX9ksJTyiFEgRm0Zz4zjJ41NEktgdXMvOajeMY
         SHGNbNzp1yJhrlaNgu+5PeFXLCMEEUOPudk4crjC0xielVzhSapNlOvVoBRxEkRDMMhM
         gYxaraLAjI3j6YIJ5VV9FpclKgWNrzXSS4HQGTUFUzJ14OcI6EP7Uk+5gIInYdL3JxsX
         koew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5rEpnULY8+b8WrkyLdPVDl/tma+nLZwVk04sUPAfu0s=;
        b=an2tex6IvnrCIjY1rW0hL5FqOE7q0GDXHrf+j6UNLxowCNTWtXJPc6nGgoWVVbVB9n
         3Z3YX4x9ewqw4Cx31wPlWmeaRPZYtexSrAUCikmDQBwKrArS+cJi0TEWxzPYsrWvQhiS
         TcxVnxhCtxkeCa4leL3YgeGKrkv1g4+OAnQhN12bZLrBBuMS+ixQK5NHQCtkLjf3f/OE
         zbCCAquKxw0lVgXYaLlbpQxGDbqooVpepngdL+Aw6MiLMMy1aU8OFEP2kA5ZpX6YMJwH
         nui/IJUv9/u6uy8wrU5YNCi+tzNg40MTzJF4LHuZm8jIgxczRy+WyWfhheZoxo4jOHDe
         HERQ==
X-Gm-Message-State: APt69E0WFvChAnzT4HFiXV8n+Fhk/rWHG6PXlxfVyVwbeD1hio0bp8xu
        H1HiT4jmGQo/qnInjS5fj8o=
X-Google-Smtp-Source: AAOMgpenC7g4Xn8jlS0k5G8JKBuah3osKKUeV6IJpOYdyzfZiXtaDA6P4eIBC7IzbJcPnRNhvWbz2A==
X-Received: by 2002:a24:5654:: with SMTP id o81-v6mr1903945itb.56.1530548179730;
        Mon, 02 Jul 2018 09:16:19 -0700 (PDT)
Received: from nuclearis2_1.lan (c-98-201-114-184.hsd1.tx.comcast.net. [98.201.114.184])
        by smtp.gmail.com with ESMTPSA id z26-v6sm6817477ioh.14.2018.07.02.09.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 09:16:18 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com, keith.busch@intel.com
Cc:     alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI/AER: Fix aerdrv loading with "pcie_ports=native" parameter
Date:   Mon,  2 Jul 2018 11:16:01 -0500
Message-Id: <20180702161611.2048-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180702131923.GB15983@bhelgaas-glaptop.roam.corp.google.com>
References: <20180702131923.GB15983@bhelgaas-glaptop.roam.corp.google.com>
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
 drivers/pci/pcie/aer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e88386af28..db2c01056dc7 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -283,13 +283,14 @@ static int aer_hest_parse(struct acpi_hest_header *hest_hdr, void *data)
 
 static void aer_set_firmware_first(struct pci_dev *pci_dev)
 {
-	int rc;
+	int rc = 0;
 	struct aer_hest_parse_info info = {
 		.pci_dev	= pci_dev,
 		.firmware_first	= 0,
 	};
 
-	rc = apei_hest_parse(aer_hest_parse, &info);
+	if (!pcie_ports_native)
+		rc = apei_hest_parse(aer_hest_parse, &info);
 
 	if (rc)
 		pci_dev->__aer_firmware_first = 0;
@@ -324,7 +325,9 @@ bool aer_acpi_firmware_first(void)
 	};
 
 	if (!parsed) {
-		apei_hest_parse(aer_hest_parse, &info);
+		if (!pcie_ports_native)
+			apei_hest_parse(aer_hest_parse, &info);
+
 		aer_firmware_first = info.firmware_first;
 		parsed = true;
 	}
-- 
2.14.3


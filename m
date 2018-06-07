Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dY2YDaOIGVv6TQAAmS7hNA
	; Thu, 07 Jun 2018 19:33:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1C27B6089E; Thu,  7 Jun 2018 19:33:55 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgmuyJU0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 76C5B601C3;
	Thu,  7 Jun 2018 19:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76C5B601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbeFGTdw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:33:52 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46991 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeFGTdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:33:50 -0400
Received: by mail-oi0-f68.google.com with SMTP id h79-v6so9665879oig.13;
        Thu, 07 Jun 2018 12:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EDFzg7yHcMkki5gobLgrIzHSDEIDAYiPYLkosue7+PU=;
        b=DgmuyJU0JE7viG65OzO3fZ7q1CfCBPgUy5Dtdwhy7DmSHWQLbJS5OnG66zQh/KrBfn
         OKoQGHPlvK5x7IDNKDZaZKbWJJKhjf0HkZMsm+N55eaCqG49ENXbQnAt+zZF4GmlWtiy
         nqL8G39XdLvtEMNikpHR4pY36l9nC3r356xg7Z461DwHyxjY20tZOxkz4wg1rDPNNpCC
         EGkPUG5nqCMAawQjYkz5ibbVvcPrA0B8sGHBYbVy8BSYoaSHFSEliYocVrTWdDfZih1c
         Y8KATHBrlajdzMIxWyV87xGlLHTu6S0Dcr51oQi52i6jN3PX6sLIftos2IKNrCa0Cntg
         QFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EDFzg7yHcMkki5gobLgrIzHSDEIDAYiPYLkosue7+PU=;
        b=Hy4wtd0O+moqybCvUYlc7lv0vQQg1eTmYVv/NN0vaAfGWHZH4nY/95r5fcn2PNXyGB
         oMt4BzrnLGsIv1soZDSgVd0Tm4WJDFOFPu6fj2pr6JsErS9Zyixr6rgateaa4ArCmqT2
         E6YMdFOSeYbwscqN5AlSM9XeqaUqNU4io0PlgpXEs25wVFQzr4WqSB75bAHnc4Y4N6RX
         4nLIz/OPCUsNhv39aVs4xsWyJCBDVprvsWlE2nAcQj1JX8xbCc4VDis0K540D0sD3kN/
         a/mTX4uNW43sHOpjUCtF/w4ajzah5FWRr74Fr2+86LRrfy0MOeLsUlhmdJifUF6a7him
         VCQA==
X-Gm-Message-State: APt69E0ipTpfMvzGDwIBQ/CajOPJJUcNYWkYR7dGKfrMbWKfFPWSZl/Q
        UjfQtjoFjtRCzpdBVoNy4kUfIsCc
X-Google-Smtp-Source: ADUXVKLE/61tf0LFxgKVo8fQhEBByTcSAs97J/MJi+2UOfe82DASAQCxreK0AiDXtYwlY60I8ZYqMQ==
X-Received: by 2002:aca:cf84:: with SMTP id f126-v6mr1688474oig.131.1528400029667;
        Thu, 07 Jun 2018 12:33:49 -0700 (PDT)
Received: from nuclearis2_1.lan (c-98-201-114-184.hsd1.tx.comcast.net. [98.201.114.184])
        by smtp.gmail.com with ESMTPSA id g36-v6sm7400877otb.54.2018.06.07.12.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 12:33:49 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/AER: Fix aerdrv loading with "pcie_ports=native" parameter
Date: Thu,  7 Jun 2018 14:33:40 -0500
Message-Id: <20180607193341.18891-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
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
 drivers/pci/pcie/aer/aerdrv_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_acpi.c b/drivers/pci/pcie/aer/aerdrv_acpi.c
index 08c87de13cb8..4b491851a781 100644
--- a/drivers/pci/pcie/aer/aerdrv_acpi.c
+++ b/drivers/pci/pcie/aer/aerdrv_acpi.c
@@ -101,7 +101,7 @@ static void aer_set_firmware_first(struct pci_dev *pci_dev)
 
 	rc = apei_hest_parse(aer_hest_parse, &info);
 
-	if (rc)
+	if (rc || pcie_ports_native)
 		pci_dev->__aer_firmware_first = 0;
 	else
 		pci_dev->__aer_firmware_first = info.firmware_first;
@@ -135,6 +135,8 @@ bool aer_acpi_firmware_first(void)
 		apei_hest_parse(aer_hest_parse, &info);
 		aer_firmware_first = info.firmware_first;
 		parsed = true;
+		if (pcie_ports_native)
+			aer_firmware_first = 0;
 	}
 	return aer_firmware_first;
 }
-- 
2.14.3

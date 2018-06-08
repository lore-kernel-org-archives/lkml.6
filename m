Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id S7oDBFLhGlvRLgAAmS7hNA
	; Fri, 08 Jun 2018 20:05:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2F80E608CA; Fri,  8 Jun 2018 20:05:36 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCS8/F3r"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8D7C2605A5;
	Fri,  8 Jun 2018 20:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D7C2605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932143AbeFHUFd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932085AbeFHUFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:05:30 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B73CB20874;
        Fri,  8 Jun 2018 20:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528488329;
        bh=+pI0Gq7MMOxThGO9wsoRuWTqvzx0EXy/4iIp43QQrqg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UCS8/F3rbhK6neAmZcKu8tobQQB74zBprsT79CpHsiuensAP/OYeS57gewgWro4w4
         MGT8jsPeIE76UOYuqPW286B3QSVf3y9BEC/2UiRUQwb0BwOTDPdz4npuGmc9JrdcWJ
         P8+sCEIKOOMgNtYF5L8xOeJEcDyxNrqrrj1Wvz4k=
Subject: [PATCH v1 07/13] PCI/AER: Remove duplicate pcie_port_bus_type
 declaration
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:05:29 -0500
Message-ID: <152848832893.11888.6593179260714831306.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pcie_port_bus_type is already declared in portdrv.h, so remove the
unnecessary duplicate declaration in aerdrv.h.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/aerdrv.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index 7fa902b1f7c1..f4fc71119cf2 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -76,7 +76,6 @@ struct aer_rpc {
 					 */
 };
 
-extern struct bus_type pcie_port_bus_type;
 irqreturn_t aer_irq(int irq, void *context);
 
 #ifdef CONFIG_ACPI_APEI

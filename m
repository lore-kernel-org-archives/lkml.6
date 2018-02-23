Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x224JFw6flLI0r6TnTonmyXoksJ6O2klzRUKtMywviuUK86NvoDDghWEFRIUVg0MHaE+KnCjo
ARC-Seal: i=1; a=rsa-sha256; t=1519374260; cv=none;
        d=google.com; s=arc-20160816;
        b=ZRcBK9Cn8IXoSRy06r8X1QTw9FWNqlz4GUh63iglb/Ulces4/LggWMipBj34EJ47fY
         RTJ5PYJRLbEy9aiHeoPYTZG22JZU//E1RD1oT7AuCsOfIGeGIK+gaqt0t7LLSfZFkyoY
         NOhniUOK0ci6Oi1bpJTijUiXsTKrQxeCDQYPeznVvYIK8h3cHQBtqszER2kA4Dy7pG3N
         BqMZZzy8lgyWf3kcXNa1nyKebfG1GtqQ2NQLYAuzYOTnawaZnECqTYfqFBl6S4ozrdYu
         m5/FN17+rfK+geiubgUfx1SLrYQw5Wk39AdUfi79yZak9CbM7XhZ2ro6axSUAz9A2vaB
         WYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=NdLxPYjlHUWURPydx0TYHH3eGfZcrtmSP6FXuH/3XqA=;
        b=GjS2QeFhsMMFr1rmFiPf3D81xw4sOZvvGP+JZMU1CHC/4swfpi8hr2WemQbTkMaNyk
         MNhDiMmuxmSSZCofYgyjN6rWFpWI/xy93nyFbHV2+PWFZWTN+GQDyVJe0G1lZ/hlfcJd
         rGj/ylPTPlOo2SU6kgspp4139HWmLxsuUhEUZbaJvKyekHbBKBjU0MBHPvM49W7JM9N8
         xuxzFlarylu0KPAHanaSe1HAaS3mnAXheQR9f78Z/Td+FTv1zuVDAKqYU1mShcWgmZQH
         5khoLTIHJjtRV6DESIglJHcDE/3aMMZQdFR1YYe0CfW4aRuJtQraN6LUPvd1K+UekzFP
         XC2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nvBOYTnv;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nvBOYTnv;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nvBOYTnv;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nvBOYTnv;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC3A860F6B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=poza@codeaurora.org
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Keith Busch <keith.busch@intel.com>,
	Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH v11 1/7] PCI/AER: Rename error recovery to generic pci naming
Date: Fri, 23 Feb 2018 13:53:58 +0530
Message-Id: <1519374244-20539-2-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
References: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086403303503248?=
X-GMAIL-MSGID: =?utf-8?q?1593179384621560762?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch renames error recovery to generic name with pci prefix

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index a4bfea5..aeb83a0 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -478,7 +478,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 }
 
 /**
- * do_recovery - handle nonfatal/fatal error recovery process
+ * pcie_do_recovery - handle nonfatal/fatal error recovery process
  * @dev: pointer to a pci_dev data structure of agent detecting an error
  * @severity: error severity type
  *
@@ -486,7 +486,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
  * error detected message to all downstream drivers within a hierarchy in
  * question and return the returned code.
  */
-static void do_recovery(struct pci_dev *dev, int severity)
+static void pcie_do_recovery(struct pci_dev *dev, int severity)
 {
 	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
 	enum pci_channel_state state;
@@ -566,7 +566,7 @@ static void handle_error_source(struct pcie_device *aerdev,
 			pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS,
 					info->status);
 	} else
-		do_recovery(dev, info->severity);
+		pcie_do_recovery(dev, info->severity);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -631,7 +631,7 @@ static void aer_recover_work_func(struct work_struct *work)
 		}
 		cper_print_aer(pdev, entry.severity, entry.regs);
 		if (entry.severity != AER_CORRECTABLE)
-			do_recovery(pdev, entry.severity);
+			pcie_do_recovery(pdev, entry.severity);
 		pci_dev_put(pdev);
 	}
 }
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x2279nEa+PGcVepuIVUEc/2FiQGcNRMq/GZDWD8SgmrlrRXEB03zKKuQ2Ul/Ixm7F/RUlKJeS
ARC-Seal: i=1; a=rsa-sha256; t=1519837480; cv=none;
        d=google.com; s=arc-20160816;
        b=DSObOh3aKIpYMSP3cM5y0c3MidSmnF37Z4sm2OloG6pEUX7Vu7/KraFTM+uPRQKCvt
         rB267JqGqPQWPaT8iJGXImOwLzHWVOO0gklk0Lor4a0nWlzgfJ+kyj+EOpOUyDkyE8nr
         598vJUiQbC/fAm70CUH7/HcjIQAOlUfykVSHBR4tV54MdTEKosSjnMwZsRqxNqrH8JbM
         41f80AoYMW3EWLRdd+cUTJlKj4plK+KsNPVsiDs/XX73rSKWSEh9NqToh7fs9QaHgwvn
         WZhI+ns2bj8+3O+38YGhGtYhWD9lpaXCH8a0w/9KXcaXzPgKn4Ws2/udludSwzxuzDTT
         8ecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=jo6NYX5EOIn3rxSBRjT14oPJqCnffLflXu74mCQVRoU=;
        b=hT2yzCDufMxR0odkNERI2O2f3xiTPpwnSzsvZtlWdRgEg10LTe+KKoae0IZMUM2aJC
         ytyk+S9sDY80SJa3Blsspa0b4pxsYR7KdCvvDQYLJY1QmOJVEwei1x10tTy7BXU94knr
         /nKqgvIgjd8bI+6xy6yfaTTbtXBlzsO7bxx00qs2jwEVSPlrnP9QvyXKQ2iA9qrHiC++
         tdQsurbfBpj0r0MU6GfoKMlpu0Yb5babybMdGohvX3lYXBBo8r/Kqz0h+txeuUz1hofp
         GqP22pvMrVwjuyk5CFYFgRm3CUN6XS0Eu/UuqDQ15O3ZVyOMNztTy2aX1afRAW3J3h9R
         AXkg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DbOH0FOu;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=BgQ0mspZ;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DbOH0FOu;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=BgQ0mspZ;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E39E1601CF
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
Subject: [PATCH v12 1/6] PCI/AER: Rename error recovery to generic PCI naming
Date: Wed, 28 Feb 2018 22:34:12 +0530
Message-Id: <1519837457-3596-2-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665106165176501?=
X-GMAIL-MSGID: =?utf-8?q?1593665106165176501?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch renames error recovery to generic name with pcie prefix

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fcd8191..abc514e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -342,6 +342,9 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 
 void pci_enable_acs(struct pci_dev *dev);
 
+/* PCI error reporting and recovery */
+void pcie_do_recovery(struct pci_dev *dev, int severity);
+
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
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

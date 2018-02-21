Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x225gaFljP8oFzmCmhQzJqQ6zrQVE2i+VwYP1L46BxsSdRb7pk5N+kZzsE6QOA9w9cmq2VfIy
ARC-Seal: i=1; a=rsa-sha256; t=1519208825; cv=none;
        d=google.com; s=arc-20160816;
        b=eI88a4Jk57ti0sQX5aN6IEb5oQfScm2M4KusCdE7XTxhRaLLiOh5c+avxPVoMZfAox
         GzRDSct0A4ET/bvdDnIWKizBXIHbdL8SAiGsNfyO3H4b+ofp6y+jvVnXSzJzruP/MoQt
         jJJPxRzBi86Y45oNxJgsUe0gxjisZ50YK/mhIDX8v3Jw5rH+u8g+jyrr8clcZY4KPdEm
         ffC0zmTe9wD4AqF7N0jgvo+a24NA2XvJLaRMJMPP0Yjjd8VQrfpuHbjyXEWFJbpxXu0b
         OnAdAe5ugeJytRULPa/iRCwfwJNZqHKythMCFpu2N+tAvXrj6JL0hx3TVIik+LK5xPVV
         SRiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=RaKMbTFB5oF00Hf2eKXWu7Ptl/gIUMxWoq4RM47QGhw=;
        b=wOUESu4H4s15JlXfYA1heafsJpRlxwCsKZMJCiW36+Cih2wT15mmqIgVVdJL1Pz6N3
         Invz5263DBpA3WRCS+4+cAFewHp5dZsuZz0wi2g37aeNE09l6f9vENf1ttbqmz0gGg36
         U2yR3MfZQLfNt4AZigi4ISXKrtKg4FrCpeqLiepuKe1KiLUR1AtT5asEVOkM2QC0AMO2
         95W/DJzhZ4XNrO0XOjd3/jrvVg3eomnCv5DJbRRiZyzp+bYi8pUWwSn3SNuMyMdjPxd9
         DdRgtsOJYCa7IixdT4Qs2B1pVsOEQ7WI+q9kIsGHEn0tHdVhyKNnteSrQJ5D/4IF4soS
         08eA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=WPp/jwye;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=m6EK1V0V;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=WPp/jwye;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=m6EK1V0V;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3564605FD
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
Subject: [PATCH v8 1/7] PCI/AER: Rename error recovery to generic pci naming
Date: Wed, 21 Feb 2018 15:56:38 +0530
Message-Id: <1519208804-24512-2-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519208804-24512-1-git-send-email-poza@codeaurora.org>
References: <1519208804-24512-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593005913047088715?=
X-GMAIL-MSGID: =?utf-8?q?1593005913047088715?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch renames error recovery to generic name with pci prefix

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index a4bfea5..306bf2f 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -478,7 +478,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 }
 
 /**
- * do_recovery - handle nonfatal/fatal error recovery process
+ * pci_do_recovery - handle nonfatal/fatal error recovery process
  * @dev: pointer to a pci_dev data structure of agent detecting an error
  * @severity: error severity type
  *
@@ -486,7 +486,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
  * error detected message to all downstream drivers within a hierarchy in
  * question and return the returned code.
  */
-static void do_recovery(struct pci_dev *dev, int severity)
+static void pci_do_recovery(struct pci_dev *dev, int severity)
 {
 	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
 	enum pci_channel_state state;
@@ -566,7 +566,7 @@ static void handle_error_source(struct pcie_device *aerdev,
 			pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS,
 					info->status);
 	} else
-		do_recovery(dev, info->severity);
+		pci_do_recovery(dev, info->severity);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -631,7 +631,7 @@ static void aer_recover_work_func(struct work_struct *work)
 		}
 		cper_print_aer(pdev, entry.severity, entry.regs);
 		if (entry.severity != AER_CORRECTABLE)
-			do_recovery(pdev, entry.severity);
+			pci_do_recovery(pdev, entry.severity);
 		pci_dev_put(pdev);
 	}
 }
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

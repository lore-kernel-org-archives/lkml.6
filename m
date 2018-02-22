Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x225jIzt7CxHQI0SDlSe7JqYhwff764UO/qY4Eg1zVqlRsQion8/Spbxy9AzQftOhR3+AXGt3
ARC-Seal: i=1; a=rsa-sha256; t=1519315349; cv=none;
        d=google.com; s=arc-20160816;
        b=tX72MVc0KGj3Fe0XDV7TSKUuQ2Y5C0n5vv+nyerPU3fyGu4shNwp1bhYVBFGKIyv+g
         VdqM3/p2CFfLxGc6t/JH2XMwy89tKlP2XgvGdJ+ZB7Mqh7k2xLAiSGEXwv/e+ueoC33p
         rRmk4Mtz8qp6ZfpaLwfN+xErnMD6IrGgSI0Y8sPtSI11vON5pDIK0Us85ze0hm4RBTLU
         EKNgeZT8yDqYAN2IX5hptvdv4teV3WiUvyTsRuVy5HBsg3kvkmN9qk6/vD5EweZbCkLD
         nlaDajHf6kR7K0/JECuEm1pRVmwbKOLqkIg5PQHs1KqIDJZrZlFLPrEYltPPwhxEvoBf
         OHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=RaKMbTFB5oF00Hf2eKXWu7Ptl/gIUMxWoq4RM47QGhw=;
        b=Y+7elL9Zvq71aZL+pLVCr2G7HGzFHAZanKCZzuBhjGRoTidrDlSJ9MO/4ih+o1tfHH
         PRic0Ivmf4rVOwJot/XF/Gs+eLba8tA0x3Q186vjHoM3d84MWPdHJ+VWjLbRhTRvaBPg
         RUi0zyu7FjVJHFdM1rN9PkTTtn0FntdjeI+Msghyvpw0To1n0e46x2PNkMy4idFpWV+w
         GlWOrF4gtCtZ3xJM8JDrsKQOOUCFu9gwNbHjeV5vok+zrQdgRZRmVgcoRW4WWDdHHuLt
         DwTMGXoNBUuQJD1w8yVuNl0KpbK9iK/2pmuD/GeJaQ6+mVZezcxBizO4KSSkMdQA/y3r
         rk8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=adKIJpQ8;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Qbgr7bBO;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=adKIJpQ8;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Qbgr7bBO;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0D4D6081C
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
Subject: [PATCH v10 1/7] PCI/AER: Rename error recovery to generic pci naming
Date: Thu, 22 Feb 2018 21:32:06 +0530
Message-Id: <1519315332-26852-2-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086403303503248?=
X-GMAIL-MSGID: =?utf-8?q?1593117612398262737?=
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

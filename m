Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x227qWu0Zneo+nSDKVTpFg+Q+pb+qgWYA7FhNzGEmtS1Wx1GAptJWRV528ns72aAJNDwwCj0J
ARC-Seal: i=1; a=rsa-sha256; t=1519285586; cv=none;
        d=google.com; s=arc-20160816;
        b=QBJ5BndvtO9vdJw/LuXAkR8ZhNIzLPxLEtN1l5v7DwY8PbzBf4+jwYVbPNEIhfptEg
         MU3wbBtn+bu2nGU9TMEus81INEsaq9QoOZPqpO4s7rv25sdCvcBiTE7xMAhJxkZucNZt
         kdzqqEc4WS1TQwV9HZijBkfEWbymMBV772XZ0QZvKP4lzmKj3gFPBIJlBZL4sdPQeD6E
         TLrOF+vAKLj/PG0lhJwD9rWoNNUnDpfDaqdqFLDe856R9qz051tgTjq9tqwaCj8LDh9P
         yfGx4wfjejel7w1ZvBVyN38Cp1CvkkwtbIXK2BwB8bU+b2XnCkU8wmiAhRRhIgZ7mBjz
         I//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=RaKMbTFB5oF00Hf2eKXWu7Ptl/gIUMxWoq4RM47QGhw=;
        b=e/VDBNpOcydU/ZeKUopIMBrf5v2jZzuDnQqV3EbUyPv4uDgJwBAwSHk35BJQ8LjucB
         k5TSYeWqYszpT7Xv79rfJyoJMiTXgfD7zIQo/s3lCjGsANUz94ctMMadnU7AUhWead7K
         1kGQAyxdRg3YkmHYxp1Uc9H0LCVmu66vs2ZRX+JAHSZu2SpKCUoZV5zUdLrNTOdS0DGc
         /gFegh0gnb9FxLgvk44mhDoE8q9P1r+xziU1rzbVf2QzbQFGbFp4HPBkmOxTnbRK3RNz
         eLvbL8yhGTEWUuikcDcz7q4fjYEsmp/6H2TBtWmIEn/MBIY9dBoYybIncu56lIzb5fzK
         UQig==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=k53ysruS;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Z+ZvbYqP;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=k53ysruS;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Z+ZvbYqP;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E10B607E5
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
Subject: [PATCH v9 1/7] PCI/AER: Rename error recovery to generic pci naming
Date: Thu, 22 Feb 2018 13:16:05 +0530
Message-Id: <1519285571-5634-2-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519285571-5634-1-git-send-email-poza@codeaurora.org>
References: <1519285571-5634-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086403303503248?=
X-GMAIL-MSGID: =?utf-8?q?1593086403303503248?=
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

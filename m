Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x22585XD1VojyaHs8hY3jb+L7LDWX/zMN1fN2KbeglS9aIqufYOA5h/zNrrKsYaDWXlY+GtKI
ARC-Seal: i=1; a=rsa-sha256; t=1519285602; cv=none;
        d=google.com; s=arc-20160816;
        b=spvkhAxCLgiJRKqF3qjSt7UulnOZSr4jet/Luz3xeb1anqmmuuQi9lEF8cakX81cJc
         K0W6EtZKYW8TdqarNy3tBeXeTFVzhsosWNMN1AsS3F8cbueyZLuRaVQr58HPdzUrNKFc
         rfH3HALUV1dz7CQLyJBMU00hzNFC7sEHmNVJ7V1oJFjv3YXv808oumXxaQT2S9pGdRi6
         6rmSEq5jgZavpH5ezbcjeZzAXxACVyyTs8E3/TkennU7Oz/0N8zKnOlPtqLxF89VRBqB
         eQi0zZKXecnKvQO9m4XfPvtxhJTyBwXYkYGYT152VK38abZIF0Jm/mkEHbAnJ07fWe0w
         +DbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=m8qGhUFA9VkH7IuJYKyL2k7UfRBEOosG5dCFie1bMaQ=;
        b=FXjyZNGh5y7gzdkQs8+n57DlrOm4gAtj7AJsl9DSN6XqpoibqNTnebnWoT2Ypr2ob7
         mxz928vLgq677my+GqCtDYf4S2tII0uuC5LmHblrqL6ca85K3Enp/hxA+u6KjnBNI8R5
         O0MGsh2DKP+ktjFMQLO6+d8i3dm7h/uEZ7Uh1kfCv9417zpiiHZq8Tg66kzH85Xx0cD8
         dsG6SjPGvoX8o4kGVu3MhCV6DHwXyk2yFwGCAgROT2qEUQv2N1T6cNbgc07+V0RwalWJ
         5b5BGV5yEy2tHxhNzZcF3TGAIUz/DuPYdEdJ6fqAE7dACPERFFedwa7QFSiqlQTkWWBZ
         NN4w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=W4f54il7;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=W4f54il7;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=W4f54il7;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=W4f54il7;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ABCA3609EF
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
Subject: [PATCH v9 5/7] PCI/AER: Unify aer error defines at single space
Date: Thu, 22 Feb 2018 13:16:09 +0530
Message-Id: <1519285571-5634-6-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519285571-5634-1-git-send-email-poza@codeaurora.org>
References: <1519285571-5634-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086419214751308?=
X-GMAIL-MSGID: =?utf-8?q?1593086419214751308?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch moves AER error defines to drivers/pci/pci.h.
So that it unifies the error repoting codes at single place along with dpc

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 1efefe9..7ae9bb3 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -56,6 +56,7 @@
 #include <ras/ras_event.h>
 
 #include "apei-internal.h"
+#include "../../pci/pci.h"
 
 #define GHES_PFX	"GHES: "
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 124f42e..b0e63b5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -343,7 +343,11 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 void pci_enable_acs(struct pci_dev *dev);
 
 /* PCI error reporting and recovery */
-#define DPC_FATAL	4
+#define AER_NONFATAL		0
+#define AER_FATAL		1
+#define AER_CORRECTABLE		2
+
+#define DPC_FATAL		4
 
 void pci_do_recovery(struct pci_dev *dev, int severity);
 
diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index 6a352e6..4c59f37 100644
--- a/drivers/pci/pcie/aer/aerdrv_errprint.c
+++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
@@ -19,6 +19,7 @@
 #include <linux/cper.h>
 
 #include "aerdrv.h"
+#include "../../pci.h"
 #include <ras/ras_event.h>
 
 #define AER_AGENT_RECEIVER		0
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 8f87bbe..3eac8ed 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -11,10 +11,6 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 
-#define AER_NONFATAL			0
-#define AER_FATAL			1
-#define AER_CORRECTABLE			2
-
 struct pci_dev;
 
 struct aer_header_log_regs {
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 9c68986..d75c75b 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -13,6 +13,7 @@
 #include <linux/aer.h>
 #include <linux/cper.h>
 #include <linux/mm.h>
+#include "../../../drivers/pci/pci.h"
 
 /*
  * MCE Extended Error Log trace event
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

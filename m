Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x225/1pTpt0Dgdqjl2fi1bm4pfcUxfBXAs4LJAEWrydBTDpnk4WD+q2DwI69QlOY+vGUbOpkX
ARC-Seal: i=1; a=rsa-sha256; t=1519315373; cv=none;
        d=google.com; s=arc-20160816;
        b=kh4rws4yb2Tsu5+S2irQbC2iNLxsI+9VPdaPeWQfTnYPl0ejiA7fQSJqK+CfQYwEhM
         YjCogTwNltXWzcQ8vaWyPML1xF1puZACwXMQQxiOnBSV8TjbNT0lo/qaX/5FE5H+YdKg
         FVLzdnoPGxDNfWrGuO6/oqi2U/UTumGjbrFZduDk8mBd+t7PWcGak3jHpNVv8RjZbMsV
         QEcqkH9jV5izsVn9NoQLeae666qRJr+J3G2b+H4q3jxe7r9V4niMH4Gb6WVnFYh7RP6F
         yM/0fi+ZRbNskJ2ojN6JVidNMu9oCyv5TOyRjiHs71yyHQHBvnPTHt07fcfepRSakXdw
         iZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=m8qGhUFA9VkH7IuJYKyL2k7UfRBEOosG5dCFie1bMaQ=;
        b=njg+r51PEKVcOjmpF15jg5wAyVmMqKT2ptfWKBs7gK8OJQ98xDV0XA72GwNPIwZM4K
         ZWw/O3UTJmnB5NdIuu5m9+n8o5tIQWfNJ0S7WwyX8uPdF67hOoMJdveqSoliO4p2BgZo
         l/DVmwCwqlUibTO7Ysaw9mDKVc8suKh9vqpM6CcV/AVNabg4wcv5Tqd0zprlhD3muh9f
         z3+u0FzQ+2Tj6d6APuhrw+KeYjttdrmm5C4lih0Lv4RW1YpHZRwkz+FV9FMg1RPOdnDP
         Vm5xyPbcS+aosTdVuOAaxGBXgA42VkxCr5O7LQaVbatL+CJAHy+n+o7Kg+hhTVMFyCcb
         IbkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=CVLRtavF;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=c0Z+rsO6;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=CVLRtavF;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=c0Z+rsO6;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52B2A60FF0
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
Subject: [PATCH v10 5/7] PCI/AER: Unify aer error defines at single space
Date: Thu, 22 Feb 2018 21:32:10 +0530
Message-Id: <1519315332-26852-6-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593117637130164390?=
X-GMAIL-MSGID: =?utf-8?q?1593117637130164390?=
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

Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x2247q38eY7sQVJwqRo+O2BE1lCsMZApFzGMpdOuJQQ3wMJ3lzojLSPfz1uK6TElThSbVpyO1
ARC-Seal: i=1; a=rsa-sha256; t=1519208840; cv=none;
        d=google.com; s=arc-20160816;
        b=z+e3O9y53yep8ovm6BAFRfkrLZxk+cAfm2LsnDGKrlFM3Smbgx4mzPXeOOy0KRVuPQ
         rMv0WQUsMeyn8qBa24YboOUcNCDYTVEKk/JiovZsIGFgKwFyyxsaDPcTUVPJnpJl3SL5
         boUaDrHIl2mdCARQH7yG2GFznBcB7zR2PHfhShCrwHrCWA1Oqngbn3mtT0FteXzwhN4c
         XNi9EJOHaPGPYD0CFs+VdFjKrMT5uq042GFnspuQSbTf5sqK2QVLCPXSaMJlHWJU5LPo
         uvrWdS8O5gfD4z0mMMyJVKCZifhQfL9X4vwbOnNjauwKA63F8+godVuqH31SDsr19hga
         PB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=2tcOc+g27Dl6GceKhR0f2kGrSPlqPln6mE1x+UPr2xo=;
        b=gAPoW7WvHFPf/ifK/fspjAFIi0LUngEdKNl7HG760cB+D7KpNyiKvlegFjCmWL9uWh
         chzDOSMYl/ARMK616QkCR79a7d5tEnHm3WfuaNdSO7xl9DqhqXCCrm41K1vTcuQW/fmF
         gs/Kplw67qc0yGObbMWq5sXhmn+5pM6+l6+d7bfGWcveF1b02mrKIqJSI4MvCYW9fABV
         x2EI6gdGPLwMDWLVPPE+fJCNtemaHu8zHz9MgvBF8GXcvtLtRDk26/6DPSiqQuafbtU9
         7cuHP2nUnVL7FRUy2WusKQs1MlFqsJljFcClDmTsvWnCyOP53HNQgLj4DsO9PNA8gcs4
         l6kQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ng01C2HJ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=NRkJ/KC2;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ng01C2HJ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=NRkJ/KC2;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F9EA602BA
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
Subject: [PATCH v8 5/7] PCI/AER: Unify aer error defines at single space
Date: Wed, 21 Feb 2018 15:56:42 +0530
Message-Id: <1519208804-24512-6-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519208804-24512-1-git-send-email-poza@codeaurora.org>
References: <1519208804-24512-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593005929518138318?=
X-GMAIL-MSGID: =?utf-8?q?1593005929518138318?=
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
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

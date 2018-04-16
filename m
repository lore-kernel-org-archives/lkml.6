Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx48uXTQURplCdOa/dNoKR3jhs1cnKhmtatum8XumJKQWmof0ZgsslAmc69LtLeU3GSwrT86K
ARC-Seal: i=1; a=rsa-sha256; t=1523915205; cv=none;
        d=google.com; s=arc-20160816;
        b=cUBbVvJqdDI4JyIYnSIqHyd4EN5q9DTMnqyvxPOIq0Gyy12xAyxCqcoE3zQsmoqJGV
         vnJ9TKbW/R/E0Tfv97/8HUUnt2cbvhpFvzamvR+yJFyebh9H31LCWRpW1CUsfHmqTT8k
         NJbmPLqHYI7UcB7oWnZUpkt26aW+3fH6dfNaE9TLn1V+6iCXcXYlhqQUuFt/xbp7A2nh
         nMTPuKlhkmznjL4KJvltwrLEhGiWx7livBs8FU5So9lVVCk/2JeFXWGV2knkYD28kM64
         S+YLw1LnD/XiI+L/RriiPxFY1b7vrkJanowFJ2ueEKW5lA9M3hLVDLUx/vAked5tyE+z
         ejDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=rCXscOwUs4u8MHDFy5/JUA7aKs7nsZyLeXNS9+MAncw=;
        b=HMy6vJGUiQ7Q/w1phVLUBdlKR7CDcLJi1FgSKwMsV9QvFQJESOBbsHGTC3Ih5Xhf9R
         ctWJ9V/RzubckkfK0iFYqW2+DGbscbSoO/hVfKq9rYEqAlb7u5wTVOPiG61u43aX3at9
         liJ3vmD/T4pU8vDosLb0l4eEdT83Bi8dDMw0u54rvni0TxbxjUjk9TGaQDmgHJ8f6ScQ
         sf9dx3kIqhbQyequcPbK21PoTZxlUL4PvdN83rRnLQ27D3zTBvazmwPRRMtLkfL32w8o
         XX/BOli4XJto4UmtX7BCl9DOMtpvruHncdo3hE7NiqdWTnGXxYvlC6Wefko0FzszYaXD
         IWgA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,460,1517904000";
   d="scan'208";a="34740181"
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Raj Ashok <ashok.raj@intel.com>,
	Jean Delvare <khali@linux-fr.org>,
	"Christoph Hellwig" <hch@infradead.org>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 15/22] iommu/config: add build dependency for dmar
Date: Mon, 16 Apr 2018 14:49:04 -0700
Message-Id: <1523915351-54415-16-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910308380643?=
X-GMAIL-MSGID: =?utf-8?q?1597940910308380643?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Intel VT-d interrupts come from both IRQ remapping and DMA remapping.
In order to report non-recoverable faults back to device driver, we
need to have access to IOMMU fault reporting APIs. This patch adds
build depenency to DMAR code where fault IRQ handlers can selectively
report faults.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 73590ba..8d8b63f 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -139,6 +139,7 @@ config AMD_IOMMU_V2
 # Intel IOMMU support
 config DMAR_TABLE
 	bool
+	select IOMMU_API
 
 config INTEL_IOMMU
 	bool "Support for Intel IOMMU using DMA Remapping Devices"
-- 
2.7.4

Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AG47ELtGZWQVQXftIQiw0zWzQv08q6Ose3hB7wH18ELJXEhOFz/CRaiRsNzXmBwOkExFYPWc9Rx1
ARC-Seal: i=1; a=rsa-sha256; t=1521774609; cv=none;
        d=google.com; s=arc-20160816;
        b=hyZ4RS3qr8Yqhcs32IMtzsHytUESZLu/RvMLaFbLR+3Ga2CGRiqsShhWZi0T52UqwF
         4fx+udmqV1Mm7CSJpG8z0+XkqWPizkneCD4JRuaE88dI8U2sfYZk/XOnAReD986+qL/u
         BPbiKOTRS7OS0qEcaugV64PxCj3GO/eB0syLd/ZS4m9O7kKGYo1Uy36LBMK31T6cXZLL
         jzuezxWWST6xiDOiya7FMgzvA11bHX/aaTxVc5SjBm6mwQyJKtHPCUSXdnjvezMB3DRD
         IqLLYlxy/Jq61vHkhjIty02KLkqexJNtuV+0rwgrog2Py55Gz38zUCCnom0iP2SMscBN
         DTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=b8iZhJtCXvoQvsNutGxYzN2yf5gbE6QJG0enWcsdq+E=;
        b=VzjB2vt8dJDJahY8qnQR7t3a1gI7lny2AcQONvlQwLiRPJgbWoUp5hVd+mUnR9y0aW
         I5iexGE5HxIcrKgi491MUEVmcRhoA869cTIMKFBJsbhZWtt8t0IvWw/VesksXdMUrzJi
         nq/2kLQnDMfqHLz+cYU548N9SP7I7qDV70VXe/g3/JPFZaKgYPQ0V+8RL8vMTF6wg+aE
         Qp8+W2hYILMGck9Js98ipnX6cMpBHsT7wfQiEMUuuQHMgcIHjiGeYS54fnjMN6xrYGxC
         zb/wk0+ubtHCGCLxrv4huzdb9aL72Mds+5ch8EMZaDoHLJz7IDwGbnXEDXwrvSv6j8T1
         4otA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,348,1517904000";
   d="scan'208";a="26316028"
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
	Lan Tianyu <tianyu.lan@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Raj Ashok <ashok.raj@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean Delvare <khali@linux-fr.org>,
	"Christoph Hellwig" <hch@infradead.org>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 15/22] iommu/config: add build dependency for dmar
Date: Thu, 22 Mar 2018 20:12:07 -0700
Message-Id: <1521774734-48433-16-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595696333254675112?=
X-GMAIL-MSGID: =?utf-8?q?1595696333254675112?=
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
index f3a2134..45db4cc 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -138,6 +138,7 @@ config AMD_IOMMU_V2
 # Intel IOMMU support
 config DMAR_TABLE
 	bool
+	select IOMMU_API
 
 config INTEL_IOMMU
 	bool "Support for Intel IOMMU using DMA Remapping Devices"
-- 
2.7.4

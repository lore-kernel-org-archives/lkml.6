Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZoU43hfF8mkENcVXOg+na5LOpnlJ/J+ogcQ4QA5kRyBjqEmtdK2UuQIuKBDkwpCfExsqhbQ
ARC-Seal: i=1; a=rsa-sha256; t=1526071893; cv=none;
        d=google.com; s=arc-20160816;
        b=sTdZ3HQjuNjAowpkXkeMGwyuag7a7boMBV75trGFEDxKWYyli3OURYVQHXhGIio/pe
         OLNPagvhM9PemTysZ0ifnhR7Xk+ab1bhu8TJtSYCFMa7p/h5lqaUXHYxVvEaWTeo22co
         KFA9Z8xS+f4jBusEPr8ZoQQUO5cwgCfGP0H+TGK0gzSnQJ3q0v2QHlGWPdZWCBPTO1lE
         4onEKKaMOYdMdQSZJjHjG/P4uVGCVTw6gbZMcsbHlRgO58j8K8mcb1zRy0Lf+5NE9NG7
         58GkCh0o6sz1DOkIv+oSzHzVmJcDClCCxbQ09/B2O6WPTuv+818bSu2zo3gVGRI9t/Xn
         cOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=KF4t0cP+bAhPnaLtu9P8y8ZF1rYXdAoeEZ5mqDsumC8=;
        b=vbMCOYJMeuvLtcxHBi7RPDJvEDSlixRT55ivoIS0WHJbLftJb+xML74NYw1D2CgPWW
         FhU4O3R8dmu3sgty8Dt/SxzunB0IQeEFuBa3gd2pyDQESjq2xg7X9ITA/AXPDtULXB8r
         Srazvwk4eFE+yGjpzW9gcrUENF2YJo0HRDRuvgwrGFL+E4puLnhFCSywBkqEYnc+2i0D
         RkJHyRGTK7YqeNTNgZzWXg+iikWAbH43O/bKT+hrNHCjssthWaXeca1/Puka/U3ZuvW8
         kx2KsEl0vnz1q2Qrh9uDsNZbXneKrVwj5zsUasLBPbe+L0IEulAgECAMGsM06JQNgwak
         +LIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="41104737"
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
Subject: [PATCH v5 03/23] iommu/vt-d: add a flag for pasid table bound status
Date: Fri, 11 May 2018 13:53:55 -0700
Message-Id: <1526072055-86990-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202361739379214?=
X-GMAIL-MSGID: =?utf-8?q?1600202361739379214?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Adding a flag in device domain into to track whether a guest or
user PASID table is bound to a device.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/linux/intel-iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 304afae..ddc7d79 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -473,6 +473,7 @@ struct device_domain_info {
 	u8 pri_enabled:1;
 	u8 ats_supported:1;
 	u8 ats_enabled:1;
+	u8 pasid_table_bound:1;
 	u8 ats_qdep;
 	u64 fault_mask;	/* selected IOMMU faults to be reported */
 	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
-- 
2.7.4

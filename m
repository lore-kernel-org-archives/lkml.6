Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx4++H5hkNYhtY0ctwAinEoLi5jN/lu+GQsoSiwHA/xic+4OWQY8CYC1JAHjsElFp6f2ZX5t6
ARC-Seal: i=1; a=rsa-sha256; t=1523915204; cv=none;
        d=google.com; s=arc-20160816;
        b=aY5nsZrW2A8lhtodQ+KruOcmMIcb50rC82s30G4pRxG78pcfxn8pJsKLjhpbpIe8Ep
         pcHDi3y0pJ9lq+SjqRmaPQBLC32SP4yq0CQu1wLPntFxYSeOeT9CS4Wm4/5sq/zgZysn
         cXADtWP4a/eorQnHymWN5ZqcyOHW+ZjgcfvCo2ZgRYNJcxrjSVstJtvyB52+0zBO4nEU
         l9If2FbWkRT5Xjzyd6YJetpKCy0R/31RKsQOCjM5s/egMswUIE6GiZ0vf/Dq6kkmOVrg
         t8rPA0c1Vr58d0tgSu31z+Kf5VwAtHPX8WGKnzatwVPRhxGR8VUhvL8GtV9UDf0BMVzz
         JdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=KF4t0cP+bAhPnaLtu9P8y8ZF1rYXdAoeEZ5mqDsumC8=;
        b=qgVDhVD7EC7+/3Xj12K3NJ1a4xLZpVFf/RLpvRtvgH5ohceeDZUzoupaOP5E2spMLw
         4/u+S42yYX+u1gLyH8Gmash4WlleLKZ17ZGBx7gvRnsU6GoOKnOvbGprZ6jZV9V8RkPw
         WvQSccmU/Z8d22Wnl0TmgeJ4VSrGkz6nwLgwueOBMCmRTck+s96Zq1z0NdhEpXdAJ9ii
         olEHS4ALu7FoA6upQsGfMoE2xnjLB/Kp3p++1byzk1pw2ejHjMdBjj8ud+m93Z9A0wPZ
         jalWCD+sS/8qYyKyPcJcvku7mtyQgodwgb+zErJCy0UC0xN/+rH6Jqac/M5IayBp3hcf
         ah8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,460,1517904000";
   d="scan'208";a="34740140"
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
Subject: [PATCH v4 03/22] iommu/vt-d: add a flag for pasid table bound status
Date: Mon, 16 Apr 2018 14:48:52 -0700
Message-Id: <1523915351-54415-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940909410984022?=
X-GMAIL-MSGID: =?utf-8?q?1597940909410984022?=
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

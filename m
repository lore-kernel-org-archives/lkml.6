Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZqpsWJA8rUgiLivcYAwX2YLDJJgxHa0d62cqX2ApBikzSNnNFMlIaaKrrX1T7zLnRBwIg5k
ARC-Seal: i=1; a=rsa-sha256; t=1526071895; cv=none;
        d=google.com; s=arc-20160816;
        b=HXxgY9bsFbT9dNvkqkf0XsfYSFFSONViriYEUpWS/2AwnJHlC/zLrBW9Fbf31BD0dc
         qv/6GoT/iEyMAJA7Wr1b5tYnn9gEZswOBJMPTp3xtgKyNUoCWTQ7WwZW7vcUcM6sfUNe
         qcsa0HUjwzz6C5iENfdZ9aZQEqOtmQrr8UvGJZb/7nbyjzXm8mC8tyXHt8OWtfDw5JBs
         zmiYOX4DKRh0mpzczdWpD6QoOrWkcIOMntTcu5AwFXbse5XhgbogsttcRPmgeqPqRnDU
         nQ4LAqcfZGT+unzOeQpW9KByR7Vw1P8HlLSlk3Skzy0So6zZ4brFqeXP9UOHv1DT7lD0
         YJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=rCXscOwUs4u8MHDFy5/JUA7aKs7nsZyLeXNS9+MAncw=;
        b=mwSZ282WKriv264BEAqTzFSWOurrugGwiXO169wFEYZBRyzHH3lm8JQwTEddMm/xTK
         Dh903MgHnMuaT+S6gWja6WdbjQEGhI87bgU+wm/L3HmRM+5E1qshYXKZ5Ol58Z64GpQ9
         /KjZ3DRNMrYGhtuGVCpeSMyeOBn0dwiO6wISPpSvgsLpNUZzhJjNyheTm9fuValFVRmU
         0j8gW0Ce4V8RuZNx00qjR1Zn5LIczgdJGpyTHIcZ6DGyTN9A6PLlqaPzjHEMjOVQkRNF
         3sG55g7xmFmZaBOun3/nN5CcAAlOAuvlQOlf2sLwxjcAqZl2op8A1FvvG6uxHuuy1AdZ
         hy7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="41104781"
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
Subject: [PATCH v5 16/23] iommu/config: add build dependency for dmar
Date: Fri, 11 May 2018 13:54:08 -0700
Message-Id: <1526072055-86990-17-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202363434174521?=
X-GMAIL-MSGID: =?utf-8?q?1600202363434174521?=
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

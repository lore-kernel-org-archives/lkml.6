Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AG47ELtBmZmiKNxHrxne3kEZAolg2hPEPwAW1RgTGa/bglBFtcirisJxA7opDjm6PXTnhajv6PDf
ARC-Seal: i=1; a=rsa-sha256; t=1521774602; cv=none;
        d=google.com; s=arc-20160816;
        b=lWWZLBNh6sekjKiZzak9PMTYxQT244kqVhOsRAyVqOg1ybNfYXGpUF7vusHXUNhR1t
         xFPfmmOEZBwqTW8CkXf8KHvH2GNqXJKm7XuMBpxyp6777x24VUftjnwpNFdkJSB+krss
         O07Y526+NGdX+W0AvGEg2LuqMqW6WFClQutRh2hByCLwVEQpzX+Dmyc+eVO5EuFdXk8T
         RPXfTfr9yBpOFJUMySHf+DcnL4W97kFeLopWtG+5NmKQHFnvxKm7YLxGtptkWp5D8nbT
         nSS1e1QwbrhaACMyTF9u1CS7hGMiMiQ59cErA1YsBbIPnCHKBuLkdvUma7FOS2frRN5Y
         lxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ii5AZc0sCiAhIDdCRLnawijtkmp0gvWRQuJM4Bu9WXg=;
        b=ZfDWwkf9Q9D+0Chw35mStFIfn1iufkbvKrt4fB+R6vNTISaKJ0yPMmhXPNkxMJCwfy
         +N5EXT8WejOaoJFt/A9PQzRGeOpLene/4jBc8kTRCvLTK2279nb4cNOVttwrl75uMM2A
         ISwFoqasM2KR8fMMQleqGp6Oq73uhfAuGkZlZZ2DMTCUBdygHeLvq8s8/lCdhDDFXIxe
         hcHNGVkH9HQyrolP1rTHdmNhnvFmidrkHqE38tzpbNE5qNNRkeFquf+r3TVbH6b8Ig5f
         2NsROPgfCM38DEky3I6++0+cYlmgRIdZlb+97hgGh6ST/lVuZvtTbPsLDBrZwSErIO25
         XdZw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,348,1517904000";
   d="scan'208";a="26315956"
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
Subject: [PATCH v4 03/22] iommu/vt-d: add a flag for pasid table bound status
Date: Thu, 22 Mar 2018 20:11:55 -0700
Message-Id: <1521774734-48433-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595696326206359566?=
X-GMAIL-MSGID: =?utf-8?q?1595696326206359566?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Adding a flag in device domain into to track whether a guest or
user PASID table is bound to a device.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/linux/intel-iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 13b44bb..e4a16dc 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -446,6 +446,7 @@ struct device_domain_info {
 	u8 pri_enabled:1;
 	u8 ats_supported:1;
 	u8 ats_enabled:1;
+	u8 pasid_table_bound:1;
 	u8 ats_qdep;
 	u64 fault_mask;	/* selected IOMMU faults to be reported */
 	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
-- 
2.7.4

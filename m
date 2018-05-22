Return-Path: <rajatja@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527028110; cv=none;
        d=google.com; s=arc-20160816;
        b=RxMGZYSg19X2Uib6uqtO91dcxbVM3qhCGqndIO/+vVxXOZCOkuW2T62KKn/KiPDjuL
         MIYa5wz/1XbwggLr3ND7k4mjUCgzLpvDH+rCtTKmvgNjrxi+CtgFB1bVL+szLc1toRVc
         cRgl3ZEuejimNY0Ddkaz4VzDJBtuWbQ5v6xwrW1LrL3N8N9nLUpFr4HXz3t5qvTVNE1J
         EpGYes1FiA2b6KZYJWpRfXZyTiawNLhgiVfP3x5RNqM/bTzPeA+YeWiE3As9bNbj06OW
         33v4sjkSZfIg/xnh5XETP8wH9juuspUdKMoCabuUKpZSSbjagsEvN0wGnzGoFVV1i1l5
         2BHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=z7VkBQQlYBnvGN1Gtxd8V7KUxPUVslFvPtw1dHurOCM=;
        b=CIKoqb58npFjft1/e+5agALMdZ8oot/95ZAMdcfTNIHl+66x4jMS2GE9VQM1NTLBjR
         4d33PsEDs6t6/VDY6fMuj/NSTIL7UIbm+xOpDLGv3XuVOTNF5j+PVU58nIibpgVVoTC1
         vH7vYYUVnuLb7pBY/SeDREnTTzQdu4IVEcMR2t5urZ+CnIOrA8H8sccikkK3jaQN2JgH
         IIaLUliSdGMkB9Wj35OTItSrKnFPRbszd4H3jFhsRpGimvZmnItyzOHLmMc1AJVNUJ9e
         /13G6KQJ3sp67hu+sg6EGO3YqdYkeopoqPnSKZwu6o0MKRbvH5bUDCXskQQIOQL85JUS
         n7aw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Im6X19go;
       spf=pass (google.com: domain of rajatja@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rajatja@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Im6X19go;
       spf=pass (google.com: domain of rajatja@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rajatja@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZrRiuC9iS72kd4aGlNn5MMtdQyVn0H3/m5JAUn0kvnd2dsIr1Zj8+8Wi4tngIzM5X4VAL9eFg==
From: Rajat Jain <rajatja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajat Jain <rajatja@google.com>,
	Frederick Lawler <fred@fredlawl.com>,
	Oza Pawandeep <poza@codeaurora.org>,
	Keith Busch <keith.busch@intel.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Thomas Tai <thomas.tai@oracle.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jes Sorensen <jsorensen@fb.com>,
	Kyle McMartin <jkkm@fb.com>
Cc: rajatxjain@gmail.com
Subject: [PATCH 5/5] Documentation/PCI: Add details of PCI AER statistics
Date: Tue, 22 May 2018 15:28:05 -0700
Message-Id: <20180522222805.80314-6-rajatja@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180522222805.80314-1-rajatja@google.com>
References: <20180522222805.80314-1-rajatja@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601205027389634414?=
X-GMAIL-MSGID: =?utf-8?q?1601205027389634414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add the PCI AER statistics details to
Documentation/PCI/pcieaer-howto.txt

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 Documentation/PCI/pcieaer-howto.txt | 35 +++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/PCI/pcieaer-howto.txt b/Documentation/PCI/pcieaer-howto.txt
index acd0dddd6bb8..86ee9f9ff5e1 100644
--- a/Documentation/PCI/pcieaer-howto.txt
+++ b/Documentation/PCI/pcieaer-howto.txt
@@ -73,6 +73,41 @@ In the example, 'Requester ID' means the ID of the device who sends
 the error message to root port. Pls. refer to pci express specs for
 other fields.
 
+2.4 AER statistics
+
+When AER messages are captured, the statistics are exposed via the following
+sysfs attributes under the "aer_stats" folder for the device:
+
+2.4.1 Device sysfs Attributes
+
+These attributes show up under all the devices that are AER capable. These
+indicate the errors "as seen by the device". Note that this may mean that if
+an end point is causing problems, the AER counters may increment at its link
+partner (e.g. root port) because the errors will be "seen" by the link partner
+and not the the problematic end point itself (which may report all counters
+as 0 as it never saw any problems).
+
+ * dev_total_cor_errs: number of correctable errors seen by the device.
+ * dev_total_fatal_errs: number of fatal uncorrectable errors seen by the device.
+ * dev_total_nonfatal_errs: number of nonfatal uncorr errors seen by the device.
+ * dev_breakdown_correctable: Provides a breakdown of different type of
+                              correctable errors seen.
+ * dev_breakdown_uncorrectable: Provides a breakdown of different type of
+                              uncorrectable errors seen.
+
+2.4.1 Rootport sysfs Attributes
+
+These attributes showup under only the rootports that are AER capable. These
+indicate the number of error messages as "reported to" the rootport. Please note
+that the rootports also transmit (internally) the ERR_* messages for errors seen
+by the internal rootport PCI device, so these counters includes them and are
+thus cumulative of all the error messages on the PCI hierarchy originating
+at that root port.
+
+ * rootport_total_cor_errs: number of ERR_COR messages reported to rootport.
+ * rootport_total_fatal_errs: number of ERR_FATAL messages reported to rootport.
+ * rootport_total_nonfatal_errs: number of ERR_NONFATAL messages reporeted to
+                                 rootport.
 
 3. Developer Guide
 
-- 
2.17.0.441.gb46fe60e1d-goog

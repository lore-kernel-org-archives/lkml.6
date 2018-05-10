Return-Path: <jrdr.linux@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525962018; cv=none;
        d=google.com; s=arc-20160816;
        b=jYh8/DfM9qYKcmU3VfwIbCpl0SyMb1eZcFnqhO8mSfrknP6bp6ocl/LFNkKXeG6jCG
         ktRSdZXQTEgPDbjgnYl1kEs5Xgm1DCvoroa+XlSOOoGFvUfPkK/IHNEvn4Q6oU5SPBqD
         8kCpwwLcRDIPU2LnfK7hmwKBA2VRpfJLbjoCJFCO1uTv3Nhe0rVmUKBsbL1vMn1xFhro
         4JpMFrCUzmdIO2uACPKIo5JZdS7+j9UgcmQnALZSwMPcrlXKi7X/L5wpe5T+RkPbmz9V
         sJIfQOQG3stdg6rx2xKZR7p6C71S9plG1kXZh5eHKXjsgcEBpSvjz8CMDbVuHhy0v1KE
         J7bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=fL5wirfNI/ypXNWdMdwRYhJlc2EGVz1q2EQvKiAO0Hk=;
        b=M02Ciib0GtDNc5RKt9Bbfrnu7fvQ0ZxSimpF+s9B5liCR8bTxNC1wd7/rWHDfKgqGS
         SSh7nmCkZJPcTaxJRBBj94+tsfuXI1LXbQbkEVJq90ewuX8JVVYBiAadhHn8xYppb5RM
         vFNSOSdRaoVzSotSNUixiLO8qtf1w5s3j6wvlObkVz2b3pO7NKhUG7b1ZgvWQknDWC0M
         2x2zARWhQSJwNCYlti4xqwsLCtr22VnTyAiBA+4ylezrFbvFySkS7qiyzWEWA0sXs8XM
         h4pju4fpUderiAeZf0hinWU2HJVjrGYNwAJbv7fO6jU7rak5xikPDswzftMuD6M3oY41
         HkKw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=J2lMXZTz;
       spf=pass (google.com: domain of jrdr.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jrdr.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=J2lMXZTz;
       spf=pass (google.com: domain of jrdr.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jrdr.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZp4/PKrhrFDGAMzvcyocBTrW9MV+Hh366JQxv43Xc7Xu1nMpj27q/1sIIhA2hrXYL037WF6gg==
Date: Thu, 10 May 2018 19:52:23 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: airlied@linux.ie, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, willy@infradead.org
Subject: [PATCH] char: agp: Change return type to vm_fault_t
Message-ID: <20180510142223.GA25519@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600087149819739591?=
X-GMAIL-MSGID: =?utf-8?q?1600087149819739591?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use new return type vm_fault_t for fault handler. For now,
this is just documenting that the function returns a
VM_FAULT value rather than an errno. Once all instances are
converted, vm_fault_t will become a distinct type.

commit 1c8f422059ae ("mm: change return type to vm_fault_t")

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 drivers/char/agp/alpha-agp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/agp/alpha-agp.c b/drivers/char/agp/alpha-agp.c
index 53fe633..c9bf2c2 100644
--- a/drivers/char/agp/alpha-agp.c
+++ b/drivers/char/agp/alpha-agp.c
@@ -11,7 +11,7 @@
 
 #include "agp.h"
 
-static int alpha_core_agp_vm_fault(struct vm_fault *vmf)
+static vm_fault_t alpha_core_agp_vm_fault(struct vm_fault *vmf)
 {
 	alpha_agp_info *agp = agp_bridge->dev_private_data;
 	dma_addr_t dma_addr;
-- 
1.9.1

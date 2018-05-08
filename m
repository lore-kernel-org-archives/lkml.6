Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756097AbeEHVam (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:30:42 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:45557 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755958AbeEHVak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:30:40 -0400
X-Google-Smtp-Source: AB8JxZpzrvTemrrK8a4iEQXDsaXooL2pQNDPVCsEGaRHmYWCKgUvLwHekYO4xXfvW3Wl2BRtlaleIQ==
Date: Tue, 8 May 2018 14:30:36 -0700
From: Tejun Heo <tj@kernel.org>
To: linux-ide@vger.kernel.org
Cc: Dave Jones <davej@codemonkey.org.uk>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH libata/for-4.17-fixes] libata: Blacklist some Sandisk SSDs
 for NCQ
Message-ID: <20180508212922.GM2368884@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From 322579dcc865b94b47345ad1b6002ad167f85405 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 8 May 2018 14:21:56 -0700

Sandisk SSDs SD7SN6S256G and SD8SN8U256G are regularly locking up
regularly under sustained moderate load with NCQ enabled.  Blacklist
for now.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Dave Jones <davej@codemonkey.org.uk>
Cc: stable@vger.kernel.org
---
Applied to libata/for-4.17-fixes.

 drivers/ata/libata-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 68596bd4..a2498f5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4493,6 +4493,10 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=15573 */
 	{ "C300-CTFDDAC128MAG",	"0001",		ATA_HORKAGE_NONCQ, },
 
+	/* Some Sandisk SSDs lock up hard with NCQ enabled.  Reported on
+	   SD7SN6S256G and SD8SN8U256G */
+	{ "SanDisk SD[78]SN*G",	NULL,		ATA_HORKAGE_NONCQ, },
+
 	/* devices which puke on READ_NATIVE_MAX */
 	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_HORKAGE_BROKEN_HPA, },
 	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_HORKAGE_BROKEN_HPA },
-- 
2.9.5

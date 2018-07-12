Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E116ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EDC20841
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="osjUxfkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EDC20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbeGLTpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:45:14 -0400
Received: from mout01.posteo.de ([185.67.36.65]:55448 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbeGLTpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:45:13 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 2F1AF210F2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 21:34:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1531424054; bh=DB7ZPPJs97XIXYyxJ19vtFky5jlLIZ2qiUrBT1QdafY=;
        h=From:To:Cc:Subject:Date:From;
        b=osjUxfktTLk7RfqlQh+LmRgkMBbH5D8e1TVV8lC7lWnpKrOEzedn6/BEp9CQX+Bwx
         yDzihd11v6h/78fzqA1kUF9ZIZncbfIPmpCh0LOPXmC66WObUNqebnnSizaIdSyW/U
         9uAStXQtCVLFsd5+ebvYKd4P2SlqARrCULd/76DlhF1DzZQXCmmGUJdx94eGGDCGt5
         cMSoKnQdAaXlPmYNOZ+1GfHCT2Oi6cOR4yq8Nw1ehQjhyFopT3Pk2MHWdUT6okHpF0
         5CoWbHgAEc0ifincVcSG6J2SnLg6Z8T7mC1WaUEaBDRGmp2AcXZa4BSsJIgri13oWM
         n9QhCqsaZFxlQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 41RR2Y6Dktz9rxZ;
        Thu, 12 Jul 2018 21:34:13 +0200 (CEST)
From:   Felix Siegel <felix.siegel@posteo.de>
To:     devel@driverdev.osuosl.org
Cc:     Felix Siegel <felix.siegel@posteo.de>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] staging: gasket: fix multi line comments style
Date:   Thu, 12 Jul 2018 21:27:14 +0200
Message-Id: <1531423694-22478-3-git-send-email-felix.siegel@posteo.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531423694-22478-1-git-send-email-felix.siegel@posteo.de>
References: <1531423694-22478-1-git-send-email-felix.siegel@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes checkpatch.pl warnings:

WARNING: Block comments should align the * on each line
Signed-off-by: Felix Siegel <felix.siegel@posteo.de>
---
 drivers/staging/gasket/gasket_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index d7fdfa1..5eeaae7 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1347,9 +1347,9 @@ static bool gasket_mm_get_mapping_addrs(
 	*virt_offset = 0;
 	if (bar_offset + requested_length < range_start) {
 		/*
-		* If the requested region is completely below the range,
-		* there is nothing to map.
-		*/
+		 * If the requested region is completely below the range,
+		 * there is nothing to map.
+		 */
 		return false;
 	} else if (bar_offset <= range_start) {
 		/* If the bar offset is below this range's start
@@ -1507,7 +1507,7 @@ static enum do_map_region_status do_map_region(
  * Calculates the offset where the VMA range begins in its containing BAR.
  * The offset is written into bar_offset on success.
  * Returns zero on success, anything else on error.
-*/
+ */
 static int gasket_mm_vma_bar_offset(
 	const struct gasket_dev *gasket_dev, const struct vm_area_struct *vma,
 	ulong *bar_offset)
-- 
2.7.4


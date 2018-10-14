Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3042DC7112B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F319920645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F319920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbeJNXf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:35:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36099 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727851AbeJNXL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:57 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLl-0004cJ-0Z; Sun, 14 Oct 2018 16:30:37 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLZ-0000hc-Nj; Sun, 14 Oct 2018 16:30:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Sekhar Nori" <nsekhar@ti.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.200997759@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 321/366] ARM: davinci: board-dm646x-evm: set VPIF
 capture card name
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sekhar Nori <nsekhar@ti.com>

commit bb7298a7e87cf3430eb62be8746e5d7a07ca9d7c upstream.

VPIF capture driver expects card name to be set since it
uses it without checking for NULL. The commit which
introduced VPIF display and capture support added card
name only for display, not for capture.

Set it in platform data to probe driver successfully.

While at it, also fix the display card name to something more
appropriate.

Fixes: 85609c1ccda6 ("DaVinci: DM646x - platform changes for vpif capture and display drivers")
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm/mach-davinci/board-dm646x-evm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -541,7 +541,7 @@ static struct vpif_display_config dm646x
 		.outputs = dm6467_ch0_outputs,
 		.output_count = ARRAY_SIZE(dm6467_ch0_outputs),
 	},
-	.card_name	= "DM646x EVM",
+	.card_name	= "DM646x EVM Video Display",
 };
 
 /**
@@ -699,6 +699,7 @@ static struct vpif_capture_config dm646x
 			.fid_pol = 0,
 		},
 	},
+	.card_name = "DM646x EVM Video Capture",
 };
 
 static void __init evm_init_video(void)


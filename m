Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED71C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD9A20684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="mxF7WOw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD9A20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeIZRTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:19:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40668 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeIZRTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:19:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id o2-v6so1823620wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 04:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=wwz8zBFywIOWO1rrnuqL0Dod0nRCz8DA3b4cZbVIAoI=;
        b=mxF7WOw1wKgHQvAwaOBLZM9o9eqZ0iovq8UXhuBMSrxT/t8uGjylqebrGbAW3Jwxmt
         O3K2lDXvRWI7D2whocFg85cCqK0KVc4W8uiMQJFdEtQL8MAoliTHmE6upcXY4FlTOg/x
         bgf+oHZlTHON9lFQ1EoMDy05n97rRBdVNUQ4W7cblag3NcqDvfPBAH8EO86f/XzIZ9LW
         /AGsTjDOFqvEXGPTDGZkgbPKHs2TAgAKZyPAxFxpcUoI+W99HgWZ5ZcVQ48yH5KuKKgO
         AlgHYFqovQ/Pm+jo4Z3pGdsl9m67oFEVCcmA0ukbGlEBlbSr05ytH4GDQrirDQqMeK6F
         dCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=wwz8zBFywIOWO1rrnuqL0Dod0nRCz8DA3b4cZbVIAoI=;
        b=g8XcvOp1xxqA+MS9VpqDNSF7+r6Fn4eeqrY+WHi3EFlK3nIDbLV30ygcxAQtcWSmph
         hjGk20oQGCyGYCV+4n8A3gUIP9epqGJnC3QrqneC3n+OikzjRgy9zvHSwr4mVTB/e79n
         OdEk5Dk6khvXHyQL3YFHQF9c+Qc1iWL/HjoInqmnPgVBPGozA3nMP04OI0SDx7GTmPKi
         59+FobEbPmnK1+/NMxHma2RxjxGNEJF9U1T0hZ+L6v3/4n3c6ux8PoYFXavLfpxAeW4Y
         84Y3/Z6o115sywXVEMh1YxKiRLCw49dKpNrb/b2+zCx5PIVb+ay16Xy8inAV2eEz+0TL
         BxFA==
X-Gm-Message-State: ABuFfojcLG4TrrxBX8rbFRQ8ZCdtdFbup9R3q5CbEOu5GGSMGGvbO2Wc
        u/nABmMC70Vkc1oWq6+FLsyUXhnFdi9rtg==
X-Google-Smtp-Source: ACcGV62kPoHeVNxYNhyOWkljUiiAnUzzbyjwcYiGqjIMG3lUVYzKVYoabVlVAU7ahColrEx9O/MfRg==
X-Received: by 2002:a1c:8c08:: with SMTP id o8-v6mr4196975wmd.60.1537960001738;
        Wed, 26 Sep 2018 04:06:41 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id v6-v6sm4860810wrr.60.2018.09.26.04.06.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Sep 2018 04:06:41 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gregkh@linuxfoundation.org, geert@linux-m68k.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] of: base: Fix english spelling in of_alias_get_alias_list()
Date:   Wed, 26 Sep 2018 13:06:39 +0200
Message-Id: <b64be28f7705a91fcb84b9c59ca830e057c71d96.1537959997.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix english spelling in of_alias_get_alias_list().

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Greg: Please apply it on the top of tty-next because patch is going via
your tree.

---
 drivers/of/base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 33011b88ed3f..ffcbb2963ba2 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1948,7 +1948,7 @@ int of_alias_get_id(struct device_node *np, const char *stem)
  * @matches:	Array of OF device match structures to search in
  * @stem:	Alias stem of the given device_node
  * @bitmap:	Bitmap field pointer
- * @nbits:	Maximum number of alias ID which can be recorded it bitmap
+ * @nbits:	Maximum number of alias IDs which can be recorded it bitmap
  *
  * The function travels the lookup table to record alias ids for the given
  * device match structures and alias stem.
@@ -1971,7 +1971,7 @@ int of_alias_get_alias_list(const struct of_device_id *matches,
 			 __func__, app->stem, app->id);
 
 		if (strcmp(app->stem, stem) != 0) {
-			pr_debug("%s: stem comparison doesn't passed %s\n",
+			pr_debug("%s: stem comparison didn't pass %s\n",
 				 __func__, app->stem);
 			continue;
 		}
@@ -1986,7 +1986,7 @@ int of_alias_get_alias_list(const struct of_device_id *matches,
 			pr_debug("%s: Allocated ID %d\n", __func__, app->id);
 			set_bit(app->id, bitmap);
 		}
-		/* Alias exist but it not compatible with matches */
+		/* Alias exists but it not compatible with matches */
 	}
 	mutex_unlock(&of_mutex);
 
-- 
1.9.1


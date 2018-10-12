Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCDBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7372087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="vqOrtOTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7372087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeJLNOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:14:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34985 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbeJLNOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:14:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id e187-v6so11702357wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 22:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Zsa0cn6PGxfFyqi8Z9uVse59foJB0FibfI32UvedOAo=;
        b=vqOrtOTNrFee1rr02zOGYDVqor+mAGw7DghaFHaDs9oReY4Dt4+IphwapvPCknS0jz
         gvMFfhSFd3dRv3cxWB5dnaab7pJ0ysRXIxO0mH09LjJMmSqjxX4fAPB8uMfYvAoBe40F
         3395JBc0dH+mw0C/f76blbV+qpAohhWGFrT8EOAg4iROVsIxl48YRBgKxdIJMzvv6ByC
         pkjMMjj8HHUfJIC+rZYP6k8kRfkF2qCbpZL96mVFRQzYqZUJgB6t80tjvrdnVf151PU+
         FeeiwRxmH3yuuyZWbjyen7c/f7SJRPl8W3Mmd0jgufD+iJ5u6WfB4ygD3XLu7020GF/F
         hkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Zsa0cn6PGxfFyqi8Z9uVse59foJB0FibfI32UvedOAo=;
        b=UWztlmKZv9OYEHgiUwtOQXSFx1bwymk9Gusz3zbeNCUPV6fqsV4SAWfmkX9tHSVcQH
         QpcILB+VYFHODQUBsPeHGkMUfb9pfrBOFRRiblrrnKv2FLXgbahd5FubXgpwwOTjem8w
         e80Qn06E2iUfSJBILXlYP507lpG3kXWc7XBnpN1WYNZBsVON0lG0JZHmuF9Dg2qYYp79
         tGRhUGxnLG6Q0YXKxZbA+NjvkI1pUDNDW91djAKj7HsMQuDNGtX2Og/sLdFOrvUyJ4Qr
         VJJgHcaCv/HqLZ8c6D//ejbTvRCAKzQao+Mw5imp2CUSojRWhyZ2kVtjf2zJbfZFrk3Y
         31Ew==
X-Gm-Message-State: ABuFfojbfFbpfB6g/DJRQa6GJQdyuKNhXSqLXmVlp8m/X2zS4lVPL3r/
        kYA6Y6+HLk3aBeYkxlo2+FYJR6o1oVvCqw==
X-Google-Smtp-Source: ACcGV60ZGyrjuCdV2qwAeihL8gvMZmXxJwP368foZDPvek5hnbuK3DQt2KNnzceiMPfKymyi4F7Wsg==
X-Received: by 2002:a1c:6655:: with SMTP id a82-v6mr4187560wmc.10.1539322996790;
        Thu, 11 Oct 2018 22:43:16 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id q77-v6sm415316wmd.33.2018.10.11.22.43.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Oct 2018 22:43:16 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        geert@linux-m68k.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] of: base: Change logic in of_alias_get_alias_list()
Date:   Fri, 12 Oct 2018 07:43:11 +0200
Message-Id: <1bc1488a4cbf21fafc64269958ba3ed04e0a3c1c.1539322989.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check compatible string first before setting up bit in bitmap to also
cover cases that allocated bitfield is not big enough.
Show warning about it but let driver to continue to work with allocated
bitfield to keep at least some devices (included console which
is commonly close to serial0) to work.

Fixes: b1078c355d76 ("of: base: Introduce of_alias_get_alias_list() to check alias IDs")
Fixes: ae1cca3fa347 ("serial: uartps: Change uart ID port allocation")
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
 - Use EOVERFLOW instead of EINVAL - Rob

I have looked at it and I don't think there should be necessary to
report error immediately back with partially initialized bitfield.
The reason is that still there could be a console device which is most
likely below that max limit and it is worth to return at least that nbits
properly filled.
It will also enable cases that you can still continue to use aliases
higher then fields prepared for devices without alias.

To be fixed patches are present in tty-next branch.
And this patch depends on
"of: base: Fix english spelling in of_alias_get_alias_list()"

---
 drivers/of/base.c                  | 22 ++++++++++++----------
 drivers/tty/serial/xilinx_uartps.c |  2 +-
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 908de45f966b..6418205a05f5 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1953,13 +1953,15 @@ int of_alias_get_id(struct device_node *np, const char *stem)
  * The function travels the lookup table to record alias ids for the given
  * device match structures and alias stem.
  *
- * Return:	0 or -ENOSYS when !CONFIG_OF
+ * Return:	0 or -ENOSYS when !CONFIG_OF or
+ *		-EOVERFLOW if alias ID is greater then allocated nbits
  */
 int of_alias_get_alias_list(const struct of_device_id *matches,
 			     const char *stem, unsigned long *bitmap,
 			     unsigned int nbits)
 {
 	struct alias_prop *app;
+	int ret = 0;
 
 	/* Zero bitmap field to make sure that all the time it is clean */
 	bitmap_zero(bitmap, nbits);
@@ -1976,21 +1978,21 @@ int of_alias_get_alias_list(const struct of_device_id *matches,
 			continue;
 		}
 
-		if (app->id >= nbits) {
-			pr_debug("%s: ID %d greater then bitmap field %d\n",
-				__func__, app->id, nbits);
-			continue;
-		}
-
 		if (of_match_node(matches, app->np)) {
 			pr_debug("%s: Allocated ID %d\n", __func__, app->id);
-			set_bit(app->id, bitmap);
+
+			if (app->id >= nbits) {
+				pr_warn("%s: ID %d >= than bitmap field %d\n",
+					__func__, app->id, nbits);
+				ret = -EOVERFLOW;
+			} else {
+				set_bit(app->id, bitmap);
+			}
 		}
-		/* Alias exists but is not compatible with matches */
 	}
 	mutex_unlock(&of_mutex);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(of_alias_get_alias_list);
 
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index d452dceb0cb3..b8f8abc96631 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1393,7 +1393,7 @@ static int cdns_get_id(struct platform_device *pdev)
 	if (!alias_bitmap_initialized) {
 		ret = of_alias_get_alias_list(cdns_uart_of_match, "serial",
 					      alias_bitmap, MAX_UART_INSTANCES);
-		if (ret) {
+		if (ret && ret != -EOVERFLOW) {
 			mutex_unlock(&bitmap_lock);
 			return ret;
 		}
-- 
1.9.1


Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEBEC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03C62085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="WQeC82nj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03C62085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeJHTau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:30:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32902 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeJHTas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:30:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id e4-v6so20622886wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=NaiVNtYCDKE0Z4Xwjd4fDLoCLSWdI5pEGC87+tacw3U=;
        b=WQeC82njnSR42hpup7wZXwBNSubTb3gf8gaJFg7bXHyu8ZR7HAkKY8a8aICfTmvvu8
         N5lSQVmNv0t8akMB8KP6EUtsW6pvMeDVbTAY8cgaRoMck1/FE3tSMzKVtY2HClK9uiFz
         bFTAuODAP3sFvJENnfGlrjM/QqQIncgpOUm/VvGAnKwYJkiMYPnmkqFaKC3uzmni0ILm
         akaN3v5yhXZMXo8sJ38Z7PRc9DmdBKx2Y86PqKexySVJImVpGvrxF1QcCxgO7R78X4BM
         7r5TMdooiBNjsQ+IOkSHvFJ14HLznWncYsxEdKOgaPQEd0t5Va5nhy1WrxB43guPUG03
         tXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=NaiVNtYCDKE0Z4Xwjd4fDLoCLSWdI5pEGC87+tacw3U=;
        b=OCi4nlRKl7HFBthPl1BUKCn0PCIJYBB2RKKJoEqvdN0RTrcknFHKOcoxw9BIZjDszV
         LgZbAj7KgciGcrZSdOO2WYgNMC0z/FBWFMg80z2j6I2Zn1VWtuKHqBDksz4gbGdzqAkk
         Ci7jvY2cjQp2TLwpPhmz1RUTr0Ka/Kj5A1nWyMHCrpnfyTOnSLA9ss954F2laP7sO/V+
         AEXy9o4TYyAbk2iasXSquOAacDx8Ij7Ny8uPpF5zU48ChUnBLcHOLXDXpMaWkPyaayoG
         jkLgp+fkqhEVpWAR98sw7bwymCjcpjuDRj9U3ZsfUSr30hUZFQeZDkKqFoKw/e5xqoRU
         JqpA==
X-Gm-Message-State: ABuFfoidSygDjy633WyXRKijWpKMyXPa4IQY8GhooZ8N0HED2qk17oMT
        jYfrwzk1rMtZz9Hvw2pCXMa2WQCYSfnCnQ==
X-Google-Smtp-Source: ACcGV600COeaVu+CzzeFlBm8kweUyJWeRQdsiR930Wed7QACMfRbtGc6jBZWx5rfwHa+qMsR6mqMxA==
X-Received: by 2002:adf:da43:: with SMTP id r3-v6mr16595987wrl.221.1539001159564;
        Mon, 08 Oct 2018 05:19:19 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id r16-v6sm22635162wrv.21.2018.10.08.05.19.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Oct 2018 05:19:19 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        geert@linux-m68k.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] of: base: Change logic in of_alias_get_alias_list()
Date:   Mon,  8 Oct 2018 14:19:18 +0200
Message-Id: <e879d07e97b7f7fc46543315e9fb1b4bc8b7a352.1539001154.git.michal.simek@xilinx.com>
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

I have looked at it and I don't think there should be necessary to
report error immediately back with partially initialized bitfield.
The reason is that still there could be a console device which is most
likely below that max limit and it is worth to return at least that nbits
properly filled.
It will also enable cases that you can still continue to use aliases
higher then fields prepared for devices without alias.

To be fixed patches are present in tty-next branch.

---
 drivers/of/base.c                  | 22 ++++++++++++----------
 drivers/tty/serial/xilinx_uartps.c |  2 +-
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 908de45f966b..0b9611e196d1 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1953,13 +1953,15 @@ int of_alias_get_id(struct device_node *np, const char *stem)
  * The function travels the lookup table to record alias ids for the given
  * device match structures and alias stem.
  *
- * Return:	0 or -ENOSYS when !CONFIG_OF
+ * Return:	0 or -ENOSYS when !CONFIG_OF or
+ *		-EINVAL if alias ID is greater then allocated nbits
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
+				ret = -EINVAL;
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
index d452dceb0cb3..29a18103182d 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1393,7 +1393,7 @@ static int cdns_get_id(struct platform_device *pdev)
 	if (!alias_bitmap_initialized) {
 		ret = of_alias_get_alias_list(cdns_uart_of_match, "serial",
 					      alias_bitmap, MAX_UART_INSTANCES);
-		if (ret) {
+		if (ret && ret != -EINVAL) {
 			mutex_unlock(&bitmap_lock);
 			return ret;
 		}
-- 
1.9.1


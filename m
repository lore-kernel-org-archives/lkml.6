Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E8AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85CB20881
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="yWcsLctJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfAYKzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:55:14 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39983 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfAYKzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:55:14 -0500
Received: by mail-lf1-f67.google.com with SMTP id v5so6601799lfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 02:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/bqEREUNQF0lnHixYiWX5TuONOArgR+FJLmGNjXRqiU=;
        b=yWcsLctJT6Nb5vAUj5CbqC4ha9zM7VOsn0uD61e9fsWQ+Q8wkOEY6SJ5TbSSA38Veg
         GlxTyFYmsR4slBR8o4SxPtPDI/pSg8OKq5yuhOY+gvYLgZv/xuTfpcVVqS8tVe6zyxkX
         nwWjryJLF+d4vCkYfRL5zcmKhPv5SK6SEQqUpjsK7ckzNCPwmN0sNBa6s92ujZjP3V25
         uYqa7t+EF4iqk2Qz5myQ8FUlxW/23TTdmccnjA9R42HHy9d3Kg9rnTlfHUdyuxOtafR7
         ZVq0PVmha0DxF+vIDCyJ8z4in5ALZRaGqdn39XNOooxJN6fzk2cdoD7hNLnl+egWnewO
         6e9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/bqEREUNQF0lnHixYiWX5TuONOArgR+FJLmGNjXRqiU=;
        b=AhUNApnS5OskN4T7Fa7oJv1ovDp8tBehaJqkVVABVVKCWXZ/0d2T/P4393u5VobU43
         XI7DbL5wgKYLNemTz0RxRncvasY/b5Apf+lr8Lts4ftuBpHw1tMKZP1CHVsuT8Gtcw6J
         SiKzoPEFF47Lul/bY8r6G9flA4PWQ7Qlu3bZMvGQ2VKp3O1kTjMJfs1aLYBDnRY3Wl5G
         3HC17Ek0yggJCyUOgq3McJlwShZQzcmge0cce2iOxj/Qzxy1/dleBKzR829M1aqbID9X
         y8xeunqu2Ct2txaoGS1aaMuXFjQsr9KHraUOegiQQXY5sT9Vfhk9GL2yr4GHy9AGAQgJ
         gsBg==
X-Gm-Message-State: AJcUukdTFIfrSFebz4JPq3FUgypohfQrO06ah1hA9g3eeJHdkxiN2fIx
        +D4Uj2kc/ecOVtawUkuZ6TfyjitlWaM=
X-Google-Smtp-Source: ALg8bN72lQAgHijsMPAXbC2JYyfDqOKTT6xpQcEFO/wNyj/7XjyWuoyJNJGMFoCGeV4abP8ov4cz6A==
X-Received: by 2002:a19:5394:: with SMTP id h20mr7964276lfl.75.1548413711504;
        Fri, 25 Jan 2019 02:55:11 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id a62sm1424257lfa.37.2019.01.25.02.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 02:55:10 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>,
        Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 1/1] spi-nor: always respect write-protect input
Date:   Fri, 25 Jan 2019 11:55:07 +0100
Message-Id: <20190125105507.2733-1-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The status register bit SRWD (status register write disable) is
described in many words in the datasheets but effectively boils down to:

i) if set, respect WP# when trying to change protection bits;
ii) if unset, ignore WP# when trying to change protection bits

In short, the bit determines whether the WP# signal is honored or not.

It's difficult to imagine the use-case where the WP# is connected and
asserted but the user doesn't want to respect its setting.  As such,
this patch sets the SRWD bit unconditionally so that the WP# is _always_
respected; hardware that doesn't care about WP# normally won't even have
it connected.

Tested on a Cypress s25fl512s.  With this patch, the WP# is always
respected, irregardless of whether any flash protection bits are set.

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
CC: Marek Vasut <marek.vasut@gmail.com>
CC: David Woodhouse <dwmw2@infradead.org>
CC: Brian Norris <computersforpeace@gmail.com>
CC: Boris Brezillon <bbrezillon@kernel.org>
CC: Richard Weinberger <richard@nod.at>
CC: linux-mtd@lists.infradead.org
---
 drivers/mtd/spi-nor/spi-nor.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index c6064479b614..c960c097e0bc 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1230,9 +1230,6 @@ static int stm_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 
 	status_new = (status_old & ~mask & ~SR_TB) | val;
 
-	/* Disallow further writes if WP pin is asserted */
-	status_new |= SR_SRWD;
-
 	if (!use_top)
 		status_new |= SR_TB;
 
@@ -1312,10 +1309,6 @@ static int stm_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 
 	status_new = (status_old & ~mask & ~SR_TB) | val;
 
-	/* Don't protect status register if we're fully unlocked */
-	if (lock_len == 0)
-		status_new &= ~SR_SRWD;
-
 	if (!use_top)
 		status_new |= SR_TB;
 
@@ -3918,6 +3911,7 @@ static int spi_nor_setup(struct spi_nor *nor,
 static int spi_nor_init(struct spi_nor *nor)
 {
 	int err;
+	int sr;
 
 	/*
 	 * Atmel, SST, Intel/Numonyx, and others serial NOR tend to power up
@@ -3953,6 +3947,16 @@ static int spi_nor_init(struct spi_nor *nor)
 		set_4byte(nor, true);
 	}
 
+	/* Always respect the WP# (write-protect) input */
+	sr = read_sr(nor);
+	if (sr < 0) {
+		dev_err(nor->dev, "error while reading status register\n");
+		return -EINVAL;
+	}
+	sr |= SR_SRWD;
+	return write_sr_and_check(nor, sr, SR_SRWD);
+
+
 	return 0;
 }
 
-- 
2.19.1


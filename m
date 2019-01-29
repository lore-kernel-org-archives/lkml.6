Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6451C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCAC2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1Z2U+FF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbfA2VrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:47:08 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37463 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfA2VrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:47:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so17310596edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 13:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n8XV4iq9rA+fxnqZgdrOpJNvxbAjFgBIFBi+69D7N30=;
        b=O1Z2U+FFs/xXdhyfCIX4vQ/y60cjlT6HDkQbbCzsFOYaAYRvGEkqWzMxH11eUvLywW
         gBC+m1/yoJuwnGH7V1gi5rIVNPCWa+nNl1hC7Sd+KBIMIbbX5SBL+9onypPIPsR2noru
         HnKTU1rdKKgFWt+ypI5KA39EYIQyXaSjgBiBKTTmFcXMgPw5MJCzTEJs+z790N1/x+8t
         +S2rcqQ3F+CTQvGHasCuk7VWgQGkoerq+fzYx2HRoIETjKXC/Lq6o+vIH07RMxm/o1b9
         m7r70uUp9Gw+59LBw9u7Q5j8kOD7XcvLQlSqTqs3L8PuLVaZqZ0rPG10CIHFAtvwhSXD
         +BAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n8XV4iq9rA+fxnqZgdrOpJNvxbAjFgBIFBi+69D7N30=;
        b=H2qAscyFWnNteX8YQkK0VhrX/GCRO8bPUGTzrV1e0SLdRvxYJ9nhv05L6GpW5juCXE
         E6CoktujKaPpZ3FsbBiENyKvLiIJvb5tDar+GytrjDU48DwTu7Rj0W1U+kS0OvYfM0xm
         8GabicF6R7s7I2tV4ZkZYCWRe5pT5JQkYsPDoWUfGqnqVeHrJIFf9wur+yEh+QVPfvSx
         dRiqh9mcmJeAYdOy3dOqb7dqVsCWGzuDjrIc6lwqUyHq1fxh2vYZatLHNZURgbBnM9Uc
         8MVH2GU1P02zC6dgkc/ukiAMHbZUWWeHNmVNzBRhVMOKDSy154z5IcTb99lhvmyoME6x
         Jpcw==
X-Gm-Message-State: AJcUukeqxTlmU4DSxROIbc5k9iS6vb2f6JhU6Pd4sWvxfLvA5XthiVyg
        i3m62S6E1gEuJVlQlner0SM=
X-Google-Smtp-Source: ALg8bN47o6Rqe+uaZF9wFXjaoxci4e+cXndEnBBvjiH+TT4ecdA3X+dxfIjNsZrcwc7TRCDv49DITw==
X-Received: by 2002:a50:8d12:: with SMTP id s18mr27666403eds.32.1548798424905;
        Tue, 29 Jan 2019 13:47:04 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id y16sm8342edb.41.2019.01.29.13.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 13:47:03 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Liang Yang <liang.yang@amlogic.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] mtd: rawnand: meson: Fix linking error on 32-bit platforms
Date:   Tue, 29 Jan 2019 14:46:57 -0700
Message-Id: <20190129214657.5877-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm little endian allyesconfig:

  ld.lld: error: undefined symbol: __aeabi_uldivmod
  >>> referenced by meson_nand.c
  >>> mtd/nand/raw/meson_nand.o:(meson_nfc_setup_data_interface) in archive drivers/built-in.a

The dividend tBERS_max is u64, meaning we need to use DIV_ROUND_UP_ULL
(which wraps do_div) to prevent the compiler from emitting
__aebi_uldivmod.

Fixes: 2d570b34b41a ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/mtd/nand/raw/meson_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index e858d58d97b0..6f12a96195d1 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -1116,8 +1116,8 @@ int meson_nfc_setup_data_interface(struct nand_chip *nand, int csline,
 				       div * NFC_CLK_CYCLE);
 	meson_chip->tadl = DIV_ROUND_UP(PSEC_TO_NSEC(timings->tADL_min),
 					div * NFC_CLK_CYCLE);
-	tbers_clocks = DIV_ROUND_UP(PSEC_TO_NSEC(timings->tBERS_max),
-				    div * NFC_CLK_CYCLE);
+	tbers_clocks = DIV_ROUND_UP_ULL(PSEC_TO_NSEC(timings->tBERS_max),
+					div * NFC_CLK_CYCLE);
 	meson_chip->tbers_max = ilog2(tbers_clocks);
 	if (!is_power_of_2(tbers_clocks))
 		meson_chip->tbers_max++;
-- 
2.20.1


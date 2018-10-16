Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBDFC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14B5205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TmdkXu1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14B5205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbeJPMXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:23:48 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:59710 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbeJPMXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:23:47 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w9G4XURK014518;
        Tue, 16 Oct 2018 13:33:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w9G4XURK014518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539664411;
        bh=9DhBSVXGAHdZlvSm6YziIof6Uy9YYyub7y++TQwJD50=;
        h=From:To:Cc:Subject:Date:From;
        b=TmdkXu1H8pt6pj+mqIl4iq9XVvTyYmeH8X8PGE5GOxcMKXhhYOgKkuxlw0R3mEFoC
         vgBnt02lb/R028hImUNx9m5oxTZPY+l0/UIc4cEiXza1JtPr9WOXsNRhL1KR/YVExx
         FFXL6Cs0A5NSzTCjNONayZ+P3jBQoTSG3QU8WJ4VGEnbVajXpjczJquK2EFsY6aMAp
         aOMztnjtYbtNZo5d3R38mPrghSlv4lukHuQD8NaZwnwVMH979E/dFRNcv6nQcBYb2L
         TSzKkJtS+JTFEDG+KE8+N/xGU91wlOfACkJbsInHBfcyWbul8Uqje61dzV9BQtJA3J
         Hkug5xpv6ZenQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] mtd: rawnand: denali: include <linux/bits.h> instead of <linux/bitops.h>
Date:   Tue, 16 Oct 2018 13:33:21 +0900
Message-Id: <1539664401-17651-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reason of including <linux/bitops.h> here is just for BIT() and
GENMASK macros.

Since commit 8bd9cb51daac8 ("locking/atomics, asm-generic: Move some
macros from <linux/bitops.h> to a new <linux/bits.h> file"),
<linux/bits.h> is enough for such compile-time macros.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/raw/denali.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/denali.h b/drivers/mtd/nand/raw/denali.h
index 57a5498..25c0060 100644
--- a/drivers/mtd/nand/raw/denali.h
+++ b/drivers/mtd/nand/raw/denali.h
@@ -7,7 +7,7 @@
 #ifndef __DENALI_H__
 #define __DENALI_H__
 
-#include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/completion.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/spinlock_types.h>
-- 
2.7.4


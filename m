Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE68C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835F120827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1V5SOoh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835F120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeJ3T6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:58:34 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:19853 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeJ3T6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:58:34 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w9UB5Bw0029866;
        Tue, 30 Oct 2018 20:05:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w9UB5Bw0029866
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540897511;
        bh=M6yRGBpHUd+p53zd9fWHkh1Gf0qW+k/Xw+V/E90ZVUA=;
        h=From:To:Cc:Subject:Date:From;
        b=1V5SOoh5+Nyy8L5N8lGK+zcLKz/HEgs0tH+JVSEo8RuK2Kc1aevMCXLoiddUr7meR
         KAUJVdAHnLaIfiwyQ6eiZUhk43iltfPjHPMuvSa5sI4y8LYW5JtouKJkGPWEDfeDIl
         CijCGS5UDdEAmmqIB7XoNm47ft2VHhQPnnnvX2itnh4SoMkOp1kxFeVe8lOKymrTGe
         hryeI75+O5hUFk4VEglfQvm9I/IwRsiHrKCVTSb3Wo2t7dGfvgivpdu4+vdeBSN82h
         ADhSsDXr6Nw1HkOotK6iUfKWevBthYItf4MSZ9Xb7mybvn4cMjuIeTVsI5ELg8H7h6
         cj8XBMbzUqaTw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-cadence: include <linux/bits.h> instead of <linux/bitops.h>
Date:   Tue, 30 Oct 2018 20:05:06 +0900
Message-Id: <1540897506-3075-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reason of including <linux/bitops.h> here is just for BIT() and
GENMASK() macros.

Since commit 8bd9cb51daac8 ("locking/atomics, asm-generic: Move some
macros from <linux/bitops.h> to a new <linux/bits.h> file"),
<linux/bits.h> is enough for such compile-time macros.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-cadence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 7a343b8..e241287 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -14,7 +14,7 @@
  */
 
 #include <linux/bitfield.h>
-#include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/mmc/host.h>
-- 
2.7.4


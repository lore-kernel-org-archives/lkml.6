Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2920BC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE90214F1
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="xHFkwVu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE90214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbeKQOKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 09:10:24 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34402 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeKQOKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 09:10:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id f12-v6so12046117plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 19:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=rk0sxhdj9KtpA38fFQRAocxRA5sbD33dk1fpH2uJ4Iw=;
        b=xHFkwVu+h1S8JYb2sFrbz5D40GTXA9qdcJsLpODc+IrlFCkdmpphDv8FRUONbXFMse
         kb52TOPFGkvuMuV8ZNuM8vvpCdSsE2O3w+7b/kXXihXswf0LdahNz5IyKTleo+Pkkkqa
         /6QW4KA8JyG1TIJUD0chHJ4PGiuAi27SPiRj5s+FnmK4YwcBw33cf+1ztIZHAg1KlNrc
         ttlG0ZaMt5F9B03xzX98dmGiB2yMq6/8TkXznvFUfQcWG3RmRI0f3Y0lS2r2olfzE8R/
         KrmBLs6P4+IJdYYXE3aPocEdiubCswnyTzbOvD5r/PTfbFbD13q5HuZecmXphcbCd9pG
         dojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rk0sxhdj9KtpA38fFQRAocxRA5sbD33dk1fpH2uJ4Iw=;
        b=g4gmjAtRvr5neXvBpIs/Ji4khVwdxlssDcu+pZ0pLGKP6f0tB7CvLkrrYXdOmBN6Ca
         AC/wD/H4bCkYk0Hh2lroU9/xP+P85OGb1A3XbWwCSBvJK35isPr3mLw0yUe78bblwHmN
         OywLKY9ErDshSbf40k46Sjs5+TAzEG9PSIW0ofdFXzsC4Y5ariF/egVB24C+K0WNbC84
         nkko70QPqRaLArk9n7fmC6ya6yGf53go5zVVAnaR58keo5uPJC9N3RjR96YuLnaWOukW
         +q4zGP8gnPHUuKCsqYtHXLc+WQqSXDE4ognKSj38pc2523dMdLNbfZ6Z1UGnEbvnr5VO
         TgPQ==
X-Gm-Message-State: AGRZ1gJNtuqZ8QUPCaSAAsFbQmEWRyV9+DcRXLgVHRA+3PoIZZVSVjOQ
        jiCXGPjeJwWsyErpEF7Y7VeeoA==
X-Google-Smtp-Source: AJdET5cJFa4W0A9c5OSQUqb85iHl0SzSWcFAtDdM+JCrXODdFoAY8FBscx1AyI6N12mZzIhYGvxdrw==
X-Received: by 2002:a17:902:70cb:: with SMTP id l11-v6mr13961702plt.30.1542426909701;
        Fri, 16 Nov 2018 19:55:09 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id p5-v6sm36112904pfb.109.2018.11.16.19.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 19:55:08 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        opembmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] spi: npcm: Fix uninitialized variable warning
Date:   Fri, 16 Nov 2018 19:55:04 -0800
Message-Id: <20181117035504.95804-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler has no way to know that rsize 1 or 2 are the only valid
values. Also simplify the code a bit with early return.

The warning was:

drivers/spi/spi-npcm-pspi.c:215:6: warning: 'val' may be used uninitialized in this function [-Wmaybe-uninitialized]

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/spi/spi-npcm-pspi.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index 342178e282bcd..be0539cb19e49 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -217,15 +217,23 @@ static void npcm_pspi_recv(struct npcm_pspi *priv)
 	rsize = min(bytes_per_word(priv->bits_per_word), priv->rx_bytes);
 	priv->rx_bytes -= rsize;
 
-	if (priv->rx_buf) {
-		if (rsize == 1)
-			val = ioread8(priv->base + NPCM_PSPI_DATA);
-		if (rsize == 2)
-			val = ioread16(priv->base + NPCM_PSPI_DATA);
+	if (!priv->rx_buf)
+		return;
 
-		*priv->rx_buf = val;
-		priv->rx_buf += rsize;
+	switch (rsize) {
+	case 1:
+		val = ioread8(priv->base + NPCM_PSPI_DATA);
+		break;
+	case 2:
+		val = ioread16(priv->base + NPCM_PSPI_DATA);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return;
 	}
+
+	*priv->rx_buf = val;
+	priv->rx_buf += rsize;
 }
 
 static int npcm_pspi_transfer_one(struct spi_master *master,
-- 
2.11.0


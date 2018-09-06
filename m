Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54D4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FC520659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="g4U3FApv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FC520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeIFLM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 07:12:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36761 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbeIFLM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 07:12:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id e1-v6so988274wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 23:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=drdCZGACtIDDKjoQw/oDI+FjGY3Btpe/MmFPHzLGxkg=;
        b=g4U3FApvZj0Ri4tBqK3HtfHKoozrTWC6yYI2n/aPtp61LrE4uRQKF5TpB/tPuSkyBW
         tHanbp4uNAMeM7hs3GS5BlibPa4Va/lYK/U4JL2CIrQv0NaUr2skNVAI2CZlFjqpqHiZ
         Kh6zZXEjgfLWO/KJswMKZ9JFLLNCCen/0yZ71vOOOJdzKDmeTWkif2pMV4scLXc26MTy
         DpcsxQD3Yqi+jY+EaedUSfrJn/y9qtvOalSv6dUZFF0lv7OMdflCYTEcdiQ7quKr2p9V
         0rrPdx2V8/GyNlnxEDC2JwPgDWhdgplb8BM7UTGCJCMRRKouzMu/Cc9kfjbZUqerBHVB
         O8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=drdCZGACtIDDKjoQw/oDI+FjGY3Btpe/MmFPHzLGxkg=;
        b=EHSjGFkoA0AsvUHY+zp9xc9qC0bSeexQTXT4zPzB1OWT6aJNuUvcdPbZHBh08M3ijG
         qJPKyKjYbxN2R/QaNvGV9NOZwyePJlQ/O9/1/tQFt2ZTRjnzcLAl/zhaHL9HUB60+P3N
         DjLiZ1BT78hW8TuahL6/WX6j/BygKt0VeAUv/F1JmqxZznRxYBbJn1QaWBZj9Y7DAll9
         LAXiaVhGn4JaUk7J4TywYve7fVXwvSdlXR9vLEI54eGMu/Q4WlF7izDPP8wMhkm+/dFW
         yATfD5D64rT4YJqLapvpIwFgQJHrLRnS5cQkGQzqgXE8uzSTI5DdRfTsTwvzxfSaSsG2
         2lYA==
X-Gm-Message-State: APzg51DSUsoYo++9GA3D9XGfL4gpYW2dMSJiSX1oz9m8qKFO/BN97hnG
        OFE/4R4KYdxwhXfG/M3DFKIZ3w==
X-Google-Smtp-Source: ANB0VdYlOln5RezUt/KYpUkaSFJko6791LB/QcjqXaQbcHJkcptIDkLjRQfNxWTcGI+tgw4XXLNn7w==
X-Received: by 2002:adf:e711:: with SMTP id c17-v6mr983429wrm.143.1536215941862;
        Wed, 05 Sep 2018 23:39:01 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id r66-v6sm6964761wmb.37.2018.09.05.23.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Sep 2018 23:39:01 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RESEND] zlib: remove fall through warnings
Date:   Thu,  6 Sep 2018 06:38:40 +0000
Message-Id: <1536215920-19955-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch remove all following fall through warnings by
adding /* fall through */ markers.
Note that we cannot add "__attribute__ ((fallthrough));" due to it is GCC7 only
arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:384:25: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:391:25: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:393:16: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:430:25: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:556:25: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:595:25: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:602:25: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:627:25: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:646:25: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:696:25: warning: this statement may fall through [-Wimplicit-fallthrough=]

It is easy to see that thoses fall through are needed since in each case state->mode are set to the case value just below.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 lib/zlib_inflate/inflate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/zlib_inflate/inflate.c b/lib/zlib_inflate/inflate.c
index 58a733b10387..48f14cd58c77 100644
--- a/lib/zlib_inflate/inflate.c
+++ b/lib/zlib_inflate/inflate.c
@@ -382,6 +382,7 @@ int zlib_inflate(z_streamp strm, int flush)
             strm->adler = state->check = REVERSE(hold);
             INITBITS();
             state->mode = DICT;
+	    /* fall through */
         case DICT:
             if (state->havedict == 0) {
                 RESTORE();
@@ -389,8 +390,10 @@ int zlib_inflate(z_streamp strm, int flush)
             }
             strm->adler = state->check = zlib_adler32(0L, NULL, 0);
             state->mode = TYPE;
+	    /* fall through */
         case TYPE:
             if (flush == Z_BLOCK) goto inf_leave;
+	    /* fall through */
         case TYPEDO:
             if (state->last) {
                 BYTEBITS();
@@ -428,6 +431,7 @@ int zlib_inflate(z_streamp strm, int flush)
             state->length = (unsigned)hold & 0xffff;
             INITBITS();
             state->mode = COPY;
+	    /* fall through */
         case COPY:
             copy = state->length;
             if (copy) {
@@ -461,6 +465,7 @@ int zlib_inflate(z_streamp strm, int flush)
 #endif
             state->have = 0;
             state->mode = LENLENS;
+	    /* fall through */
         case LENLENS:
             while (state->have < state->ncode) {
                 NEEDBITS(3);
@@ -481,6 +486,7 @@ int zlib_inflate(z_streamp strm, int flush)
             }
             state->have = 0;
             state->mode = CODELENS;
+	    /* fall through */
         case CODELENS:
             while (state->have < state->nlen + state->ndist) {
                 for (;;) {
@@ -554,6 +560,7 @@ int zlib_inflate(z_streamp strm, int flush)
                 break;
             }
             state->mode = LEN;
+	    /* fall through */
         case LEN:
             if (have >= 6 && left >= 258) {
                 RESTORE();
@@ -593,6 +600,7 @@ int zlib_inflate(z_streamp strm, int flush)
             }
             state->extra = (unsigned)(this.op) & 15;
             state->mode = LENEXT;
+	    /* fall through */
         case LENEXT:
             if (state->extra) {
                 NEEDBITS(state->extra);
@@ -600,6 +608,7 @@ int zlib_inflate(z_streamp strm, int flush)
                 DROPBITS(state->extra);
             }
             state->mode = DIST;
+	    /* fall through */
         case DIST:
             for (;;) {
                 this = state->distcode[BITS(state->distbits)];
@@ -625,6 +634,7 @@ int zlib_inflate(z_streamp strm, int flush)
             state->offset = (unsigned)this.val;
             state->extra = (unsigned)(this.op) & 15;
             state->mode = DISTEXT;
+	    /* fall through */
         case DISTEXT:
             if (state->extra) {
                 NEEDBITS(state->extra);
@@ -644,6 +654,7 @@ int zlib_inflate(z_streamp strm, int flush)
                 break;
             }
             state->mode = MATCH;
+	    /* fall through */
         case MATCH:
             if (left == 0) goto inf_leave;
             copy = out - left;
@@ -694,6 +705,7 @@ int zlib_inflate(z_streamp strm, int flush)
                 INITBITS();
             }
             state->mode = DONE;
+	    /* fall through */
         case DONE:
             ret = Z_STREAM_END;
             goto inf_leave;
-- 
2.16.4


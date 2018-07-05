Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3020BC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9E624069
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XBGfjxUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C9E624069
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753294AbeGEFTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:19:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54885 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752851AbeGEFTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:19:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id i139-v6so8795710wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 22:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=2eXlVhSkTKsCpSBDkL3ZbPSzmE50Bsap0W9dt7zwnfU=;
        b=XBGfjxUmjKiowwqc9/CCo79TP9ZLiHd1ErHJe+QpNUiLlNdthDwiJBqgAtD1fdTi1N
         xHCJ59V1JtwuwAargJbNLs/Oxk9pf3uugS/f2mIiHxsrXRz421GSGkhqLh9dYemmxQa4
         Irgr1X3z2rHlQghjg1+YSoFB+0uqpiJ10mkq9aENn6Is0ZMmeoi6mI6KKlnGOy3+5kkf
         PLtM/JIxfQ9UfF3OdHqf/QHpVfyMWnuOnxUcF+u+Min9I0g43BvzQNHIZLn4YAVY816Q
         SHf7WSRCM41ifbkJF3DeAkXkFGMV6BfFg+LCOM8+PYGPqlq5E2aOa886udStOsBu+BoU
         fCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2eXlVhSkTKsCpSBDkL3ZbPSzmE50Bsap0W9dt7zwnfU=;
        b=f7RKnMalU/ymcWobf1bZJ65tT4mGvI2PQdr0pL/BiGMvt3J9Q4Vtq1NWFVhpbrlXF/
         ok7oIHXwKBUUJTTbc1RZ5LR9Xgah4XSNIx70LtMvHO8lG4hOowcLnMeVp9blv3nkFzgM
         K2HhqGwCt68w8bNcCdzZGOuaLLcWm2+hdJZb8RPH8yxCESHSH8kUzPgR32YaCtt9vKPT
         LvYwR3lOp2KpIrtTJ6meuNlPlDMbY0Sm0Fztc7Lfsv/SqHqtiJPsXvQ5fI+n1j1FTWAP
         VoA/OKcEAPgFvZ7Ij3TXauogFyVvwTRsNSRK3R4IVerPPEtQG+NOP+XRC8Y452jqKRYN
         xjZw==
X-Gm-Message-State: APt69E2aTdw8AIuSMjIOELmQ2P6kk2metcmrcnPsPdVKjSZXYjUqGE7Q
        LaFjmg+Tdks1F2FF8zghuIHPwQ==
X-Google-Smtp-Source: AAOMgpfHCksPvph2sJrqo2IrW35tw3XtTQ441q+CTJybUK6vBqGwesukQyjYjvZieUmBu8A02Dq2LQ==
X-Received: by 2002:a1c:2e90:: with SMTP id u138-v6mr2821908wmu.156.1530767983245;
        Wed, 04 Jul 2018 22:19:43 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id e13-v6sm11521214wrd.9.2018.07.04.22.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 22:19:42 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] zlib: remove fall through warnings
Date:   Thu,  5 Jul 2018 05:18:37 +0000
Message-Id: <1530767917-20443-1-git-send-email-clabbe@baylibre.com>
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


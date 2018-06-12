Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B1390C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62014208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="KbbVdOL9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dv49yZ5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62014208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934833AbeFLAje (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:39:34 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56487 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933759AbeFLAja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:39:30 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id BBBF721C1C;
        Mon, 11 Jun 2018 20:39:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 11 Jun 2018 20:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Ag0aLnre2CQ/GqT91
        k+b54VEHQrsohfs4q7p52APlH8=; b=KbbVdOL9egi/sSwo3gsie0G00mN3NhETR
        qJwmAdjsMlRt1D1ZxqChrE1X/KvkczEtUabmtOnaBegksaDzvtwZeoOIQrHe1QG4
        r21YbMFwHZrLthkw/DAFnAGYFvM3avuPyx0uiIU1yNGxcvygD1Vb7p15mt2h1rrP
        2GfFCOHDSNiqd2XwkLkoVe/cR9fEi3c8//XsHc6rqaXTkjGqrfUbEEJR1X6O1cQD
        G/4jroGRQ/sDWyP/G8Yb0tr6+Kbeebd3wIweNEbKqvGaoJExgS0sVNhlsRPRNCN+
        akD0QPeP+lmChr5T7AtgteTgogMTKPLNyFDs+/L1MNKl1Pa6m/p+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Ag0aLnre2CQ/GqT91k+b54VEHQrsohfs4q7p52APlH8=; b=dv49yZ5Q
        a2dAJ7dXEiAV45EDMgaPexVEJrWJak9YAVwosYwYTAjmS0+IMjV1k68QOYnm8Ep9
        oit060SsE2Eqakw7iNTJYn1v3traXvPfzURc5J032LKssD/192AUTK/855Kj13N2
        UqgHNsMJPArpbcAM9SZvppThSbqze/mcuSLH62tBBI+nv1bD5pMdWCkFaBYLQ5kp
        Q7TYt2R6+RbGwiHSDhtIpX5QgWDFtyHXbRkd27rulkwIbFLeKDqRfNl+adOgOx4L
        msQBYfzCD06KIhhseTa+HZpay2DofrXvFl1XRPwyD3vWkRatE2pIbpbbZdVbe+GA
        kXRf+Xoq0odfGA==
X-ME-Proxy: <xmx:QRYfWw65EiVIjhdoTuv4vFBM157KH_HC4Idvp5ZQQUAW7N97fj_P6A>
X-ME-Proxy: <xmx:QRYfW4T1RRbMWUvwlrg8ELW8y2fRdCZZLyGfTLHNLGDMeRUGrL4OKQ>
X-ME-Proxy: <xmx:QRYfW0IhtGz7iVUOX_NY7V8kdb58OmBoltYMg6W2StqcMu-Y2LDlMQ>
X-ME-Proxy: <xmx:QRYfW4SbDdaMFoqbaPL0Urc9kmbBnuydfEqoXNJ1PjF-PfTSTDv_og>
X-ME-Proxy: <xmx:QRYfW5MtFWinqVO4euYyMrUACWEs3z7yKb_d_khVf2vxnC1SDdAC-w>
X-ME-Proxy: <xmx:QRYfW1ABCX1LbIDNRb_8lFg1pNY24lcBdIopUjyOg_LVdNnCvGdsTg>
X-ME-Sender: <xms:QRYfWyQZ4ADELNBs6d-_scQFPCWtygJPlqvxxokPIJZXJasyJEXCOA>
Received: from localhost (124-169-136-87.dyn.iinet.net.au [124.169.136.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id EC3A8E4A32;
        Mon, 11 Jun 2018 20:39:28 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/4] random: Fix whitespace pre random-bytes work
Date:   Tue, 12 Jun 2018 10:39:11 +1000
Message-Id: <1528763954-27731-2-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528763954-27731-1-git-send-email-me@tobin.cc>
References: <1528763954-27731-1-git-send-email-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple of whitespace issues around the function
get_random_bytes_arch().  In preparation for patching this function
let's clean them up.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
Acked-by: Theodore Ts'o <tytso@mit.edu>
---
 drivers/char/random.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a8fb0020ba5c..ed679099afba 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1736,7 +1736,7 @@ void get_random_bytes_arch(void *buf, int nbytes)
 
 		if (!arch_get_random_long(&v))
 			break;
-		
+
 		memcpy(p, &v, chunk);
 		p += chunk;
 		nbytes -= chunk;
@@ -1747,7 +1747,6 @@ void get_random_bytes_arch(void *buf, int nbytes)
 }
 EXPORT_SYMBOL(get_random_bytes_arch);
 
-
 /*
  * init_std_data - initialize pool with system data
  *
-- 
2.7.4


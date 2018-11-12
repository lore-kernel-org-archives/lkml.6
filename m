Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5775C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A55F214F1
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZmY98PQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A55F214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbeKLONI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:13:08 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43380 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbeKLONI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:13:08 -0500
Received: by mail-pl1-f196.google.com with SMTP id g59-v6so3653046plb.10;
        Sun, 11 Nov 2018 20:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0FWWRUwPZPf5wN0wtSRNRqcACmh2GKG5vi8Tr0gcNfI=;
        b=aZmY98PQb0RldgHAxuwhL46Le+nD2a1edqbVtacR9vAJSY+597Qfn/7sow4sFzptTh
         ZBPP5nNUtoa2ysWWmJtI9GdFdbdqYRydRe9SyibGOhkgLO0TPWOEW+jF4fnoaXMeE5DX
         Ayuape9EUDpCHNu1V2pK50OT6HmuX3Stug84qbCssg27/SJp+aBdMFuEz+y8r2lDt4I+
         ge6gkSR/SlDXuIOkjuj+CCdg2tOXD7uKEVWsSzdA0KCpOlMDjF0qBHlDWmKa91p/fws8
         fgvg/6GfGKxcGe9mtOV8COQW1qFUhZEfMzbbFmHfw6KRc4tUztnDPq1xJXx9g5ikKQcC
         eZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0FWWRUwPZPf5wN0wtSRNRqcACmh2GKG5vi8Tr0gcNfI=;
        b=gPCE6IRXmv9yZkQuU3kZkvpD8bNHhMiLBKtvUZFch1eHQlEzcQxVqoww0AD2jitgaQ
         GcRFW5vj892uEsR4Jc8L+3RTJucasWt4e7jyp7V8/w1AJmyPQ5XYBsz8qXkOxSP+e5h1
         uyANfG+tPlX4LLPthbe5rhhXri556IW/hFHHSLJruldtLaS2mIkM4tRAefaWkuPSSuQp
         oYV0Cx0uBBTs/0mfPEPT9t47EkIlUQ+x0WsoBgA932nFdB0blCUNv1Clu7tYTz/nFKIY
         OU91w7YydLrK9vFN9rDk8PH5kNwEuIDEsdr+f273b5Qgn/S3UjFa4csAahZ0wmwb0xav
         CDMw==
X-Gm-Message-State: AGRZ1gKXyQFdh0Caa9AV6yW/8CkwRHSxl1yRSG4YwvgOhX66+T/9bnlX
        LJVboYKBC6n4YyaI3Qt/pzc=
X-Google-Smtp-Source: AJdET5dQVMWY2bcx8C0tiCJpNGgtCnNjIZh+sr9a29jsOegEU3BkMnABYSVtPWP1A0v85Qu9FR6eqA==
X-Received: by 2002:a17:902:1744:: with SMTP id i62-v6mr17717218pli.250.1541996506822;
        Sun, 11 Nov 2018 20:21:46 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id g123-v6sm3314835pfc.155.2018.11.11.20.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 20:21:46 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation); Mon, 12 Nov 2018 14:51:38 +1030
From:   Joel Stanley <joel@jms.id.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Daniel Axtens <dja@axtens.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/2] powerpc/boot: Set target when cross-compiling for clang
Date:   Mon, 12 Nov 2018 14:51:16 +1030
Message-Id: <20181112042116.5271-3-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112042116.5271-1-joel@jms.id.au>
References: <20181112042116.5271-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang needs to be told which target it is building for when cross
compiling.

Link: https://github.com/ClangBuiltLinux/linux/issues/259
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/boot/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 39354365f54a..111f97b1ccec 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -55,6 +55,11 @@ BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
 
 BOOTARFLAGS	:= -cr$(KBUILD_ARFLAGS)
 
+ifdef CONFIG_CC_IS_CLANG
+BOOTCFLAGS += $(CLANG_FLAGS)
+BOOTAFLAGS += $(CLANG_FLAGS)
+endif
+
 ifdef CONFIG_DEBUG_INFO
 BOOTCFLAGS	+= -g
 endif
-- 
2.19.1


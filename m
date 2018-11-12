Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8109C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818F3214F1
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZZCFUgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818F3214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbeKLOM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:12:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35263 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbeKLOM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:12:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id v9-v6so3660917pff.2;
        Sun, 11 Nov 2018 20:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AfmLjimSE+u9Sy0yk5tbns1pzcTs/BVhUoretovdKgc=;
        b=hZZCFUgDmcDa9atXmPKhPjcQ2NSeQxlDEo4KWPNsgL9x5dRq0Tu9NAFjPVm3QSXk4D
         NZwQdRV5W4GpGjRWyMEf/Q3oIp/yP1sdVgSyZWZLG9t2tWBOg5VuwzU/DuQBxcwlU042
         JN77N8M7lf1TEGW6zvdiR8lQV96J57gQXHwcwCuhvqJRc3G+PwE31wvD1s3JMckXTkqw
         ZGOOUNxGFF8M5owZtzwAKHv13skrkvGVsR1A7o3+fVh9eCWXcWzLDkcbJ8Oaw04XLxnl
         LUhL+lZX6nrVI258Yf1cc7as51wt1IrtNHmBwGlVE4Mp6Q0sVyRMzuUhRGodFC1fgbbI
         O/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AfmLjimSE+u9Sy0yk5tbns1pzcTs/BVhUoretovdKgc=;
        b=d0sQajbIdgpHxxVhhkgYzLK3c/KF/4GhzqTPWnW9f/KvsF0CTY+yUvUpsrBED194kl
         g9/eMOK6tz+1pgNJ4owwIEyXh8FFd1Ag5IxWlJrArwfPvpuU/2J0RLSewFpXvIvugvtm
         iwIX2LdPSI5jU9dtQIN7KgamflNuvcsb1NGLNL7IK+c+DeHuRcsgsAIHlAFvyMATsaIR
         UDKCOHnzXmrjXsCJyfbG6J0jfxEzhv6aIgNVxjPCE4QrvT49J7cUmCbTtu9vt0r2HOBh
         iExx09PlaqWsbGhYHcmnREAJfaC+D8tP4Ao8AehZXrIomHPMYfTqKZ9fTOyCok/ob6Xf
         Bd8Q==
X-Gm-Message-State: AGRZ1gI25AeE++y+8ey6upaIgperVhd8AYXHaZMI7jKt+SVTvfghpPsq
        drHVQqWDwRDuogtf9X+DkPrF6YcO
X-Google-Smtp-Source: AJdET5ef/PNEQHg9krXR0mrZKkE56lCnm2fbxajHf5TuowdEy8abYUO39Feq2b6OoQAbSYmPsX7ONw==
X-Received: by 2002:a63:4566:: with SMTP id u38mr16016372pgk.4.1541996497502;
        Sun, 11 Nov 2018 20:21:37 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id 34sm16556456pgp.90.2018.11.11.20.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 20:21:36 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation); Mon, 12 Nov 2018 14:51:29 +1030
From:   Joel Stanley <joel@jms.id.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Daniel Axtens <dja@axtens.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/2] Makefile: Export clang toolchain variables
Date:   Mon, 12 Nov 2018 14:51:15 +1030
Message-Id: <20181112042116.5271-2-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112042116.5271-1-joel@jms.id.au>
References: <20181112042116.5271-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The powerpc makefile will use these in it's boot wrapper.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 09278330282d..840efe6eb54c 100644
--- a/Makefile
+++ b/Makefile
@@ -495,6 +495,7 @@ endif
 ifneq ($(GCC_TOOLCHAIN),)
 CLANG_FLAGS	+= --gcc-toolchain=$(GCC_TOOLCHAIN)
 endif
+export CLANG_FLAGS
 CLANG_FLAGS	+= -no-integrated-as
 KBUILD_CFLAGS	+= $(CLANG_FLAGS)
 KBUILD_AFLAGS	+= $(CLANG_FLAGS)
-- 
2.19.1


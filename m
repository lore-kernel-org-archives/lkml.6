Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E42C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B3E2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TEEEeL0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B3E2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733022AbeHAUKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:10:11 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:43728 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732297AbeHAUKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:10:10 -0400
Received: by mail-io0-f201.google.com with SMTP id w19-v6so14309464ioa.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 11:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+KRME9vGAEtu01DjOm2vUaiwaXWnzR718tBHI+0fjAI=;
        b=TEEEeL0zTr5I3uxlqHGx7UY3VbGbbGCFOlgbJ3V4EQB57nndACqYvL9QOHLEooPEhz
         ynKHLuS48OVB/pf2iAy3/+OCkAjZo9dU3NGeJw2q+kFoifSM0dVr7U6VwBacQ6f+39gQ
         6zUuHZGd2Wk8zR17KuCGLo8Hycqlk89iaLHXdsF+PsHt6iOJ1pwut6b7nR7lerZv60Yj
         8D0eOUV+JNSSUDCfTISvWZJARKmwadzurrAZSKOOIB0yNQ8IIT3DBOQWYHE40uz1I2Uo
         tfSMfIKHKNiml6/QiHc/sQDY4BoE8CnNRxmryuxNYdQtqWaTPHY6qh9CZqnDpLUYwE2w
         GMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+KRME9vGAEtu01DjOm2vUaiwaXWnzR718tBHI+0fjAI=;
        b=U9Zugx3LYDkQsjdBxD1/MF0OzBHLAPgrKXPxrgIykf78fnEDAZo5x6A1O4/4BwBtu0
         6Kf49B+bUeUNPvHouHFtjwOgIt1RDzOHx30Iebt2PuVz+Uf9cfZlzlkpfldJTkeziWoV
         I3riDW3bGTG0UcEVIEyPjdJrzacPgQ9T25tUeJ7Hgm9F7GCDz3CH8mrYhLAnhXSJPsqn
         P+ok+BJ4rmvJfQHaQctb0fMuKoUwrtX4rKqeVL34FGbd1izBuPU7sipIQafe2Oa6bUGT
         jdcYLOchyNuWpja7MP+0q5Z8S7WecWScqgWi60LfLotaCYCC27sGbxKCFevV0Rs2kPHD
         syMw==
X-Gm-Message-State: AOUpUlGDPa50xmIkkMKv0CxgzuvxBBX/eKJKmxhoxpvTR7s9e8xMhzbL
        RyGOtdoEnDFUqEW9/YvYSxrEdMO1g2ppMuTBtss=
X-Google-Smtp-Source: AAOMgpd6aKEmwxJUK5Yr6mFiQo/VPEO3heAqb9NWO+azFVhN8k65odBj4zV+IWWuHwnwcsHCtQ/J8Hc8UPdHmgeV93A=
X-Received: by 2002:a6b:1785:: with SMTP id 127-v6mr10409900iox.118.1533147791044;
 Wed, 01 Aug 2018 11:23:11 -0700 (PDT)
Date:   Wed,  1 Aug 2018 11:22:56 -0700
Message-Id: <20180801182258.17834-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH] parisc: prefer _THIS_IP_ and _RET_IP_ statement expressions
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     deller@gmx.de, jejb@parisc-linux.org
Cc:     natechancellor@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the effort to reduce the code duplication between _THIS_IP_
and current_text_addr(), let's consolidate callers of
current_text_addr() to use _THIS_IP_.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/parisc/kernel/unwind.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/kernel/unwind.c b/arch/parisc/kernel/unwind.c
index 2ef83d78eec4..a4b430f440a9 100644
--- a/arch/parisc/kernel/unwind.c
+++ b/arch/parisc/kernel/unwind.c
@@ -439,8 +439,8 @@ unsigned long return_address(unsigned int level)
 	/* initialize unwind info */
 	asm volatile ("copy %%r30, %0" : "=r"(sp));
 	memset(&r, 0, sizeof(struct pt_regs));
-	r.iaoq[0] = (unsigned long) current_text_addr();
-	r.gr[2] = (unsigned long) __builtin_return_address(0);
+	r.iaoq[0] = _THIS_IP_;
+	r.gr[2] = _RET_IP_;
 	r.gr[30] = sp;
 	unwind_frame_init(&info, current, &r);
 
-- 
2.18.0.597.ga71716f1ad-goog


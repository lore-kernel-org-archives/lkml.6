Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17573C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F1F21721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r70SoXyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfBGWCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:02:47 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:59703 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbfBGWCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:02:46 -0500
Received: by mail-it1-f202.google.com with SMTP id t143so2386708itc.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 14:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eegGQ+TDUvyP04r1vddWpgDCV6euPHpHx7dZx3qsf9g=;
        b=r70SoXybzoOCIkWu2j8mHZU8g0T5YQAGdrIRivO7Fturw9VJMugfsd1neIGkdH7Er1
         dyAjuZyQputIMHrZBXJ29KnbhRagGBiey30mdOvY4OMmAuZMQvjYODVqZeO8iF48xIzG
         rBhUba+pAiojFj7gUgxP41P3WBpF/SfwrlP+RksQ0LyoidZEBUZQApvdpSMGATUEtewi
         B65bDNa5b53iEYCsysInHQAOb6b2bDc9Pong9Gm1o6rFjz/K1yWrV+98YVsTsRkTs3Dl
         jYASom8/BBGx3ldWHLZOPusu71rPUZrStAB4tVtTsAEP9rZW8oOcA4et2Jp8YpV3DUjh
         XNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eegGQ+TDUvyP04r1vddWpgDCV6euPHpHx7dZx3qsf9g=;
        b=rPd1k3eFXxb0gwE2BDuets0GyHXC6B067L4EHprnqZHU2emdwl+q4YyfPTR9Z34ndD
         xV/FSEf1ipcZdpheorcTXioTQAQnE5oOL1hS5eKkCxKGrCQGBkh5ocsdhZCHcFkANc9z
         MF9yPgwB1cmY8/a1aFpXIk/opKvMceP4yHBqHPME4p40i0U48c3gl8qtMcyJuG7ml81b
         zwQ/bJxvT3Wz4GI4uBprLP2INywc+9m4ONGgmuNMvIAMV9gVzmu38XHzHkoV6tFi1ypl
         s+lkq8Ydt+b4RvLiSJ5ZTgoNNT2d5Xa2GHAHE6jMChoMaY0wcnQAh5TGgFlZ3rxHBDXk
         0fBA==
X-Gm-Message-State: AHQUAuYXhAY5596ICKWS15/uhVldGp69bMfQSrbpY4mH3actZVDIOp2k
        7mmWGcvCO4XPAHRl+w3YjBz4RdTerz3UTosQh/8=
X-Google-Smtp-Source: AHgI3Ibav9Uf6gMTGf3azbmCskscwy0sOHZk3WccVi7eZymU8SgkUiG9YtamdMiJLkL0IGdpQs53SbSMD6CCMIMpxKA=
X-Received: by 2002:a24:248d:: with SMTP id f135mr7815646ita.36.1549576965962;
 Thu, 07 Feb 2019 14:02:45 -0800 (PST)
Date:   Thu,  7 Feb 2019 14:01:51 -0800
In-Reply-To: <20190207220155.81351-1-ndesaulniers@google.com>
Message-Id: <20190207220155.81351-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190207220155.81351-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH 3/4] Makefile: lld: tell clang to use lld
From:   ndesaulniers@google.com
To:     yamada.masahiro@socionext.com
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed because clang doesn't select which linker to use based on
$LD but rather -fuse-ld=$(LD). This is problematic especially for
cc-ldoption, which checks for linker flag support via invoking the
compiler, rather than the linker.

Link: https://github.com/ClangBuiltLinux/linux/issues/342
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 0eae4277206e..6307c17259ea 100644
--- a/Makefile
+++ b/Makefile
@@ -502,6 +502,9 @@ endif
 CLANG_FLAGS	+= -no-integrated-as
 KBUILD_CFLAGS	+= $(CLANG_FLAGS)
 KBUILD_AFLAGS	+= $(CLANG_FLAGS)
+ifneq ($(shell $(LD) --version 2>&1 | head -n 1 | grep LLD),)
+CLANG_FLAGS	+= -fuse-ld=lld
+endif
 export CLANG_FLAGS
 endif
 
-- 
2.20.1.791.gb4d0f1c61a-goog


Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DF7C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD2921721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hT0sOTj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfBGWCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:02:55 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:43184 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfBGWCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:02:54 -0500
Received: by mail-qk1-f201.google.com with SMTP id z126so1388603qka.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 14:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o+AJ8QXrg2DBnZGy5ZK6HlHEP2OPjBoRWVCrnuFEEho=;
        b=hT0sOTj7b3PLD8UwlhjluEWCgaUqFcwBupSFo+rIsarXYKEEWRH8u5FdyH7Xyl9LMI
         BzEnQsTHoKZJRQxb6hXGp7lQh0jmZm3p0FYgvxRFytFo6ty1cwfFm3I+I4L4j+PNQH3a
         gz33UvMVgKqYwpyW7oeYb8bcxcbe+sOBeFgWf5nnPwdONZq/izCL3HqA4tP4mhgnqGAq
         se5QlTXVg+Jfy5sonuqLJR4zqRK768Pt6ayAIESLzTLDpKkHDCxl1BGzCjwCOHsVcQfN
         RR8BQfIeBGdlTq30stNQ0Oi8PfTYdErpUaW/zDoFT+nFtJGLGkHwP73oPrd4SRZzqhLI
         dKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o+AJ8QXrg2DBnZGy5ZK6HlHEP2OPjBoRWVCrnuFEEho=;
        b=qstcMYN0NtGEHUTffHYmohaPqcgZntJPo8T755339nlkMsC5WrpXJJWy7Pba8xf7rp
         HKkyV+p1IN/vrNKqM2a5klX64Re17YeN8UIWK1tYlBCrlnabTAdN/hGiTtLoVPnuvgr2
         W+gJsQbZsAt1JG40o2mHTQdqU6jtTm4laX9OgxR9p/2uFG6YBV6pBmu2kdZZb3fWwCUe
         0Qd3izQSCH7+m0qZDoa7hDkWiPgjYu7/ZnOwudR+56zCwqz5gSmY+if++BfZfunu9CZp
         IUl0FvdYv7cd8CNsZJaLMY7pYNyouT+c6YMdmagouROq/xkh0q01FBIScgZhdsbYM20T
         2iPw==
X-Gm-Message-State: AHQUAuZfljyP4f15rkaFB7UP9Np6DWGxorw+Bw1z6FXKrHUIZISYxa05
        5rNsZmeGR6WE8d5xPi8Nc4lSZHmSzzou2+N3iJw=
X-Google-Smtp-Source: AHgI3IZpSTvveps4gw9Ymi9LhC8L0aj58ECu2QXXZgpry+dP6rog7BE3nXSvtl0Om6ewMCVDLY3yy1gx+yqMFm/NSvc=
X-Received: by 2002:a0c:b0b6:: with SMTP id o51mr10787701qvc.40.1549576972858;
 Thu, 07 Feb 2019 14:02:52 -0800 (PST)
Date:   Thu,  7 Feb 2019 14:01:52 -0800
In-Reply-To: <20190207220155.81351-1-ndesaulniers@google.com>
Message-Id: <20190207220155.81351-4-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190207220155.81351-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH 4/4] Makefile: lld: set -O2 linker flag when linking with LLD
From:   ndesaulniers@google.com
To:     yamada.masahiro@socionext.com
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Rui Ueyama <ruiu@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-O2 enables tail merging of string table strings.

For arm64:
0.34% size improvement with lld -O2 over lld for vmlinux.
3.30% size improvement with lld -O2 over lld for Image.lz4-dtb.

Link: https://github.com/ClangBuiltLinux/linux/issues/343
Suggested-by: Rui Ueyama <ruiu@google.com>
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 6307c17259ea..c07208ec49d4 100644
--- a/Makefile
+++ b/Makefile
@@ -718,6 +718,10 @@ else
 KBUILD_CFLAGS += -Wno-unused-but-set-variable
 endif
 
+ifdef CONFIG_LD_IS_LLD
+KBUILD_LDFLAGS += -O2
+endif
+
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
 ifdef CONFIG_FRAME_POINTER
 KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
-- 
2.20.1.791.gb4d0f1c61a-goog


Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF8AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8CA21721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hoBwgSPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfBGWCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:02:40 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:55447 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbfBGWCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:02:39 -0500
Received: by mail-it1-f201.google.com with SMTP id j3so2441961itf.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 14:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K0M49omsRwIKeW5zWET20jPe2lVNAfQ5m7GbqMaJYbE=;
        b=hoBwgSPC4iUGIYLp/p9AbVZY/vdXNqM0t+kVb0+ZzI9CXouraAjcLv2JerIIQj8+Vj
         djaCunPvOWlH/OoZy9uRACSwhgsh3qzqazg1KqsteXq52nVsSbqOp9OfgCZz3y/ADaR5
         BDSu3oYzWzcr+L5xhPhhaPa/OE9Lo/PbeHijtn7Pp470SZKoVIyPzFxy11y95Q5FTWeC
         FFJ8iIMJLX5FfaZ/l0bk9X8DYMSTvIEOjraQnqq9q9HHT2pMmm4JJTnS1Q3Ds9n43JiD
         /vfFJz/9zEO1quFrZz2p32oAT3tjf3T/uI33mUoVXIEEoCt+jcRIckLEFz+/kbgHO97P
         mgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K0M49omsRwIKeW5zWET20jPe2lVNAfQ5m7GbqMaJYbE=;
        b=QiON6AxjlT+KMJgLRFHmtJHLlKbukAS5QEK4dKxtf1reJowPV/9z/3AcpMfuaJ0qln
         mIsAanBOqNyrV/ju7ndhUEp072dsKnP8mT5accSBHxBDBcU5kQMgs3AUGCr8cTqU8iT5
         iTDTdH1mpou3FUiuZpSe2Xwy0fVhhBp66EmCkNEY7Uku2t3v4wU34bbiVL3FY22vI1I/
         EFSNCexRFjbezpMzB+KIVvpKLqTKHuqfOBn5KbP+jD/sfaZOkFYujrIgbVcRYIvhdAds
         AA70chuFjVcR0Bc1cmYxWQwfwUh7hPuFlLCpFfqmW88fnEJoFzUiNTmeMr1divsAjwDO
         LJ9g==
X-Gm-Message-State: AHQUAuZiIz3cfuh11EkOoCju3vsimXoEhgHPrZbiqWUoGrIpMWZusAGX
        a+GY/G8Jsmhq9y4edk/PBjn4Ytcwit8pBrPtGSU=
X-Google-Smtp-Source: AHgI3IaeJBxN+8seessG4GsDgvTBxyTTmrCBHcmKW3evwnw1QYPPcQl9e5B5fx5xvUBmhNfMI1y687pmNtj++y9uEt4=
X-Received: by 2002:a24:3653:: with SMTP id l80mr7872820itl.3.1549576958955;
 Thu, 07 Feb 2019 14:02:38 -0800 (PST)
Date:   Thu,  7 Feb 2019 14:01:50 -0800
In-Reply-To: <20190207220155.81351-1-ndesaulniers@google.com>
Message-Id: <20190207220155.81351-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190207220155.81351-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH 2/4] Makefile: clang: choose GCC_TOOLCHAIN_DIR not on LD
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

This causes an issue when trying to build with `make LD=ld.lld` if
ld.lld and the rest of your cross tools aren't in the same directory
(ex. /usr/local/bin) (as is the case for Android's build system), as the
GCC_TOOLCHAIN_DIR then gets set based on `which $(LD)` which will point
where LLVM tools are, not GCC/binutils tools are located.

Instead, select the GCC_TOOLCHAIN_DIR based on another tool provided by
binutils for which LLVM does not provide a substitute for, such as
elfedit.

Fixes commit 785f11aa595b ("kbuild: Add better clang cross build support")

Link: https://github.com/ClangBuiltLinux/linux/issues/341
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 3142e67d03f1..0eae4277206e 100644
--- a/Makefile
+++ b/Makefile
@@ -492,7 +492,7 @@ endif
 ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
 ifneq ($(CROSS_COMPILE),)
 CLANG_FLAGS	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
-GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
+GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
 CLANG_FLAGS	+= --prefix=$(GCC_TOOLCHAIN_DIR)
 GCC_TOOLCHAIN	:= $(realpath $(GCC_TOOLCHAIN_DIR)/..)
 endif
-- 
2.20.1.791.gb4d0f1c61a-goog


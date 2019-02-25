Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2169C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABE72173C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129350;
	bh=rRept8gDVs7cMicX4RtIMmYSabXvlVtAPKbKGzE9F2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u87/Hfiq4JSMkUiCQxJmN9ktb2UvDe0YgnePobk1MwSC/E6Yr/nQjF66/FrreJkBN
	 q/XRw8K3qjNI7A0QMs62nBRWOMtySQ3kq5LU9CMw7DCa5ysDpsxHU6guK9IqKNRlXd
	 Qz29EGNhn2k9wx3sXynzGgl1BaoCnqA3Zj3PX5Mc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfBYVPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:15:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729577AbfBYVPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:15:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADDE221734;
        Mon, 25 Feb 2019 21:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129346;
        bh=rRept8gDVs7cMicX4RtIMmYSabXvlVtAPKbKGzE9F2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xFye58ZpyWUlshtByqm0rCdL23oRW48Gi5KyiXfM1k/7y/MTerkUmQJlj6EOsWYff
         BjyaVXphTwc5HtYgrN/P2tIGJjiZ1NwRPRrA63IOOZRpUFJKU9bv2DDbymIivUASsv
         UdsOJGiMmARtdrFiCHFTiupJAR1iVHEB12SyYNo8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 54/63] kbuild: add -no-integrated-as Clang option unconditionally
Date:   Mon, 25 Feb 2019 22:11:54 +0100
Message-Id: <20190225195039.962436558@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit dbe27a002ef8573168cb64e181458ea23a74e2b6 upstream.

We are still a way off the Clang's integrated assembler support for
the kernel. Hence, -no-integrated-as is mandatory to build the kernel
with Clang. If you had an ancient version of Clang that does not
recognize this option, you would not be able to compile the kernel
anyway.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -516,8 +516,8 @@ CLANG_GCC_TC	:= --gcc-toolchain=$(GCC_TO
 endif
 KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
 KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
-KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
-KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
+KBUILD_CFLAGS += -no-integrated-as
+KBUILD_AFLAGS += -no-integrated-as
 endif
 
 



Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3F9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20482133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218817;
	bh=vKVTFrdDJYAxiKLNY4rBgyihk6xLyobex7Bf/9Mqdxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gQlIvWufM8oP4Q6v1c45wXeGI89mZklP8nqrMIC845an1+Y3adAJ/MWZDTiKpT+nn
	 sVbdL7np2r7jrPAC/P7epb4dbCK6Yk1NRqS4HCxvndbeXLDX1DVWcVNye+KDtxb5c9
	 xeRjaJLUhd4m2/fz/uhfcqzIhVqozrhKZzBXfYjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389584AbfAKOdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:33:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389568AbfAKOdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:33:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8862620870;
        Fri, 11 Jan 2019 14:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217182;
        bh=vKVTFrdDJYAxiKLNY4rBgyihk6xLyobex7Bf/9Mqdxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dDRXSpzUsTwDeY0TpwutKOuwybBdDLNlGHj7mFR1HvqYtLCtn984v6qJKMDD9HFh2
         J1VGFg6IJBwO/JUsOBGcxwxCYT9hN13kqiLg0eyBuQQNlJ6QmdHflgoDEKLhkXSXmB
         8pPzU3lPZ4E+SoTXp3XcLMQVBrQ+XsEhLSKR7vrE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.14 073/105] kbuild: add -no-integrated-as Clang option unconditionally
Date:   Fri, 11 Jan 2019 15:14:44 +0100
Message-Id: <20190111131109.099848974@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -489,8 +489,8 @@ CLANG_GCC_TC	:= --gcc-toolchain=$(GCC_TO
 endif
 KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
 KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
-KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
-KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
+KBUILD_CFLAGS += -no-integrated-as
+KBUILD_AFLAGS += -no-integrated-as
 endif
 
 RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register



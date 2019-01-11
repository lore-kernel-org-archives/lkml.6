Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23969C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7772184A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217550;
	bh=YqK5JzPf0iFKZuksaAnusxTTKTVgAto0IVXgK9bNy5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oEiJnfjVkxysy4FfuBgIerrzOupHYs9BROmglb+1Md2TWTIjrjOeyvZKdwkt9sazl
	 A0TnrZaXTO0NfQoigxkOAV5PPYWZhCCKSp5LqZd34+weNx5O9agUX8F10Zip2MsDpZ
	 tD+bRusOAI8s+qOGAq1YKLT4tLoLTrQsZlvwWftA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390969AbfAKOjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:39:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:59860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403776AbfAKOjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:39:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A3042063F;
        Fri, 11 Jan 2019 14:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217544;
        bh=YqK5JzPf0iFKZuksaAnusxTTKTVgAto0IVXgK9bNy5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nXvB06V7RD+I9UYybkh6lhneayCKsAFwlMCOmE2WBNRYrE0BJCq2/4c5TFAc7Tpvw
         V9YLsYTaRiOjhlUCxAN4L3vy2Ac72KOuVBale6Y64ZgFFhBTB/nUmr9XtCOA4Zr+82
         yZ/2ciR9I2nt/+MKR2tSKejUtD71Rh+UNdDPRmgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH 4.19 099/148] powerpc/boot: Set target when cross-compiling for clang
Date:   Fri, 11 Jan 2019 15:14:37 +0100
Message-Id: <20190111131118.181576049@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joel Stanley <joel@jms.id.au>

commit 813af51f5d30a2da6a2523c08465f9726e51772e upstream.

Clang needs to be told which target it is building for when cross
compiling.

Link: https://github.com/ClangBuiltLinux/linux/issues/259
Signed-off-by: Joel Stanley <joel@jms.id.au>
Tested-by: Daniel Axtens <dja@axtens.net> # powerpc 64-bit BE
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/boot/Makefile |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -55,6 +55,11 @@ BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAG
 
 BOOTARFLAGS	:= -cr$(KBUILD_ARFLAGS)
 
+ifdef CONFIG_CC_IS_CLANG
+BOOTCFLAGS += $(CLANG_FLAGS)
+BOOTAFLAGS += $(CLANG_FLAGS)
+endif
+
 ifdef CONFIG_DEBUG_INFO
 BOOTCFLAGS	+= -g
 endif



Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF51C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD5D20685
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NoUqRvax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbfAKDZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 22:25:55 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:56672 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfAKDZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 22:25:54 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x0B3MdXd025916;
        Fri, 11 Jan 2019 12:22:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x0B3MdXd025916
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547176962;
        bh=ocHlcWrjAm/xs8+iPn+7un9p3CS3ZkzSyHBVDG5ginM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NoUqRvaxPlIvsbYyQk/wDfmqf+a1YG0UK9ZTldnJ1bNAMPZNhvM1fFTgKEw8nQy5U
         lPm/giq9K2JOae+I74tyf2wCKQbApisfQmuDuLhBSgF9DBywNPHnFVJ4+CFG4hA75s
         H+hhyDv/O1nX9pm/sEmuKWFj2JzYEYHyNqLN7wdX3gsuefGag2Tthmi3vnIGpAsv2T
         Fm1f3hMZxdwidWkLHuSa8e1Ibb+Yso/ghS1vID60wC5OHbqCMa4NOaGCFtide/77xN
         3EByxDmZsc9JcWPyJe3Rzm+pAax0eI9BJsXvktTkRyaLwm6S/J3wnE9C530xW317Mn
         WlvwQq1uX0ALA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] powerpc: remove redundant header search path additions
Date:   Fri, 11 Jan 2019 12:22:32 +0900
Message-Id: <1547176954-17739-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547176954-17739-1-git-send-email-yamada.masahiro@socionext.com>
References: <1547176954-17739-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same path -Iarch/$(ARCH) is passed to KBUILD_CPPFLAGS,
KBUILD_AFLAGS, and KBUILD_CFLAGS.

As you see in scripts/Makefile.lib, KBUILD_CPPFLAGS is passed
to c_flags and a_flags as well.

Passing it to KBUILD_CPPFLAGS is enough.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/powerpc/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 488c9ed..ac03334 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -213,9 +213,9 @@ endif
 asinstr := $(call as-instr,lis 9$(comma)foo@high,-DHAVE_AS_ATHIGH=1)
 
 KBUILD_CPPFLAGS	+= -Iarch/$(ARCH) $(asinstr)
-KBUILD_AFLAGS	+= -Iarch/$(ARCH) $(AFLAGS-y)
+KBUILD_AFLAGS	+= $(AFLAGS-y)
 KBUILD_CFLAGS	+= $(call cc-option,-msoft-float)
-KBUILD_CFLAGS	+= -pipe -Iarch/$(ARCH) $(CFLAGS-y)
+KBUILD_CFLAGS	+= -pipe $(CFLAGS-y)
 CPP		= $(CC) -E $(KBUILD_CFLAGS)
 
 CHECKFLAGS	+= -m$(BITS) -D__powerpc__ -D__powerpc$(BITS)__
-- 
2.7.4


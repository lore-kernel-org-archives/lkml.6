Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A109C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722122082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="E0iKG8RG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722122082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbeLEHiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:38:00 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:60898 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeLEHh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:37:59 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wB57btem026548;
        Wed, 5 Dec 2018 16:37:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wB57btem026548
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543995475;
        bh=6zNvwqlcG0bSpLY1fsGSbxOKDnUnqs92LwmbOsPJ5eo=;
        h=From:To:Cc:Subject:Date:From;
        b=E0iKG8RG/AAsaQIq6t3A1NOq6C2yQwEdt5r2vTCgFtfsPFWGXBCVY87LbRla5qPqr
         aSZV2x+gA7jSkKqpYzcfLO8S4XIJmhP9aEjFhaStiZhwN9daKjiIqNusDtByHiCJww
         t+lVWIEW4oP31zLjx1C/XdnthuoR4S3Wx1tYAdobWoKYg9mKqdzUilrAPUz/mwl235
         MTdP8hVNt1XPOfJe8LLOLO8ovFSDty+iJj0Ti2DyfMyo6ooIfCuZRvQazIT5hxv77h
         Ex3A0OUF5bTk5A3bf+ULqvEWKJ87e0Rm7phXELiSFyyq2IiPs7ETuAy6n/vw/9r05q
         AoNdnKpdEyX/w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove a special handling for *.agh in Makefile.headersinst
Date:   Wed,  5 Dec 2018 16:37:53 +0900
Message-Id: <1543995473-25080-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/Makefile.headersinst takes care of *.agh just for

  arch/cris/include/uapi/arch-v10/arch/sv_addr.agh

because renaming exported headers is difficult (or impossible).

This code is no longer necessary thanks to commit c690eddc2f3b ("CRIS:
Drop support for the CRIS port").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.headersinst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.headersinst b/scripts/Makefile.headersinst
index 0d4a96d..3d1ebaa 100644
--- a/scripts/Makefile.headersinst
+++ b/scripts/Makefile.headersinst
@@ -44,7 +44,6 @@ kbuild-file := $(srctree)/$(obj)/Kbuild
 installdir    := $(INSTALL_HDR_PATH)/$(dst)
 gendir        := $(objtree)/$(subst include/,include/generated/,$(obj))
 header-files  := $(notdir $(wildcard $(srcdir)/*.h))
-header-files  += $(notdir $(wildcard $(srcdir)/*.agh))
 header-files  := $(filter-out $(no-export-headers), $(header-files))
 genhdr-files  := $(notdir $(wildcard $(gendir)/*.h))
 genhdr-files  := $(filter-out $(header-files), $(genhdr-files))
-- 
2.7.4


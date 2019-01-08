Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E8BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D832089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="tk4YfqMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfAHGpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 01:45:52 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:35682 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHGpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 01:45:52 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x086jR6b024433;
        Tue, 8 Jan 2019 15:45:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x086jR6b024433
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546929928;
        bh=xAb+wwNCnlaRKkTWL2jGWIAjWJwD8B8Moh76ogeBCLo=;
        h=From:To:Cc:Subject:Date:From;
        b=tk4YfqMT4XRzWXey3dCrAxCWTxxai6BxUeOqHulwTi2uAeNpwEOi5rdaqujv2YIEe
         K7wfnhoj3YPcYZhZjBoeqA/CpzB3VLSTMGK6kQU1CzmuCmx1ppGz+f1Mzh/0Zy7fbp
         vr1AlV8QIA/O6V2X8lINHu9+RlkgviKI8JFrPr7TQZQA/U0jG2XK6h/PAl+bXOQXy9
         DS/JzKLj0s/h0jbKnSvXD7PC6UC7GBdCnRHy74AaUwCMTTEy0n4bGHNx+dnqytOleg
         GMn7VWDbOQO9HDwW+5cYTxOhwyOb+V2TiOkMjwvqLpC5lkqRU7NUE1d/SGqio/FHzq
         AicRawAWgtYhw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: remove meaningless ccflags-y in arch/parisc/boot/Makefile
Date:   Tue,  8 Jan 2019 15:45:18 +0900
Message-Id: <1546929918-27235-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ccflags-y is never used because arch/parisc/boot/Makefile
only contains objcopy and install targets.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/parisc/boot/Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/parisc/boot/Makefile b/arch/parisc/boot/Makefile
index cad68a5..41cce07 100644
--- a/arch/parisc/boot/Makefile
+++ b/arch/parisc/boot/Makefile
@@ -2,12 +2,6 @@
 # Makefile for the linux parisc-specific parts of the boot image creator.
 #
 
-COMPILE_VERSION := __linux_compile_version_id__`hostname |  \
-			tr -c '[0-9A-Za-z]' '_'`__`date | \
-			tr -c '[0-9A-Za-z]' '_'`_t
-
-ccflags-y  := -DCOMPILE_VERSION=$(COMPILE_VERSION) -gstabs -I.
-
 targets := image
 targets += bzImage
 subdir- := compressed
-- 
2.7.4


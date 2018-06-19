Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062B1C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D70208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TLQs8+4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D70208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756947AbeFSJpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:45:42 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:64529 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755866AbeFSJpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:45:41 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w5J9i6px002346;
        Tue, 19 Jun 2018 18:44:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w5J9i6px002346
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529401448;
        bh=YpndrUOX3Y2iInr6iGjxDqfgacjqhxMhjwpfVWFMako=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TLQs8+4VfC4ZOnttWSElrvykR7K8GJgld9/gw5H5ufms0jxyBWDlfbzt4D9RFEz7F
         /a9L1wErcipVTCa94/NM+bxum17hoUU9cELvAQLJny945rk4bu7YthI3s7Rsft0B7M
         8NhOUtvwZhEvKF+hXvKJSeAGFe6mnvjw4wzIcO+Pt+6+rl4kzSabbqk8T0/9nfYTaZ
         AdSIUrbXcl47fLy6afUm73+JwUxbpTm4RiCeFC88xQPvI7m0woVtuvzCMXfMmgtfJD
         cIfmWo5vPH16LgL3pOuimbcDxm3LYVlgogcn5S/xPFk9x3cNj5wlc1DAxPLjZKmg/g
         VMFWMMHFW6tbg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/build: remove unnecessary preparation for purgatory
Date:   Tue, 19 Jun 2018 18:43:42 +0900
Message-Id: <1529401422-28838-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529401422-28838-1-git-send-email-yamada.masahiro@socionext.com>
References: <1529401422-28838-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kexec-purgatory.c is properly generated when Kbuild descend into
the arch/x86/purgatory/.

The archprepare target is redundant.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 246a979..a08e828 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -258,11 +258,6 @@ archscripts: scripts_basic
 archheaders:
 	$(Q)$(MAKE) $(build)=arch/x86/entry/syscalls all
 
-archprepare:
-ifeq ($(CONFIG_KEXEC_FILE),y)
-	$(Q)$(MAKE) $(build)=arch/x86/purgatory arch/x86/purgatory/kexec-purgatory.c
-endif
-
 ###
 # Kernel objects
 
-- 
2.7.4


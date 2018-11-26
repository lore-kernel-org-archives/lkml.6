Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033B9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0EC20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vM8fc/D3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0EC20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbeKZTKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:10:05 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:48914 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeKZTKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:10:03 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wAQ8FpWB020092;
        Mon, 26 Nov 2018 17:15:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wAQ8FpWB020092
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543220152;
        bh=pVjcHJwj0J6RzT7OpWrpYm7jbHU5z7/yn0f7+ECjTAU=;
        h=From:To:Cc:Subject:Date:From;
        b=vM8fc/D3UE2uZVz4WbfTpZrPoXoDo5RHosxJyRWXCR8j/81+lF67wltyQtMl9IVbQ
         WXr/K4XWgmG8xlNiE8j5g21EEMHnTaMMq3iezoCtY06D9WDgABKm9S3x2tiKoGZBiB
         gv3fvJb7hJrcWBQUZAROI6rCWJjIGeJlcpKJCOJ6CkJGX8IvvKUoeoG0U57xaHSRDX
         gwDOb2fOKT9HAtxfUyxRYgRH3qfpyfbivDV2xqCKYeIjeMNM2tU2Sa6A1EMTwiqz/+
         DsmJGbUYAhMa/lOYGjSxeSqiqHLOe3SmrRAzVtwonEkMZBj7WORFZCDXVvd7g5qcSl
         fCOZXVNkSo9Vg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jeff Dike <jdike@addtoit.com>
Subject: [PATCH] pcmcia: remove per-arch PCMCIA config entry
Date:   Mon, 26 Nov 2018 17:15:41 +0900
Message-Id: <1543220141-13744-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all architectures include drivers/pcmcia/Kconfig where
the PCMCIA config is defined, the PCMCIA config entries in per-arch
Kconfig files are redundant.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I will queue this up to my kbuild tree
along with Christoph's clean-up patch set.


 arch/s390/Kconfig | 3 ---
 arch/um/Kconfig   | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 5173366..b212c59 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -837,9 +837,6 @@ source "kernel/power/Kconfig"
 
 endmenu
 
-config PCMCIA
-	def_bool n
-
 config CCW
 	def_bool y
 
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 6b99389..a7d09a7 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -34,9 +34,6 @@ config SBUS
 config PCI
 	bool
 
-config PCMCIA
-	bool
-
 config TRACE_IRQFLAGS_SUPPORT
 	bool
 	default y
-- 
2.7.4


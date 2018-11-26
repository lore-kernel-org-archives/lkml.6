Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B036AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7670D21473
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDjxZ5+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7670D21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbeKZV4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:56:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729290AbeKZV4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:56:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8BAD20817;
        Mon, 26 Nov 2018 11:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230176;
        bh=fKJDLIwFBU+D8ghuxZoEjFxb0xzyJUuYFh6SiGrxpF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDjxZ5+DFVO6KWSn7b3cSMWJOzhyqbL9Z0DE4P29c4tqPaigny9fDZxoBAxXtLdqa
         6cPVvSoI99uewr5+I1T+SGliSjBb/WKlRZuHAN4VKoj/m0cciU1Lf9wwtEmzaFL4Hd
         2si7OqhUKEGIFwopYr4EDJzfP23cAgUiy6jpL7LA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philipp Rudo <prudo@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 035/118] s390/decompressor: add missing FORCE to build targets
Date:   Mon, 26 Nov 2018 11:50:29 +0100
Message-Id: <20181126105101.747136534@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ef5febae1543f35a45f01614123e829d77326d0f ]

According to Documentation/kbuild/makefiles.txt all build targets
using if_changed should use FORCE as well. Add missing FORCE to make
sure vmlinux decompressor targets are rebuild properly when not just
immediate prerequisites have changed but also when build command differs.

Reviewed-by: Philipp Rudo <prudo@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/boot/compressed/Makefile | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
index 04609478d18b..b375c6c5ae7b 100644
--- a/arch/s390/boot/compressed/Makefile
+++ b/arch/s390/boot/compressed/Makefile
@@ -20,7 +20,7 @@ KBUILD_CFLAGS := $(KBUILD_CFLAGS_DECOMPRESSOR)
 OBJECTS := $(addprefix $(obj)/,$(obj-y))
 
 LDFLAGS_vmlinux := --oformat $(LD_BFD) -e startup -T
-$(obj)/vmlinux: $(obj)/vmlinux.lds $(objtree)/arch/s390/boot/startup.a $(OBJECTS)
+$(obj)/vmlinux: $(obj)/vmlinux.lds $(objtree)/arch/s390/boot/startup.a $(OBJECTS) FORCE
 	$(call if_changed,ld)
 
 # extract required uncompressed vmlinux symbols and adjust them to reflect offsets inside vmlinux.bin
@@ -51,17 +51,17 @@ suffix-$(CONFIG_KERNEL_LZMA)  := .lzma
 suffix-$(CONFIG_KERNEL_LZO)  := .lzo
 suffix-$(CONFIG_KERNEL_XZ)  := .xz
 
-$(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y)
+$(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,gzip)
-$(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y)
+$(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,bzip2)
-$(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y)
+$(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,lz4)
-$(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y)
+$(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,lzma)
-$(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y)
+$(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,lzo)
-$(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y)
+$(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,xzkern)
 
 LDFLAGS_piggy.o := -r --format binary --oformat $(LD_BFD) -T
-- 
2.17.1




Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3E6C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156E221884
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crFoVII1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156E221884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753675AbeGEKSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:18:13 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44421 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753323AbeGEKSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:18:11 -0400
Received: by mail-pf0-f193.google.com with SMTP id j3-v6so4974158pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 03:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SlHo/GDLvFZh0sW5Nl2THoSc6achPKlNqoHtBirpIAw=;
        b=crFoVII1NGLJi1U/CE0PIcif4LeYy93DDfOeEGWJ+4OIs6LsmDzdHtD3InfhCEg81V
         kiuyRY5eRq4OBwCUOk5wd7IqP+IIfGyXfXvXObjJIj3ezcKB4hJOa3JQY0gA7mDo16+0
         kamdB1UCXbGD8bEs2gvGA9wqZJwR8ldIeIM15fYxM1H41eLqXlFUIJ+IchALFq99WqDh
         rLhfl4RLOJ0/AXXkUMgMXPEMUhanYxBmKGvhYtR5mepMqBzCICzp68d6d7xaI23HAf9N
         8EDBz0+7o0D8/txwF8Lq8ZWsQo6/ZIQwpqdRuI/Y5UO06T18w3eUPAzf7VCS+edSdyRj
         2lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SlHo/GDLvFZh0sW5Nl2THoSc6achPKlNqoHtBirpIAw=;
        b=CN2tVckRxEMcMZzIB0O8ErKjrmVoKweA3VAFpy3FdQi5mgXcXt1dwTeiklG2oPc41c
         +w+N5SFtuHXVMZXztuSiY6m7cX49yGylVjyhGVK+/wMSLy59neGlDIiU64zPNaPFxcsK
         +WQ3EqfdcXQ/YyM3lN2YWizGoO0zTetBviE6rIMLZV/4HyYgiAabRVJGiv36HmnS+DcD
         Agw75zN+0NIklf9AeTlpxMIY+4dtVR/sfxYlkiv4OT/NJYCKf36rkK50ABexxocJk2go
         AZPto0pQbEc57i/Z5ixHJUKEWQzwU2O71pzHbgiTY6ZbsxdunLt1z17PLUx5Z1WMKNof
         ZWNA==
X-Gm-Message-State: APt69E2Az3scGl14S5W1VfnQXQvN6vcTbDTYD4gf5TNjACuX/kNRQQbp
        eE6WVIJ+u2ZCfYTzc8Lu9+nBKQ==
X-Google-Smtp-Source: AAOMgpdOhUeWeaXYtk/R59P8MQONONf73wIg2sJJKyK3p3ONwDa8SLE2BdPNiKAM7GWG7c8kZ8SHwQ==
X-Received: by 2002:a63:68c1:: with SMTP id d184-v6mr5013945pgc.239.1530785890933;
        Thu, 05 Jul 2018 03:18:10 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id v17-v6sm863574pfn.177.2018.07.05.03.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 03:18:10 -0700 (PDT)
From:   Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To:     greentime@andestech.com, linux-kernel@vger.kernel.org
Cc:     green.hu@gmail.com
Subject: [PATCH] nds32: fix build error "relocation truncated to fit: R_NDS32_25_PCREL_RELA" when make allyesconfig
Date:   Thu,  5 Jul 2018 18:17:51 +0800
Message-Id: <987553894f0ce8c1d83578136603a89009f42d35.1530785564.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will cause a linking error because the jump assembly code were using j,
however it may be not enough to jump to the destination. We have to change it
with pseudo instruction b. In that way, assembler will generate a set of safe
assembly codes to make sure the destination is able to jump.

Toolchain:
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/x86_64-gcc-8.1.0-nolibc-nds32le-linux.tar.gz

Command:
PATH=/NOBACKUP/atcsqa06/greentime/os/toolchain-kernel.org/gcc-8.1.0-nolibc/nds32le-linux/bin:$PATH ARCH=nds32 CROSS_COMPILE=nds32le-linux- make allyesconfig
PATH=/NOBACKUP/atcsqa06/greentime/os/toolchain-kernel.org/gcc-8.1.0-nolibc/nds32le-linux/bin:$PATH ARCH=nds32 CROSS_COMPILE=nds32le-linux- make -j8

  MODPOST vmlinux.o
WARNING: EXPORT symbol "copy_page" [vmlinux] version generation failed, symbol will not be versioned.
WARNING: EXPORT symbol "clear_page" [vmlinux] version generation failed, symbol will not be versioned.
nds32le-linux-ld: kernel/futex.o:(.fixup+0x4): relocation truncated to fit: R_NDS32_25_PCREL_RELA against `.text'
nds32le-linux-ld: kernel/futex.o:(.fixup+0xaa): relocation truncated to fit: R_NDS32_25_PCREL_RELA against `.text'
nds32le-linux-ld: kernel/futex.o:(.fixup+0xb0): relocation truncated to fit: R_NDS32_25_PCREL_RELA against `.text'
nds32le-linux-ld: kernel/futex.o:(.fixup+0xb6): relocation truncated to fit: R_NDS32_25_PCREL_RELA against `.text'
nds32le-linux-ld: kernel/futex.o:(.fixup+0xbc): relocation truncated to fit: R_NDS32_25_PCREL_RELA against `.text'
nds32le-linux-ld: kernel/futex.o:(.fixup+0xc4): relocation truncated to fit: R_NDS32_25_PCREL_RELA against `.text'
Makefile:1010: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/futex.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nds32/include/asm/futex.h b/arch/nds32/include/asm/futex.h
index eab5e84bd991..cb6cb91cfdf8 100644
--- a/arch/nds32/include/asm/futex.h
+++ b/arch/nds32/include/asm/futex.h
@@ -16,7 +16,7 @@
 	"	.popsection\n"					\
 	"	.pushsection .fixup,\"ax\"\n"			\
 	"4:	move	%0, " err_reg "\n"			\
-	"	j	3b\n"					\
+	"	b	3b\n"					\
 	"	.popsection"
 
 #define __futex_atomic_op(insn, ret, oldval, tmp, uaddr, oparg)	\
-- 
2.16.2


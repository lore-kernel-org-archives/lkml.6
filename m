Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB190C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1CE21720
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546270527;
	bh=WB+NMiTDhXvt4PBMNGNWj7dvhvc6nooEfv3DIrVoPzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qpj0VuZi8SFzPqovz+vEbCggDVTGkzs394+AwXXDYhsf1V2xpDx2Ye8UOoDxnH8L3
	 JIJO5sdmyg5qzkzo4gcXjZ7QFJBN7L06gTmvv0JrpXbrJH+shnnJfG4OeSlJaQecdX
	 sJD7DUHUDTanUE+G9bhKdYyTTXSS3wn479Bmu+Jc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbeLaPf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 10:35:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:60542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbeLaPf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 10:35:26 -0500
Received: from localhost.localdomain (unknown [183.128.55.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C4762133F;
        Mon, 31 Dec 2018 15:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546270526;
        bh=WB+NMiTDhXvt4PBMNGNWj7dvhvc6nooEfv3DIrVoPzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W+Oz+X1fC+pj8X0fZxnSJHaiW8sQumTGy6dtbBlRLzr94g70vxcRdCt2FS7l9yMlG
         0cOP3THN6dsr+2JRiRgXEDiVNx1uqS/9t7xBTSHVTbvwJ2kxfbNuIMNa1FfhVJeHzX
         lzEGiK4pQO3EyYZwaVgPFpK/JsntETchuj8/PW0I=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     guoren@kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com,
        linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 14/14] csky: Add EM_CSKY_OLD 39
Date:   Mon, 31 Dec 2018 23:33:04 +0800
Message-Id: <1546270384-4590-12-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546270384-4590-1-git-send-email-guoren@kernel.org>
References: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

C-SKY historically used 39, the same value as MCORE, from which the
architecture was derived.

C-SKY binutils support both EM_CSKY and EM_CSKY_OLD, confirmed by
binutils:include/elf/common.h

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/elf.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/csky/include/asm/elf.h b/arch/csky/include/asm/elf.h
index d6dbc00..e1ec558 100644
--- a/arch/csky/include/asm/elf.h
+++ b/arch/csky/include/asm/elf.h
@@ -8,6 +8,7 @@
 #include <abi/regdef.h>
 
 #define ELF_ARCH EM_CSKY
+#define EM_CSKY_OLD 39
 
 /* CSKY Relocations */
 #define R_CSKY_NONE               0
@@ -43,7 +44,8 @@ typedef elf_greg_t elf_gregset_t[ELF_NGREG];
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
-#define elf_check_arch(x) ((x)->e_machine == ELF_ARCH)
+#define elf_check_arch(x) (((x)->e_machine == ELF_ARCH) || \
+			   ((x)->e_machine == EM_CSKY_OLD))
 
 /*
  * These are used to set parameters in the core dumps.
-- 
2.7.4


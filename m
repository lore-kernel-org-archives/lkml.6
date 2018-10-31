Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21B4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757CB20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="RhhNkCD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757CB20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbeJaPoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 11:44:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33737 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeJaPoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 11:44:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id x6-v6so6806845pln.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 23:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jbGses3kKLxFwMMziG7eRw5NjyQ3ctDmuG8/t+lyq1U=;
        b=RhhNkCD0ovQE6FKl+WOSHKOzLviG03HhGHMpt4zJl9WuK/YgK03wRgyPUsGH1L5RQ3
         vc7RJwXiLD6una6/S1hwTSxpC94cLlji32JKzOyw6XI+xxn1SI43F6k8WRqMHerDXjkS
         57PqbAc8+B6Nz9hM2+TPn3fFgwIdYmUlTql/4pgs+qRkVW8oglCuZbwNftZHHce6J8DR
         KGTdpmbRC/GgP3vznlJ6A8IvJuVgf1ML44iV85niZyQY/M0dHi+fx3G1WEOF/e34Q1e0
         qtkKRYS8r95SC6FUZhztVW7ypB7Mxx4Fsx2ZwFUoSn7WzTW28ZMj9TneAIvlhTHt9T8k
         p9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jbGses3kKLxFwMMziG7eRw5NjyQ3ctDmuG8/t+lyq1U=;
        b=eaLqVAMjKLEJsdws+EGVjcXUatzN7MVw/pdkkbNIHZaT3EomVzw36XSQxp+J1KUO38
         3kTsaSetEImkUs2mrB/Q6ZPXPYG39u1KC95TbrjCeMPI7uxrm33QGBsV03sBfQoc3BEF
         gQ1LWkpmK+8CQMVxF/h3VyKIPyIGA/LLFHVtDRWAMm5UMv3XONyBq8DjBVe1yAu5M7dV
         vUKE62KDtha4VUQ1ukH2atPMwmpgIulKNam7soHHKtNX+H5sw8b8ypV/f6KPlP2+omTy
         kJ1T2FkLSac78uvUSvD3eFoVCCf0KcUmjWNcmJ02+buO3FOO3FAhub86QV2fhuWDR/UD
         6ooQ==
X-Gm-Message-State: AGRZ1gIrXoPqEfXPEbOrSfzrKq1ZN0paG2iRilAoZLOFUu8nRiZ1sAFb
        LuNVTslBX/qTFhZLDkjMxPfPhQ==
X-Google-Smtp-Source: AJdET5cyaXd7g3uo6iTIq8sGIDTN3KuSkaGfk6ArccNXVzRZCqdvpIyMORuYd/sfD7gbE3QA4V0o1g==
X-Received: by 2002:a17:902:6ac7:: with SMTP id i7-v6mr2075226plt.268.1540968446360;
        Tue, 30 Oct 2018 23:47:26 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id z7-v6sm12127306pgi.42.2018.10.30.23.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 23:47:24 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Zong Li <zongbox@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 3/3] RISC-V: Silence some module warnings on 32-bit
Date:   Tue, 30 Oct 2018 23:47:09 -0700
Message-Id: <20181031064709.30981-4-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181031064709.30981-1-olof@lixom.net>
References: <20181031064709.30981-1-olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes:

arch/riscv/kernel/module.c: In function 'apply_r_riscv_32_rela':
./include/linux/kern_levels.h:5:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'Elf32_Addr' {aka 'unsigned int'} [-Wformat=]
arch/riscv/kernel/module.c:23:27: note: format string is defined here
arch/riscv/kernel/module.c: In function 'apply_r_riscv_pcrel_hi20_rela':
./include/linux/kern_levels.h:5:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'Elf32_Addr' {aka 'unsigned int'} [-Wformat=]
arch/riscv/kernel/module.c:104:23: note: format string is defined here
arch/riscv/kernel/module.c: In function 'apply_r_riscv_hi20_rela':
./include/linux/kern_levels.h:5:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'Elf32_Addr' {aka 'unsigned int'} [-Wformat=]
arch/riscv/kernel/module.c:146:23: note: format string is defined here
arch/riscv/kernel/module.c: In function 'apply_r_riscv_got_hi20_rela':
./include/linux/kern_levels.h:5:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'Elf32_Addr' {aka 'unsigned int'} [-Wformat=]
arch/riscv/kernel/module.c:190:60: note: format string is defined here
arch/riscv/kernel/module.c: In function 'apply_r_riscv_call_plt_rela':
./include/linux/kern_levels.h:5:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'Elf32_Addr' {aka 'unsigned int'} [-Wformat=]
arch/riscv/kernel/module.c:214:24: note: format string is defined here
arch/riscv/kernel/module.c: In function 'apply_r_riscv_call_rela':
./include/linux/kern_levels.h:5:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'Elf32_Addr' {aka 'unsigned int'} [-Wformat=]
arch/riscv/kernel/module.c:236:23: note: format string is defined here

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/riscv/kernel/module.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 3303ed2cd419..7dd308129b40 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -21,7 +21,7 @@ static int apply_r_riscv_32_rela(struct module *me, u32 *location, Elf_Addr v)
 {
 	if (v != (u32)v) {
 		pr_err("%s: value %016llx out of range for 32-bit field\n",
-		       me->name, v);
+		       me->name, (long long)v);
 		return -EINVAL;
 	}
 	*location = v;
@@ -102,7 +102,7 @@ static int apply_r_riscv_pcrel_hi20_rela(struct module *me, u32 *location,
 	if (offset != (s32)offset) {
 		pr_err(
 		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
-		  me->name, v, location);
+		  me->name, (long long)v, location);
 		return -EINVAL;
 	}
 
@@ -144,7 +144,7 @@ static int apply_r_riscv_hi20_rela(struct module *me, u32 *location,
 	if (IS_ENABLED(CMODEL_MEDLOW)) {
 		pr_err(
 		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
-		  me->name, v, location);
+		  me->name, (long long)v, location);
 		return -EINVAL;
 	}
 
@@ -188,7 +188,7 @@ static int apply_r_riscv_got_hi20_rela(struct module *me, u32 *location,
 	} else {
 		pr_err(
 		  "%s: can not generate the GOT entry for symbol = %016llx from PC = %p\n",
-		  me->name, v, location);
+		  me->name, (long long)v, location);
 		return -EINVAL;
 	}
 
@@ -212,7 +212,7 @@ static int apply_r_riscv_call_plt_rela(struct module *me, u32 *location,
 		} else {
 			pr_err(
 			  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
-			  me->name, v, location);
+			  me->name, (long long)v, location);
 			return -EINVAL;
 		}
 	}
@@ -234,7 +234,7 @@ static int apply_r_riscv_call_rela(struct module *me, u32 *location,
 	if (offset != fill_v) {
 		pr_err(
 		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
-		  me->name, v, location);
+		  me->name, (long long)v, location);
 		return -EINVAL;
 	}
 
-- 
2.11.0


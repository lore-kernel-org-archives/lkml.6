Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3028EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC9420864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ+k4wAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC9420864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438620AbeKWGfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:35:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406907AbeKWGfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:35:04 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0BEF20645;
        Thu, 22 Nov 2018 19:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542916452;
        bh=ZNu8WHQed2JoXgLvINJb0Cp1VHXHhW3cx5Jo1Zm8BqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LZ+k4wADZJpXV0hkXKo+uoqrVRtRzM1lisI7vy/uoQhSiAP7WGZH7f0Ai914U2U/X
         NdFI9vDULwGzJwt5C4xvv65hpZAX4yZKTgCDlD7ZMYw8xFfbRyW67GrhjGl6MELxTg
         w4ZydYX4looVzXX7OWUO0T4AZJfRkjl8VM23QqKw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 27/36] RISC-V: Silence some module warnings on 32-bit
Date:   Thu, 22 Nov 2018 14:52:31 -0500
Message-Id: <20181122195240.13123-27-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195240.13123-1-sashal@kernel.org>
References: <20181122195240.13123-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olof Johansson <olof@lixom.net>

[ Upstream commit ef3a61406618291c46da168ff91acaa28d85944c ]

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
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.17.1


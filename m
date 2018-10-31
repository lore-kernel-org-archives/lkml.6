Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBC1ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC9520657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="meozz6lJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC9520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbeJaPoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 11:44:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44497 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeJaPoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 11:44:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id j13-v6so3625909pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 23:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8JnXO0CmsRANa8vJkrTWMoBBwz9FHTmUizOnZ5jp4Ok=;
        b=meozz6lJBjR45UuqY79EXfIam3Qt90vtt9kAuXpXaR2xN8ALGyXu276O+89n6iVaXS
         sePrUg3I1263ujnjyU4RwYLOsRS4cSWaODZjeSI+ZBTJPyMT9cnHPO9rYI5CoDGrHwdh
         DwplT0j96qH+0gnExV7pxtLXrBQcKEDJXhzeb35mFiTMLrz2CjUs0s9mOreAuDxvQ31F
         zxM6Pbcseojp4v2XIfAV7aMPfSf1tYMt9NVAyLOlgjEa2Xt1ZEC6RhOhWVHwktW3r2J+
         8GzCPLaPlmA4iZnVZKuQaTi721nQaBNFWs9bet6cdZNvXyi61BE1e5nsnWlYsrsyFpx/
         4p1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8JnXO0CmsRANa8vJkrTWMoBBwz9FHTmUizOnZ5jp4Ok=;
        b=Y5f77bIBDQrJL/Z+cVq3hE5HLhL3D9gJ3BWBLSR11s9d1za6fAAsCJKbOjeBKLcSXJ
         MuJUy8MCrAOiu8A3+OHRTI5OooDhHxMc63zvFVQhjFqbTn2oe8ImqaDkEDoXgmegN/4A
         rhrkr8xwJMbAWa3Zk4QNg8gyC99TFQbItj1tjzQqpk3qTayeZnq/WV2XhEgZsyPgrjUR
         /UD0tXepmzf/9NA0++mhhPo3kfu9lRFAWKM0Za6pWy3IiKAhOZJn75TSO9tWxSh9RJMe
         0dOvXIHKT4tA1ErWAP5Mt0LWhWQIGBiy3tR+FN4UO9YiSbckbeigjfR10RyshRFabq3I
         /YiA==
X-Gm-Message-State: AGRZ1gLWTp1vZ2U5rM2QTU3+siexJBgHuZAg+KrcOK2SyIzrLjF+JZ1f
        ihEVgxxHtbfqWs0FAtjeTWw2NA==
X-Google-Smtp-Source: AJdET5extOWqniinY943Y+junajQfD4v+S10E+FXFkg4u0+tdqi+3gCo/PhFx/cLSA/0u+k0p4PgoQ==
X-Received: by 2002:a63:111c:: with SMTP id g28mr1896919pgl.85.1540968444058;
        Tue, 30 Oct 2018 23:47:24 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id z7-v6sm12127306pgi.42.2018.10.30.23.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 23:47:22 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Zong Li <zongbox@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 2/3] RISC-V: lib: minor asm cleanup
Date:   Tue, 30 Oct 2018 23:47:08 -0700
Message-Id: <20181031064709.30981-3-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181031064709.30981-1-olof@lixom.net>
References: <20181031064709.30981-1-olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix tab/space conversion and use ENTRY/ENDPROC macros.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/riscv/lib/tishift.S | 59 +++++++++++++++++++++++++-----------------------
 arch/riscv/lib/udivdi3.S | 42 ++++++++++++++++++----------------
 2 files changed, 53 insertions(+), 48 deletions(-)

diff --git a/arch/riscv/lib/tishift.S b/arch/riscv/lib/tishift.S
index 69abb1277234..237bc9fd0763 100644
--- a/arch/riscv/lib/tishift.S
+++ b/arch/riscv/lib/tishift.S
@@ -10,33 +10,36 @@
  *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *   GNU General Public License for more details.
  */
-  .globl __lshrti3
-__lshrti3:
-  beqz  a2, .L1
-  li    a5,64
-  sub   a5,a5,a2
-  addi  sp,sp,-16
-  sext.w a4,a5
-  blez  a5, .L2
-  sext.w a2,a2
-  sll   a4,a1,a4
-  srl   a0,a0,a2
-  srl   a1,a1,a2
-  or    a0,a0,a4
-  sd    a1,8(sp)
-  sd    a0,0(sp)
-  ld    a0,0(sp)
-  ld    a1,8(sp)
-  addi  sp,sp,16
-  ret
+
+#include <linux/linkage.h>
+
+ENTRY(__lshrti3)
+	beqz	a2, .L1
+	li	a5,64
+	sub	a5,a5,a2
+	addi	sp,sp,-16
+	sext.w	a4,a5
+	blez	a5, .L2
+	sext.w	a2,a2
+	sll	a4,a1,a4
+	srl	a0,a0,a2
+	srl	a1,a1,a2
+	or	a0,a0,a4
+	sd	a1,8(sp)
+	sd	a0,0(sp)
+	ld	a0,0(sp)
+	ld	a1,8(sp)
+	addi	sp,sp,16
+	ret
 .L1:
-  ret
+	ret
 .L2:
-  negw  a4,a4
-  srl   a1,a1,a4
-  sd    a1,0(sp)
-  sd    zero,8(sp)
-  ld    a0,0(sp)
-  ld    a1,8(sp)
-  addi  sp,sp,16
-  ret
+	negw	a4,a4
+	srl	a1,a1,a4
+	sd	a1,0(sp)
+	sd	zero,8(sp)
+	ld	a0,0(sp)
+	ld	a1,8(sp)
+	addi	sp,sp,16
+	ret
+ENDPROC(__lshrti3)
diff --git a/arch/riscv/lib/udivdi3.S b/arch/riscv/lib/udivdi3.S
index cb01ae5b181a..7f1c0af182a3 100644
--- a/arch/riscv/lib/udivdi3.S
+++ b/arch/riscv/lib/udivdi3.S
@@ -11,28 +11,30 @@
  *   GNU General Public License for more details.
  */
 
-  .globl __udivdi3
-__udivdi3:
-  mv    a2, a1
-  mv    a1, a0
-  li    a0, -1
-  beqz  a2, .L5
-  li    a3, 1
-  bgeu  a2, a1, .L2
+#include <linux/linkage.h>
+
+ENTRY(__udivdi3)
+	mv	a2, a1
+	mv	a1, a0
+	li	a0, -1
+	beqz	a2, .L5
+	li	a3, 1
+	bgeu	a2, a1, .L2
 .L1:
-  blez  a2, .L2
-  slli  a2, a2, 1
-  slli  a3, a3, 1
-  bgtu  a1, a2, .L1
+	blez	a2, .L2
+	slli	a2, a2, 1
+	slli	a3, a3, 1
+	bgtu	a1, a2, .L1
 .L2:
-  li    a0, 0
+	li	a0, 0
 .L3:
-  bltu  a1, a2, .L4
-  sub   a1, a1, a2
-  or    a0, a0, a3
+	bltu	a1, a2, .L4
+	sub	a1, a1, a2
+	or	a0, a0, a3
 .L4:
-  srli  a3, a3, 1
-  srli  a2, a2, 1
-  bnez  a3, .L3
+	srli	a3, a3, 1
+	srli	a2, a2, 1
+	bnez	a3, .L3
 .L5:
-  ret
+	ret
+ENDPROC(__udivdi3)
-- 
2.11.0


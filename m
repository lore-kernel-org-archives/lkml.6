Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539A5C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B1C2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="fk7GOstm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B1C2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbeJaJAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 05:00:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44371 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbeJaJAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 05:00:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id s5-v6so4690841plq.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 17:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=FSOhZ3ryZkqtCoQg5utGGQFoOYf7wfsxoCZco3ZZqSw=;
        b=fk7GOstmST086IhkAIsRudbrBOE+2OSd9s5SZZs9D7MMmXwWaEHpzcIgZDYE76JPt5
         5Fo/RKUNGtU1YtpqO+yDzODGi5U/dN/lbHB68MI7Rf2tdmNZsh8xLp770BfgL9qj7T5v
         Uk7bKBuyVPd/HY80Kwm3IvBWOyhkk/PAthSLzVdtJE9Vq90wf1khjYGgUH9pIECHr5D0
         BV9sgEvRrAeG3eq7b76E7Fk5ryaV1m4bH+uo+yZZPv1hiAfKXQFg1TTdKqo+ooNJ/ByR
         dixyhPJLaWISj+gtwFQq+dtmpn7yrfLEPqSV7y/dVDvoofNbSYMEX7p9yThRwg8tXMo/
         lq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FSOhZ3ryZkqtCoQg5utGGQFoOYf7wfsxoCZco3ZZqSw=;
        b=epsu5fiKeH7SL0oCzYqgIzd8WgEOjx/L72iXeUPZJ3ThNsMo0PKYPfRUjcKXczDEi/
         RipRyS0NIJAbSRYe6uoDGvv299gfmVuEHpytxaDnMj22G+au7sn9yEaxo/KsxPv/oN+v
         xgRU3lh2PnUYuCf/dvAB4axw5F98KBD/KwXyo+rBr3OFGXf5xUOQtVrNru3bVl0XzT16
         TaR6SLo/WbC+Y9j27/hRpm945uzNcw5ExPnlcn5m16MHZfNQrOMF3aHUwpX/t8XX3DRq
         JDDdYmtDRGtRSaFwj7H6pTt5csPoTopKp9+e3/0PMIkulBic0gTEtgwU4xj66ZMY72vy
         ZUJA==
X-Gm-Message-State: AGRZ1gKkResOdi9n07Yvi/0is+R8GK98SyN6G96CTgxJEqkDLySam+0R
        5XGqAK9P9hBaHvQMzc1nhH9kog==
X-Google-Smtp-Source: AJdET5d4C5aguF2pRpzDV6dMBqd4M1NPEmDfeN1SBzUz+TYB4B6fpZzsNUj5ZQavTp3mU3zPET3BAA==
X-Received: by 2002:a17:902:14e:: with SMTP id 72-v6mr797127plb.299.1540944267051;
        Tue, 30 Oct 2018 17:04:27 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id o27-v6sm24638235pfk.85.2018.10.30.17.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 17:04:24 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Zong Li <zongbox@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] RISC-V: lib: Fix build error for 64-bit
Date:   Tue, 30 Oct 2018 17:04:13 -0700
Message-Id: <20181031000413.30123-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following build error from tinyconfig:

riscv64-unknown-linux-gnu-ld: kernel/sched/fair.o: in function `.L8':
fair.c:(.text+0x70): undefined reference to `__lshrti3'
riscv64-unknown-linux-gnu-ld: kernel/time/clocksource.o: in function `.L0 ':
clocksource.c:(.text+0x334): undefined reference to `__lshrti3'

Fixes: 7f47c73b355f ("RISC-V: Build tishift only on 64-bit")
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/riscv/lib/Makefile  |  2 +-
 arch/riscv/lib/tishift.S | 59 +++++++++++++++++++++++++-----------------------
 2 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 5739bd05d289e..4e2e600f7d538 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -3,6 +3,6 @@ lib-y	+= memcpy.o
 lib-y	+= memset.o
 lib-y	+= uaccess.o
 
-lib-(CONFIG_64BIT) += tishift.o
+lib-$(CONFIG_64BIT) += tishift.o
 
 lib-$(CONFIG_32BIT) += udivdi3.o
diff --git a/arch/riscv/lib/tishift.S b/arch/riscv/lib/tishift.S
index 69abb1277234b..237bc9fd07636 100644
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
-- 
2.11.0


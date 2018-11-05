Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF9AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A9E20819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPhwSxe+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A9E20819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbeKEX4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:56:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52096 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729800AbeKEX4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:56:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id w7-v6so8568601wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 06:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rll+3a6sim5r4iYb/OVW+ZQ3/aG/mb9q23Uc50bWxkM=;
        b=UPhwSxe+xd5ApS0SGX7RRPT9iC640prbYb+ufqJzx/xRhImUP24PSbxVYz5QCUXajs
         iaVCFn97C+rEwP26+8fcXO25BrCtX/9TVgtVoZaUidFr80PH9g6ZgVS6HBbnZpRbaHVo
         4w++QppRHcRK/klBRrlDjnb27668glOqa0NQxrtD9E+GMzv0BNZXBuRcDnQr0ySl09cO
         Z6t4RfxPPkmVm8kqmDJ9zPyxfN2mTqbc2kfp13u4ZP8nW2z/DcdKqriV6uyDptQTH887
         CEkKOUoXdoJNbTZ3iHEmjPAM8j5jf3fgj2jaRX1sGk+ku0DFiRf64jIvBLnBg7nmofeX
         IM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rll+3a6sim5r4iYb/OVW+ZQ3/aG/mb9q23Uc50bWxkM=;
        b=C2K5XrgpI3Bm/GQqPk7S4vaakJA06AjhOD2T4WasrDids3Szh68H2rqV5z38H85oJ4
         9JsYaGZunnHiscX3ZErhpEznOfqyDgHKwGc8WsZeVT4RWar57Sj/jrPZ0XdtfTjYbYn0
         +IBwVXNK7T44/1zGDHLZsP+txAQ0GbVEdHnThY5bf3zu/XBY/ERnIwwKx05gmaF1Eq3g
         bsOZRTRawN7PKbSQfGeP/gwMhLL9sEP8Ij74M3Ne2GawbW4Spqm9M+79IAKgk+Yd4Qf/
         xKKvT0RCLi62qHHn9UKzhRyiZYGLiwBT5yWCMZj2VuygrH6v41ebwKOkYr9iim0BcbCi
         JHFQ==
X-Gm-Message-State: AGRZ1gKRDgCHUXHkoo07V8nxFpKkFzeVTvQHPgjAO7jiZa7CN26m9t9H
        FOlpQCUi2JyRjM0dEanrec8=
X-Google-Smtp-Source: AJdET5dkbYthTquJ1fz5I9JyOvAsZ+xcKOTMGCZUBedWT+QuvPspKj/So+TSJWYIm7zjGVmpljTfxw==
X-Received: by 2002:a1c:bc82:: with SMTP id m124-v6mr6715758wmf.47.1541428560725;
        Mon, 05 Nov 2018 06:36:00 -0800 (PST)
Received: from localhost.localdomain (ip-76.net-89-3-178.rev.numericable.fr. [89.3.178.76])
        by smtp.gmail.com with ESMTPSA id x139-v6sm15473731wme.3.2018.11.05.06.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 06:35:59 -0800 (PST)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH] riscv: add missing vdso_install target
Date:   Mon,  5 Nov 2018 15:35:37 +0100
Message-Id: <20181105143537.27396-1-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building kernel 4.20 for Fedora as RPM fails, because riscv is missing
vdso_install target in arch/riscv/Makefile.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
---
 arch/riscv/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index d10146197533..4af153a182b0 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -77,4 +77,8 @@ core-y += arch/riscv/kernel/ arch/riscv/mm/
 
 libs-y += arch/riscv/lib/
 
+PHONY += vdso_install
+vdso_install:
+	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
+
 all: vmlinux
-- 
2.19.1


Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0620C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 06:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B2820825
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 06:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NN9naLgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B2820825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbeKJQ3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 11:29:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35276 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbeKJQ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 11:29:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id z16-v6so4048820wrv.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 22:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wSmwO/A3iz9yjq1Nxz1nrZto0VJAqkpQ7ytp/hBquDI=;
        b=NN9naLgZGQOLpprOYIt/eChXk+Sgv/+rdhuomGZic0dlbhV2SEL+Ng0jZfeLwzJOJ0
         FVbmFQ4WL5VUdrY/DMalaTyOA4JYccjyL7ztHEs0CfLJay+4FyjP3HBDHmz+v08hB8YG
         spqYkfBdoW6+l3ye5ypfyaqQ/pti+cPO+rHYn6O6H4pTPz0akKP/u8Armg0vr0lvaPcN
         PvlwmDTL80sjSZltrfcRC123s86l2iU85jrHNkkswaQ6egcdMzBE2c/QzahkHHiiNXgv
         ww3yM//9mmsvfGvBfxm8+ZvrNPo/V9hl3DoA3IlRcHEQ0efocr4WqiMabhIVfvM6ofum
         rF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wSmwO/A3iz9yjq1Nxz1nrZto0VJAqkpQ7ytp/hBquDI=;
        b=KDhzY+5xHHcLnXEDfxzTdm5y61zbR/ShFinPHydj/CN0R5Ot1xsRa9SbQF9wx107Jg
         h6SNM+IovlreN1yIYg7fUOHxLa3JkyBT4Cn4z4MiSXOO1q1vKUBVukteP1KvYTsxIKoI
         WmSd2kBXuLNIPHFDsdaUK0qVyfl+UPKuljq2cS5fXLMSBcPRgXeyn3gAYu76loGWyKet
         idkXlAspeNhDUUm36M3xOPO/xWFA/v/bZUP6dD4YfN7FJbqeQBlHj3HmUyAugBi8/tcK
         VtsMKsZ3t4M91fXJvXnUYcATw650sdLct3CJDP2DLbx/twXbfWsY/8+xzR0AHZCAvq4Q
         6Vmw==
X-Gm-Message-State: AGRZ1gJ9bHFf4RYUMWW2veHluDZ/o1HuPJ0sTaGRjU6E0k4eKFot+xuz
        yqGPd0qfB2vdk/7quCYyO8o=
X-Google-Smtp-Source: AJdET5d2UggJlhYEg1BA/jf33tB4ShV7cXXNSryIBDIRx958vX9aOMmUqImjzHNxkh0fVi9RnpvNzA==
X-Received: by 2002:adf:f342:: with SMTP id e2-v6mr5183608wrp.219.1541832350159;
        Fri, 09 Nov 2018 22:45:50 -0800 (PST)
Received: from localhost.localdomain (ip-76.net-89-3-178.rev.numericable.fr. [89.3.178.76])
        by smtp.gmail.com with ESMTPSA id e14-v6sm5878036wrv.93.2018.11.09.22.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 22:45:49 -0800 (PST)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH] riscv: add S and U modes to ISA string
Date:   Sat, 10 Nov 2018 07:45:43 +0100
Message-Id: <20181110064543.12411-1-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting kernel (4.20-rc1) with riscv-pk @
6ebd0f2a46255d0c76dad3c05b16c1d154795d26 (master/HEAD) on Fedora 29 one gets:

[..]
[   55.075000] unsupported ISA "rv64imafdcsu" in device tree
[   55.075000] unsupported ISA "rv64imafdcsu" in device tree
[   55.076000] unsupported ISA "rv64imafdcsu" in device tree
[   55.076000] unsupported ISA "rv64imafdcsu" in device tree
[   55.077000] systemd[1]: Detected architecture riscv64.
[..]

The patch adds the missing S and U modes.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
---
 arch/riscv/kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 3a5a2ee31547..4029c7e6872b 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -64,7 +64,7 @@ int riscv_of_processor_hartid(struct device_node *node)
 
 static void print_isa(struct seq_file *f, const char *orig_isa)
 {
-	static const char *ext = "mafdc";
+	static const char *ext = "mafdcsu";
 	const char *isa = orig_isa;
 	const char *e;
 
-- 
2.19.1


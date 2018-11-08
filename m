Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817BBECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4880A2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpXVov7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4880A2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeKIEn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:43:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32897 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbeKIEnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:43:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id u9-v6so12091984wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 11:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tHsK0hhrKmdeeb3ghMdlBw0MAo3rlZFjyqHNm6Q0ZR0=;
        b=rpXVov7hv6/psus9dpe+GRQrRwrJI6lSNw64tpPO97PeC/DUs5VBDTUMFjmHJ131Pg
         oJVFCkIuAhOqE3RrExVlvVZsqpZlyrcCpJ7yJNgbNccOBbRT622zi5K1BDnxKyyzrYrT
         9Kqy/LMqJxqq+5F7DLPi3DGnVAtlHRjr6A9AKH283vEu2qMwgkIz2Ah4uyQc7lvv8Jc+
         LXlmlv/yqQe/25jHzYhiI3UbQqRpHMK+kRbNn7vDzW5aYL6tD+T5TrKKbWSHcXJiLZyS
         74xhdl4xx0JRuEGP9mBPF3hW3JDRumRo+lC5kCL3uWdaTt9FV3kEemo4BGFZmXcUxPGb
         HC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tHsK0hhrKmdeeb3ghMdlBw0MAo3rlZFjyqHNm6Q0ZR0=;
        b=alXC97JjpAG3ZqimezcWXTEomzxsXSbe7Ll/vbpQp++G+G+AMZwrS01azsnHzXgMqb
         2UvUSOp/lbbDJN1oUS9b5HKwY0XOEYNjY2cKYXiIQu+iOj/Cq6Hket+7qxZ/xjMpf5ac
         HfoHJY9o4wFMY4R6B9iqRtZ0js2fRMJlM+BNi98bD4CycXhxcvjsgR5DDlGO0gkRHyXr
         b4E2gMgHpQekHrp4U69Wxi9G2axdcdALOFYVBaxGGFWixywtOtvMGo9ZCyb6182tKPet
         WX0P7O+uktkSPsOAhlsCq7qj7Ine8Xd41udwhT52aTPbY5tIrF+0H1isCYKql8xMp46J
         8/dA==
X-Gm-Message-State: AGRZ1gKDCMO/dfsNwuq+OgNzdqqqD1FYXGwayTDgqOn6L1Cy2UaDmrcd
        9HN5GP/bp8kvaNwG3IH2CvU=
X-Google-Smtp-Source: AJdET5fut7tiCpoKcNQEH1HIxdbI46PYanxIm3fghms0xgWRCgt93ADAyeh7ZaKotZnfe76NRAObsw==
X-Received: by 2002:a5d:664e:: with SMTP id f14-v6mr5398407wrw.218.1541704023838;
        Thu, 08 Nov 2018 11:07:03 -0800 (PST)
Received: from localhost.localdomain (ip-76.net-89-3-178.rev.numericable.fr. [89.3.178.76])
        by smtp.gmail.com with ESMTPSA id e14-v6sm3010547wrv.93.2018.11.08.11.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 11:07:03 -0800 (PST)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH] riscv: fix warning in arch/riscv/include/asm/module.h
Date:   Thu,  8 Nov 2018 20:07:00 +0100
Message-Id: <20181108190700.30825-1-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes warning: 'struct module' declared inside parameter list will not be
visible outside of this definition or declaration

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
---
 arch/riscv/include/asm/module.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/module.h b/arch/riscv/include/asm/module.h
index 349df33808c4..cd2af4b013e3 100644
--- a/arch/riscv/include/asm/module.h
+++ b/arch/riscv/include/asm/module.h
@@ -8,6 +8,7 @@
 
 #define MODULE_ARCH_VERMAGIC    "riscv"
 
+struct module;
 u64 module_emit_got_entry(struct module *mod, u64 val);
 u64 module_emit_plt_entry(struct module *mod, u64 val);
 
-- 
2.19.1


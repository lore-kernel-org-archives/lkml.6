Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91236ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E7620832
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BH2K2UTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E7620832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeJYIsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:48:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45169 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJYIsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:48:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id s3-v6so3106004pga.12;
        Wed, 24 Oct 2018 17:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s+RUdShvwMM6rr/uuU22QGgj6n7GIZiSDfLiTt5iSHE=;
        b=BH2K2UTfbdJxWwiTNS/S6/8Y2//JZZWfovtGYaD6cSCMAyt4ea/lCNnMxlI3bcFmYu
         bGdTreUHe/3opQiDBavJ6+YW+cTBvIdStz8tmQ6WbBg1x8Qhqtiglp7DC41pqvriOBtr
         1TE9OJ2+Q51aJVm8J/u1kw6MmywgHqGjkrZ4ZHDol+uk7hMkBCLvzyC9qV3chXX9Ggqa
         ahhItnGTn4FR+HtFgEBP4WbzkJEG1HEirbwnzhmUkC5DnGQ2FZd7SREceJh57Fgrp8W/
         qoM1oHD1WqYtEmM15dKyu+BMDLOkRgvzUXRIEEhZxG68zpuQ0sWTNQWosZfPPhyR7w2F
         bA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s+RUdShvwMM6rr/uuU22QGgj6n7GIZiSDfLiTt5iSHE=;
        b=MgcuOeI3fctC2z1T8M8wBo8Q6Ufiy7VeePmJ88T+LFry2kYjRlJgKX+odTQm+O0Eoh
         E4AUIdjNeOeZqAsML4olQs2Eibl5jKEiqHLwTf/B3Q5oweeEIp28dpfiJ4qshy58mbYV
         ALplAwnJWyFCKpCXcrk/4Z6gV1WZ9Tix8dFsi7dTTtGPsTx5RSHeYMkrzxCLR3pyKdoT
         bOhpf7JhdcxgXOkU+ILw2lP+iXWWxJymR8eRzD0KTRbapqBFuAm95Xl+zfo0Wp0wmClI
         Qi24cnUQrG3ZlYcta+KlThREJa8VDKcSXsXZ/xlMLpkpMnyAGxl5catB8ZLTjJ8+DecN
         JQCg==
X-Gm-Message-State: AGRZ1gK/eduaAKNy+yFMCBJ5wKUQ/vaeIvYT/BKiN5KYDOY9OwuzKGVW
        hupWL/PJ0siJcYBpyOEAkqtKl9PY2c4=
X-Google-Smtp-Source: AJdET5fTCQ/7sgs5uF96Xpj+3YdzpK/rbYK8XLsCuj5JozVWAMfmG9RmFqHEdQdGxmkxqvne0cj3Tg==
X-Received: by 2002:a63:9409:: with SMTP id m9-v6mr4350164pge.93.1540426675557;
        Wed, 24 Oct 2018 17:17:55 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z87-v6sm11615707pfl.58.2018.10.24.17.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 17:17:54 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), arnd@arndb.de
Subject: [PATCH v3 2/3] arm64: Remove custom __early_init_dt_declare_initrd implenentation
Date:   Wed, 24 Oct 2018 17:17:41 -0700
Message-Id: <20181025001742.6510-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025001742.6510-1-f.fainelli@gmail.com>
References: <20181025001742.6510-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that drivers/of/fdt.c includes the proper implementation for ARM64,
we can get rid of our custom __early_init_dt_declare_initrd()
implementation.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/memory.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..dc3ca21ba240 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -168,14 +168,6 @@
 #define IOREMAP_MAX_ORDER	(PMD_SHIFT)
 #endif
 
-#ifdef CONFIG_BLK_DEV_INITRD
-#define __early_init_dt_declare_initrd(__start, __end)			\
-	do {								\
-		initrd_start = (__start);				\
-		initrd_end = (__end);					\
-	} while (0)
-#endif
-
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
-- 
2.17.1


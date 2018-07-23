Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB65C6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 01:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6689320854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 01:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGMho5oN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6689320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbeGWC6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 22:58:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37042 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731059AbeGWC6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 22:58:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id n7-v6so11051378pgq.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 18:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A1OqVoZAh5Xl0rWEI6oRjLgOW69kgPoUkzG/O/9JyGg=;
        b=NGMho5oNU0sE4qV10nbpz5y3r5YofIIe50EThWfDdQjHJMZlrMEFY90K7dYQWqHXxV
         Qh0nh3+tX2xghAHqx/FB44jlwZT5daZ96QijBVA5BP8D4aeAnGZ8H2IoXtwqMxzxxU8J
         9XAeiQwgbJd3sGg5UKoYvGUKRUyuc6QE5BVKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A1OqVoZAh5Xl0rWEI6oRjLgOW69kgPoUkzG/O/9JyGg=;
        b=F/tCSSp/MkySBXBT6yv2bIWLJx6odj/KwVzZQiRKol++afk89H9B8ijxbLaVGqiQ7w
         lLsKE01qm5dy43JheGUxh2coGjydinqZgamYMZol24uncpmSv56gzbJnFQJ4S/yXXjzA
         Ujb6VtohsFzkm5Ex/ARW2Kh7Arm9hMAe4//LVLFIMwMZfIzOoKBN6nOoOCWUGbA5SgVr
         D/qsfO8Qgx4SbIoJvBawa5HUL9M3DNLytJA6oslRHYiqf2vSD0/SywtdX4nu/GzyBMex
         DxrTijj6XyViM1wfl586+gSorCgiT1fdPBmt0AGxSuyRpshyXafDlVRz1m3P/ywtyy+N
         28cw==
X-Gm-Message-State: AOUpUlErftJV8XBXGjeThI9ytp50lqhsChV5mLNsBJd7b1XhFZLoCE01
        Wqnsx9O2yvrh1p0C1X5is98+dA==
X-Google-Smtp-Source: AAOMgpevYWf5hsR2/cmWNRtclg9mDSVcbsTeXgzYkZzdnaXpWdaF5cCy0S8ephRxEz93H+eK6jbbuQ==
X-Received: by 2002:a63:af14:: with SMTP id w20-v6mr10746599pge.47.1532311162129;
        Sun, 22 Jul 2018 18:59:22 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id m26-v6sm10000028pfi.102.2018.07.22.18.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 18:59:21 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, ard.biesheuvel@linaro.org
Cc:     tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v4 2/5] drivers: acpi: add dependency of EFI for arm64
Date:   Mon, 23 Jul 2018 10:57:29 +0900
Message-Id: <20180723015732.24252-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723015732.24252-1-takahiro.akashi@linaro.org>
References: <20180723015732.24252-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Ard suggested, CONFIG_ACPI && !CONFIG_EFI doesn't make sense on arm64,
while CONFIG_ACPI and CONFIG_CPU_BIG_ENDIAN doesn't make sense either.

As CONFIG_EFI already has a dependency of !CONFIG_CPU_BIG_ENDIAN, it is
good enough to add a dependency of CONFIG_EFI to avoid any useless
combination of configuration.

This bug, reported by Will, will be revealed when my patch series,
"arm64: kexec,kdump: fix boot failures on acpi-only system," is applied
and the kernel is built under allmodconfig.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index b533eeb6139d..15ab1daaa808 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -6,7 +6,7 @@
 menuconfig ACPI
 	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on !IA64_HP_SIM
-	depends on IA64 || X86 || ARM64
+	depends on IA64 || X86 || (ARM64 && EFI)
 	depends on PCI
 	select PNP
 	default y if (IA64 || X86)
-- 
2.18.0


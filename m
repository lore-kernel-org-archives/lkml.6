Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06113C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C167120675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jd2M/fur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbfAOTSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:18:45 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44916 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729633AbfAOTSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:18:44 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so2909406lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 11:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1xkvY33qLaFRb0R1VDCtBPYVc9gDjRgw4GnLsSZDD3o=;
        b=Jd2M/fur6g+ebFQr0b0ZOYZUdty2Nud8TwgANhYRwFcHQlPvipshLVps5bNN90RBJE
         Gt0Ipdea+1zpGK5KM9RJz9/XNIBy5/aBY2/QfsTtdlctjzx2eBXZ+UWsNFkJ2xvL/Xiz
         7fyeil7BHseF3A0K9axxfifbFIV4xTqfkbImI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1xkvY33qLaFRb0R1VDCtBPYVc9gDjRgw4GnLsSZDD3o=;
        b=MuSF6xC3gqh5hZOd0XQnsegYOar25b7USDIKkloP1QHaSn6zbN9QxvVa2ihBI9mtqe
         IUK0L+5R0F0usA34I/Q8AkRYE/o3MX/KTRFzzXMMrIXO/aOpaolwG6KW2CwE4hE7UkVW
         qwul7EkgIiVFvW+EZrgdtF7Hb/N6FtG68wzhTyB6DFp1XukZXoLPNhY4+1k5K67uBpJV
         NsJbI529ET7tHhboyOVlSbPcBxWXIyX93BNYq0fGO5TjkcCtbPsVdeP8vb2MTspyBcny
         /WX7nJ2Fx9gPEI++XEVUKvZpSBRoi1hdir7el7EsaPmh+1m9DYJNjJvN9bCFkKO809Ri
         KYZg==
X-Gm-Message-State: AJcUukdRlOlICSXPew5eN1uneO2bhz2xHJNp+VTGBlf2YWiU5JkqDAOK
        0NyeGQ77d6lqXSddCQXQkFr0HMWa55H30Q==
X-Google-Smtp-Source: ALg8bN7BhJwQ1IdNP6iPvtp0u35H9sqhx7BMXB26EAEvWnmf66qwOPgvgSOn9bviI1IogMdDEAr8mg==
X-Received: by 2002:ac2:554b:: with SMTP id l11mr3956878lfk.92.1547579922409;
        Tue, 15 Jan 2019 11:18:42 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id c2-v6sm695005ljj.41.2019.01.15.11.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 11:18:41 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] arm64: Kconfig.platforms: fix warning unmet direct dependencies
Date:   Tue, 15 Jan 2019 20:18:39 +0100
Message-Id: <20190115191839.13823-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ARCH_MXC get enabled, ARM64_ERRATUM_845719 will be selected and
this warning will happen when COMPAT isn't set.

WARNING: unmet direct dependencies detected for ARM64_ERRATUM_845719
  Depends on [n]: COMPAT [=n]
  Selected by [y]:
  - ARCH_MXC [=y]

Rework to add 'if COMPAT' before ARM64_ERRATUM_845719 gets selected,
since ARM64_ERRATUM_845719 depends on COMPAT.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/Kconfig.platforms | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 251ecf34cb02..d4faca775d9c 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -145,7 +145,7 @@ config ARCH_MVEBU
 config ARCH_MXC
 	bool "ARMv8 based NXP i.MX SoC family"
 	select ARM64_ERRATUM_843419
-	select ARM64_ERRATUM_845719
+	select ARM64_ERRATUM_845719 if COMPAT
 	help
 	  This enables support for the ARMv8 based SoCs in the
 	  NXP i.MX family.
-- 
2.19.2


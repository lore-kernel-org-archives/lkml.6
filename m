Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13776C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5A5208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="bNUEGftr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5A5208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbeKQMKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:10:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42434 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbeKQMKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:10:01 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so7735646pfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 17:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=fYD1CJsEoNuW6Fa4eRyng4gkxuPQdpl1uLpVMpBV/MI=;
        b=bNUEGftrAIdiKpYru2HhxiDE4HSCggd9u+JIAOxv81GHQRj16cvhnq90aIh9OOlxOx
         I2nSv9VtbRaOVV5J75VMjU7ctrdXuzzuICecAYwMb/VJnuaZVLGjkKsVObpAXjU+SQ4e
         X41kfS1mMAYC7gO6PqzMhsyRtuuIsyMbSQmKULBwzOvHeaaGKN7tsr/fP3PPYQsFzEKN
         jngXfDal8rPjFkVL3uUqDSsvHfIE8qxSDCUaQ/NhyugOH0opWhdpL7QaIYxKJs7La74Y
         IQvKSOeFtR0dEOuPLKAMwWegeNNjwtb/XBiFk/lECTjButi4xRQnmQ74z5zL0G961O8W
         /J3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fYD1CJsEoNuW6Fa4eRyng4gkxuPQdpl1uLpVMpBV/MI=;
        b=MUxjb83TJ0GyuPqhoshKX9tozt4B2fuDpoE17xp25tms+TXJSrxkhhg/wuif2EAkrf
         gOANVbFAac94QCQcDpAe3D78mo4AAdG0+5lMCTyvE7VfIyAZH638bf6qEsYWy+AZzKMb
         cc5eeyiCWXD9GOBKf2kHAjV9Efu3P0FGW2rHsdRQonpGKJ2aM4WpaJIFs1ltegjYmVL7
         ZVPVccWEGGRHJ3vVKpaOZBo81WFoWfN18AiAhcvKHvMcl0ppSPWvpiIFbGTGWkZAs5oN
         8VsC0b8fnwUxhkxx9kpLHm2XG3yeE65TCawlFj6UfkhRZ71fjqBnFAZ73XY95FK7gZOi
         K7Cg==
X-Gm-Message-State: AGRZ1gL31jFXr+HESL0dRu1rdz4hmpAe+F4dw++6RLeGFDNkC5Bef9sq
        8LO0NzHbP6hPg7i1PDBbPCSRMQqQzX2vdQ==
X-Google-Smtp-Source: AJdET5cV2u8ClI7hZxLPeYxFFfJnk6f9kz/cE7ivy1kAedljxCTmkyjeD9rF6qkUSaKblLFyrVeJyg==
X-Received: by 2002:aa7:8354:: with SMTP id z20mr13440648pfm.81.1542419710826;
        Fri, 16 Nov 2018 17:55:10 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id u7-v6sm23777203pfu.34.2018.11.16.17.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 17:55:09 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] arm64: Explicitly mark 64-bit constant as unsigned long
Date:   Fri, 16 Nov 2018 17:54:56 -0800
Message-Id: <20181117015456.101222-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes sparse happy. Before:

arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm64/include/asm/sysreg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 0c909c4a932ff..981892b67b8f6 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -468,7 +468,7 @@
 			 SCTLR_ELx_SA     | SCTLR_ELx_I    | SCTLR_ELx_WXN | \
 			 SCTLR_ELx_DSSBS | ENDIAN_CLEAR_EL2 | SCTLR_EL2_RES0)
 
-#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xffffffffffffffff
+#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xfffffffffffffffful
 #error "Inconsistent SCTLR_EL2 set/clear bits"
 #endif
 
@@ -509,7 +509,7 @@
 			 SCTLR_EL1_UMA | SCTLR_ELx_WXN     | ENDIAN_CLEAR_EL1 |\
 			 SCTLR_ELx_DSSBS | SCTLR_EL1_NTWI  | SCTLR_EL1_RES0)
 
-#if (SCTLR_EL1_SET ^ SCTLR_EL1_CLEAR) != 0xffffffffffffffff
+#if (SCTLR_EL1_SET ^ SCTLR_EL1_CLEAR) != 0xfffffffffffffffful
 #error "Inconsistent SCTLR_EL1 set/clear bits"
 #endif
 
-- 
2.11.0


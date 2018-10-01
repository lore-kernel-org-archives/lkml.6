Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0175FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3206205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="F6C2FUXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3206205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbeJARCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:02:42 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:29890 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbeJARCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:02:42 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w91AO8Y3032372;
        Mon, 1 Oct 2018 19:24:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w91AO8Y3032372
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538389449;
        bh=ULTMewL42Fo19v7Ruh3OqprQvPf1MpIZbX64M6oAqks=;
        h=From:To:Cc:Subject:Date:From;
        b=F6C2FUXpGKZa4MqNvP2V3dYqD16yYiRUpUlvNtTF2bVFlYNCr88zLhA4z/U2b+twR
         iTW0p5zDPDsM4N4koYkG2MuRgGvNTyHHgUKyNAa+Yo5TqqoC8FlkzJc/LHfCA6d/Ue
         HVs2U4lsp4SNIJ8W3vNU+HS9c++yks6iikKqgs+qLH24WqKX4erLS/tCEFvhjwZTxn
         Xu34uHCUXzxpJ1L1X18KJuXvNPjiSKxxGKwyu8SDBi5w6Faor8wLp0eUSK2kOsBfuj
         59hxzZ5/mMZaydcC+f5LnzT1gnZDtcAi/GfOW3StsD9HEZ2iZyURVAkZZHlWyrii8C
         UGc57CTVCPiDQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/build: remove unused CONFIG_AS_CRC32
Date:   Mon,  1 Oct 2018 19:24:03 +0900
Message-Id: <1538389443-28514-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_AS_CRC32 is not used anywhere.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index bbdb780..bf0265f 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -189,7 +189,6 @@ cfi-sections := $(call as-instr,.cfi_sections .debug_frame,-DCONFIG_AS_CFI_SECTI
 # does binutils support specific instructions?
 asinstr := $(call as-instr,fxsaveq (%rax),-DCONFIG_AS_FXSAVEQ=1)
 asinstr += $(call as-instr,pshufb %xmm0$(comma)%xmm0,-DCONFIG_AS_SSSE3=1)
-asinstr += $(call as-instr,crc32l %eax$(comma)%eax,-DCONFIG_AS_CRC32=1)
 avx_instr := $(call as-instr,vxorps %ymm0$(comma)%ymm1$(comma)%ymm2,-DCONFIG_AS_AVX=1)
 avx2_instr :=$(call as-instr,vpbroadcastb %xmm0$(comma)%ymm1,-DCONFIG_AS_AVX2=1)
 avx512_instr :=$(call as-instr,vpmovm2b %k1$(comma)%zmm5,-DCONFIG_AS_AVX512=1)
-- 
2.7.4


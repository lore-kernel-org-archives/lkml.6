Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F3EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF8B2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF8B2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbeJATlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:41:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35641 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbeJATlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:41:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w91D3svm1575170
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 1 Oct 2018 06:03:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w91D3sYA1575166;
        Mon, 1 Oct 2018 06:03:54 -0700
Date:   Mon, 1 Oct 2018 06:03:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-ac0d6567955cf70dd43d56b677361c9d4c3d7710@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, bp@suse.de,
        tglx@linutronix.de, yamada.masahiro@socionext.com,
        mingo@redhat.com, hpa@zytor.com
Reply-To: mingo@kernel.org, bp@suse.de, yamada.masahiro@socionext.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@redhat.com, hpa@zytor.com
In-Reply-To: <1538389443-28514-1-git-send-email-yamada.masahiro@socionext.com>
References: <1538389443-28514-1-git-send-email-yamada.masahiro@socionext.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/build: Remove unused CONFIG_AS_CRC32
Git-Commit-ID: ac0d6567955cf70dd43d56b677361c9d4c3d7710
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ac0d6567955cf70dd43d56b677361c9d4c3d7710
Gitweb:     https://git.kernel.org/tip/ac0d6567955cf70dd43d56b677361c9d4c3d7710
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Mon, 1 Oct 2018 19:24:03 +0900
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 1 Oct 2018 14:58:09 +0200

x86/build: Remove unused CONFIG_AS_CRC32

CONFIG_AS_CRC32 is not used anywhere. Its last user was removed by

  0cb6c969ed9d ("net, lib: kill arch_fast_hash library bits")

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1538389443-28514-1-git-send-email-yamada.masahiro@socionext.com
---
 arch/x86/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 8f6e7eb8ae9f..0e496ed476d4 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -193,7 +193,6 @@ cfi-sections := $(call as-instr,.cfi_sections .debug_frame,-DCONFIG_AS_CFI_SECTI
 # does binutils support specific instructions?
 asinstr := $(call as-instr,fxsaveq (%rax),-DCONFIG_AS_FXSAVEQ=1)
 asinstr += $(call as-instr,pshufb %xmm0$(comma)%xmm0,-DCONFIG_AS_SSSE3=1)
-asinstr += $(call as-instr,crc32l %eax$(comma)%eax,-DCONFIG_AS_CRC32=1)
 avx_instr := $(call as-instr,vxorps %ymm0$(comma)%ymm1$(comma)%ymm2,-DCONFIG_AS_AVX=1)
 avx2_instr :=$(call as-instr,vpbroadcastb %xmm0$(comma)%ymm1,-DCONFIG_AS_AVX2=1)
 avx512_instr :=$(call as-instr,vpmovm2b %k1$(comma)%zmm5,-DCONFIG_AS_AVX512=1)

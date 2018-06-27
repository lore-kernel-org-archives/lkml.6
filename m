Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022B5C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1D725AAC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="RFB1DW+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1D725AAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935170AbeF0Trw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:47:52 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37453 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935128AbeF0Tru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:47:50 -0400
Received: by mail-pf0-f196.google.com with SMTP id y5-v6so1445417pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CbiIAbtXjBY7brOqPA9Uiplq3cBuUCchk/D3EVIB8uk=;
        b=RFB1DW+989riWr27svLbRR0+43a45EDiJmAoOt6BUccY9YuXlR9eOOtotM2cLlYIYW
         i6t86EO7PigYUNJmv1WoJwGMtC11AJRHkyzXHf7z6cmPmEb1TZzW01suU6JU0B/gQjQ5
         s26LQ8LuR/lWHAp9l4a71l3Tjcw+P2KknyREXnvE8nghHwLvQLwn5VSqPxIvH/s2Cb+r
         0punE95H2ILvQELVEsHoeFBJjzECpGgo3g6wJr+cdvSpQ6lH6mqeOemL3E//CWlU3SGr
         clSz9opoWQrLFoHqJIK/6xaGjsnbEJa8dbb85p0F5sSUeaVoEUcrwQSOXyMWOsRhpVwH
         F7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CbiIAbtXjBY7brOqPA9Uiplq3cBuUCchk/D3EVIB8uk=;
        b=Ik958Y6EanRhtbRXOKSXa5an2VMj6jGQdn2oaEfSe+aOd6xxqj0lIdVwIJJgL44LVd
         Jv8m26pgDdcaVGe0vbWLM+Pv8DOGdsUkglEmmA89XV+CX9CAf7M7YzjOqE4B06WscXWo
         Zqt08zVh2J2f6e0A2JoiTJ+Y346mrpJz+/6IrNpB5LGUIGhfjthDfNBfGyR1Kfhbkvn0
         gerAx2rzKKQfsjHqjRcwqzt8Pm6AWCiRkU19GoG8wEft+6+RmVrSGmotRAZ5Em38N385
         n53c3LxvkX2mUFb99gAGFWS1gtquL7ARueeOkhTADwJjhyD00bnL+k7RgFQVgvpeWBiX
         GmZg==
X-Gm-Message-State: APt69E0heiu/eYLj2gLLnjq6UjBg2gbzIaYp99s/ApXzLU1ykvGYvi4L
        WOfF8YUwQj5X+WU/cYLpEsIwzA==
X-Google-Smtp-Source: AAOMgpcsTGGYiEUFWtUgJk4/vYKPZifb3Cuf+hVmT6nRzgAkGJZNiZogxXl2qrjQGBB771kXUS0MOw==
X-Received: by 2002:a62:5d18:: with SMTP id r24-v6mr5524091pfb.87.1530128870022;
        Wed, 27 Jun 2018 12:47:50 -0700 (PDT)
Received: from hackmann.mtv.corp.google.com ([2620:0:1000:1600:2377:5409:db26:9d95])
        by smtp.gmail.com with ESMTPSA id s83-v6sm5505236pfj.126.2018.06.27.12.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 12:47:49 -0700 (PDT)
From:   Greg Hackmann <ghackmann@android.com>
X-Google-Original-From: Greg Hackmann <ghackmann@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, mka@chromium.org,
        Greg Hackmann <ghackmann@google.com>
Subject: [PATCH] arm64: remove no-op -p linker flag
Date:   Wed, 27 Jun 2018 12:46:14 -0700
Message-Id: <20180627194614.188210-1-ghackmann@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linking the ARM64 defconfig kernel with LLVM lld fails with the error:

  ld.lld: error: unknown argument: -p
  Makefile:1015: recipe for target 'vmlinux' failed

Without this flag, the ARM64 defconfig kernel successfully links with
lld and boots on Dragonboard 410c.

After digging through binutils source and changelogs, it turns out that
-p is only relevant to ancient binutils installations targeting 32-bit
ARM.  binutils accepts -p for AArch64 too, but it's always been
undocumented and silently ignored.  A comment in
ld/emultempl/aarch64elf.em explains that it's "Only here for backwards
compatibility".

Since this flag is a no-op on ARM64, we can safely drop it.

Signed-off-by: Greg Hackmann <ghackmann@google.com>
---
 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 45272266dafb..79bd701071de 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -10,7 +10,7 @@
 #
 # Copyright (C) 1995-2001 by Russell King
 
-LDFLAGS_vmlinux	:=-p --no-undefined -X
+LDFLAGS_vmlinux	:=--no-undefined -X
 CPPFLAGS_vmlinux.lds = -DTEXT_OFFSET=$(TEXT_OFFSET)
 GZFLAGS		:=-9
 
-- 
2.18.0.rc2.346.g013aa6912e-goog


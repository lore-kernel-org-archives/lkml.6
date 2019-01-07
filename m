Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ED8C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB5E2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="z9XzDcy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfAGQLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:11:09 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39346 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfAGQLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:11:09 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so354415pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 08:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=r+bbCVvJkcdWrVFRIVDVXamcKKSHxagP8W8Jb1FDxYQ=;
        b=z9XzDcy1of7BfEH5zq2Cyro9679+pORefM33EwJ3aDSKyRGyQVC4wwnZhQqrR/wLJ2
         Dkh3o3WhR0+c6bIz8qG8vJxFPl6fabgFbSLjADfnBaya0dQXFM/50nnB3IrBWaUm1UiN
         QCSm8JKj4IZNxQTjdr0AER3VKQxTByh9N6pJ3E1gs7qhK3zlXlTpkln5gd0mLF7EeBVI
         GHIaObfwAplHtBf7G1oR+op4X5rGcOmDl90N/2Btt0qzyD7zNXdCuLltw/LRp4lN3EbM
         r05NglnIfPDp1rZ9JGDfQ3f5GXz2TyCEh+HAOdUh86CO3zUdiotNx1J5w74eWR/9focA
         Vv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r+bbCVvJkcdWrVFRIVDVXamcKKSHxagP8W8Jb1FDxYQ=;
        b=a4RRPAUNmZFfwUtnqdETE/5PXtUo3kmZTTWVFRM0+oeKta5Oq9Ew+PVaTL7ByRvB2n
         ofJ1yaMETZ61DQJCiDsrJlO7igH8uc0EBx/DZ/dABbB3vagGqmue9Kr8Ywo+4SFzTHlY
         Slcf+mHie0O4QeVppTV8r8GcUirnpt064dEab2scpH4EOvUE2LG19mspRM2UQwLZjogZ
         dEUD53oMDs8DBoX/ZcujkxxKWoD949ME5dw9DgnEUX8mlHnvNKsX3N2ntcoOUb6+t8Gp
         Ka+rY9MEdBvoKsJoA2J+GJaw1nL2SlGgwFn0w4GLFR1QkuhF5cgvOxELYe0Ip4WLSflw
         EVlQ==
X-Gm-Message-State: AJcUukehZiVD5sYN2BjMYZQCvDd6dHJWhFN7v380mpHQ5UOCB4mR56aA
        SH+yGkb/tO2UrC8XyvGNGrf8ww==
X-Google-Smtp-Source: ALg8bN6kZXlXrShgikTMcu6Ca2qumG5QUiMtCF1XpdgJuv2DfBtPdXF3GgEhpXT3zdrD1G11ulwXfg==
X-Received: by 2002:a17:902:280b:: with SMTP id e11mr62036116plb.269.1546877468236;
        Mon, 07 Jan 2019 08:11:08 -0800 (PST)
Received: from localhost.localdomain ([49.207.48.214])
        by smtp.gmail.com with ESMTPSA id a10sm93243512pfi.138.2019.01.07.08.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 08:11:07 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH 0/5] Fixmap support and MM cleanups
Date:   Mon,  7 Jan 2019 21:40:42 +0530
Message-Id: <20190107161047.10516-1-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset does:
1. Moves MM related code from kernel/setup.c to mm/init.c
2. Implements compile-time fixed mappings

Using fixed mappings available, we can now get earlyprints
even without SBI calls. For example, we can use kernel
parameter "earlycon=uart8250,mmio,0x10000000" to get early
prints on QEMU virt machine without using SBI calls.

The patchset is tested on QEMU virt machine. It is based on
Linux-5.0-rc1 and can be found at riscv_fixmap_v1 branch of:
https://github.com/avpatel/linux.git.

Anup Patel (5):
  RISC-V: Move free_initrd_mem() to kernel/setup.c
  RISC-V: Setup init_mm before parse_early_param()
  RISC-V: Move setup_bootmem() to mm/init.c
  RISC-V: Move setup_vm() to mm/init.c
  RISC-V: Implement compile-time fixed mappings

 arch/riscv/Kconfig               |   3 +
 arch/riscv/include/asm/fixmap.h  |  52 +++++++++++++
 arch/riscv/include/asm/pgtable.h |   1 +
 arch/riscv/kernel/setup.c        | 106 +++-----------------------
 arch/riscv/mm/init.c             | 123 ++++++++++++++++++++++++++++++-
 5 files changed, 186 insertions(+), 99 deletions(-)
 create mode 100644 arch/riscv/include/asm/fixmap.h

-- 
2.17.1


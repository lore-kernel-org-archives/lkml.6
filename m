Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1242ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892BF2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnOQriTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892BF2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbeGRKzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:55:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43278 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbeGRKzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:55:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id v13-v6so1793088pgr.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5cy94I7Jhsyyb71nQTgp6UGHYIPLAl52HuyX7InuEcI=;
        b=TnOQriTuvH41y6y//7CFqqxk2q4Z5eYY9UTRBoOeY0ySOiaYoZm1GPNQrR5iqiYTLi
         NZvP8B8QkaEWiX0cZ1OiHuA/0bL5P6T7wx/GPI6HeVN9cQSY7tnrWNW9uX8zvPoi4Z6b
         NBXQKmAQ4l8bBzgg/pgy9Ynj1dOxiM4MfR2Gw7rQ7Yz/j4j8ixgW9GALvSg+NA4LjFMF
         zoX4q6fb3w3Z6egQnuCSYwo3SbiODGWNKfP2yoHiTIGu6vSO+EDzOMi1eHFmZFbK/kpH
         eeSHQaMSwZSjTZ7pENj02VG+FR5Lhsz3C47dVOe4rxw0BgpY0jRPDb26iTBT/cKQ0Gw4
         r5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5cy94I7Jhsyyb71nQTgp6UGHYIPLAl52HuyX7InuEcI=;
        b=Lnq4qA3cWJ0l8PW7vfgpUE/C0Kn8tcS+WYW8uI3ur4RKyL0PlOCtXGlU74wplu+kNk
         cmBCzV3y8T0wZWuA9ay9663TMsIOEyxnHzsNleW4hnKVtA+IexozrKhbfqi4mHSLlRje
         4wak3bKtQOcPJhvyuRnIV993Ri+d7JOQDiAPgvwi12xRYoNucNrOCxWBxH0FOTGBgAHJ
         1kYxZEat6qPAO0eJjtJaidJKkIbiAx4uz0mAULOYAXj816hD59Jqoif8YFvOYCgnCKHV
         5GCgEvddpqTvgNBu2stwbuK6Z8cmiia9NwBVkvNkL70PNpP6x4IuLQxHrEImEX9UObZ4
         sg3w==
X-Gm-Message-State: AOUpUlEOStZUNFxBGq+PfNxvbYbeJagivdUvMr1qsWqT1xL6e1hJhzMC
        cFPCeNTcsiUa+kzbIjp4QHM=
X-Google-Smtp-Source: AAOMgpezVg41SI61HqOMQb1slV7MMD3X34/Pm1J0PyH5cQb70d0WwltdW4XWSm6KqxjjBuPbvioG5w==
X-Received: by 2002:a63:2404:: with SMTP id k4-v6mr5132895pgk.191.1531909076468;
        Wed, 18 Jul 2018 03:17:56 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.10])
        by smtp.gmail.com with ESMTPSA id x2-v6sm6899518pgq.33.2018.07.18.03.17.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:17:55 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4 0/6] arm64/mm: Move
Date:   Wed, 18 Jul 2018 18:17:21 +0800
Message-Id: <20180718101727.10787-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 4 changes:
	1. Rename INIT_DIR to INIT_PG_TABLES and move it outside the
	   '.init.data' section[1].
	2. Move the 'count' calculation to clear_pages()[1].
	3. Rearrange register in __enable_mmu() and pass ttbr1 through
	   the x1 register[2].
	4. Add commit message to explain why we can make swapper_pg_dir
	   smaller[3].
	5. Rewrite in_swapper_pgdir() and use pgd_set_fixmap() to
	   populate swapper_pg_dir. At the same time, add a spin lock to
	   avoid race conditions[4].
	6. Move {idmap_pg_dir,tramp_pg_dir,reserved_ttbr0,swapper_pg_dir}
	   to the KERNEL_PG_TABLES macro. And put this macro after
	   NOTES[4].
	7. Update init_mm.pgd before kasan_early_init() and
           kaslr_early_init(), which makes pgd_offset_k() work properly.

Test following configs with CONFIG_RANDOMIZE_BASE/UNMAP_KERNEL_AT_EL0/
CONFIG_ARM64_SW_TTBR0_PAN enabled on qemu:

	1. CONFIG_ARM64_4K_PAGES/CONFIG_ARM64_VA_BITS_48
	2. CONFIG_ARM64_4K_PAGES/CONFIG_ARM64_VA_BITS_39
	3. CONFIG_ARM64_64K_PAGES/CONFIG_ARM64_VA_BITS_48
	4. CONFIG_ARM64_64K_PAGES/CONFIG_ARM64_VA_BITS_42

v3: https://www.spinics.net/lists/arm-kernel/msg662537.html
v2: https://patchwork.kernel.org/patch/10485641/
v1: https://patchwork.kernel.org/patch/10476595/

[1] https://lkml.org/lkml/2018/7/6/238
[2] https://lkml.org/lkml/2018/7/6/239
[3] https://lkml.org/lkml/2018/7/6/243
[4] https://lkml.org/lkml/2018/7/11/782

Jun Yao (6):
  arm64/mm: Introduce init_pg_dir
  arm64/mm: Make __enable_mmu() take the ttbr1 page as an argument
  arm64/mm: Create initial page tables in init_pg_dir
  arm64/mm: Make swapper_pg_dir smaller
  arm64/mm: Populate swapper_pg_dir by fixmap
  arm64/mm: Move {idmap_pg_dir, swapper_pg_dir} to .rodata section

 arch/arm64/include/asm/assembler.h | 29 +++++++++++++
 arch/arm64/include/asm/pgtable.h   | 66 ++++++++++++++++++++++++++----
 arch/arm64/kernel/head.S           | 48 ++++++++++++++--------
 arch/arm64/kernel/sleep.S          |  1 +
 arch/arm64/kernel/vmlinux.lds.S    | 47 ++++++++++++++-------
 arch/arm64/mm/mmu.c                | 35 ++++------------
 6 files changed, 159 insertions(+), 67 deletions(-)

-- 
2.17.1


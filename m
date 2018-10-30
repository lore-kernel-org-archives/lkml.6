Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03C0C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7179020664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkWhFgrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7179020664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbeJaIDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:03:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42809 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeJaIDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:03:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id f26-v6so6609143pfn.9;
        Tue, 30 Oct 2018 16:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XfAFF30A3FXmhnhQJoMd3dHdYPobUy+1OSlpFhlT3i4=;
        b=GkWhFgrAtWXPJbRCpu1d7yChmE1NtqQ1Sh6ikSpUdTOBupHIsGTPvd/H9I9kE/MmGn
         uR7iI+BFF4P4JU2G4AT3222l72m1Zcy3BqKxjkutI7CKHYxBtpEXBZdP/RcMvO9zPXQ7
         ojU97KmxbcoxdBfJC/WpsKtKEjBbip08l2daOkf9td5SrkQpNU5r7QzI9yax/vSC5cX8
         /Kui4txZZJeNKThs3gmscdRIBdmE/DN0Z/jTV+qANyUB5qHtMYYv5vVaj0v0a0fcrkgN
         rJec9VQxV9LXLTL14vH/QnCpXRg/sf06yMKTT6/pd1PNkpY3xDSgsPlfomw5QWuEYhPm
         o6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XfAFF30A3FXmhnhQJoMd3dHdYPobUy+1OSlpFhlT3i4=;
        b=fvvpdanR8gY1gdMVILljO6qMuVzcKQnqs6z6llxOwbrIqQuXH4tFXh+6mAdvo/jjA9
         iRpbYE7v9iclJY8PHYm2wQYguE7SG7hvAP1xujT+Jvkx7CfU05N31qJ8EGdrdoXnbn3k
         yyEp/5jNGAsRmtwdhebgbhG1xXqflmYKq0jYYn1uM5IZs3F7ZXd86CCy2+Ad/TmPBHKg
         9X6ZgnUC9u8dM7QH63JicAGZig04PRGdVKQ6FmpMSOzQu/6aff9Qmh1TRX5hM0Sao7Sd
         IEXtUyCuUfBske4tGEamcHf05Xr8gObbdvFy7zZOwZkPBL+M5awFMSZlPd+g/whaLGzR
         8lVg==
X-Gm-Message-State: AGRZ1gKcLL0OQ6f41P0cERnq2e2aTAfIspKqM8KaSDNqxySuUmXfVwZA
        KusdvgORAIkr/eLVitZ9x+XNvD5d
X-Google-Smtp-Source: AJdET5fs1HG8NPnQ/g2MkJipSiVB3LTAzBVQnqN3GwAqPS7DP9FTZnZ0vRwNxfnuvw36ja8it2sNXg==
X-Received: by 2002:a63:3546:: with SMTP id c67mr686686pga.284.1540940863927;
        Tue, 30 Oct 2018 16:07:43 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id f14-v6sm3431689pgr.87.2018.10.30.16.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 16:07:42 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Hackmann <ghackmann@android.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), rppt@linux.ibm.com, linux@armlinux.org.uk,
        green.hu@gmail.com, deanbo422@gmail.com, gxt@pku.edu.cn,
        ard.biesheuvel@linaro.org, linux-snps-arc@lists.infradead.org,
        vgupta@synopsys.com
Subject: [PATCH v2 0/6] arm64: Get rid of __early_init_dt_declare_initrd()
Date:   Tue, 30 Oct 2018 16:07:15 -0700
Message-Id: <20181030230721.28429-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Changes in v2:

- get rid of ARCH_HAS_PHYS_INITRD and instead define
  phys_initrd_start/phys_initrd_size in init/do_mounts_initrd.c

- make __early_init_dt_declare_initrd() account for ARM64 specific
  behavior with __va() when having CONFIG_DEBUG_VM enabled

- consolidate early_initrd() command line parsing into
  init/do_mounts_initrd.c

Because phys_initrd_start/phys_initrd_size are now compiled in
ini/do_mounts_initrd.c which is only built with CONFIG_BLK_DEV_INITRD=y,
we need to be a bit careful about the uses throughout architecture
specific code.

Previous discussions/submissions list here:

v3:
https://www.spinics.net/lists/arm-kernel/msg683566.html
v2:
https://lkml.org/lkml/2018/10/25/4

Florian Fainelli (6):
  nds32: Remove phys_initrd_start and phys_initrd_size
  arch: Make phys_initrd_start and phys_initrd_size global variables
  of/fdt: Populate phys_initrd_start/phys_initrd_size from FDT
  arm64: Utilize phys_initrd_start/phys_initrd_size
  of/fdt: Remove custom __early_init_dt_declare_initrd() implementation
  arch: Move initrd= parsing into do_mounts_initrd.c

 arch/arc/mm/init.c              | 25 +++++------------------
 arch/arm/mm/init.c              | 28 ++------------------------
 arch/arm64/include/asm/memory.h |  8 --------
 arch/arm64/mm/init.c            | 35 +++++++--------------------------
 arch/nds32/mm/init.c            |  2 --
 arch/unicore32/mm/init.c        | 24 +++++-----------------
 drivers/of/fdt.c                | 11 +++++++++--
 include/linux/initrd.h          |  3 +++
 init/do_mounts_initrd.c         | 20 +++++++++++++++++++
 9 files changed, 51 insertions(+), 105 deletions(-)

-- 
2.17.1


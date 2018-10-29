Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E144C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F89520870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtwRF2iE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F89520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeJ3Ing (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 04:43:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34966 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeJ3Ing (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 04:43:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id 32-v6so4687777pgu.2;
        Mon, 29 Oct 2018 16:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ywkQ4pBzy+okMcYg/tA16vWIBgM/SUB4JcA2XHdHXas=;
        b=mtwRF2iEbqqJcx6t2XjILD8Ym3OpOps2hG7+1gHz/DgFnHtrQeeJVtjuZ1T1VD1PYO
         gb+Kw0g3uzlrgnXfy8IMOJR0W0Bn8hK/mn6Qm/3cUBBvXIdAj2uSwasJwoRlyAZ5Bl0j
         zQ5vcteD+iaDHXMLsxA80tu2Uv4F7XbQxaotQ6fghNFPNFk8xryZ+7LkxpMReaM8Lotl
         JMYsAip82BDojyd+sjvCy5QE/Fqe9PEchSkWkTJ42oxAB4f+Kvuhwc7pWgNE/8Rz2XGp
         gHj658+Om46yixAShdGBCLkhu8GLZyBnKDKlLng9FJBBJ3/aMdTz0ARSdQGHJsPU6CRz
         2sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ywkQ4pBzy+okMcYg/tA16vWIBgM/SUB4JcA2XHdHXas=;
        b=VvTe/ohEtFNlbORMJBiKumTiupiX+tVOE383xjMeELuoXgLDNJ8B/OZKhsGxISwGSI
         pqjej5rnFGk2p+vzP92Eo4/wPHBjxIzo5ka3HJA3j8nRIqYet6ZnCdwP9Gigj4PKXMY2
         L5zxwdOpTEqmnv34bsWXE4m2CFkLhguSbKGWshBQIFFI5nHOeA+RNanT/B3d5z8XHlQR
         7TwOwy8tra5vgl+JwDudfRWsbKxKRXA4Awp/kPD11vvekyyxJPDK9v3jkLL3MLrP7+Yc
         NmWnle2YTcUekVO5J5upoiuYnDMcT/N0+Cv9kNGWvi3ix8YZ451lKA2hE6xCvMtPxZ3X
         avEg==
X-Gm-Message-State: AGRZ1gLOWsGIImS5gxNOiO+pl/KymniT7wkBbVvoTw4slpk83cciMx+5
        HiYkPlyzjbEly8ie5mV37gw/gStn
X-Google-Smtp-Source: AJdET5fiuGxLO/m9wAL6/HZBi9hxcWXDvU7mweKH7gz2DnQxJLf+asDB1EWA9bms3ivKf8Au5STB4g==
X-Received: by 2002:a63:a552:: with SMTP id r18mr15710615pgu.176.1540857151939;
        Mon, 29 Oct 2018 16:52:31 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id k13-v6sm22537981pff.30.2018.10.29.16.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 16:52:30 -0700 (PDT)
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
        ard.biesheuvel@linaro.org
Subject: [PATCH 0/6]  arm64: Get rid of __early_init_dt_declare_initrd()
Date:   Mon, 29 Oct 2018 16:52:00 -0700
Message-Id: <20181029235206.30060-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The numbers no longer make any sense since I either did not correctly
understand the feedback being given, or dramatically changed the
approach.

This version introduces an architecture symbol: ARCH_HAS_PHYS_INITRD
which indicates whether the architecture cares/supports parsing the
physical address of the initrd. Currently ARM (32-bit), Unicore32 and
now ARM64 support that.

When that symbol is defined, we also have the generic FDT code populate
the initrd physical address and size, and we can later make use of that
within architecture specific code to populate the memblock regions and
do the righ physical to virtual address conversion.

Rob, hopefully this is what you had in mind.

Previous discussions/submissions list here:

v3:
https://www.spinics.net/lists/arm-kernel/msg683566.html
v2:
https://lkml.org/lkml/2018/10/25/4


Florian Fainelli (6):
  nds32: Remove phys_initrd_start and phys_initrd_size
  arch: Make phys_initrd_start and phys_initrd_size global variables
  arch: Define ARCH_HAS_PHYS_INITRD for ARM and Unicore32
  of/fdt: Populate phys_initrd_start/phys_initrd_size from FDT
  arm64: Utilize ARCH_HAS_PHYS_INITRD
  of/fdt: Remove definition check for __early_init_dt_declare_initrd()

 arch/Kconfig                    |  7 +++++++
 arch/arm/Kconfig                |  1 +
 arch/arm/mm/init.c              |  6 +++---
 arch/arm64/Kconfig              |  1 +
 arch/arm64/include/asm/memory.h |  8 --------
 arch/arm64/mm/init.c            | 23 +++++++++++------------
 arch/nds32/mm/init.c            |  2 --
 arch/unicore32/Kconfig          |  1 +
 arch/unicore32/mm/init.c        |  4 ++--
 drivers/of/fdt.c                |  6 ++++--
 include/linux/initrd.h          |  3 +++
 11 files changed, 33 insertions(+), 29 deletions(-)

-- 
2.17.1


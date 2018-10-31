Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749DAECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DB12080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6iJXyY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DB12080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbeKAE2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:28:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45921 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbeKAE2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:28:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id o19-v6so7737643pll.12;
        Wed, 31 Oct 2018 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oyqW3Y3lTC+4Kk8BMrHn2Q/58ghVK0lWapIo4/K2Dvc=;
        b=k6iJXyY5N/Ll+k1Tsj1yl/aUQ0ftoy5g+eTi/AD8BEVeNfx1oBglYfSRxjkwAt0aIZ
         Gywfnr9SgyjlqyA7I6KgY7xhHKqOaONRbS9owG2Du6/9aDMP0Um2cgS99nvKj1PSXsVx
         1N21oOV86Q/39i7OMO0BekV8M6pDEC5y6fkz2IdzLalakcZ75ZFtx/f4w1HAdY1w9opv
         Wprzqk3I45zwpZ6ROLauB4EJ+EDyDxqxOdyy/ygzyR+HteHrv98v1OOKEZlLC+orFVNb
         Am5DOlUThZKFPlBNjQLEC9XhSqgPWYb0u1JahJ44CFN06CnIBLsLsFogOrG9+zIqySVi
         fNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oyqW3Y3lTC+4Kk8BMrHn2Q/58ghVK0lWapIo4/K2Dvc=;
        b=ImqTEzAqP9sy8U6zCy+E0Uerd1mVCkm4Tbnpz57f1MJKEySHwJvLykhwN2L2BUmTrh
         9ARZjHMFGxuiNywLWsfFQScTng4O6XN9Ulw27fCFBNPfRaOtjHayy9fuXq7u0lUqAxWB
         3Nd/KCwie9Cq/IQxbH9ApuMf9TmUtzdJCyhu8R7KWTmBhfShmXwMY74Z+BbnlicDeh68
         Y0pNAnIuJ8m3IXCPiMC1xerdw9Kjmjol8Zehkd0FO40JZ6iVsb8IeqQEfqx728kpshTg
         esy0AO091I3BFt/RNz4Rh8ax8iHXnvgVlPzGTkORIe0KjKZpSp/QL9ioQxaeAjZqekgh
         BSpg==
X-Gm-Message-State: AGRZ1gKFmveA8LygtRoah52uSPKmhrbjPc9q2FBiNmcE9/9B94MWvHOW
        Qjya4BWa+IZQ4VYzA3fnQoMFDGrw
X-Google-Smtp-Source: AJdET5eZ5/0tJNck4CjD4sJSzcMo10Zb+5a4ldWjia8ej7AdnC0/anvtpdgJWEFLZDakM3b3YpO4sQ==
X-Received: by 2002:a17:902:30f:: with SMTP id 15-v6mr4698184pld.155.1541014147331;
        Wed, 31 Oct 2018 12:29:07 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z26-v6sm28926456pfh.77.2018.10.31.12.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 12:29:05 -0700 (PDT)
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
Subject: [PATCH v3 0/6] arm64: Get rid of __early_init_dt_declare_initrd()
Date:   Wed, 31 Oct 2018 12:28:37 -0700
Message-Id: <20181031192843.13230-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Changes in v3:

- use C conditionals in drivers/of/fdt.c
- added check on phys_initrd_size in arch/arm64/mm/init.c to determine
  whether initrd_start must be populated
- fixed a build warning with ARC that was just missing an (unsigned
  long) cast

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

 arch/arc/mm/init.c              | 25 +++++--------------------
 arch/arm/mm/init.c              | 28 ++--------------------------
 arch/arm64/include/asm/memory.h |  8 --------
 arch/arm64/mm/init.c            | 33 +++++++--------------------------
 arch/nds32/mm/init.c            |  2 --
 arch/unicore32/mm/init.c        | 24 +++++-------------------
 drivers/of/fdt.c                | 17 ++++++++++++-----
 include/linux/initrd.h          |  3 +++
 init/do_mounts_initrd.c         | 20 ++++++++++++++++++++
 9 files changed, 54 insertions(+), 106 deletions(-)

-- 
2.17.1


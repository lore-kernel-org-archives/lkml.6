Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDD8ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA6020856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AARkt2oD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA6020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeJ0HTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 03:19:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42917 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJ0HTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 03:19:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id f26-v6so1204287pfn.9;
        Fri, 26 Oct 2018 15:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6NbFjkFyWM32p9EHP4XvhY+exv9Sw/mY2xKovCSkpc0=;
        b=AARkt2oDj2M7sM5gBxaDXPAKcPV2xZtcWe76WCORezXXIeeYe/b5iN4Harp3j9Remw
         hZnV70HL6advI4hOODWbPtgU+Qr9Q/4IPgkSE2PGJdGdnmG4dVQApLcLtvtKM6aqbvVG
         Ry81zM0lJZy24QDyq8vDqaJjK5FF3bn9w36DszQydLC5Y4u+Cl9gHwwaD9B5AprdBH68
         vAXF4R7OF0LwtrXXHcXMpe79Xv5yvTbmm1ZPIGDa7CEGhaJJBye1FlE8kE/7//xmq56w
         jvEIFovum6NtQC+h8xyLyImhXDXXH2sFqt+cwjFB24cV5wWBKhxH6d8HB2M/dmSIhzXq
         9Dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6NbFjkFyWM32p9EHP4XvhY+exv9Sw/mY2xKovCSkpc0=;
        b=b2C4YdOvD7ITfA9Fga+z6jYA4pdTYfmQBGDu+UVzyH2sAUkAgABS9ZNgnLD2xXcdtk
         Xx1TYco52XV+7JQPGf3CMA7j4PmkpS63N4+yLoj0Kk9BSk56lNgLqNJQN34Hmg1uS+Ud
         a5EMLGT4KiwQqwfboDCMEVSTy4HBwb3cwNrO4Qssos3GTbl617mnYpkF6I5P0EBIcIOo
         Avr/A6Z8ZW4wX2fZkudYe+vJgXCeHjS7wiDqBOi6jWWeUN9TY6CpYh/K+ddrmf/Dm+Nv
         JxBkrzrN11mJTfNaMXCh/0C6hwwSpoNRIxMPqlEyjAoKHd7HSTDMydocXmIFh/F73U6B
         w+Lw==
X-Gm-Message-State: AGRZ1gIV9RsUekeurBTWU6gJBKBqTRygb+zVVW2m4gSSG2m9a3S5Ciai
        1A0UEmtSX+gMKuO7BGEDFqi67xqS
X-Google-Smtp-Source: AJdET5dd+Q1sBDb+Jb51w3RA5ZQn6RJIl42B46FonHaVgzi8wo+39tb11wXdva747IFl4gdwE6UElw==
X-Received: by 2002:a63:6dc8:: with SMTP id i191mr5036556pgc.215.1540593615410;
        Fri, 26 Oct 2018 15:40:15 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id t9-v6sm3665536pgl.37.2018.10.26.15.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 15:40:14 -0700 (PDT)
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
        DEVICE TREE), rppt@linux.ibm.com, linux@armlinux.org.uk
Subject: [PATCH v4 0/2] arm64: Get rid of __early_init_dt_declare_initrd()
Date:   Fri, 26 Oct 2018 15:39:49 -0700
Message-Id: <20181026223951.30936-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I numbered this v4 because this is still revolving around the same
initial desire to cut the build time of an ARM64 kernel when toggling
CONFIG_BLK_DEV_INITRD. This 4th version is basically the 3rd possible
way to just get rid of __early_init_dt_declare_initrd() for ARM64.

I previously mentioned that I was working on making
phys_initrd_start/phys_initrd_size generic across architectures that
make use of it, which would cover ARM (32-bit), unicore32 and possibly
arm64, but upon second glance, this does not necessarily help, or rather
this patch series actually helps make a smoother conversion in the
future.

Comments welcome, sorry for making so many iterations, it's Friday.

Previous discussions/submissions list here:

v3:
https://www.spinics.net/lists/arm-kernel/msg683566.html
v2:
https://lkml.org/lkml/2018/10/25/4


Changes in v4:

- perform the physical to virtual initrd conversion straight within
  arm64_memblock_init() to get the correct memblock reservation to occur

Changes in v3:
- attempt to change drivers/of/fdt.c to absorb ARM64's specific behavior

Changes in v2:

- put an /* empty */ comment in the asm-generic/initrd.h file
- trim down the CC list to maximize the chances of people receiving this

Florian Fainelli (2):
  arm64: Get rid of __early_init_dt_declare_initrd()
  of/fdt: Remove definition check for __early_init_dt_declare_initrd()

 arch/arm64/include/asm/memory.h |  8 --------
 arch/arm64/mm/init.c            | 26 ++++++++++++++++----------
 drivers/of/fdt.c                |  2 --
 3 files changed, 16 insertions(+), 20 deletions(-)

-- 
2.17.1


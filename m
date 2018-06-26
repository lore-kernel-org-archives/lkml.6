Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECDAC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FD02679A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Q76EybhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FD02679A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934068AbeFZJZp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:25:45 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43220 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932965AbeFZJZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:25:42 -0400
Received: by mail-wr0-f194.google.com with SMTP id c5-v6so5311687wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=7829Wb5v71jjUsij2yEVhHfqVxJP8lx4GwoHTzFx+v4=;
        b=Q76EybhRGaxPRYIBFAcYb4pP/QNk9qT/b9WotyoHoYxnNvFggx7/5Cj34Mo03LSgkn
         tP6A4MieD6w+cCZg8eDMO1GQvo+frlN5TbR3sIXOgvggiecTDm7JsdE31jDb0f/iHNuw
         iB5EiGFhfjT7RNIT310p2cTFQaEbaWNyYf7WQ4yXRzKBRzzJLxQ0ugCoxv8i2XnmATnz
         hnHjuY8ML0d9MnptxVne884rKBJZ3l1M40/QUacfmCOnzS+ePr3OU5XoXamZZWO8Y33j
         t6ocnu9EShdT10ujphelSn1wUuvETuccrH068TMBp5820exXIPereRAwulmpCmoV6PqH
         Pdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7829Wb5v71jjUsij2yEVhHfqVxJP8lx4GwoHTzFx+v4=;
        b=DjP/XUvFcBR50VEjYpYs8XKatdhfLAvIzSD7+QEJIA1iMLzwcM9crqzn4RC0ensTSZ
         PKU0Qu4meuyvPd8mj/NfYzm3kVj0qxOtyt7bUDCx3tfqgb7FR2UTqZe/85QqFYVFDxio
         57uetYER5ERmMDIHt6kBbeoW15522pwrwkLwi5ZlEeBKCU88x4YOcOHGbARQgr3uczzo
         sH88wZNVko4Einid4NFsgre4dKd2D0ugyaLQDDdoqv38nfOwri/OBHgXw8p4joziFoWr
         Qh9Grx8vz69+pm+atndYy/WT9SvM3Aba4s/Ye4AH+3LmY+u/WWd5ImnT6BXxGQ3Guqg3
         Yb2g==
X-Gm-Message-State: APt69E34by4Mm4AdKqSgZ04nzDotz7J1sZyKV1w4E2zvmT11tAxSJI4x
        qxaaqxOfLgskni2eLbIPCbGktQ==
X-Google-Smtp-Source: AAOMgpdMXBo7XMf1IFJSssICFe0avtLDIDVSrrlv19hAl19m6gPZ5UwjQ/1TkYsIqmHdTM2u+3seiA==
X-Received: by 2002:adf:890a:: with SMTP id s10-v6mr773887wrs.122.1530005141412;
        Tue, 26 Jun 2018 02:25:41 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id a8-v6sm1528791wrn.50.2018.06.26.02.25.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 02:25:40 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 00/13] ARM: davinci: remove duplicate aemif support
Date:   Tue, 26 Jun 2018 11:25:24 +0200
Message-Id: <20180626092537.6737-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series moves all aemif/nand users to using the ti-aemif platform
driver located in drivers/memory instead of the older API located in
mach-davinci.

First five patches add necessary changes to the clock driver. Next
seven convert the board files to using the ti-aemif driver. Last patch
removes now dead code.

v1 -> v2:
- added missing clock lookups for ti-aemif where needed
- removed an unnecessary davinci_nand clock lookup from psc-da850
- moved the .id field initialization of aemif platform devices next to .name
- tweaked the commit message for the last patch

Bartosz Golaszewski (13):
  clk: davinci: psc-da850: remove the 'davinci_nand.0" lookup
  clk: davinci: psc-dm365: use two lookup entries for the aemif clock
  clk: davinci: psc-dm644x: use two lookup entries for the aemif clock
  clk: davinci: psc-dm646x: use two lookup entries for the aemif clock
  clk: davinci: psc-da830: add a lookup entry for aemif clock
  ARM: davinci: omapl138-hawk: add aemif & nand support
  ARM: davinci: da850-evm: use aemif platform driver in legacy mode
  ARM: davinci: dm365-evm: use the ti-aemif soc driver
  ARM: davinci: dm644x-evm: use aemif platform driver
  ARM: davinci: da830-evm: use aemif platform driver
  ARM: davinci: dm646x-evm: use aemif platform driver
  ARM: davinci: mityomapl138: use aemif platform driver
  ARM: davinci: unduplicate aemif support

 arch/arm/mach-davinci/Makefile                |   2 +-
 arch/arm/mach-davinci/aemif.c                 | 218 ------------------
 arch/arm/mach-davinci/board-da830-evm.c       |  56 ++++-
 arch/arm/mach-davinci/board-da850-evm.c       |  93 ++++----
 arch/arm/mach-davinci/board-dm365-evm.c       |  59 +++--
 arch/arm/mach-davinci/board-dm644x-evm.c      |  55 +++--
 arch/arm/mach-davinci/board-dm646x-evm.c      |  52 ++++-
 arch/arm/mach-davinci/board-mityomapl138.c    |  55 +++--
 arch/arm/mach-davinci/board-omapl138-hawk.c   | 132 +++++++++++
 drivers/clk/davinci/psc-da830.c               |   3 +-
 drivers/clk/davinci/psc-da850.c               |   3 +-
 drivers/clk/davinci/psc-dm365.c               |   3 +-
 drivers/clk/davinci/psc-dm644x.c              |   3 +-
 drivers/clk/davinci/psc-dm646x.c              |   3 +-
 .../linux/platform_data/mtd-davinci-aemif.h   |   1 -
 15 files changed, 407 insertions(+), 331 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/aemif.c

-- 
2.17.1


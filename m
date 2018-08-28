Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614D3C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16400205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16400205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeH1TCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:02:21 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:38084 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbeH1TCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:02:21 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id UfAD1y00U3XaVaC06fADUD; Tue, 28 Aug 2018 17:10:13 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fufdF-0008WV-BT; Tue, 28 Aug 2018 17:10:13 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fufdF-0003fd-9A; Tue, 28 Aug 2018 17:10:13 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/2] arm: renesas: Remove the ARCH_SHMOBILE Kconfig symbol
Date:   Tue, 28 Aug 2018 17:10:09 +0200
Message-Id: <20180828151011.14065-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

Commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS") started
the conversion from ARCH_SHMOBILE to ARCH_RENESAS for Renesas ARM SoCs.
Now all dependencies have been merged, this patch series completes the
conversion by removing the ARCH_SHMOBILE Kconfig symbols on ARM and ARM64.

Changes compared to v1:
  - Drop updates of dependencies for drivers, all merged.

Thanks!

Geert Uytterhoeven (2):
  ARM: shmobile: Remove the ARCH_SHMOBILE Kconfig symbol
  arm64: renesas: Remove the ARCH_SHMOBILE Kconfig symbol

 arch/arm/mach-shmobile/Kconfig |  4 ----
 arch/arm64/Kconfig.platforms   | 44 ++++++++++++++++------------------
 2 files changed, 20 insertions(+), 28 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

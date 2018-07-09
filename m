Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B6EC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E166920881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E166920881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932638AbeGIJcC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:32:02 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:50400 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932875AbeGIJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:30:44 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id 8ZWj1y00E3XaVaC01ZWj82; Mon, 09 Jul 2018 11:30:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fcSVG-0002dc-MV; Mon, 09 Jul 2018 11:30:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fcSVG-00069Q-JQ; Mon, 09 Jul 2018 11:30:42 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/5] m68k: IO Fixes and Cleanups
Date:   Mon,  9 Jul 2018 11:30:35 +0200
Message-Id: <20180709093040.23597-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series contains fixes and cleanups for I/O accessors on m68k
platforms (with MMU).

The first patch contains small fixes without any dependencies.
Patches 2 and 3 make small adjustments to drivers that are dependencies
for further cleanup.
Patch 4 and 5 complete the cleanup.

Changes compared to v1:
  - Move ARCH_HAS_IOREMAP_WT to fix "ioremap_wt redefined" warnings with
    m5475evb defconfig,
  - Add Acked-by.

Given the dependencies, I think it's easiest if the respective
maintainers would provide their Acked-by, so all patches can go in
through the m68k tree.

Thanks!

Geert Uytterhoeven (5):
  m68k/io: Add missing ioremap define guards, fix typo
  net: mac8390: Use standard memcpy_{from,to}io()
  Input: hilkbd - Add casts to HP9000/300 I/O accessors
  m68k/io: Move mem*io define guards to <asm/kmap.h>
  m68k/io: Switch mmu variant to <asm-generic/io.h>

 arch/m68k/include/asm/io.h          |  7 +++++
 arch/m68k/include/asm/io_mm.h       | 42 +++--------------------------
 arch/m68k/include/asm/io_no.h       | 12 ---------
 arch/m68k/include/asm/kmap.h        |  9 ++++++-
 drivers/input/keyboard/hilkbd.c     |  4 +--
 drivers/net/ethernet/8390/mac8390.c | 20 +++++++-------
 6 files changed, 30 insertions(+), 64 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

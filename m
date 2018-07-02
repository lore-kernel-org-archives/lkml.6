Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DB3C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3375251FE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3375251FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752925AbeGBNft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:35:49 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:39294 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752451AbeGBNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:35:35 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id 5pbZ1y00c3XaVaC06pbZKD; Mon, 02 Jul 2018 15:35:33 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fZyzN-0001Yw-9T; Mon, 02 Jul 2018 15:35:33 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fZyzN-0001QI-7R; Mon, 02 Jul 2018 15:35:33 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        "David S . Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/5] m68k: IO Fixes and Cleanups
Date:   Mon,  2 Jul 2018 15:35:27 +0200
Message-Id: <20180702133532.5412-1-geert@linux-m68k.org>
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

Given the dependencies, I think it's easiest if the respective
maintainers would provide their Acked-by, so all patches can go in
through the m68k tree.

Thanks for your comments!

Geert Uytterhoeven (5):
  m68k/io: Add missing ioremap define guards, fix typo
  net: mac8390: Use standard memcpy_{from,to}io()
  Input: hilkbd - Add casts to HP9000/300 I/O accessors
  m68k/io: Move mem*io define guards to <asm/kmap.h>
  m68k/io: Switch mmu variant to <asm-generic/io.h>

 arch/m68k/include/asm/io.h          |  7 +++++
 arch/m68k/include/asm/io_mm.h       | 40 +++--------------------------
 arch/m68k/include/asm/io_no.h       | 12 ---------
 arch/m68k/include/asm/kmap.h        |  7 ++++-
 drivers/input/keyboard/hilkbd.c     |  4 +--
 drivers/net/ethernet/8390/mac8390.c | 20 +++++++--------
 6 files changed, 28 insertions(+), 62 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

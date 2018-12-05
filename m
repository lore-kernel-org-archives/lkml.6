Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4913EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166F9206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166F9206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeLEPjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:39:52 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:46376 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbeLEPju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:39:50 -0500
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id 8Ffo1z00J3XaVaC01Ffots; Wed, 05 Dec 2018 16:39:49 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gUZHA-0001yR-5j; Wed, 05 Dec 2018 16:39:48 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gUZHA-0003aq-3f; Wed, 05 Dec 2018 16:39:48 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/4] soc: renesas: rcar-sysc: Miscellaneous fixes and cleanups
Date:   Wed,  5 Dec 2018 16:39:41 +0100
Message-Id: <20181205153945.13767-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Simon, Magnus,

This series (against renesas-devel-20181204-v4.20-rc5) contains
miscellaneous fixes and cleanups for the R-Car SYSC driver.

This has been tested on R-Car Gen2 (H2 and M2-W) and R-Car Gen3 (H3
ES1.0, H3 ES2.0, M3-W, M3-N, D3, E3, and V3M) (without 3DG).

This not been tested on R-Car H1 and R-Car V3H.

Thanks!

Geert Uytterhoeven (4):
  soc: renesas: r8a77990-sysc: Fix initialization order of 3DG-{A,B}
  soc: renesas: rcar-sysc: Remove rcar_sysc_power_{down,up}() helpers
  soc: renesas: rcar-sysc: Merge PM Domain registration and linking
  soc: renesas: rcar-sysc: Fix power domain control after system resume

 drivers/soc/renesas/r8a77990-sysc.c | 23 ++--------
 drivers/soc/renesas/rcar-sysc.c     | 65 ++++++++---------------------
 2 files changed, 22 insertions(+), 66 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

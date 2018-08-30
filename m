Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57773C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B1620645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B1620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbeH3Q4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:56:07 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:48176 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbeH3Q4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:56:07 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id VQu51y00o3XaVaC06Qu5c6; Thu, 30 Aug 2018 14:54:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fvMSb-0007YK-K5; Thu, 30 Aug 2018 14:54:05 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fvMSb-0005Wa-Is; Thu, 30 Aug 2018 14:54:05 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] serial: sh-sci: Fix earlycon on Renesas ARM platforms
Date:   Thu, 30 Aug 2018 14:54:02 +0200
Message-Id: <20180830125404.21192-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Greg,

Due to an unfortunate oversight, commit 2d4dd0da45401c7a ("serial: sh-sci:
Allow for compressed SCIF address") broke earlycon on all Renesas ARM
platforms using a SCIF port for the serial console (R-Car, RZ/A1, RZ/G1,
RZ/G2 SoCs), due to an incorrect value of port->regshift.

This patch series fixes that by reverting that commit, and a (reverse)
dependency.

Earlycon for RZ/A2 (which is a new platform) will be fixed later in a
separate patch.

Thanks for applying!

Geert Uytterhoeven (2):
  Revert "serial: sh-sci: Remove SCIx_RZ_SCIFA_REGTYPE"
  Revert "serial: sh-sci: Allow for compressed SCIF address"

 drivers/tty/serial/sh-sci.c | 56 +++++++++++++++++++++++++++----------
 include/linux/serial_sci.h  |  1 +
 2 files changed, 42 insertions(+), 15 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

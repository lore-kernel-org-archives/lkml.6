Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B31CC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD182054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfAROiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:38:50 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:54112 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfAROiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:38:50 -0500
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id Rqen1z00F3XaVaC01qentf; Fri, 18 Jan 2019 15:38:47 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gkVIF-0007kw-6y; Fri, 18 Jan 2019 15:38:47 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gkUlz-0007bY-2x; Fri, 18 Jan 2019 15:05:27 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nguyen An Hoan <na-hoan@jinso.co.jp>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/2] eeprom: at25: SPI transfer improvements
Date:   Fri, 18 Jan 2019 15:05:23 +0100
Message-Id: <20190118140525.29189-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series contains two improvements for the AT25 SPI EEPROM
driver, related to SPI transfers.

Changes compared to v1:
  - Merge "off" and "offset" into a single variable instead of just
    killing the cast, as suggested by Arnd,
  - Add Acked-by,
  - Dropped "[PATCH 3/3] eeprom: at25: Split writes in two SPI transfers
    to optimize DMA", as this is better implemented in the SPI
    controller driver (cfr. e.g. "[v2 PATCH 2/2] spi: sh-msiof: Use DMA
    if possible",
    https://lore.kernel.org/linux-renesas-soc/1547803771-9564-2-git-send-email-na-hoan@jinso.co.jp/)

Tested on a Renesas Ebisu development board with R-Car E3 using MSIOF
and a 25LC040 EEPROM.

Thanks!

Geert Uytterhoeven (2):
  eeprom: at25: Merge "off" and "offset" in at25_ee_write()
  eeprom: at25: Use spi_message_init_with_transfers() instead of open
    coding

 drivers/misc/eeprom/at25.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

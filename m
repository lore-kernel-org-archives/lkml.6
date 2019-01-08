Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED87C43613
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576AA2089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfAHERk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 23:17:40 -0500
Received: from twhmllg3.macronix.com ([122.147.135.201]:48731 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHERj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 23:17:39 -0500
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id x084H3Eo091858;
        Tue, 8 Jan 2019 12:17:03 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        boris.brezillon@bootlin.com, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw, Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v5 0/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI driver
Date:   Tue,  8 Jan 2019 12:16:58 +0800
Message-Id: <1546921020-20436-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG3.macronix.com x084H3Eo091858
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

This Renesas R-Car Gen3 RPC-IF SPI driver is based on Boris's new
spi-mem direct mapping read/write mode [1][2].

v5 patch is accroding to Sergei's comments:
1) Read 6 bytes ID from Sergei's patch.
2) regmap_update_bits()
3) C++ style comment

v4 patch is according to Sergei's comments including:
1) Drop soc_device_match()
2) Drop unused RPC registers
3) Use ilog2() instead of fls()
4) Patch read 6 bytes ID w/ one command.
5) Coding style and so on.

v3 patch is according to Marek and Geert's comments including:
1) soc_device_mach() to set up RPC_PHYCNT_STRTIM.
2) get_unaligned()
3) rpc-mode for rpi-spi-flash or rpc-hyperflash.
4) coding style and so on.

v2 patch including:
1) remove RPC clock enable/dis-able control,
2) patch run time PM, 
3) add RPC module software reset, 
4) add regmap,
5) other coding style and so on.

thanks for your review.

best regards,
Mason

[1] https://patchwork.kernel.org/patch/10670753
[2] https://patchwork.kernel.org/patch/10670747


Mason Yang (2):
  spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
  dt-bindings: spi: Document Renesas R-Car RPC-IF controller bindings

 .../devicetree/bindings/spi/spi-renesas-rpc.txt    |  37 +
 drivers/spi/Kconfig                                |   6 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-renesas-rpc.c                      | 787 +++++++++++++++++++++
 4 files changed, 831 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
 create mode 100644 drivers/spi/spi-renesas-rpc.c

-- 
1.9.1


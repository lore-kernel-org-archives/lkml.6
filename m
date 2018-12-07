Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AF0C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F052720868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F052720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mxic.com.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeLGLNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:13:54 -0500
Received: from twhmllg4.macronix.com ([211.75.127.132]:27252 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeLGLNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:13:53 -0500
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id wB7BDKkj078297;
        Fri, 7 Dec 2018 19:13:20 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        boris.brezillon@bootlin.com, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw, Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v3 0/2] spi: Add Renesas R-Car Gen3 RPC SPI driver
Date:   Fri,  7 Dec 2018 19:13:17 +0800
Message-Id: <1544181199-3373-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG4.macronix.com wB7BDKkj078297
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

This Renesas R-Car Gen3 RPC SPI driver is based on Boris's new
spi-mem direct mapping read/write mode [1][2].

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
  spi: Add Renesas R-Car Gen3 RPC SPI controller driver
  dt-binding: spi: Document Renesas R-Car Gen3 RPC controller bindings

 .../devicetree/bindings/spi/spi-renesas-rpc.txt    |  38 +
 drivers/spi/Kconfig                                |   6 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-renesas-rpc.c                      | 776 +++++++++++++++++++++
 4 files changed, 821 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
 create mode 100644 drivers/spi/spi-renesas-rpc.c

-- 
1.9.1


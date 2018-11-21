Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3B8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABC42147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=upb.ro header.i=@upb.ro header.b="e+sBAAku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABC42147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=upb.ro
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbeKUWNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:13:20 -0500
Received: from mail-sender200.upb.ro ([141.85.13.200]:38924 "EHLO mx.upb.ro"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729259AbeKUWNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:13:20 -0500
Received: from mx.upb.ro (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTPS id 9EC39B560074;
        Wed, 21 Nov 2018 13:28:53 +0200 (EET)
Received: from localhost (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTP id 813ECB56006E;
        Wed, 21 Nov 2018 13:28:53 +0200 (EET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.upb.ro 813ECB56006E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=upb.ro;
        s=96342B8A-77E4-11E5-BA93-D93D0963A2DF; t=1542799733;
        bh=HLlA+Riagk5howXjCVz0hHv2LwkhoNtzyJSegrw99/c=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=e+sBAAku//vG/+1DTZlYDHPfiAZty+gAZ4u9dh81eHXByvZx0M0yxuAQ50D+kKdN0
         hKeH0kRRiZ+LA72TbztOmTSppHY42q2hbuOwZaL+eiSQHURADE8hwfdWi0oBoMgWFr
         DyZ7KNE35odDZousdDCNlf7OzsZPtVZsT52a709c=
Received: from mx.upb.ro ([127.0.0.1])
        by localhost (mx.upb.ro [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Vb-unI9kuRkR; Wed, 21 Nov 2018 13:28:53 +0200 (EET)
Received: from asus-rog.localdomain (arh.pub.ro [141.85.160.17])
        by mx.upb.ro (Postfix) with ESMTPSA id 4F534B560065;
        Wed, 21 Nov 2018 13:28:53 +0200 (EET)
From:   Radu Pirea <radu_nicolae.pirea@upb.ro>
To:     richard.genoud@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.co,
        broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Radu Pirea <radu_nicolae.pirea@upb.ro>
Subject: [PATCH 0/3] Add PM and DMA support for AT91 USART as SPI
Date:   Wed, 21 Nov 2018 13:27:29 +0200
Message-Id: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series improves the SPI driver for AT91 USART IP and
adds support for DMA transfers, updates the bindings of driver
and PM callback functions.

I decided to use DMA only for transfers long than 16 bytes. DMA
setup introduces a little overhead and is better to use PIO for
short transfers.

Radu Pirea (3):
  spi: at91-usart: add power management support
  dt-bindings: mfd: atmel-usart: add DMA bindings for SPI mode
  spi: at91-usart: add DMA support

 .../devicetree/bindings/mfd/atmel-usart.txt   |  15 +-
 drivers/spi/spi-at91-usart.c                  | 284 +++++++++++++++++-
 2 files changed, 292 insertions(+), 7 deletions(-)

--=20
2.19.1


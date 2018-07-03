Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD57C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4EB2084D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4EB2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932983AbeGCO5L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:57:11 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:39664 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932409AbeGCO5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:57:10 -0400
X-IronPort-AV: E=Sophos;i="5.51,303,1526367600"; 
   d="scan'208";a="16634813"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Jul 2018 07:56:42 -0700
Received: from rob-ult-m19940.microchip.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Tue, 3 Jul 2018 07:56:41 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <alexandre.belloni@bootlin.com>,
        <nicolas.ferre@microchip.com>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <quentin.schulz@bootlin.com>
CC:     <Cristian.Birsan@microchip.com>
Subject: [PATCH 0/2] ASoC: atmel-i2s: Remove unnecessary audio PLL clock
Date:   Tue, 3 Jul 2018 17:56:29 +0300
Message-ID: <20180703145631.15246-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Quentin Schulz's patch:
commit 1a1a36d72e3d ("clk: at91: clk-generated: make gclk determine audio_pll rate")

the generated clock (gclk) itself is able to configure the audio PLL clock
(aclk). For this reason, the I2S driver no longer needs to set aclk,
but only gclk.
This patchet removes all references to the audio PLL clock from the
driver and updates the driver's bindings.

Codrin Ciubotariu (2):
  ASoC: atmel-i2s: Remove unnecessary audio PLL clock (aclk)
  ASoC: atmel-i2s: dt-bindings: Remove unnecessary phandle to aclk

 .../devicetree/bindings/sound/atmel-i2s.txt   | 11 ++---
 sound/soc/atmel/atmel-i2s.c                   | 46 +++----------------
 2 files changed, 12 insertions(+), 45 deletions(-)

-- 
2.17.1


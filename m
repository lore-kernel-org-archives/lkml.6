Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE00C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F7D2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F7D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeHaVXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:23:07 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:23111 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbeHaVXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:23:07 -0400
X-IronPort-AV: E=Sophos;i="5.53,312,1531810800"; 
   d="scan'208";a="19891695"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Aug 2018 10:14:39 -0700
Received: from rob-ult-m19940.mchp-main.com (10.10.76.4) by
 chn-sv-exch07.mchp-main.com (10.10.76.108) with Microsoft SMTP Server id
 14.3.352.0; Fri, 31 Aug 2018 10:14:39 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <florian.meier@koalo.de>,
        <cristian.birsan@microchip.com>
Subject: [PATCH v2 0/2] Add support for MikroElektronika PROTO codec
Date:   Fri, 31 Aug 2018 20:14:34 +0300
Message-ID: <20180831171436.13360-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is based on Florian's initial PROTO driver:
https://lkml.org/lkml/2013/5/22/342

My changes made the driver more generic, so that we could connect other
I2S CPU DAIs, by using device-tree.

Tested with sama5d2 I2S driver.

Changes in v2:
 - removed unnecessary code that added constraints for the fixed SYSLK;
 - fixed errors reported by kbuild;	
 - adjusted "mikroe" in vendor prefixes;
 - updated description in Kconfig;

Codrin Ciubotariu (2):
  ASoC: Add driver for PROTO Audio CODEC (with a WM8731)
  ASoC: mikroe-proto: dt-bindings: add DT bindings for PROTO board

 .../bindings/sound/mikroe,mikroe-proto.txt    |  23 +++
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 sound/soc/atmel/Kconfig                       |  11 ++
 sound/soc/atmel/Makefile                      |   2 +
 sound/soc/atmel/mikroe-proto.c                | 165 ++++++++++++++++++
 5 files changed, 202 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt
 create mode 100644 sound/soc/atmel/mikroe-proto.c

-- 
2.17.1


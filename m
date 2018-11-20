Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60910C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 06:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11F020870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 06:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11F020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732750AbeKTRUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:20:55 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:47668 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732290AbeKTRUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:20:54 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 7A47C5FAB6; Tue, 20 Nov 2018 14:53:16 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 0/3] arm64: dts: allwinner: h6: orangepi: Enable USB 2.0 and LEDs
Date:   Tue, 20 Nov 2018 14:53:08 +0800
Message-Id: <20181120065311.30009-1-wens@csie.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This small series enables USB 2.0 and LEDs on the Orange Pi Lite 2 and
Orange Pi One Plus. The two features are unrelated, but included in the
same series as the patch contexts overlap.

Patch one adds a fixed regulator to represent the board-wide 5V rail.
While not strictly necessary, this helps define the relationship between
regulators.

Patch two enables USB 2.0 host and OTG. Note that VBUS on both ports are
directly tied to the 5V rail, without any power switches or current
limiters.

Patch three add device nodes for the two LEDs. These LEDs are driven
directly by the GPIO pins, without a current limiting resistor. At the
default drive strength, the LEDs are quite bright.

Please have a look.
ChenYu

Chen-Yu Tsai (3):
  arm64: dts: allwinner: h6: orangepi: Add board-wide 5V regulator
  arm64: dts: allwinner: h6: orangepi: Enable USB 2.0 host and OTG ports
  arm64: dts: allwinner: h6: orangepi: Add device nodes for LEDs

 .../dts/allwinner/sun50i-h6-orangepi.dtsi     | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

-- 
2.19.1


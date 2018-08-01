Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D871CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAB4208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAB4208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390419AbeHATki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:40:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50082 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405989AbeHATIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:40 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 482FB115E;
        Wed,  1 Aug 2018 17:05:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 237/336] dt-bindings: pinctrl: meson: add support for the Meson8m2 SoC
Date:   Wed,  1 Aug 2018 18:49:32 +0200
Message-Id: <20180801165038.128659786@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 03d9fbc39730b3e6b2e7047dc85f0f70de8fb97d ]

The Meson8m2 SoC is a variant of Meson8 with some updates from Meson8b
(such as the Gigabit capable DesignWare MAC).
It is mostly pin compatible with Meson8, only 10 (existing) CBUS pins
get an additional function (four of these are Ethernet RXD2, RXD3, TXD2
and TXD3 which are required when the board uses an RGMII PHY).
The AOBUS pins seem to be identical on Meson8 and Meson8m2.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt |    2 ++
 1 file changed, 2 insertions(+)

--- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
@@ -3,8 +3,10 @@
 Required properties for the root node:
  - compatible: one of "amlogic,meson8-cbus-pinctrl"
 		      "amlogic,meson8b-cbus-pinctrl"
+		      "amlogic,meson8m2-cbus-pinctrl"
 		      "amlogic,meson8-aobus-pinctrl"
 		      "amlogic,meson8b-aobus-pinctrl"
+		      "amlogic,meson8m2-aobus-pinctrl"
 		      "amlogic,meson-gxbb-periphs-pinctrl"
 		      "amlogic,meson-gxbb-aobus-pinctrl"
 		      "amlogic,meson-gxl-periphs-pinctrl"



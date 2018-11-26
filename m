Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16DDC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C71220865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="dr4tqszQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C71220865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeK0CXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:23:03 -0500
Received: from plaes.org ([188.166.43.21]:50126 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbeK0CWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:22:45 -0500
Received: from localhost (85.253.196.132.cable.starman.ee [85.253.196.132])
        by plaes.org (Postfix) with ESMTPSA id 8CE6741CD4;
        Mon, 26 Nov 2018 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1543246097; bh=GenIgYx59LmIuL/j+2Q6PrK12wKEQotxrKvCSV57Qq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dr4tqszQKjcjy9gyKMnHqFRJaImi/l5junS9rySEl1Xmj7bJuMasiCpYV+hWST6ar
         Ao6VSylMV/N1AZOiMKkVhYpG10M4PnNa466fmpQIU356U/GBKYS3/AQLxl4gpOVALN
         X4RLYzrCOmJYYBz/8lQph+CY6OlZ90hq6j4dP7DuTWKgXnxQcg4Kpqj5QdUlhl/IT1
         XvXpMP7t8VasIqBenSF8RhxXTANE2IatP9OF3abZ4Yxmqfc6B8pVC3UAxbApYREHYO
         HcTMFMQKc344i+QzSmBtcgxB4reXq8/XNqZEkPsgkt5WyKIVAQfExiWfHzCcvS9x67
         9gVmIklneQhaQ==
From:   Priit Laes <plaes@plaes.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     Priit Laes <plaes@plaes.org>, Olliver Schinagl <oliver@schinagl.nl>
Subject: [PATCH 13/14] power: supply: axp20x: add missing include bitops.h
Date:   Mon, 26 Nov 2018 17:27:54 +0200
Message-Id: <9547ef8e8e6fe9f933264119bd186bdd83974999.1543245984.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

The axp20x_usb_power driver uses BIT() operations but lacks the include
for it. Include the bitops.h header file.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/power/supply/axp20x_usb_power.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 42001df..f52fe77 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -10,6 +10,7 @@
  * option) any later version.
  */
 
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-- 
git-series 0.9.1

Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C76C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF45206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XrfO9sOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfAPR7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:59:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45643 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfAPR7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:59:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so7940777wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGHM2N2WtdqsIqm1wuBaVDYD4GGJqThFPI7IpSINGlI=;
        b=XrfO9sOP4jXmsMPFHS7rLSI+6aZpeYXOHQOv9L3ndVzRqSbsm0hxPavwGKMENkZPgf
         6t9n9adC4KJFHnTAWDeZ36Wdaxkz2wB4TDOqedsX3gxndXWWReM4z8Mzdfrvc7Ry+rus
         w5857yiT7rpwUWwQ50yKd0482KeoZ3uDTw+hxDpnv4LBDNFg+Khrn9Oa/8B0Iuzfdq1A
         Pi9ofF+Zjmv1sf/u3OHD+HW3DLZpajrWf4lws5X3f0hXj9RGY6BG7unpda4ZAGui6FlZ
         Y7sHs6ykksXhmT6JGR5Wo82JmNEzzP2SSH99FYTgNb0R0rKc3l0qUkA5QsSLXRDDKfp6
         QPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGHM2N2WtdqsIqm1wuBaVDYD4GGJqThFPI7IpSINGlI=;
        b=iL6Nq7S37H1GAfd+JjNlTAEhWBQWw6EI8VS8wI/oNAmlXPNE/wVUsBRSdqBwDwc06j
         V5S5g7R+bvU3zw4oy27J5sk7tJsv0W5EHvq3fsJsslXxzKfODmGSd4oBeFnu4YT8BpSa
         PUpUC+Ol8NIyPhtvuM95ZtoepSfetqVJJPEknoafzI7M90WJUz2LGkQI24xtpmzls7kz
         aSQi8xGhJ2ZPNjhrv3nqIwcfYn53d7v32i5DcILguGsjgzdQ7PBRXnR79gp6CgxND4k7
         YDGarSC0DvRED8XDmybxPfU03i1Y1nvgHe60wZTah8RSxPKkM0WdlcIWcaH2bwDpHSYG
         0Pxg==
X-Gm-Message-State: AJcUukdb4W4c8fW5NWYVab8/6e4Js/goZEUbIkDSeAl8+WpuKDOU/9JV
        a0iUcpsajMH2p0L6rx2W3A8GXA==
X-Google-Smtp-Source: ALg8bN55WY6SihpB6uxj+w141K80WQwdVgvXOa91M41k3U38zXCRRcwq425myaNWmHuDi47kpOjbtg==
X-Received: by 2002:adf:8228:: with SMTP id 37mr8367659wrb.160.1547661558331;
        Wed, 16 Jan 2019 09:59:18 -0800 (PST)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 3sm42867315wmw.46.2019.01.16.09.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 09:59:17 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH] arm64: dts: meson: s400: enable sdr104 on sdio
Date:   Wed, 16 Jan 2019 18:59:13 +0100
Message-Id: <20190116175913.5907-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bcm wifi/bt device on SDIO support SDR104 and it seems to work
well following the recent mmc driver update, so enable this
ultra high speed mode

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 2e1dcf1c26bf..0c98ca78c8b8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -464,7 +464,8 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	sd-uhs-sdr104;
+	max-frequency = <200000000>;
 	non-removable;
 	disable-wp;
 
-- 
2.20.1


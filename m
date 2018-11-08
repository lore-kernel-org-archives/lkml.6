Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F4CECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FC52081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mB3UV0Ts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FC52081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeKHX3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:29:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33230 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeKHX3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:29:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id u9-v6so11005098wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jmLKsj8MdV/bQegPzrUFYLlxjsgIqYnOv75dL5siDLw=;
        b=mB3UV0Tsm6oLqjrVTx5217FgZFpvk4ew+1cqZjqJzhyZGMiWtI6dPobpW7W+8tXl8j
         9EcgGt6Abb8iCn2RWF9S9H1rj/9U3DHMLBqieQnhu+shLVfCtFEzt/3KWLHAr7LVsVaE
         /MBi7lWmhbf5KE+3feyy2nl4EjwF4L1tpAnn5xW7DgxObTC/294IaPcD2axz/GKXb5dk
         QpBIw5cviPZhN2nsJ/eRDj7MXbO5M/8xNy95YLkBjt2OoGC9gTVPCkWJWdUy9F7YhTwZ
         rFmW0PB24rwmIbEAkH2+wo7Y14cD3/mtqXvjZCADyV863hUnV9EYxcsCPb0MJAoEvt3V
         CF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jmLKsj8MdV/bQegPzrUFYLlxjsgIqYnOv75dL5siDLw=;
        b=rz+1Pmh02VHTwcuPiJ3mkCbuhgtSzNHVTnfMNzR5P+KAjD4E1QJ148apBNeq4wwdXh
         5cGNUuvkf3SDIK7Z4FvHx437UmIKw5xKUxpENEzDJceoRyLN2TQo2PsQHusT8fcs1uIi
         QPGJ36t9skFWtjNiHOBwHd9v0QOTfNNB/vj91zzRCyM811OgYWfCQ2jcrgcF1I8c3eAh
         j2NgEokl8Y5mcutC7EtoXlL6z2zly0fTOnZ7I3yr80JvH42dzej5vhQD0hNLY4kaoLpR
         R4Bw2Ju/sPJJOBrDqokR8M1hX86vL8DhU+Iyq+ERirqW5UPVZz6r326fVA1mhWZ728zj
         4WvQ==
X-Gm-Message-State: AGRZ1gLe3RJrCqI7FdiBN6ZacQSGJuoSlBjNoLR+92iXHzakprTDCjP4
        OfDU/B0/xzS3/Dmg1iO3ZhSq4w==
X-Google-Smtp-Source: AJdET5fG2F9vW2BLLbxBe9ho4kr7vSWp85lKizQ0SfM1KaALQ9Vx1rn3dASEu1r5Ne9T8aKysI4kwA==
X-Received: by 2002:a5d:6a0e:: with SMTP id m14-v6mr4359472wru.76.1541685240652;
        Thu, 08 Nov 2018 05:54:00 -0800 (PST)
Received: from boomer.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p6sm2740329wrx.39.2018.11.08.05.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 05:54:00 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] arm64: dts: meson-axg: fix mailbox address
Date:   Thu,  8 Nov 2018 14:53:49 +0100
Message-Id: <20181108135352.8459-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108135352.8459-1-jbrunet@baylibre.com>
References: <20181108135352.8459-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MHU mailbox address is wrong. Fixing it enables the mailboxes on the A113.
These mailboxes are needed for SCPI

Fixes: 9d59b708500f ("arm64: dts: meson-axg: add initial A113D SoC DT support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 3cc0044d3468..ff8b3406aff6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1067,9 +1067,9 @@
 			};
 		};
 
-		mailbox: mailbox@ff63dc00 {
+		mailbox: mailbox@ff63c404 {
 			compatible = "amlogic,meson-gx-mhu", "amlogic,meson-gxbb-mhu";
-			reg = <0 0xff63dc00 0 0x400>;
+			reg = <0 0xff63c404 0 0x4c>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 210 IRQ_TYPE_EDGE_RISING>;
-- 
2.19.1


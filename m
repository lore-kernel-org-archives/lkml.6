Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ADFECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038DB2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tjader-com-br.20150623.gappssmtp.com header.i=@tjader-com-br.20150623.gappssmtp.com header.b="l6TM9DCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038DB2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tjader.xyz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbeIST53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:57:29 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38260 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731654AbeIST53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:57:29 -0400
Received: by mail-qk1-f193.google.com with SMTP id s129-v6so280370qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 07:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tjader-com-br.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DhPH8DjufzaTlwuDaD7y9zF4jcNzs/Iwo6L7dhfuGHo=;
        b=l6TM9DCbuO56ueZTos0GCMNEq4+oR/ZC924kUM6YZw4JpyhIk3vZB4dZXwTiS/Hyy+
         kJBp8FQNvkEc8wOLJjsmmtP9zJEni+LmwJ+m23Uelhzc3LHdx0ni5P0pnnTb8Yd1v7UI
         DDK0Q7EqeLtZsO5gno8VR21YeZ/zZbzVgy5G/8Xm344/V40XmDDw2/ySwiDgK9EtR60b
         dB4sAuomtwHdi9rXwyYViLn//GJ9rRdd1Q42JHHtQV7F2aehE/EbDlB70Of/qzZ2a6N+
         DdjYwe/4c7FgJEEwhQ4xo6Ki+H6qvonMM9eWTqVEKTcYTKLvKUyWAflvujpIhzXvitm4
         DcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=DhPH8DjufzaTlwuDaD7y9zF4jcNzs/Iwo6L7dhfuGHo=;
        b=D5ykPaZyVV3kNfKSduOKZytHDwbh4Tk1xt7kxLnYzN2lkhDijU85orTBV+4eS3S2x0
         95TjR+1mRf5EmvdyTnmdCOtRmjNN7WsYgRXe+BqB4MdlSl2G4610w0g9WFheowBxKvKJ
         7VcZxb1BY1kJpktNjzXDen3Yatxjl0wh71M2fZ5FbIiz2mScG/gi5Zbpf414h2yiYKx2
         y5IlAMBJRGlB9gam8aBtZGnPSWAOS6+ikRBT37cVa0j6p3ZCWjc61+o5MtfGUJHMhYOk
         ymkm27DMLJ0fir+5pOCmmJFqprUtM31xKaEj0fLLV7yolx1Vn54bEsC59Ak6wuBCe5a/
         C+HA==
X-Gm-Message-State: APzg51A9uY9VojReLd3XLd0vzBcc91xoAuX4rrUlVEpiwweFSurK3vIP
        7hxWm9WWn8/W2NcXkdMFd0BHkA/EPrDjVFAe
X-Google-Smtp-Source: ANB0VdaRNlTggt2ryl5QlPVZQC0paoJYgZl4dv/jZX4aHE6+DCmyApGHOA30KjOExm9Vi1D4dRl9rg==
X-Received: by 2002:a37:4ecb:: with SMTP id c194-v6mr23719006qkb.345.1537366760862;
        Wed, 19 Sep 2018 07:19:20 -0700 (PDT)
Received: from smellerbee.basingse.tjader.xyz ([2804:14d:5cd4:84dd:8fb:bdff:fe0b:4c1d])
        by smtp.gmail.com with ESMTPSA id 62-v6sm11108qkw.72.2018.09.19.07.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 07:19:20 -0700 (PDT)
From:   =?UTF-8?q?Rodrigo=20Exterck=C3=B6tter=20Tj=C3=A4der?= 
        <rodrigo@tjader.xyz>
Cc:     =?UTF-8?q?Rodrigo=20Exterck=C3=B6tter=20Tj=C3=A4der?= 
        <rodrigo@tjader.xyz>, Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: allwinner: Olimex A64-OLinuXino: enable eMMC.
Date:   Wed, 19 Sep 2018 11:18:13 -0300
Message-Id: <20180919141815.18737-1-rodrigo@tjader.xyz>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copied snippet from A64-TERES I.

Signed-off-by: Rodrigo Exterckötter Tjäder <rodrigo@tjader.xyz>
---
 .../arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 657f58def54c..5245de3a1f35 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -128,6 +128,17 @@
 	};
 };
 
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+	vmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_dcdc1>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	status = "okay";
+};
+
 &ohci0 {
 	status = "okay";
 };
-- 
2.18.0


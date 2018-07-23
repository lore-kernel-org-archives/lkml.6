Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BBCECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F5220854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+WcGGqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F5220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388338AbeGWRL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:11:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44411 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388133AbeGWRL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:11:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id f23-v6so1428357edr.11;
        Mon, 23 Jul 2018 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2BAmoG1IPDPsRReiUnBAS5ecR2jHhEqs3MQ4HUdtlH8=;
        b=D+WcGGqOTtzWnpES6iynTqG5+kksjX0tT+gfDEKXoHEI2cBtqJLhFXkrnfWZqfNBer
         JTmt2q2ZGbfFLMdIoMt9jKOEuqwmUaGqkdYZKCaTyKGmKkEAk/+vSZS93swXdkzqdfw4
         qEEqBHsetaL8aQfWzNoqreZzpCkDKzaGTRMYXaa7IHRfC7tu1H7emzpFhToMJBEoiyP8
         717fJ0tvdxgDWfwtNdar294YDjh6Xi/24m7p6HD0A7ru5MmoMju5YWc3ojYkhp//jO0t
         HkTAP0js32e0x9fyye15fFHH1Op4dS/j+NtMgn/yhNDv0vzBYCNGBXilgkMvk9kRpSx7
         PB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2BAmoG1IPDPsRReiUnBAS5ecR2jHhEqs3MQ4HUdtlH8=;
        b=k2DXWJF+t77RXKyFiJd5tz3yuKJOgjAk09xGuusfrAahqGJDXca5OxTk6ftFXcxnHY
         Uf2HJzeEOSD7okxZpLJD49cWClGH8wJbpP27d3Wkk6o26ApARREYZ4gBAqglK3iOULJU
         65C7NKy7eQMsoY8Cfi3tsY0BGxiAVt50esDt2YWtFYmKqZQ0XXeEt3GkxfMPlvHGCPVG
         AtxbpBqN2WXX1API7pbKf3kSwFcXJPvnT6RF8gdQ8sTPu/SaaNXpAJHOOGmU2vfFX0BF
         2BVjBLwf2Gk2cyB+4X9XQSlkYrCtzDrcsNcw6qp+g5QCcoKOpSCVJ6LJj/TMxmaq1w+D
         xC2Q==
X-Gm-Message-State: AOUpUlEpxkEPg9xaiezbVjqQm9VqnrihsfC8v64R9v8hYEKWsagxqj3v
        sO26SjYuYXow1y5UwLhS8rA=
X-Google-Smtp-Source: AAOMgpfd/6oUZ/50l4OTMlQwVyBNq8obcUVsh9Uu3RUBM7llbX7ktTmGwpAjnaq8uYyCWAUqu70gJg==
X-Received: by 2002:a50:944f:: with SMTP id q15-v6mr15066845eda.70.1532362202760;
        Mon, 23 Jul 2018 09:10:02 -0700 (PDT)
Received: from localhost.localdomain (ptr-1kfhjj5270yus88jsb0.18120a2.ip6.access.telenet.be. [2a02:1810:343d:ca00:8caa:e7d7:6033:7e0c])
        by smtp.gmail.com with ESMTPSA id h1-v6sm4401981edr.86.2018.07.23.09.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 09:10:01 -0700 (PDT)
From:   stevenvandenbrandenstift@gmail.com
To:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Steven Vanden Branden <stevenvandenbrandenstift@gmail.com>
Subject: [PATCH] sun4i: dts: add gpu node to sun4i-a10 platform
Date:   Mon, 23 Jul 2018 18:09:54 +0200
Message-Id: <20180723160954.14115-1-stevenvandenbrandenstift@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Vanden Branden <stevenvandenbrandenstift@gmail.com>

Add mali gpu node to sun4i a10 platforms.
Tested with offscreen rendering with lima mesa (freedesktop gitlab)

Signed-off-by: Steven Vanden Branden <stevenvandenbrandenstift@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 3a1c6b45c9a1..be22f18b1462 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -1001,6 +1001,27 @@
 			status = "disabled";
 		};
 
+		mali: gpu@1c40000 {
+			compatible = "allwinner,sun4i-a10-mali", "arm,mali-400";
+			reg = <0x01c40000 0x10000>;
+			interrupts = <69>,
+				     <70>,
+				     <71>,
+				     <72>,
+				     <73>;
+			interrupt-names = "gp",
+					  "gpmmu",
+					  "pp0",
+					  "ppmmu0",
+					  "pmu";
+			clocks = <&ccu CLK_AHB_GPU>, <&ccu CLK_GPU>;
+			clock-names = "bus", "core";
+			resets = <&ccu RST_GPU>;
+
+			assigned-clocks = <&ccu CLK_GPU>;
+			assigned-clock-rates = <384000000>;
+		};
+
 		fe0: display-frontend@1e00000 {
 			compatible = "allwinner,sun4i-a10-display-frontend";
 			reg = <0x01e00000 0x20000>;
-- 
2.17.1


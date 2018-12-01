Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB11C65BAE
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784432081D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="r7DoDvYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784432081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeLAVVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 16:21:18 -0500
Received: from mail1.kuutio.org ([92.222.216.83]:59380 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbeLAVVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 16:21:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 0D8F31F978;
        Sat,  1 Dec 2018 11:09:06 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1543658945; x=
        1546250946; bh=MzMBlHLkwiO/Fjwv4OAmFkPbUn6e8VQqxVxiqId1keM=; b=r
        7DoDvYKXp1GnJysyhAmB34LtkVCKF2PK66Fubxq/fmSxV+EIQwsX2qZoZvJ7TE6r
        hvYuOothTRbr2qXUFXEQYHtv0mMWoivuqJoXtZOqzAaa5dnDLBfPa+dbLmKEI+XN
        TGLD+AwTtS7VqY2DH/Z02OCpB41DuBzmmvfOCEQnEFzRpb18PNeit8f3nwv+cJyQ
        oqnwA/wTQA2j1ugGzXUL43NVZHSIvwfcfBAXoNlOpyUb9vWJ14pkMEd9OcojkhNq
        aDAQf840O5zEGjXkOEIEBIP1WeyBWEiw+UbO4QVzrKpRDDEleerjjbkuy9pxqzVh
        1d0WkpkjEeHyjTYltNW0g4dB0DgGKVMKcV1x6PPdmQDjl3vybaL++yOHDQg7HYdN
        mojHaupm+NsYrewiNWtRYVyZ47oFy7MXGcXZDyy5KNpmZqq2TcieIePax7A/aQYg
        yBibI1tT/LzJKc5GNBle3K59LscJZ1+qZ3kCi3R+j7Bw6cJiBfsmet1mD2QXznaa
        UbkI6A2VQY4a4Yx9S+4FC24n4zgxkb5k8fZWVuGM95otNcmd0B1tfYxL2AXhzOGn
        gG3zy1UkZrhSuZXr1aqAg9db35m3uv5IMvqMvrt2H+9/4jfWvaJzEkzxPN8urdcV
        R1CyMjjfrp4Q8rU3KaMJEVV2wmT5fjx32TPS5Krw04=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 6Uhxi4Dz5h0S; Sat,  1 Dec 2018 11:09:05 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 988B41F99C;
        Sat,  1 Dec 2018 11:09:04 +0100 (CET)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Akash Gajjar <Akash_Gajjar@mentor.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH 2/2] arm64: dts: rockchip: rockpro64 fix video output chain
Date:   Sat,  1 Dec 2018 12:08:17 +0200
Message-Id: <20181201100817.20688-3-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181201100817.20688-1-oskari@lemmela.net>
References: <20181201100817.20688-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockpro64 is not able boot if kernel is compiled with
CONFIG_DRM_ROCKCHIP=m

Enable Rockpro64 board HDMI output to fix issue.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
index 5bd4d69914bd..be78172abc09 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
@@ -205,6 +205,13 @@
 	status = "okay";
 };
 
+&hdmi {
+	ddc-i2c-bus = <&i2c3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_cec>;
+	status = "okay";
+};
+
 &i2c0 {
 	clock-frequency = <400000>;
 	i2c-scl-rising-time-ns = <168>;
-- 
2.17.1


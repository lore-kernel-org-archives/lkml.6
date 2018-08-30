Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65372C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F2E20839
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdVcOQBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F2E20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbeH3XFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:05:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37614 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbeH3XFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:05:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so9003549wrr.4;
        Thu, 30 Aug 2018 12:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Tdxgkt9CvsMDffYgLZwCBYAMe31gzmLe/ZAbH0KQ5c=;
        b=bdVcOQBhDKg1YU7EuaVN50ehxdx8lwubQ6N2NC1qOENkXiSnFjX6M95te/1JvU+DLc
         5a9zj1tpIOzhcGIo5rcHAANACJN2T/0abHljawknikpjNiZgqrWwDVVTvjszntiMm5BD
         nr8TFwV78fCiJ5XJYEKzG+ImdbIFI+lvLnad2pQb3LUcrxMiYkvB1lreOe3CENHZi6G9
         QqmxA1JB9od6d39rAQG/4G0ZJpRZy333jdIGKxYUOjvTU7oWQ3H9q1eiY34H7VlyWRge
         zZXsH+vXL5OPCSozU+fiM8uHaw5Mssn9TGjoA6q+dcu6eeqG9hvyg5gBhnXY9mCGMCoV
         LlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/Tdxgkt9CvsMDffYgLZwCBYAMe31gzmLe/ZAbH0KQ5c=;
        b=aIVvlM3vV1Fq+xtPqAPTysnLUb35HeL0O57cV7w3hHH5kpAduH/0uzG27CnMan4EHn
         Atft3DmR6B5v9I0rKyp9I29Clx58CqPaUqbqE6UbzXXs692L6xLFX1t2Bo4TmpCUI5Qu
         m+TemfgCa0AplTeoBmciuD8QF8P4PR7CmzxjLuDsoBGCmL25PnhM7VuczPMu9EkqMS2N
         87oqkNGtpJ1sqRT7tgkOY9e1J09g/7GSGOVE8nrGyjMq93HZ+uVzunj3JkdWG2ZYFN29
         HE6cHqIumPW12Diu5/Bh1D3s6cFsdyLVBMuDc9qgYfMRWb0P9elJLMB1/dMiETdNmTKd
         DY1A==
X-Gm-Message-State: APzg51A9JWgz2zbvOpCSzpBpmDpDbF+Qa2Lx+Uoi/TCaiql6q4w3t+Nl
        4tfPn06g2ydzh/o200fQGgE=
X-Google-Smtp-Source: ANB0VdY554aIbbCMKkMrXU/yoUgm3k/luqENql/oBTCw8GdNQKmtOgEY6Ei2iKI5hSiQBHo6DpxJ2Q==
X-Received: by 2002:adf:dcc1:: with SMTP id x1-v6mr8674417wrm.21.1535655706835;
        Thu, 30 Aug 2018 12:01:46 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id w17-v6sm2937095wmc.43.2018.08.30.12.01.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:01:46 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org, clabbe.montjoie@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v4 12/13] ARM: dts: sun4i: a10: add sata-port/sata-phy nodes
Date:   Thu, 30 Aug 2018 21:01:19 +0200
Message-Id: <20180830190120.722-13-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch convert sun4i-a10 sata to the new binding which use a sata
phy node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 3d62a8950720..52d5c2e79499 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -556,7 +556,20 @@
 			reg = <0x01c18000 0x1000>;
 			interrupts = <56>;
 			clocks = <&ccu CLK_AHB_SATA>, <&ccu CLK_SATA>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			status = "disabled";
+
+			sata_port: sata-port@0 {
+				reg = <0>;
+				phys = <&sata_phy>;
+			};
+		};
+
+		sata_phy: sata_phy@1c180c0 {
+			compatible = "allwinner,sun4i-a10-sata-phy";
+			reg = <0x01c180c0 0x200>;
+			#phy-cells = <0>;
 		};
 
 		ehci1: usb@1c1c000 {
-- 
2.16.4


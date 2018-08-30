Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC49BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950B020658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGIpwGhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950B020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeH3Tse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37953 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbeH3Tsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so2496953wmi.3;
        Thu, 30 Aug 2018 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FywbVIB0mybZGQlha7NFbll0y71vzt8iOO5Bixlf4OM=;
        b=TGIpwGhzBwkzCA2k0q5aqOzmNO+gwTDQe4W2eznKJAMCoTOXzszi8sLJRBl7S+ejXD
         uS/I6378Cpn3/kvXXhk7mbJiZy9gF8G/ni3z10hQ/cMvBJD8mnxxvLSYIEcePM8GjmNR
         WSTQcyCm+2ae7LYYQAu3wxn8SQ+8uLzzHoxC6oGnlCFn9SIMmheek819Ta+LhtfoeqIp
         HLrq21b75L2B90xqlKsZ43PR4UDzaIGLRHfisQjBKwH1CwksFiHjijVUhdazU9Ri665b
         ArbI+MXODDsgYB4Lzoez9/nB2I4+73LNMeW3yvEH5uFpHI+AuiBQLMr6Gkf4dl2bXg9v
         BfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FywbVIB0mybZGQlha7NFbll0y71vzt8iOO5Bixlf4OM=;
        b=aehmTq4Uk5IKUCqILUUMCtlKRl5ECBx3M6ipxhUz7dD38KUKMufNzEaETyaRynjbYt
         4GSgFYoesYUYOYY3yz+U2Z94O/em9KY4KiFMbsuWpRxRMs4JBhlw5mig3+OinmysaE6M
         d/3JMaRdLVSfvfNiSBcfT1aFsLEfD5ayGiluVC4YZse+jOFoDS2nIq/csHuUe0LDtcOa
         QDRJzqmyhFmHq/Zqvj1g9ichWH2ImkPOT+85O+GK3hFFRFirTPlkpoIMX9TowbX7Awmz
         dsRUua0EE64XNDRxCNAhmvkD6Xn3pOKcZJqO8Rb2fRw3xfMxRxwLNuCq4/y2lWYLy6CO
         1o/w==
X-Gm-Message-State: APzg51A7YoWeDOkoss8ZiAh9mtip6Rb2uKsqRjy5pqk3jyhNZfbBkbI7
        SX/8u/MhTnLYs1Dn1eKgt5M=
X-Google-Smtp-Source: ANB0Vdb49E8FXdr5hCrNgeojqWMHwts1H1t3PCXOFkIgWsf3OM1BOR5eP1POMRnYkyXEudrQryqrSA==
X-Received: by 2002:a1c:e70b:: with SMTP id e11-v6mr2127387wmh.22.1535643945694;
        Thu, 30 Aug 2018 08:45:45 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:45 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 24/30] ARM: dts: sun8i: h3: add support for the thermal sensor in H3
Date:   Thu, 30 Aug 2018 17:45:12 +0200
Message-Id: <20180830154518.29507-25-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the missing compatible and the thermal sensor cells.
The H3 has one sensor.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 41d57c76f290..5b7994cb1471 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -185,3 +185,8 @@
 &pio {
 	compatible = "allwinner,sun8i-h3-pinctrl";
 };
+
+&ths {
+	compatible = "allwinner,sun8i-h3-ths";
+	#thermal-sensor-cells = <0>;
+};
-- 
2.11.0


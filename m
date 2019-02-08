Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCE4C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D391921916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6Ub6F4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfBHAaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:30:16 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37075 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfBHAaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:30:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so822568pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 16:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c324b380hphqzikJSwYwP+iMI2K9W7f9e6HIiTYzB7k=;
        b=Y6Ub6F4ydFHhhs7fQk8IjFmLX17QPsmXIhljs3ttclwAAhAFQsFDD/d6UMXpXsJPCy
         dAh37W5bDhiIFaYTAz/2vjI3qRxono16pVaIsLmCuxZg0DKMmA6K7kPM717tq/pBgQo8
         V9hnUhl/7xR7tptVuJ1GkCnNJQVH1fAWzu1pwj6y3/DLV/uOu52wa9IqquGEMU/rmT+O
         DJBTEG7pGkvtbOxWsq7kCOHP7ZeXJ9c4d5GBela9ftO4TEyMsPeNSf2tcHhwVZVLTqch
         RLIbzu8VtWTGBBcPxOab6V/sQsfU5bfnAN47f4ANk7PIGTGHMXKBFiBnusj4FvuPlReJ
         goJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c324b380hphqzikJSwYwP+iMI2K9W7f9e6HIiTYzB7k=;
        b=gn1ToDIthbC4JBwRZkcmrVNt/hmO4QgWMx+iVGiRbhn9gJI1PD4QS/o6Y8/K/PX1Xq
         aDL4eP4IVUY5P3Td98I+7ed/GWkRKvqtDKP4KYAylgGnzX+Esa6IUJvQcR47C6b9uzri
         2O1UE8tXL4h1vEwAKd+mDzYL6sSrxQ4wrJ2/PkjBl4za8eGZMCqV15hIbk6H+wzGZK5t
         Q5YOxYLEk54/OvwlFus3Ct+oEsK4z7Ja1Ptl4F6Wyb7AX2qN+QoDuEcke1QaCVu9zyyP
         CNaJo9Y1xjOfS6bz7NhsISOrgTyakdu+OA8P6N030YEfL83BZ+KyjUkgQJAFgTH9QAUT
         6zQg==
X-Gm-Message-State: AHQUAua0jcCxeyzcqSjVplEytr9/ZHqfOlfVjO+Jt6ig94kdVutHBXD3
        WHWFtr6Lj/gE8CkrFXzoSWs=
X-Google-Smtp-Source: AHgI3Iatvplw1t39WpZ1FuDx8dLwVFh25jfkRAbg/cnaQUJj6AX/lmjxWW3/02r+d9pW3T/WZUgJyw==
X-Received: by 2002:a62:2f06:: with SMTP id v6mr19345960pfv.216.1549585800149;
        Thu, 07 Feb 2019 16:30:00 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id p81sm380835pfa.107.2019.02.07.16.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 16:29:59 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC v2 3/5] arm64: dts: imx8mq: Combine PCIE power domains
Date:   Thu,  7 Feb 2019 16:29:39 -0800
Message-Id: <20190208002941.30343-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208002941.30343-1-andrew.smirnov@gmail.com>
References: <20190208002941.30343-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to NXP's FAE feedback and a comment in ATF firmware, PCIE1
and PCIE2 power domains can't really be used independently. Due to
shared reset line both power domains have to be turned on at the same
time. Account for that quirk by combining PCIE power domains into a
single 'pgc_pcie' power domain.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 50436bd393ed..89babc531380 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -273,9 +273,28 @@
 						reg = <IMX8M_POWER_DOMAIN_MIPI>;
 					};
 
-					pgc_pcie1: power-domain@1 {
+					/*
+					 * As per comment in ATF source code:
+					 *
+					 * PCIE1 and PCIE2 share the
+					 * same reset signal, if we
+					 * power down PCIE2, PCIE1
+					 * will be held in reset too.
+					 *
+					 * So instead of creating two
+					 * separate power domains for
+					 * PCIE1 and PCIE2. We create
+					 * a link between 1 and 10 and
+					 * use what was supposed to be
+					 * domain 1 as a shared PCIE
+					 * power domain powering both
+					 * PCIE1 and PCIE2 at the same
+					 * time
+					 */
+					pgc_pcie: power-domain@1 {
 						#power-domain-cells = <0>;
 						reg = <IMX8M_POWER_DOMAIN_PCIE1>;
+						power-domains = <&pgc_pcie2>;
 					};
 
 					pgc_otg1: power-domain@2 {
-- 
2.20.1


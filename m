Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6B2C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C40B218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUiXTl9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfAaUnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:43:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38269 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbfAaUnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:43:53 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so2022949pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 12:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c324b380hphqzikJSwYwP+iMI2K9W7f9e6HIiTYzB7k=;
        b=kUiXTl9Fc9q5qeFVMdQ4Z5t96hNHcW1LFh5NIpabJlBerfIqlKR9bdumgncRN2EIkh
         2YScR1sK5NGNQeKv9MLoSZp0ShiSu0Qgwhqv4q7BrWLwqAuldqy4hA1YAW1A0zhiSNVs
         g88UxqdtMsEn4XQrKgmzS3FrbDZWoS0CG5i9XcHDE83/ksONpRDeef7sKbJwGX/yBqpf
         FCCbPc/fhOq5ukT1U6uz0oD8mCA71Nxb9GhRmeUVM8EIzQxZz1wtHUUaUYeSQbBTT94E
         rpaKdAJ5HmAboBKcv9Ep09evF4cJ8zKEfc7EW2oUMzbHaSitXqcEUSCwMjjGkWFXTxBM
         wLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c324b380hphqzikJSwYwP+iMI2K9W7f9e6HIiTYzB7k=;
        b=TbjguMqhuMY+hfd3vuusnvrTRBS85Q1hl2QzjlXCJOthqUHOadGF67bXm3RZh3PgEo
         xpWVNn/wlE+XZshnkIGMmK+haTUNRmoL9ZcCtlEJewOFYNLiGmcLQH5t6qc2FmsLoNix
         euih0G1SHbw/+4tQHs3SYR7QvY/0Hh81vIN2IA66QegTMs+NrAIqxdLSRdmHZy0ek8yD
         ebhKj1M4wAOVvyrQaNiVcmj7wcetjA/rglGbGJcuSN1n2/sPBhmSQ+rbULEbtv5tpnuB
         yAW0RXeYMSg+rST4bNNZfsPPlRehry+uFknxw72WxOiRhGqwqAW1tf4XaC6iIaQXzxmJ
         k4lw==
X-Gm-Message-State: AJcUukcjsgZYfRJeXLzozFBfckKv5SuGbC9TF7q950ObW4Ka95oJOw7G
        oCbB2f1cuTm1zWah1QdGHV8=
X-Google-Smtp-Source: ALg8bN7lpv54ik/rydarrkBjlKm7Qrf7F0z9Zh7hmp8qFEbGwXLfLOa6BxZlGAikLH/z4st3gol/gA==
X-Received: by 2002:a63:fd0a:: with SMTP id d10mr33170876pgh.164.1548967431950;
        Thu, 31 Jan 2019 12:43:51 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id s190sm7272034pfb.103.2019.01.31.12.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 12:43:51 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC 3/5] arm64: dts: imx8mq: Combine PCIE power domains
Date:   Thu, 31 Jan 2019 12:43:31 -0800
Message-Id: <20190131204333.31846-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131204333.31846-1-andrew.smirnov@gmail.com>
References: <20190131204333.31846-1-andrew.smirnov@gmail.com>
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


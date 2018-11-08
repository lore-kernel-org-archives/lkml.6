Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0FEC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F21E20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETTba6La"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F21E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbeKIHh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:37:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729667AbeKIHh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:58 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2427420892;
        Thu,  8 Nov 2018 22:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714429;
        bh=kMSzHfoSMaqVGoWzCs75wTJCIyV/y9Nasg7eTEBT56g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ETTba6LaNLNnhYESOSYvWvkb8CDnD4uQhb9uabySG4Qo1G2epSqFaGBSa0ItI3OHV
         KSbUPDegARUPIC587zvWFuQ0ZXDWQ2g8ILhfoUcSdQTc7lJHoK+IB4f6gKdU9SPCXj
         0maxo+kdss/kDWIxAkh/Wcf9ILVVDqOLkZSsBZfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 084/114] ARM: dts: imx53-qsb: disable 1.2GHz OPP
Date:   Thu,  8 Nov 2018 13:51:39 -0800
Message-Id: <20181108215108.517756162@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit eea96566c189c77e5272585984eb2729881a2f1d ]

The maximum CPU frequency for the i.MX53 QSB is 1GHz, so disable the
1.2GHz OPP. This makes the board work again with configs that have
cpufreq enabled like imx_v6_v7_defconfig on which the board stopped
working with the addition of cpufreq-dt support.

Fixes: 791f416608 ("ARM: dts: imx53: add cpufreq-dt support")

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx53-qsb-common.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index 53fd75c8ffcf..47894b41e4e2 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -130,6 +130,17 @@
 	};
 };
 
+&cpu0 {
+	/* CPU rated to 1GHz, not 1.2GHz as per the default settings */
+	operating-points = <
+		/* kHz   uV */
+		166666  850000
+		400000  900000
+		800000  1050000
+		1000000 1200000
+	>;
+};
+
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
-- 
2.17.1




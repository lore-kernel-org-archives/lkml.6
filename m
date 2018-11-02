Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0EAC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471562084C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kyt135U2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471562084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbeKCEB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeKCEB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:01:26 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEBDD2084A;
        Fri,  2 Nov 2018 18:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184791;
        bh=dqOH0T6gQpFbovWBV67QgfPeSo0Vwk5oea0fqobq7Mc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kyt135U24R1Aj6MaNsv/8gsTso1g608KqczEQ0aL/NRuTcTk2Ve9wxgS+ZOsrcyPS
         0k5bSPXlN/N3cRC30SoZWIMD1KXkzZskX+aY4WwjJ+cSAMqPJn/zNvXLxN1p57eBVz
         xLBvHsF3VxoeP77la9GuFMs8+ypdI6+KEx1fh7XQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 097/143] ARM: dts: imx53-qsb: disable 1.2GHz OPP
Date:   Fri,  2 Nov 2018 19:34:42 +0100
Message-Id: <20181102182905.627367704@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 683dcbe27cbd..8c11190c5218 100644
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




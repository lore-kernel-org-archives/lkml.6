Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1ADECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CBA20864
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Bn2sktn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CBA20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbeGRMS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:18:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35311 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731171AbeGRMSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:18:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so4355260wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+1g7TEFTx5CeOlyIGM6oGcX0vSNy4lE+qwE7d//N6Fc=;
        b=Bn2sktn2OrjsnAtx6q2gvySXDNnoVo8GUfkG5mr/y8lbH8ZMPhcUpCLSDfJ+49dGBu
         QWG7EhwcoWZ2cwnzdPJQjQ5bM1IUylsn/2O+/1whUuiYUBVPfMTpVopSw57h+cknzRk9
         U5qVSGxrknPPt77euA3wQlfkS1StnPCqqlV03BD8BA8ZYyFI5Dm2fAct7tD3j0zN1u16
         Mr3WCPW8CzJbJm3H7nkX+U3CGrPGQYq0+KXcQQTZpxyrgvz6kdDq35RqmpuLXqppdTPm
         9gxDxmBwkSx8cLSvSL0j9q2sf+BccE9oF4d5bfnOaUh7rOmdBv/Hn+da62nkHg1WsV+V
         bBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+1g7TEFTx5CeOlyIGM6oGcX0vSNy4lE+qwE7d//N6Fc=;
        b=fFYJtxjQvWbr5KMKaXzksjPJaJ9WwdJB/myGajuqTpdw1sp45hEVVSjcjVPVkYp3A5
         GvH/lr5BHoIGeldnUznNK5ywiFtH8jkxjJ/FaLOUckLIXaKzXeB9pzORDXwFNd5C/iLu
         /iRSIlj9D7QfOezNwzd63OQNlIvIA9vCdCFSJPePlG8d0li2FXEWVp+U8OBHYPkl+lf5
         fTeNwCvuM2vAaWPI8LEbdzeOIqY05ufEVTM2YlUOr8OgIXuqd2RksNAxmqI3rOZDM5gy
         G6QgqU66Grv5JZpxBp8v7Ys9vKrnPsSwoNlk1GHY00A5nlG5LL5I0/sNmjlqFCFNcsoN
         Va5A==
X-Gm-Message-State: AOUpUlGCp0jZYNvVYWBs3cQYz1WIGM7RgY3v0i0+23vZ+SXv0V02R3Mg
        J2OB2eNlg5lYDPwIP4rzCPvTBA==
X-Google-Smtp-Source: AAOMgpe+CGMQoah5POsjBN8yBeaz1JhF/QpFucifjTHXsbX5//1wUp84gwJnxE7A29of0veULXmpgQ==
X-Received: by 2002:adf:c109:: with SMTP id r9-v6mr4350319wre.233.1531914055026;
        Wed, 18 Jul 2018 04:40:55 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y102-v6sm3805129wmh.9.2018.07.18.04.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jul 2018 04:40:54 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     catalin.marinas@arm.com, linux@armlinux.org.uk,
        mark.rutland@arm.com, maxime.ripard@free-electrons.com,
        robh+dt@kernel.org, wens@csie.org, will.deacon@arm.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 4/5] ARM: dts: sun8i: r40: Remove unused address-cells/size-cells of dwmac-sun8i
Date:   Wed, 18 Jul 2018 11:40:40 +0000
Message-Id: <1531914041-14751-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531914041-14751-1-git-send-email-clabbe@baylibre.com>
References: <1531914041-14751-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

address-cells/size-cells is unnecessary for dwmac-sun8i node.
It was in early days, but since a mdio node is used, it could be
removed.

This patch fix the following DT warning:
Warning (avoid_unnecessary_addr_size): /soc/ethernet@1c50000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 38a3e0dbc824..1e680e4fee60 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -576,8 +576,6 @@
 			reset-names = "stmmaceth";
 			clocks = <&ccu CLK_BUS_GMAC>;
 			clock-names = "stmmaceth";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			status = "disabled";
 
 			gmac_mdio: mdio {
-- 
2.16.4


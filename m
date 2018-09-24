Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95D0ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E7720877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="KTuWbxhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E7720877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732444AbeIXXdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:33:35 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:60930 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbeIXXdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bFXA4sZTTQ/zX1uy8Iaas00YJu2olg9swkKZ1sUsD9w=; b=KTuWbxhFj3BPiwd5XR17s8n4mW
        CsEU+tRvRvk8aCeAEc0JpD80D06lExc1Ta88OxoFQ3IAQhRW22GuDsyOS6mY82KPc+oGvaSuI93BM
        XDYAixKTGwvG3xyvDGC3XW5isen3GNinkz4icZoxHnorfqu2+zmzEhaG0c0GqFN0sp6c=;
Received: from p200300ccfbcbd9001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbcb:d900:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g4UgX-00072M-On; Mon, 24 Sep 2018 19:30:13 +0200
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g4UgX-0005JD-Dh; Mon, 24 Sep 2018 19:30:13 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] ARM: dts: omap3-gta04: add pulldown/up settings for twl4030 gpio
Date:   Mon, 24 Sep 2018 19:29:57 +0200
Message-Id: <20180924172957.20366-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pullup and down settings were missing, so add them to avoid
floating pins and make headset detection working.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 09e45e7ad4bc..6bcb459c1b20 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -657,6 +657,19 @@
 	status = "disabled";
 };
 
+#define BIT(x) (1 << (x))
+&twl_gpio {
+	/* pullups: BIT(2) */
+	ti,pullups = <BIT(2)>;
+	/*
+	 * pulldowns:
+	 * BIT(0),  BIT(1), BIT(6), BIT(7), BIT(8), BIT(13)
+	 * BIT(15), BIT(16), BIT(17)
+	 */
+	ti,pulldowns = <(BIT(0) | BIT(1) | BIT(6) | BIT(7) | BIT(8) |
+			 BIT(13) | BIT(15) | BIT(16) | BIT(17))>;
+};
+
 &twl_keypad {
 	status = "disabled";
 };
-- 
2.11.0


Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B59C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A45D208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="rkYFM7kt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A45D208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbeGaIup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:50:45 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.122]:33107 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732094AbeGaIuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533021111;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=K3TY3pYhDYwQq/x4ZOA+SSGgaAaELM7uqPVewuIyzx0=;
        b=rkYFM7ktaPHacNo4Egm2Z84dIoQrBhjpEv2ZZQJ/8wwK5MnOuXFBGfSB98diOftyPW
        r4+3TAdVwZDOJZHFYTtb8pkQOot8my6PRAHS29G9yEHO1t8vASl7hK5CCV0mmDlL7WzX
        L+IL8F/heCsVZjFWnk3cOjoc6ZWSYrLCjtjVuvCeyN/2B/mLoS0ZpS2FrGapzehNdqpz
        r/xMcOjWfPItcO2ORtQGXIGAGkfkv8I+e71w+ZhxbqYRz+rns2OUhVK9ejU75TSweIRj
        FZjAicjuvnksSPdWDe1ks7fNMfQkTad5UWGpdh1RU41LKdmUCjrM5khbFrL+5R+tXzXe
        d7iw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1pxICp41QvXLM9PJBRQ"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6V7BjwOo
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 31 Jul 2018 09:11:45 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     ladis@linux-mips.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Marek Belisko <marek@goldelico.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 23/32] ARM: dts: omap3-gta04a4: fix model name for A4 variant
Date:   Tue, 31 Jul 2018 09:11:26 +0200
Message-Id: <26d4a75a6dcb46e187719802ec7436fa09b75fdf.1533021093.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GTA04 is the project name and Letux 2804 the product name.
Report both.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04a4.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04a4.dts b/arch/arm/boot/dts/omap3-gta04a4.dts
index c918bb1f0529..77afc711fe4f 100644
--- a/arch/arm/boot/dts/omap3-gta04a4.dts
+++ b/arch/arm/boot/dts/omap3-gta04a4.dts
@@ -9,5 +9,5 @@
 #include "omap3-gta04.dtsi"
 
 / {
-	model = "Goldelico GTA04A4";
+	model = "Goldelico GTA04A4/Letux 2804";
 };
-- 
2.12.2


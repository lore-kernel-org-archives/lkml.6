Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAFDECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9912086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="BZdg/Mwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9912086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbeGQPa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:30:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39556 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbeGQPa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:30:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so1579521wre.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=E0je9mzxPuzSOvNRR+YAGKhegeLbQYsK2K8iE5XCpCA=;
        b=BZdg/MwlOHlk7W2JEC9LSVj5NXPu/dnhiINxFQePooiyisl1+Y5mM2alMn7RgHk223
         0blpyxvAResZoGF2XFiaQqIp4zIU4DFAv1XBJOedcz9tsk5oSCLcuDWAfcyIxHOlzLuX
         Z1tTf+nLBefrW37DPqGMtdbMVWkCWXKG4EGzvysetMVyacjxEH3kLkRISJbGdDtEDZMw
         3blOxIbFhJt94+fsGeyLq44FYGlhWIFM72hm6l1t3qyBoUVpQdJ9AbUR/FHaDxA1yC+K
         locEkhiizCpgzjSNWALllOL9zAvD7b6Jncq2c0tn2KfLU2mvzwHBUKVW/37RCBSfMESz
         1FBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=E0je9mzxPuzSOvNRR+YAGKhegeLbQYsK2K8iE5XCpCA=;
        b=RBGNOBz3eZBL1lCVAHuUXXPYgkbqgR6xQQ/SKkpOxQLW4RFpBa71CCiAWUnTcXiQNz
         ez2Jx4pCaAgeI1ydiGjN88JsP8rkp8O7kFEBrzC95n6FHcalqXuIRWd8mrG597LXK/NA
         C/euapzoTEDrThG2dhS9BSqLZbcM6scnYg1Jpp1KTDT3xF4tg+AqvKacv19nuH+dI6kO
         idpTI+PGsI8DT8v0SFiUDjTgJ0vfwNK/lAPnNQtB4z07M3OKhFU3d/FwNuv+QjB0NYxU
         JRhRyLxiQA35VsEzGZMpgaA/NkZHHSmDd3g/63eJ/t91LikhoL21cFIbJNBe2DGY21Zi
         Jafw==
X-Gm-Message-State: AOUpUlEKUaj+61RQ2gfX9kPqkVcOy9uyEKshpQLQ9X9IqafBbV70qkYT
        OTJrn49J0U7Iqo6ak9TB3d+Y1A==
X-Google-Smtp-Source: AAOMgpdBUvF6Bk9+ndaA5ea60yDIr6yPuVqnHFQRY5JdPK6NMG2T53MMsk5tCuQQqGKqqGepJsZXyQ==
X-Received: by 2002:a5d:4e49:: with SMTP id r9-v6mr1578938wrt.27.1531839444905;
        Tue, 17 Jul 2018 07:57:24 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id e7-v6sm2619216wrm.14.2018.07.17.07.57.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 07:57:24 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     devicetree@vger.kernel.org
Cc:     monstr@monstr.eu, Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>,
        Albert Aribaud <albert.u.boot@aribaud.net>,
        Rob Herring <robherring2@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm: zynq: Remove #address/#size-cells from gpio-keys
Date:   Tue, 17 Jul 2018 16:57:23 +0200
Message-Id: <af809c1d98451a14b981f8d2cc123b2e1016021c.1531839440.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dts reports incorrect usage of these properties in gpio-keys node.
Warning (avoid_unnecessary_addr_size): /gpio-keys: unnecessary

The patch is removing these useless properties.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-zc702.dts | 2 --
 arch/arm/boot/dts/zynq-zturn.dts | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index 6653e34409cd..cc5a3dc2b4a0 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -29,8 +29,6 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 		sw14 {
 			label = "sw14";
diff --git a/arch/arm/boot/dts/zynq-zturn.dts b/arch/arm/boot/dts/zynq-zturn.dts
index b25beaed874d..b38704657960 100644
--- a/arch/arm/boot/dts/zynq-zturn.dts
+++ b/arch/arm/boot/dts/zynq-zturn.dts
@@ -49,8 +49,6 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 		K1 {
 			label = "K1";
-- 
1.9.1


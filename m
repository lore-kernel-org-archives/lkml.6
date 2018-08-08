Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42D5C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F3421570
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tyzBF9sO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F3421570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeHHL3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:29:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37722 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbeHHL3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:29:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so1347192wrr.4;
        Wed, 08 Aug 2018 02:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FpTBDzFj7FhGuM0sypfkgd2031tupe8CwWIxIYgtzEk=;
        b=tyzBF9sODIorZr1w3WTisMEPMqdhs55cLa+GCtS8q6WPSH+0jaHdBJeuYUPLE7DcuM
         tsu64K16HgRTziGkiVTvMCyKV2jk80mfQWnOaVzBZeQMUngk5yACzza33KPw3EpmAfS4
         Ef4SX/fkaRLMQnaVKwmRmeqVgpNb5q8erjGwPqHoIrsJt8nxHbcDrlBn+Tywk01zDiaJ
         CFlso9P8VrwpWstL/GND9sQr+A1M+UXR2fN4lUWvl1dX4WH6k4Duc/vRFXRe37Yd1u4s
         isRiyCMYmiDWreZQhR75VHS6/Tg/P+n6f6FaWn7FNHkl6LEBRdI611F5EDYwJXXs9Bla
         VJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FpTBDzFj7FhGuM0sypfkgd2031tupe8CwWIxIYgtzEk=;
        b=l0q3ghcWf5mMsnMSb4v79Lfd07cxnLvOAypV+9c2civ5I3LOLkEylvpU5h8G+JOxE8
         Zrr8P2JUB5kTiJmaiRx/jQ87nmKmUoc1RjhEXHhV+y1auozRYAHQtavXpmeuCwTS8Fg8
         WOWBIkqVo7srtv+OBwXCSNQ/AdftBz9yL+rEf+mdeaOW6jH0UdTXPrZD2yM0vUylEBl/
         rN/WluNUEDG4f9fSPQ0A2PF61zdljeVBPWMJZe1kKjSWo83rl7W1yz+wrSknW+Tma6FX
         VmAjUsS3Vnpo1CMunebatcdnkWOW3k374EoZBdLlxccE9t0gmghSnyZXXmYQcA/lHT96
         xoYg==
X-Gm-Message-State: AOUpUlF5HTeIYLNwpAZB+j2JWzBKLn3e2aRtCFjNCB9rs1Iv31R9hi60
        03Xc5pCmQGO/y5fTbCC8JPY=
X-Google-Smtp-Source: AA+uWPwNXMEsJj/mFbRdWvg2UCpgrZVoIF/XYTOLhOE7TN4YzN3m1W2FGWoWI5YTHfXZu2cdd1SexQ==
X-Received: by 2002:adf:8481:: with SMTP id 1-v6mr1393313wrg.34.1533719429684;
        Wed, 08 Aug 2018 02:10:29 -0700 (PDT)
Received: from ubuntu.home ([2a02:8071:6a3:700:542c:ff11:9c97:a518])
        by smtp.gmail.com with ESMTPSA id c129-v6sm6530687wmh.2.2018.08.08.02.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 02:10:28 -0700 (PDT)
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marex@denx.de>
Subject: [PATCH] ARM: dts: socfpga: use stdout-path for chosen node
Date:   Wed,  8 Aug 2018 11:09:44 +0200
Message-Id: <20180808090944.861-1-simon.k.r.goldschmidt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use stdout-path dts property for kernel console.

There were two socfpga boards left not using stdout-path:
socrates and vining. Make sure they match the other boards.

Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
---
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts    | 3 ++-
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
index 53bf99eef66d..6f5255a7d192 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
@@ -22,7 +22,8 @@
 	compatible = "ebv,socrates", "altr,socfpga-cyclone5", "altr,socfpga";
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
+		bootargs = "earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory@0 {
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
index f50b19447de6..e61efe16e79c 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
@@ -54,7 +54,8 @@
 	compatible = "samtec,vining", "altr,socfpga-cyclone5", "altr,socfpga";
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
+		bootargs = "earlyprintk";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory@0 {
-- 
2.17.1


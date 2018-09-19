Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED1AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A79206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A79206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387479AbeITDrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:47:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37383 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732852AbeITDrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:47:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id 2-v6so3385862pgo.4;
        Wed, 19 Sep 2018 15:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=vXWc+5eoojfL6cNWfW7qNkvjpwIvEsr12Iw0arMBWDc=;
        b=WeXqXRFQve1cUg9aUiDhZ+rqEJyhem2PZMpZWHfEP8WUroZTxf4DGSv2UJ70pWvTTA
         OgeWGbc/OMIA5e/bDKsn8tulLWxpwmbF3Rrdj2Y8M3IByg7VQWjwhDnLMOfApckvz2DJ
         UQ532fjsbbe2zHVg41FGrXHFMoj/tdPZjPCGWas2XdmKiusDpdpBpIAb4aiQZ+nO/gSI
         84p7ZP835TeTUp/LEE4IA/vuYNlH0l7OiLm4P4305T9LZZDKI5McL+Z5TUm22fDN0/tX
         O+k7sB6dOe76PyPyCeI11Dy2se4Ze+Noa9s7PnjudZSZVz9Zggc1ipwxYt0noGro6Hto
         WTuA==
X-Gm-Message-State: APzg51ATJyvRmXYaFHHVwUgbvieDti5XQlOM8jY909huv09nh9GoPPsm
        SB1t/yQHHdFO3WONUBMffqIyTnzv1w==
X-Google-Smtp-Source: ANB0Vdaw08VQneQCJMeQ+Mp0XSe9sFhxP9kl6ZSC5NHXvSiD+CsKjSnnVO0KsjtfDRkwxbRBa/vC2Q==
X-Received: by 2002:a62:938e:: with SMTP id r14-v6mr38706615pfk.55.1537394874737;
        Wed, 19 Sep 2018 15:07:54 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.googlemail.com with ESMTPSA id u15-v6sm167257pgn.56.2018.09.19.15.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 15:07:54 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] of/unittest: Fix I2C bus unit-address error
Date:   Wed, 19 Sep 2018 15:07:53 -0700
Message-Id: <20180919220753.27273-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtc has new checks for I2C buses. Fix the warnings in unit-addresses in
the unittests.

drivers/of/unittest-data/testcases.dtb: Warning (i2c_bus_reg): /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest14/i2c@0/test-mux-dev: I2C bus unit address format error, expected "20"
drivers/of/unittest-data/overlay_15.dtb: Warning (i2c_bus_reg): /fragment@0/__overlay__/test-unittest15/i2c@0/test-mux-dev: I2C bus unit address format error, expected "20"

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/unittest-data/overlay_15.dts     | 4 ++--
 drivers/of/unittest-data/tests-overlay.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/of/unittest-data/overlay_15.dts b/drivers/of/unittest-data/overlay_15.dts
index b98f2514df4b..5728490474f6 100644
--- a/drivers/of/unittest-data/overlay_15.dts
+++ b/drivers/of/unittest-data/overlay_15.dts
@@ -20,8 +20,8 @@
 			#size-cells = <0>;
 			reg = <0>;
 
-			test-mux-dev {
-				reg = <32>;
+			test-mux-dev@20 {
+				reg = <0x20>;
 				compatible = "unittest-i2c-dev";
 				status = "okay";
 			};
diff --git a/drivers/of/unittest-data/tests-overlay.dtsi b/drivers/of/unittest-data/tests-overlay.dtsi
index 25cf397b8f6b..4ea024d908ee 100644
--- a/drivers/of/unittest-data/tests-overlay.dtsi
+++ b/drivers/of/unittest-data/tests-overlay.dtsi
@@ -103,8 +103,8 @@
 							#size-cells = <0>;
 							reg = <0>;
 
-							test-mux-dev {
-								reg = <32>;
+							test-mux-dev@20 {
+								reg = <0x20>;
 								compatible = "unittest-i2c-dev";
 								status = "okay";
 							};
-- 
2.17.1


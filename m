Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F284FC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01F62146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549634752;
	bh=a6BcCySmYSM5Qie/ErbUNgukMDB/MX0Y+Z4Ss4DvgSc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DM7f7EFTYk/H8lRRV8msseddsIX/mjhID5g0SLFeYJtX5PGrPdOeZ9nLkHP6o6SxP
	 Yx8IHgifHmW9pdGY2E6CbxgOF4UPy6asOM5PjHpDt/FjTbxR+sI1rkxOyYbCkt/k26
	 Bw6BMhMLB6nuHIUEq2ACRCljRQm3WW5oz/suV3Ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfBHOFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:05:51 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38169 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfBHOFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:05:50 -0500
Received: by mail-lf1-f65.google.com with SMTP id j15so2619223lfh.5;
        Fri, 08 Feb 2019 06:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3JR2OJ3HLN8oC8qz1a8O1nIAhv90j+8ohr3+E4Qf+NE=;
        b=bpt5Ou02gz+r/dOlYeXzFd6wTL2J5AvvijvnPgnYaCcoql9SzC1Om23cDvKgGT421E
         NTt5/1ZF24fzId2yBX5dW90isfq/aqrAoXaSx1/qRAQf5Brt1hGm502VIivAXVJ7tssI
         3p76epQz+F/FoeAYDyOlCIdX6HXKPCY42MQi+zF3NQmK1R06kdRnGEJxsZHg3aAIQVWR
         rLEl36C/PQhyFChJCjEypNVdDvw3Nxo7JIMbOV7R2JnI2TeGd/gnPRdZMDxq0hPWpw+q
         f3MqrrWym+1qNwH+J//vGCMnJlv1sV7j3a5v1csckiYymv2DTYLQ0lHmiR82x5b/CxHK
         dVeg==
X-Gm-Message-State: AHQUAuaLNv0QyCzrIERCU6PycW/+cCZFwxi6/wTsOdM8Fsnt1im+WK9v
        lY5QGowvWvwEv+Tfq/+Mm8Q=
X-Google-Smtp-Source: AHgI3IahTfyJGCs0e3HBs9McEg8D5NDjSdJlgCWB8+ummk/wtpyLY1AhMP4uZMz/bMSbSCjJezkSrQ==
X-Received: by 2002:a19:6f0a:: with SMTP id k10mr13707155lfc.119.1549634747066;
        Fri, 08 Feb 2019 06:05:47 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id a11sm383982lff.68.2019.02.08.06.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 06:05:46 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gs6mm-0003ND-AT; Fri, 08 Feb 2019 15:05:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH] dt-bindings: regulator: update fixed-regulator example
Date:   Fri,  8 Feb 2019 15:04:25 +0100
Message-Id: <20190208140425.12917-1-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed regulators do not have associated bus addresses and are typically
placed directly under the root node where their names must still be
unique despite not having a unit address.

Fix the malformed example node which had a unit address but no "reg"
property by dropping the unit address.

Also, try to make the example more useful by using the recommended
generic node name "regulator", but with a suffix reflecting the
regulator name in order to make it unique.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 .../devicetree/bindings/regulator/fixed-regulator.yaml        | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
index a7607b0baab7..d289c2f7455a 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
@@ -52,9 +52,9 @@ required:
 
 examples:
   - |
-    abc: fixedregulator@0 {
+    reg_1v8: regulator-1v8 {
       compatible = "regulator-fixed";
-      regulator-name = "fixed-supply";
+      regulator-name = "1v8";
       regulator-min-microvolt = <1800000>;
       regulator-max-microvolt = <1800000>;
       gpio = <&gpio1 16 0>;
-- 
2.20.1


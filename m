Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8231C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688762087A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kIXlxZuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688762087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbeKNUmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:42:33 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43464 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731585AbeKNUmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:42:33 -0500
Received: by mail-pg1-f193.google.com with SMTP id n10-v6so7179646pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 02:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OM1h8RLKMaTSl+4WPqfsrJv64qiH5E4qocw+dALFqNU=;
        b=kIXlxZuOIgnlUEDi+YvKlaMxvH0DjZA0ifPLve5ohrGyYuxz/mVluaV5wt3ogQ4PgW
         6O9EP9YqraYTglnwCXAiPGcftC5zJjm6RUepPR9J1h2dKnkxghsjXQIa8GswaOMDmxuZ
         grTjxpZcDvVc7joKcvcmX6vaT6skpT3yC4xg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OM1h8RLKMaTSl+4WPqfsrJv64qiH5E4qocw+dALFqNU=;
        b=V1e8Ud95/mVcTKMcEzbxjyL5l4R+RMvVSr5ml5HsNMSl+h5zBKodzYD1/TC0Osdrp7
         A0PwmF8AJpYMk+vtG4bMs2KS6zKSqjaPgtOOgUg2qXlm1206oORNhck0AW/fv3dri5DO
         uNssgoT0cGB56FVBqaVsZij2y6FRgblYQgiASyW5QQ/DIPaHXx9ovQLFeKesBNt5rUtP
         0gpkDBPZsxfoWEdWanzHJoyo+Us01wMgYjvqoPqSXozVKCocMxJQJ8ouEvEjgEjAdFbI
         V1m0f0UokEyOExpNL0lT97e7z5e397101I/SF3DPpC0qe4WtY6JUsNEow4RxZMQq+gNd
         /tgg==
X-Gm-Message-State: AGRZ1gIMZ+zDUXQRXrU0iLUa1zPFryrOtuHsHA4HhcVxAh64znxWSDDc
        XDfxGVBfRHGh5X34tWekG0sV
X-Google-Smtp-Source: AJdET5f2CmIING92NP+YuNyXJPzSPmPaeH5EznIodjn1F+lu2362/tS/gQ9y4YzxdbK8QcSzEVm9kA==
X-Received: by 2002:a62:5210:: with SMTP id g16-v6mr1391945pfb.256.1542191991903;
        Wed, 14 Nov 2018 02:39:51 -0800 (PST)
Received: from localhost.localdomain ([2405:204:734f:c50:bc03:daf0:c43c:4a59])
        by smtp.gmail.com with ESMTPSA id b2sm15028270pfm.3.2018.11.14.02.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 02:39:51 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, robh+dt@kernel.org, todor.tomov@linaro.org,
        hansverk@cisco.com
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] dt-bindings: media: i2c: Fix external clock frequency for OV5645
Date:   Wed, 14 Nov 2018 16:09:35 +0530
Message-Id: <20181114103935.24559-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit "4adb0a0432f4 media: ov5645: Supported external clock is 24MHz"
modified the external clock frequency to be 24MHz instead of the
23.88MHz in driver. Hence, make the same change in corresponding bindings
doc and mention the acceptable tolerance.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/media/i2c/ov5645.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/ov5645.txt b/Documentation/devicetree/bindings/media/i2c/ov5645.txt
index fd7aec9f8e24..b155583469a4 100644
--- a/Documentation/devicetree/bindings/media/i2c/ov5645.txt
+++ b/Documentation/devicetree/bindings/media/i2c/ov5645.txt
@@ -8,7 +8,8 @@ Required Properties:
 - compatible: Value should be "ovti,ov5645".
 - clocks: Reference to the xclk clock.
 - clock-names: Should be "xclk".
-- clock-frequency: Frequency of the xclk clock.
+- clock-frequency: Frequency of the xclk clock. Should be 24MHz with 1%
+                   acceptable tolerance.
 - enable-gpios: Chip enable GPIO. Polarity is GPIO_ACTIVE_HIGH. This corresponds
   to the hardware pin PWDNB which is physically active low.
 - reset-gpios: Chip reset GPIO. Polarity is GPIO_ACTIVE_LOW. This corresponds to
@@ -37,7 +38,7 @@ Example:
 
 			clocks = <&clks 200>;
 			clock-names = "xclk";
-			clock-frequency = <23880000>;
+			clock-frequency = <24000000>;
 
 			vdddo-supply = <&camera_dovdd_1v8>;
 			vdda-supply = <&camera_avdd_2v8>;
-- 
2.17.1


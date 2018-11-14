Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2B4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F36922419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TKAb/cQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F36922419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbeKNWQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 17:16:58 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43162 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbeKNWQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 17:16:58 -0500
Received: by mail-pl1-f195.google.com with SMTP id g59-v6so7701122plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 04:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=f9HV0LS1Ii4UmTPpivxRZYMQGVQIv/yLKxNfYU46tF8=;
        b=TKAb/cQxvYneIuWluj2Ai4HjHcW69k0PdhJsDPdvJ33xe3A8+WBtoKZNxOFhALZthj
         w5rGQmlMRRMQVLZCrYTZAGF0OjoF12ej4wZsK/wcOiHZrFEk4Vct4Ra+s0yk4i8zmdE+
         3hswvMyYfgC4dmcTDnxlxruodRie5PbUXeDtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f9HV0LS1Ii4UmTPpivxRZYMQGVQIv/yLKxNfYU46tF8=;
        b=ozN+saNMTWjIpo7y2E8o0NKrtaYj93l7z1lSTmXRMSXDIH6qeruizx0T5itEX7HuDs
         BVQ6TwYLVlz+W6MPTybU4VbXuYcKMFCf6t7TkyZIhZvq2tBT0K/O+xC2bgTAIzWRb1py
         vsK96l6F+t2NuK6AGMH/GRCfzN1LJhtRjzQBFi+jNeuzv6NWIjo+/ir1uc+XufPz2qYf
         ujTwxpIVlvjQLzJtDp9hFtC/f/GZhGI+KC4B1/rq8xX3up6VnN+gGpEp29pnIBSMPE5q
         euPxcjhAsnnUi5eCE3T4fvV471WHFxp61sWPGEqsm6ZBHSqO0yuxDTzXhOekTTtrXyPY
         YhqA==
X-Gm-Message-State: AGRZ1gKU/MQjaClwobOGulTQ3YhIenykqAeHuwymJQ1brhXFx/RWuUXa
        0f6GKKwxDwoJvUPReNaSSPxadHMXFg==
X-Google-Smtp-Source: AJdET5ebTkRZ3kQebakebhVUV5T/AQ4cmFqH3qGVaJIipkrEBWkzER42ycMFTLQDsQokLYM7cVaj+A==
X-Received: by 2002:a17:902:be07:: with SMTP id r7-v6mr1661360pls.137.1542197637958;
        Wed, 14 Nov 2018 04:13:57 -0800 (PST)
Received: from localhost.localdomain ([2405:204:734f:c50:bc03:daf0:c43c:4a59])
        by smtp.gmail.com with ESMTPSA id k70-v6sm26652807pfc.76.2018.11.14.04.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 04:13:56 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, robh+dt@kernel.org, todor.tomov@linaro.org,
        hansverk@cisco.com
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2] dt-bindings: media: i2c: Fix external clock frequency for OV5645
Date:   Wed, 14 Nov 2018 17:43:38 +0530
Message-Id: <20181114121338.28026-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit "4adb0a0432f4 media: ov5645: Supported external clock is 24MHz"
modified the external clock frequency to be 24MHz instead of the
23.88MHz in driver. Hence, modify the frequency value in binding.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Removed the wording about supported frequency since the hardware is
  capable of accepting freq range from 6-27MHz.

 Documentation/devicetree/bindings/media/i2c/ov5645.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/ov5645.txt b/Documentation/devicetree/bindings/media/i2c/ov5645.txt
index fd7aec9f8e24..b032abfcea36 100644
--- a/Documentation/devicetree/bindings/media/i2c/ov5645.txt
+++ b/Documentation/devicetree/bindings/media/i2c/ov5645.txt
@@ -37,7 +37,7 @@ Example:
 
 			clocks = <&clks 200>;
 			clock-names = "xclk";
-			clock-frequency = <23880000>;
+			clock-frequency = <24000000>;
 
 			vdddo-supply = <&camera_dovdd_1v8>;
 			vdda-supply = <&camera_avdd_2v8>;
-- 
2.17.1


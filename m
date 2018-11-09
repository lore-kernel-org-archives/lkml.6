Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A06C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4034F20892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="idp5njpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4034F20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeKIRgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:36:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46909 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbeKIRgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:36:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id s9-v6so557845pfm.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 23:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=b0ZI4yKMDm3C+8nerlVTKSyWkE+9ztsGbxX/Wr3Lzqo=;
        b=idp5njpTylykwWt0S5Xw3IZ7VFhZ8ChpziKqEGnvQn3UoEYVD+n8/C1u3hk2IMtmi6
         t9Rz3jNn7S7fxMa5cuDgBV+URzFESg2r1phqzC+GEMvQry1IxJcRKr67IDYalFWSYyvb
         JvGtGYKEVLbowQdLaHVfY2tOtLu/BldXdlye8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b0ZI4yKMDm3C+8nerlVTKSyWkE+9ztsGbxX/Wr3Lzqo=;
        b=VFosQkKgV7Q3OYsmzvQhVPEjILw/dwz1813Sxky2ZpqjZgzBUoSp7j/9P0v/CP0r4v
         ghaOyZ9hWGZVljMnCo2BA5lVbhMgxGxnPbJTAS4YawCSzc+ipXjHkUruG2Kx0UkBbi3V
         u+MHezWKIORetLMLTzeiRy0+mnrHp87QCNNkONA2qZoRjCnWWg60xiClAcMRogmhcD45
         9KXyQllf7suTQacr9Ft7ogW8jtW3h/DPfw9JjzTuBq4mj71VGS0AZt6aqtznPxPiQqUC
         cxEZRmQpQlDNFf0IrgK45MVNxbtJASgiEqNGIb509Fs14nuiCcdZxRIEOCJnimjQHY41
         cPXQ==
X-Gm-Message-State: AGRZ1gIoCm1D5NLY58fpahb9f5QwuEtivry+T3gH6MEBFEgEPQOecW4n
        +LzwsyYbIMDGDrMOzZV4AyGq
X-Google-Smtp-Source: AJdET5eGFALKDWsb4PYhmoHZ0evbq2gw14/bTVPDy6u3DBO+rHZpwonC/WWksVfRbs1OzK5SwgSQNA==
X-Received: by 2002:a63:f811:: with SMTP id n17mr6756092pgh.23.1541750214835;
        Thu, 08 Nov 2018 23:56:54 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id f18-v6sm16591110pfh.0.2018.11.08.23.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 23:56:54 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, robh+dt@kernel.org, todor.tomov@linaro.org,
        hansverk@cisco.com
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] dt-bindings: media: i2c: Fix i2c address for OV5645 camera sensor
Date:   Fri,  9 Nov 2018 13:26:43 +0530
Message-Id: <20181109075643.17575-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c address for the Omnivision OV5645 camera sensor is 0x3c. It is
incorrectly mentioned as 0x78 in binding. Hence fix that.

Fixes: 09c716af36e6 [media] media: i2c/ov5645: add the device tree binding document
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/media/i2c/ov5645.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/ov5645.txt b/Documentation/devicetree/bindings/media/i2c/ov5645.txt
index fd7aec9f8e24..1a68ca5eb9a3 100644
--- a/Documentation/devicetree/bindings/media/i2c/ov5645.txt
+++ b/Documentation/devicetree/bindings/media/i2c/ov5645.txt
@@ -26,9 +26,9 @@ Example:
 	&i2c1 {
 		...
 
-		ov5645: ov5645@78 {
+		ov5645: ov5645@3c {
 			compatible = "ovti,ov5645";
-			reg = <0x78>;
+			reg = <0x3c>;
 
 			enable-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
 			reset-gpios = <&gpio5 20 GPIO_ACTIVE_LOW>;
-- 
2.17.1


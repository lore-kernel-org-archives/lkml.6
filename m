Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF39C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BCE21E1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6rAd07H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BCE21E1D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbeHIO5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:57:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37623 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732053AbeHIO5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:57:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id a26-v6so2793974pfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 05:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=zbtXplXL4eCfyozOTLoTj7c7yf/Di+JxuuvxI0s2oo8=;
        b=b6rAd07HpkMnc5nB0TJyPTwaanaEBzqHYDhX6y1dkCJu1hA5Q70SstU81tyCkPZjYD
         QQjwDzlLeA+3D6T4w7qahzlS2ioLrmjnK/9ccUaCT07l5afJqb/0rxgUcI8KaqEZCOfG
         NWZTZDfJOysWY4FLhzQ8gcr5umfQWcAviNGp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zbtXplXL4eCfyozOTLoTj7c7yf/Di+JxuuvxI0s2oo8=;
        b=GXcXBCVH8bHUI/2yxBPnCU3qILUrxUnUvCzygG2NlAfS0l9pYETM9Nsn43dPZcn35z
         ouMtNNL9DHXAZQ+5cerayKIdNKrPVS6ZZxhe9+FtKwHJYBP0pEPxWC60LcDMe6miatHr
         AVHgzn1AOIjdwRcnNGb0aUqepT5i4wygfaAkaI8W3QQBaUvnCeqNYesFdhU7KHyskcCb
         e5AjY/Rm2Wv7pVo1zDENAnO7R1x3JkOgqWIIGTOVjZJ9QKcJcsy6BeXelajpQtRts3fP
         VGlhCernJyBw60yqVar4u+Ig+xGv/HCCc/OjHPujUy84huDXN4a+x3Abg9xWWrOq4OnU
         Zowg==
X-Gm-Message-State: AOUpUlEHGDfSB0F5y896LJYXUGCr2d0GPQqo6tEvdLmSUg9BRooQXu3l
        f/dkYQIYO60yIe6R7B3jNtkbj7DY5Gk=
X-Google-Smtp-Source: AA+uWPw65ytn1LX2ZRGNXXn1EJu89v3kbg7dexqmknaBz1WUA03GZX/FK7WXpXeXs62USl97UXFFNQ==
X-Received: by 2002:a63:c80e:: with SMTP id z14-v6mr1965521pgg.77.1533817983225;
        Thu, 09 Aug 2018 05:33:03 -0700 (PDT)
Received: from localhost ([45.113.251.134])
        by smtp.gmail.com with ESMTPSA id g15-v6sm17012656pfg.98.2018.08.09.05.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:33:02 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 02/10] dt-bindings: thermal: Fix a typo in documentation
Date:   Thu,  9 Aug 2018 18:02:34 +0530
Message-Id: <08b528ddc26adcb57539b1ac9d352850d7d80bfb.1533815718.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1533815718.git.amit.kucheria@linaro.org>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1533815718.git.amit.kucheria@linaro.org>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c(1) + x(1) was actually meant to be c(1) * x(1).

While we're at it, add some brackets to make it nicer to read.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 Documentation/devicetree/bindings/thermal/thermal.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index cc553f0952c5..751104213d08 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -152,7 +152,7 @@ Optional property:
   Elem size: one cell	the sensors listed in the thermal-sensors property.
   Elem type: signed	Coefficients defaults to 1, in case this property
 			is not specified. A simple linear polynomial is used:
-			Z = c0 * x0 + c1 + x1 + ... + c(n-1) * x(n-1) + cn.
+			Z = (c0 * x0) + (c1 * x1) + ... + (c(n-1) * x(n-1)) + cn.
 
 			The coefficients are ordered and they match with sensors
 			by means of sensor ID. Additional coefficients are
-- 
2.17.1


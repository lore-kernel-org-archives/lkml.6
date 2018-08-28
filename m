Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C08C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4D32089E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JyzwBTUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4D32089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeH1RbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:31:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37239 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbeH1RbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:31:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id b10-v6so1401823eds.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 06:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=PbQjEup6XpRnvv+UBO/q/f3xZ3V6EwBkXW9c9eUdpL8=;
        b=JyzwBTUztWfCDNMkxGrOPshebCX2whfQketX4WNvaVOeetlill0VGCXoiiH+B8sxt6
         2/byLEObvVdAzuXDPHK80ys2hllPfqUQbeVtrKRu6Y91a+ZIS4chVzOVpdGZKxXzAd8t
         9Cy2IzzaPoGueerYjichhMPjlWdPxyMsYOu8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=PbQjEup6XpRnvv+UBO/q/f3xZ3V6EwBkXW9c9eUdpL8=;
        b=jR1C9fdAK+RzAcRH/fnq2vlDeMl3w38GE8VHBoS+hT8aAykbqiEvO6IpCTAUXf7j+l
         M1iJmyewhULGhR0hjyXiS9RAek631barVjNLKPnrkfaufRNlxfaxX6nldsc7jNdHrm76
         uRym4IacAYtk9HJBr46B3JflxptLmAesxZz6cE3eo4ox5Q/1ONYd6F0RG631RwwXx+Fc
         y11wAns/xyDQ96zeco2xOzyAcQA4LeJBVn1rZ5iKROyPiss4VSmFhuOdB3C957gEMJ7X
         yocSmN0TwG4I1LSrG/x/XJGcr8CRQ2NLIxItLqKs1G4S5YYjhOEiczG41rQjVRzQGlYZ
         yPFw==
X-Gm-Message-State: APzg51B5Pm96W7/j/ynzMtIL4evkx1aIhJ3qL0m5DMDAh0IxMIyx96km
        plFOUcdiFPOOrdQ8WLYm+JKEm3Rr+EY=
X-Google-Smtp-Source: ANB0Vda+X4CmlZd2m9vsdzAnt5mrTCIJ1aKiMjNKrXvwr1+8ViFJmBjIMKextR8edDFmIfyKstM6RA==
X-Received: by 2002:aa7:d6da:: with SMTP id x26-v6mr2545421edr.209.1535463557845;
        Tue, 28 Aug 2018 06:39:17 -0700 (PDT)
Received: from localhost ([49.248.200.109])
        by smtp.gmail.com with ESMTPSA id f16-v6sm595597edq.36.2018.08.28.06.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 06:39:17 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 03/11] dt-bindings: thermal: Fix a typo in documentation
Date:   Tue, 28 Aug 2018 19:08:32 +0530
Message-Id: <8480b996596184a478fe74dfdb97ead7dba6fb11.1535462942.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c(1) + x(1) was actually meant to be c(1) * x(1).

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/thermal/thermal.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index eb7ee91556a5..ca14ba959e0d 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -152,7 +152,7 @@ Optional property:
   Elem size: one cell	the sensors listed in the thermal-sensors property.
   Elem type: signed	Coefficients defaults to 1, in case this property
 			is not specified. A simple linear polynomial is used:
-			Z = c0 * x0 + c1 + x1 + ... + c(n-1) * x(n-1) + cn.
+			Z = c0 * x0 + c1 * x1 + ... + c(n-1) * x(n-1) + cn.
 
 			The coefficients are ordered and they match with sensors
 			by means of sensor ID. Additional coefficients are
-- 
2.17.1


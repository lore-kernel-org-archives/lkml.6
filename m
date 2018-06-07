Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id m+k8A384GVuHewAAmS7hNA
	; Thu, 07 Jun 2018 13:51:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E59CD608D2; Thu,  7 Jun 2018 13:51:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="m8qndPgh"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5A729608C8;
	Thu,  7 Jun 2018 13:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A729608C8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932837AbeFGNvz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:51:55 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34061 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932818AbeFGNvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:51:50 -0400
Received: by mail-pl0-f66.google.com with SMTP id g20-v6so6202189plq.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 06:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aGwiEeJ/vyGxho/CLF2GkRyKJUCYD5pFEnm6TLrDztw=;
        b=m8qndPghRc7+xlYWYbENtOIyMk14wZ0YOAXk/SqPB0lUgAR9BOozOc/7TW+Qq6N+Fn
         qjQfUxAlWTdkGLD1xSRux9lRJRDVRMfx5Y+5UlmYFhl3UVucp5NKqv0F6J+4SSVeXcCC
         aIKfUJMdlNnVrLtSKRFl/R8PBobwMbzVqK3kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aGwiEeJ/vyGxho/CLF2GkRyKJUCYD5pFEnm6TLrDztw=;
        b=HVeZRViJJbO7UC3YD09n2GwGmRArfss6of8yFy/vD50Cj8qqYYRB9Lfvxbz/1s3beH
         LWrHhQr/BxpKvobdZiDrtnjDrRgXYhvRXECWb+C74KcuvFKaodzXJP/dYHzXmtx7S2oO
         I+MkH/4s6L4AWsuMj2vYJgs7Q7VQXRtjtiqdKa7BQOs0oFjGgKwvELoCGLrvB8/C4JnT
         0pzYmhi9VXWwUEJZHvZV9f58Z4fhadIdEfkh0nv9+T27lpg1IiB5IvYdJcOijrxx9X+7
         eVzzCd+iu86L+uQ/A1lNV3TgUdCRW4VEHufOiU/EVLocKr46++i/eW8/gu9ZAwvs6z0R
         oEYg==
X-Gm-Message-State: APt69E1DLRoSiDBpDaQY9HTlamTHWWuR5nlP2YexRKOdoXBQOFFegFZI
        NNwm7LoTDm8oaf9ZBL1Bo5paIg==
X-Google-Smtp-Source: ADUXVKJvn6xQcUsQlyrtHZBUYxojnpkxR7ueg3s5/GCzw05rDdKPKCDE+NQDqeWxW++lmbIm5Bk2Ew==
X-Received: by 2002:a17:902:6546:: with SMTP id d6-v6mr2170165pln.196.1528379509941;
        Thu, 07 Jun 2018 06:51:49 -0700 (PDT)
Received: from localhost.localdomain ([115.97.190.51])
        by smtp.gmail.com with ESMTPSA id b3-v6sm56455901pgn.44.2018.06.07.06.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 06:51:49 -0700 (PDT)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 3/3] ARM: dts: imx6qdl-icore: Fix wrong reg_2p5 regulator node name
Date: Thu,  7 Jun 2018 19:21:33 +0530
Message-Id: <20180607135133.3104-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180607135133.3104-1-jagan@amarulasolutions.com>
References: <20180607135133.3104-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- in reg_2p5, fix regulator node name as regulator-2p5v
- remove exctra line

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6qdl-icore.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index be8aa55c973e..9ce993776160 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -65,8 +65,7 @@
 		regulator-always-on;
 	};
 
-
-	reg_2p5v: regulator-3p3v {
+	reg_2p5v: regulator-2p5v {
 		compatible = "regulator-fixed";
 		regulator-name = "2P5V";
 		regulator-min-microvolt = <2500000>;
-- 
2.14.3

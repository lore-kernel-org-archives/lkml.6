Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9464EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AE021871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cdf4UhSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbeLRV3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:29:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35605 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbeLRV3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so17436763wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QNYOuzWiRe8n31bZiL2aJF+DJft2DVSSW8AmaS53Sng=;
        b=cdf4UhSu1WQNvX1qVaWrYRJGRVRhsMi3GwCYhub2YEfgE1E6ugegMir2Tjfd+lS8LF
         X57mjysx4r4/H8O/cA5i8Xe5n6W6iyedu62f2uVOlI2kVGhR2AJbdbYxT5OQXbb5JXj6
         yOM9VvF65/O+RrfHnQErxM686Cbc1LkNC355U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QNYOuzWiRe8n31bZiL2aJF+DJft2DVSSW8AmaS53Sng=;
        b=E6kHi1diMdimvwc+t439k1vHwMuq0WTRmcafJvYY6Z8dpWdUHhBbcJOR2a2NVunPUk
         VOtTGwrbNuBbZ+4iWtjVMtAOuGOuwgeP91Kbt5QkQr1FmY80jBl4dvh3iNdaE61cdvh8
         GIeNVqQxIzwXvCQTCpdKzFX+eubHewmQ+H2jclciKer2Zf6jqBVzIXCeFkkgnZZXq76H
         r+cUWIN5dRqIpPD5dS7Iyn4tr0aL+NGIptXVJO3KJSgYjZ1MxPgVBVciswUG00FU5kmz
         RM8JlArEa/Oh00IE0YEyurV2G1z+8x6d1SMoezcj+K19E/WKISdwh9oPkq1B0+UmFVJr
         sbGQ==
X-Gm-Message-State: AA+aEWbcEKkRC4adEetdYIdjv2ZcQLVXq7DQkTiQ2TUZTkURfsERvNXQ
        q184+Z2gerHFMLGF7VDmtWUdJKLWVOU=
X-Google-Smtp-Source: AFSGD/Veh/lP9zns+YVoDDYH8/7bl1IUz2jg4FdaFlZNHw3g1jAQrp07SvCSE16PCVKxNZJxSznuyw==
X-Received: by 2002:adf:9083:: with SMTP id i3mr15864234wri.124.1545168570957;
        Tue, 18 Dec 2018 13:29:30 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:30 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 14/25] dt-bindings: timer: renesas, cmt: Document r8a774a1 CMT support
Date:   Tue, 18 Dec 2018 22:28:32 +0100
Message-Id: <20181218212844.30445-14-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biju Das <biju.das@bp.renesas.com>

Document SoC specific bindings for RZ/G2M (r8a774a1) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../devicetree/bindings/timer/renesas,cmt.txt         | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index eb602c599341..862a80f0380a 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -30,6 +30,8 @@ Required Properties:
     - "renesas,r8a7745-cmt1" for the 48-bit CMT1 device included in r8a7745.
     - "renesas,r8a77470-cmt0" for the 32-bit CMT0 device included in r8a77470.
     - "renesas,r8a77470-cmt1" for the 48-bit CMT1 device included in r8a77470.
+    - "renesas,r8a774a1-cmt0" for the 32-bit CMT0 device included in r8a774a1.
+    - "renesas,r8a774a1-cmt1" for the 48-bit CMT1 device included in r8a774a1.
     - "renesas,r8a7790-cmt0" for the 32-bit CMT0 device included in r8a7790.
     - "renesas,r8a7790-cmt1" for the 48-bit CMT1 device included in r8a7790.
     - "renesas,r8a7791-cmt0" for the 32-bit CMT0 device included in r8a7791.
@@ -51,9 +53,12 @@ Required Properties:
 		and RZ/G1.
 		These are fallbacks for r8a73a4, R-Car Gen2 and RZ/G1 entries
 		listed above.
-    - "renesas,rcar-gen3-cmt0" for 32-bit CMT0 devices included in R-Car Gen3.
-    - "renesas,rcar-gen3-cmt1" for 48-bit CMT1 devices included in R-Car Gen3.
-		These are fallbacks for R-Car Gen3 entries listed above.
+    - "renesas,rcar-gen3-cmt0" for 32-bit CMT0 devices included in R-Car Gen3
+		and RZ/G2.
+    - "renesas,rcar-gen3-cmt1" for 48-bit CMT1 devices included in R-Car Gen3
+		and RZ/G2.
+		These are fallbacks for R-Car Gen3 and RZ/G2 entries listed
+		above.
 
   - reg: base address and length of the registers block for the timer module.
   - interrupts: interrupt-specifier for the timer, one per channel.
-- 
2.17.1


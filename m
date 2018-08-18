Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273B5C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 19:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDA62176D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 19:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="l6mvIQVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDA62176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeHRXIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 19:08:17 -0400
Received: from onstation.org ([52.200.56.107]:47902 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbeHRXIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 19:08:17 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 2CF6A1020;
        Sat, 18 Aug 2018 19:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1534622365;
        bh=e+FRXECGK4SqzbEocIibP8JfgagJNGbiwyJ9iJ+INbA=;
        h=From:To:Subject:Date:From;
        b=l6mvIQVALqGIwR9BPSqluX49fFzk3Kw2OGDlFjKUy5GODqC3d+bW7nfoYJcwcRZXZ
         rurVGz5WREluheZ/y1azuy4hZgHYvVGq59gCaRDldWCA6UXz+2wPDaKdfiqlaCRZ+2
         2m4iw1FN+Mfa6qG52uM1WDM9OBJmksQ8m0dL3dXE=
From:   Brian Masney <masneyb@onstation.org>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.reichel@collabora.co.uk, robh@kernel.org,
        mark.rutland@arm.com, masneyb@onstation.org
Subject: [PATCH] dt-bindings: input: pwm-vibrator: correct pwm-names in example
Date:   Sat, 18 Aug 2018 15:58:55 -0400
Message-Id: <20180818195855.13429-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the example for the pwm-vibrator bindings, pwm8 is the direction pin,
and pwm9 is the enable pin. The pwm-names on the vibrator node has these
two values swapped. This patch corrects the values for pwm-names.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
arch/arm/boot/dts/omap4-droid4-xt894.dts is actual implementation for
the example and it is correct.

 Documentation/devicetree/bindings/input/pwm-vibrator.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/pwm-vibrator.txt b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
index 09145d18491d..2731cbb7e8d7 100644
--- a/Documentation/devicetree/bindings/input/pwm-vibrator.txt
+++ b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
@@ -60,7 +60,7 @@ Example from Motorola Droid 4:
 		compatible = "pwm-vibrator";
 		pwms = <&pwm8 0 1000000000 0>,
 		       <&pwm9 0 1000000000 0>;
-		pwm-names = "enable", "direction";
+		pwm-names = "direction", "enable";
 		direction-duty-cycle-ns = <1000000000>;
 	};
 };
-- 
2.17.1


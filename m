Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5E3C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC4C2146E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="f7jb3C+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfBGNcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:32:06 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:55952 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfBGNcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549546321; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3RPMPQytOhSC9q0Je/JSl5fbx8HDrff2YPvGeN6P0WQ=;
        b=f7jb3C+uE+vWcVSvdEnm+k6CvF1HCBuYEFDWXO9IRMtYi86oXw0jUS0mPZWPMjimeZ/Oxd
        1pB1G1+NGjnZvrBt1sZE56YwIrJhRvAsbIqKAoRKzqdJjdPhe4dnefIG0HJtn91dk+tMjc
        d9bEORDm9v0XmSyNhfNkJCyygR2X+UU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/6] dt-bindings: sound: Document jz4725b-codec bindings
Date:   Thu,  7 Feb 2019 10:31:39 -0300
Message-Id: <20190207133143.5232-2-paul@crapouillou.net>
In-Reply-To: <20190207133143.5232-1-paul@crapouillou.net>
References: <20190207133143.5232-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation about how to probe the jz4725b-codec driver from
devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v2: No change

 .../bindings/sound/ingenic,jz4725b-codec.txt         | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt b/Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt
new file mode 100644
index 000000000000..05adc0d47b13
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ingenic,jz4725b-codec.txt
@@ -0,0 +1,20 @@
+Ingenic JZ4725B codec controller
+
+Required properties:
+- compatible : "ingenic,jz4725b-codec"
+- reg : codec registers location and length
+- clocks : phandle to the AIC clock.
+- clock-names: must be set to "aic".
+- #sound-dai-cells: Must be set to 0.
+
+Example:
+
+codec: audio-codec@100200a4 {
+	compatible = "ingenic,jz4725b-codec";
+	reg = <0x100200a4 0x8>;
+
+	#sound-dai-cells = <0>;
+
+	clocks = <&cgu JZ4725B_CLK_AIC>;
+	clock-names = "aic";
+};
-- 
2.11.0


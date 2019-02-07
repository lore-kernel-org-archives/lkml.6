Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E44C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C160E20663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ePJsfZYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfBGNcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:32:01 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:55866 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfBGNcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549546318; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=srgDHS0KHV1GzD6hMhzNz/cO/paL3bkbGx3CUEyjmNs=;
        b=ePJsfZYSXKAkuI0h9BfzxGOrVYdOSIPrw6Mmd9iVcOAnAW7Opn4dt86nFzDWL5PuvDdxQl
        JaNSNwxzR7NIEKDQZvAWXHXyoSq1bG5I6z1vQomgfVhpqnQW2kkahR383CVv5khMvedVMM
        QnNm4EwTfYO6ZLjMm/W3z9U6QCnwL2Y=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/6] dt-bindings: sound: Document jz4740-codec bindings
Date:   Thu,  7 Feb 2019 10:31:38 -0300
Message-Id: <20190207133143.5232-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation about how to probe the jz4740-codec driver from
devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v2: No change

 .../bindings/sound/ingenic,jz4740-codec.txt          | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt b/Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt
new file mode 100644
index 000000000000..1ffcade87e7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ingenic,jz4740-codec.txt
@@ -0,0 +1,20 @@
+Ingenic JZ4740 codec controller
+
+Required properties:
+- compatible : "ingenic,jz4740-codec"
+- reg : codec registers location and length
+- clocks : phandle to the AIC clock.
+- clock-names: must be set to "aic".
+- #sound-dai-cells: Must be set to 0.
+
+Example:
+
+codec: audio-codec@10020080 {
+	compatible = "ingenic,jz4740-codec";
+	reg = <0x10020080 0x8>;
+
+	#sound-dai-cells = <0>;
+
+	clocks = <&cgu JZ4740_CLK_AIC>;
+	clock-names = "aic";
+};
-- 
2.11.0


Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5A4C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCEF2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nteZ1A5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCEF2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbeLBVYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:24:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41921 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbeLBVXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:23:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so10128923wrs.8;
        Sun, 02 Dec 2018 13:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qRH6PeTeS0nOBRWqCT6Sy3VYXacguU5ylHf5h8mKS3s=;
        b=nteZ1A5S5jTFEMnLTgHOVZCS6vWXVMfXSpo02opfr4tRlO1SrDYsi+WMd8ECELQi69
         DgK4zoDwn6nJoQofP2HZjADGqPITtv9r9dBG0ZpEOPwRFLCsJmMXzH1grPxd1xeNEz6I
         JYY+DRJf+PiuRJOLVpPDy2llNdCDPL0bGp1XxheZekHKKZK0MWAFkz2wRxSTDrif0pWN
         yDS5XNt+FpqzxXEFMjPzKtE2BqBjntpt4F+flB8Ud96BIBErmBVxHj41OcgECLqJiS6f
         NbzfqMYH6I4h9uzi5xL/QzgfUbncbeF38yUqRODJBDCwro2+JV5z87DTuq9KUc88ITyv
         eJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qRH6PeTeS0nOBRWqCT6Sy3VYXacguU5ylHf5h8mKS3s=;
        b=RDCL9pq0lS8P4J4usZdcTtR1dX5cSr7EbOQIEOG4MWhFmgfI2pwi85fsbnE52uoEus
         Ab34LW4ZYv6tyrLlnjQOi42ZDxL7cHf3VqjKIyU9VS2HaTDNukm3yupVn5QC7sCK7PpR
         qGyWgdqx/hb6lNrNTIdCu2WvmRhlRS3HQM9HdbB9vwi+/0PhDb2dOrvsPKweQCwVy3Oo
         Fm4anwAbUhh+eaYNInHDXHIh3e09KMVgYMze73Zl0d0BGSEAf7eXMknEqtW7U7GMIhEe
         YBVO/bs3xX3wDK13kzhU+oPayNEnhlTiQBabqCQIWJaepERrb9v6F+xUv9nrlXMk3lDt
         0IJQ==
X-Gm-Message-State: AA+aEWaXjl7uhRIkRo89k1ooelf4ZDgFR34mOMDacU83fk6xsJQa1gSD
        bh3tENNqLZQJFu5pxmU9Rqj4bCWHV8k=
X-Google-Smtp-Source: AFSGD/URI7MWeIJo1zSa6arTqQmdNcPT7xrHVumv/vajrAYyCpjWsU77MvdbmYmIAZ6S5TSZqNcNCA==
X-Received: by 2002:a5d:45d0:: with SMTP id b16mr11121188wrs.86.1543785822565;
        Sun, 02 Dec 2018 13:23:42 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id d2sm9551043wrs.97.2018.12.02.13.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 13:23:42 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [RFC PATCH 07/10] dt-bindigs: sound: Add Allwinner suniv F1C100s Audio Codec
Date:   Mon,  3 Dec 2018 00:23:14 +0300
Message-Id: <d0ce4b1f2a89a319d6becb5f88d7ca4184aa5595.1543782328.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543782328.git.mesihkilinc@gmail.com>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Allwinner suniv F1C100s audio codec.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 Documentation/devicetree/bindings/sound/sun4i-codec.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-codec.txt b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
index 66579bb..9778bc1 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-codec.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
@@ -8,6 +8,7 @@ Required properties:
 		- "allwinner,sun8i-a23-codec"
 		- "allwinner,sun8i-h3-codec"
 		- "allwinner,sun8i-v3s-codec"
+		- "allwinner,suniv-f1c100s-codec"
 - reg: must contain the registers location and length
 - interrupts: must contain the codec interrupt
 - dmas: DMA channels for tx and rx dma. See the DMA client binding,
@@ -27,6 +28,7 @@ Required properties for the following compatibles:
 		- "allwinner,sun8i-a23-codec"
 		- "allwinner,sun8i-h3-codec"
 		- "allwinner,sun8i-v3s-codec"
+		- "allwinner,suniv-f1c100s-codec"
 - resets: phandle to the reset control for this device
 - allwinner,audio-routing: A list of the connections between audio components.
 			   Each entry is a pair of strings, the first being the
@@ -41,6 +43,7 @@ Required properties for the following compatibles:
 			   "MIC1"
 			   "MIC2"	(not on sun8i-v3s)
 			   "MIC3"	(sun6i-a31 only)
+			   "MIC"	(suniv-f1c100s only)
 
 			   Microphone biases from the SoC:
 			   "HBIAS"
@@ -51,6 +54,8 @@ Required properties for the following compatibles:
 			   "Headset Mic"
 			   "Line In"
 			   "Line Out"
+			   "Right FM In"	(suniv-f1c100s only)
+			   "Left FM In"		(suniv-f1c100s only)
 			   "Mic"
 			   "Speaker"
 
-- 
2.7.4


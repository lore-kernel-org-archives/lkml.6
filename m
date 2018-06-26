Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21CDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA90C216C1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rmJX3ACr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA90C216C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935308AbeFZMOA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:14:00 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42885 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933814AbeFZMLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:11:36 -0400
Received: by mail-wr0-f196.google.com with SMTP id p1-v6so1413544wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 05:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kmk5GqCZw2LAuiM5nkGX+ZyZtn47eBm/kJTs/oNEV2E=;
        b=rmJX3ACrRfmhZeXV5htDWFS9S3CC5SrX01ixUK92lEvXRGB8XfuA9sgp6rcoPV5h4Y
         AtW/i4cbaZjU6XeP99zbsdWxDxut2V0LUsIPUTkHzlgvUNzm2egH1aO6omJrFCQwEdSh
         COGCMFWvg7iirk4Pm5L53aKedvW1yuT9LUz3EYlUDizZfXzO99vas7DFzUNxIJ3F27T0
         JXFcICpXpImux67xlMeeK5nkbqbUG6vy1rt77xKGvCm4ZOfpBuB2mAf1fksigwIHeHw4
         kSAy+6qRhR4snRpLuVBjQCvcbPVi1Q5wKgjwEUKppsEopOuvl32YW9STGcWkMUdBoybY
         UFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kmk5GqCZw2LAuiM5nkGX+ZyZtn47eBm/kJTs/oNEV2E=;
        b=ixe4RRhPE+q8P3hAtyMuVoAPKJ4ItJ+YLVPYthUJeIkV9WAkGoXOCoAmwRi3eBPBFI
         dRDPZVfW7GaugJaktmEmmuf+hQu+3lPvWChPzDmoDBmoexL7mVY6nFggM/pxvXiCX2F9
         F56LtUAIcj1pACs3p5c1Yx+BBIPBdEsjHUjUV/PkutuVo/UOD7YIknosNun4gFifEyIe
         c6h/qEWg1WyJ82LV2Ilb5LQcZglpw51vKeoL8WueNRT+P1LSKlG3/cHEi8MsMuYwLB+B
         Z7WLDefCdpZkX6RENe/+ijZB6g+kQgJhp7Of8nNnuRAUkz6Of3bWer+kKelYPG21Y8xy
         DDDw==
X-Gm-Message-State: APt69E13PTdFOmg+BrMjJhecFm+e9mFwDqF+/OAuMo7KePZiepxn/i5S
        VAddfvGPMYjZJsdCqD/r0Lx3gg==
X-Google-Smtp-Source: AAOMgpdhD5ztQZrknBry4uaPlkn1Hz+Oiql9BfRqLSmNRMY8nUmxb3D1yJW4yOF4SxOCLThN/slWDA==
X-Received: by 2002:adf:ef50:: with SMTP id c16-v6mr1225940wrp.182.1530015094919;
        Tue, 26 Jun 2018 05:11:34 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l15-v6sm1917865wrs.95.2018.06.26.05.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 05:11:34 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 1/3] ASoC: simple-amplifier: remame dio2125 documentation
Date:   Tue, 26 Jun 2018 14:11:26 +0200
Message-Id: <20180626121128.28564-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180626121128.28564-1-jbrunet@baylibre.com>
References: <20180626121128.28564-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dio2125 is simple enough that we can make it a generic component.
Rename the the dio2125 documentation to simple-amplifier to
prepare this change.

Suggested-by: Nicolò Veronese <nicveronese@gmail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/sound/dioo,dio2125.txt     | 12 ------------
 Documentation/devicetree/bindings/sound/simple-amplifier.txt | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/dioo,dio2125.txt
 create mode 100644 Documentation/devicetree/bindings/sound/simple-amplifier.txt

diff --git a/Documentation/devicetree/bindings/sound/dioo,dio2125.txt b/Documentation/devicetree/bindings/sound/dioo,dio2125.txt
deleted file mode 100644
index 63dbfe0f11d0..000000000000
--- a/Documentation/devicetree/bindings/sound/dioo,dio2125.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-DIO2125 Audio Driver
-
-Required properties:
-- compatible : "dioo,dio2125"
-- enable-gpios : the gpio connected to the enable pin of the dio2125
-
-Example:
-
-amp: analog-amplifier {
-	compatible = "dioo,dio2125";
-	enable-gpios = <&gpio GPIOH_3 0>;
-};
diff --git a/Documentation/devicetree/bindings/sound/simple-amplifier.txt b/Documentation/devicetree/bindings/sound/simple-amplifier.txt
new file mode 100644
index 000000000000..8647edae7af0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/simple-amplifier.txt
@@ -0,0 +1,12 @@
+Simple Amplifier Audio Driver
+
+Required properties:
+- compatible : "dioo,dio2125" or "simple-audio-amplifier"
+- enable-gpios : the gpio connected to the enable pin of the simple amplifier
+
+Example:
+
+amp: analog-amplifier {
+	compatible = "simple-audio-amplifier";
+	enable-gpios = <&gpio GPIOH_3 0>;
+};
-- 
2.14.4


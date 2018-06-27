Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A986EC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640E72571D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrULsVi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640E72571D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754816AbeF0RPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:15:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41906 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965911AbeF0RMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:12:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id v12-v6so2232491ljj.8;
        Wed, 27 Jun 2018 10:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FfkN2BRmaFMo/wJvnoikyZaoLnqmd1IN7BL7KjnftSU=;
        b=VrULsVi72g9bOoDa/rGkGcSbG7IZbQFlVzmH3IrYCAiV3StIWe7UdIS58MYz4v6eTX
         qV9LmKhbqpiVSYcXdWMs6iZFcyGhFsFHtCmjy5KJ2rr1Jzm5M+ycBaJXjmCGyU8zoK6u
         7DPevBBbOg2VgLaBOeZPMJTsM1o4SotJV1igSrAruiWIFHxTyeQQEP+cDKPyM9cUEQlA
         wYp1CQ7vHn/9SLLoxYCM7jHbFLTAaWGQ1gzlUDC2X+S2wPSKSgk8pQv7GOfUvpJwjfg+
         7gupr1v3M5BWB87kkedbCyBd2zr4TFNkC1/s1apeY9Wb56IMs5A9E7RsGX3BAkpUe7Zm
         MmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FfkN2BRmaFMo/wJvnoikyZaoLnqmd1IN7BL7KjnftSU=;
        b=F3tuZo6UHWKroRlX801yaH1D/3yEXBiAR2xPBC3RYtUihSyCEy3U6u3gqiZWZIF4j3
         G25wKThXPPbWHK5ElJJ9jRtPj17QcxS8/+wFT2WoAiAsKZx3rL2jx/hxz5DXY/MjWDbd
         CGwNy9gS181mWUwt0usiY6w9vyDlAFZNu5NHPSWkkaI/A6NHeny72OH0tWF9Rdi8qTqs
         JNd+s9IE6xwkV6HpmRrxGnLY5S5nu5ia+GrKm/Mk/DDHqJTnInWNAodzpFQp416fUfZy
         j4gMjq0TwaFXGZglxEa+cBRP2r4f6CCa0MvYSjZ+Eo3lbajOswbJ7hudOcwlay+osgb2
         8MDQ==
X-Gm-Message-State: APt69E1fJnxcq+GXc98Grx6YF4CVAjpSZszk5Yb0Tx7F76Lpa/yGqVpL
        wBN3+8KF7UFRROxveZDwvns=
X-Google-Smtp-Source: AAOMgpcBx9P45Vi6WDkaFnOscSSpC7uEqVoNLugXZgRF61eGhWBFxi9tjhEhyGxMfHQLkl7xlv5GOw==
X-Received: by 2002:a2e:9809:: with SMTP id a9-v6mr4628841ljj.143.1530119558306;
        Wed, 27 Jun 2018 10:12:38 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id n9-v6sm929344lfb.7.2018.06.27.10.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jun 2018 10:12:37 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v2 01/10] ARM: dts: s5pv210: Add missing interrupt-controller property to gph2
Date:   Wed, 27 Jun 2018 19:12:15 +0200
Message-Id: <1530119544-30023-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds missing interrupt-controller property to gph2 block,
to silence following warnings during build
  /soc/pinctrl@e0200000/gph2: Missing interrupt-controller or interrupt-map property

It's reguired by Samsung aries boards, an S5PV210 based
Samsung Galaxy S (i9000) and Galaxy S 4G phones, which are added in next patches.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
index 3a79feab11c3..7f0c9d447871 100644
--- a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
@@ -258,6 +258,8 @@
 	gph2: gph2 {
 		gpio-controller;
 		#gpio-cells = <2>;
+
+		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-- 
2.7.4


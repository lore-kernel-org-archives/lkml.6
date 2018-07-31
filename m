Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7F5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48F9208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGeJgwkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48F9208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbeGaLCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:02:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46276 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbeGaLC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:02:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id h14-v6so15853970wrw.13;
        Tue, 31 Jul 2018 02:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TTXfINDZ2ZqQ+bpQKY5udYNqHsQFXpgqngZPHFTTxgk=;
        b=BGeJgwknGPSAB8GPYfgnt3PZrH8wPsQfs0f0QSUSajfLIl/txGRWEIFJdhJ4M5b+ZI
         rmg+9Q8CP7v+PeV4JJ6lLG203ZNc0avSl6ZwjTWNTPs0HLIFFfO3GQjBTGV2Jbqu6wt1
         WpGtXplGDaZX5j22opqvuLKogiYZSOZR1r1wodbCBADs+5A4tyktjEYrEoHOce2+TXLT
         fdGof/qDlSNe2Ccq8KnnEMc2er0H1uW2CxxVeq3wy025Bn48OjCXzuhcWnJosE9aQyrV
         ZsTsPKXQ9A+7qTHJ7whjTRFEA6jHKoODZPiTp+IkGGWrSam+zfocZVouoXuM7/OyKNZ1
         CqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TTXfINDZ2ZqQ+bpQKY5udYNqHsQFXpgqngZPHFTTxgk=;
        b=L+zMAdlvEUfgaceEZyguBHvqrrMugpeATg7rrYfimW0ZJZyuWwu2YcpWvwnkm42EJX
         LAT/ZltIcAbysF6i7s49wv2CbTYJHFJXsO3N1a8Y8P2yYGUFjzU1fiM/BOSW21FR8QBK
         hzrWg6zP3Avb2VuTKgvNW3WG2eGhVAJFCvbkkcZ9jboNunswJ0VqXRoOFhrwLU01Pmti
         JxvTWmvmwXfPShANuMc+fJ9oEI6wNo4OOLwBMlBtBVVkUOA+oxwjkDM7S2CinpOhbfZb
         sLFDidYH/lF9bet4+xXppdsWKzLxUnmVcHCZXe1cTqeBluuM/8mwEqlUHuddOp93AjNX
         aKxA==
X-Gm-Message-State: AOUpUlFqsmOPfHGiP5S2CiCTMPsZjxMPAgjwjOjziUpOj7OvyPCkkOLn
        lGdIiU8kR47f+yoGDD2ylxtViuZL
X-Google-Smtp-Source: AAOMgpdKT3XOlB/fA7Jl29tiFUn6lcSLFnO1kqhKDYH4UdLNNwqEDInGnMtrc9IqbsLYP0wgMVnN8w==
X-Received: by 2002:adf:f790:: with SMTP id q16-v6mr12824550wrp.86.1533028983707;
        Tue, 31 Jul 2018 02:23:03 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id y191-v6sm1670873wmy.4.2018.07.31.02.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 02:23:03 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org,
        linux@armlinux.org.uk, sean@mess.org, p.zabel@pengutronix.de,
        andi.shyti@samsung.com
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v6 4/4] ARM: dts: sun8i: h3-h5: ir register size should be the whole memory block
Date:   Tue, 31 Jul 2018 11:22:58 +0200
Message-Id: <20180731092258.2279-5-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180731092258.2279-1-embed3d@gmail.com>
References: <20180731092258.2279-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of the register should be the size of the whole memory block,
not just the registers, that are needed.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index c3bff1105e5d..2f4d93de836e 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -818,7 +818,7 @@
 			clock-names = "apb", "ir";
 			resets = <&r_ccu RST_APB0_IR>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-			reg = <0x01f02000 0x40>;
+			reg = <0x01f02000 0x400>;
 			status = "disabled";
 		};
 
-- 
2.11.0


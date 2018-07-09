Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE42C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB08620854
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIXNFI/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB08620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754446AbeGIJne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:43:34 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38140 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932699AbeGIJnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:43:21 -0400
Received: by mail-lf0-f66.google.com with SMTP id a4-v6so14686497lff.5;
        Mon, 09 Jul 2018 02:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1koQvgLpOHKSo2UbGrEiF0QLYvVVtdV9mxihlxpb/Nw=;
        b=dIXNFI/z+xlQuMy7LKtYylJ4lEM7z2Iy7LOAKH9+KgV3iFAmWPVSaD1wC+cWW9F4qK
         TfPmBLRngm+CULDO/pwAva1Uh3C/86/q4Q1sNGRvLQfxyzSIFJPK/vBcQTnGxC2uirxv
         cgipnJEfZYynpUQxfV1yqgDJXDf/KOXThZj07ndoB9TUVqHcDHJS7Oj0vaSgNutmXWQv
         qayxOO3cKQHxLPoLzEqMcSIkv1rbVoYIoRHU3yz661TGl+hTCxQWGD+CQLGr5vULmJN3
         NgT2eGRzxCf62pjQri8MrXJxm9g+kLi0Wk9wGSF4lZjOQj5JHGcGc7Crikia93nayA6S
         gaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=1koQvgLpOHKSo2UbGrEiF0QLYvVVtdV9mxihlxpb/Nw=;
        b=C+CrZcyYjrOLsTudI5CGS11CayjaR5JZubaiKxSH0JtozwQC6N7tR87oaWZHdHNGKl
         m23qCYK3Pt2FpfIJ0ScNmDvDjYDmgSsygg9gH9B/Dq/Nin257VApId4FWRBHT36zd9+X
         grQCYv88jGmWS/QMZAFZKhaG8YaoZlsLuxdc2m+jQWgkiILTVpZhFIQC+p55PZkrx/8m
         CoNx4CX6RE2UbB40B/dXCU7y39YrnZYLL4442F4pzZW9LYgioBOVnMYUgpOTs1tM9C8e
         C8wAUvcsAsBV9ChyLyU9nYLy5bVdo31XBGXCIz9rhTTlMOJEqlbJHk/naGgzWZHb0EcI
         O5Xw==
X-Gm-Message-State: APt69E0qvUuOw0HE3sZq2E8ZRivwfYOGVg9duay308NTalVUWLx5ulnt
        Tak9JUSpmdqyvdbyRcHTZRQ4fukTTvE=
X-Google-Smtp-Source: AAOMgpcfJgib2kY0uvp14/OTB54wyBGroPzAACsvRISUpRshtNAyqsMW7STi5yxvKaKHdPr5BZ9Fdg==
X-Received: by 2002:a19:ef13:: with SMTP id n19-v6mr14571206lfh.48.1531129399648;
        Mon, 09 Jul 2018 02:43:19 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id q6-v6sm3396357lfk.31.2018.07.09.02.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 02:43:19 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yuan Yao <yao.yuan@freescale.com>,
        Esben Haabendal <eha@deif.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] arm: dts: ls1021a: Enable I2C DMA support
Date:   Mon,  9 Jul 2018 11:43:04 +0200
Message-Id: <20180709094304.8814-5-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709094304.8814-1-esben.haabendal@gmail.com>
References: <20180709094304.8814-1-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

Gives substantial performance improvement for transfers larger than 16
bytes (DMA_THRESHOLD).  Smaller transfers are unaffected.

Signed-off-by: Esben Haabendal <eha@deif.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c55d479971cc..1e5640701c65 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -363,6 +363,8 @@
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen 4 1>;
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 39>, <&edma0 1 38>;
 			status = "disabled";
 		};
 
@@ -374,6 +376,8 @@
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen 4 1>;
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 37>, <&edma0 1 36>;
 			status = "disabled";
 		};
 
@@ -385,6 +389,8 @@
 			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen 4 1>;
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 35>, <&edma0 1 34>;
 			status = "disabled";
 		};
 
-- 
2.18.0


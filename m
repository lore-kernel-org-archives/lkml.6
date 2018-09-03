Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21097C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05DC20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1X5KvpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05DC20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeICOVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:21:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41249 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeICOVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:21:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id z96-v6so6618wrb.8;
        Mon, 03 Sep 2018 03:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yco3GuOwe1ADSho8sukxLRIOHQlCReJ4bgpdQLYejFc=;
        b=J1X5KvpQE8zgQgmc2/vQAmiKvPlYH1gGdMjr9Zuw9Y4Dos/aMtoSMHUNUhFqFXqeGd
         T3F8YIahgkY940DbwdulOsuINGsKtknyxXi1kvQpljEe4rM7fat35dAT+SWAt8J9vV3s
         7KVWYEmTaWvqHrjvfPUcKYav5YtxbOqh7/w+qM3qI4U6VrnLNjJsgzr95uDgM2KQJ6k0
         cnlooSaxrl5xHSkxW1DnZ73wVmzOjRbFWDo00o53FjBpoNaTQjix3YcAuGYbzqZZKtgn
         O7JBlpXiDHNSvGp+kmub0iow0Oi3DckfbwIeZxwSqJVqHMXDPObNVbpbl3azYMdcCA0h
         4bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yco3GuOwe1ADSho8sukxLRIOHQlCReJ4bgpdQLYejFc=;
        b=lLDnnboDMgh1ilM5L8NV7vmfpHxsxpbG5jAk3NJdUs69/AN9IjwNlKxfqJrSf7oICr
         7PQbkIvJyHAQDX0GVv/61vEVEAuqLaxAuVMLARKGwlrlOeXE6y+7khQTjdO/hxpcgP0m
         szdt/SPalMYExt2gK4CElCa9lfRI2vBSeE12ZImdzbCa7tsmnMU+TmnnQC0MGC0JBNU6
         c/8BFxqswHXZ3YwxDl/vU/vRWMhgCaFCg3UXpF8aFkay1HOZ0bpvcp773JhZvQu1ecW4
         RnRNM4gbqkOOvhZjWAo+kyUkhd05Jr/vwSiYKnU6h92AgPhvhnI9VL3VSRrV1UmDmQ4I
         df4g==
X-Gm-Message-State: APzg51DEmcW0MEO7REU+Kw1sLClslTEQOy7UpTonoc6DuV88pHGBrMsF
        LEeHVz5KTgnPMAIRor2YkGE=
X-Google-Smtp-Source: ANB0VdYcw7DcZk2D5RcjweU2/i4DeLxR20feymZy2BW1uejbAnCva4EEXUo8FY/IQzBQh93UZ3UD+w==
X-Received: by 2002:adf:e084:: with SMTP id c4-v6mr17993852wri.199.1535968938709;
        Mon, 03 Sep 2018 03:02:18 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id k34-v6sm31773936wre.18.2018.09.03.03.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 03:02:17 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v5 9/9] ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable AHCI
Date:   Mon,  3 Sep 2018 12:02:01 +0200
Message-Id: <20180903100201.23131-10-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enable the AHCI controller.
Since this controller need two regulator, this patch add them.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index a891a387e8f1..438b7b44dab3 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -105,6 +105,12 @@
 	};
 };
 
+&ahci {
+	ahci-supply = <&reg_dldo4>;
+	phy-supply = <&reg_eldo3>;
+	status = "okay";
+};
+
 &de {
 	status = "okay";
 };
@@ -250,6 +256,18 @@
 	regulator-name = "vcc-wifi";
 };
 
+&reg_dldo4 {
+	regulator-min-microvolt = <2500000>;
+	regulator-max-microvolt = <2500000>;
+	regulator-name = "vdd2v5-sata";
+};
+
+&reg_eldo3 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "vdd1v2-sata";
+};
+
 &tcon_tv0 {
 	status = "okay";
 };
-- 
2.16.4


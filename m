Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AB9C64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D319E20868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bFYDW4/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D319E20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeLHRNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:13:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41746 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeLHRNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:13:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so6567782wrs.8;
        Sat, 08 Dec 2018 09:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wE0/E2Ken/bZjZgqEBLKchV5gfKl45yizVk0lLCEPOs=;
        b=bFYDW4/+8qDr+Bip/V11Jwndu28XVzccbPCpr+vtpQoQDzgKVA5h2ASNaGIc/Xy5bU
         rEkFhrGBWFpHJniTJp+GeAu+pDR837+hlguWDroP33S2YFm7e579riGz2kE/TX1m6HAD
         ivNFz0B+0WHy8S2HGN5UCq/Ede0YH32A2HeM68HfdCEEmSYC/8x369WYlrZqLH9hpmJI
         FNy+5WkBGLBAWyFsr4cSv1amXRi4mjCMMVPvx76w761BTrV/Fkf54AOcdloCtsmBZek1
         MI7ADon2mTX5QUKhGeTml3xcCax241ftqcgFNci7Z5B178zurVUf+r5OMRy89hR6dIF5
         Vghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wE0/E2Ken/bZjZgqEBLKchV5gfKl45yizVk0lLCEPOs=;
        b=mSckkJjlEzqqJh6eUuS101tFzJ2cSagBGWgfHAxo/4aFyBoDJMD6StFjk4cDZhrNYR
         JsH9JB0qOq9Sw1Mx01gnhjBIT5Y10j95T7q1ksBJ6AsyX7UOv8LEDXLTH3AsoAI5Hmcg
         q+LtyFiqWFjC1/Ty8Bzl9TxOHihlb4SkIiic4I8NAA/JCJcvL0BziH5ubh6rFw/SSm1x
         gh4DpSWJ3kOkJ1eHWewFT77v0X/SqTxt6JOg/dHztfMDSdGK88XZ/QS71olOmwJlfU6I
         yCk1a5AC7gnWyCD2+HNp67R6xp3snAMBjpuL6iui1Svvqf+nkF9M93kumVJs0vWSzJlg
         Y80w==
X-Gm-Message-State: AA+aEWYzL7gU7GA0fBJO02b38AaPIrV14CBfBbUVo/g9s1V6BfJuJAdi
        sVYPfr9Ewat8qmo9igRodCY=
X-Google-Smtp-Source: AFSGD/UCvJtMpsBdOmw/IIGPc9vZGR1+kvdrBDqJh4CEi+4FkgHICerDNNgruq8QjwkRk7urzAP1UA==
X-Received: by 2002:adf:ec11:: with SMTP id x17mr5245724wrn.88.1544289189691;
        Sat, 08 Dec 2018 09:13:09 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id r12sm4995851wrq.3.2018.12.08.09.13.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 09:13:09 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com,
        khilman@baylibre.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sboyd@kernel.org, mturquette@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/5] dt-bindings: gpu: mali-utgard: add Amlogic Meson8 and Meson8b compatible
Date:   Sat,  8 Dec 2018 18:12:43 +0100
Message-Id: <20181208171247.22238-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208171247.22238-1-martin.blumenstingl@googlemail.com>
References: <20181208171247.22238-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for the Mali-450 GPU on Amlogic Meson8 and
Meson8b SoCs. Meson8 uses an "MP6" variant with six pixel processors
while Meson8b (as cost-reduced SoC) uses an "MP2" variant with two pixel
processors. Both have a reset line to bring the GPU into a well-defined
state.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
index 63cd91176a68..efa1077a90cb 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
@@ -12,6 +12,8 @@ Required properties:
       + allwinner,sun7i-a20-mali
       + allwinner,sun8i-h3-mali
       + allwinner,sun50i-h5-mali
+      + amlogic,meson8-mali
+      + amlogic,meson8b-mali
       + amlogic,meson-gxbb-mali
       + amlogic,meson-gxl-mali
       + rockchip,rk3036-mali
@@ -77,6 +79,10 @@ to specify one more vendor-specific compatible, among:
     Required properties:
       * resets: phandle to the reset line for the GPU
 
+  - amlogic,meson8-mali and amlogic,meson8b-mali
+    Required properties:
+      * resets: phandle to the reset line for the GPU
+
   - Rockchip variants:
     Required properties:
       * resets: phandle to the reset line for the GPU
-- 
2.19.2


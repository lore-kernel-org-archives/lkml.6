Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF38C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979FC208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="h6uT/sjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979FC208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389423AbeKPTvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:51:19 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35385 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbeKPTvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 14:51:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id t15-v6so20549924wmt.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 01:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VhrsNFD+e9chNyIzaJLgBTnb8Z4z8WMz0KpzTlhbRZc=;
        b=h6uT/sjFLlMURPNFdF64zDs4mbNtNt6u9Whr1f6LsJiDVxfAugkKNHBExqFkBPdIFH
         f5b1Swt+xAadnFJK2ElbNShK4EG4cmLPp+C8iF/d80kWn9bwiCWQWkFNkmPsY95+zdwP
         Jt+oNKtTln4HCZN3Oine85LPiN/4Rw2ERdNaagocUWicyyLYfsIoQyOM7CtxGivIQ3q1
         5CYO4xNg7fZ2FeAnXFnSmANX1mT8ngJ95E8UdArTALntL+7gql8ahlc2mGyXE1wOugm+
         bLwfnwhbE5WTW6vnauB1De0jE8rCd091fgRuVsitgNSHX2sHIZhv2S9wVNYVPOoeKEww
         VBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VhrsNFD+e9chNyIzaJLgBTnb8Z4z8WMz0KpzTlhbRZc=;
        b=Fz+Z5fdaG8B9w+9jSGJoRd7eq1WiVv7JGx+c1BOP3fRk+JFxr1hk81JBXfXAfSx9up
         EmM4C5W1nwUFZkzfYxC4x9NFqQbVRjOh3K+vm8qAFCITzpn9T6LUSZEcNmy4uD0nbQeX
         2hnNAWTKT3ft2S6PFmRbfjGPrpI8gHfdfvy8pLDkmoM4SCu4/FVVrbec+8JqNh7h6Ojx
         rBScj3++U6sNEvf653FWhm4YZ3SiAo0q0r9TycU98TqRzKBmLVzek3XxHb1ff/u87NpT
         kbVoXNfft7Vb1D8H7nI9RAHsmYoqK1zVhOt20jFMpNHk5AtULt/2S5UReo5Qas4iXr1S
         arLQ==
X-Gm-Message-State: AGRZ1gLNczoxNENYEZIKft3X7DCAi/vE/YYP0WxG7pfNCfyAEYuJJGOF
        wtnLtNfDMAQbrNjr48eDEMOkaAIqqEv4MQ==
X-Google-Smtp-Source: AJdET5fSwjHO1iGUx4RGwtqOiVGaZwVnI2Jd+jKqBfi1s/Gj9gzew+0vgwn/sr/YIFvry67xEampuA==
X-Received: by 2002:a1c:9f01:: with SMTP id i1-v6mr7891311wme.8.1542361185977;
        Fri, 16 Nov 2018 01:39:45 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id o15sm12760780wrp.12.2018.11.16.01.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 01:39:45 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: amlogic: add libretech aml-s805x-ac bindings
Date:   Fri, 16 Nov 2018 10:39:37 +0100
Message-Id: <20181116093938.26373-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116093938.26373-1-jbrunet@baylibre.com>
References: <20181116093938.26373-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Libretech aml-s805x-ac board, aka 'La Frite'.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 4498292b833d..203d38e5e271 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -93,6 +93,7 @@ Board compatible values (alphabetically, grouped by SoC):
   - "amlogic,p231" (Meson gxl s905d)
 
   - "amlogic,p241" (Meson gxl s805x)
+  - "libretech,aml-s805x-ac" (Meson gxl s805x)
 
   - "amlogic,p281" (Meson gxl s905w)
   - "oranth,tx3-mini" (Meson gxl s905w)
-- 
2.19.1


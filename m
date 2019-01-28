Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFB5C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D982148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TIBNIqQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfA1RgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:36:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54628 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbfA1PzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so14538555wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 07:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=quTvH/8HwdVKlU+wlhb7sd6WX/yxeEDN3CSJOW9W6jU=;
        b=TIBNIqQ+69+2A1i7ampbm8QrDAl3gLCvK9p0kFPr3ofwWum9/xG6XA5qgolMEdaJhk
         SCkFwqV7tCpbqEBVcAY+OaqXXGHDEn2K/FgibRIx8WR2FKirLpY77lTAxBAMuijVFlXf
         dkQZRZ9VP7G6HnBAA+Ayxw7bbOLy/xUtBG6sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=quTvH/8HwdVKlU+wlhb7sd6WX/yxeEDN3CSJOW9W6jU=;
        b=syH4Kb/CkjwkLODAhoP65KP8ItZ0z60jETXB8BhgUsknG3hS1cJe50m7/gi3Ws0MrS
         sHtFhNp93luZd9EZ+NGBxc4SJwRkuu/NOXAOWqbMQscBMPDRZ7v2HcfBrK8rM+vOHCtW
         uzsUoVgUymo8mwWu0i49cVJSsZQ/a/y59gAcSwKTt5KsaSriM1DZ+kFDPmmj0Amu3tTD
         NHCU+z8lb9yAEtInlPEo16HPeAxEn3R/77cUwijXqgHx88ZbcrWUWZT9vue+0oXqrSnZ
         rDMD1WvN91UKNgk0lUqF8k8pium73ITHrHM3jhorhhel3zWa2PnJlLbBoCNGQ8JZK/T1
         Utdg==
X-Gm-Message-State: AJcUukfFHmNHkTA+Vc3Is3ALrbyzVOxtOC/hrEtZlZqdEzFxa+c+Wb0V
        f2OQNk/bZsvl5T2tvjh0RAY7OA==
X-Google-Smtp-Source: ALg8bN7RfzBVxmyxCvpaLKfloMhK2qUj0FlYgdsNZGZ5YfHMe+M/vnwZw13E/jhETV4EAa36rhxE+Q==
X-Received: by 2002:a1c:2088:: with SMTP id g130mr17284229wmg.122.1548690914001;
        Mon, 28 Jan 2019 07:55:14 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p6sm145140485wrx.50.2019.01.28.07.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 07:55:13 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] dt-bindings: imx-ocotp: Add i.MX6ULL/ULZ support
Date:   Mon, 28 Jan 2019 15:54:58 +0000
Message-Id: <20190128155506.25566-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128155506.25566-1-srinivas.kandagatla@linaro.org>
References: <20190128155506.25566-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

Since the i.MX6ULL/ULZ only supports 8 OTP banks we need to introduce a new
compatible.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
index ff389cf1606e..7a999a135e56 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
@@ -1,7 +1,7 @@
 Freescale i.MX6 On-Chip OTP Controller (OCOTP) device tree bindings
 
 This binding represents the on-chip eFuse OTP controller found on
-i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL and i.MX6SLL SoCs.
+i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ and i.MX6SLL SoCs.
 
 Required properties:
 - compatible: should be one of
@@ -9,6 +9,7 @@ Required properties:
 	"fsl,imx6sl-ocotp" (i.MX6SL), or
 	"fsl,imx6sx-ocotp" (i.MX6SX),
 	"fsl,imx6ul-ocotp" (i.MX6UL),
+	"fsl,imx6ull-ocotp" (i.MX6ULL/ULZ),
 	"fsl,imx7d-ocotp" (i.MX7D/S),
 	"fsl,imx6sll-ocotp" (i.MX6SLL),
 	"fsl,imx7ulp-ocotp" (i.MX7ULP),
-- 
2.20.1


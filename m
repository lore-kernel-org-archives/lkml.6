Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA927C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE3320851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0E6lQZS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfAQKXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:23:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33065 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfAQKX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:23:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so683614wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 02:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=arU82ZeX78CY4qS47DMaU2XgnlqLaod0sJ3wwiKXdJQ=;
        b=0E6lQZS9zPkUt5xcP+4AMSa1H4NYJRIuU4bWqFMTzdbvL+uRMYXfuhwHxOIGyja/u1
         0LiFUR2AM06a0Vnf9p6n1HwdZdxDOV15xV8f//fuc1jIVx8bcl0vpDbmGpDru/NtBu4h
         ivi6ZDNvISNA/Vm6BJBuvtPxiKjx8LNkbijxrby0qTkY6UDJY+XYg4E3np27WWdJfVqE
         Wp9q3ln9vEQpZXxjN58sUJCTJCvMaLFcDey/nsptyfPsxOdERxu+Aw63B9t9L7R02adf
         u8UM0O4GXVK56hn0aogtwTQOje6YdQrsvIcFPiyu8M82BeR7UaadCCXkmh5iswDy7eEK
         cYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=arU82ZeX78CY4qS47DMaU2XgnlqLaod0sJ3wwiKXdJQ=;
        b=fB14+ZjqFllGv6twha7m2/q8MGhVOgbtCllMsGrAdCcKiAKKv32nezMjc7MsFjYoRZ
         JGSF33Rb3cW3fAE9zlj6hwC7SVg97JY7P83ixe1oB3fR/rrgmtUbkUUSteMmodwEweYI
         ojffuVI1u3jFDL4r5ym5Ni/NrF1hSbxNkRAiEYEJ6AFlAY1SGSFOCsMJavGEoJlMTFRn
         G/VvFyb3iyZHAn9lMXGeIPb9xe+EEeD+d3LLrUSt65eUnNPsbk3OdctwTqVwLgZsBBLH
         4OiH4Deq3b9jaSy7MRSagTYn2wZrQ34ZFOQ0rLgehH31FcZ/1fn6p8c88i2Zjw3giqec
         ORYw==
X-Gm-Message-State: AJcUukcKT7JzSlNQGPfD/5FZM6JGiAdtRMWJRe7wl/Z+SwJrMBQBPEdE
        TkP+SWjvGBedg3GzRcQ6pzFwLA==
X-Google-Smtp-Source: ALg8bN6+r6UxGkve+2SVzOFUokDcQ6JsEowB8X71IJ2tKx2zjB42OXexglSwjfpg1+jJT/u1rBsqcg==
X-Received: by 2002:a7b:cb18:: with SMTP id u24mr10685287wmj.138.1547720604286;
        Thu, 17 Jan 2019 02:23:24 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id u10sm66400530wrr.33.2019.01.17.02.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 02:23:23 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: pinctrl: meson: update register descriptions
Date:   Thu, 17 Jan 2019 11:23:13 +0100
Message-Id: <20190117102315.1833-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117102315.1833-1-jbrunet@baylibre.com>
References: <20190117102315.1833-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

like pull-enable, pull should be optional has this region is available on
every controllers. Also, the g12a feature a new region "ds" for the
drive-strength

All this region thing is one big mess. I suspect that there is only one
big GPIO region with holes in it. All registers between the current
regions reads '0' so it is probably just spare space to handle more pins.

Since we need to continue to handle the existing controllers, switching to
one single region now would not simplify things. However, if more
organisation layouts and features keep on being added, we may have to look
at this again

Fixes: 3cd3c83f6752 ("pinctrl: Add compatibles for Amlogic Meson G12A pin controllers")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/pinctrl/meson,pinctrl.txt      | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
index 82ead40311f6..a47dd990a8d3 100644
--- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
@@ -23,11 +23,11 @@ The GPIO bank for the controller is represented as a sub-node and it acts as a
 GPIO controller.
 
 Required properties for sub-nodes are:
- - reg: should contain address and size for mux, pull-enable, pull and
-   gpio register sets
- - reg-names: an array of strings describing the "reg" entries. Must
-   contain "mux", "pull" and "gpio". "pull-enable" is optional and
-   when it is missing the "pull" registers are used instead
+ - reg: should contain a list of address and size, one tuple for each entry
+   in reg-names.
+ - reg-names: an array of strings describing the "reg" entries.
+   Must contain "mux" and "gpio".
+   May contain "pull", "pull-enable" and "ds" when appropriate.
  - gpio-controller: identifies the node as a gpio controller
  - #gpio-cells: must be 2
 
-- 
2.20.1


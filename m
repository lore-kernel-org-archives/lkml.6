Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F072BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDED721726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XX85W9JM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbfAXUAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:00:24 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35187 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731740AbfAXUAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:00:23 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so3389808plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gRegVC+JR56IFWmVyKDLRuzzRXdOa660M3yO267QTPA=;
        b=XX85W9JM3QzoUOQIUKI7V8K9T+EZDaVppVDplpV+yN1RPAMtaDZrW/AyjORDOjI8R2
         oeVCvGNdLCTdca/8je/awH7tFatX6ja4JUCYXSCk0A7RlqPgtsbBRY2O68UN/0AVVcNl
         boDqEEXIrUS6d884VQIkLDAhxC0fi+LAMUjMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gRegVC+JR56IFWmVyKDLRuzzRXdOa660M3yO267QTPA=;
        b=It3pNiJd9AZLICqs6Fot/9gGqlTmQrZ9Qg6XSrR2n5q9i8rK+gZ8Sk9fr0WE9SE8YT
         hUlNPIS6UUJTbEutaKV837xpnu5eZuD0weYWOp7YrSCVla3lx1fspMzERIZgQWjLzb/e
         w+yBXdRJjmGdncVIIFVfeSHUzjMdCJdw/REtjO6v1THPtQp9Wx5CyLLh95R68NkjFNif
         PiR565sk9/o79wH0eBCkr+aGER9p2cTkziULT48j799/826wbl2yFXYqXGRpmU+EN3/7
         NRhBrF3G31BmTeljN6uUdcpOKiAvP56ylsBvT4oc4ybj7BmHOH/ypz04k0XfCfEXQD2C
         u51Q==
X-Gm-Message-State: AJcUukf6YSz6V+7a4y1FjLMXExAGOlZqpWhfGBFqjPfGzxFw69HnEXAV
        TOrfzEv1R9OXOTmx01dLS9jN+Q==
X-Google-Smtp-Source: ALg8bN7GxiLQI9M5eT3P6PNQeyDSKSr75K/UljM/ECi4BQLWX9qt+fR+VTx5SODUcxnpR82iuSKXHg==
X-Received: by 2002:a17:902:584:: with SMTP id f4mr8117719plf.28.1548360022788;
        Thu, 24 Jan 2019 12:00:22 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.12.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 12:00:22 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 12/22] dt-bindings: sun6i-dsi: Add VCC-DSI supply property
Date:   Fri, 25 Jan 2019 01:28:50 +0530
Message-Id: <20190124195900.22620-13-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the Allwinner MIPI DSI controllers are supply with
VCC-DSI pin. which need to supply for some of the boards to
trigger the power.

So, document the supply property so-that the required board
can eable it via device tree.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index 6a6cf5de08b0..69e233e8fad1 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -27,6 +27,9 @@ Required properties:
     first port should be the input endpoint, usually coming from the
     associated TCON.
 
+Optional properties:
+  - vcc-dsi-supply: the VCC-DSI power supply of the DSI encoder
+
 Any MIPI-DSI device attached to this should be described according to
 the bindings defined in ../mipi-dsi-bus.txt
 
-- 
2.18.0.321.gffc6fa0e3


Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E32C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7203F20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JfEea0Wr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfARQcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:32:15 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44662 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfARQcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:32:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id e11so6561371plt.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 08:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wXbv4EStlt/WSU+EIZH0OlN5Zo9WGSHjVKnuaGSJ7JI=;
        b=JfEea0WrjPfkCG3tH7f9t+M6PSMOT5SjF9aq6cqyT5W20z1o0YkrEOpfsMuPdhzzpw
         IV8zPBwdsdVJUzYFcmHLKLJ9VXlCfC5QV4ppqQYjdxDu/eZjvhoatEriJ2uoI+MhZLHk
         yqmENxEAsw/86d4iktkdOzIMg6NJXcPhBR6cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wXbv4EStlt/WSU+EIZH0OlN5Zo9WGSHjVKnuaGSJ7JI=;
        b=AyseQxPEUx/xGX0uilXSBSsvKtc6xaYu04JEbhLV41OTPtMb7biw+wV3z517ukIuZQ
         RLZssbgMehh+NdLHYW7zjW+g69LI3qRTTRcLoZ7SVQjOA8HJr96o6lmX+34Eptt4r/I5
         YIPzJdWT9Wis8q1wFdDn9t8aKRzcLGy+AsH4GoS/uBwgWWePD4rabISu/T+IpUJru+0Y
         ts4h7QERafLoOgnVb68fdeVA/aN5S5oszIawbKvvaWDIYJSg3Tb7ysWvPkVeRAN6cMEN
         VqW4cSuYXRzJuiha5WJcU5lnuX6AwJZtNg2OGNhYGZU093c55GlMV96oquGjxTNDBk24
         xpUA==
X-Gm-Message-State: AJcUukdR3q0Zv4tDgxiOxk+NUBllXYb72DtvTOfJwRRHfZMLwiHUZP9+
        ADIcz9Fi2syA/ztypHumWzq5PVGAx18=
X-Google-Smtp-Source: ALg8bN4/H0QR2+ASRowTivs5hAZMKosQvkhXOtMeI+YzIuImn25KZJOQ+nZVn5foWwCH78GrOPiDuA==
X-Received: by 2002:a17:902:2867:: with SMTP id e94mr20077723plb.264.1547829133059;
        Fri, 18 Jan 2019 08:32:13 -0800 (PST)
Received: from jagan-XPS-13-9350.domain.name ([103.81.77.13])
        by smtp.gmail.com with ESMTPSA id z13sm13967086pgf.84.2019.01.18.08.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:32:12 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 1/6] dt-bindings: media: sun6i: Add A64 CSI compatible
Date:   Fri, 18 Jan 2019 22:01:53 +0530
Message-Id: <20190118163158.21418-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190118163158.21418-1-jagan@amarulasolutions.com>
References: <20190118163158.21418-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 CSI is a single channel time-multiplexed BT.656
protocol interface.

Add separate compatible string for A64 since it require explicit
change in sun6i_csi driver to update default CSI_SCLK rate.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/media/sun6i-csi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
index cc37cf7fd051..0dd540bb03db 100644
--- a/Documentation/devicetree/bindings/media/sun6i-csi.txt
+++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
@@ -8,6 +8,7 @@ Required properties:
     * "allwinner,sun6i-a31-csi"
     * "allwinner,sun8i-h3-csi"
     * "allwinner,sun8i-v3s-csi"
+    * "allwinner,sun50i-a64-csi"
   - reg: base address and size of the memory-mapped region.
   - interrupts: interrupt associated to this IP
   - clocks: phandles to the clocks feeding the CSI
-- 
2.18.0.321.gffc6fa0e3


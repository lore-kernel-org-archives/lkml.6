Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B54C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5922082C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RXlY0lhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfAXSIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:08:24 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32967 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbfAXSIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:08:22 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so3255882plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 10:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wXbv4EStlt/WSU+EIZH0OlN5Zo9WGSHjVKnuaGSJ7JI=;
        b=RXlY0lhBeHHAfn1ZoEusdajsMhzMKtu8DlU+tEnR82ZIZCqeXz6LcVt1IHozsnbtKp
         afu/I4bhUGnXxfMDmRxvGmplqN8cQw6gBwXY3YE9GMDpdT11tVyftqCsYuE3CLzia+wK
         JGevvUAuOr8KTHXi/HWznqW37CXxuwGWLsdCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wXbv4EStlt/WSU+EIZH0OlN5Zo9WGSHjVKnuaGSJ7JI=;
        b=TnCcxtzH3XIthEC4L7/4oID6aTeyFQzROxVinkHe1ro+svDAPzyn7h0bswLIw1ODon
         7UGj7f9P8iPl5KVLcG09t16NJgjKtmFHljUyBfB85uzN+d/HVhFa7G2Urop/v6JhEI77
         CWIF0JD3X4ENoB0bneTY2VmP0Qrl6JfJlWBYfG7Op1LXhI3sQaV0a5+l+mMC3pnI8QPG
         Ulx7u1JqeQeGJb/ZFVF/DEbewW9NS5nrUft378J9/hyVtf3PVuZOnCHAM8pSfmAOzxfO
         NegkzyzZkVbG1oJdkAm5TRLTRoB1ffJDg1Yk2xcP2lqq7xhgoXIKmvkgmds2V1wntdDE
         ploQ==
X-Gm-Message-State: AJcUukcMW1x+kC54GS65ZyBfyuUiR5FgFO73V2WFFeruPSgM8KtRTgsL
        TiJxs/o4LrYd8kBdRmhmVHSC0g==
X-Google-Smtp-Source: ALg8bN5bdO/M10wWvWnvl5qVQWRmF2XjjMq2zxObQuRH7GwYHUUTnLpTB1Sr481ExOEyNaw7/hrmqw==
X-Received: by 2002:a17:902:654a:: with SMTP id d10mr7393226pln.324.1548353302040;
        Thu, 24 Jan 2019 10:08:22 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id k15sm36141551pfb.147.2019.01.24.10.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 10:08:21 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v7 1/5] dt-bindings: media: sun6i: Add A64 CSI compatible
Date:   Thu, 24 Jan 2019 23:37:32 +0530
Message-Id: <20190124180736.28408-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124180736.28408-1-jagan@amarulasolutions.com>
References: <20190124180736.28408-1-jagan@amarulasolutions.com>
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


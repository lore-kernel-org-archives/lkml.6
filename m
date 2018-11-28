Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA96CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9659820873
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUk6DR9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9659820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeK1PiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:38:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37256 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbeK1PiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:38:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so16754187plr.4;
        Tue, 27 Nov 2018 20:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6lmll1IWsxEUtw2cYFC//V9pRv5fGesI1eg7SA2Km1o=;
        b=HUk6DR9OhEtM6ZYht4H+OhpxGZXv5T553IsVuUUBTcVc7s/QW4SQiAz0ystv/mL+Mu
         UvKMULbARcrDYi+27o4VcFF/CS7MZtscBq8hyPbPMSg/9LBfo/VHsyAkvAhZaPy9hCdK
         QMhAHO9uw/fqZ+hrWf4weDs+B4CWEe3E3m6PnE+X+CCfBqyHQFd6Llhdo97EKX+iMpP8
         Oc90SZRUPbZiJAgtu10H7QpqhhVKI1i4Z9gekzs37fddDRLYzCkelBDhEukX5li/uWxp
         A0aIg9eenRWfus4U1uU7ECprg82lCMPIoPQ2q8oyN5aBMkyGLcyw9NX2SDLePD/LM6Q3
         4jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6lmll1IWsxEUtw2cYFC//V9pRv5fGesI1eg7SA2Km1o=;
        b=lXfPKo85gzMhkj+fWE6/57wC9ycVfUOCteXU3o+3yDWFT1l4hiiUlHOijfQglmwTj1
         2JNWJRB/OYMIxiuZceWaFAYduvoemjDzWyE2Zmy5YGEiyNnp0TDol1mi8wHTXR2EnJ63
         r2Wuox4pCkExneb5V10sv8xvmrBUNYXc4vuAemsjFewEAuuRSY/DzKq7E7mQKLwcechM
         Ba0GE1lNh8g0lm9hKzDio+suFQu51mmqqNe4m+DUm5EQIH9PF3rPCd6fHienM4DMdpr8
         ESoxaM9O28GiCsODdQ/SQMCdx2phCR0VK09eGzXEUKZAOk4h7SBQXtNS26ljoyO0zjwI
         DGcg==
X-Gm-Message-State: AA+aEWYfr7C9IbgkLPDoZieVYKMOBaEq6QI7hN/7mYNGCD3jnjManRQ1
        3gtNTzNifDJ3ZwiPxbCh0sYc3w3lEfs=
X-Google-Smtp-Source: AFSGD/USX+60GnLheEVRPzbphISKnvxIRprGi7XFICLWy6E+1E/MsdeZEMGa7navk57mp8s4es4b1Q==
X-Received: by 2002:a17:902:7044:: with SMTP id h4mr15269725plt.35.1543379877208;
        Tue, 27 Nov 2018 20:37:57 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id v2sm6387369pgs.0.2018.11.27.20.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 20:37:56 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>, p.zabel@pengutronix.de,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/3] dt-bindings: reset: imx7: Document usage on i.MX8MQ SoCs
Date:   Tue, 27 Nov 2018 20:37:38 -0800
Message-Id: <20181128043738.12714-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181128043738.12714-1-andrew.smirnov@gmail.com>
References: <20181128043738.12714-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver now supports i.MX8MQ, so update bindings accordingly.

Cc: p.zabel@pengutronix.de
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 Documentation/devicetree/bindings/reset/fsl,imx7-src.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
index 1ab1d109318e..2ecf33815d18 100644
--- a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
+++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
@@ -5,7 +5,9 @@ Please also refer to reset.txt in this directory for common reset
 controller binding usage.
 
 Required properties:
-- compatible: Should be "fsl,imx7d-src", "syscon"
+- compatible:
+	- For i.MX7 SoCs should be "fsl,imx7d-src", "syscon"
+	- For i.MX8MQ SoCs should be "fsl,imx8mq-src", "syscon"
 - reg: should be register base and length as documented in the
   datasheet
 - interrupts: Should contain SRC interrupt
@@ -44,4 +46,5 @@ Example:
 
 
 For list of all valid reset indicies see
-<dt-bindings/reset/imx7-reset.h>
+<dt-bindings/reset/imx7-reset.h> for i.MX7 and
+<dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ
-- 
2.19.1


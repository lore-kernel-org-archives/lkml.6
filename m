Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABA2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFF6217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQZXCbF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbfBRTMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:12:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39449 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbfBRTME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:12:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id f132so9036605pfa.6;
        Mon, 18 Feb 2019 11:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6n68aB9JlkxCY7Qx/DXKciFTQ8435UNi+H1H6r3cxfo=;
        b=eQZXCbF3GrZT2RRhflWWMW4fXJ2vwcxeIJy6EIkYlfjV6gUBjK4XHHHivUEaRfeX2e
         lNHolIExdctlpSG//zsTCK5Xp4vJWHTLmkKQRyIMHVlLnyRaFACr90b2QfqWtplj26IH
         xeFusoo24Q3S2b/nqXrmDhN1Aja2khmQKlEOi7qtPnDZXdon5XqgwnaN5ZN0s4UQUpnj
         29qGIbSKH2765lGocOnFowK8pDZ91AuEMdPyZLIFQ4Evqn0KF4aG9cg7vB+IwALYalH+
         N9ETcxRX5Rhx4BN7Vclj9kiQGz3zKTFOzBZbekJ8Ny7gonqfMZI83zdFEVSYGVx3I85m
         v7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6n68aB9JlkxCY7Qx/DXKciFTQ8435UNi+H1H6r3cxfo=;
        b=lS2hJidwxbSVctDF+yvIzwJjEcJcMCCGwxYgt0UR+MTSKvqTl3HBeQgsjdUI8gtetF
         2XFKmymhZHCviSa5dgP+OLPEtByyFZ4/piQat5T0mFwUoaqPA4+Lpynz/EAe3DqrTT6l
         ISElwaMhYKHJEsV5ZBnjCkvEL3NjRJ1hwtWcZcWEXIC5PaA1TVjbhfhOoYaNg3wkVrPU
         77E9DZo6H8LQqkqJ+H5xNjpKdvdeACGtRO7V5nv6HRoomb3Sjao32qaTfIe5VNnR1aZU
         dpqY9Wm/AZws7gDcp1TeofsUIQ/4TJsmT9lO2+NNcyQiTEcslanqeUKMh5wi56v6SEpX
         6RRg==
X-Gm-Message-State: AHQUAuYjLSaykJI7W3MkAWM+R86jt+fqTUeUw4tXxyWEihF6QZqejGG4
        AFZMh5SfwJZ38inQe/Q6xc72u0mq
X-Google-Smtp-Source: AHgI3IZNEinVHe/li4SGUcyIlXyDa4knPGhwGxH4DWsivXM7ZoT+U3L2X95AaABSX5tVpZNfHxrBTw==
X-Received: by 2002:a63:df50:: with SMTP id h16mr20596955pgj.421.1550517122868;
        Mon, 18 Feb 2019 11:12:02 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t12sm33189727pgq.68.2019.02.18.11.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:12:02 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] thermal: qoriq: Remove unnecessary DT node is NULL check
Date:   Mon, 18 Feb 2019 11:11:31 -0800
Message-Id: <20190218191141.3729-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218191141.3729-1-andrew.smirnov@gmail.com>
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is meant to be used with Device Tree and there's no
use-case where device's DT node is going to be NULL. Remove code
protecting against that.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 18c711b19514..3e147f856bf5 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -189,11 +189,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	u32 site;
 
-	if (!np) {
-		dev_err(&pdev->dev, "Device OF-Node is NULL");
-		return -ENODEV;
-	}
-
 	data = devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
 	if (!data)
-- 
2.20.1


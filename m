Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D201BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3D82084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="guAKJy0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732847AbeLTMzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:55:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35581 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732654AbeLTMyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:54:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so2062574wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XK1+ImY4LqT3mqPXOgRcotLaegAmI6oUTAhBqe9t1Sw=;
        b=guAKJy0OL6nXtpHu5GU/d99DuxpR0mmuIZemRdWaOszAnuyybtR/sssbywfDKRrNrf
         DqL8yOLBev+gKWvFdn94peWiE144jfkW0jdSegShXzl3vVX8Veitr4Aov8ON1Mna/ZKG
         ltr8NR+r0nrJ12xaj2GAHmF2tKLYzb0BjWWpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XK1+ImY4LqT3mqPXOgRcotLaegAmI6oUTAhBqe9t1Sw=;
        b=Tx82UCUT8mDr6JkV8O+q7gXtiGS9Qh7z55RneAG/myslWTsVrK1C5ZG22KqdsHwSpt
         oR0XDA210YoRgsrKGvPXiqa4HAZkhiAYv8VAtM2AJX5qwxScnp7zLbuq3002gwqjgUoA
         aSKrpQR/GSoBH3Iw2ISJpyc3/EMNgWFMjZ9TZPQAX+XgZV5dD8s10jpkPofdPp/PsCVD
         Czb7tgnJ2MkjUR8ClYXxzL8TyNyU8+FDKp3ReuKNSQrQOFNL5CeqNNBdcCMh3OmJD0PZ
         oQWyNyDvFI+v39l3vJW98U2dRr88YuhJxrlTJ8trFktpYjRQH1Xa8xlVQNYSIDS+uiJ7
         ZwuQ==
X-Gm-Message-State: AA+aEWZnLelg1RQdG3G7Z8y941TArqBzbdpQ+UPs6pR7ropQ3n6AE6NQ
        +8YYrpxzcbAJYQd+2Z/6JT2s/w==
X-Google-Smtp-Source: AFSGD/VaVhsdOJ+GQeoQ3YRRzS8H1oCRVWa/ZckdcR5C+R9heqHrTZBUjY6lcOQvr2R2zurM9FcrHw==
X-Received: by 2002:a1c:a895:: with SMTP id r143mr10839869wme.95.1545310493002;
        Thu, 20 Dec 2018 04:54:53 -0800 (PST)
Received: from localhost.localdomain (ip-163-240.sn-213-198.clouditalia.com. [213.198.163.240])
        by smtp.gmail.com with ESMTPSA id o4sm8732756wrq.66.2018.12.20.04.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 04:54:52 -0800 (PST)
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
Subject: [PATCH v5 3/6] media: sun6i: Add A64 CSI block support
Date:   Thu, 20 Dec 2018 18:24:35 +0530
Message-Id: <20181220125438.11700-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181220125438.11700-1-jagan@amarulasolutions.com>
References: <20181220125438.11700-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CSI block in Allwinner A64 has similar features as like in H3,
but default mod clock rate in BSP along with latest mainline testing
require to operate it at 300MHz.

So, add A64 CSI compatibe along with mod_rate quirk.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index fe002beae09c..48919aabefdb 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -913,10 +913,15 @@ static int sun6i_csi_remove(struct platform_device *pdev)
 static const struct sun6i_csi_variant sun6i_a31_csi = {
 };
 
+static const struct sun6i_csi_variant sun50i_a64_csi = {
+	.mod_rate	= 300000000,
+};
+
 static const struct of_device_id sun6i_csi_of_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-csi", .data = &sun6i_a31_csi, },
 	{ .compatible = "allwinner,sun8i-h3-csi", .data = &sun6i_a31_csi, },
 	{ .compatible = "allwinner,sun8i-v3s-csi", .data = &sun6i_a31_csi, },
+	{ .compatible = "allwinner,sun50i-a64-csi", .data = &sun50i_a64_csi, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sun6i_csi_of_match);
-- 
2.18.0.321.gffc6fa0e3


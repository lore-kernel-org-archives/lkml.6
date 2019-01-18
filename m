Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B5CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7952020850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V52neNJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfARQcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:32:23 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36239 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbfARQcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:32:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so6293947pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 08:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AcTNJoiSIr2UvGcIYC+6yeK1JimQepwB20Vv9L6yJsk=;
        b=V52neNJr+5s5Ws7YreKtc2b0uXnFaD/GlUykSFfQFbUBiHU1Y5clMVBSrpHzW39P4d
         r1Dkduqwp8D1wV6rlNp4bKfRDblmhN302+64PH4JhlZ2akOt82XQgeIfQ6wDBq3SG9Na
         6pB6Gm0FeqPnXFlvl9K0nySUPInlzSdgm7q88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AcTNJoiSIr2UvGcIYC+6yeK1JimQepwB20Vv9L6yJsk=;
        b=U31ZpaW08vC6aieFKF/Tiflnb0dtu6O75ADwyL2kSkph28AJQdoiSD5jQIs2yE8ZhQ
         GBqXQn/CWWBQyGogdGd6jizafBul+nakwfb914feU7k/cOlz6IUgjGABNcj7/L3uT4iH
         Tb9F0ndv8Geg8ynr6BmLmslnmkGvvByb2s9SeiTkjig0x5OVJr71+LoGJXXuLvjkV6wb
         WgBQlPSfUX3E7CKaKSgWzTmlroiqBFiAjEFWr8UV23D28VNJmE6f3ap1OVMffk6Ix5ad
         uywdTcLbZLauAbeugpCd/Trgk6o1fMkSnrHEvqm2NzeYb4+ZI3/ac4bEx4eCJOoEPmhs
         ageg==
X-Gm-Message-State: AJcUukceNETlDWqItoMW5QjIV8b6dfsb/8ADYzAgcGra0FkM2cH10KZX
        ZEuwAkuQOq8Bt1+cNWega4oJqw==
X-Google-Smtp-Source: ALg8bN4o3QTXvzSyHghbovl3uuhczhuTH4f7BPtE96v9dSt5mHU0Qhbh1OmAJLTa98g0kwf0LPl6AA==
X-Received: by 2002:a62:8985:: with SMTP id n5mr20180814pfk.255.1547829141742;
        Fri, 18 Jan 2019 08:32:21 -0800 (PST)
Received: from jagan-XPS-13-9350.domain.name ([103.81.77.13])
        by smtp.gmail.com with ESMTPSA id z13sm13967086pgf.84.2019.01.18.08.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:32:21 -0800 (PST)
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
Subject: [PATCH v6 3/6] media: sun6i: Add A64 CSI block support
Date:   Fri, 18 Jan 2019 22:01:55 +0530
Message-Id: <20190118163158.21418-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190118163158.21418-1-jagan@amarulasolutions.com>
References: <20190118163158.21418-1-jagan@amarulasolutions.com>
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
index a9aef630c3b4..d03559d27066 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -909,10 +909,15 @@ static int sun6i_csi_remove(struct platform_device *pdev)
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


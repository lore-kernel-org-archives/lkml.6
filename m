Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42DCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E14E21746
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEZ5FJeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E14E21746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeH0MIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:08:15 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40229 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbeH0MIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:08:14 -0400
Received: by mail-lf1-f68.google.com with SMTP id x26-v6so9179427lfi.7;
        Mon, 27 Aug 2018 01:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tUtlDobmS3JDO74Woysr6AQvtZDWk+5XonLlWqwCnoc=;
        b=cEZ5FJeBH/pymft7uNHHILvTUKOtYpJMvyOV7SmSoDb5iNsUoQG8jIAoRlw6dilNfy
         iatPiJnZmdQr10vLeP/zoAJM8Kl8IBecqiwKT3+ATnPxiIOVoqXQg1HQ6ucnpmdmq0NU
         hPZKSQLUWYN/s++YPNTZUcdbKwVg+owPLfxdXjzLCwMhQ4e553UFtUAeicoxo8pErPTj
         NEx9+AglqJ7Y0Hn1R3cjAqhVS85RwZJoKt3+VjS3N5l0Tv5scwVYWG8zFFfrWDpqTUN0
         0LXEvWW+RVnAtSfryE/80sB1FO3K54w0lArWU6qnlkCuHhcRR65QC7K0hx9XRD+ITFeA
         cw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=tUtlDobmS3JDO74Woysr6AQvtZDWk+5XonLlWqwCnoc=;
        b=K5WhggqC1XuVYLm67bpYCi1XppEs1mXkA+QEYidaRdq8JpdMWdBQWTvjb7dXfx+phj
         ugfxOKxEyk31jJDul9LdnptU6P9HzzzhkSRk8ujw6+UxkcGxJGyKGvIH7oEmUEreW6tI
         P9LAaI4sT8WAyTiXmC4Ags2DPL0gsk5akDk8ERnxl+BzROSNmhFDqwk5B0Y6yf50xOM2
         8lDPMmhVuk+Q0E4d2gwN2KJ2iCvRoiecBI2J+t/GlwAcZc7jcqUZWH6UQkx+iCdNnYpc
         4dsmh+62mygkihHXAh4d8TTlVo10F1IQFJv5Sv3c1yzYnIJFr6zKKqkTk4v6u7q7dv2I
         SRNA==
X-Gm-Message-State: APzg51AQNB8Ck9rfPWXu3optRVt2zsNNepxWH4MOPOQUAR5P7s20cDkp
        VyqLC2gJ8j7FrPHvn01V5vRPwG+y
X-Google-Smtp-Source: ANB0VdYFM1tN28N+9dWpZmwJ9Cp7i/2QHXnt1O+dIJwX/9OHNse1oxJkfTsyFVWF5XuKvupdk/io1Q==
X-Received: by 2002:a19:1517:: with SMTP id l23-v6mr8125142lfi.69.1535358156052;
        Mon, 27 Aug 2018 01:22:36 -0700 (PDT)
Received: from xi.terra ([85.230.190.116])
        by smtp.gmail.com with ESMTPSA id m15-v6sm2405292ljb.87.2018.08.27.01.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 01:22:31 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fuCn6-0005sX-NH; Mon, 27 Aug 2018 10:22:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Junzhi Zhao <junzhi.zhao@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        CK Hu <ck.hu@mediatek.com>, David Airlie <airlied@linux.ie>
Subject: [PATCH v2 2/9] drm/mediatek: fix OF sibling-node lookup
Date:   Mon, 27 Aug 2018 10:21:46 +0200
Message-Id: <20180827082153.22537-3-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827082153.22537-1-johan@kernel.org>
References: <20180827082153.22537-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new of_get_compatible_child() helper to lookup the sibling
instead of using of_find_compatible_node(), which searches the entire
tree from a given start node and thus can return an unrelated (i.e.
non-sibling) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the parent device node).

While at it, also fix the related cec-node reference leak.

Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
Cc: stable <stable@vger.kernel.org>     # 4.8
Cc: Junzhi Zhao <junzhi.zhao@mediatek.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: CK Hu <ck.hu@mediatek.com>
Cc: David Airlie <airlied@linux.ie>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 2d45d1dd9554..643f5edd68fe 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1446,8 +1446,7 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 	}
 
 	/* The CEC module handles HDMI hotplug detection */
-	cec_np = of_find_compatible_node(np->parent, NULL,
-					 "mediatek,mt8173-cec");
+	cec_np = of_get_compatible_child(np->parent, "mediatek,mt8173-cec");
 	if (!cec_np) {
 		dev_err(dev, "Failed to find CEC node\n");
 		return -EINVAL;
@@ -1457,8 +1456,10 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 	if (!cec_pdev) {
 		dev_err(hdmi->dev, "Waiting for CEC device %pOF\n",
 			cec_np);
+		of_node_put(cec_np);
 		return -EPROBE_DEFER;
 	}
+	of_node_put(cec_np);
 	hdmi->cec_dev = &cec_pdev->dev;
 
 	/*
-- 
2.18.0


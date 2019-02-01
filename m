Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40A8C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746CC20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoMh8cXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfBADYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 22:24:45 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39500 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfBADYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 22:24:44 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so2277745pgp.6;
        Thu, 31 Jan 2019 19:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=W/b0oc8GZVkD3025OaAQRjZVsMQYhNuuYRfn86IusNA=;
        b=KoMh8cXslL+zoIZ2PgP3rPpQ970r1vRtTR2/nG+q/3maGl+DcfhEoQwKTjkne8E1gm
         sG+xPLAS5yWwM1wsQosltYuV8TlCSnUxh8fYAgNSepUMPWyHbCd8UnotmNykuP4DGJl1
         NXe5YLrR//PWl0jiTcc3YhHp6gP+sqh/m6RZzrbMJICyWmgrVLKjhNMOakMJQRDKpDJv
         0VW61UcjYDGFcPnhxu/d1MZbR83byo684zSOSPUU5x3DVo8NRTLq8Ne+xS/0qBOGU9el
         m6Te9bs63XtKKOoagFPqLrh3jz0Zx99WMRkqbUntvFfuRg/Th3I9oZ3p2+X8YlrVp7Ch
         cZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W/b0oc8GZVkD3025OaAQRjZVsMQYhNuuYRfn86IusNA=;
        b=mjkwZ4Lw+C24ZOcnEsl06dD8VV3RYQYcoJvkXI/81x0WGbpj3woz6n/9/FKYrGZSlX
         3bmTkn+K9BB+OxLQ1waOu/TXsNuwV92riA6r5We9wSvMhk6oAP9CYePvtcPOOtw2/LfT
         1UUAyMewF91TetMu6y2VEe5fyzEHSrR45xmJ1kmL3KIxg52Au1oAJVHe7pshsKv6XeRJ
         +/OKn7Wpct6f1MVKQ213p+F2YGGy8O2SuCQO6NdL2OT+onsIg7DSArcFNgaIkzr14kRt
         bpm6i49g8sUSOGES/cMB6A/DgWVnLDYHnTH+IBdNpahi2DyCa1wirXu+rn7+BxLREvv7
         zklw==
X-Gm-Message-State: AHQUAuZt09Sx3bLG7vJBPTTP5QCrMOVrd6hz8XyX9DJHUSH5KHqcc8w2
        emonawTQEwLuNY8OOFbWLVA=
X-Google-Smtp-Source: AHgI3IYRpWj18peoxEvSXLjFlyRIVNrcaKlz+iTQjL8ygt47zSB9Biwo5VUbs2DxGzR1OJPXZiBi1Q==
X-Received: by 2002:a63:5621:: with SMTP id k33mr623633pgb.395.1548991483836;
        Thu, 31 Jan 2019 19:24:43 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id v191sm11620386pgb.77.2019.01.31.19.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jan 2019 19:24:43 -0800 (PST)
From:   Xiang Xiao <xiaoxiang781216@gmail.com>
X-Google-Original-From: Xiang Xiao <xiaoxiang@xiaomi.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: [PATCH] rpmsg: add match optional callback to rpmsg_driver
Date:   Fri,  1 Feb 2019 11:24:19 +0800
Message-Id: <1548991459-12515-1-git-send-email-xiaoxiang@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

so the driver could decide whether support a particular device at runtime

Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
---
 drivers/rpmsg/rpmsg_core.c | 3 +++
 include/linux/rpmsg.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index ea88fd4..afdd1c6 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -413,6 +413,9 @@ static int rpmsg_dev_match(struct device *dev, struct device_driver *drv)
 	if (rpdev->driver_override)
 		return !strcmp(rpdev->driver_override, drv->name);
 
+	if (rpdrv->match)
+		return rpdrv->match(rpdev, rpdrv);
+
 	if (ids)
 		for (i = 0; ids[i].name[0]; i++)
 			if (rpmsg_id_match(rpdev, &ids[i]))
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 9fe156d..7a5a342 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -109,6 +109,7 @@ struct rpmsg_driver {
 	int (*probe)(struct rpmsg_device *dev);
 	void (*remove)(struct rpmsg_device *dev);
 	int (*callback)(struct rpmsg_device *, void *, int, void *, u32);
+	int (*match)(struct rpmsg_device *dev, struct rpmsg_driver *drv);
 };
 
 #if IS_ENABLED(CONFIG_RPMSG)
-- 
2.7.4


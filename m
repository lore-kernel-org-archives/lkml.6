Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE21DC282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2EA218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YbqF7rO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbfBAPjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:39:15 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38669 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730667AbfBAPjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:39:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so3388349plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tJ0vVOL8XD9yWBH7fkHAUlpmy1k8wF+axXxeAyBhZsE=;
        b=YbqF7rO3XIv9/Gh2ZRe5z22Mt3MOBU5/xMQRWkCA5MMMIftPZdOknSTxzLdaPkRMZW
         DKWwTa/TauZYrWDCtNTUw2+z+AGiUTRPsteQMlhjGsAPEe+YxozS9eDgqYcPDx91X2uV
         Hyq7pM3LidN+yC88pOFL6VmfmF+G2wRqKS3FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tJ0vVOL8XD9yWBH7fkHAUlpmy1k8wF+axXxeAyBhZsE=;
        b=a3LAdsWugWP9v9L0ImNBeZNYMbkVif1CCMut39BRCNTQ1BnzhL7DOtBWduP1/GOZ+7
         zrcEAJKDDp85c07+9GRr+QhCYxTHAGuhxM4s3C0qAa8ZCczUbdYr6nROuGaY+oHs9PbP
         FTfcEXd2dtpOaRGh+6RxitwiCMm+NQyKliN5TcZYyFwprTg9Iz+38uRVj/oUhVJPWRUr
         5eXonmYoKsxKjAsRTIJMVdJqz8s2Fxte5HD4vlMGL2FfQ54asQMm3HuKa1AR/s1ZhdcG
         tyt83HXWnaN7nBXdaQIPbfzPXZ8uCuz16t2zC9sIRioLAhHon5NSih++r6zWaHan1iDR
         ZFQA==
X-Gm-Message-State: AJcUukeQ2UAULLBSNls9rTa5cJOcJw6jWMkObhG+Q11qhDAP+Ue7262I
        ovcyR331uOQPm5aYDq7lizI7Oo3vhQ==
X-Google-Smtp-Source: ALg8bN6+HfmmOQ85GQbZHWRafETMzY8x00axa1Uv2OdB9M2YxpRZzGYf9AbXQFfKG/DWKoKKzwACqw==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12mr40360250pld.8.1549035551741;
        Fri, 01 Feb 2019 07:39:11 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7348:9f93:3db9:68de:e3db:c028])
        by smtp.gmail.com with ESMTPSA id l22sm12350035pfj.179.2019.02.01.07.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:39:11 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, xuwei5@hisilicon.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/3] reset: hisilicon: Add HiSilicon HI3670 reset support
Date:   Fri,  1 Feb 2019 21:08:41 +0530
Message-Id: <20190201153841.21903-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201153841.21903-1-manivannan.sadhasivam@linaro.org>
References: <20190201153841.21903-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI3670 SoC is architecturally same as the HI3660 SoC. Hence, add the
HI3670 compatible to HI3660 reset driver in order to reuse it.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/reset/hisilicon/reset-hi3660.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/hisilicon/reset-hi3660.c b/drivers/reset/hisilicon/reset-hi3660.c
index 17d8bb128e6e..1c22f3457ba7 100644
--- a/drivers/reset/hisilicon/reset-hi3660.c
+++ b/drivers/reset/hisilicon/reset-hi3660.c
@@ -103,6 +103,7 @@ static int hi3660_reset_probe(struct platform_device *pdev)
 
 static const struct of_device_id hi3660_reset_match[] = {
 	{ .compatible = "hisilicon,hi3660-reset", },
+	{ .compatible = "hisilicon,hi3670-reset", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, hi3660_reset_match);
-- 
2.17.1


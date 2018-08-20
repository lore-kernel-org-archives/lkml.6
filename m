Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E02FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EB7208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaR+3gec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EB7208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeHTNp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:45:27 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41068 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeHTNp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:45:26 -0400
Received: by mail-pl0-f66.google.com with SMTP id p4-v6so3342215pll.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 03:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:to:cc:subject:date;
        bh=6RKeNRNK7+tGO+atCIlpzP0huE6JWjNzUmOp/crlJ4g=;
        b=XaR+3gec8xVFzl9uzBxGAlKrEy+EkhYuXU03yFvXfjTQorpuO3bAMQns9QS6Qbspye
         GPcYkvmvCUq5g/1VEuJhtVi8Ggt+qVS3jme5cPBm8rc8BdB6OON32eXBcmZqthru16k9
         XNi9TJNOevs7i98UpMXhkEm0MlQFXKQg+LEd8vCozIK8k+xpoyhWrdWat46hYTRCb/ir
         3OxXsSboYqMoFhB8aTrqJJ1fT370zokq+bTrTjDJSW/QV1C7GCMbQcVVNpd8G9CX0QgF
         QmhZf9Di/k19DR8wpH2X2WLvlJyaOqdIpMGt+ypDPZpfSj91Zi/Ji7qTYBQkoBqKUZLt
         FCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:subject:date;
        bh=6RKeNRNK7+tGO+atCIlpzP0huE6JWjNzUmOp/crlJ4g=;
        b=bCjoh5vmHoa2Dg/lByh4DH97pgV2YjU0NZZhYAn4rI9URAcu1D40x1UTNbfwdFRN7d
         68VJmnkfAek2Myxtno/NN3IXsJFpKkfMEX8NsvlW/hrhzXIi4aPWs78ZOXVLHBdbqF+V
         g5FMUjRKASY2m4kZP/YBxQO86qmCU1/J5HhMnOTwMSeSau4WXi3q1oaggW7NznoI0yqG
         bEUq+9nnbacF4BbQMOQhAWEiF2GpHR+8/96BYHIqUePmzz3xkb9soCL9JKowzwPM6hrr
         huU87ivRka3Nx+79hQT6RpLmEC0VrMQzBSPxGlMft6vUBUPBZujw2OqUzhjGQIca4zSr
         MB1g==
X-Gm-Message-State: AOUpUlH3wzPLq3Is31IJiiAl8+SEDTwCSV5sxH4dkQoNxZC82OvxxI8I
        IHYyWbHU9R3zOOQ7GJREdPc=
X-Google-Smtp-Source: AA+uWPzahbeD4lXnN9JJyLepCxjFvrftDjroDU78Vp1ZspwPMQyEDJ1o5vP9/8j3UgD7kJgbOHLs+A==
X-Received: by 2002:a17:902:820a:: with SMTP id x10-v6mr44951639pln.261.1534761022869;
        Mon, 20 Aug 2018 03:30:22 -0700 (PDT)
Received: from bsapthagiri.soct.com (gw4.soctronics.com. [202.153.34.22])
        by smtp.gmail.com with ESMTPSA id h130-v6sm20182430pgc.88.2018.08.20.03.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 Aug 2018 03:30:21 -0700 (PDT)
Message-ID: <5b7a983d.1c69fb81.8349b.fc57@mx.google.com>
X-Google-Original-Message-ID: <1534760941-4423-1-git-send-email-bsapthagiri>
From:   sapthagiri.baratam@gmail.com
X-Google-Original-From: bsapthagiri
To:     lee.jones@linaro.org
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>
Subject: [PATCH] mfd: arizona: Correct calling of runtime_put_sync
Date:   Mon, 20 Aug 2018 15:59:01 +0530
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>

Don't call runtime_put_sync when clk32k_ref is ARIZONA_32KZ_MCLK2
as there is no corresponding runtime_get_sync call.

MCLK1 is not in the AoD power domain so if it is used as 32kHz clock
source we need to hold a runtime PM reference to keep the device from
going into low power mode.

fixes: cdd8da8cc66b ("mfd: arizona: Add gating of external MCLKn clocks")
Signed-off-by: baratam <sapthagiri.baratam@cirrus.com>
---
 drivers/mfd/arizona-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index c7c3d72..190f9a4 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -53,8 +53,10 @@ int arizona_clk32k_enable(struct arizona *arizona)
 			if (ret != 0)
 				goto err_ref;
 			ret = clk_prepare_enable(arizona->mclk[ARIZONA_MCLK1]);
-			if (ret != 0)
-				goto err_pm;
+			if (ret != 0) {
+				pm_runtime_put_sync(arizona->dev);
+				goto err_ref;
+			}
 			break;
 		case ARIZONA_32KZ_MCLK2:
 			ret = clk_prepare_enable(arizona->mclk[ARIZONA_MCLK2]);
@@ -68,8 +70,6 @@ int arizona_clk32k_enable(struct arizona *arizona)
 					 ARIZONA_CLK_32K_ENA);
 	}
 
-err_pm:
-	pm_runtime_put_sync(arizona->dev);
 err_ref:
 	if (ret != 0)
 		arizona->clk32k_ref--;
-- 
1.9.1


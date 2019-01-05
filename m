Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1927C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 18:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF77822307
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 18:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="d4JHDNlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfAESsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 13:48:20 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:51486 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfAESsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 13:48:19 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 0A7F4A3D
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jan 2019 18:48:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1PWHaAJk12BW for <linux-kernel@vger.kernel.org>;
        Sat,  5 Jan 2019 12:48:17 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id CF88FCB0
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jan 2019 12:48:17 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id p21so3655160itb.8
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 10:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+I8uhisP0a8qBAXn1b3pJWPTpTfCf9zrvPMtDhjc0SU=;
        b=d4JHDNlzvODwwZ9BD1NMP5jwJwd010krAV1kYM/9NdcvIFKjOEe4RCePjpxUVFQl73
         NVA914Ge6doC3NZPtOspCxtKSrvsraelS/qeXwsRVENP1q5ZvCX3sq+8PpFnEKB4fHZU
         NOzhp5rj1dQ8JH4EL87w6GBhPDAnZN/3Xb6zY7HLn41ttiQ0+h1AWkAj/tLUMLQSMudh
         oFyv+H2OJe3R9tQQn1mhHo5EZy/uUDBF+8OB0Z3zflgS425qSZu6CsnBpH+XxAek7HWz
         s1RCulwOpqe3Y1QZbxG5l9hatCIIAm/EqbVFYnBaWTCF++cSgXObXxfygioy8Q9KGXjz
         2qLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+I8uhisP0a8qBAXn1b3pJWPTpTfCf9zrvPMtDhjc0SU=;
        b=KuduFS51rdAOIpOTiu6xo4kn2GFc1h90VO/2jTMmpi3yKSh20mcyWqduuM/N5aN4nZ
         VXcK5ViAm/DAFkdJCs3gABArc9qoDvGmxqvnd6wRq/XHDrHG1wVuJyDuyKZwMMgY85Zd
         9J69z5pu77Ra019L6RC0G2EyN/BSpTyAun7Gbntt7vck75tm9HKYnDScPL9b4Nx0xZUu
         OSt5Iy/jaAyV5xCoRaT0XBSDDtiyHMBDiExKyr7VoIQhGQihq0jHmpewLAg/yC4vTuDq
         6jvV3pgjAJKibZDSsHIMNFAWxb6BUXVXBrHeLtosPKl+8jge9Udfy8bJjxylN8jSrfml
         71tw==
X-Gm-Message-State: AJcUuke/hxsa0u3hFndO5XRAYAsTNDjrema/Sk9W7V2YluexdkVuWjCx
        MUWQhBN6xeH6AMaZeahGkrpdquZpFGPvUYGeNVO7N+w6wzCUQgHxdCzno6wgblT+on33kH71S0z
        k3z79iJEXQOr1q1u7jL0UoN6G9cxS
X-Received: by 2002:a24:e38f:: with SMTP id d137mr3626566ith.69.1546714097255;
        Sat, 05 Jan 2019 10:48:17 -0800 (PST)
X-Google-Smtp-Source: ALg8bN632Jr2ytc07frzmmrHPlyLR1+tuBYbQ97UrpW1nbQlbOz2Wll6U7E7i4NdjaFafXlpRLYLNA==
X-Received: by 2002:a24:e38f:: with SMTP id d137mr3626557ith.69.1546714097015;
        Sat, 05 Jan 2019 10:48:17 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id m45sm2235474iti.10.2019.01.05.10.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 10:48:16 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] v2 bakclight: fix missing checks in ambient_light_zone_store
Date:   Sat,  5 Jan 2019 12:48:07 -0600
Message-Id: <20190105184807.4827-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In adp8870_bl_ambient_light_zone_store, set, clear, and write
can return an error but are not checked. The fix adds a check for these
cases and returns -1 to match the return type (ssize_t).

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/video/backlight/adp8870_bl.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
index 8d50e0299578..56a640587a82 100644
--- a/drivers/video/backlight/adp8870_bl.c
+++ b/drivers/video/backlight/adp8870_bl.c
@@ -800,10 +800,14 @@ static ssize_t adp8870_bl_ambient_light_zone_store(struct device *dev,
 
 	if (val == 0) {
 		/* Enable automatic ambient light sensing */
-		adp8870_set_bits(data->client, ADP8870_MDCR, CMP_AUTOEN);
+		ret = adp8870_set_bits(data->client, ADP8870_MDCR, CMP_AUTOEN);
+		if (ret < 0)
+			goto adp8870_bl_err;
 	} else if ((val > 0) && (val < 6)) {
 		/* Disable automatic ambient light sensing */
-		adp8870_clr_bits(data->client, ADP8870_MDCR, CMP_AUTOEN);
+		ret = adp8870_clr_bits(data->client, ADP8870_MDCR, CMP_AUTOEN);
+		if (ret < 0)
+			goto adp8870_bl_err;
 
 		/* Set user supplied ambient light zone */
 		mutex_lock(&data->lock);
@@ -811,12 +815,18 @@ static ssize_t adp8870_bl_ambient_light_zone_store(struct device *dev,
 		if (!ret) {
 			reg_val &= ~(CFGR_BLV_MASK << CFGR_BLV_SHIFT);
 			reg_val |= (val - 1) << CFGR_BLV_SHIFT;
-			adp8870_write(data->client, ADP8870_CFGR, reg_val);
+			ret = adp8870_write(data->client, ADP8870_CFGR,
+						reg_val);
 		}
 		mutex_unlock(&data->lock);
+		if (ret < 0)
+			goto adp8870_bl_err;
 	}
 
 	return count;
+
+adp8870_bl_err:
+	return -1;
 }
 static DEVICE_ATTR(ambient_light_zone, 0664,
 		adp8870_bl_ambient_light_zone_show,
-- 
2.17.1


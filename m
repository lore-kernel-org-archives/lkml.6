Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93373C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF3420661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rfFwbRBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF3420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967075AbeFSQKO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:10:14 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36314 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967042AbeFSQKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:10:03 -0400
Received: by mail-wr0-f195.google.com with SMTP id f16-v6so247513wrm.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rOtoKs4754A7gJ+XVdvywpUR4xb3LVeyH+W8NWUsYGc=;
        b=rfFwbRBML9Qg17COtBsw2E/ft6qCam2GbzzU3O5FPB8RfcKOIqMeV1ELlDeDyMo7I9
         BJ13AopLOoNi9TzXfpsq6roa9E35SiCONjTlv5fkRfa/t06YtWsf4UxZBUz39/8kdpJb
         JEFU6Htv/S6N/vCOCezLYCdIbCEiExVa7BRE+sMCeOdIftTmVVi9iMKehW4ciTCh7E5w
         UrpGcWYBcWImO91sQaTvw4yZlRF1XDAd0Nf5KUXoE0eiPFu1EjJ4um9p97TYsXvFLL7F
         uQB2EnIE8EgEifK36NoQQsDNQ3LSCTT7YJTzaGlGQnqwugV9PLzkw5Cp9CJ5xtum/ZIy
         Zaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rOtoKs4754A7gJ+XVdvywpUR4xb3LVeyH+W8NWUsYGc=;
        b=c4dkg+w3xqS2hKarquCg0m53Kf9tp922dDP1Y2xWJ5YTs4+iDjBrsZ3oX47+2971sh
         zv22uL9vJgfCCNh35WFEswVY49KItQbjreoFEnorHlhu0dq2WVBYAliMjx+xBm4p7pOs
         qUNu6Ye/UG9U8CQWSgSUbqYBs8uu/C81afBmc4bGG+WT0Xz/ZUomePLcGapbTfYQdOsQ
         dRV4ZzdJPFlF0XBnjTZUOEklszcjy6o0mLJSWxCxrzvw1KRZdGyPIc1LB5FjQIyHSXU+
         rZFZ3Yk2Y9n8oTROpavosbTfTEuqKS50tUGDZ3PVUDzOH9uXMOCROX/AyyShIwfeVxx7
         C/Ew==
X-Gm-Message-State: APt69E1m3xOfSOfQfnivzvDTngzMWLvuqhAGk0DC41StJByw7aflHYp1
        91j5FmgdW4EgEoj60xDq9gUxRw==
X-Google-Smtp-Source: ADUXVKJ+MiXfoalyh3hbbpUpnGFsI0BfTrg2xNUTv0K4eKH3P6Q0+4UQ23wN/LaG03LxXH4u+8Jmyg==
X-Received: by 2002:adf:cc8e:: with SMTP id p14-v6mr13654107wrj.226.1529424602030;
        Tue, 19 Jun 2018 09:10:02 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-1-7080-22.w90-116.abo.wanadoo.fr. [90.116.249.22])
        by smtp.gmail.com with ESMTPSA id 74-v6sm619327wmt.31.2018.06.19.09.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 09:10:01 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/3] net: davinci_emac: match the mdio device against its compatible if possible
Date:   Tue, 19 Jun 2018 18:09:50 +0200
Message-Id: <20180619160950.6283-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619160950.6283-1-brgl@bgdev.pl>
References: <20180619160950.6283-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Device tree based systems without of_dev_auxdata will have the mdio
device named differently than "davinci_mdio(.0)". In this case use the
device's compatible string for matching.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/ti/davinci_emac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index a1a6445b5a7e..c28a35bb852f 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1387,6 +1387,10 @@ static int emac_devioctl(struct net_device *ndev, struct ifreq *ifrq, int cmd)
 
 static int match_first_device(struct device *dev, void *data)
 {
+	if (dev->of_node)
+		return of_device_is_compatible(dev->of_node,
+					       "ti,davinci_mdio");
+
 	return !strncmp(dev_name(dev), "davinci_mdio", 12);
 }
 
-- 
2.17.1


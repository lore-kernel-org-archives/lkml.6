Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CC4C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C4420846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tBP9Brr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C4420846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932831AbeFTJEV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:04:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40169 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbeFTJES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:04:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id n5-v6so5336950wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 02:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x5M7hdW50E1mLj0VdwmAUYUy3kxdHT/fUYGo7Zjz4m0=;
        b=tBP9Brr+PjJ2Z8JWEwQwDmdzEzasaFGaJZftvGsOQ0dLNsWqyNh872C32ukKW4vApw
         /rdQO5SrI7nueTDt3oSy36G4r1k8FGKV1uU8o9icGEHvSylxYHa+2sEW23wAbmFYZ82t
         tBf1p/7BYW6iNE5AaHLj16BNMC8UwIfKnGtT0fbXD74ovOv3hovnwu61iH3pe5ogWR+M
         1s5rhcgxSaw/j5fflNZpc3oGlbVXCtKuVPiHQUWKVBs8pQ25FzSrCqRNu33HBwpRRXw6
         K29ZN3nKAedURHIyhcB4EYPTCCG81Re8LuxOSvKbuZV2Efncd0rthmSKWBqw74ZtTGzN
         Wb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x5M7hdW50E1mLj0VdwmAUYUy3kxdHT/fUYGo7Zjz4m0=;
        b=OLGCAoAa4sTG9QfRAE+T94khoIQXWcIe1T0W2KgzfyfD8AOl0z9anGtf/AsP/QYIXH
         qrAgWImfeysBbH6EZWBIF60lDWJF89Hp1nr+SOJmUJIKluKnFQUBWVjObO/UvDCtF67e
         b0GZnZDMS87OkI/SQyS0zJr3eFtUfQG4hqy6nLqIb0oDozR5PeM0zJWPOnq6H/YDRd3T
         zb3CyAiJ4D5ppCpCij3SWWaSR5b8fPW5ZEl1zJoK84bAyEsA8LCjAGFKiOV5FAdJ3QCY
         qzEELNF5o94Nd4L24oGeJctgtCDDsjKQ0tByO6cg8DucNdxFWOL8wJ2/zKEtIKp5yKIk
         hj5g==
X-Gm-Message-State: APt69E2U79u5V/U0+fFbONlRBUAQ/osowi52lIZhvpQPXu7grP76ySS+
        mDT31ID8aiW9I7w5Hu9iq0VISd3LNz0=
X-Google-Smtp-Source: ADUXVKLAMAVxfX3O4cBcgl+N2D+4pekwkF1btroC8jBISr5TKJFm88w4bdp/fRoDup7xgqA8ZwAiBw==
X-Received: by 2002:a1c:ec84:: with SMTP id h4-v6mr869637wmi.154.1529481846046;
        Wed, 20 Jun 2018 01:04:06 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-13-249.w90-86.abo.wanadoo.fr. [90.86.134.249])
        by smtp.gmail.com with ESMTPSA id t14-v6sm2131704wrm.79.2018.06.20.01.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 01:04:05 -0700 (PDT)
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
Subject: [PATCH v2 2/2] net: davinci_emac: match the mdio device against its compatible if possible
Date:   Wed, 20 Jun 2018 10:03:56 +0200
Message-Id: <20180620080356.11900-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620080356.11900-1-brgl@bgdev.pl>
References: <20180620080356.11900-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Device tree based systems without of_dev_auxdata will have the mdio
device named differently than "davinci_mdio(.0)". In this case use the
device's parent's compatible string for matching

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/ti/davinci_emac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index a1a6445b5a7e..f270beebb428 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1387,6 +1387,10 @@ static int emac_devioctl(struct net_device *ndev, struct ifreq *ifrq, int cmd)
 
 static int match_first_device(struct device *dev, void *data)
 {
+	if (dev->parent && dev->parent->of_node)
+		return of_device_is_compatible(dev->parent->of_node,
+					       "ti,davinci_mdio");
+
 	return !strncmp(dev_name(dev), "davinci_mdio", 12);
 }
 
-- 
2.17.1


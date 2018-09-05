Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A70C4321E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CA720878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hEQiNjDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CA720878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbeIEO1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:27:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39705 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbeIEO1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:27:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id o37-v6so6962879wrf.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I1VBG0PAwehY35jashnN3ubpOSw/AOLijfoN6Rb7R00=;
        b=hEQiNjDcfbhggmgKR4Jy12P6EQ6yufcz7/7IiKPfuatT+uu6dKBgJLA9Us6W49wylD
         wTMLhBDnO2sUmYtEtlGqQRvXY5XrNxmlVkrRgLcql43qu9F/Qy+zpa0OtCpNVZMCG5Qn
         ONqhpaRYK4Uk22P0eDVArimE9BqzG29ELX1qHfvsmG965qNxbG8s5HCmFruUgtQFgStg
         NtQg1LuGobUHvv0OAd84Ue1jPos6+QYAOGDONza6f0sfE3aEcGjC+QIKzrvkoWQ4SWcI
         GLozHF6yErs/f895RME5R9bhSPwAACbq1t1yG005YPZVDeqi/F2wMluOcpyCPDB/7zvV
         4onQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I1VBG0PAwehY35jashnN3ubpOSw/AOLijfoN6Rb7R00=;
        b=ez7rlDSfHT2Ha5nEtkc2K23RIa3MPcIM7kO30seNBNfWr2QAsRn77/ohmUqQ6QFRvw
         Dy9q1VY/eF+CgPkTHm98zJcKMAUx+NHrgdZTXbHsEs8ZKSQrRI17YNOQUE/8S3vtHeHs
         m4gwHdUoavAY+mmZgp6l7Tn7Y8dW1YsOBxAxuaTvtXRDx5GKLUr7YUVGB0vEI561gsFl
         tg2h5+iNACQ3HzRQujX1oHw8g7Y/nEIyw7kCwZkrcBC4BHrg8JX/ctJiVbnrhgQNDErA
         tz1ERZfRvCZqzJbvevdkbmT3yCVCe2bCiYL+7RSWN+ww6P5BO3Af+Jeg9OwooNv8okOE
         aWZw==
X-Gm-Message-State: APzg51ALVp0jqhREYy0/McuK3dSt0RO0sE1bPPasg7EciXbM/D3QgCTr
        osNeLblP3JWok5dHgNqdHf8IgA==
X-Google-Smtp-Source: ANB0VdaXSBWexf64CcrU5v7PmZTntKrdf2enoXmy3wLA0M83R5Yzsz3DXdfgJofksqUY/AGbE9oQdg==
X-Received: by 2002:adf:9543:: with SMTP id 61-v6mr7497951wrs.25.1536141492971;
        Wed, 05 Sep 2018 02:58:12 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-33-235.w90-86.abo.wanadoo.fr. [90.86.152.235])
        by smtp.gmail.com with ESMTPSA id l12-v6sm2127815wrv.29.2018.09.05.02.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 02:58:12 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joachim Eastwood <manabian@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 07/13] nvmem: remove the name field from struct nvmem_device
Date:   Wed,  5 Sep 2018 11:57:32 +0200
Message-Id: <20180905095738.26406-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905095738.26406-1-brgl@bgdev.pl>
References: <20180905095738.26406-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This field is never set and is only used in a single error message.
Remove the field and use nvmem_dev_name() instead.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 364ee16e7d6a..e456aaa6184a 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -26,7 +26,6 @@
 #include <linux/slab.h>
 
 struct nvmem_device {
-	const char		*name;
 	struct module		*owner;
 	struct device		dev;
 	int			stride;
@@ -537,7 +536,7 @@ static struct nvmem_device *__nvmem_device_get(struct device_node *np)
 	if (!try_module_get(nvmem->owner)) {
 		dev_err(&nvmem->dev,
 			"could not increase module refcount for cell %s\n",
-			nvmem->name);
+			nvmem_dev_name(nvmem));
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
2.18.0


Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A4EC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A29E20894
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XXvG6u2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A29E20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeILMzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:55:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35365 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeILMzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:55:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so931751wre.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5hy1cImwFLaoJYAZMstJrgaN4xDvjcz+dii9EY6OQ8c=;
        b=XXvG6u2gG7rNv/I/2LwPIM9cDaetie4JtmDL1OdR66w0yhrzL6pIPyL6qvO29pwmol
         Ukimo+k1/7M+Z5B8sI6L97p2IIjILQq/0TTzp6QuqtX/3/R8E8L7cWJQsPVpCWV2ZGtk
         psGickRtJKX+Gx5GaL7ato3kN3bfSyPQrNDgiDCANTLyz0AKxbcddu3M9mEmOm+UW+P3
         PqT1mkuYoN3rLAb+2Bd7ezIzlKBzbLmSSk1JAaKt6tD+uu3m6Qz/Ah2invQUxQdH140N
         7VU+LEyrvHJiODoauHLMbr9T1Xu61MLZf2vUUQSSC7THhsxFHwKsi4QBu3+nFJRMiz4O
         Fvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5hy1cImwFLaoJYAZMstJrgaN4xDvjcz+dii9EY6OQ8c=;
        b=cPasmfiuIeS8n02/7F0jAVR1Egs0oCzB2lTZW1CxPlAAkK3laOBvOh2zp+pvXx6rGA
         eTg/Ff4U5FqIfDZ3eGjzKKDJgVl2A21w74hkPdPso7dS/DNVeMlVE2tjW/0ci4/GtKAS
         Ig++A1eoLsC3zLxPN+nOZc8DMxsKgL039AiUd1qHxpTVyfn0Xf9paO6KLxnb7s4++hk0
         I1gXElySmzIYDb7dpekcFgRIyQFrzc/86o7Brbj1QJthAUR+J58KewD+v+uIgs9de+am
         Zjc284ZgZjVTWwLwjQ8nxI+iqvmGIW39gqRcYS3W7lU9IxmCk5p2DY97kEZjeh9KTEfw
         p63w==
X-Gm-Message-State: APzg51Au5hGtuoFvDO/EspaXIvzhmgofede4b4Wmj9waDBpoifSWLRQi
        DeOiffu8vXv2ykpMS7axl+sE1w==
X-Google-Smtp-Source: ANB0VdZQ31WUf+5NQRUNzqHvVsZvtEdKF3VvVrNP2ZlXhf1yxQQtvQhInfzTd2A5/hGMfg4XeepC4Q==
X-Received: by 2002:a5d:490b:: with SMTP id x11-v6mr500134wrq.114.1536738712365;
        Wed, 12 Sep 2018 00:51:52 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id l7-v6sm169341wrt.67.2018.09.12.00.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:51:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 05/21] nvmem: check the return value of nvmem_add_cells()
Date:   Wed, 12 Sep 2018 09:51:13 +0200
Message-Id: <20180912075129.25185-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This function can fail so check its return value in nvmem_register()
and act accordingly.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b469f700c699..ffed8fa16936 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -512,11 +512,17 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			goto err_device_del;
 	}
 
-	if (config->cells)
-		nvmem_add_cells(nvmem, config->cells, config->ncells);
+	if (config->cells) {
+		rval = nvmem_add_cells(nvmem, config->cells, config->ncells);
+		if (rval)
+			goto err_teardown_compat;
+	}
 
 	return nvmem;
 
+err_teardown_compat:
+	if (config->compat)
+		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
 err_device_del:
 	device_del(&nvmem->dev);
 err_put_device:
-- 
2.18.0


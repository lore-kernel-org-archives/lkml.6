Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A02FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FDB2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="o0XNS9YS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FDB2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeINTzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:55:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35777 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbeINTzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:55:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so10892795wre.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5hy1cImwFLaoJYAZMstJrgaN4xDvjcz+dii9EY6OQ8c=;
        b=o0XNS9YSB3E+o5w9WuKdMh6H+ShF1Ispq2AgrjESnp0laXJjmFH4P+biT9tNq51vGf
         1vKcEPm5C22/lPn5wyIZyOI8MoTSW6BASGR4E/rolX2DW5RS30NCEurmZ0QZ7tOb+L3o
         33Q8ghK9hbaLP8ts2Rf85sF5zrv+5nnY0ZxoCQ0SMXPnS4BX9+88L9W6mPGi+Vhj1+Og
         WNz49MqJyZ02TctMIO6WUnyY/id50Zd1N9Syc1f6dkXLyft1U8M2jjOU5emImD0ragQH
         ZkiUJ8sAk9pdtbV4Wi3gosezr/8VgiUOZW+zzuGXhPBTuJJs3r6pru4gClvJyZ0Q3rXe
         /+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5hy1cImwFLaoJYAZMstJrgaN4xDvjcz+dii9EY6OQ8c=;
        b=rj3eRy6Sgr6JC4c+kSCzRKgcyUSnUWj2V2kb6Y8rJUBUEk8cRhCCJ92/LwxXx0fb2t
         WBD4YW5vKJSRPxAqfBQlVGgoGWBzeEN2MPX+Cfp3j3n8WXLV7PQwuEVDkvyaN6YD/Gnu
         RxhoTkjSURuA2GI5nPkOQwu9MWb/LnGN31AK+A0XIjqPuXe4nUve67fsR84qXfctJ4XM
         hC4rmDcXQopBAhr5n/DD1yxfdKQqOVKrO+YaHW54+sJWn0gwJMwA70Lfy5/FFlfCr/yG
         KUAMXWcMEHPBeh3oVYa+b7p1z1xanzD/Roor9e8daWK8wVkET0Skpnk+ylRFQcI9agfS
         HQfA==
X-Gm-Message-State: APzg51CGlcBblD/IyduKlG7TmI0DZAaypCXPNDrd0U01W41PzBxA6roo
        iR2GZ1eKZN/szUafcMAt7+awww==
X-Google-Smtp-Source: ANB0VdZhDkcM2z7bM3oRujFanuSA4xLtl50xZNt7TIdAgbgPyQbpDPu3slIPOgPa541xQJ+mQXRZVg==
X-Received: by 2002:adf:9f13:: with SMTP id l19-v6mr10382180wrf.206.1536936030348;
        Fri, 14 Sep 2018 07:40:30 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v46-v6sm10313526wrc.63.2018.09.14.07.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:40:29 -0700 (PDT)
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
Subject: [PATCH v4 05/22] nvmem: check the return value of nvmem_add_cells()
Date:   Fri, 14 Sep 2018 16:39:54 +0200
Message-Id: <20180914144011.27614-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914144011.27614-1-brgl@bgdev.pl>
References: <20180914144011.27614-1-brgl@bgdev.pl>
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


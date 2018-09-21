Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B97ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8488C21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mG3uP22u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8488C21547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389455AbeIUNRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:17:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53623 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389436AbeIUNRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:17:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id b19-v6so1946630wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 00:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d9TDNBlE9LOCCIoo/ZC3FoSnNdXa8lDWsSssw/xuKi8=;
        b=mG3uP22uDBcDg0Edcn7LKupQ+Tafi0s7wh9UzjW0wwgHHmStkCV9AYiWTlnTMq/iE/
         PnTZgifm1yFLWQDLuH3d2BwmEGmre4VLHCrWCUcUOeg4+pU3zfdHjBn33IqOelhi0B++
         GIONRtawGkju43VirDjuFz/JuhkdCqBpLvLQnYPu0ta6VMOoHMSDnxaFhdL2ffrbSAhr
         TAXa6SzftNyXHrwPOGlHwkvyg2rVu4eJRVy4rkARryBH9SyKjWXzY74lSzxGX4IEaAzd
         rShsSOy6NcK3bLDi/IzvaS+xZJiHHk6d2e1wWZDaZELcpM+3VcFhRDXlPXw2VxKUzKBa
         64xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d9TDNBlE9LOCCIoo/ZC3FoSnNdXa8lDWsSssw/xuKi8=;
        b=cAMk9CUORUfc/LhTx9F5QGP3ThThM86VT5ld5xnU4+EVGEezvzwL23zAzaBAOXAJe1
         g5ISFQIwYetNDrUleSSVyET2DTVoImKMEf044u2u8eF5wL+Z3D3c1+Uez2p6nnosI4t1
         cu//sw93Sy3aOpxGOiZdqcNlpE1kLwvfnLyW4tj2P8J4KhnmSS0rEhu4pBxBRzJMFcxN
         zUaC4YbpFsj/W6+KMv1KZTh+0d0DuEXflouQglFtRhV+6xUPH2GEIvzHFTGcr250ZoaY
         4DuzJH98c/Z0CfkMMZkNiMDKOwO/1GUMuEPR/2HGO3StgfRcm2bcvKXfjQb6WUpC43rW
         bZNQ==
X-Gm-Message-State: APzg51DUVo5dyGDUcJ7UT/DExyGUHgTRqsI+MgvAjPLit55gul1yw4SL
        hKpBgIFxu+xk8Dc2qzczSf776w==
X-Google-Smtp-Source: ANB0VdZX8LW1YXBy5fOyahMvBiRYl+R4D2EPZHAWtdzv4huEjBrzMnaS+4vktR3fFZyiZAvbYbFF9Q==
X-Received: by 2002:a1c:40d5:: with SMTP id n204-v6mr5923803wma.44.1537514973217;
        Fri, 21 Sep 2018 00:29:33 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id d18-v6sm2841597wmb.33.2018.09.21.00.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 00:29:32 -0700 (PDT)
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
Subject: [PATCH v5 05/22] nvmem: check the return value of nvmem_add_cells()
Date:   Fri, 21 Sep 2018 09:29:04 +0200
Message-Id: <20180921072921.19387-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921072921.19387-1-brgl@bgdev.pl>
References: <20180921072921.19387-1-brgl@bgdev.pl>
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
index 1ced9caa811b..0ef84441ebe5 100644
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


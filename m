Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C488DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5E821547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Nmyx41um"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5E821547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389728AbeIUNSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:18:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40102 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389397AbeIUNRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:17:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id y8-v6so8138156wrh.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 00:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rrkXqSITKs+bXSvh4K/fOwEuHASH/0tAlKDmrUdOv7o=;
        b=Nmyx41um0e7xupLaKrIDpj2WKtTeI6umZiADdUYg+ScHh9Rcid7FV29qoqnh+fjKlP
         4lOFYK10fnECkDtgq82jNz1AQ++hDkeVy4rl1CGCPYFSZFKE05AvmFL7FbU1YBM3SKjx
         IM72FdmyXtzA4RMa7SA0XQnQ67sK9b2FIMsCZ1kWm7cJS4xW4fc5pdMpvAJoCdoFbtdc
         t2+LpzTXSMRaBRYVS0PUx8qL9zFMlAIFuD2y9e8d0WP4UsQcuN60WyMGIuW2G2nN8Ux/
         QNC0FpCEv8NFslCGj02khu6oxY4EbkfUBiKlKdMjeVPY4QHH5GlIENU7WrpG3O8FNQKn
         wV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rrkXqSITKs+bXSvh4K/fOwEuHASH/0tAlKDmrUdOv7o=;
        b=ky+tCMznEt/Nh0TZUElweSBK066fQmSZekooqi5hdKT0fAiNe/f0KQIMG4YHEDnyhc
         TY2RTVQiS7x5hE4MRPjDBtI6/WjvlQf3YNCgP6UXGaGwv3cG0xetjR9FInkIvpZOa+TY
         gNjlXWf6EyLwPCacVWc/7oVuVdjXoHR6xHStGP2GeJhbpsDzDMe4r4lqT1ntPIwh2pfl
         29ezzM5V62IlgznnajNrlrx91ajgJuvrrzUKc101b/9KmZWH1mr7/VJFdBSv0UPAFK0D
         IWlHGoe4P97Ux8O+SLcvFQLgz7koXLrUZ39dhY2Kh2vqQbwWYJM9KKjwgdC0UkLuSUme
         Pazg==
X-Gm-Message-State: APzg51Cf6TcM3H0uzo5rwrki4YzzaVx9fQHQSw9Kcyxiy7dH/FDb8Bke
        V8MB2xRVfWXotcnHg0rOLZHqGQ==
X-Google-Smtp-Source: ANB0Vda2CrwffrLvwl2u80N0gqL2x1jbTzX02dRmDJRKRGTYMF2A/2x9lEVpqA9qCKuQYAvXu8Mjhw==
X-Received: by 2002:adf:fc44:: with SMTP id e4-v6mr10262811wrs.9.1537514971870;
        Fri, 21 Sep 2018 00:29:31 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id d18-v6sm2841597wmb.33.2018.09.21.00.29.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 00:29:31 -0700 (PDT)
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
Subject: [PATCH v5 04/22] nvmem: remove a stray newline
Date:   Fri, 21 Sep 2018 09:29:03 +0200
Message-Id: <20180921072921.19387-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921072921.19387-1-brgl@bgdev.pl>
References: <20180921072921.19387-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are two empty lines between devm_nvmem_unregister() and
__nvmem_device_get(). Remove one.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 0e963d83a099..1ced9caa811b 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -613,7 +613,6 @@ int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 }
 EXPORT_SYMBOL(devm_nvmem_unregister);
 
-
 static struct nvmem_device *__nvmem_device_get(struct device_node *np,
 					       struct nvmem_cell **cellp,
 					       const char *cell_id)
-- 
2.18.0


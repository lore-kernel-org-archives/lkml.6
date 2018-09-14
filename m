Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC21FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBA92083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="J0tuqWp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDBA92083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeINTz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:55:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33529 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbeINTz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:55:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id r1-v6so798073wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=enYwgS0Z/OX0ykxo6KT1YIz+qVBOPAuLng+TvhpgC2Q=;
        b=J0tuqWp78z/kLE8iKSFZ9qTLtR9ffUNnaPhG8bhPBRUa+c3nJcxft2O95gA8Ihugen
         uC23jq4mGvPuJh0uI9e7tpfFNEgQyw5Xrtgg/MhnZpx2S38tc+aVx991nB8a182v3yz3
         uoC5rZp9NGqGMzU1EWu7zxLKgpLotfVIXdPk/yJVEr0iRyBJvKCsR+KUVNFXA5Nd9UtX
         q5sqR6oge4AoM3HjIo8YIWP642CRNNLBdKkFW+1ctOnug5huoJpjmSa1yWdU0BIBbLEy
         SzUR0rpnR5lKp++KfieuQyrgtvORNpNayzO5VPERvyprWFbLl6WmaD7w/iYilKsjDWEu
         b3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=enYwgS0Z/OX0ykxo6KT1YIz+qVBOPAuLng+TvhpgC2Q=;
        b=fjSjV7Jtk7KrmG6M4W1nvLZLg3d2iPgL/LQ6/T1hykWPcQgpguWxfO4cqq0WlZp3bD
         MOkhLFAnnBeaiW5U1vqWj1SEGW0BCJzTD1/YrrVJ9OegmV47wOmXYgv+j0tjm3XpNCzS
         fmW1jMno+smqOVyE+zoIcygL4p1boYb+1qkvvcGgcYiZ+k78Z8k0JOIao2N+oIvyUE6v
         AfEf6bScwkd2EsMgPk+IXHhuMOq5d3nLMakYzN8FPYdV+TuIj9RUzJdQnNh4Ko6M12JQ
         wtowGTESx42nsXDoggzitaKh2aJGfut+ErrizMHjnRmsXg6s3pEE9JVGvIPRMavWsHOX
         3agA==
X-Gm-Message-State: APzg51D5tbH8dev4qfy9DYKzWCSSTHhJy502SXKTjF8k+ovjOb8F2oYG
        cu6tybmJRE5XLXB6xbo36bX85A==
X-Google-Smtp-Source: ANB0VdYSJoaq9YUkUfMrwDJmJ+UhshpcMNt1XhFoxdx3nGoTVcq/P5Nnu19eUdKBLyJ3Bp9dxiWEdQ==
X-Received: by 2002:a1c:1745:: with SMTP id 66-v6mr2530682wmx.38.1536936036782;
        Fri, 14 Sep 2018 07:40:36 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v46-v6sm10313526wrc.63.2018.09.14.07.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:40:36 -0700 (PDT)
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
Subject: [PATCH v4 10/22] nvmem: mxs-ocotp: use devm_nvmem_register()
Date:   Fri, 14 Sep 2018 16:39:59 +0200
Message-Id: <20180914144011.27614-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914144011.27614-1-brgl@bgdev.pl>
References: <20180914144011.27614-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the resource managed variant of nvmem_register();

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/mxs-ocotp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/mxs-ocotp.c b/drivers/nvmem/mxs-ocotp.c
index 7018e2ef5714..53122f59c4b2 100644
--- a/drivers/nvmem/mxs-ocotp.c
+++ b/drivers/nvmem/mxs-ocotp.c
@@ -177,7 +177,7 @@ static int mxs_ocotp_probe(struct platform_device *pdev)
 	ocotp_config.size = data->size;
 	ocotp_config.priv = otp;
 	ocotp_config.dev = dev;
-	otp->nvmem = nvmem_register(&ocotp_config);
+	otp->nvmem = devm_nvmem_register(dev, &ocotp_config);
 	if (IS_ERR(otp->nvmem)) {
 		ret = PTR_ERR(otp->nvmem);
 		goto err_clk;
@@ -199,7 +199,7 @@ static int mxs_ocotp_remove(struct platform_device *pdev)
 
 	clk_unprepare(otp->clk);
 
-	return nvmem_unregister(otp->nvmem);
+	return 0;
 }
 
 static struct platform_driver mxs_ocotp_driver = {
-- 
2.18.0


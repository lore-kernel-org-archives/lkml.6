Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFC8ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4DF21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ax9QBPqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4DF21547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389715AbeIUNSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:18:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52498 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389437AbeIUNRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:17:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id y139-v6so1938650wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 00:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=enYwgS0Z/OX0ykxo6KT1YIz+qVBOPAuLng+TvhpgC2Q=;
        b=ax9QBPqEHiCyAwwF9/F83G6RkY/zwF0zAVw4bJMCA1u1VBs4Vy6ldq+YfmdcLOfzO+
         otZHdHSQo7uKd68dRs9RAOWOR7hV3GfJZ/mwv4p7GArn5WVEicO5U886Tt5k1XQk7IaY
         4e1AmPKXXzgcwKBnbyvkevLCKKG/0J3hNSMG3wQMN+1GpLYdQ1A2iPSjKD4lF9/WlO3y
         qV5Es+vp7uDcxclX5NZeDbY7v9ZHHqd33JWiHlxpPKramRuVO98kBj2Fw+tRWoJwoUly
         /3Ukifj1mwgxhNuGmDv1NnPN++uzZeqaG7JzgXJfHFBKEuM3NmM4ds8lybkuar27m/Xe
         cd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=enYwgS0Z/OX0ykxo6KT1YIz+qVBOPAuLng+TvhpgC2Q=;
        b=Bv4BLjF+hSrUM9uu6o1drqCw/pG2A9n0uly9Ac1IDw8ORJI1xEP/9k8oBXLzG3AF7N
         hJReyWzlNSavBTiqWOoMC6wg4b/TNa9gF57OwuHSiq7UQW/2OOw5yXShdeGWq0GnneLV
         8pw74GuYWl+Izk5TWFUsstd5BpvoNeIz7b6uhwsI6WC9iY9xDfrk0kzgh31359aCKb+E
         9qjDw+7+ZBYARPgR09d0fhePQ8TBzXJiu6E5BXb7M7ANFfTn7CAMArHbuL25/5u87wNo
         AmCk6OwwVdKCId7YoX1BBD0IA0N4HYoOveX0T+YEecIGS+SSbPCgxTpAbuo485u1MvKB
         2Feg==
X-Gm-Message-State: APzg51A1FYMIExjN7H+6jjtDtdYTUyMLRKcFr3E3Rvkj5Se+vbJeZrXi
        yYGlTWP81+3UEcoLT6h6KCIT5A==
X-Google-Smtp-Source: ANB0VdYVG3Hut091dxcPYAon/AW+q0CXTIGK9gN4AZuJZ11+Ckt6Rc5TXLYEijShq/9FbJTyefoz8g==
X-Received: by 2002:a1c:88a:: with SMTP id 132-v6mr6142987wmi.9.1537514979956;
        Fri, 21 Sep 2018 00:29:39 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id d18-v6sm2841597wmb.33.2018.09.21.00.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 00:29:39 -0700 (PDT)
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
Subject: [PATCH v5 10/22] nvmem: mxs-ocotp: use devm_nvmem_register()
Date:   Fri, 21 Sep 2018 09:29:09 +0200
Message-Id: <20180921072921.19387-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921072921.19387-1-brgl@bgdev.pl>
References: <20180921072921.19387-1-brgl@bgdev.pl>
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


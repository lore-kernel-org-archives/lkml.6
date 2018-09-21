Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C52AECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5496121547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="e+TNNLb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5496121547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389493AbeIUNRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:17:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39331 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389458AbeIUNRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:17:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id q8-v6so2035898wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 00:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7pNB/YkN9hno7KdXunbmQOYsXKCGrUI9TMuetzklSpo=;
        b=e+TNNLb3r0E+A+rjJohde9ukPt4XsdbaYNspA8fLg1x7J285Fg2XWo8/NGkqVaCWuv
         MS4ARjZy/MBbOvAHzEG6a5fS8LVda1DzH4Fie857AGtDztGUJEAR1uLLLpSXWNUlJkng
         wRyWNL06Sk9VVgLHPOaXXqsXH5btz959Ke3t0oEGwI4gAx6oi3J/tOdM5IMp6VOWsxOv
         KRX6i324o0q2jozQDph3b/lvJE7ABxysJ385tzC2kzVh+VcuDczjQRP+5pigWYS02xBC
         badCseLVISinBgRzE6gZ1OC/acZbu9osg0x0DwsDbaS2SUEGP106ioIh9ko44DAnJXzB
         M6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7pNB/YkN9hno7KdXunbmQOYsXKCGrUI9TMuetzklSpo=;
        b=ceJiocwva01VlsI9nA5KOlih5NziF2dot5M94Z1LRA8slyvvBPjhy1wxlSE5QsccWx
         A6RtYqKPUzmQym5pgFQxvtewu4Pj9ILWTWOaVgon0IZbSCvIi8AJ078Xvsjay2I0QU1t
         4z1Oebn5FOK1FHZMWGjfd1Xgq60wfJimPapn3BiquR1x0wS8iovduLm9YqcPodahOeZ9
         c+kd6cqTwwg0SgoCgu4EWcjRxLXT/XWV/izUoS+eyaa6gTaWgl3I8QxurvSwgWS1Yug/
         i9LW2IIO3q6mj7Am454/Heo25jpK+/pcjG5JQpUm6ShnMUTGiy2jHdBH4ruuL/PSOBye
         0wdw==
X-Gm-Message-State: APzg51DpLyp9buf9D6aIzkh9Apwg7e11TAKOMz+PiYekg0i4CVyL4oeh
        oYhm/ifmoXgKLFjndDPwq/LgDg==
X-Google-Smtp-Source: ANB0VdZOPAkkhry5s7XS9BMeBWEjzcYT1eW4RHLwems3GiFvysccgYweRBEimNI439E7/4sYKecSkg==
X-Received: by 2002:a1c:4d09:: with SMTP id o9-v6mr6166328wmh.134.1537514976009;
        Fri, 21 Sep 2018 00:29:36 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id d18-v6sm2841597wmb.33.2018.09.21.00.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 00:29:35 -0700 (PDT)
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
Subject: [PATCH v5 07/22] nvmem: sunxi_sid: return -ENOMEM if kzalloc() fails
Date:   Fri, 21 Sep 2018 09:29:06 +0200
Message-Id: <20180921072921.19387-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921072921.19387-1-brgl@bgdev.pl>
References: <20180921072921.19387-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The driver currently returns -EINVAL if kzalloc() fails in probe().
Change it to -ENOMEM as it should be.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/sunxi_sid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index d020f89248fd..4d0b7e72aa2e 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -187,7 +187,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 
 	randomness = kzalloc(size, GFP_KERNEL);
 	if (!randomness) {
-		ret = -EINVAL;
+		ret = -ENOMEM;
 		goto err_unreg_nvmem;
 	}
 
-- 
2.18.0


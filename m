Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C50CFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082662147A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="kVueZXqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082662147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbeINTzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:55:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44551 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbeINTzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:55:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so10866034wro.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7pNB/YkN9hno7KdXunbmQOYsXKCGrUI9TMuetzklSpo=;
        b=kVueZXqzj43Ei3Z1+1lFMocjfG/ooMES8MIemzLkdHBxyGqT+VEsAkbbdYoilTq/VM
         xhxqidCZTA2zjXLS7a/ITVZnZAc+rnxXNjotPFDbXFyDMY6AWSje1CxxdRiSshj44BHK
         jRhqz/35mpC/P4YeFVwqvq//8J4u8Cms6EUdrRzo2ilGg3EM3vHCKvte5yDN1Bv9xqPB
         Uxrmf1IZPmMcOn6sKdYwsdB3UXDEE00yk3Wcso/mf9cNHx4c/7jpiZgt4urzrOqYkDZ3
         otm10MoZyqiJWEs5D1eo3o0Oy2XfyxcJJbCqW2SgKPiob5gaP5e+c71rqqFDoIcRHkMP
         RmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7pNB/YkN9hno7KdXunbmQOYsXKCGrUI9TMuetzklSpo=;
        b=PsEWn77rkQ4aRnlUb1NRqBOpw5uIFbjhw/RUo31z+AMmgYCm95OHF35zDZMnph2jds
         P2mOudPyRlSFVlccQR5urmSR10Opv19g/9kASnncCQuHc2tCHpjdGWXGAA5eQ7w/aRCm
         J9csOOEMzb9qKtYGEYlhX9mLmkk6fdIDnniF6Wt6yrfBvENTBICF8S11D5H5MvguA/En
         SpfAAf7TYRhFO/GQs2Fs3r5ZPgPxyoOMc4iJuPe5WRABXzW49cFwj+zL+SRF/Tah8Gaf
         zFk8T//GeUmR5AixUjqsTF9SoGk1SNcn6NvZiQPG/ClMcnpmGIRjVmlRnAYfQdTav8J3
         lS3w==
X-Gm-Message-State: APzg51CgRK4GkScyOAqhN/kmuWthRNAaOHFgpqzU+60RgQ5gQmyEhZGO
        G/cbJsXaKOi8RQHK9Clr+oi8Mw==
X-Google-Smtp-Source: ANB0VdZGHNWzAEllVRroGFkQVUm1NLL3cKkbyxRGezizukVkvSVhVANUJu6udaTUcIlVq2qbG/SbDA==
X-Received: by 2002:adf:de85:: with SMTP id w5-v6mr10818141wrl.270.1536936032885;
        Fri, 14 Sep 2018 07:40:32 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v46-v6sm10313526wrc.63.2018.09.14.07.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:40:32 -0700 (PDT)
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
Subject: [PATCH v4 07/22] nvmem: sunxi_sid: return -ENOMEM if kzalloc() fails
Date:   Fri, 14 Sep 2018 16:39:56 +0200
Message-Id: <20180914144011.27614-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914144011.27614-1-brgl@bgdev.pl>
References: <20180914144011.27614-1-brgl@bgdev.pl>
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


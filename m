Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDF7ECDFC4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363FF2088F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OJ1gcqKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363FF2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbeILMzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:55:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34913 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeILMzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:55:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so1253473wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LlD+NifSVaE3IfYdeYyWcCIMEiVmFR39vy4y8WN8rv8=;
        b=OJ1gcqKUTo9i439LzMcwsF6etRJBBp4US94hluDxZHEXDWwFhKCv4ZcQD7q20Ed16D
         ZWAfiAxGseknKWlw5zkrsDQBcwZ1rwPQuBjc047bnELgiOFUO0EOhmwmQIvcSxTvPBEB
         szAnPmGwQO0YBKF/xFGJdEpuKXM3S9nLsrzjjWnHujj1+nRAingIb/97B+dXF8zwV//k
         kmA2b7Y/pWm7Fj9XDOP4ey8U/3FJOdpMAcllYBvuUBW7+9MMQATrU4H4EuShkWTbJzAO
         dZvZuTuE+lYJWU2KZnDIoKxr1u7Re/bB85lpgwsDRUhJWEd8JtCA2Pit9ZJTI79co3H9
         0bCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LlD+NifSVaE3IfYdeYyWcCIMEiVmFR39vy4y8WN8rv8=;
        b=OnoCj6iVQ1798Wtce2bfh9j8bwS484SPH2rR1Eum5yFq4BV6g0JNK7RMie6xiBE7gW
         YtgdXTldX37hkTzyCu2vo33+HYQ/Ea/O73cmZN0sJqa+FFttMnprPwKz7PetNf7en98N
         bgwtA4HjPPBmkr4sGfnh/7J/EBiEIBwZGuWGe3nvgPdNcIWiM8vBdIX/3vpci1dIAArD
         RHypx28D/m5wdVpnqTeAH+dtXYGidIpjtZSGBlvJNhdvHL7T/sg964xEyUGfFP/nh0hN
         /aZF/9m2yjaI8zKcrmOGSeQqJgyba+AioPPpEu9+ic1GPvibtZgq8iALyV30Ahk1NaJe
         wTuQ==
X-Gm-Message-State: APzg51CiGs696zsHX+V6L55NE1NF8fOZYbXxCYcW03rT3ig3i/aIlNaM
        EmFhGEMpappJ5QELJHIgQoCuOQ==
X-Google-Smtp-Source: ANB0VdYzXxZCwxoeF0Ng8W5MFFsYuUnxyL1JI3gJ+sW6XcEdvJoNMGndDT5TueCa37rM6Xxt8S9FhQ==
X-Received: by 2002:a1c:1a48:: with SMTP id a69-v6mr711877wma.43.1536738707218;
        Wed, 12 Sep 2018 00:51:47 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id l7-v6sm169341wrt.67.2018.09.12.00.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:51:46 -0700 (PDT)
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
Subject: [PATCH v3 04/21] nvmem: remove a stray newline
Date:   Wed, 12 Sep 2018 09:51:12 +0200
Message-Id: <20180912075129.25185-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
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
index b69005367908..b469f700c699 100644
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


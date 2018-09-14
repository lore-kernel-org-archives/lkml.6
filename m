Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFEAFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06D52147A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="kwvO6hHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06D52147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbeINTzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:55:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43422 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbeINTzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:55:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id k5-v6so10870881wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LlD+NifSVaE3IfYdeYyWcCIMEiVmFR39vy4y8WN8rv8=;
        b=kwvO6hHYoVK6Et8cqODz+uSJyw1JFE+9rpWKLTKOJIcAVd2k7gjQONwAH/NfmRbOaw
         9BDngcuqhDI4WF49FltrihGy9WKTau6EXGhZ7ZAIQDrZAw5uJWWKQbeNH8RLcyxi2Zkt
         rdmhEe07bXSLeeR0NTNfU5ukqdz4bmf0wZUKs8lMutBV15+L0778Kv7kABmE8s8YAwAp
         +MtAXmf1dFcS48YThM6WcKUDHTrwuatE3Pw8VtqenpZuLRtHIgj/SFy3uXKYwYnBArC1
         D+8NyRoXa/zy/dbdZZnhwNSX64TlFzJKsuWNmjuQX6oWWz2Ym4e1cEl3pyFdWcGJqo+B
         m1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LlD+NifSVaE3IfYdeYyWcCIMEiVmFR39vy4y8WN8rv8=;
        b=APl0bBGKA8ubB83+56JQ50BdwuUa6pPCLwacMUFCP9MgTygiv90sbz1lO6n9B3OoRu
         PE/7h4p4jFFNXNLitUFdTQJSkvKTVhw8rNdqUHNxn2pjQ0+IzEKoiRn1cfSgVQzMotBP
         lKIvZvZU/THzqIhsmHDGMqDJoZHYjaTrvVyBnNgJoLrgYIEBZOTJzFJN9GcsxXnw/JOI
         1ARMZKpgZUwSgJzv4nnjGjMrYhH7heiwkxGqHuCGtaR0Pr9C/gtv4mAwk0TjLA81b8UY
         xjw3ECawNf49OKe/0Y03OuHwZU696t3IXt8X94gL0VyBsXS7oXG7zw1akuGTpmyInQNp
         LoYw==
X-Gm-Message-State: APzg51AemDZ4ttbl1qeTk9y0jwCuZ28CmQXgSW5F1jayGZZweke3nrrC
        T9kE2RTUtLXG8FPY7qJUUJAs7w==
X-Google-Smtp-Source: ANB0VdZQu68ZpJmiUaYe1juj2SGgRn9JjIQ/XZgmIF8uHv3fD8J57t71s404Jw9gEreKHVsXuwxVeA==
X-Received: by 2002:a5d:4605:: with SMTP id t5-v6mr9322475wrq.200.1536936029060;
        Fri, 14 Sep 2018 07:40:29 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v46-v6sm10313526wrc.63.2018.09.14.07.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:40:28 -0700 (PDT)
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
Subject: [PATCH v4 04/22] nvmem: remove a stray newline
Date:   Fri, 14 Sep 2018 16:39:53 +0200
Message-Id: <20180914144011.27614-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914144011.27614-1-brgl@bgdev.pl>
References: <20180914144011.27614-1-brgl@bgdev.pl>
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


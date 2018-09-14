Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66480FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E352147A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tdVj5GlF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E352147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeINTzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:55:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34538 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbeINTzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:55:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id g33-v6so10912904wrd.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=To/SQLBCgeq0lnY/26X7cnEpcdLcDIuj/UXMlG3uaxI=;
        b=tdVj5GlFefhU/37/xmsD4OR3sD01gWfqXfUwQmv5zNZwJSFt2uqRm5yb6o7rW76NCZ
         1qg/VipmX9svIqIc8Z7IqPIL8gHhaME9b7uYY0Pvh42UBIAP8Sc3qRnK5Hbg1qPyLZeL
         WAwAWvs5lRICPJh9D2VSTKMTI2zs6T472BRFt/FkEIyNR61BNlubIZsUPFdCSb0KO+sD
         tfwGqz7ZM3CX+sIRvBhzVLPEwAIjTyVTSGwMMRIGOLFbmO1KTPCuNPNphdi36RxZwwxK
         ghXiQF8gH7UEbjkP3kFFVNwoWBt0flBCjlq+bkvY+ZJ3AuOnvVrryfHmQjjjg4r+gV57
         gNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=To/SQLBCgeq0lnY/26X7cnEpcdLcDIuj/UXMlG3uaxI=;
        b=PHyaNDfgsiwVhWsm9DIMLdrKfIEcftyIeXrI7l2V86Gxw9kPA0MIdyk2mr1wU3UOma
         NOFx0L1VlaQb9QlFLcN2J85+guwmerk7mo1GdD+WlXCPkNjqcnbW8c19VhmvWsrkm0/x
         BStP0UIl/AEysUITn/A1yZhYH3K3J9mPVqAG1L8vMPX6xzwVEHMpUM87d4oGsWZmC3Yb
         KINGrF0WlurkUuGuqnYjD9Nk3VejT8mh3WTsZxIfXN/lj0s/G4BUhBn+Y6uzY1qOWo2q
         40Bqix50hcIHIx6ZRldpUAAxoj5t4SdUqVV66TiILHmModgkgODAQdusypeodTCt870C
         Yx/Q==
X-Gm-Message-State: APzg51BUXxWpJqtFVn72MLJL/aCo4Tj4vbmZUmhG6zCMkOsurUObHEL9
        jU2KF1azpJEl5+cFqXMS/CVYWA==
X-Google-Smtp-Source: ANB0VdbD5bR5nBTiU0E1EUKOniCAUGLi2ZPGC0OFUhyuP64ZlGD5Gitk+ZwXUBvxo+rNE7I2oEW5OQ==
X-Received: by 2002:adf:c684:: with SMTP id j4-v6mr9968773wrg.243.1536936026440;
        Fri, 14 Sep 2018 07:40:26 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v46-v6sm10313526wrc.63.2018.09.14.07.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:40:25 -0700 (PDT)
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
Subject: [PATCH v4 02/22] nvmem: remove the name field from struct nvmem_device
Date:   Fri, 14 Sep 2018 16:39:51 +0200
Message-Id: <20180914144011.27614-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914144011.27614-1-brgl@bgdev.pl>
References: <20180914144011.27614-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This field is never set and is only used in a single error message.
Remove the field and use nvmem_dev_name() instead.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index d96348ae0f37..8987da0f7456 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -26,7 +26,6 @@
 #include <linux/slab.h>
 
 struct nvmem_device {
-	const char		*name;
 	struct module		*owner;
 	struct device		dev;
 	int			stride;
@@ -652,7 +651,7 @@ static struct nvmem_device *__nvmem_device_get(struct device_node *np,
 	if (!try_module_get(nvmem->owner)) {
 		dev_err(&nvmem->dev,
 			"could not increase module refcount for cell %s\n",
-			nvmem->name);
+			nvmem_dev_name(nvmem));
 
 		mutex_lock(&nvmem_mutex);
 		nvmem->users--;
-- 
2.18.0


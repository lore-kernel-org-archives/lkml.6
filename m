Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DD5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630D020861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Ql67q/cv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630D020861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbeIGOsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:48:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39521 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeIGOsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:48:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id s14-v6so5399278wrw.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 03:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OkoqiLjbJSODXJoiTP2mWCeOVuHWiRrCaV2oGASjKkw=;
        b=Ql67q/cvaDNfqNAJLZ2meBMvoRpSakM4XzL+fx23NO9k4x8rlyCD9s3n5YGDwet4/2
         iwdk4tqwtt4FCURfcLMyJFJwG6Q6kvQ+uOtEiaLai1wldC8Ulu6OmBujeN93eoKQ1z+B
         K/jBklhrhuywVD6BztEtZjiZOWTwXjp/RfJhrtWWbgmLZ504+93EKiyBW990DdHipuKA
         ZpJy0tvsvkVk4IX+7MpqkklIA7YmQ5JPfmtiZfNnkbubr9fH1w+vUe7jx/oFy/MyK1o0
         eGZH0fXT1HoXSZ1HPwlUbQ/m6r9xvIq0/g1yjo72/4J1Qc5l95XljX1MV5npITdl2Gz6
         yp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OkoqiLjbJSODXJoiTP2mWCeOVuHWiRrCaV2oGASjKkw=;
        b=jCVLSu/qnMw65VLwLG4T3zlrTWUFVhCa2dNBewGtpInrqD6YC5MT+4LN2yhR5+cqkj
         O8JOuHHCeLREj1TEjaMboDpB1/7ahChpZvR9UDoDmr0gdXOn9VeFRWzlPfstHcC3AJ6x
         C7tVYxYq5NaWbYrwqQJVgsNmAZyWIVtqeeS6E0NiEdD8AQUUtgup08Szj1Gx/9brt5Gu
         IIHdUdwsqMU8JRnOli3NaSfhxy66016ZJEbSx4ERxw/Y0ulz7Xk3p8aHZrQkCEB45HlE
         4xWrdamzTqmBKW/y1zPwx4cP96tw/r64lGDuWB+6soKrFWhe6wW/4/XFY/Aq7ZDFDsyj
         jfIg==
X-Gm-Message-State: APzg51CSvvExOpC+J5n9zSh0Fb9buUPuPWq11TqK3qZhH3sS0J48Rk/3
        LypqKnxBLqVMBIhqeQnspfXadw==
X-Google-Smtp-Source: ANB0VdYrylm9/VwbLuJauYWuDUOk7RPP+KGu7xOSGEhxwmNnT4Jsl1L7HVUtvaGQhQLzXZcMdumofw==
X-Received: by 2002:a5d:4a44:: with SMTP id v4-v6mr5551176wrs.278.1536314901286;
        Fri, 07 Sep 2018 03:08:21 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-83-232.w90-86.abo.wanadoo.fr. [90.86.25.232])
        by smtp.gmail.com with ESMTPSA id 72-v6sm6631619wrb.48.2018.09.07.03.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 03:08:20 -0700 (PDT)
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
Subject: [PATCH v2 02/16] nvmem: remove the global cell list
Date:   Fri,  7 Sep 2018 12:07:36 +0200
Message-Id: <20180907100750.14564-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907100750.14564-1-brgl@bgdev.pl>
References: <20180907100750.14564-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Make each nvmem device the owner of its nvmem cells.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index bb475c2688f9..86af62e2df47 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -38,6 +38,7 @@ struct nvmem_device {
 	int			flags;
 	struct bin_attribute	eeprom;
 	struct device		*base_dev;
+	struct list_head	cells;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
 	void *priv;
@@ -58,9 +59,6 @@ struct nvmem_cell {
 static DEFINE_MUTEX(nvmem_mutex);
 static DEFINE_IDA(nvmem_ida);
 
-static LIST_HEAD(nvmem_cells);
-static DEFINE_MUTEX(nvmem_cells_mutex);
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key eeprom_lock_key;
 #endif
@@ -284,29 +282,25 @@ static struct nvmem_device *of_nvmem_find(struct device_node *nvmem_np)
 
 static void nvmem_cell_drop(struct nvmem_cell *cell)
 {
-	mutex_lock(&nvmem_cells_mutex);
+	mutex_lock(&nvmem_mutex);
 	list_del(&cell->node);
-	mutex_unlock(&nvmem_cells_mutex);
+	mutex_unlock(&nvmem_mutex);
 	kfree(cell);
 }
 
-static void nvmem_device_remove_all_cells(const struct nvmem_device *nvmem)
+static void nvmem_device_remove_all_cells(struct nvmem_device *nvmem)
 {
-	struct nvmem_cell *cell;
-	struct list_head *p, *n;
+	struct nvmem_cell *cell, *p;
 
-	list_for_each_safe(p, n, &nvmem_cells) {
-		cell = list_entry(p, struct nvmem_cell, node);
-		if (cell->nvmem == nvmem)
-			nvmem_cell_drop(cell);
-	}
+	list_for_each_entry_safe(cell, p, &nvmem->cells, node)
+		nvmem_cell_drop(cell);
 }
 
 static void nvmem_cell_add(struct nvmem_cell *cell)
 {
-	mutex_lock(&nvmem_cells_mutex);
-	list_add_tail(&cell->node, &nvmem_cells);
-	mutex_unlock(&nvmem_cells_mutex);
+	mutex_lock(&nvmem_mutex);
+	list_add_tail(&cell->node, &cell->nvmem->cells);
+	mutex_unlock(&nvmem_mutex);
 }
 
 /*
@@ -423,6 +417,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			goto err_device_del;
 	}
 
+	INIT_LIST_HEAD(&nvmem->cells);
+
 	return nvmem;
 
 err_device_del:
-- 
2.18.0


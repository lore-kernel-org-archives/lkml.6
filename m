Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65437C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F73A223FE
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JyjIVura"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F73A223FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeHJKe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:34:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41050 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbeHJKe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:34:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so7454802wrr.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=paBZJybUvvxWZ7I1PKX8NyqdoyvAh8f59AsdTQsxQjE=;
        b=JyjIVuraEgVEhK5SRVFay0GN4fUY9203oBblBwmIW7ZZ4OdK8tsCQso3CQsJbNTdIC
         zFZYNw4dGp+6ZtDOm1bXtDQQ5Pdc2+4SP7IRR6tQjk5VFUiCh5sa/kDYUjOJEQO2x9Zl
         2h+sE5hE380ywLdTfzvTgCVgFuvXxOJTh3bmwhSY8ivhBoWApOE1UBSYDMyP4nzTKnLy
         8vuROWjc+lmUev6WXIB9/5yBbFOKxJIouB3qqfKp0DF+DGaKV/T7FHsNSwrqE3S4TiU+
         SVquCkZ6Sm8ltaOC1KOAmRtabfb5mvYJ+PiJByY3+RmldnsUI82Q5PRrgGb8WdC1hcKC
         W3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=paBZJybUvvxWZ7I1PKX8NyqdoyvAh8f59AsdTQsxQjE=;
        b=ho8EdtEJmA7BtELAscZ6Co3CyoikEyuJAMVkm8Pf3MX4bPsV/xE3UK4wmKiXlGOsLh
         +TNitHA5SW6Fp9gp5ZxZzRYouE5kwSaLLEQoFIut9MF/dN25bsRzJZbTqZiALUwIpwzs
         5RnlKD/0lqbl/U/rTDYKaV2V26hh72nz6XPF0t/id2Lh12yAkS7LpbsopvYKApnJ1TOE
         Gyv9qGbo1+kB+aQ0GNUctLNsu6saa8UauD4T6Ckr67ZACUs/AQa8NgDvp6rNHjB7xW4b
         220ld7oOYV20m2gITu8EOOFfY4tEGGeTxnn+1QWpVG33UuSjZhkPCCS6hF1viulUw4jL
         fDDw==
X-Gm-Message-State: AOUpUlEVwSgTtf1tP2kFN5ttOBghaWegG1ZFo7u4msrpNNxxmbDtkz8J
        vu6bvpOJNV4xK0K6sZzMI/3J/Q==
X-Google-Smtp-Source: AA+uWPxPcUpQhBROdDATdjNUBaS0soH9ECmya+4jv8PLxdtymCewzYsuTuTaB/510RDrzB3C8+q4sw==
X-Received: by 2002:a5d:458b:: with SMTP id p11-v6mr3507964wrq.122.1533888341327;
        Fri, 10 Aug 2018 01:05:41 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id h7-v6sm9546405wrs.8.2018.08.10.01.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:05:40 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 05/29] nvmem: remove the name field from struct nvmem_device
Date:   Fri, 10 Aug 2018 10:05:02 +0200
Message-Id: <20180810080526.27207-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
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
index 31df2e6d6f72..ab3ced2d9a84 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -26,7 +26,6 @@
 #include <linux/slab.h>
 
 struct nvmem_device {
-	const char		*name;
 	struct module		*owner;
 	struct device		dev;
 	int			stride;
@@ -712,7 +711,7 @@ static struct nvmem_device *__nvmem_device_get(struct device_node *np,
 	if (!try_module_get(nvmem->owner)) {
 		dev_err(&nvmem->dev,
 			"could not increase module refcount for cell %s\n",
-			nvmem->name);
+			nvmem_dev_name(nvmem));
 
 		mutex_lock(&nvmem_mutex);
 		nvmem->users--;
-- 
2.18.0


Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08FDFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D1B20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="isCJL/Wk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D1B20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbeINTzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:55:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38216 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbeINTzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:55:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id t25-v6so2185572wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BVLbSgd1wb/HwG+kDXFY/KlS+ziWt1RndHQUeQC7kyc=;
        b=isCJL/Wkrqg/c5ZnUFCwrlHeC9e63kQRNS6yYITqXuUTzi9QUeW6m+HdSMO9dQBR+s
         TxAAc9+P9B+aCEivV821qkKzwY3LqqcpZRYDaz36fhZD4dUvils+SpeAbinPeITPpxdJ
         sS298vBLKyU1GEdjBAr1twcJsgbnzTvE4HrHAKX6mbZL/pOSv/tgjZQ1xh86H7/e0Q7Z
         J9+BTfK7432MpILwQKzOoJnSODVAZtSrzDwSkGKnJIpT7LJlS68PAGRsZo6Y/w0qk2kF
         On2Kexn7IIt0YbK8WzL9AjLxEuCelCqvtFel898oddUyfNCa03lWO90I912KwtLgPa77
         AvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BVLbSgd1wb/HwG+kDXFY/KlS+ziWt1RndHQUeQC7kyc=;
        b=oZ7xrPVaHxcf6JdXq5qcIsanI3N8QWKwezR6d68n63d8S0n1HevMlzztDEtL9n54Mj
         ApTllditMSBLXsXiKdI+M5himJOlbDYeK5NB0+vNi0wSX6v0h+G+LnVMv8NgP8wgrzdB
         Pd65lwjwj/+9DEgH8AFFLmDbG/YO4N+k9ZHnE85q2V21RU3XXHmBMblN7CJfonMy04NO
         IzdsaxH9EiPRzRWJzQMika4WSzCNLTp7qPiqy8yrPaa0m129DUWNiKDkjk0xOu9QW5Ws
         46jhwRmGtrXQPRMZO2KbeQ831XTvtg7y6WZ/wGjkR7bidU4jWofJ/l0P/xlXmWmF8UHd
         snyA==
X-Gm-Message-State: APzg51AObKZPe5mXV7PUo3jssdR9hZIZ/F62OSX/sece7PVa6LlckCY0
        Y47I/ZTzTJi1HTJhAd+Xvffd5g==
X-Google-Smtp-Source: ANB0VdZVGm4cyztOffbnujLBEDL5C92pYxxkPPUE6lJlaTWeO+l+BV1X/QAp3WYc0wZ4Abd5iZ/s0A==
X-Received: by 2002:a7b:c10c:: with SMTP id w12-v6mr2655589wmi.132.1536936052981;
        Fri, 14 Sep 2018 07:40:52 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v46-v6sm10313526wrc.63.2018.09.14.07.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:40:52 -0700 (PDT)
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
Subject: [PATCH v4 22/22] nvmem: use octal permissions instead of constants
Date:   Fri, 14 Sep 2018 16:40:11 +0200
Message-Id: <20180914144011.27614-23-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914144011.27614-1-brgl@bgdev.pl>
References: <20180914144011.27614-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Checkpatch emits a warning when using symbolic permissions. Use octal
permissions instead.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index e44a1860a2b3..ad1227df1984 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -154,7 +154,7 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 static struct bin_attribute bin_attr_rw_nvmem = {
 	.attr	= {
 		.name	= "nvmem",
-		.mode	= S_IWUSR | S_IRUGO,
+		.mode	= 0644,
 	},
 	.read	= bin_attr_nvmem_read,
 	.write	= bin_attr_nvmem_write,
@@ -178,7 +178,7 @@ static const struct attribute_group *nvmem_rw_dev_groups[] = {
 static struct bin_attribute bin_attr_ro_nvmem = {
 	.attr	= {
 		.name	= "nvmem",
-		.mode	= S_IRUGO,
+		.mode	= 0444,
 	},
 	.read	= bin_attr_nvmem_read,
 };
@@ -201,7 +201,7 @@ static const struct attribute_group *nvmem_ro_dev_groups[] = {
 static struct bin_attribute bin_attr_rw_root_nvmem = {
 	.attr	= {
 		.name	= "nvmem",
-		.mode	= S_IWUSR | S_IRUSR,
+		.mode	= 0600,
 	},
 	.read	= bin_attr_nvmem_read,
 	.write	= bin_attr_nvmem_write,
@@ -225,7 +225,7 @@ static const struct attribute_group *nvmem_rw_root_dev_groups[] = {
 static struct bin_attribute bin_attr_ro_root_nvmem = {
 	.attr	= {
 		.name	= "nvmem",
-		.mode	= S_IRUSR,
+		.mode	= 0400,
 	},
 	.read	= bin_attr_nvmem_read,
 };
-- 
2.18.0


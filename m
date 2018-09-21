Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BE3ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DE921531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="a7QRAMB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DE921531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389666AbeIUNRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:17:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38400 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389641AbeIUNRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:17:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id t25-v6so2044142wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 00:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BVLbSgd1wb/HwG+kDXFY/KlS+ziWt1RndHQUeQC7kyc=;
        b=a7QRAMB9IE3DmEB5wR9u0Mt99su5XgEX/eTSBxVzD+M+bK06knYXrB2nIVT2TrxduA
         cUZpYJT/MtPZGgRFdqhS3VLRfcRcvCIu8rOeBVci9f34nd0gNHLtOhCv0hvmNRxim+Zs
         N1F0OitgHNVVuJXUKYn41+enR47CZXFOfhNSjl+WQCYpUcfM2G3PjZg8P3cKNxx0N0nH
         cUVKQ7HE1bHexVouHgE7NLJHxco3s/lw1oBFde6xCYO9/sx9sefjGHBUwhSpHRid3KpO
         XiNuNrgJvpBL2FO/qX52yNNrM76OxCcgHsUwLRQygt9FnT5HABpcyNgjomN7GnCg7VR/
         x5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BVLbSgd1wb/HwG+kDXFY/KlS+ziWt1RndHQUeQC7kyc=;
        b=TEpzEqHKr3o7a1Qua9mZXNXUsy0dwNWQNLo3dZDBmK9n2CKXHn/OqEHeNGP/iFG400
         jjaBjDEkJzNs3N2AJ2ksMa3zpTB3IctCubkXumN+J62GbYLfd8kHlGl3Bx1Rk5Fcbih4
         /HzHS3I+UyQPAfe+JOqd8GYb/mWmDpwOlVmGXt6knDhw4qw+uJN1VTVtItjrP+jyyixI
         zFSXxGnDXZY3uBrdpT4jWfbY4Majbf/DchPspSVjoEL+1dYWqzf9JMzXd+Ne66UsUxZb
         3mQXyeOAWEhRU12MCCp3bRpmhJlfgGmjKQMPAG9OVsOaHP1mXsTuV5gfJVd71oLoqMMU
         sgVg==
X-Gm-Message-State: ABuFfogBPUTPlVcOgZSjfP/kBwmxiAOZ5+O3ooXtQ2JluUOHUA4ZRLIH
        +D8BpRQ/MU9hUYJkxtISO58gZg==
X-Google-Smtp-Source: ANB0Vdb9HGryc4tNeEoea1LbGzQw/ODvtG/TZj55AVd1yReHsffG/W5gOhQeQ/w4gT8U+wTGGaLr3A==
X-Received: by 2002:a1c:e00a:: with SMTP id x10-v6mr5954422wmg.58.1537514996394;
        Fri, 21 Sep 2018 00:29:56 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id d18-v6sm2841597wmb.33.2018.09.21.00.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 00:29:55 -0700 (PDT)
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
Subject: [PATCH v5 22/22] nvmem: use octal permissions instead of constants
Date:   Fri, 21 Sep 2018 09:29:21 +0200
Message-Id: <20180921072921.19387-23-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921072921.19387-1-brgl@bgdev.pl>
References: <20180921072921.19387-1-brgl@bgdev.pl>
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


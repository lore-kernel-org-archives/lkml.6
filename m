Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01909C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74AF2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pXLEyYVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74AF2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387686AbeKNAAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:00:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36543 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387583AbeKNAAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id s11so2180370wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0uqZU8gDHiv/neEGi/hrgDK8MU/UOgRvLZjvxfNOd/I=;
        b=pXLEyYVi7xk0SDGCkD5Y1ijc20sYg43PO7FF5Ii9S7OMZMW80DFLiF+kCgRmUqxyiR
         o3bcuXYEa54fs2rggnBxWAa6iAM1kzvQVzhkWPUHnelnFzHhILejvVhWx3g3manDZ4xt
         Gfnhk0eLmrS2IAfQOJzCRBqP0kv1oT19u8VW0XkrHrnp+fob5e5aBYD4fbbBooLGPnOR
         a+0gn4pB9BDdohjzrBwvryRKmanWXkSSMBqmskFsDMAD2SaaseafMiaCt4zHSYjLLWbc
         C67jmWgjPFs5Lw0Css3+YkWBhQHRvMdQbfWwM99LWk0Y0ZB1eZg4dXVgb1y4EvJWfVEf
         fG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0uqZU8gDHiv/neEGi/hrgDK8MU/UOgRvLZjvxfNOd/I=;
        b=Bvq1y5ZJ+aINeVvRwtkZFq31diaFUMNK+yU6/ZY5QMVJIWbddJVw4m7o/JLLJud23E
         mbhqR1WAp0rUamS+faWpihTaSn76simu8vxO197gGfS/HALjEw+B4xvY6iNDOpVwMCzI
         26ll6mIJ7W/1BaQGKosgya/FVoYj2xEKOQnJHW+DQNRn2SlZQjWP8+lOE5x61rKcOUCZ
         G1bWpudR9u3MCtT7/s9tEbR6f5jTkQhcU+OFQE1kr93KPqhfBTYp94ivzLBKnmqOzTnA
         lqmqvF8yUobHipxJ1mhlHVUtIYe2p159BWER/RlrFc9kDuAi8g05w/gXwgUuS+xdVlpP
         6q8A==
X-Gm-Message-State: AGRZ1gKVawUf8gEvOcA6zsQAM3tedglVhu4AQn82xYMn7nyk8q8qEgqE
        Y741/73AH8m27+TC8qRHjPHe5A==
X-Google-Smtp-Source: AJdET5cGhZk6/cOVbPrvR9ypywUUj8C/WS5YdF9VjGZLtBZXxc7blVkWSGEcBSlK5+2a4sBzMvRZVw==
X-Received: by 2002:a1c:7fc1:: with SMTP id a184mr1113108wmd.55.1542117715063;
        Tue, 13 Nov 2018 06:01:55 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:01:54 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 01/25] nvmem: add new config option
Date:   Tue, 13 Nov 2018 15:01:09 +0100
Message-Id: <20181113140133.17385-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to add nvmem support for MTD. TI DaVinci is the first platform
that will be using it, but only in non-DT mode. In order not to
introduce any new interface to supporting of which we would have to
commit - add a new config option that tells nvmem not to use the DT
node of the parent device.

This way we won't be creating nvmem devices corresponding with MTD
partitions defined in device tree. By default MTD will set this new
field to true.

Once a set of bindings for MTD nvmem cells is agreed upon, we'll be
able to remove this option.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 3 ++-
 include/linux/nvmem-provider.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 9b18ce90f907..ac7971e8154e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -604,7 +604,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->priv = config->priv;
 	nvmem->reg_read = config->reg_read;
 	nvmem->reg_write = config->reg_write;
-	nvmem->dev.of_node = config->dev->of_node;
+	if (!config->no_of_node)
+		nvmem->dev.of_node = config->dev->of_node;
 
 	if (config->id == -1 && config->name) {
 		dev_set_name(&nvmem->dev, "%s", config->name);
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 1e3283c2af77..e53545e9852b 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -30,6 +30,7 @@ typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
  * @ncells:	Number of elements in cells.
  * @read_only:	Device is read-only.
  * @root_only:	Device is accessibly to root only.
+ * @no_of_node:	Device should not use the parent's of_node even if it's !NULL.
  * @reg_read:	Callback to read data.
  * @reg_write:	Callback to write data.
  * @size:	Device size.
@@ -53,6 +54,7 @@ struct nvmem_config {
 	int			ncells;
 	bool			read_only;
 	bool			root_only;
+	bool			no_of_node;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
 	int	size;
-- 
2.19.1


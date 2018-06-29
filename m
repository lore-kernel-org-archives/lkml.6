Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AD3C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A4727C92
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wr4HQRE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A4727C92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966784AbeF2JmT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:42:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55056 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935746AbeF2JlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:41:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id i139-v6so1470253wmf.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jOLtKJCxnJbnqKQvbWA8E9QMQLQ8bmWHWXbRtOMMgfU=;
        b=wr4HQRE3sMQY+zKu7CjA9b7W9TER2hQBDLtm116esFdNjBLUiBY4fQ1VEmeNxpYzNF
         E2b15rEDJO0c9Whj6g7dmGFwwGS/BloSSrDuQyLHkTuA1pwDwFIidB9sQ5wdQRE3vvLy
         ft4/ZcoZPENLzb63M0qXOQwiZWafZFvyshkX0723qv8ulttkacldr8pcNjNZK8tABZmq
         1v5ggrCcNB9XUb0qyuF1MV5/mO91LNelRyBIYnMO55y+FOyX5f7uN8tvFZozxVdSQTkS
         fyZ2335/E/aFEAiujw+oAwlEf4R10xzr5IQS0ehGO3FXV1GUhovAkQM9S/wxVSIEuMkU
         LpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jOLtKJCxnJbnqKQvbWA8E9QMQLQ8bmWHWXbRtOMMgfU=;
        b=mD88b0FBqWKdRwUWYYgLNJGf34HQ2Q69HaK+bX2Fi/6ZqP0864glmJKLNYH3TIbHRd
         DrEFiNkwPdCDTLttszmsCJVBrfcdkbmb2fzvihnkz4Y7tXmn/Q8DSoeW+yoh72Kcf+k/
         XKDEYqm3plzxVFcEaD9AY/OkGGOY2ZE7Np2r4sdOxTw6WKl+EQVGfoLwimaRLaxyAy88
         NDL0BXdi+nQKQM1B9aueFeBMQ1yCMqoVQhUv+2s0mLT4Xoh5+dVkT0szLvhuU3MpfKp8
         B5WYmJHzuNXuczkWI1tc5Qt3+itS3lD8PBE95xDzv8DvRSfWbli/ahdQJuiEVUtWBekR
         WoDg==
X-Gm-Message-State: APt69E0Vo6DBgGl9zIS3jUD0tkTQUG1cCBPJYRfaEkl5Kcr3UEMW/4b2
        t0EiM6/Fn9tDXQD1rSfmR/rR/g==
X-Google-Smtp-Source: AAOMgpesV0a0XXZEvpYWn+GihtzTXVYTNl3lHZbM8pXZZtQPhUDZnjaGBZj/6qnA6OaQ3NQKzM15FA==
X-Received: by 2002:a1c:d812:: with SMTP id p18-v6mr1280072wmg.92.1530265258872;
        Fri, 29 Jun 2018 02:40:58 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id d102-v6sm1386394wma.10.2018.06.29.02.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:40:58 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 11/18] ARM: davinci: mityomapl138: don't read the MAC address from machine code
Date:   Fri, 29 Jun 2018 11:40:32 +0200
Message-Id: <20180629094039.7543-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629094039.7543-1-brgl@bgdev.pl>
References: <20180629094039.7543-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is now done by the emac driver using a registered nvmem cell.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index b5be51c0451e..5c0a0557a361 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -120,7 +120,6 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
 {
 	int ret;
 	const char *partnum = NULL;
-	struct davinci_soc_info *soc_info = &davinci_soc_info;
 
 	if (!IS_BUILTIN(CONFIG_NVMEM)) {
 		pr_warn("Factory Config not available without CONFIG_NVMEM\n");
@@ -146,13 +145,6 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
 		goto bad_config;
 	}
 
-	pr_info("Found MAC = %pM\n", factory_config.mac);
-	if (is_valid_ether_addr(factory_config.mac))
-		memcpy(soc_info->emac_pdata->mac_addr,
-			factory_config.mac, ETH_ALEN);
-	else
-		pr_warn("Invalid MAC found in factory config block\n");
-
 	partnum = factory_config.partnum;
 	pr_info("Part Number = %s\n", partnum);
 
-- 
2.17.1


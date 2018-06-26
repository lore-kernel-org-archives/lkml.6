Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B43C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1499C2560B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OwQn7Fw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1499C2560B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935065AbeFZKZt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:25:49 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42639 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934771AbeFZKX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:23:26 -0400
Received: by mail-wr0-f193.google.com with SMTP id p1-v6so1068554wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x9tAz9TB7Rhx1eB/dgg8uF02oHbyRX2HTzlv5KIKThU=;
        b=OwQn7Fw4iZDmBVfKh/AorNfgjPDWzYYEXR7HARB8jogPtJrhILeDv4fCkzWG7JojDx
         9dC1+7fzVl3n30oPneDjkMod/LwXFZi46gAWaYBpVqPcC0riJODYIjixXxe0MMxI7Ghk
         EFI692j9LODAxYw6dWFZYMfAt6emoaO5UxO5tFt6DTgXKGVdVuSVmX7WjN9bv2U3bERK
         nYizMGDr1ljdzwPTMhaoZxcQTsY32QCEeS1R7Zh+VIyGFdK43BKJ+3avLLRJN+/21xPb
         51/kqkualvED3OAwaJlV1RjRW3dO8hRjzNIM3xduEULiZA56b59KcB82eMVuTFpEzZ5K
         JaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x9tAz9TB7Rhx1eB/dgg8uF02oHbyRX2HTzlv5KIKThU=;
        b=N+ll2MFfqdejjkr08GgHcy97pDL4VvjB3GoaMxMxx/002fczzeiSKKF7fAMvk/XE2t
         F50OnDSouPTlxCLSKy3tLnukFiZ4hxPhhFC/2si6CC2FzdTjGO4SIpGVuqccxdhPiJAD
         K+wU50uH0YU2ziiNhPvS77BdCQuNkcFsCftJLVSKEOsGSTNnZTQksU19oTVB9KwxniWw
         D8hNd97lzaf61C/xtXsXKlM4min0XpZu2SJqrCkh+PY+WUd9cZAHF6AdlOCBPBqvqYNp
         Gaj1xtklk4jbypqXMndIoRTkJczMI+PeONYOGYy1E5PiQLFNzBxSLkIPIY6pNv+aM5lN
         Trbg==
X-Gm-Message-State: APt69E29+1JHRYH9Kt4jRQHF7fJeW/86fLa9UpiRXky70w2O73tBtIJR
        h6zwVWXbgctnXTEJgPd3VDvlHw==
X-Google-Smtp-Source: AAOMgpcAA945O4IhPVebSg828V1abNrIo/5REo1onwrXQ3TWHdsaV32JAtJ28qGi1x839joA2ri6uQ==
X-Received: by 2002:adf:b839:: with SMTP id h54-v6mr965602wrf.36.1530008604921;
        Tue, 26 Jun 2018 03:23:24 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2573852wmp.23.2018.06.26.03.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:23:24 -0700 (PDT)
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
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 08/15] ARM: davinci: mityomapl138: don't read the MAC address from machine code
Date:   Tue, 26 Jun 2018 12:22:38 +0200
Message-Id: <20180626102245.30711-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626102245.30711-1-brgl@bgdev.pl>
References: <20180626102245.30711-1-brgl@bgdev.pl>
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
index 2ec31ff61dbd..6263e6afcbf0 100644
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


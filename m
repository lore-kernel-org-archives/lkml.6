Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F20C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDE12239A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="EhKA3X6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFDE12239A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934904AbeFZKYD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:24:03 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41622 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964844AbeFZKXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:23:39 -0400
Received: by mail-wr0-f194.google.com with SMTP id h10-v6so16650655wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u5DqzgH5fpoGJX2DCfyjILWRGPoFwgDmrRb4Q1YR2bg=;
        b=EhKA3X6Ps8DiLi+BGbAxBfQ7/Pkiw+J12z67wTbxcg3B4/dN2UL1iKXSr90WaWhNss
         veEZ3mchUr7GKiSYNWq6nbeNW6f/bFzgp46lSu9db5UeUu9Hy5lxpfOscAIuzgebffZj
         g+udrsvbwzrVCAm00vxu90LOT4dVRU6ofog1YlmHrVf2uF8HY0B4goZxH0aqr1IsJDiu
         1pWnYSbYt8muQMzx6kTOunCWd+s7+ILWmIjzrDSDpW9YI3GhAVMejS9DJv8PLg37AWse
         QyerLhDlstRZq4kRiaUFNa07ZV/GJFhcUJ/MiOjQ+ofdbKmy/gWo5Xk8f+/PuVIMHiAh
         sAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u5DqzgH5fpoGJX2DCfyjILWRGPoFwgDmrRb4Q1YR2bg=;
        b=YEQK8tY09VcMphkb5DLjJZxzBDF0iEBw8mxbHVuE5v9UWZwu7XUJ/79/Q90eiEaE4q
         CwW/CBxEmLweeqwkSXH+KHKg1oIp2kdgsy4AwIm1VyeyS3ic9PS/0wxRsRapTbqHWsGC
         9YApJXhp/1p3GlvTi2xuQUqLO9TfwjXYCHg04TFTA2ANW/pF9FznQMF0TiL+LX8zw+cs
         PDUbjmYVcTqqNLiYiJJNkKcLKGFazOzWZUIb6o2I1fCDt2Aqnu3jnPpcjvsR/tDSz+2g
         nAAMVEm+n2B6KrIsSl15w1+hYUA35KMtV7OKdPBeTnDcjFkSDEtGM3OutiO/r+FGzJn3
         OmsA==
X-Gm-Message-State: APt69E3EPSPW2MYD2lpIpVdIVywKfUB6RAr6u85IbZL3xOV7+ww96OnO
        ZC9Z85rbBlTkUgtydPOxb9WzBg==
X-Google-Smtp-Source: AAOMgpc1BvtZ/wGlVAZ4Y1WPa4KwmfNNoMEbcxXdlk2cxgI39BPATGKgCtPxnAeaiAgVsDLIEGfi2Q==
X-Received: by 2002:adf:f3d2:: with SMTP id g18-v6mr883906wrp.279.1530008617911;
        Tue, 26 Jun 2018 03:23:37 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2573852wmp.23.2018.06.26.03.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:23:37 -0700 (PDT)
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
Subject: [PATCH v2 15/15] ARM: davinci: remove dead code
Date:   Tue, 26 Jun 2018 12:22:45 +0200
Message-Id: <20180626102245.30711-16-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626102245.30711-1-brgl@bgdev.pl>
References: <20180626102245.30711-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are no more users of davinci_get_mac_addr(). Remove it. Also
remove the mac_addr field from the emac platform data struct.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/common.c | 15 ---------------
 include/linux/davinci_emac.h   |  2 --
 2 files changed, 17 deletions(-)

diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index bcb6a7ba84e9..0c6cc354a4aa 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -28,21 +28,6 @@ EXPORT_SYMBOL(davinci_soc_info);
 void __iomem *davinci_intc_base;
 int davinci_intc_type;
 
-void davinci_get_mac_addr(struct nvmem_device *nvmem, void *context)
-{
-	char *mac_addr = davinci_soc_info.emac_pdata->mac_addr;
-	off_t offset = (off_t)context;
-
-	if (!IS_BUILTIN(CONFIG_NVMEM)) {
-		pr_warn("Cannot read MAC addr from EEPROM without CONFIG_NVMEM\n");
-		return;
-	}
-
-	/* Read MAC addr from EEPROM */
-	if (nvmem_device_read(nvmem, offset, ETH_ALEN, mac_addr) == ETH_ALEN)
-		pr_info("Read MAC addr from EEPROM: %pM\n", mac_addr);
-}
-
 static int __init davinci_init_id(struct davinci_soc_info *soc_info)
 {
 	int			i;
diff --git a/include/linux/davinci_emac.h b/include/linux/davinci_emac.h
index 05b97144d342..19888b27706d 100644
--- a/include/linux/davinci_emac.h
+++ b/include/linux/davinci_emac.h
@@ -19,7 +19,6 @@ struct mdio_platform_data {
 };
 
 struct emac_platform_data {
-	char mac_addr[ETH_ALEN];
 	u32 ctrl_reg_offset;
 	u32 ctrl_mod_reg_offset;
 	u32 ctrl_ram_offset;
@@ -46,5 +45,4 @@ enum {
 	EMAC_VERSION_2,	/* DM646x */
 };
 
-void davinci_get_mac_addr(struct nvmem_device *nvmem, void *context);
 #endif
-- 
2.17.1


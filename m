Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C57AC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E37627C84
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="sVL77/ZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E37627C84
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966581AbeF2JlW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:41:22 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40583 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935715AbeF2JlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:41:09 -0400
Received: by mail-wr0-f195.google.com with SMTP id l2-v6so7628554wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u5DqzgH5fpoGJX2DCfyjILWRGPoFwgDmrRb4Q1YR2bg=;
        b=sVL77/ZJD73ZOrNYBNMI4Oy1fKUIyNDghcLEo2AE6NuvERvWvitrJKco+6zEw1rrjx
         BYEvGlq5j+jNb4FqItkxskFIV63fvFPCbw0w5sLqjXt1E4voL7eI93rUSlZbzEjE/+m7
         TO/6L4EqTn2399keKOSyRX7WJhqWJU9X24vMRRC/umLMmjIjkqe3Fi5+15NXvznkTTWS
         t1CDJiU8dRhm07bCQWLxF+soEWSfMkeYj8sudkp7Uy4Sn7Aos0nnuezJmvrL5UHGTfI/
         ZgxhtGLkD674XLfbbNcN2iLNN/OSBtxt5HE7DdRc4IWZU5hYatn8KvGhU6zbj2eUCvSw
         Km4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u5DqzgH5fpoGJX2DCfyjILWRGPoFwgDmrRb4Q1YR2bg=;
        b=mx96A28I1gjj5CpgJyEz6D5GMB/dN1BsXc8Ys92qBtLRKlNkT1C5MzXyjLh/6DAGDI
         cBqtb+i1g7hUgysDJeq0mzHCbgjcO6EL47gX6uQJMJJjhPQuGWzkWeAG4IyYMPDoe0mq
         MWibaZLJUjQgfytWsHS+5D8gv6YEpRfANJoV2MFL2LJq8Lf6dl3FwRYRlgniaMofpw4v
         IvFO14/t8MxtCDXmIRROgZINkrGfjwHiKjCjgM8w0mkbFWA898eO8gOfZbjTWp++1zaI
         p/Qmec4KlRqvs+6XNvtK7byev3eWxrB+RfazT18Q2W+8XQDpLOozGfrn8dToYPRtl3M0
         CPxg==
X-Gm-Message-State: APt69E07m20+EUVYVWY5piWIYiBxK/HNkgDNf8+Z38HAueI9j1CDYMEG
        +/5Y3+7ERuAJyjVBUh4lGb9M6A==
X-Google-Smtp-Source: AAOMgpdkYVIyRqQ9aENw5f8/jv/gl0RAPguEbmMrryxydRcGzIMIcpsKLbjKkwkENu9JBL7gQf/psQ==
X-Received: by 2002:adf:f6c4:: with SMTP id y4-v6mr11216416wrp.4.1530265268615;
        Fri, 29 Jun 2018 02:41:08 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id d102-v6sm1386394wma.10.2018.06.29.02.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:41:07 -0700 (PDT)
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
Subject: [PATCH v4 18/18] ARM: davinci: remove dead code related to MAC address reading
Date:   Fri, 29 Jun 2018 11:40:39 +0200
Message-Id: <20180629094039.7543-19-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629094039.7543-1-brgl@bgdev.pl>
References: <20180629094039.7543-1-brgl@bgdev.pl>
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


Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77709C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBA827CAD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="07PXizVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBA827CAD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934116AbeF2Jov (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:44:51 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43378 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933750AbeF2Jk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:40:57 -0400
Received: by mail-wr0-f196.google.com with SMTP id c5-v6so8198600wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DEaxIuyp3QkNsGvwkhtanL8JC1vLeKQqMPNhy3Q8tDs=;
        b=07PXizVWn2gm4O8P2EJhbbVQC/g8hEtTMYHKdEKT43BF2vZv53E7D8cd8vyUgK8M05
         JRQ93xhkKEvVv8MReZ03y8ijP/tuT6F7ltXDu5PZhJq9qJwMS3eLhS0n/bJhkZCSwuSz
         LF1xRPek6uLNNvDeDLGnVqVZ+nUYqrg3YuQinuTGLZQAaXRY2Kh7EGwru/CokJ4gWt5v
         tA94aB9PZgXbZi/zjQwANiaJ05ZAW4WyXE8CjQ7M/1wSIWQMEvZI0s25r9Cu7adJecG9
         ZmqakQsEtUUjet4iOMFave+Z3GO3EhwNkUs+xzcExWT9bmRnVc7NBUPZO6367j6WkZav
         Hw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DEaxIuyp3QkNsGvwkhtanL8JC1vLeKQqMPNhy3Q8tDs=;
        b=HPVZfBYbHVOsCRNTH+ftHdsugUrczMjPGZlAjFJeBxgC6H+xPY15/WBftgPUZoFHSR
         Vxyc24jzpNHPVIFPHJdq9i+UU6UaM1TXAL5cNaKnYh+3CBKoFbvtMPMzw1jnwnHTJHu5
         M+FEB2r/i0mkKRaPk0WVxamtAESRN/wQooEI+EWi3ybb6CarcZWIWFfZDceHvatl+wNd
         6Z00tZaIS9sEpYMIcDO3mGI3GmcqC3nqwszGbm7V5cPx+s2kVTe80qaEnngWiSe0VW3R
         KD+UoMW7BEWF9yHPjzkuzJMRFsJvlK1V34TDjr3htTzccEUHawr2UmJqZKSX31cRNBW4
         3TSg==
X-Gm-Message-State: APt69E1gYHJGq376QjmDS2LQkwtSxmYFZTpsgYBV6585QEVfQFQHqRaZ
        W/9YRY+tuS+uFSg0wbR1Tz8zow==
X-Google-Smtp-Source: AAOMgpfyQOkaQ4jDnhB5CNmG1EsUAWaw4VzowXs82mtWriNWI2hZbJ1QDVBGOY4mI6QxbklxA+avvA==
X-Received: by 2002:adf:d84a:: with SMTP id k10-v6mr11443739wrl.26.1530265255926;
        Fri, 29 Jun 2018 02:40:55 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id d102-v6sm1386394wma.10.2018.06.29.02.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:40:55 -0700 (PDT)
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
Subject: [PATCH v4 09/18] ARM: davinci: da850-evm: remove dead MTD code
Date:   Fri, 29 Jun 2018 11:40:30 +0200
Message-Id: <20180629094039.7543-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629094039.7543-1-brgl@bgdev.pl>
References: <20180629094039.7543-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We no longer need to register the MTD notifier to read the MAC address
as it's now being done in the emac address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 28 -------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index e22fb40e34bc..4de075458d83 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -124,32 +124,6 @@ static struct spi_board_info da850evm_spi_info[] = {
 	},
 };
 
-#ifdef CONFIG_MTD
-static void da850_evm_m25p80_notify_add(struct mtd_info *mtd)
-{
-	char *mac_addr = davinci_soc_info.emac_pdata->mac_addr;
-	size_t retlen;
-
-	if (!strcmp(mtd->name, "MAC-Address")) {
-		mtd_read(mtd, 0, ETH_ALEN, &retlen, mac_addr);
-		if (retlen == ETH_ALEN)
-			pr_info("Read MAC addr from SPI Flash: %pM\n",
-				mac_addr);
-	}
-}
-
-static struct mtd_notifier da850evm_spi_notifier = {
-	.add	= da850_evm_m25p80_notify_add,
-};
-
-static void da850_evm_setup_mac_addr(void)
-{
-	register_mtd_user(&da850evm_spi_notifier);
-}
-#else
-static void da850_evm_setup_mac_addr(void) { }
-#endif
-
 static struct mtd_partition da850_evm_norflash_partition[] = {
 	{
 		.name           = "bootloaders + env",
@@ -1455,8 +1429,6 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warn("%s: SATA registration failed: %d\n", __func__, ret);
 
-	da850_evm_setup_mac_addr();
-
 	ret = da8xx_register_rproc();
 	if (ret)
 		pr_warn("%s: dsp/rproc registration failed: %d\n",
-- 
2.17.1


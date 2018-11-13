Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D76FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362B42086A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="czxsBaTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362B42086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388011AbeKNAAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:00:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53074 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387968AbeKNAAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so12019577wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rzIOy5k8NvgMAGaMyhICjOaJC80/j9SQ1XPs3RN4Qj8=;
        b=czxsBaTIPylrdoZnIop/vzqSbcMKwqBFiN/pcIU147oEk9zTP3NdX9TSPh78RwQtE9
         3jRDWdnsbuepnfF0ABAlMrqHS87O+5tsZ9sbMTyQBOpifi/7XMrMX/V7gwZodPwGsJGi
         dqVY+O4clHSia80j4pbhTM9h5nt6AVkTadJxhRQYOmlYeHNwoi2CRAGHTiDNUDPsXys7
         0HKhWFEeX6T1V0Up53zF8ieYCV7cF0dbCYEzPCRajntX2XIQJoiQwtUUwXeV2TEJ+cd1
         Cbd3d0z6KKefOsE3gRi19GLQivBI6DvvhWfLII38bPV+xKCsUWZVviX8ATVE12fXl0Qo
         rryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rzIOy5k8NvgMAGaMyhICjOaJC80/j9SQ1XPs3RN4Qj8=;
        b=HVcio/+pt7FAcixVU2nyIPiI3vBTj6Kk3N8oE3aagIs9yCtAts/9SADs/yS8J3wT9f
         RZnYgtThNMjsm7sEtYj0x1D3qa/Cn0cqp8StWLBB9w3yaZa/AZrvGit0RxPVOEb/CbdU
         xSpU5eV/fWlwlgVUWipjL7/9eLp+tfbZFUML/kBlICumIqZG2U1DmIroBzO6/t5P9oyq
         iPm1v0a2F06XWfrIPGO8ZKDWTuInF/0DKXs2tuDMqHIKkHMBdcLbqGl/FD/zUw1gyyyt
         1k2D5a76sfE+NaGQu+lgoI/0WqJgQ79iu4ccIO6LWwoZ1oQnLmGsfkXz/0hzMQMNIlsV
         debQ==
X-Gm-Message-State: AGRZ1gKZlbdzW9VPFZ+wkgXeqCvDGooS5d9QUWkziTFzEBxzzu62AKOa
        cWvEffy0rFiyL4iLh8duP5YWHA==
X-Google-Smtp-Source: AJdET5cejNO1sjS5Rs8mSVv9N6GwUYu0qmNgnOpUOzqnv3+pTsBtyBxBNVY+mFQOeYTglyIswaPP8A==
X-Received: by 2002:a1c:b8d:: with SMTP id 135-v6mr3273167wml.128.1542117741207;
        Tue, 13 Nov 2018 06:02:21 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.02.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:20 -0800 (PST)
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
Subject: [PATCH v2 15/25] ARM: davinci: mityomapl138: don't read the MAC address from machine code
Date:   Tue, 13 Nov 2018 15:01:23 +0100
Message-Id: <20181113140133.17385-16-brgl@bgdev.pl>
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

This is now done by the emac driver using a registered nvmem cell.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 8df16e81b69e..3286dc2457a5 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -121,7 +121,6 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
 {
 	int ret;
 	const char *partnum = NULL;
-	struct davinci_soc_info *soc_info = &davinci_soc_info;
 
 	if (!IS_BUILTIN(CONFIG_NVMEM)) {
 		pr_warn("Factory Config not available without CONFIG_NVMEM\n");
@@ -147,13 +146,6 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
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
2.19.1


Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5899AC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10592245BC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="O4qOG1uh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10592245BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755077AbeFYPyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:54:16 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36407 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754315AbeFYPva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:51:30 -0400
Received: by mail-wm0-f41.google.com with SMTP id u18-v6so6106298wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x9tAz9TB7Rhx1eB/dgg8uF02oHbyRX2HTzlv5KIKThU=;
        b=O4qOG1uhng/aL4D5B9SUpsXoE4H69H/8WWLN23msOM4R6xpu9z9Z2lB47+DRibee2o
         0KpQodfZEpdpui89NE3lT32jP14rxruLKUXSvFldPBxgt6ftspL/nm82ebyNfoXkQ/wj
         +Utukf925a/nQQ6r4wE6p1Qp8qNpSSCqXPpK12nKF54ca88YBvlVqoDfVeY3ykLLqKaf
         70E+pMhRLnzWjsubyCypai2W2aWEzIYvZ9w1cyDinh/gtJbC7fGYHonD/dIwyZejZdcj
         HWyK0NdW5t9wIZtipYSCw/ky8zy+yeMjTh8LRCLaGSlXwAifviHaSPTAerdazfUGPz43
         OGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x9tAz9TB7Rhx1eB/dgg8uF02oHbyRX2HTzlv5KIKThU=;
        b=kAYTJ5606Yq7uXYQrb5a7qz1UdpvuaOnWg1GDuSrouC2gvUEcc/0qGrGnslZSOTePU
         /BOtE9LWcG4/APu+mIHnsx8i+lPgzQwCRDkDfn5qaNPTKR+O+HjwoAaI0YG7/bSAtm3E
         uZPY2+iXtm8MCjfqWDvoQdshEdp918Hxv7gEe1G6jDVmFm9ORQe8P/+6uj74OCO8kwi/
         Un96U2vAe+ULcH74X5IWhff3ZQNqfDrd7H3dz6GNE0wF14b3qzMsNiPGV2qjrqQ2z1wB
         4QZgULZ6LvhiR1srlNwxBAInZC0k2tl9USQZdnYgwqATkNCy4o3Aiph20rvyPF0zB57S
         Qbgw==
X-Gm-Message-State: APt69E3chHvUkud5AwFRaU92AJmkybCjfJxGdCGn9On3KMF0N+4zZQUT
        8GgZu1+AX9bp+d3lqF9yKNygYQ==
X-Google-Smtp-Source: AAOMgpcII9hPRSyzDgelkg+sU2v5tkcyK5Hi9Ij50VpvyEQ9nP+jsBNymaPdXFcH3ug9ywRXnLv+mg==
X-Received: by 2002:a1c:8f50:: with SMTP id r77-v6mr1527308wmd.77.1529941889347;
        Mon, 25 Jun 2018 08:51:29 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id x16-v6sm3523737wro.13.2018.06.25.08.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:51:28 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 08/14] ARM: davinci: mityomapl138: don't read the MAC address from machine code
Date:   Mon, 25 Jun 2018 17:50:19 +0200
Message-Id: <20180625155025.12567-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625155025.12567-1-brgl@bgdev.pl>
References: <20180625155025.12567-1-brgl@bgdev.pl>
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


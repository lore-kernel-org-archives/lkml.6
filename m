Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74764C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AEB2753E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KhjR6YwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AEB2753E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966891AbeF1Ogy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:36:54 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36227 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966683AbeF1OdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:33:24 -0400
Received: by mail-wr0-f195.google.com with SMTP id f16-v6so5764571wrm.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jOLtKJCxnJbnqKQvbWA8E9QMQLQ8bmWHWXbRtOMMgfU=;
        b=KhjR6YwApHddMdYY7GngMCPJBStSJ4yNZFujpMhWRboYIegUOb3dNd3IgglzVtqZmJ
         fTiMT7d5fGikbySSyHBOvyfwKfxvBUBArtsYrnDw/9cUbi+1qvcX82A95ZfJ90u+pihd
         GrEuafL94Bt3Yu+eiladN/cY/6kK1uYl5NOyslF+l828KBnzfWvmV+SajT8cX2zT0b4w
         X7nmyPZc6AngMBd9epc6UCfsIGGND/EVxU63Lfc/OhBKvgAVVf4sWxoa6A9gg8a56sw9
         qxzYPgHulaSvglQmMhkzoIc1ocWywI6W6EMTYkBPipfT+imMtIsL7aWCX/rStDMkf22h
         69Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jOLtKJCxnJbnqKQvbWA8E9QMQLQ8bmWHWXbRtOMMgfU=;
        b=OMidnTfib9fLKMWKnVvinhbtlpbq0DB49Eu61QV/tKZj0+MlyQ286YEdSKs+QephuF
         c1qrc5/6xi/muvgpx20UPiqiTafckcu02Rukqdn7a+EFo6rkDb+IJ3c4ayMwhjg63JW+
         e0rVtnmjGyr5K8uQlBeL+uigEdgA/+B+XLqkteL0pgKJQphKmLid/o/ybwMqCnujTPDl
         snbnp9TJwC94Og7CWoAETzBGn5prAXmw76TECMpkmtsh200aRtvi0wMEoHsQ43x1kd3x
         gQfizeWUMbwJPbEKaGokEnfgBqRFGFsi7ZLMGBHu1duAVfbsaNW+r63jHZQiESDDt4RC
         Fp7Q==
X-Gm-Message-State: APt69E2TU1oulLDP5vZfkIjQ1aS+0o5ZoH6XKa5nYTRMQXsrYVW+/SQo
        p4M8rSEGlGMUbDJeBYmYiv6Hpw==
X-Google-Smtp-Source: AAOMgpdxGovLwDoEewrO8MvkGgVb0qf4+H365n1fEykRhoFct48eFuX5TkxHuojc4+EW04js6crm5g==
X-Received: by 2002:adf:fed2:: with SMTP id q18-v6mr9346815wrs.165.1530196402987;
        Thu, 28 Jun 2018 07:33:22 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id 4-v6sm8037499wmh.14.2018.06.28.07.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 07:33:22 -0700 (PDT)
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
Subject: [PATCH v3 11/18] ARM: davinci: mityomapl138: don't read the MAC address from machine code
Date:   Thu, 28 Jun 2018 16:32:37 +0200
Message-Id: <20180628143244.4561-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628143244.4561-1-brgl@bgdev.pl>
References: <20180628143244.4561-1-brgl@bgdev.pl>
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


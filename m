Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF420C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05CD218A1
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="arFFNjky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfAHJP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:15:57 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42787 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfAHJPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:15:52 -0500
Received: by mail-ed1-f66.google.com with SMTP id y20so3438816edw.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rzIOy5k8NvgMAGaMyhICjOaJC80/j9SQ1XPs3RN4Qj8=;
        b=arFFNjkyK5jgVqwI5Ncn+AX4a2Q/NGhSWf3He9mhz2NT/lv0JN6w2Fd6eObEZoLRYG
         VypoCMG+ieqP0BCnwTOuDhNKI0fl+vqoqjUIwqamttegNF1TUZKya0QRDNMuRq2TpLCU
         3JWsUClIg5p7i3lSu+oM6mhi6YH1grg3KEfwjuvOxOsvKAQAAfBuCsclNoCxdsaDhpjh
         1zydTjOEwKMHO2PYSy6IxNawqjaUg4kw/c2IPoBrghXUhWfHD6qFowNisM4+tyhpoVUV
         +7JYYq3T0ZMPwYYj59yt5py8VFcAEkul6t93PyeDqh4W55Z1rxJv0Zyi8mF1exbQeXML
         CzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rzIOy5k8NvgMAGaMyhICjOaJC80/j9SQ1XPs3RN4Qj8=;
        b=N0FDNYp6n3ryhchPh+UjXFBhQJRoSqaqpFl9BQumOTfCrRKb/wIvWF7pGSWgcWTdS2
         Y9f2DO7jxUWctUHf3i+tBD/ipAwGQPZWbZnoW7924rqCYcj/qboxEjBXSEjknVr3flZD
         8yLlMiOWtla8j52ssyp5aV0QhDrVWlleez4ZkQ1t9tNSdAejBjm32sxeJbNgtz7CCyah
         Pwbi0EoUxZsUCrSyLabz5ipbj+sJF9T9xuanCXf59Cq5Pft4Up6gfdu3P/N9nok3cn4A
         tUB9uP1ufujBurV+7/+ImU91CRK62LMEeKx2bpFblFUDmIVX3+tCd9Z/KZFqlwj4fNkw
         Hd+A==
X-Gm-Message-State: AJcUukdhiTy0iEWWpso6ZgLB4/6sPpOuHmyWSCdGiY8yvN/0OdVH4Qwy
        UTqBcu6vu/05dUbfLJWSLEZtaw==
X-Google-Smtp-Source: ALg8bN5D0lUcLdMnPkrhL+9/XqfcyVo0ZPm2mWRhm95c1UrmtVLn4SfcM8CGDAmsmNkCW55Cy8eMAA==
X-Received: by 2002:a50:b1db:: with SMTP id n27mr1317277edd.65.1546938951160;
        Tue, 08 Jan 2019 01:15:51 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 01:15:50 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 02/12] ARM: davinci: mityomapl138: don't read the MAC address from machine code
Date:   Tue,  8 Jan 2019 10:15:29 +0100
Message-Id: <20190108091539.16674-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108091539.16674-1-brgl@bgdev.pl>
References: <20190108091539.16674-1-brgl@bgdev.pl>
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


Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39988C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E603425D6D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bwWCLcDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E603425D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755735AbeFYPy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:54:59 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35428 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753149AbeFYPv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:51:27 -0400
Received: by mail-wm0-f49.google.com with SMTP id z137-v6so4873814wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hdmPjDSvWgFzi/ui3xXp3ufbDxi9LLAFx2+8+VRHKfA=;
        b=bwWCLcDfCvvX5JyT6wqGGjNISoXDEep7EEKn7bUcBLNi52A0LCK93wsKpc72irDND2
         U1L0gWd31ZCgST7bNJK/BwK+YbDVkQEsPlER5Dpvc89klAR1iDfIGUFHzlGoQ0/OCDXE
         93KwP3JSSKAxpwkic+Z0+duUSCd+xfUKFOO3c8KfD4IItl4MLrHc58eQ62jwLpD1gmKE
         MNlbKLCuzshYDz0e3dEFUrMnpXwsb/f4R2yxmNTa7tJCREA3oluCxaWBowoGerzMEDv7
         xWbsJ7o7fmy4DCQMymAdQ2Gimw4jgVUTl7UZFGaDqULbizoyQ2N5r4CjgIEAJSJ+NLJL
         JSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hdmPjDSvWgFzi/ui3xXp3ufbDxi9LLAFx2+8+VRHKfA=;
        b=CBNWajsLtH/rjy41hDJN2D5oAYDwHrb5aLW6cFnB23Lp9ZYCgPqK68YokKjKN3xvvn
         25XHDX6WvMl95IMMmgxx0FbP/0xTmqE8ZXqr+ljWyqB1cddc1npWIbiFUJaVYXq4k1+r
         9hiS8J6zYqXfjNNoNvmbRw0ltqociI0Q9XR0sFOtSU17Qa5RYnhoYTcamRLCdspVcpkO
         VoDIkwQfhdvW1HfXreUFYIDz0jA6TX+I6chEpTuL1jm5ottiMeC5O6ker4a0lAlSv1hC
         CrPamRgPrHB2YVjkTljQhIIbL0rlUjPKL9sufm1+bdsZBWlD5tAXO+WD76z0dK7Dw6h/
         g+NA==
X-Gm-Message-State: APt69E2tOLjZkpEORWp14hMoLhwnGonaQyOUw4BP3Kkk0OZGm6Z+7VGv
        4wHBHaQG48yu0QVsJ0AKP7frww==
X-Google-Smtp-Source: AAOMgpeNfj5J9PRxWw4Z2w3YYshvyfmZ9wWX10WwAghy5ZgvLn1cuzvY4+OyRW7hMsi2uNIfUH2nYg==
X-Received: by 2002:a1c:be10:: with SMTP id o16-v6mr1369682wmf.132.1529941886304;
        Mon, 25 Jun 2018 08:51:26 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id x16-v6sm3523737wro.13.2018.06.25.08.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:51:25 -0700 (PDT)
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
Subject: [PATCH 06/14] ARM: davinci: mityomapl138: add nvmem cells lookup entries
Date:   Mon, 25 Jun 2018 17:50:17 +0200
Message-Id: <20180625155025.12567-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625155025.12567-1-brgl@bgdev.pl>
References: <20180625155025.12567-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem lookups for machine code. Add a lookup for
mac-address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 37b3e48a21d1..2ec31ff61dbd 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -21,6 +21,7 @@
 #include <linux/etherdevice.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
+#include <linux/nvmem-provider.h>
 
 #include <asm/io.h>
 #include <asm/mach-types.h>
@@ -160,6 +161,25 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
 	mityomapl138_cpufreq_init(partnum);
 }
 
+static struct nvmem_cell_lookup mityomapl138_nvmem_cells[] = {
+	{
+		.info = {
+			.name = "factory-config",
+			.offset = 0x0,
+			.bytes = sizeof(struct factory_config),
+		},
+		.nvmem_name = "1-00500",
+	},
+	{
+		.info = {
+			.name = "mac-address",
+			.offset = 0x64,
+			.bytes = ETH_ALEN,
+		},
+		.nvmem_name = "1-00500",
+	}
+};
+
 static struct at24_platform_data mityomapl138_fd_chip = {
 	.byte_len	= 256,
 	.page_size	= 8,
@@ -534,6 +554,8 @@ static void __init mityomapl138_init(void)
 	if (ret)
 		pr_warn("spi 1 registration failed: %d\n", ret);
 
+	nvmem_register_lookup(mityomapl138_nvmem_cells,
+			      ARRAY_SIZE(mityomapl138_nvmem_cells));
 	mityomapl138_config_emac();
 
 	ret = da8xx_register_rtc();
-- 
2.17.1


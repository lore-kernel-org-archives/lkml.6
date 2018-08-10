Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA846C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDDD22402
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="WXTaSryW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDDD22402
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbeHJKeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:34:44 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34002 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbeHJKen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:34:43 -0400
Received: by mail-wm0-f50.google.com with SMTP id l2-v6so776212wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vbd/0hAQ6eCPDyxiTiuvrAkBoIff8s2ba/U1T9sJXTg=;
        b=WXTaSryWR9CEYrjcNIo3UE5DtLYVKzLIWsj+6TZ2+rPbEG/Yh5qafUI1htgP0u5l5M
         8CL9+bQBZT1ilBuuK+swWtl13ZX4Z6gOJz9Elduk/Q2SDVrS7IhQBp7/qAbPVaprWw+E
         qnuyZVLHRlSl96tEGph9PAvUv/tYPBsSe8xFsVLr6PiQDRIKDNYLRYtfBnqVqVeeBLUu
         WZe6k76TwxoChB83iOgCkPg2lJ7w951xHcPU3lAk1ccOIQFMZ+MZBVRN7Xl6MPbrJdFL
         FA9BLxZp8nf/vLEhYrrgY2IHv2KlkYuCMkEkC0SQ2T5n26mkbWlELxvvu5MDON2LDCZP
         Hxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vbd/0hAQ6eCPDyxiTiuvrAkBoIff8s2ba/U1T9sJXTg=;
        b=EowhVFwUh7R/3Lf0gUQYPSniEBRY3crKcMy3uRid3S6ejg8/ss0NsHLM8bE6uKTx6l
         8qTLx7f87iqYXmpp4a3Pmprg1e3AW+Y+3zeza5kSJVE1qmhsRuzzKUnE/vPy47xx6f3F
         refPjz/0Z9eh3VCK8RGMh5bNK4kGCN0oMLJJnus2vMd/3P/BgvDFx2fANHDpNZzKONwX
         XCkmw1gsWvsfuVtFUfvXdFy19/p7HslKANfFQJNt2nWxctgPvk4AbqkVjgWhROUr34HL
         ll4mzr5P30rbN+2tOTa2QFIZ++ynsWXDuy7seM5yrUVfoM8PhE1kDd7kThMlsUuUrJoE
         WJWg==
X-Gm-Message-State: AOUpUlEdIyg0Kp7YsG+TRECuG0dH1OsQpgOCBYCmEo4RIpjEyb0qURvU
        sHL2EKCG11pACtk3HGCokSuxZg==
X-Google-Smtp-Source: AA+uWPwevt7H+4psNa6nNW0sB6RMqRzZSdo/PB1RqE6sIHuds28NM2mVCOs48EMlZ/vnaPtG0JWFww==
X-Received: by 2002:a1c:8b0d:: with SMTP id n13-v6mr730206wmd.46.1533888357383;
        Fri, 10 Aug 2018 01:05:57 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id h7-v6sm9546405wrs.8.2018.08.10.01.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:05:56 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 13/29] ARM: davinci: da850-evm: remove unnecessary include
Date:   Fri, 10 Aug 2018 10:05:10 +0200
Message-Id: <20180810080526.27207-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The include file for at24_platform_data is not needed in this file.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 5a634a04ec69..521a26b5c20d 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -20,7 +20,6 @@
 #include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/at24.h>
 #include <linux/platform_data/pca953x.h>
 #include <linux/input.h>
 #include <linux/input/tps6507x-ts.h>
-- 
2.18.0


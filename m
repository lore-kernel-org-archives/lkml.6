Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C6DC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9A821EF6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hyVrD2uP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9A821EF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeHJKin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:38:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39066 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbeHJKeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:34:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so7461101wre.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=auDnQ2msgcUIg2cR1NJaWEIgp9qglPcIziHCsh4zH4c=;
        b=hyVrD2uPCuDfG/SIVDF3sBQ3x5jPiEIiYfLhv4zCCwnLblKSqKqaAzB+653FJmrvzf
         0e7bBYw1HAepWkf2U4LVpYgUjfZrKoVVh4FsuGcBMtiS+/SWcQle/y6aNI/rL+0drHQg
         jcV8QsqKTyRZoOsyt22VpaW9vTwkAFYZTn1EnN/IUhBp0W1GI+T7fDyIzwF8CX0/JejB
         qn+I0si68PVnhgSRuSUiRLU6KdgC6+/mrYiJiPtsG7TV+4jK228jLAs+oFZgJk5AfIKU
         lxIvEZrz9jOSA4FcAwwpvSafLhEQSuDJiaUTmMC9+byu6RvzOqCz0+7HA0qUPdS3cEax
         mGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=auDnQ2msgcUIg2cR1NJaWEIgp9qglPcIziHCsh4zH4c=;
        b=Uj/2Sef0/XQex2I64nEZwNgajHFpykhl15KJXrmQQ84D9YTboH6TZJUc/p6DVs/TOA
         wLtGZ+s3DJaWb7AFOX2tX6aBIBL62ydCrQPw1XgxYma2UO8TJtMTF/5WtfNkn6FUXv19
         pmy1L+K7bIeXdB/c4x5IlaNdmp4qqr26VJ+DnPXgtyxj4mwHGRQQP695845Zpk43YDy6
         5nyHji6h/MxgIs6NPN39cBTzFORztSOoDjiSguu9rTIdbBXMH2ONUGBlYBEY5HPImDcS
         ed/FxsXHQ2R37JGr8WsHJd3DR5ealZtXt2Yeyswh62+ub7lschKIZMk9jYus7lFPNiFB
         mASg==
X-Gm-Message-State: AOUpUlGIruK4jrR0holLzdto6iwRctP0v9cqciwFY295yLpF5H24U1tX
        rdkHjX0vZlz59OrC6tfUUbklsg==
X-Google-Smtp-Source: AA+uWPymFzn6I/ZI2lEGyhAt132NMNyj5wgE/WcirkCrpDDb/X28TuLJrG8472LzrmsGj41RTdm2uw==
X-Received: by 2002:adf:c78e:: with SMTP id l14-v6mr3521076wrg.230.1533888335767;
        Fri, 10 Aug 2018 01:05:35 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id h7-v6sm9546405wrs.8.2018.08.10.01.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:05:35 -0700 (PDT)
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
Subject: [PATCH v2 02/29] Documentation: nvmem: document lookup entries
Date:   Fri, 10 Aug 2018 10:04:59 +0200
Message-Id: <20180810080526.27207-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Describe the usage of nvmem cell lookup tables.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/nvmem/nvmem.txt | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/nvmem/nvmem.txt b/Documentation/nvmem/nvmem.txt
index 8d8d8f58f96f..9d5e3ca2b4f3 100644
--- a/Documentation/nvmem/nvmem.txt
+++ b/Documentation/nvmem/nvmem.txt
@@ -58,6 +58,34 @@ static int qfprom_probe(struct platform_device *pdev)
 It is mandatory that the NVMEM provider has a regmap associated with its
 struct device. Failure to do would return error code from nvmem_register().
 
+Additionally it is possible to create nvmem cell lookup entries and register
+them with the nvmem framework from machine code as shown in the example below:
+
+static struct nvmem_cell_lookup foobar_lookup = {
+	.info = {
+		.name = "mac-address",
+		.offset = 0xd000,
+		.bytes = ERH_ALEN,
+	},
+	.nvmem_name = "foobar",
+};
+
+static void foobar_register(void)
+{
+	...
+	nvmem_add_lookup_table(&foobar_lookup, 1);
+	...
+}
+
+A lookup entry table can be later removed if needed:
+
+static void foobar_fini(void)
+{
+	...
+	nvmem_del_lookup_table(&foobar_lookup, 1);
+	...
+}
+
 NVMEM Consumers
 +++++++++++++++
 
-- 
2.18.0


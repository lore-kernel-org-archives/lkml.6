Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D615C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1F721A13
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="i0TceG1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1F721A13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbeHHRxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:53:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33664 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeHHRxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:53:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so2425386wrp.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=auDnQ2msgcUIg2cR1NJaWEIgp9qglPcIziHCsh4zH4c=;
        b=i0TceG1lfus+3BKletcKWO3nK/kouvjNQ7m41aqTlvkDGShVKicbJizZHKDcw3Xqt+
         HPr21z1eaCC7xAYrE6QY5AYgYSjdpdncEKSuTuYtGsJMlOxdr1Xs06f0jThoaM5E5FPt
         RDoXE6k+MkI0htttCqe3Z533KoWRVj+IGT1KP/BBWIUee236jV5xzx3s/WuaxDl0jp05
         XCNQAg3Rv3YvBaDXWZKo4rYHxI8zIBvMJI6UUfP5/mVir7hVqVimhQlrXmh2SFn1dkzK
         6WoaZtFaMc8ktSCQafPsfjp+uQWjcGeBBFPjxiDX0PsUVROXEtmgSb5yWl9ElgSrCvZm
         HUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=auDnQ2msgcUIg2cR1NJaWEIgp9qglPcIziHCsh4zH4c=;
        b=swfBq+aDX0nVnMsgi/5DWIjBv5xWJLLe12BvhXDBpoEC02e+c7fEzZmVzDkMTfPFG0
         89AyrKlOknKFecBnmx5aHuzrIQGZIqG0Yu841gdBoPaJWC2NezGdHhtSTnehEyvR2vdc
         GRtFmTw/3tUref98NghCQP4LoayPdhtfHIVRLlRCQUFShJHxdQIgA+fiCQM6OP3CSAn5
         6HtlwCALVY332FFtKGPrKadobAQC1k5joBy9ShZVcuvq99bfjWsk5yyaps0hyybYruNz
         4bOQANCC4YADQ6ZSRm/DPD8lykBu1G5xljq5OEJkf9GDnr7wiHCMBe+pTwj0wtuEREzj
         d36g==
X-Gm-Message-State: AOUpUlHgnFqHHD8SYNYSwSak0rZWYD912ssoXiUGA3llE2inA2bmbX1V
        Or0AIy+foE4PXffzJ4U+g16BSw==
X-Google-Smtp-Source: AA+uWPzXSa//8V3H1avfMZTefmddl6h0FyaPd0yH7CY96wAZDwMdcsR62BaE3h96tK/j1eDfbq7FHA==
X-Received: by 2002:adf:eec9:: with SMTP id a9-v6mr2368667wrp.21.1533742409371;
        Wed, 08 Aug 2018 08:33:29 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id s2-v6sm5240915wrw.52.2018.08.08.08.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:33:28 -0700 (PDT)
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
Subject: [PATCH 02/28] Documentation: nvmem: document lookup entries
Date:   Wed,  8 Aug 2018 17:31:24 +0200
Message-Id: <20180808153150.23444-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
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


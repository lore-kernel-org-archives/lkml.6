Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB508C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CB02087B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JGD+vdcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CB02087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbeIGOtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:49:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38093 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbeIGOsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:48:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so14025874wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 03:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rjARCe3NpsJLpu+gwm8Y4x+0pJknacrTsP46NqsklWs=;
        b=JGD+vdczikrboApyovvWow0pnAnzkJz0ImUB1OKO7J6WzuO1DV32poJqARyVCHAT4W
         9oJqnM42O2El0bVSTuFljdRfZZIjvgQmi+/hWuOUHYNv3wru2eluY4AmvJf6Jk1jdoTO
         m5Al/MYjbFknubjNUyjfSiW8IcaR5CKY1lWcAtc7UVUHVYFKUPR2A7zqJ3JKDHVB/pQZ
         i1+Cj4KCQLvusrX6PWxX/2YjqTAZilzQHWTmysLBMTnUDvBZdXOw+/NfjgRwEBoMFIUr
         T0KZAFPvSYxLE8hOYpryEJgbAWSG57sqr2etvyjPsj+lg+QngzHPPeV0q28GKHgJuBjw
         8uWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rjARCe3NpsJLpu+gwm8Y4x+0pJknacrTsP46NqsklWs=;
        b=nWFSt5I6RpJhwJn5w3atuP3yAtbuwRYuRazv1iZsu2ZDaWTTjsa78MD6YSUOeJW87V
         zaAh6TpnDXThYcISC/h4SInWiGacn0BdHgD1wPt5RypWrb7qBHi46y5PP8w7+xQ2Dk0C
         YlZncR7qFv3LJkj9rJT2CPQcD3KL7hQV+LF04+7ITALwyzypok+aYhdknT2SAwHc83vm
         BLJf49Xb/Dt3Iirljrhxp9dx3VPg1eoNV63BM7VoSoduL8XGQeRBcTDRKL38DZNXNIXP
         sdXDvVrUs5WkwSBVVnZ4k1IE/MOmdsQOZGGYvphTNZyjv4sCFpR+aguQbXEAomJR3pn9
         mkSQ==
X-Gm-Message-State: APzg51CYxUcY0kWhsw57s1D7imgx6tDGadNmGIPC+qOfbDett4AOY+hr
        vUjr+YAYKL90uW2WhYSVZZimuA==
X-Google-Smtp-Source: ANB0VdaeWAYzfcGsVF/mkA53G39QTZNQ9p4L/aP28vkS4LM/gh08yPlu9mL8Ht3+wc7ew+p2LpA12g==
X-Received: by 2002:a1c:7f93:: with SMTP id a141-v6mr4825953wmd.45.1536314916701;
        Fri, 07 Sep 2018 03:08:36 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-83-232.w90-86.abo.wanadoo.fr. [90.86.25.232])
        by smtp.gmail.com with ESMTPSA id 72-v6sm6631619wrb.48.2018.09.07.03.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 03:08:36 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 14/16] Documentation: nvmem: document cell tables and lookup entries
Date:   Fri,  7 Sep 2018 12:07:48 +0200
Message-Id: <20180907100750.14564-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907100750.14564-1-brgl@bgdev.pl>
References: <20180907100750.14564-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Document the new nvmem kernel APIs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/nvmem/nvmem.txt | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/nvmem/nvmem.txt b/Documentation/nvmem/nvmem.txt
index 8d8d8f58f96f..fc2fe4b18655 100644
--- a/Documentation/nvmem/nvmem.txt
+++ b/Documentation/nvmem/nvmem.txt
@@ -58,6 +58,37 @@ static int qfprom_probe(struct platform_device *pdev)
 It is mandatory that the NVMEM provider has a regmap associated with its
 struct device. Failure to do would return error code from nvmem_register().
 
+Users of board files can define and register nvmem cells using the
+nvmem_cell_table struct:
+
+static struct nvmem_cell_info foo_nvmem_cells[] = {
+	{
+		.name		= "macaddr",
+		.offset		= 0x7f00,
+		.bytes		= ETH_ALEN,
+	}
+};
+
+static struct nvmem_cell_table foo_nvmem_cell_table = {
+	.nvmem_name		= "i2c-eeprom",
+	.cells			= foo_nvmem_cells,
+	.ncells			= ARRAY_SIZE(foo_nvmem_cells),
+};
+
+nvmem_add_cell_table(&foo_nvmem_cell_table);
+
+Additionally it is possible to create nvmem cell lookup entries and register
+them with the nvmem framework from machine code as shown in the example below:
+
+static struct nvmem_cell_lookup foo_nvmem_lookup = {
+	.nvmem_name		= "i2c-eeprom",
+	.cell_name		= "macaddr",
+	.dev_id			= "foo_mac.0",
+	.con_id			= "mac-address",
+};
+
+nvmem_add_cell_lookups(&foo_nvmem_lookup, 1);
+
 NVMEM Consumers
 +++++++++++++++
 
-- 
2.18.0


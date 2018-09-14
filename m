Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129DDFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C044A2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ehBne27m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C044A2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbeINT42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:56:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36636 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeINTze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:55:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id e1-v6so10902152wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rjARCe3NpsJLpu+gwm8Y4x+0pJknacrTsP46NqsklWs=;
        b=ehBne27meR4PyxNCUPBVLcSfQlbZbVl7xJaoMM+y1SldpCWucVmRWNQ02YfBoKlyrQ
         g4wHbPqW8q+LvM8BfzrqI3DrHrsjkqmtvKGud4P2hgJnhiNuqRD8CTLPs6koOpMuh3A9
         PYK8zvCn2EMKZ0vtPaVvaAtERAC4oXhjRcCeb77BWk5E7h+vGM9uO0B7fz9sy98ZN+Bp
         pX7dSsH8P9brxc85RCbgRPyOVmqa6x3FS6Z/io1fetyvDIJ0JS7XojWkA6vWF7t7wgIX
         x0P7EgfCxnyMI6z0DIKUvBeRGEZBqxdyCiukDKov1bEE1i22YOYccM5q9mHiHzVvFvMP
         bj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rjARCe3NpsJLpu+gwm8Y4x+0pJknacrTsP46NqsklWs=;
        b=pn0OeVpRQFPN8g4Y5y4LS+cKd2n01hIANNYzhru0rbwp8esWp6qq3qZfOw/hCyJWX3
         kzJhQ5lqA0Dk7TqsmtQeT5MZx0LAIJ0DmsOl+nWfHBQznGMdeuATMv/QboOb4MLjnaFp
         MmMg1d0PzeVux0llg0I7+VAvkkNjnXqDapKAH2t5lXTgxRqC8+gcSRLOVV1dZbzBqxG9
         rHahVVpIQnOklLQmk8eRUiionjacqOu6/tRyEtZ/o5lOUHihNlpv/zgXdKZ7d/4MKxxH
         nxveD/+a5OeIHvZSJGC6xA6Hb9YdYG3hsa+6XNt2St369kkVg6MXw0K4VyikbODuYkgv
         LsPQ==
X-Gm-Message-State: APzg51ASoVVk1WKJONksg0nTEfmVGee018/Ktu9H15qLVeP/LOxRd1kT
        FqhOlrvWRNjTtoGA5XtPXXeY4XqvKGU=
X-Google-Smtp-Source: ANB0VdYkLruEia5UqmkWWvf/+HeCNtupZRYryHgb8VDENNxCVWiGFO+ctoDMZJ3RE1WRgggXgFckag==
X-Received: by 2002:a5d:4648:: with SMTP id j8-v6mr9723585wrs.52.1536936045075;
        Fri, 14 Sep 2018 07:40:45 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v46-v6sm10313526wrc.63.2018.09.14.07.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:40:44 -0700 (PDT)
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
Subject: [PATCH v4 16/22] Documentation: nvmem: document cell tables and lookup entries
Date:   Fri, 14 Sep 2018 16:40:05 +0200
Message-Id: <20180914144011.27614-17-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914144011.27614-1-brgl@bgdev.pl>
References: <20180914144011.27614-1-brgl@bgdev.pl>
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


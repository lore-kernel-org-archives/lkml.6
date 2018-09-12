Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C07C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F62E2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Fs1KPfuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F62E2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeILMz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:55:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32957 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbeILMz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:55:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id v90-v6so940233wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rjARCe3NpsJLpu+gwm8Y4x+0pJknacrTsP46NqsklWs=;
        b=Fs1KPfuLGjhmN40UmU9tXCVjtd1Ypky/hXlcNhvJ4ZdsktmUGrwqy0BvQGNAHLkpDq
         PaA2Av+KU93GeJiQ8wuWtHdIMDW+Iu2zVIJ5R4OtD8jVebJUjPs/+3C4zeORQ0eXq2Oj
         wpJMZPM2UfWJLxOg7vBlDy6iNcCPpJwRSoqLiS4cMxuKEWqNij06Fht4kChaGdMBykkp
         0rP/HJcEpcDum+pVMKYhRCCWvvpkmwucyEImPUkjvI93uQZTPxycOcbEP/lNC6K9t42Y
         gYFEb4MolHlGGzHSFeUDEVTENO9c6G4BWPCrkifFmwc2T145IOeI4KKHtvlgqbuk0aW6
         YcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rjARCe3NpsJLpu+gwm8Y4x+0pJknacrTsP46NqsklWs=;
        b=l8zaMf7fGh2DsPmc13HPbX/O7ZU69PTotUg76fkfvp7hm1xEtjymn1HmEXR/uhhHuB
         cVGUL5ChQrkbDG9ALxMDhK+UIx8MRtHTVDzAf7NQKcTNtZhUrOkyDj5i0cAcPZO15YD/
         MobScZenuT1PoKk7ECRfFkWe8F7pld24h8U6SWjqXl/u9FjOs2ClF2e1KljgFpJo/e/N
         vmDV53GeGQn/YqCBECUGvm5MexDpv5L/QwSKAgtZI9S29P/nFP8bJYnGVg3Tj2kDBMf6
         ihf3zJvGs7c24W03iH6zQSir8VGbKnJhELpVQutCR6MtW+6Q7YBIj4CHdtqo8P7v0Df6
         X4EQ==
X-Gm-Message-State: APzg51B4dg+99CsjOBKW0+y34nh81xit6dZo+U7OEBAjBcX0LLgskj5D
        J6LZFUIddbgIXWDNoNMcg+OOZA==
X-Google-Smtp-Source: ANB0Vdb0/pWaejo7JU4HxGj4loHJp95Ch+j4mzZMVwskZMBXfAsV3ywMBMXsUym/S6Acj1i9yt/xkg==
X-Received: by 2002:a5d:55ca:: with SMTP id i10-v6mr531380wrw.38.1536738727672;
        Wed, 12 Sep 2018 00:52:07 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id l7-v6sm169341wrt.67.2018.09.12.00.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:52:07 -0700 (PDT)
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
Subject: [PATCH v3 15/21] Documentation: nvmem: document cell tables and lookup entries
Date:   Wed, 12 Sep 2018 09:51:23 +0200
Message-Id: <20180912075129.25185-16-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
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


Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42D6C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9452086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="AFOtynpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9452086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbeIEO1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:27:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40632 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbeIEO1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:27:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id 207-v6so7001087wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u/vGnWPAfFIzYEkGzNSLnF1qQXU18MToxRtfXu+i8Lw=;
        b=AFOtynpeAfIILSknYGLsIURIbLtuFfq7vbabvPnCn/wydhZu/7W8BGrhhByinYP73M
         C8VRgtcJpZpKXlVbJdXTS2qmVbsiAal52V9xvIE+cd+5Ktc8pvjvHpA+/KOYzUTjoTUY
         eVVGdrSLj3WbqnGU626M6qDY2KcPJI38TQnECU8SFaO/GRqgc7iCXLqEz9qcefveH7FG
         V06HKBeWJbIIZWUcMyS2OoyiUkG1r0BcvlMluWq6T4EzjbxXDL+RwdqamI9mVmyus6CJ
         94hLZdJX5rFYPNivyAetTVBjAaoAoCXHJJzIdBrlJ52LaB9ULjq0Y+cVmgsuwCirsNWf
         M/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u/vGnWPAfFIzYEkGzNSLnF1qQXU18MToxRtfXu+i8Lw=;
        b=sLGXXtXh4cH2KaHE3p00YbokDhncx8lzTl0+fBRmEN2nMkv3kOdIVfYc5gW/FVqRS4
         kXJ7ABzS0fn8fGi8jVb/CWXXamTqxUYAVlEmgTEaPlf5DCUVgo1q/tYSo59ZJ6H5lrlM
         5wnDxWFYX3LsfaQ9kan0X2OXlNTr67NTSnX6O8u4h8SbapP0zBNCsRB038mC8RtDY0K0
         uQ+7+1t/UagiE4dxH3yvT5FazPU4EvQXGafoTo0fvfKmTBvdSSe6n5d14qVM9Y5i91xW
         9JdqmXbOvDVHPgNUa3e5MZMBI5qUvxPtFW8K/eME3c8Rou2M+dJGZn7Jnszox3ENfczx
         fQJA==
X-Gm-Message-State: APzg51DrHafXdZc3QPHZCf6YimAuF/K6+6WKbKU3ZagvIE9lSBgBxBQL
        w6c9bb9FUmg6y6aSJs0QVU7X6Q==
X-Google-Smtp-Source: ANB0VdZnBRihRCUqGRhDnjcFvDA/f1NOvLLwGgdrDnG1x7QUnHU8iyXAaA0VSm+maGLf1Y5zdQ/Umg==
X-Received: by 2002:a1c:578a:: with SMTP id l132-v6mr5296997wmb.16.1536141499343;
        Wed, 05 Sep 2018 02:58:19 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-33-235.w90-86.abo.wanadoo.fr. [90.86.152.235])
        by smtp.gmail.com with ESMTPSA id l12-v6sm2127815wrv.29.2018.09.05.02.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 02:58:18 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joachim Eastwood <manabian@gmail.com>,
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
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 12/13] Documentation: nvmem: document cell tables and lookup entries
Date:   Wed,  5 Sep 2018 11:57:37 +0200
Message-Id: <20180905095738.26406-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905095738.26406-1-brgl@bgdev.pl>
References: <20180905095738.26406-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Document the new nvmem kernel APIs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/nvmem/nvmem.txt | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/nvmem/nvmem.txt b/Documentation/nvmem/nvmem.txt
index 8d8d8f58f96f..2cb01cdf87c8 100644
--- a/Documentation/nvmem/nvmem.txt
+++ b/Documentation/nvmem/nvmem.txt
@@ -58,6 +58,36 @@ static int qfprom_probe(struct platform_device *pdev)
 It is mandatory that the NVMEM provider has a regmap associated with its
 struct device. Failure to do would return error code from nvmem_register().
 
+Users of board files can define and register nvmem cells using the
+nvmem_cell_table struct:
+
+static struct nvmem_cell_info foo_nvmem_cells[] = {
+	{
+		.name		= "mac-address",
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
+	.dev_id			= "foo_mac.0",
+	.cell_id		= "mac-address",
+};
+
+nvmem_add_cell_lookups(&foo_nvmem_lookup, 1);
+
 NVMEM Consumers
 +++++++++++++++
 
-- 
2.18.0


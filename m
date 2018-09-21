Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A42BECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D682156E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nrl0ZmzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D682156E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389607AbeIUNR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:17:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38518 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389575AbeIUNRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:17:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id j8-v6so8063986wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 00:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rjARCe3NpsJLpu+gwm8Y4x+0pJknacrTsP46NqsklWs=;
        b=nrl0ZmzFXKV1C2dHT2G+p10w+heILcFor2W+NM5qN7CgCgjv1OsLYmDDtjR5/haaJl
         +c//cpqEP8jAIsCY29Fulgr0VzOmKLAbgR77mGFiBb17oMQgwSExDg7KgUDudPC6bEY5
         s134IalH1vMybPrCDZgOWCUjqgmzslGKYEYIeFcy11EiSypauYgMuVD3Zt92UYwDhpwj
         xc8GchyYlZALU7ukamoDf9namr6cIrQz2IH4MP/TrKpLNF5EscTcKZOeAPTfIPZJysKf
         47xg1UgHQe0zj1jCnk3CoeOWSW6+RW20Od1tdK+wPeqCS7R5vaYnksm9Gw/AlDY7MV4t
         fGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rjARCe3NpsJLpu+gwm8Y4x+0pJknacrTsP46NqsklWs=;
        b=DgcfqiSrOxKOf52K4by8i4fxfZ8LutDU0F2wRyhQppquZNv+PSYFCJtHz4/E822bmb
         ALLEx6SgB52Wa/9X55I1QLfHOS3fdOVpM0Oud4wQGKcnWG5wxOvu802fvoUTToftKOfS
         ASz3ISDMzbEyTLYfoCdm1BMGIrZAYndV2+mTxaj/h5nsBcCOxQA5ESlCoTthAOrEsiwZ
         20YdUjgshOWoSNpTe7V11gTJhkmyaqF8ZOyevuSJWkId5K7huSyAts1KMtnwnwsm5Rtb
         quwPwFty+WgvmjMne7gJQgh8BIu3EFCPSVMMfqS7wKHHwvNdrDAQjCu85yDR95oMr9Jd
         SVyQ==
X-Gm-Message-State: APzg51ArZRCQeKTfnnK+F+e7cgYVxCw2pNDgLlsO59msD7Twp535Ot6C
        vlcrifzgK79TFgJhm0G72EM+LQ==
X-Google-Smtp-Source: ANB0Vdav5OfRgQsR3mjSOueeXCMx0dNd3X2ZogTEP48htDbmJ1HVY310M6PUYAoafiOD1j+qUSLcHw==
X-Received: by 2002:adf:f984:: with SMTP id f4-v6mr37339731wrr.105.1537514988246;
        Fri, 21 Sep 2018 00:29:48 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id d18-v6sm2841597wmb.33.2018.09.21.00.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 00:29:47 -0700 (PDT)
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
Subject: [PATCH v5 16/22] Documentation: nvmem: document cell tables and lookup entries
Date:   Fri, 21 Sep 2018 09:29:15 +0200
Message-Id: <20180921072921.19387-17-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921072921.19387-1-brgl@bgdev.pl>
References: <20180921072921.19387-1-brgl@bgdev.pl>
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


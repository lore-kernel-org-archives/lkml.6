Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C600AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989B9218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfOB4IyF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbfAKTcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:32:53 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34016 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732371AbfAKTcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:32:53 -0500
Received: by mail-io1-f65.google.com with SMTP id b16so13076894ior.1;
        Fri, 11 Jan 2019 11:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eIxobHanVVV7p4lGf1aBEUdrw5ikpusn57X5A64Zg5M=;
        b=TfOB4IyFZXNCn+wncrr1rZAslXeVSpqhzslRhS7ij0abumHa6EqHmQ0ROw+1PxX5M2
         vBsUz5uMZJ4my2oED4jAPsRnOgk7bEwMWI/J5OZaig3MjvNPIMgJrujisjOCC2YvRtoZ
         0YcqaxzOxs3jwMcEtY0mp4p0XUj8Rauze7B4VPMEBMTVLBylA0sdTX6L2ZRYziy05+Jf
         sfPOaydeniBXNU+R1Yx8RDKBlAieskYiXCNdskbfTR33Da9gNm/6ldIsb48JjFNBEe13
         q83AIuAtm7/uLibrc2BOLB+REYnwNiujyit4Ci/7tY5KvtymhfUgdGLmQTSD7pTY3+Ye
         vxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eIxobHanVVV7p4lGf1aBEUdrw5ikpusn57X5A64Zg5M=;
        b=PvRBCj5OKrHmD/9CeOo2jlAEPFJsGN1Dag3An5kDXKZ+E2Z7+76z6SxpSfTEHOW1rj
         ehytD485+ZMzLxygWERmvVONEYIC80+pEia3vTi7wcDEMPURTp6XSEHIZ085COGBSMJg
         CimMmoqjFcJscUfPB8tKH5Ws48QsVI9Pc/opMlh9YNSuK55cHzN2NimhkWehl80R0o+h
         eO0A5d0lZobn2GsfLLqmc6HwU83zMWted/+eWmZrJV3e5/ReCkwpCpWvLwYfrTMch6HX
         Imoh48Vgn1anX3UCKH64B+iV0eXvVK4NKPWqnAzSz4OC3BqlXJFstYb5IuHx9jX9M+/B
         LUkQ==
X-Gm-Message-State: AJcUukfZyMr0P3XndmC0BdvIaBZ1gDEoWYsN1kY3uX38T+I4aCEAGGJH
        2xocos8oaickNvRg0B3IPgQxNjIxMhY=
X-Google-Smtp-Source: ALg8bN6b5J9P4GUpsK2WN8ppu+cGCQK1MgkW9Uw85UFWMimRHyRon6/E9fbT88jsvb9HqHBZRhBssQ==
X-Received: by 2002:a6b:3bc8:: with SMTP id i191mr10970226ioa.23.1547235171581;
        Fri, 11 Jan 2019 11:32:51 -0800 (PST)
Received: from localhost ([67.218.223.154])
        by smtp.gmail.com with ESMTPSA id r195sm1320694ita.3.2019.01.11.11.32.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 11:32:50 -0800 (PST)
From:   Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        himanshujha199640@gmail.com, mark.rutland@arm.com,
        robh+dt@kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org,
        Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Subject: [PATCH 1/2] iio: chemical: bme680: Add device-tree support
Date:   Fri, 11 Jan 2019 14:31:40 -0500
Message-Id: <20190111193141.20607-1-sebastien.bourdelin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit allow the driver to work with device-tree.

Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
---
 drivers/iio/chemical/bme680_i2c.c | 7 +++++++
 drivers/iio/chemical/bme680_spi.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
index 06d4be539d2e..94a36ebdf0b2 100644
--- a/drivers/iio/chemical/bme680_i2c.c
+++ b/drivers/iio/chemical/bme680_i2c.c
@@ -70,10 +70,17 @@ static const struct acpi_device_id bme680_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
 
+static const struct of_device_id bme680_of_i2c_match[] = {
+	{ .compatible = "bosch,bme680", },
+	{},
+}
+MODULE_DEVICE_TABLE(of, bme680_of_i2c_match);
+
 static struct i2c_driver bme680_i2c_driver = {
 	.driver = {
 		.name			= "bme680_i2c",
 		.acpi_match_table       = ACPI_PTR(bme680_acpi_match),
+		.of_match_table		= of_match_ptr(bme680_of_i2c_match),
 	},
 	.probe = bme680_i2c_probe,
 	.id_table = bme680_i2c_id,
diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
index c9fb05e8d0b9..45bd4e93a891 100644
--- a/drivers/iio/chemical/bme680_spi.c
+++ b/drivers/iio/chemical/bme680_spi.c
@@ -110,10 +110,17 @@ static const struct acpi_device_id bme680_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
 
+static const struct of_device_id bme680_of_spi_match[] = {
+	{ .compatible = "bosch,bme680", },
+	{},
+}
+MODULE_DEVICE_TABLE(of, bme680_of_spi_match);
+
 static struct spi_driver bme680_spi_driver = {
 	.driver = {
 		.name			= "bme680_spi",
 		.acpi_match_table	= ACPI_PTR(bme680_acpi_match),
+		.of_match_table		= of_match_ptr(bme680_of_spi_match),
 	},
 	.probe = bme680_spi_probe,
 	.id_table = bme680_spi_id,
-- 
2.20.1


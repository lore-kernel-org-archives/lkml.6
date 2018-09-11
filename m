Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F4FECDFC0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6A020839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=az8.co header.i=afonsobordado@az8.co header.b="QySoZ0Tj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6A020839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=az8.co
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbeIKUAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:00:31 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21431 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeIKUAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:00:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1536678023; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=WU2NGX/Q5uFOOoOejBJfj684GlH3dWGT9WC8+VUGfi7B3su7NZcKeFUYn7yBIbkZKInxr3wLtKIglNqwJQS0H9FfWu9vzEKIjTuZd1LNmOsewgKj8nveL+NMor3RVw8UhGhMj1Llob+gFCwQF7d3cD+xsT5uWYEPHewtnwaouk0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1536678023; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=kwaKAEKkiHDuPbatLtRuiq06oBkvc5vjFR9gREl3xtY=; 
        b=TP/S08Ep5FCkFMSANU2ksFmRd2n91QasUSlgeo7tqt+zHTiUkpSNpeFQtBZ42CVJ6XNhmeCv1SwRejJyzbcisP7w8juxfhjkhtjP35wRvfT2NkZWrpQoIPCpgTOEaT5MwTxeub70VQ/Rz2CefkGoHJAn+ZIlqhjyEqJy0tEfi48=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=az8.co;
        spf=pass  smtp.mailfrom=afonsobordado@az8.co;
        dmarc=pass header.from=<afonsobordado@az8.co> header.from=<afonsobordado@az8.co>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1536678023;
        s=dkimmail; d=az8.co; i=afonsobordado@az8.co;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1222; bh=kwaKAEKkiHDuPbatLtRuiq06oBkvc5vjFR9gREl3xtY=;
        b=QySoZ0Tjx98eP73uv5wS7v4lDVEAtEZXGgzWKybkOZmTvzSb4O7vJ7e2R5UB5Y8R
        o5L7ZzYiA4rBQ9QqMO/n/YS+tnYK6RaCbb9D3bU7FjG83AellL9IMkW4hD+TzWetOJY
        xH2sA3smQJmE7i6+HM3D8frnBD/2Jp5O9Ri/GLp8=
Received: from localhost (bl9-77-228.dsl.telepac.pt [85.242.77.228]) by mx.zohomail.com
        with SMTPS id 1536678022251349.7712885126558; Tue, 11 Sep 2018 08:00:22 -0700 (PDT)
From:   Afonso Bordado <afonsobordado@az8.co>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 2/5] iio: gyro: add device tree support for fxas21002c
Date:   Tue, 11 Sep 2018 16:00:08 +0100
Message-Id: <20180911150011.31964-2-afonsobordado@az8.co>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180911150011.31964-1-afonsobordado@az8.co>
References: <20180911150011.31964-1-afonsobordado@az8.co>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree support for the fxas21002c driver.

Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
---
 drivers/iio/gyro/fxas21002c.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/fxas21002c.c b/drivers/iio/gyro/fxas21002c.c
index 649316c26f5b..e2ce0622944b 100644
--- a/drivers/iio/gyro/fxas21002c.c
+++ b/drivers/iio/gyro/fxas21002c.c
@@ -8,7 +8,6 @@
  * Datasheet: https://www.nxp.com/docs/en/data-sheet/FXAS21002.pdf
  * TODO:
  *        ODR / Scale Support
- *        Devicetree
  *        Scale Boost Mode
  *        Power management
  *        GPIO Reset
@@ -357,6 +356,12 @@ static int fxas21002c_probe(struct i2c_client *client,
 	return ret;
 }
 
+static const struct of_device_id fxas21002c_of_ids[] = {
+	{.compatible = "fsl,fxas21002c"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, fxas21002c_of_ids);
+
 static const struct i2c_device_id fxas21002c_id[] = {
 	{"fxas21002c", ID_FXAS21002C},
 	{}
@@ -366,6 +371,7 @@ MODULE_DEVICE_TABLE(i2c, fxas21002c_id);
 static struct i2c_driver fxas21002c_driver = {
 	.driver = {
 		.name = FXAS21002C_DRV_NAME,
+		.of_match_table = fxas21002c_of_ids,
 	},
 	.probe		= fxas21002c_probe,
 	.id_table	= fxas21002c_id,
-- 
2.18.0



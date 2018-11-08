Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5E3ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8062D206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmlBrO8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8062D206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeKIGPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:15:34 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45212 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeKIGPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:15:34 -0500
Received: by mail-qk1-f194.google.com with SMTP id d135so28892008qkc.12;
        Thu, 08 Nov 2018 12:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VyMyFFsWjC5CxdJRh55nWQzferucC4h20nm8bws236Q=;
        b=QmlBrO8DWj8apuYIbzBrRjLY7P3rQQWnGaUuMzKu2ZuF36XyzltHxIdhwNz8eV665P
         yFN4oZs9PUZ8pTQyFx5PJK4mDfNGajQKXmHiiNK27Rr6F4NXjdrvBqOOhZvxCMKJnGhg
         Nz7q/MJul3F6fMmJBwjUBsOf3YwyDvo5yQqwnPDAWmvWYYf7GXCHNrkM0SGUChVnxd5F
         AOWFqs/0yM1Rk6lUTTOxgVqe0PZh7x8NXGhhhesK2QRpDbm801qhv78cbNV6CMbSSYYo
         Ip/3wUlBSJf6Gk1pTIqPlNnx0+QC+CYxk4ZEtooL728/77iZNDZDic+G23M9BKVyC0fJ
         PWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VyMyFFsWjC5CxdJRh55nWQzferucC4h20nm8bws236Q=;
        b=LZ5REo4R2JZ9//IZtFveD8PfSzbaTlQfntzwaFVlRq49VmgtULMfVKQVlzg54kVj1M
         dOemHURaGoKAoUNix9b4zmY5CYFDOT3G3PKF25dXpX1N3C7PgJ0sSFowZ63A7XBlDwB+
         KlDwpKK5ZNO0r/jSC46wiW+2/vifBoUVPGvsgoFEvQBcL973rJ51QdfK7e3x/PREWTYH
         qZqzGG2DSVsifGSXqyimvDk5OEopBK0f7s/62lmSSGHlAUycTsIh56+SEp4YgSdmzjBf
         qrv/vMEF+kutrKx1pywnziaMCsZvviFo+bwa5/aalcMhjXWbmHBz+ltjtYh1WLWmMZMv
         /fqA==
X-Gm-Message-State: AGRZ1gIVoy7Ho/4kl603QZOVNM4cEyrgkHWfUpejxRMGJOsgnALw1qV0
        pb5QXtzIQ2srSV/u85G0xmCIvvi13lA=
X-Google-Smtp-Source: AJdET5fawRSZ71179nQMIT08TkdNu3kzL1BItMNw36Qaf9TpISknV1C9BkuqmzG9o3dyZ5E6zRtUDQ==
X-Received: by 2002:aed:2c47:: with SMTP id f65mr6004727qtd.340.1541709503751;
        Thu, 08 Nov 2018 12:38:23 -0800 (PST)
Received: from avalerion.lan (va-67-233-64-2.dhcp.embarqhsd.net. [67.233.64.2])
        by smtp.googlemail.com with ESMTPSA id c194sm2616326qke.0.2018.11.08.12.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 12:38:01 -0800 (PST)
From:   Matt Walker <mattofak@gmail.com>
Cc:     Matt Walker <mattofak@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IIO: extend dac/MCP4922 to MCP49x1 devices
Date:   Thu,  8 Nov 2018 15:36:53 -0500
Message-Id: <20181108203655.17448-1-mattofak@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the existing dual channel MCP4922 DAC driver to single channel
MCP49x1 devices. These devices are simple and write only. The most
significant bit of the transfer dictates what channel to write to.

Although there is no danger in writing to the non existant channel in
the single channel devices, it's better to not register it at all.
Therefore extend the driver to know how many channels a device has at
probe time based on the ID table.

Signed-off-by: Matt Walker <mattofak@gmail.com>
---
 drivers/iio/dac/mcp4922.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
index b5190d1dae8e..094f7dd560ca 100644
--- a/drivers/iio/dac/mcp4922.c
+++ b/drivers/iio/dac/mcp4922.c
@@ -29,8 +29,11 @@
 #define MCP4922_NUM_CHANNELS	2
 
 enum mcp4922_supported_device_ids {
+	ID_MCP4901,
 	ID_MCP4902,
+	ID_MCP4911,
 	ID_MCP4912,
+	ID_MCP4921,
 	ID_MCP4922,
 };
 
@@ -115,10 +118,22 @@ static int mcp4922_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static const struct iio_chan_spec mcp4922_channels[3][MCP4922_NUM_CHANNELS] = {
-	[ID_MCP4902] = { MCP4922_CHAN(0, 8),	MCP4922_CHAN(1, 8) },
-	[ID_MCP4912] = { MCP4922_CHAN(0, 10),	MCP4922_CHAN(1, 10) },
-	[ID_MCP4922] = { MCP4922_CHAN(0, 12),	MCP4922_CHAN(1, 12) },
+static const unsigned int mcp4922_channel_counts[6] = {
+	[ID_MCP4901] = 1,
+	[ID_MCP4902] = 2,
+	[ID_MCP4911] = 1,
+	[ID_MCP4912] = 2,
+	[ID_MCP4921] = 1,
+	[ID_MCP4922] = 2,
+};
+
+static const struct iio_chan_spec mcp4922_channels[6][MCP4922_NUM_CHANNELS] = {
+	[ID_MCP4901] = { MCP4922_CHAN(0, 8),  {} },
+	[ID_MCP4902] = { MCP4922_CHAN(0, 8),  MCP4922_CHAN(1, 8) },
+	[ID_MCP4911] = { MCP4922_CHAN(0, 10), {} },
+	[ID_MCP4912] = { MCP4922_CHAN(0, 10), MCP4922_CHAN(1, 10) },
+	[ID_MCP4921] = { MCP4922_CHAN(0, 12), {} },
+	[ID_MCP4922] = { MCP4922_CHAN(0, 12), MCP4922_CHAN(1, 12) },
 };
 
 static const struct iio_info mcp4922_info = {
@@ -166,7 +181,7 @@ static int mcp4922_probe(struct spi_device *spi)
 	indio_dev->info = &mcp4922_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mcp4922_channels[id->driver_data];
-	indio_dev->num_channels = MCP4922_NUM_CHANNELS;
+	indio_dev->num_channels = mcp4922_channel_counts[id->driver_data];
 	indio_dev->name = id->name;
 
 	ret = iio_device_register(indio_dev);
@@ -197,8 +212,11 @@ static int mcp4922_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id mcp4922_id[] = {
+	{"mcp4901", ID_MCP4901},
 	{"mcp4902", ID_MCP4902},
+	{"mcp4911", ID_MCP4911},
 	{"mcp4912", ID_MCP4912},
+	{"mcp4921", ID_MCP4921},
 	{"mcp4922", ID_MCP4922},
 	{}
 };
@@ -215,5 +233,5 @@ static struct spi_driver mcp4922_driver = {
 module_spi_driver(mcp4922_driver);
 
 MODULE_AUTHOR("Michael Welling <mwelling@ieee.org>");
-MODULE_DESCRIPTION("Microchip MCP4902, MCP4912, MCP4922 DAC");
+MODULE_DESCRIPTION("Microchip MCP49xx DAC");
 MODULE_LICENSE("GPL v2");
-- 
2.17.1


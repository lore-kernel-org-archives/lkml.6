Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DE5C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6226920868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBmlYwwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6226920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeJZWCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:02:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34733 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeJZWCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:02:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id g12-v6so544520pgs.1;
        Fri, 26 Oct 2018 06:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1gAAOpGWm9oJGIYTfyIoPjoxdi22bxF2tUaxSkoBGoo=;
        b=lBmlYwwuXzK4Tuni3ihHL/7xTuf0GvaOQ5legFn3wsotwFzo4j3gTS/MS51SV5G0YS
         qHIACa0lg7J8Okd7iQWClE7nfAn0IspAyv6Vg1pXIqLLPF33bDpv9/Zn/1DpnE3pGO0W
         Wj69ZOnctam/3MFXPZzo0C8nRMS3z0depjgpXmJtqNGeolkwa7Ow59QUchd55Pwaz8o+
         0Or/LMYd7lOvZMN/UP/eJT6nL4b0zq9Zs4WM1srzg9uUevrbPfPcsGDCpvbmGYNquNvw
         JuYBKBBJt+omfT04Bln+Bx1RMYL75UNu2TUA+jF2/4ClC39dJvX1IUZEW49Eh5Gkd/rU
         tcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1gAAOpGWm9oJGIYTfyIoPjoxdi22bxF2tUaxSkoBGoo=;
        b=JozOVCqeTA283D947yKMHso23biqKDa+sGPoTt1ua1qykC4ATnCYnnN3WZ8hEmK9z1
         J0H4sOyXr3iLLXPh0HNaux3IxfKguCXoIsrp6iuveIcHD4G1uwNmtT3WzVm3XwlWIDr1
         0Pmq4SoBhRF8KN4Z/FsXlshHSHil7dg8yHeR40irOMaOAR5syjurEMZdWF3SNCVE90cs
         hMmGpvDyKg3EuKtvHy45RQxtK3yyrHJHpc1ZyyEVgm2TfX+35bZrGiqs2d69TuyzsvEE
         QjtYJXzoJI6hAG7yntEirxxCsE1GwVgVigB0g3F+4s5GG1nGLzVY/jLlWasAfa4VpRqF
         UiRw==
X-Gm-Message-State: AGRZ1gKc/tpOLs9AlLCTtEfPoHHGQZj3kOo3JpjQevACnGjMeH9uLJIr
        dfn/afFB9BBTHxqs2mdW+iW33rg1a9o4hA==
X-Google-Smtp-Source: AJdET5eNDCdFwJOiw/KIysJQJLHoLtXicX9gq1nt0ftQi6RrVKOT0q9s1yUyGgKH+p9fC933Uql9PQ==
X-Received: by 2002:a65:5608:: with SMTP id l8-v6mr3528968pgs.433.1540560342524;
        Fri, 26 Oct 2018 06:25:42 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id z11-v6sm18151555pfd.99.2018.10.26.06.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 06:25:41 -0700 (PDT)
Date:   Fri, 26 Oct 2018 18:55:34 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Slawomir Stepien <sst@poczta.fm>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] staging: iio: ad2s1210: Add device tree support.
Message-ID: <1dc6fdf4626e7cf1ca4933fe3008cb3cd267149b.1540489369.git.nishadkamdar@gmail.com>
References: <cover.1540489369.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540489369.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree table for matching vendor ID
and support for retrieving platform data
from device tree.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 43 ++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 93c3c70ce62e..9fd5461c4ed0 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -669,6 +670,27 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct ad2s1210_platform_data *ad2s1210_parse_dt(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct ad2s1210_platform_data *pdata;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	pdata->gpioin = of_property_read_bool(np, "adi,gpioin");
+
+	return pdata;
+}
+#else
+static struct ad2s1210_platform_data *ad2s1210_parse_dt(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static int ad2s1210_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -682,7 +704,19 @@ static int ad2s1210_probe(struct spi_device *spi)
 	if (!indio_dev)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
-	st->pdata = spi->dev.platform_data;
+	if (spi->dev.of_node) {
+		st->pdata = ad2s1210_parse_dt(&spi->dev);
+		if (!st->pdata)
+			return -EINVAL;
+	} else {
+		st->pdata = spi->dev.platform_data;
+	}
+
+	if (!st->pdata) {
+		dev_err(&spi->dev, "ad2s1210: no platform data supplied\n");
+		return -EINVAL;
+	}
+
 	ret = ad2s1210_setup_gpios(st);
 	if (ret < 0)
 		return ret;
@@ -724,6 +758,12 @@ static int ad2s1210_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id ad2s1210_of_match[] = {
+	{ .compatible = "adi,ad2s1210", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad2s1210_of_match);
+
 static const struct spi_device_id ad2s1210_id[] = {
 	{ "ad2s1210" },
 	{}
@@ -733,6 +773,7 @@ MODULE_DEVICE_TABLE(spi, ad2s1210_id);
 static struct spi_driver ad2s1210_driver = {
 	.driver = {
 		.name = DRV_NAME,
+		.of_match_table = of_match_ptr(ad2s1210_of_match),
 	},
 	.probe = ad2s1210_probe,
 	.remove = ad2s1210_remove,
-- 
2.17.1


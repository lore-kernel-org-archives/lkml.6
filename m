Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C9DC65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE11320881
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOX+hnXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE11320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbeLHSTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 13:19:45 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38853 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbeLHSTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 13:19:45 -0500
Received: by mail-qt1-f193.google.com with SMTP id p17so8160739qtl.5;
        Sat, 08 Dec 2018 10:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g4OFN6eemQMqhRIJQa2XiEjm3UXDOntNSgSULrBno2I=;
        b=YOX+hnXiYx7gdUnlIxaxaQHe+dn83E3qufUQsU0WcpoxN3CdCs96lAuG6MX34/jtDa
         mNHeG6e/YJH8oqRYYLSkOGiZR8iniAqrkstocyzJJZHAr6nREYM7aMQtGlfQ4sDCzdWv
         IvPHjc0q5Xohn2Y6/hWvPtDCSLmsBqIvsaf/O6+PGTwBNk/x/bd0OK3OvkXAToEA0Z/w
         4Na5BFZ9dJEFqzlxNcPvRKoXAcOoKWQt8q2mzjN651+M70Y3G6cdAG3Dr4KY1S00N+Ed
         NPDNWUNOBWSK9LjL7+LN2YxTyNj0z29WU/PEwJVLYKeL5Dm2Udqr6Ba+LTWRsuRkc8OA
         Xc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g4OFN6eemQMqhRIJQa2XiEjm3UXDOntNSgSULrBno2I=;
        b=WAOtwSbT5IBJarONX2NEC0VUJzJBeuw4awHMkC4wGPXyeXIeUAo3RsEoNGKI6W57vH
         A0I6EWOkcprMfhajyl+8yEY9mwZOguJbdI1blvZFy1aIUBsoFdQ9lt6Dfg9YfG+0e37T
         hUGjkHaLzyv8+rJAkyhGDXj0OCckZuLNa0JcQASfxO1I1Y7JUugv+orPTYcGs5FIGacG
         O3AQnxuLfTcxJiSYq0HFt02eM4rKyKcKvB93IRqBYHN6uk8s9xdFfgkaxUBbChd1y18f
         eHBJ6kOTPugDcDUpsNE5UcLVlnrt3stTFUfV7X56hpAzbQJ1O09RRJd7+L9Dt7VNNF7a
         Y9/Q==
X-Gm-Message-State: AA+aEWa5hJH2BzjfO1ZsLwX9nb2ieI/Ajp7H++Cq5GSIFU1SSg6grZQO
        6GfaE/6fRRQyYGxbBQQT8aw=
X-Google-Smtp-Source: AFSGD/WZiuk50zuzRkK4cGxfdItnaZioz1C64N9W8eTKA1obuJ2yvHdoLQKKYJAh4M5uvW3HGactjA==
X-Received: by 2002:ac8:280f:: with SMTP id 15mr6671364qtq.31.1544293184010;
        Sat, 08 Dec 2018 10:19:44 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id v186sm3705967qkd.13.2018.12.08.10.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Dec 2018 10:19:43 -0800 (PST)
Date:   Sat, 8 Dec 2018 16:19:38 -0200
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 2/3] staging: iio: ad5933: use clock framework for clock
 reference
Message-ID: <2e60aac1f824d421b355e0df8b4a564fb422202b.1544292845.git.marcelo.schmitt1@gmail.com>
References: <cover.1544292845.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1544292845.git.marcelo.schmitt1@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the option to specify the external clock (MCLK) using the clock
framework.
Also remove the old platform data structure.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Gabriel Capella <gabriel@capella.pro>
Co-Developed-by: Gabriel Capella <gabriel@capella.pro>
---
 .../staging/iio/impedance-analyzer/ad5933.c   | 43 ++++++++++---------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 730bc397a26b..3134295f014f 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/clk.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -82,20 +83,10 @@
 #define AD5933_POLL_TIME_ms		10
 #define AD5933_INIT_EXCITATION_TIME_ms	100
 
-/**
- * struct ad5933_platform_data - platform specific data
- * @ext_clk_hz:		the external clock frequency in Hz, if not set
- *			the driver uses the internal clock (16.776 MHz)
- * @vref_mv:		the external reference voltage in millivolt
- */
-
-struct ad5933_platform_data {
-	unsigned long			ext_clk_hz;
-};
-
 struct ad5933_state {
 	struct i2c_client		*client;
 	struct regulator		*reg;
+	struct clk			*mclk;
 	struct delayed_work		work;
 	struct mutex			lock; /* Protect sensor state */
 	unsigned long			mclk_hz;
@@ -111,9 +102,6 @@ struct ad5933_state {
 	unsigned int			poll_time_jiffies;
 };
 
-static struct ad5933_platform_data ad5933_default_pdata  = {
-};
-
 #define AD5933_CHANNEL(_type, _extend_name, _info_mask_separate, _address, \
 		_scan_index, _realbits) { \
 	.type = (_type), \
@@ -690,9 +678,9 @@ static int ad5933_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	int ret;
-	struct ad5933_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct ad5933_state *st;
 	struct iio_dev *indio_dev;
+	unsigned long ext_clk_hz = 0;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
 	if (!indio_dev)
@@ -704,9 +692,6 @@ static int ad5933_probe(struct i2c_client *client,
 
 	mutex_init(&st->lock);
 
-	if (!pdata)
-		pdata = &ad5933_default_pdata;
-
 	st->reg = devm_regulator_get(&client->dev, "vdd");
 	if (IS_ERR(st->reg))
 		return PTR_ERR(st->reg);
@@ -723,8 +708,21 @@ static int ad5933_probe(struct i2c_client *client,
 
 	st->vref_mv = ret / 1000;
 
-	if (pdata->ext_clk_hz) {
-		st->mclk_hz = pdata->ext_clk_hz;
+	st->mclk = devm_clk_get(&client->dev, "mclk");
+	if (IS_ERR(st->mclk) && PTR_ERR(st->mclk) != -ENOENT) {
+		ret = PTR_ERR(st->mclk);
+		goto error_disable_reg;
+	}
+
+	if (!IS_ERR(st->mclk)) {
+		ret = clk_prepare_enable(st->mclk);
+		if (ret < 0)
+			goto error_disable_reg;
+		ext_clk_hz = clk_get_rate(st->mclk);
+	}
+
+	if (ext_clk_hz) {
+		st->mclk_hz = ext_clk_hz;
 		st->ctrl_lb = AD5933_CTRL_EXT_SYSCLK;
 	} else {
 		st->mclk_hz = AD5933_INT_OSC_FREQ_Hz;
@@ -744,7 +742,7 @@ static int ad5933_probe(struct i2c_client *client,
 
 	ret = ad5933_register_ring_funcs_and_init(indio_dev);
 	if (ret)
-		goto error_disable_reg;
+		goto error_disable_mclk;
 
 	ret = ad5933_setup(st);
 	if (ret)
@@ -758,6 +756,8 @@ static int ad5933_probe(struct i2c_client *client,
 
 error_unreg_ring:
 	iio_kfifo_free(indio_dev->buffer);
+error_disable_mclk:
+	clk_disable_unprepare(st->mclk);
 error_disable_reg:
 	regulator_disable(st->reg);
 
@@ -772,6 +772,7 @@ static int ad5933_remove(struct i2c_client *client)
 	iio_device_unregister(indio_dev);
 	iio_kfifo_free(indio_dev->buffer);
 	regulator_disable(st->reg);
+	clk_disable_unprepare(st->mclk);
 
 	return 0;
 }
-- 
2.17.1


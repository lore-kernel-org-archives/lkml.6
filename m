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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159F6C65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CA42081F
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGVxMjvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CA42081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeLHSTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 13:19:16 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34148 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbeLHSTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 13:19:15 -0500
Received: by mail-qt1-f193.google.com with SMTP id r14so8195617qtp.1;
        Sat, 08 Dec 2018 10:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ASDzKMtiVT4Z0JiMG3IHch+aSbW5ahwV29P1VwMv1M=;
        b=NGVxMjvMPhTdPXKhRNXnzEC1k1jEHdiTpqaGaG51OO49x8CTxhEzNinyK5/rWO5DkS
         8Czcv1ERyWFnKxzBXG6Di+jc/i3bnhdL8XwuW2VZrA5tZ35eLyRbqXizKkbAxZoiu99t
         GOlYa5VFoBSugRij/qulliCWrtW9JNeZX1KL9q8AdNobzWvkgMeSN435hqQ9l91Q1v7w
         PBEkQFlVe3aIiFmXrJOaEAxkbbwZG1JkwEyzIk1cpE2x8VqVWeUkBkx2YTMhIMXMSN6W
         t3oEuenLyx+ltEKUU/hiSslqor3Zr9iZ2/rsmPhiQmggW2zz2JVIaqMuX5eFAqsqVrFG
         2cMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ASDzKMtiVT4Z0JiMG3IHch+aSbW5ahwV29P1VwMv1M=;
        b=DUbu9bzHq4qLUXxWY+3CH5pQDsh2hUWLk01ELscloDPnlS5WqZHzUrpcrF3fWWtk9B
         PqMX3SrrwfEGuN8M8I6E4Jqt386XVimflnaga5ruIS7CVHLmlaxwA8rLGFzGSfMK8Lyg
         BmD3o7TNi6+wo988B2KMbgf3UL9zV2eAa+twBUR6d1mRT+G9Pc7lqhce9S4p/rEuCK9u
         QE8qxCTyJbESUAqZs9tmG9/T7CxA3EefzwKKbkTUrs/vNefIetCvbQwFfS/2XOQ6qu16
         I9FvuMjUKVO3kBESmvzbKxEG+kVH4lJyYW7vD23Ln6vjQshVXR8ld9cs0veZci8Hs4nV
         ojwA==
X-Gm-Message-State: AA+aEWY5CjeN/gkLQ7v40llMkxma9JbSovk1BXc3PueaoYMRRyKqYRlQ
        6nHeSxaJ6ytMGjTG5/Q9q8Y=
X-Google-Smtp-Source: AFSGD/UCAwcSfqZKLoUQaabpkM4czTHL4vixp65mBLZA/ZGQRwGXnCWIiya4q/JbK+efcEvWjb1sOw==
X-Received: by 2002:ac8:24e7:: with SMTP id t36mr6462301qtt.43.1544293153423;
        Sat, 08 Dec 2018 10:19:13 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id v2sm3358198qte.75.2018.12.08.10.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Dec 2018 10:19:13 -0800 (PST)
Date:   Sat, 8 Dec 2018 16:19:08 -0200
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 1/3] staging: iio: ad5933: change regulator binging for vref
Message-ID: <06caedbbe394a76feedbc77edb0df2c6109217bd.1544292845.git.marcelo.schmitt1@gmail.com>
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

Set a single voltage regulator for all voltage references.
Remove voltage reference value from default platafrom data struct.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Gabriel Capella <gabriel@capella.pro>
Co-Developed-by: Gabriel Capella <gabriel@capella.pro>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 9e52384f5370..730bc397a26b 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -91,7 +91,6 @@
 
 struct ad5933_platform_data {
 	unsigned long			ext_clk_hz;
-	unsigned short			vref_mv;
 };
 
 struct ad5933_state {
@@ -113,7 +112,6 @@ struct ad5933_state {
 };
 
 static struct ad5933_platform_data ad5933_default_pdata  = {
-	.vref_mv = 3300,
 };
 
 #define AD5933_CHANNEL(_type, _extend_name, _info_mask_separate, _address, \
@@ -691,7 +689,7 @@ static void ad5933_work(struct work_struct *work)
 static int ad5933_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
-	int ret, voltage_uv = 0;
+	int ret;
 	struct ad5933_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct ad5933_state *st;
 	struct iio_dev *indio_dev;
@@ -718,12 +716,12 @@ static int ad5933_probe(struct i2c_client *client,
 		dev_err(&client->dev, "Failed to enable specified VDD supply\n");
 		return ret;
 	}
-	voltage_uv = regulator_get_voltage(st->reg);
+	ret = regulator_get_voltage(st->reg);
+
+	if (ret < 0)
+		goto error_disable_reg;
 
-	if (voltage_uv)
-		st->vref_mv = voltage_uv / 1000;
-	else
-		st->vref_mv = pdata->vref_mv;
+	st->vref_mv = ret / 1000;
 
 	if (pdata->ext_clk_hz) {
 		st->mclk_hz = pdata->ext_clk_hz;
-- 
2.17.1


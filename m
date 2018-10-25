Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B4DECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBBC20824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gORb6cHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBBC20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeJZHEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:04:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37202 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeJZHEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:04:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id d14-v6so11914911qto.4;
        Thu, 25 Oct 2018 15:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S8vZmvdGUiC7CSK5dkt+m3y87P6zuXNe3u1DBd0mrVo=;
        b=gORb6cHDZ9Xsqvb2oeWBtl55DonGhhVaghZAuIP9SNcwV5zYLnNzsRxHimFPkYkKHs
         BMeqH19LUWviDdqPiHa8XbYijjw4YRb1wy8v6EWG9aTMnF/XGs3BqkafNr0r8w0RPXbO
         i419LH8XyDgICnoRTuWXaHMm56fQ3e9fMyI08qT0XuGX9gau6pWtSYr7L78AA6k/a6Wa
         nwaNPy9zr2OjzKTYZS+mSjyMtFwdlT4+MvlMrWJyCQwPuO+WXVAMqssW5ZUlKIGqVC/+
         mpGc9ioI+NWuz3mRcZshKmS0HMtOna24T66uHdMi2+EWD8Us8DAxYdMpvpFt3q24sPTy
         TbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S8vZmvdGUiC7CSK5dkt+m3y87P6zuXNe3u1DBd0mrVo=;
        b=jkPYU9bscpcpGgPUJ4oIaDlOo91cZbwWtNPQKanCad2l5gp5qvtgeEoXTk8VsVCb2O
         WKAobmObpZUoH9pnzFw4q+d8fjQ1h9Op9c2rH+TVlo/fiVNtC74Z4Yi0xZLrgCYoFPNV
         oJHLV15KBk6IpOhxSFiTzFo+9UMH5A0SsPV19jGXOHPl82AZXLGxWioF0yCH8JkfV9wH
         iGyPJjyDbzp2l4RT7kreOmcMYXkc54IPMAFUCcSB73ONcj8CvuwXVFLj3luwNKj6u9nM
         Lt6DXinoHAbGR+f3iq9uNgFX4Yn1PH15glOUghHASbWzAJ8z0nOIxdugjz59ZhET3Vaf
         iCxg==
X-Gm-Message-State: AGRZ1gJJaja+b4Wlkb0DElN1Obd9srukrfMpqvmY0t/J1xgdlX6JePOq
        t7OGHBPhVnR6EQVeHrMhKbI=
X-Google-Smtp-Source: AJdET5eDD5KtxyJuUHOfWb/oq2R/DOHUwKExBPlvNqm4SNjVAQFlwGigCB/4FzEa/d6mEa/IO9E9mg==
X-Received: by 2002:ac8:33ad:: with SMTP id c42-v6mr1042922qtb.190.1540506609387;
        Thu, 25 Oct 2018 15:30:09 -0700 (PDT)
Received: from renatolg ([186.220.20.163])
        by smtp.gmail.com with ESMTPSA id y47-v6sm8619123qtc.15.2018.10.25.15.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 15:30:09 -0700 (PDT)
Date:   Thu, 25 Oct 2018 19:30:04 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        alexandru.Ardelean@analog.com, stefan.popa@analog.com,
        giuliano.belinassi@usp.br
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 1/2] staging: iio: ad7780: update voltage on read
Message-ID: <1f7b2c6ee0e18b1c43a8b27f482b08313c52d4e9.1540506298.git.renatogeh@gmail.com>
References: <cover.1540506298.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1540506298.git.renatogeh@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ad7780 driver previously did not read the correct device output, as
it read an outdated value set at initialization. It now updates its
voltage on read.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 drivers/staging/iio/adc/ad7780.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index b67412db0318..27972563bb6a 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -87,11 +87,15 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad7780_state *st = iio_priv(indio_dev);
+	int voltage_uv = 0;
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
 		return ad_sigma_delta_single_conversion(indio_dev, chan, val);
 	case IIO_CHAN_INFO_SCALE:
+		voltage_uv = regulator_get_voltage(st->reg);
+		if (voltage_uv)
+			st->int_vref_mv = voltage_uv/1000;
 		*val = st->int_vref_mv * st->gain;
 		*val2 = chan->scan_type.realbits - 1;
 		return IIO_VAL_FRACTIONAL_LOG2;
-- 
2.19.1


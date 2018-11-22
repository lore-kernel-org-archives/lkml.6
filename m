Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A89C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 22:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B813E20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 22:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ms1C6bQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B813E20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407800AbeKWImt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:42:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43647 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbeKWImp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:42:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so10523193wrs.10;
        Thu, 22 Nov 2018 14:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OekskNfYJb3GaDnKXG3tXL9mAK30t1c99Vq8PTGsDH8=;
        b=Ms1C6bQUY05rNAEWQ2uECwGOA0s6uxjw6zL6k/FL+3GJ6Q+5Tij4s8Gx0yb0+1o4Sr
         kOUovS5lmymnfAb+wbExRwacODfgKmB+LoHSg7O4eSZBWSpc7S51kXg+0coVpUKDEIdK
         i3QsJKkUIn1J5hg2pfzOBcqUFr3g2HhdRPokqV5kkJTnJnKmeCtYvUdoZwKIobk7tBd6
         Jq2ax9p28wHpd2b6gRLNQZfmtQ+1kNQ/B35LKCC0JARomaGSvoYRk00RlnfYOitQtrdD
         dKEHmnIBMzW8EKDWeWe1QqJFTm5OkFOx79aY/K5Uo/4FxdpcqHujErB0RWfPMoBBo7gf
         rRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OekskNfYJb3GaDnKXG3tXL9mAK30t1c99Vq8PTGsDH8=;
        b=Oz5UogCznHift6a+8gs2yazqL8CywuCEWDK+XB8AwPb5adTvPaCsTPasYoBLlJvMfp
         Fjs0QkuE6ZPlzcjB7HEjMMuA8WZLY2Fgxg8l5lJBfi863HFu4wQkszxt7VupcYZL8FEh
         7nc5ELrFLdhSTXZXIWcMQyNYZ/HU63pOIQ3ef6R4b0EhlwJWsctr1PrMLdwVMibkVxPz
         S7YfeMbaUSym5oU6mTXQY+Gd3L35A0o78IKohXpVqUvhPUh6nhIx6pF/zonjtrLWHVWd
         y6zfSbd/lCbfxqealBNrmSdZNexvDoLaMUyn9DnRdzooIoskIYWulU2XMpcW5WU6+bgG
         pbdA==
X-Gm-Message-State: AA+aEWYcRO5cD8LIMHXdhrXc3TlEYaRj3d08CkMh5vzo8KjguyNENGDj
        ndpQVQqQ7ZW7M4Jnf8IOVEo=
X-Google-Smtp-Source: AFSGD/XOfTfVXa5z9lb0FomQp9HXealdGupvfgAx2f4wmKb7hyi51eW/KsJJOCpmncpdV87OvoWXsA==
X-Received: by 2002:adf:f38f:: with SMTP id m15mr11278013wro.111.1542924084592;
        Thu, 22 Nov 2018 14:01:24 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD732F5007DE18DA1F72FF8D9.dip0.t-ipconnect.de. [2003:dc:d732:f500:7de1:8da1:f72f:f8d9])
        by smtp.googlemail.com with ESMTPSA id y81-v6sm3327823wmd.11.2018.11.22.14.01.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 14:01:24 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/1] iio: adc: meson-saradc: fix internal clock names
Date:   Thu, 22 Nov 2018 23:01:11 +0100
Message-Id: <20181122220111.28808-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122220111.28808-1-martin.blumenstingl@googlemail.com>
References: <20181122220111.28808-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this patch we are registering the internal clocks (for example on
Meson8b, where the SAR ADC IP block implements the divider and gate
clocks) with the following names:
- /soc/cbus@c1100000/adc@8680#adc_div
- /soc/cbus@c1100000/adc@8680#adc_en

This is bad because the common clock framework uses the clock to create
a directory in <debugfs>/clk. With such name, the directory creation
(silently) fails and the debugfs entry ends up being created at the
debugfs root.

With this change, the new clock names are:
- c1108680.adc#adc_div
- c1108680.adc#adc_en

This matches the clock naming scheme used in the PWM, Ethernet and MMC
drivers. It also fixes the problem with debugfs.
The idea is shamelessly taken from commit b96e9eb62841c5 ("pwm: meson:
Fix mux clock names").

Fixes: 3921db46a8c5bc ("iio: Convert to using %pOF instead of full_name")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 6155d26091eb..729becb2d3d9 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -656,8 +656,8 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
 	struct clk_init_data init;
 	const char *clk_parents[1];
 
-	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%pOF#adc_div",
-				   indio_dev->dev.of_node);
+	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%s#adc_div",
+				   dev_name(indio_dev->dev.parent));
 	if (!init.name)
 		return -ENOMEM;
 
@@ -678,8 +678,8 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
 	if (WARN_ON(IS_ERR(priv->adc_div_clk)))
 		return PTR_ERR(priv->adc_div_clk);
 
-	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%pOF#adc_en",
-				   indio_dev->dev.of_node);
+	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%s#adc_en",
+				   dev_name(indio_dev->dev.parent));
 	if (!init.name)
 		return -ENOMEM;
 
-- 
2.19.1


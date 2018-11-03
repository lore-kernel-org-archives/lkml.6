Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F73C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBE520685
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="xVuXDa7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BBE520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbeKDIDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 03:03:04 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42695 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbeKDIDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 03:03:03 -0500
Received: by mail-qk1-f193.google.com with SMTP id u68so8938629qkg.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 15:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m0AamTcm1g4t7bycgutx/ePAEZettKzmbxK6n56vTuo=;
        b=xVuXDa7SIAlQvPnjjEqBbluD0g7qOhssMDDXcJ4NVxL2IP8nNndDK2RVatjx+MHffm
         DlwmktP1oEZ34TqmR4dToUiSvQDRsEWbyzGlHQN+Lzk5D+uSqPUmRmsSgdQg2eQkTX6c
         birMcUVjD7EQhoLj78nxCfaOqc+Lux+1UufnYgWUA4TSHN5XAfasQpip/KAhJSXXenYU
         VM5AizT+3+4hZdbEIJqMogjC1LwOnElI+LfrL76QFtzrLlyEG+6GqQr2kStvAecxHZCk
         9f+mmsA/XiarkEEY9Lk4nSBZifQfA8H/A5xc7p9b6TmU6TAL20MohUxAn5VWceKqYdRz
         lfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m0AamTcm1g4t7bycgutx/ePAEZettKzmbxK6n56vTuo=;
        b=SgNNsBMgXQmarj2cnG7Fn9NiPOwhD7Ov6aMMBxHzwdHWBnjukJjFf53PTqS+VspYOy
         h5VcboXOP/+0x6e0At9A7ab3vy4OdDY74bnKjMpnBYGJi52z8uMBJ2hiLRdsA2AlWsay
         jeAbvyP5RwAU40uVnsRXccYnl9e0yPwDyDeD8W6OP2VfcM5SVUgC6xGxoc8OcHYOhK2N
         f+ynXtjaDEu15DGzTRRleo2F/JIUv3SQiyyn2gWhRZOLvmjXBAsbKtbbNkH8hslIljjX
         et44G/lFWsNCFmQfIfR8A2d6zRZAGF4SmoRfG2UoxhAPS/fbaehnDQtoB/gQ/vErcd/M
         WdwA==
X-Gm-Message-State: AGRZ1gKv+my5kHAmTrRaXYA4vgcoKeBp8PUYTQYISPG8OTibCimq9XzE
        h9B4H7t0UMREiDQptCH80YoLYw==
X-Google-Smtp-Source: AJdET5f4V7R90r/Ps/jr9qC25oKb7stN+/NkcZzVB9gvH4MhDmnduu4wzuC2Tj96PFcIJ/Y3JsOxlw==
X-Received: by 2002:ad4:5307:: with SMTP id y7mr16298887qvr.9.1541285422387;
        Sat, 03 Nov 2018 15:50:22 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id 35-v6sm27550924qtu.69.2018.11.03.15.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 15:50:21 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Victor Colombo <victorcolombo@gmail.com>
Subject: [PATCH v3 5/6] staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to channel spec and read_raw
Date:   Sat,  3 Nov 2018 19:49:47 -0300
Message-Id: <20181103224948.31014-6-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181103224948.31014-1-matheus.bernardino@usp.br>
References: <20181103224948.31014-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the IIO_CHAN_INFO_SCALE mask to ad2s90_chan and
implements the relative read behavior at ad2s90_read_raw.

Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/resolver/ad2s90.c | 30 +++++++++++++++++++--------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 8f79cccf4814..9c168b7410d0 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -34,17 +34,29 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
 	int ret;
 	struct ad2s90_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->lock);
-	ret = spi_read(st->sdev, st->rx, 2);
-	if (ret < 0) {
+	switch (m) {
+	case IIO_CHAN_INFO_SCALE:
+		/* 2 * Pi / 2^12 */
+		*val = 6283; /* mV */
+		*val2 = 12;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		ret = spi_read(st->sdev, st->rx, 2);
+		if (ret < 0) {
+			mutex_unlock(&st->lock);
+			return ret;
+		}
+		*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
+
 		mutex_unlock(&st->lock);
-		return ret;
-	}
-	*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
 
-	mutex_unlock(&st->lock);
+		return IIO_VAL_INT;
+	default:
+		break;
+	}
 
-	return IIO_VAL_INT;
+	return -EINVAL;
 }
 
 static const struct iio_info ad2s90_info = {
@@ -55,7 +67,7 @@ static const struct iio_chan_spec ad2s90_chan = {
 	.type = IIO_ANGL,
 	.indexed = 1,
 	.channel = 0,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 };
 
 static int ad2s90_probe(struct spi_device *spi)
-- 
2.18.0


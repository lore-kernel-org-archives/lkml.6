Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60005ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E987320824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYHc4jdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E987320824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbeJZHFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:05:12 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39160 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeJZHFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:05:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id g10-v6so11893343qtq.6;
        Thu, 25 Oct 2018 15:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GOH5FTRIP3FPe1Cf6mg0NjeaY1IjAp+qJmnzPVmJk30=;
        b=eYHc4jdtnwIaRYvfosi6txc39FCOSMUozoqneiD7TExsXsjp2Jxu7kgU3eo7K+czDg
         GLNjpEnhfuU/KgoSFcnI4nTEOAq8hVHcwApVS+LQm95c3AoUXVIlMY5tbBCE+iRS9iv3
         mhOEKKDUK1xTqxBw9mb1sBys+sSOeZLQ3wMJCpfDiJdnzlM82dXYDNlgkE7JuRfwhtPw
         3Og65Tm7lubSvTp5a6xrKOmAygp82DdTh7gNoO0MJW++9JkgbvoWO9VPu86IwiovOJd8
         6bTzb33AJXTaXbCfvU5RgfljJvB+SUICspripBI5r2YRT4HXXt8KYSo9q2pTvtcyklmM
         +6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GOH5FTRIP3FPe1Cf6mg0NjeaY1IjAp+qJmnzPVmJk30=;
        b=IChF+96d5Ym7UjLoJKgLfhQzaO+w4C2lv6Pbrjl9pZ1NkSAKbgKTKwJBUnKW8rQ8PC
         bF8u/lLyWd6ibBi5S1AFIwhvlEgQkY30fGRu2KOtPbP+Hw+ZO8JDB6aby3RZiHSsYyl7
         iasypbSG0egcImUr0RjY7JFq/gmlYL4FFgS4/UiY22b34CcLtEHOhbUcY1MFENLc2YuT
         RxFVdIcNR9NjUNx2SWIz6ZmBD3sBna6IdH6q3GiL9gtLuwYijhX6ITBa1mRzxWxTQwhP
         it6PgU91TZsuWSKtowlD5B9hyQM88uWp3pfX57Qn5zgDdOpKVKWnmx4iJpakem6LuSIk
         gmLw==
X-Gm-Message-State: AGRZ1gLdxj2IWjRVBrFo4zxEjsPuPEOgZEAkJNm4hEfplRvWisUDG92z
        aZ0j/3cCsPS36iCWhdTp2Lo=
X-Google-Smtp-Source: AJdET5dIDdEk5S3KHeIKgACmUOGGgLkpVHGThVIjJvvUi54v0k7h5tCMAJlxZg5NVijw+ZkK/MALPA==
X-Received: by 2002:a0c:f047:: with SMTP id b7mr1037530qvl.236.1540506642441;
        Thu, 25 Oct 2018 15:30:42 -0700 (PDT)
Received: from renatolg ([186.220.20.163])
        by smtp.gmail.com with ESMTPSA id n47-v6sm8983755qtc.29.2018.10.25.15.30.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 15:30:42 -0700 (PDT)
Date:   Thu, 25 Oct 2018 19:30:37 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        alexandru.Ardelean@analog.com, stefan.popa@analog.com,
        giuliano.belinassi@usp.br
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 2/2] staging: iio: ad7780: fix offset read value
Message-ID: <ff71d89625c048601d3e3770ca3b4bcceb2068ac.1540506298.git.renatogeh@gmail.com>
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

Variable val subtracted an uninitialized value on IIO_CHAN_INFO_OFFSET.
This was fixed by assigning the correct value instead.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 drivers/staging/iio/adc/ad7780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 27972563bb6a..06700fe554a2 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -100,7 +100,7 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 		*val2 = chan->scan_type.realbits - 1;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_OFFSET:
-		*val -= (1 << (chan->scan_type.realbits - 1));
+		*val = -(1 << (chan->scan_type.realbits - 1));
 		return IIO_VAL_INT;
 	}
 
-- 
2.19.1


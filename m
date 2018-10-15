Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2F7C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B9F205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqjkdS/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B9F205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=capella.pro
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbeJPFMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:12:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37125 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeJPFMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:12:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id d14-v6so23276911qto.4;
        Mon, 15 Oct 2018 14:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hQEEb1+TIVT56xFyAAdPNqT9LH77Lbs2CjpqQTLNZBw=;
        b=XqjkdS/BVWhkCNGkJ/wSNzH1zHMzBleykq94J9Z6FgzNC90WeaJfCc+sJH9optoZBV
         +519+AmDYPDABwfjuYqai4CEv5hZA/TXnRJzQgSvCH7lAfVXU7Q6O15oYT7N1+kBWQiV
         rhsN1ZaqZ2a66KCIRxEjMjcYwkzGuZKklw/KtWROb7mUSPaOlSIxtEchsoWzkBoqfo+G
         80aky2QtEZOzVYp5ZC2PvHoC82sa9vUIirewpWXPQYkvreS39GnbT6QeXiq6qvmPMpYN
         Ez4LEm9jcJNVSlYNk0dILZvTpQg+Rql5fGgZ+VXfMxL8JQDE/X23DFu8iFSv2NB2dZWd
         Knmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=hQEEb1+TIVT56xFyAAdPNqT9LH77Lbs2CjpqQTLNZBw=;
        b=BVwtEeqHkHboBJGAqgT9x0nU/YpvxCrFqkZxNMFNMoBrKT6Rg3lu+rJ3TNljl3liCr
         W4W1kvGAmMjLAtvqGHttVNI+FfJk6dEFLciRQecrpbOJGIkUpR/CmQWsMiL94U2TD1ip
         HaZ+Zb9eqoBbnSz68EiZ9erU0WlTMCExhXjVg3Cm14wRKbw/c6ICJB7N9WnElSBTeZ6K
         ZoU6f6dW2iKI3Tu4BXZfGcupakM6QxyAbIWYjzrD7Cnbrpu9ZtswFIhvTZxEkxdv1tQ4
         U2yPAgjr4iPNBGjOU8EFDc9qSMU6FP2n3/G4+Fhm0QwHCOL28xIqwrOQEUKXqwcEi1wB
         uxVA==
X-Gm-Message-State: ABuFfohH9csmMNzAUesjZEkduyxuJtkcHPJUvm1IlEU4IJYVyYBSu8aP
        TgwTV8d+LMm95KP6MC+70kQ=
X-Google-Smtp-Source: ACcGV61jIZDTwZNVZ8wDvApj2kqMtZOXdVanEh/TbD4mYMxYImPjvNdO9DG6Cw03gop/15dkydnjYw==
X-Received: by 2002:ac8:7119:: with SMTP id z25-v6mr17917686qto.270.1539638712630;
        Mon, 15 Oct 2018 14:25:12 -0700 (PDT)
Received: from localhost ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id z3-v6sm5958638qkl.23.2018.10.15.14.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 14:25:11 -0700 (PDT)
Date:   Mon, 15 Oct 2018 18:25:21 -0300
From:   Gabriel Capella <gabriel@capella.pro>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH] staging: iio: adc: Add comments to prevent checks corrections
Message-ID: <20181015212521.GA24512@mantaray>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds 3 comments in 2 different files.
These comments warn to don't correct the checks of type:
"CHECK: spaces preferred around that '-'"

Signed-off-by: Gabriel Capella <gabriel@capella.pro>
---
 drivers/staging/iio/adc/ad7192.c  | 1 +
 drivers/staging/iio/adc/ad7280a.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index acdbc07fd259..786ace19c240 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -354,6 +354,7 @@ ad7192_show_scale_available(struct device *dev,
 	return len;
 }
 
+/* Do not put spaces around the hyphen. #checkpatch.pl */
 static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
 			     in_voltage-voltage_scale_available,
 			     0444, ad7192_show_scale_available, NULL, 0);
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 58420dcb406d..4927116a046c 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -749,6 +749,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+/* Do not put spaces around the hyphen. #checkpatch.pl */
 static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
 		in_voltage-voltage_thresh_low_value,
 		0644,
@@ -756,6 +757,7 @@ static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
 		ad7280_write_channel_config,
 		AD7280A_CELL_UNDERVOLTAGE);
 
+/* Do not put spaces around the hyphen. #checkpatch.pl */
 static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
 		in_voltage-voltage_thresh_high_value,
 		0644,
--

 

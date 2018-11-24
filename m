Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6C7C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 13:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11EE20868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 13:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ezs7W+ES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11EE20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbeKYAH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 19:07:28 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40318 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeKYAH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 19:07:28 -0500
Received: by mail-qt1-f194.google.com with SMTP id k12so12998802qtf.7;
        Sat, 24 Nov 2018 05:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Rc1fIfxcwrFMahCT+am35z1+4hc49D9CFSS8iakFJwI=;
        b=Ezs7W+ESailx/T++lcrx3U/DP1KUPfqpd2OHI7ZOjiJMmqmIKEbAi6btdtehQvq6BU
         2sWk0f4F7W4j2vKBwUKiQJJjgVHHjCE8mfC8lhYP9kkPucaz6heuRCHWBdaPJgdToL5s
         YgadYOIoRC9Oq87xL3QXoZhQr9B2+FntoIXC8jpLRJRkW6gG9gPepbQuZhpylgrAJIM/
         PbObKzEa9b3h4Zsz5XhEX1i9rIZZQ3uO3WPMEF8J4IkDQbiOX3WzHgRuXqAfs9DlTg7O
         yAIp6SBBYMzl3cnfv0w7ev2jpOwUEBrXwpWwDvTahmnMrJqMfyPQCcuISjlUS/ALNAL9
         UHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Rc1fIfxcwrFMahCT+am35z1+4hc49D9CFSS8iakFJwI=;
        b=Ci2HL0Ny18BIRFa5AvWpi3UhZEUbx2cefN3XYiY9owuSUao2q6hv9ZgP+M+e6OjXPf
         /c0TNb6kfdWhf2GjLhr+LjHPuMNs6GYvFFaxepUlCAE813OTQj9sr8uE9TQpDU77T9nV
         tyYAV89/PPQI75i+uPu+M/m2ILmDLC1AEiIIpvtFzAoDuYzo5PNEGt6/9Apr98I/lxOS
         Ub8itm5cS1AC2WdU0zAVB19v+F/6tpXOqM6Ez5tsKkRQi2o9CJNvxQu39YKEtisHvSQT
         5sMEcidHoHWHhP6EJmQ3YpTQaZIzSaB5q6o/3WeY8ftDYzx2bJJldSka5rpAVRSWEYAD
         h/uQ==
X-Gm-Message-State: AA+aEWZXBTFhL2LNLvTIS4wN00pHQioa51C3hLtRBbc9CLNSOD5mysEs
        IqbfBz6qABbMKryUCdZwCJY=
X-Google-Smtp-Source: AFSGD/X0Zp5DlmRDkqkygQiWcwHDCl6BMBXbYqbtnmNfEbBii/Qvi3CvEhW9kJF2xxgxbk2OmetHXQ==
X-Received: by 2002:a0c:a242:: with SMTP id f60mr18634973qva.17.1543065542781;
        Sat, 24 Nov 2018 05:19:02 -0800 (PST)
Received: from smtp.gmail.com (gwcrusp.semfio.usp.br. [143.107.150.86])
        by smtp.gmail.com with ESMTPSA id l13sm33965256qkh.45.2018.11.24.05.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Nov 2018 05:19:02 -0800 (PST)
Date:   Sat, 24 Nov 2018 11:18:57 -0200
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2] staging: iio: ad5933: add device tree support
Message-ID: <20181124131857.ur6rt7nnjinmj6gm@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a of_device_id struct variable and subsequent call to
MODULE_DEVICE_TABLE macro to complete device tree support.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index edb8b540bbf1..6faa2700dc8d 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -771,9 +771,18 @@ static const struct i2c_device_id ad5933_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, ad5933_id);
 
+static const struct of_device_id ad5933_of_match[] = {
+	{ .compatible = "adi,ad5933" },
+	{ .compatible = "adi,ad5934" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, ad5933_of_match);
+
 static struct i2c_driver ad5933_driver = {
 	.driver = {
 		.name = "ad5933",
+		.of_match_table = ad5933_of_match,
 	},
 	.probe = ad5933_probe,
 	.remove = ad5933_remove,
-- 
2.17.1


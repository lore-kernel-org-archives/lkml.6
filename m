Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C45C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E4320815
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="TcovvE9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbeLTHVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:21:45 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:55152 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeLTHVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 02:21:45 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id A6A37B9F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 07:21:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id crGkfmCQWf6P for <linux-kernel@vger.kernel.org>;
        Thu, 20 Dec 2018 01:21:43 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 7975BC66
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 01:21:43 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id y86so1347330ita.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 23:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=olSBnnx9NjGp0W7zHvNXGFjUnYVNv5tLVlKkHGT7CZc=;
        b=TcovvE9HAEINP+YPIMNf2zL7m3HwyZp/V0/dv4l+knhgon+g4cIiPdDyCrn1XaGysB
         bylQUIMOJ42UNJ8mifBon49OvKAZTrlUQRIacfSep+RQGmrvm8mxUFONvP9ZFEKO0UBn
         1spxLbexo5Ynjnp3qJn1Dc6DByJYs3RmvTlg2wBOvHEsSKRyBvEJaEudrR7b2crqgqz2
         7L2nHCIbNMszCKeYA7sS1Ke+pGYEC+f8yu3NsERqm6860Z2QIUVVnd6GGOoOiVlTFCDp
         yg8lcDnzUlCaflBcQSsGwvzh1z1ApRMNy424HwLSp2PkwXrr0GEtML2Ml2M0WWxdPGLr
         ZFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=olSBnnx9NjGp0W7zHvNXGFjUnYVNv5tLVlKkHGT7CZc=;
        b=uUz2Qwy618M4gnChPYviz6mUrbjxiJhpW16G4x73hmphd/6oHYu7LTrXC3K5qqx7uE
         OkUzZvVJU/7lR4MRMYcL/TWaY5EklCyorv+MoTc0BA1wMQJ8O4Kn8oaOXXWZ2eOafDcx
         6kAoJ89AnLCdViCMP+xCo3vnC+yL+S+JBWJ+Y7ybaQXYe/yUDS3Q+qClXjzAgS1YJdut
         OCKmRh41ap1UJ1ZOaoG/zRnXkTu6nBIFX1c3f5ggqdGtca/HX86STFjsvV6MrCDRdjdi
         9HDY1PBAEJyhVzC0CxM9SCF8bnZSrTzxPHFQh37FukVUwcvXYKfcv32sEip7xE/CL2Fa
         vNVA==
X-Gm-Message-State: AA+aEWZnjlGuUKRDXM1YBySYd9+Ylp1+bgRLHiRLUCgP0YVex/xQXAmx
        ljGKicggSq5KgRcWlD/jH8kLPyfNunHBdWbTG5fDYGZxjThNBGUitY2mQDm/c193cgIEta1JbUG
        VNlY8IP02QO5ahA7sDHrBmyHxHwDv
X-Received: by 2002:a02:734b:: with SMTP id a11mr20952744jae.62.1545290503066;
        Wed, 19 Dec 2018 23:21:43 -0800 (PST)
X-Google-Smtp-Source: AFSGD/UjZrri35WC+p0WOBT0eQNleqn0zgKrcRH89zSyKiosxaSuDUy3hydJGX8Tuy3q3PemCCHTDw==
X-Received: by 2002:a02:734b:: with SMTP id a11mr20952731jae.62.1545290502816;
        Wed, 19 Dec 2018 23:21:42 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-24.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.24])
        by smtp.gmail.com with ESMTPSA id n129sm5393195itb.20.2018.12.19.23.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Dec 2018 23:21:41 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: ad9523: fix a missing check of return value
Date:   Thu, 20 Dec 2018 01:21:22 -0600
Message-Id: <20181220072122.40469-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ad9523_write() fails, indio_dev may get incorrect data. The fix
inserts a check for the return value of ad9523_write(), and it fails,
returns an error.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/iio/frequency/ad9523.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index f3f94fbdd20a..3f9be69499ec 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -943,11 +943,14 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 		}
 	}
 
-	for_each_clear_bit(i, &active_mask, AD9523_NUM_CHAN)
-		ad9523_write(indio_dev,
+	for_each_clear_bit(i, &active_mask, AD9523_NUM_CHAN) {
+		ret = ad9523_write(indio_dev,
 			     AD9523_CHANNEL_CLOCK_DIST(i),
 			     AD9523_CLK_DIST_DRIVER_MODE(TRISTATE) |
 			     AD9523_CLK_DIST_PWR_DOWN_EN);
+		if (ret < 0)
+			return ret;
+	}
 
 	ret = ad9523_write(indio_dev, AD9523_POWER_DOWN_CTRL, 0);
 	if (ret < 0)
-- 
2.17.2 (Apple Git-113)


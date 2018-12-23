Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C1FC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2852218D3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFs+FMUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbeLWE6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 23:58:34 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34724 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbeLWE62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 23:58:28 -0500
Received: by mail-io1-f67.google.com with SMTP id l22so38445ioh.1;
        Sat, 22 Dec 2018 20:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8yZFL/zwD25f09AodsHo5P6etccInIazFV7uoFevqFM=;
        b=mFs+FMUqu3q9ekZtjSITBt0goNkoTX8vuMp1uOHkd0Q6AIHs0UeMBB+NLdSQXOtWyc
         kn9okEWP+2ksHpqyj4cVm9kfIVmIJioHZ9EVMLGS0uSO3WjXFw43tkwUASLe32OHpNxV
         Dhj3Q1FySbdbcPCllvrfFdLEUfmm866Fp2pmuuXqhMlgRqrz3dKCWAyGKF0ig/kPpwDY
         y0XP1UqxzJgij4b+Bnmckjj28yiWYXiYEPU9Zl7WAWVIXqa/fp8sXwjLcmxusEMLk0wo
         +1ruNSbdCzR56CEJGMrKbaJiNNH7u92W9XOyZOnawrv8OLsqKnHGaGWK2sjuwQQWy/SP
         8iOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8yZFL/zwD25f09AodsHo5P6etccInIazFV7uoFevqFM=;
        b=LLdoZ2OL1m8fRTAITYTyh02EWMIZtODxW7PQvdy9VtvsHY6GpOtw7RDcHRlRmjQP6E
         ubo1fMKPc44B3lD96PITUZNT4Bpq/WZL96UV1YSQpbl8LMvBQwQsgxZhiWmItzluuOE2
         JrK2cal9emHERdWwSVwB9G/42mrSOiSPbLEsR75bPY1tvFuxgzAv+maZorr5SvBbKu8a
         UYT+fNEqUkDp5ITWayk1g9hCjeLa4eOW0lCSOgLUNm0ve2wyjJIjlFKzRV+8OaXhr9oL
         u0EE89K9k3g+yks1fgI3OtkSoqVE7jZCVOJQdUxfJK6GxLF5H3EJnrhD50G23jODEb0n
         VGZg==
X-Gm-Message-State: AJcUukdC5w9bqDNxQpYETg39sajLufTvmJ1Zm57L6uWvgmdbMWOfBIhA
        y31rUbE+lZhKH8KZGDRr4So=
X-Google-Smtp-Source: ALg8bN6pundBV1jxOaEmM9wHtK7VuCT4zTimcFX5rEF0sVnMVdEb0Zl0z1/RUYrMcPk1S7fIG3T9BQ==
X-Received: by 2002:a6b:e919:: with SMTP id u25mr6013502iof.132.1545541108043;
        Sat, 22 Dec 2018 20:58:28 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id 15sm8435378itv.11.2018.12.22.20.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 20:58:27 -0800 (PST)
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Jeremy Fertic <jeremyfertic@gmail.com>
Subject: [PATCH v2 2/4] staging: iio: adt7316: fix handling of dac high resolution option
Date:   Sat, 22 Dec 2018 21:57:41 -0700
Message-Id: <20181223045743.10716-3-jeremyfertic@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181223045743.10716-1-jeremyfertic@gmail.com>
References: <20181223045743.10716-1-jeremyfertic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adt7316/7 and adt7516/7 have the option to output voltage proportional
to temperature on dac a and/or dac b. The default dac resolution in this
mode is 8 bits with the dac high resolution option enabling 10 bits. None
of these settings affect dacs c and d. Remove the "1 (12 bits)" output from
the show function since that is not an option for this mode. Return
"1 (10 bits)" if the device is one of the above mentioned chips and the dac
high resolution mode is enabled.

In the store function, the driver currently allows the user to write to the
ADT7316_DA_HIGH_RESOLUTION bit regardless of the device in use. Add a check
to return an error in the case of an adt7318 or adt7519. Remove the else
statement that clears the ADT7316_DA_HIGH_RESOLUTION bit. Instead, clear it
before conditionally enabling it, depending on user input. This matches the
typical pattern in the driver when an attribute is a boolean.

Fixes: 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9 driver")
Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index e17c1cb12c94..80cc3420036b 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -633,9 +633,7 @@ static ssize_t adt7316_show_da_high_resolution(struct device *dev,
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	if (chip->config3 & ADT7316_DA_HIGH_RESOLUTION) {
-		if (chip->id == ID_ADT7316 || chip->id == ID_ADT7516)
-			return sprintf(buf, "1 (12 bits)\n");
-		if (chip->id == ID_ADT7317 || chip->id == ID_ADT7517)
+		if (chip->id != ID_ADT7318 && chip->id != ID_ADT7519)
 			return sprintf(buf, "1 (10 bits)\n");
 	}
 
@@ -652,10 +650,12 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
 	u8 config3;
 	int ret;
 
+	if (chip->id == ID_ADT7318 || chip->id == ID_ADT7519)
+		return -EPERM;
+
+	config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
 	if (buf[0] == '1')
-		config3 = chip->config3 | ADT7316_DA_HIGH_RESOLUTION;
-	else
-		config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
+		config3 |= ADT7316_DA_HIGH_RESOLUTION;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
 	if (ret)
-- 
2.19.1


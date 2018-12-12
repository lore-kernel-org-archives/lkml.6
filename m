Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16DCC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D9020811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayHUN/rm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D9020811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeLLA43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:56:29 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51248 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeLLAzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:55:48 -0500
Received: by mail-it1-f194.google.com with SMTP id x19so6590893itl.1;
        Tue, 11 Dec 2018 16:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R9m4u/5qRzRhLWACB0cQ5SHyFZ5Alna3mIM8KLpqRaI=;
        b=ayHUN/rmzuj91miDhLWFP2JBJGfpKbx165FbXSx6ISN8AMG6AZWWMzxV5xEvvIql+H
         LSC/YPjPrUuzI12XKh00ZAOvN2fvnYhT1CR3dJqWQCsjcSEoR/8A6QMi+/cYyYJzJmNx
         SB6upjXwcLQxzaLl2rWIuVq52pg5gfotT9yFJoziQdzIqvZHaKKQlfKCpcOsLsl86urS
         Yoj0ExdRyXcuJokv0JT7isWXmPfClRC/WD8ofz71Gll6W3cE8g4hFcnSIPsN54Ci4nKK
         OXW3a88aOVfllJmfPE6NnfOGW+HcOEBtwoesekOLtK1lfMPJrkP0RUGvbdZPHgOUt4B7
         olsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R9m4u/5qRzRhLWACB0cQ5SHyFZ5Alna3mIM8KLpqRaI=;
        b=EY4P9KUUk++K5T9fABQb1FS0mfV8EXd3E/2PRHXuBEwDjbaItEagAkk20JixCv883s
         12NRtVqZWWoxxWA7mYdvWgB8pw4fIOXPRJ+CsXgAwSLb+9Wnl6cs5Ktfgl62m0EyKNwY
         hLhLNMiRkEqkTy9Y1xJTqY9l2xXmqcLAaxiIok+nJ/dOce7ZGkhK/55oPRrtys+2cENg
         mm2I/YlF4SpJeSwLlaQhMR0rQ/5wZ0KYruW+jhm5lZ4dlIQjUTUY8vTzK39K3YdVpfL2
         QQV62c3hu9IvJgozxYkYJM0XbO2HJYvCckV4naDXptBG0ptoMZItpA3hLZRoQpE+71Ya
         sneA==
X-Gm-Message-State: AA+aEWbT4lMIgWHQhRdRQZ3u91cMZgSidn/aVHgylh+2FmDtKKSpio/5
        Z46MABLChOJfa9jc2jbGTdk=
X-Google-Smtp-Source: AFSGD/VcQRj3/cdGYpYQvSYIt9y3IIBSkosId3WSXwPeN7Jt0dngo4LfLpSSPjP0aqQ/oQwrlg7J7g==
X-Received: by 2002:a24:3046:: with SMTP id q67mr4458295itq.42.1544576147179;
        Tue, 11 Dec 2018 16:55:47 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id l186sm1952445itl.22.2018.12.11.16.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 16:55:46 -0800 (PST)
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
Subject: [PATCH 04/11] staging: iio: adt7316: fix handling of dac high resolution option
Date:   Tue, 11 Dec 2018 17:54:56 -0700
Message-Id: <20181212005503.28054-5-jeremyfertic@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212005503.28054-1-jeremyfertic@gmail.com>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dac high resolution option enables or disables 10 bit dac resolution
for the adt7316/7 and adt7516/7 when they're set to output voltage
proportional to temperature. Remove the "1 (12 bits)" output from the show
function since that is not an option for this mode. Return "1 (10 bits)"
if the device is one of the above mentioned chips and the dac high
resolution mode is enabled. In the store function, return an error if the
device does not support this mode.

Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index a9990e7f2a4d..eee7c04f93f4 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -632,9 +632,7 @@ static ssize_t adt7316_show_da_high_resolution(struct device *dev,
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	if (chip->config3 & ADT7316_DA_HIGH_RESOLUTION) {
-		if (chip->id == ID_ADT7316 || chip->id == ID_ADT7516)
-			return sprintf(buf, "1 (12 bits)\n");
-		if (chip->id == ID_ADT7317 || chip->id == ID_ADT7517)
+		if (chip->id != ID_ADT7318 && chip->id != ID_ADT7519)
 			return sprintf(buf, "1 (10 bits)\n");
 	}
 
@@ -651,10 +649,12 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
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


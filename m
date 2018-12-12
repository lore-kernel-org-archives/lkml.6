Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8123C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9487820811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONp0a3Ws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9487820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeLLA40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:56:26 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52910 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeLLAzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:55:50 -0500
Received: by mail-it1-f194.google.com with SMTP id g76so6587968itg.2;
        Tue, 11 Dec 2018 16:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8x3EfAi+dwJT7LG9r3AqAVh9KBm9FxEhlGxf1nFjco4=;
        b=ONp0a3WsAdCvn6qEPX78E5QC9Mz6d6oRqo1iXX2JUGBV985+YrC2aEi0zru+q7VFfK
         6csxPZpiGZhsFx4/ttWg8jxX8prv2ZmZtOYSulIvoDhSAHs2OwBK4J87Jho8O1K43AAX
         60hYcWdRVgTjsEmP2KwN/Qz6QCfK2LaYMDZyyFjmmkjupBeKC0RyyzNCkUPXOw+Pk2PV
         /HsXdOdgZgnijJgsVkq+aFnnoGtwmEUdaYnJu9VoUw51j5JhX05u0bKdBJW8V5pGLgDH
         A+CQiHENTWdqQ1QUtkoOHWQw+FEdEj3oOXkMZo1yD8gcVMTgWcBB2XLFJc/V6zVgaiYg
         /Q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8x3EfAi+dwJT7LG9r3AqAVh9KBm9FxEhlGxf1nFjco4=;
        b=d6paOC2xvJ+iXWrVObNlnHWeYIVqADW6oEZEJu6vGjktQt9zXuLQkqDMM52ZGzflyM
         O+4RQuf00TXmKxVr/bv2ftqxsKDwnnGr2oxlvrDH1ZpNeuj3sgu7jbTTeLtXe13yl+vC
         nGPQi1Uvku+ORoGXtJBqzdqWu6gxjhBvbTPoN2cf+M/fogewPKswI3dc2SeYkY3A5Kou
         4WTkjJhfCR6ykTy7HXy4xjHti4zxwXxq9tp8vlGXypqCtHgMPQGbuihGzAieVf0zcNLO
         9bUWV7P8MW80rpn/6Hhmv3f8kqQNpJEoJ7GsGvbs7/as5JQnetP2hx3Reh764oXCfjzL
         eDjQ==
X-Gm-Message-State: AA+aEWaoDInGH14gWcC2S0I5XgzfjXm0E5Fz4iUmVoape9A0julPzxHK
        3Ix9gc5KlsC+l2YdQB0cj5w=
X-Google-Smtp-Source: AFSGD/U40Oc5azHSTu6+wK0HUW3z50CL3HQhebMK6cXLmPgfP06ZvdgJZnW2t/ruxxoSoludBIfWEw==
X-Received: by 2002:a24:1c04:: with SMTP id c4mr4403205itc.79.1544576149095;
        Tue, 11 Dec 2018 16:55:49 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id l186sm1952445itl.22.2018.12.11.16.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 16:55:48 -0800 (PST)
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
Subject: [PATCH 06/11] staging: iio: adt7316: fix the dac write calculation
Date:   Tue, 11 Dec 2018 17:54:58 -0700
Message-Id: <20181212005503.28054-7-jeremyfertic@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212005503.28054-1-jeremyfertic@gmail.com>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lsb calculation is not masking the correct bits from the user input.
Subtract 1 from (1 << offset) to correctly set up the mask to be applied
to user input.

The lsb register stores its value starting at the bit 7 position.
adt7316_store_DAC() currently assumes the value is at the other end of the
register. Shift the lsb value before storing it in a new variable lsb_reg,
and write this variable to the lsb register.

Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index b7d12d003ddc..77ef3c209b67 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -1442,7 +1442,7 @@ static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
 static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
 				 int channel, const char *buf, size_t len)
 {
-	u8 msb, lsb, offset;
+	u8 msb, lsb, lsb_reg, offset;
 	u16 data;
 	int ret;
 
@@ -1460,9 +1460,13 @@ static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
 		return -EINVAL;
 
 	if (chip->dac_bits > 8) {
-		lsb = data & (1 << offset);
+		lsb = data & ((1 << offset) - 1);
+		if (chip->dac_bits == 12)
+			lsb_reg = lsb << ADT7316_DA_12_BIT_LSB_SHIFT;
+		else
+			lsb_reg = lsb << ADT7316_DA_10_BIT_LSB_SHIFT;
 		ret = chip->bus.write(chip->bus.client,
-			ADT7316_DA_DATA_BASE + channel * 2, lsb);
+			ADT7316_DA_DATA_BASE + channel * 2, lsb_reg);
 		if (ret)
 			return -EIO;
 	}
-- 
2.19.1


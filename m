Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADECAC6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB0120855
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTgUhfA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB0120855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeLLAz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:55:56 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34181 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbeLLAzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:55:51 -0500
Received: by mail-io1-f68.google.com with SMTP id r9so13509003ioa.1;
        Tue, 11 Dec 2018 16:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L/atx7BGCxztBzsTRzroAA6bFNlexZMNZDiBGowfY84=;
        b=YTgUhfA3XhydP/im3xH6xglj1N2s9OHvGOGTkriBOvGGU150UMBz5iqAjyQ0daUPIu
         kEUan9F49Owy953ty7gDVs6CY4sx7XrN3LXoG4g/P2Wqd3FWEYhe2Z2SPXpFqR+4aK+K
         t+gP598UpePVn1DDRNNM7+BeV0iKY6BTTguGCr12/StVEcZspDRkMo7/vXKA9t+aplAk
         A7ZRUBQSrBJXgoOS8Y4MI262kqKQAgy5GnwVU2C3CTLBQD0us/MLMReUwLUE5hYDffFf
         RinoZaOtG60QcgOqwY8kU/m8xEQEQHqBvliORX0cfI5nPW9o5ot41afUYEfzPno6XQ04
         55XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/atx7BGCxztBzsTRzroAA6bFNlexZMNZDiBGowfY84=;
        b=an3bFm5/1RBzhVkMjbjDq4CuPpvXmSvdRXQnk91bUgotcu1cD5rswLxDp1/v/ZV8KL
         UaEGRfipHXVV4p97p5qxSmNBdVOtMFTQI++h++tLQzxBRcwhJFNwObUKzodFt0sMyJHY
         uh7o/omu0oxdpF3pDuzmeOrxmFJV0sdEtbEb90/f+Ttusc87LY1IGm7VWhQpKxSAnOcL
         TOhvU/OPfrM0WovrFW43aUpHCe+aZWchiZJppquyZa1csuuDvr/POeo0uWLXHtWqOcxR
         /+pWu30h2mIHyUrfiSlc9B+ithLwDb6EhQ8MvrfVKH/GOpLA0sAEGJKqTKjZyedw6DNW
         RYiw==
X-Gm-Message-State: AA+aEWbVJiIGGk2/yhT1YccLjeMBw2qxuMU/kpj5S3wgKkbg3iYDCgIG
        Mr9IU4eCqgvVeIER8m++4Pw=
X-Google-Smtp-Source: AFSGD/Ws5mxQcEZcvO9LhJ5V3G9Wl/Uzf4T/qPMB2FqbhVfV9YU9cXn9Tff/hWyg2hQa7CNhI90HtQ==
X-Received: by 2002:a5d:9b9a:: with SMTP id r26mr15497659iom.232.1544576149999;
        Tue, 11 Dec 2018 16:55:49 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id l186sm1952445itl.22.2018.12.11.16.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 16:55:49 -0800 (PST)
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
Subject: [PATCH 07/11] staging: iio: adt7316: use correct variable in DAC_internal_Vref read
Date:   Tue, 11 Dec 2018 17:54:59 -0700
Message-Id: <20181212005503.28054-8-jeremyfertic@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212005503.28054-1-jeremyfertic@gmail.com>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dac internal vref settings are part of the ldac config register rather
than the dac config register. Change the variable being used so the read
returns the correct result.

Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 77ef3c209b67..98101a7157d2 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -1056,10 +1056,10 @@ static ssize_t adt7316_show_DAC_internal_Vref(struct device *dev,
 
 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
 		return sprintf(buf, "0x%x\n",
-			(chip->dac_config & ADT7516_DAC_IN_VREF_MASK) >>
+			(chip->ldac_config & ADT7516_DAC_IN_VREF_MASK) >>
 			ADT7516_DAC_IN_VREF_OFFSET);
 	return sprintf(buf, "%d\n",
-		       !!(chip->dac_config & ADT7316_DAC_IN_VREF));
+		       !!(chip->ldac_config & ADT7316_DAC_IN_VREF));
 }
 
 static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
-- 
2.19.1


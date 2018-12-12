Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE73C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7134220811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwZFee98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7134220811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbeLLAz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:55:57 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:32833 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeLLAzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:55:51 -0500
Received: by mail-it1-f194.google.com with SMTP id m8so12288724itk.0;
        Tue, 11 Dec 2018 16:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zwgJV9Fuz7Xdf+vTXkcn64lPHT6DvBIVIzf4MQogFUA=;
        b=WwZFee984BbBT6+Sd4HICnfMvb+SOQg3oIRS7Js5rQAOGp5Hb3ZSMfI3rSIwv3//tf
         TeH3NZxZFm6hIBQfA23W148OvOH+wx5W2HgzjX4Vkpv60ZXZvAj3bB4ZqpwPSoVUVfQH
         A6b0QLuZeYBVRvjBv8l+tDoll5neYhvTAtFtTRTuuGEWocai0sjW6bvGMOtxroKbtohZ
         UWN2vjrVrew9nP3XCNUHib0cFStqbSaRtjwjb93S7r+vUeZfKTfWEvKcE/F3LTN4o2t8
         ny2PZRds0Rejej8CSLt1XafygrK88SwbGi+VBQWvzI5Rx+Lf4/aXUNCMYyyelWk/a6XE
         HfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zwgJV9Fuz7Xdf+vTXkcn64lPHT6DvBIVIzf4MQogFUA=;
        b=VKavA1rQeiPcT14QlRgYnAQZmXyEy+W9UEUmyQzyXy+3N3mlz2PZWFRnXEAlndZa5F
         11fOJ5Tw2NQjYpQXF7Gfi9E1ZT/sdENbUReKr6ygrA/P8CpMBiAzFQb++dZzgDPceQ2S
         LtJfFPnDkuZLWTZRF0N7pI2ExZxBLMFOA9vgEwj1ci4aCUuKbbm/vUW3t/RlCYv+vAhm
         mWHf8qEmKr5ma8N8AoW3uy8PDmHHOwkI8N7nLy0rN/UbT4BuM3oMi5oJuFiQW7AigtlH
         u08gNy6CT7DlxtKBSO9z3gqy4Si4dfz6y6Ll5DpjHt8rhzSL3zAVLLvTFMeQxGhZ7myn
         ueQA==
X-Gm-Message-State: AA+aEWYn5DYM106gxxQ5T7LJIvfZYY71sNHAqCFyDOSi2Z4qzq/dcmZf
        EG0PEg3DhNLmBYwfA+bJj9M=
X-Google-Smtp-Source: AFSGD/Wx6SqdWGLHShKm1B4ZcKSIDpFDBw3fNmmK+DQl5mEHJ3y1Yolug9rZaWaUiNLYeDUBjN+wHA==
X-Received: by 2002:a24:19d5:: with SMTP id b204mr4218585itb.6.1544576150954;
        Tue, 11 Dec 2018 16:55:50 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id l186sm1952445itl.22.2018.12.11.16.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 16:55:50 -0800 (PST)
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
Subject: [PATCH 08/11] staging: iio: adt7316: allow adt751x to use internal vref for all dacs
Date:   Tue, 11 Dec 2018 17:55:00 -0700
Message-Id: <20181212005503.28054-9-jeremyfertic@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212005503.28054-1-jeremyfertic@gmail.com>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With adt7516/7/9, internal vref is available for dacs a and b, dacs c and
d, or all dacs. The driver doesn't currently support internal vref for all
dacs. Change the else if to an if so both bits are checked rather than
just one or the other.

Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 98101a7157d2..3348fdf08f2e 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -1081,7 +1081,7 @@ static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
 		ldac_config = chip->ldac_config & (~ADT7516_DAC_IN_VREF_MASK);
 		if (data & 0x1)
 			ldac_config |= ADT7516_DAC_AB_IN_VREF;
-		else if (data & 0x2)
+		if (data & 0x2)
 			ldac_config |= ADT7516_DAC_CD_IN_VREF;
 	} else {
 		ret = kstrtou8(buf, 16, &data);
-- 
2.19.1


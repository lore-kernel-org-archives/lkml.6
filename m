Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF75FECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6E3206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3HBnFi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6E3206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732880AbeITTZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:25:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34646 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732496AbeITTZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:25:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so4411031pfi.1;
        Thu, 20 Sep 2018 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o6m+8LaU0HanMrlulsKdznSgYYutZpKM4WVXP+Nd1nY=;
        b=i3HBnFi0zN/3e370Nh8Ft1bVHz975m7JDe8dv2AJanYLnHz6Yr4rF6uBaI7KBLa6we
         fmMqbFxaIn0vIonhmbViybNENUFqeWbUHAcuTzt+G3G74Mlw90dLdDBXp6C17/sEK9Tc
         5cQ+uMjH0xC81VLozEzQOKTrfkiyoAa7BC4dUdBJS5DT3XZLjEE3npQSZxyV7rBcMnlt
         NI3/+mWCvF0n+hLDxkPsagG57hWRs1FckD2qkC9YkFuWCdJYTFJTffJWv33x02CUDN4e
         QVaEHodj4QiAwWwqzSJmSF+bbsRis5vNQxQ8IuBz8QN8bMPu2pTDY6f+dPLzDxMNt6vg
         rcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o6m+8LaU0HanMrlulsKdznSgYYutZpKM4WVXP+Nd1nY=;
        b=J8c8bnJC4fPo+xJXjfNbhubvSFrNemnMyMfcdGV8DkBfjLBgJV6nY2VDElikSleTXZ
         WMgY82QKfOs4jIqLHL76ywKFwKuzRBS2x1UuaYk84uuM6uU9f5LhLSFXSxlrDOJUq8y6
         +RwlHsYmxkvjguOmCf55IbVZPmm0y07P/W3srXiPE4v5NGTB6MNV9BxX0XKF08vhANOp
         O6o4yCv2kDV2YU+njR8SQ2HMVtYOcQLIII7eHB0lCdSI7Unq6a9HXwfRN+p4tL8cJ7zR
         6sKH7qrRdAp5JD7+Q7zZ+edVsbl68Nax8G12PXjyBI7HHVc8/4ycXRm6ViQh5qYWfYsk
         0AoA==
X-Gm-Message-State: APzg51D3GqaUdvCBsb5A1ISZaojb5NhaC7KeLatQbUpLFpoPPq6qqgU6
        JG3TyPR2sJL5MYERjL259RQ=
X-Google-Smtp-Source: ANB0VdYNiBQPtUPIu19Y7Bhd97e4BsH9EUAafAJJ64HrKR136BhZMMseZv4GhR0BtBU9QnHwbQlHQg==
X-Received: by 2002:a62:6b41:: with SMTP id g62-v6mr6149017pfc.113.1537450944991;
        Thu, 20 Sep 2018 06:42:24 -0700 (PDT)
Received: from localhost (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id 8-v6sm28238994pgu.10.2018.09.20.06.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 06:42:24 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, shubhrajyoti@ti.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH] iio: magnetometer: hmc5843: Replace a return value.
Date:   Thu, 20 Sep 2018 21:42:19 +0800
Message-Id: <20180920134219.8402-1-songqiang1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This error apparently is caused by timed out event, so a -ETIMEDOUT
should be used instead of a -EIO, and it also tells user what happened
, so this dev_err may not be needed anymore.

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
---
I used ./scripts/get_maintainer.pl to get maintainers about this file,
I thought this script searches maintainers with looking up MAINTAINER,
is that right?
So I searched MAINTAINER and also found nothing related to hmc5843.
In the declearation area I can see Shubhrajyoti Datta 
<shubhrajyoti@ti.com> wroted this driver and several other people
including Peter Meerwald have contributed. Is this driver now a orphan?
Or if it is, I think we may also need to add it to the MAINTAINER file.
I'm also familiar with this device, I think I can add interrupt support
later.

 drivers/iio/magnetometer/hmc5843_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
index ada142fb7aa3..4fb393c3854c 100644
--- a/drivers/iio/magnetometer/hmc5843_core.c
+++ b/drivers/iio/magnetometer/hmc5843_core.c
@@ -170,8 +170,7 @@ static int hmc5843_wait_measurement(struct hmc5843_data *data)
 	}
 
 	if (tries < 0) {
-		dev_err(data->dev, "data not ready\n");
-		return -EIO;
+		return -ETIMEDOUT;
 	}
 
 	return 0;
-- 
2.17.1


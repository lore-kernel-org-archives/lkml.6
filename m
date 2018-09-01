Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CD1C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16B12083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VP5xzAL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16B12083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeIANfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 09:35:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33436 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeIANfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 09:35:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3-v6so5282397pgv.0;
        Sat, 01 Sep 2018 02:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BoKmfDqINy2r744zO3/HpfUNHD/UCUy3WiMQi3DYEuk=;
        b=VP5xzAL6p0Ooe4WsLWr25Y1tO2QrrHZvoYSZ0P9pWpCnnpa6O0m03Opj3mNLGLffFd
         w7DScrPVKgEBQatRWzgGFN83wjr3Mq6r2/fQyo9xgnXp3m/JyT/+abjjkgTrAkZEVu6y
         bCyYbOZFrS/sNnvgnaGklw8JbH3bCCsb/vuZf+uvwwWo0IEF2JVYA7Fm62v3VnWAD+6b
         MOq/bPcfPFUqX+Oysn4dF8/Xqst2iCxPMJWLcow0avcK8u1ecM5Icu21jhzsc6xjd1MY
         aOghWPse5iFI87Z0oDqwWtM8YIiR1EPR+4pWKf6WNjyhJe26DjHMl4JiQZY/xmUDS7oL
         uXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BoKmfDqINy2r744zO3/HpfUNHD/UCUy3WiMQi3DYEuk=;
        b=hygfOzkBhTTBQQsU5lxDEsbFFh/br8rlUm+XKdkKYbVouJRd+2rY9Ioy+muzQ+MlqU
         KrgQB7mp8z/VcVPQmio+VOPHiWbRue5HezbP7ZpX1yfzskgb2DSukBNnIXS5GBJA2VA4
         pSZhRIIQVdWUna7p0PntuJYlOE61UEPySw6doG67eFiWVI3Jw3neWm+vGG86W0ce17d5
         SU7bxXuKQyOJLjbnWIUmDJ0ZmJRu1GnjuSEM5SosYr2cWR5Vc7vMhpo0LrrtCK6w6Nk/
         soT3P0y1BdlQnQusWTGFeTMmEqRa2hYKwW245ZinX/aqCH0xYpuFtggrmHXScHeGr8LF
         vUfw==
X-Gm-Message-State: APzg51C4+Ml5PRncjIwNFH9gTaW3m4QbAY8mF4VZDTclF5vB0lMy3kBE
        p42mO2ewN3pICm+mGJFy6nM=
X-Google-Smtp-Source: ANB0VdYq/Vc7ZYgwFGuDFItv6kOrLcY0qq5Ny0et5UW07BEM82jVNe6x4UW6uQcccR4KJqWi1in/6g==
X-Received: by 2002:a63:cf52:: with SMTP id b18-v6mr4877558pgj.194.1535793834070;
        Sat, 01 Sep 2018 02:23:54 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:2913:cd09:aee0:380])
        by smtp.gmail.com with ESMTPSA id u184-v6sm18137207pgd.46.2018.09.01.02.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 02:23:53 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org,
        felipe.balbi@linux.intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] usb: host: u132-hcd: Fix a sleep-in-atomic-context bug in u132_get_frame()
Date:   Sat,  1 Sep 2018 17:23:47 +0800
Message-Id: <20180901092347.13146-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i_usX2Y_subs_startup in usbusx2yaudio.c is a completion handler function
for the USB driver. So it should not sleep, but it is can sleep 
according to the function call paths (from bottom to top) in Linux-4.16.

[FUNC] msleep
drivers/usb/host/u132-hcd.c, 2558: 
	msleep in u132_get_frame
drivers/usb/core/hcd.c, 2231: 
	[FUNC_PTR]u132_get_frame in usb_hcd_get_frame_number
drivers/usb/core/usb.c, 822: 
	usb_hcd_get_frame_number in usb_get_current_frame_number
sound/usb/usx2y/usbusx2yaudio.c, 303: 
	usb_get_current_frame_number in i_usX2Y_urb_complete
sound/usb/usx2y/usbusx2yaudio.c, 366: 
	i_usX2Y_urb_complete in i_usX2Y_subs_startup

Note that [FUNC_PTR] means a function pointer call is used.

To fix this bug, msleep() is replaced with mdelay().

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/usb/host/u132-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index 032b8652910a..02f8e08b3ee8 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -2555,7 +2555,7 @@ static int u132_get_frame(struct usb_hcd *hcd)
 	} else {
 		int frame = 0;
 		dev_err(&u132->platform_dev->dev, "TODO: u132_get_frame\n");
-		msleep(100);
+		mdelay(100);
 		return frame;
 	}
 }
-- 
2.17.0


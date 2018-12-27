Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73414C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C692148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="f3nDmzm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbeL0TgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 14:36:07 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:38854 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeL0TgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 14:36:06 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id EC539CA0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 19:36:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PGDVE_ZcM5wq for <linux-kernel@vger.kernel.org>;
        Thu, 27 Dec 2018 13:36:04 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id BC68BC69
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 13:36:04 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id r65so22888854iod.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 11:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cVp4KSGJKvQbD8C4aFuzdI9yLgayti4sI1PI6yz59zc=;
        b=f3nDmzm5jdpuk1O+LB0xoxhJCVyd5Zp4gRxjefXcplGVBnld8AEHR2rCHj3eWJJcv5
         9Bvn9tuq64zhXGg1h0mfKZoNKNQNx3V8qZAXikQHPbe41U7e66Y+hGCoSq6OVdqkNuV+
         kWul68SDnIZdRmWci/BFb5CBQt8ajVtiToyDE6RktRDK2FunZLVbf80m0yzClwfsMMwX
         WUorO3JQ3um2/jYwPOTzJiK3lVJczHoWgvUZZceig9j+sYklDZ0Av12L3t5iYg0nhdqR
         z7DDBPE+OA8WWM0pDIy6izIl4acsB9NyA/cAQixeQtw8vD6Shx5Ncje0+DSGjnyYi+Qm
         mDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cVp4KSGJKvQbD8C4aFuzdI9yLgayti4sI1PI6yz59zc=;
        b=E/8Yt7dP7sipC4Aevsy2x4BDroqMW7XkuKro7xHTyHXvExhBTai3CVRdJM68CEdUEl
         IRuclmsSAOn/izesgWXwrE+/QHoQ8/rkwLTgBgS5Dr2zKTZp9i586xqwM7znG9ikFlEX
         2WSdEKFVgWjc8Qp37lZVeV+AQsb6gbh97vkeQAZyNkANlg+MQFMllPIEWnkr1qYaHc5C
         E1/cVhv+Mn9RxSWJCiNP95qEiTn6XW8WyykNroAaeCSaGfvjP/Y/o3qZMLJ/9jBTnG1e
         J4vII6EkQLtnTij4k8bsode4+E4wbZc6cF2Ru0BPs6rK6ndWIpfjG64iFL0UgZnoP4ka
         fT3w==
X-Gm-Message-State: AJcUukdwhf2ASg9VaJN/KQNBCAUooCg8wmP3hTTml0DSG8MBmouxHzxu
        SSqgfYjJXain7zgmqpiARUWRonb03OCsOcmKEwiMuKAyv274BLwmrscQNkzsneFQh71TJjh7Tgz
        dBYBWFglv90y0MlUrvvmd1eEwcaND
X-Received: by 2002:a24:2c50:: with SMTP id i77mr14174292iti.131.1545939364254;
        Thu, 27 Dec 2018 11:36:04 -0800 (PST)
X-Google-Smtp-Source: AFSGD/XRlKbwbZvJo+cMCUP95bJ2AQn5iG2fQWn7D7KyYoOQuYt99zZV28svW3E5MLQ0PIUDHlO8kQ==
X-Received: by 2002:a24:2c50:: with SMTP id i77mr14174285iti.131.1545939364020;
        Thu, 27 Dec 2018 11:36:04 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id q19sm2801731ios.40.2018.12.27.11.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 11:36:03 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Aymen Qader <qader.aymen@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: Add a check for ms_read_extra_data
Date:   Thu, 27 Dec 2018 13:35:53 -0600
Message-Id: <20181227193554.25448-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ms_copy_page, the function ms_read_extra_data may fail for many
reasons. The fix adds a check similar to other invocation to return
error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/staging/rts5208/ms.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
index 04b588b8b376..8eb6221e4cc8 100644
--- a/drivers/staging/rts5208/ms.c
+++ b/drivers/staging/rts5208/ms.c
@@ -1676,7 +1676,10 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 			return STATUS_FAIL;
 		}
 
-		ms_read_extra_data(chip, old_blk, i, extra, MS_EXTRA_SIZE);
+		retval = ms_read_extra_data(chip, old_blk, i, extra,
+					    MS_EXTRA_SIZE);
+		if (retval != STATUS_SUCCESS)
+			return STATUS_FAIL;
 
 		retval = ms_set_rw_reg_addr(chip, OverwriteFlag,
 					    MS_EXTRA_SIZE, SystemParm, 6);
-- 
2.17.1


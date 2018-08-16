Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF09EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9B921470
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTPzzTm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9B921470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeHPWuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:50:22 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39294 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeHPWuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:50:22 -0400
Received: by mail-pl0-f68.google.com with SMTP id w14-v6so2578419plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 12:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9WHEIoacHTL8R2ueEHoY7tI2Gp315Un39SMe4h5qGjg=;
        b=bTPzzTm6jLkITDzCs9d2Y61RdFW5bZ+2U3S6mFWRudvFlV5EuWHaQh8BB0sPlebwxN
         DSb5WE2bRWGjY/FfotdixxPOQ+s+QLKyYAPEGU3koDqDcO+8CHY4DQH5NRa6ngkOwilh
         NwJX9q4a4TNSspqM0dv3ff5iOAG5CQi/aznK9aR97P8MBJPeBJoHLMt+stZqg3tPDt6D
         YtCszw8DOOQEtxF0fDadlrWBFHZGJBL0XATkrqJm6+xXsB2RU/tnRXxLuzDR9zrj3iTv
         mBrVn8GRgy9dgs2deTj9WvGA3xPCiV0nf75Y9tcKGXxlWFFQBNwBMbn2j03K3/4ARUz4
         agSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9WHEIoacHTL8R2ueEHoY7tI2Gp315Un39SMe4h5qGjg=;
        b=QZdyokhbcQqlHia7YR140P9dd9jc74c/BaLnDqARbs9Wz8RsqjV+os3dxIibK8PzKT
         aQcjwu/NwJ84lh1Y6n+cMp3jAPD/kXqXE7DaU+fGFa21cXihTmAUyNbkvEC++bd5vP93
         4lNXlB2cflv/sJR17JAz1A34SBq+q7lceEHUCd9lui3eFM/OdOGpXANAooBXpUYQJTj1
         qwvEk1REWrYYQsIYINVDVdHx68ebycvn77o58z3qJOlFdRV3Y4hLRjHRd6rCrdmW8cH2
         W5zBmc5zvQzTR/oIlYCnbWXasTHTe/WYXOnjjH78jeOTEz5vyykGUxz9H4waO0Z6eBev
         Ub0w==
X-Gm-Message-State: AOUpUlHOa69AJxkCDoClfBZJwJIQI36EMelG4OUJHRHduewQS8GV999g
        8g8fw5jAXTIpCuolY0MA5UcGCoGCtL+9Rw==
X-Google-Smtp-Source: AA+uWPxPWx0Liw+EMuwtKMVnUgjCPHF7cYDYyE/xjjvVpECPv5A7XTUKOYRHF8XNKzP1JQ5pg0ZQjQ==
X-Received: by 2002:a17:902:b486:: with SMTP id y6-v6mr30166058plr.27.1534448997093;
        Thu, 16 Aug 2018 12:49:57 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id 87-v6sm217474pfn.103.2018.08.16.12.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 12:49:56 -0700 (PDT)
Date:   Fri, 17 Aug 2018 01:19:49 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        NeilBrown <neil@brown.name>, John Crispin <blogic@openwrt.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-mmc: Use __func__ instead of __FUNCTION__ in
 dbg.h
Message-ID: <20180816194943.GA25895@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the identifier __func__ instead of gcc specific __FUNCTION__
in dbg.h. Limit these lines to 80 characters. Issues found by
checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-mmc/dbg.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
index 2f2c56b73987..5da275239d7c 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -115,7 +115,8 @@ do {    \
 #define ERR_MSG(fmt, args...) \
 do { \
 	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
-	       host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
+	       host->id,  ##args, __func__, __LINE__, current->comm, \
+	       current->pid); \
 } while (0);
 
 #if 1
@@ -126,14 +127,15 @@ do { \
 #define INIT_MSG(fmt, args...) \
 do { \
 	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
-	       host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
+	       host->id,  ##args, __func__, __LINE__, current->comm, \
+	       current->pid); \
 } while (0);
 
 /* PID in ISR in not corrent */
 #define IRQ_MSG(fmt, args...) \
 do { \
 	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d>\n",	\
-	       host->id,  ##args, __FUNCTION__, __LINE__);	\
+	       host->id,  ##args, __func__, __LINE__);	\
 } while (0);
 #endif
 
-- 
2.17.1


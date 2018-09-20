Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE046ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F2121522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8PnYyKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F2121522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388635AbeIUEee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:34:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39035 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeIUEee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:34:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so1153618wmq.4;
        Thu, 20 Sep 2018 15:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RENaZUjJlY10LnT10ff/sqRbe8bi9rIvknGj7PyprDc=;
        b=p8PnYyKWp3k282LB9znUA8S+1VFkLdOT8y24+x3pNy2tClSKGYzAH/l0gjwA1K8Udn
         qSRuVSLhSQYErsUTDVxLYHXB/bck0XWrZ6FXiNkJ4d18eafEZNR+MdCf0zaNA+7CeGS+
         rTi/+o293KpJ6X9V/rbv/hWOygvAit4wnE4g5OkXFuwV564+/FZoU+uVhsvMs4Gzt/6b
         LmiddpRyNBTOsG9Bef8LC6bij70/wFFDGTIPdvVd6aybXcdctC3MAwuIDT8UZw8DB+RD
         NGo+97VN3meXCp004PpPR7q02JmQAxTL+80aCzNN2xKGigJploN+fuaViEY7KJhQFEDo
         pz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RENaZUjJlY10LnT10ff/sqRbe8bi9rIvknGj7PyprDc=;
        b=PVpAzJhkNIYkSHi7BizblHIbjzwwMXxHyjwE/lslOovf+rfxjxA4kbymFBOoMNcQtH
         BjTT8MHE0JYb/SU5vaaGfPHyNekjyoDC7OTX3AxeJu2JBC3RFiBo1ewA1Mq80j6OTCpc
         z8euofrpAZJEjvJNQ3sVdDYOH4+xPJIU2QfExQigFJMH8OAy47Z8WAWlFYvZ+MJAmPUa
         TUBWJ6EZFkmYlRS6qrakctSDx8Fqutr1TPL8amOV8S4AhUccAzdbt8Jug9rwB/g8DcXT
         xrHNzLdc52mcdl65nLOVUlGvy+VYc6HhIOyW091HLcdeYxz3GqRs/bMcty4Iwz8muq0I
         rXUQ==
X-Gm-Message-State: ABuFfogMUhaoUoqzYePF3Tqekh8UYRhGgdw4g+7gogJsn/8sjZfMQ71S
        f/9i3YF8X7psmGI5RB10HSKHr8dYLu/TUw==
X-Google-Smtp-Source: ANB0VdbrFXaENqko/v97cH0exzJXxtmf/R86JT38n811EIWCQZBA62hAoXz4E6SsWVWNgQOnwz7Zlg==
X-Received: by 2002:a1c:3:: with SMTP id 3-v6mr4449150wma.99.1537483725111;
        Thu, 20 Sep 2018 15:48:45 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id j44-v6sm43882738wre.40.2018.09.20.15.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 15:48:44 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] net: lan78xx: Avoid unnecessary self assignment
Date:   Thu, 20 Sep 2018 15:48:30 -0700
Message-Id: <20180920224829.17072-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when a variable is assigned to itself.

drivers/net/usb/lan78xx.c:940:11: warning: explicitly assigning value of
variable of type 'u32' (aka 'unsigned int') to itself [-Wself-assign]
                        offset = offset;
                        ~~~~~~ ^ ~~~~~~
1 warning generated.

Reorder the if statement to acheive the same result and avoid a self
assignment warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/129
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/usb/lan78xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 04f0a094d864..656441d9a955 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -936,11 +936,9 @@ static int lan78xx_read_otp(struct lan78xx_net *dev, u32 offset,
 	ret = lan78xx_read_raw_otp(dev, 0, 1, &sig);
 
 	if (ret == 0) {
-		if (sig == OTP_INDICATOR_1)
-			offset = offset;
-		else if (sig == OTP_INDICATOR_2)
+		if (sig == OTP_INDICATOR_2)
 			offset += 0x100;
-		else
+		else if (sig != OTP_INDICATOR_1)
 			ret = -EINVAL;
 		if (!ret)
 			ret = lan78xx_read_raw_otp(dev, offset, length, data);
-- 
2.19.0


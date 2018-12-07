Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59646C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9D0208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ+uWmQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9D0208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbeLGO1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:27:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50792 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeLGO1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:27:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so4610990wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 06:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JSCp0E3YcMHQnJxmWmlvvyYmqb2x78bbe9P3/VKRCKw=;
        b=YJ+uWmQxZR71VdOMEGKKvNWqp+ffLlvlD+LDVbBPAoyL+JI/AYFSUB2Ht2HkRCfXl+
         lhXYSUoTNB/IJhsGo3X7tZ2wTTZWYXjRU7i4cUGf2EKGb6+1Hq39rRzShIrEI7m1nlNR
         Fb81lO7yyRvL2icszXbWeVcnzYvt03Z6gZlmmYYt/lRyeAMyugEoNbLCKkwNigYqhSKA
         lJMe5KhcnC6HeFkye89IBjwf2yyAycKK4LZNRP7tXJJ+Iu/NUIXZ5JsMLuvxZmH4QKv5
         YDKsHec2RF/WFubCrvicWmFwzDUw+VOnaV4wyjMhSc6zCFC8aQb2mQDDUn+gqCZII6oO
         X9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JSCp0E3YcMHQnJxmWmlvvyYmqb2x78bbe9P3/VKRCKw=;
        b=B3118hsc0m/L7HYOlgxuekfnVJfCoAxkWpTUbEKI2mNyLGZDYEM92BjDhmGxaS2DJM
         qpb8Z8OvLiqIuF4Zb1c0WjCHrxHLnI7cLQHh7vQ44rd7YDRQ4ol4rbJVHsSPwihuAH6l
         UuvH23C5h9RAMDiWF4SZ0010tsEpILmK/tERD6ewFCRVkmU4gquFlsY9yM9CNCFh5g32
         3pmzK6gIHVNQJGQFn8q3GcJQNyleT4ur1wzBBjEqps/W1Ft5Yyc3iru7Gu7d+uvsxCF+
         rYf7Y4MBI5GoLcX7wae0csD3u3k0xmk7IfeR7NzZu3HYKeWhL6tH3hSvndQnoX5nyCcl
         7elg==
X-Gm-Message-State: AA+aEWZ0+h7K2bqvA0s5IFhJlR00YUXKunBkYnzDnzA4CxPJRXar5FK2
        MU0//aFHamvNHsikBrlOxOVje82j
X-Google-Smtp-Source: AFSGD/USXnCiyr2P9jcdU9X90PFxCDJFQ3+ZEq4vz99jfW+8731OSFhMX21BAV3eHo8yzQul5gApJw==
X-Received: by 2002:a1c:d1cd:: with SMTP id i196mr2400115wmg.107.1544192862000;
        Fri, 07 Dec 2018 06:27:42 -0800 (PST)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id 60sm7172523wrb.81.2018.12.07.06.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 06:27:41 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 3/5] char: lp: use first unused lp number while registering
Date:   Fri,  7 Dec 2018 14:27:32 +0000
Message-Id: <20181207142734.27370-3-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207142734.27370-1-sudipm.mukherjee@gmail.com>
References: <20181207142734.27370-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the parallel port is usb based and the lp attaches to it based on
LP_PARPORT_AUTO, we do get /dev/lp0 and when we remove the usb device
/dev/lp0 is unregistered. But if we now reconnect the usb device we get
/dev/lp1, another disconnection and reconnection and we get /dev/lp2.

Use the port number array to find the first unused lp number and use
that to register the lp device with the parallel port.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/char/lp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index e21ed4007d0f..0e081f521f51 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -958,7 +958,11 @@ static void lp_attach(struct parport *port)
 			printk(KERN_INFO "lp: ignoring parallel port (max. %d)\n",LP_NO);
 			return;
 		}
-		if (!lp_register(lp_count, port))
+		for (i = 0; i < LP_NO; i++)
+			if (port_num[i] == -1)
+				break;
+
+		if (!lp_register(i, port))
 			lp_count++;
 		break;
 
-- 
2.11.0


Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E01C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B8422474
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMmScwaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B8422474
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932941AbeGGClh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 22:41:37 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39361 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932463AbeGGClf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 22:41:35 -0400
Received: by mail-pf0-f193.google.com with SMTP id s21-v6so9789765pfm.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 19:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7rtkHZ25Fs5IZMgGFd9CV3MVXt/KZWZypmrhqSUP6Jg=;
        b=XMmScwaXjPfyNVpPkj8L1ZmrdSju35xgsbW+M0OYMA80Zmrh2Qvblexj5nMhx8rP/m
         fAr9KiZn22CPOk6qcp0RxXEjrq47bwPASPPQs9h8P69JMcZV+jkRoqD6PtKHDEi4N7UW
         /01ZjlXcZ+tLftP5U9TY2fo+BHYcW1cRnk09F+O5PuPamBhdY2XZH3wwAnill21q+ygt
         WncmhZQJZUQn5LgOy3ZZPigxGFUovHHPISAS6zPEABNYbUOpM5MWCwLUw8ONpv2h8T8Y
         clDI5yEFKMisTO8JrrtH9aHjZOMF44EtWyDHcry+9IbyZrvTeyp49vJC85WSk3ExiHe1
         8WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7rtkHZ25Fs5IZMgGFd9CV3MVXt/KZWZypmrhqSUP6Jg=;
        b=Gw3CQMopZg/DTdnPdj9n8g6f7EXqVyPjZel21/vKfHz82fa3x04g/qElwOh1zT1S3C
         yGuSk5SFsuMhI/++5+IrjeLuGkRhjWRsLfNIKo8GYvKjS1IWN6ic0NFj7qAAXDL00ZbX
         dW752h+niUPQuUR8WKYo9H2so2op9hRkL7BRE0BtpDObRG57ux51pnkxS9yaSpt7Z1R9
         MxHPXWYfpQKApzKQsaiVHWksYkOhcDOCFGTGklAYyTr4KVvtFdbP64zfv7zSomUVeWmD
         V+Ux5UuYio2oSzoDF+MAR5AascwUd3bDh3geMmPMwJlkQiuc87jYY0KWFkiS5FUSii7F
         k4oQ==
X-Gm-Message-State: APt69E1cxCMShzNf/mNZcxQrQ6BhFQiQHih+Vzoi20Ye8Ro1H6CnmHW/
        uExhmBp47UT6POtMKrBzss4=
X-Google-Smtp-Source: AAOMgpfkWuzLj4zabPJmkCbuE3kTgrMJB2f7BraO7qz2cbWSgGcDd4LF0WMSLD1Lv+SIMlfIFxiOwQ==
X-Received: by 2002:a63:3246:: with SMTP id y67-v6mr1173567pgy.399.1530931294564;
        Fri, 06 Jul 2018 19:41:34 -0700 (PDT)
Received: from localhost.localdomain (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i17-v6sm18897276pfj.95.2018.07.06.19.41.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 19:41:33 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 1/6] mfd: rave-sp: Remove unused defines
Date:   Fri,  6 Jul 2018 19:41:03 -0700
Message-Id: <20180707024108.32373-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180707024108.32373-1-andrew.smirnov@gmail.com>
References: <20180707024108.32373-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unusded defines that are a leftover from earlier iterations of
the driver.

Cc: linux-kernel@vger.kernel.org
Cc: cphealy@gmail.com
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/mfd/rave-sp.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index 36dcd98977d6..dfa4f5f1c376 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -63,16 +63,6 @@
 #define RAVE_SP_TX_BUFFER_SIZE				\
 	(RAVE_SP_STX_ETX_SIZE + 2 * RAVE_SP_RX_BUFFER_SIZE)
 
-#define RAVE_SP_BOOT_SOURCE_GET		0
-#define RAVE_SP_BOOT_SOURCE_SET		1
-
-#define RAVE_SP_RDU2_BOARD_TYPE_RMB	0
-#define RAVE_SP_RDU2_BOARD_TYPE_DEB	1
-
-#define RAVE_SP_BOOT_SOURCE_SD		0
-#define RAVE_SP_BOOT_SOURCE_EMMC	1
-#define RAVE_SP_BOOT_SOURCE_NOR		2
-
 /**
  * enum rave_sp_deframer_state - Possible state for de-framer
  *
-- 
2.17.1


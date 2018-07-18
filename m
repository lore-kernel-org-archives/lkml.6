Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1F0ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1F120693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m0X7Nysq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1F120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbeGRAu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 20:50:58 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:39546 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbeGRAu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 20:50:58 -0400
Received: by mail-io0-f201.google.com with SMTP id x5-v6so2136775ioa.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 17:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=UTmkHL+5aM285pQIvp81isppzJHzNX0+TeHPxZbDcO0=;
        b=m0X7NysqTdxY7Wok9UZ42bzBK1jCUpabH/1KDd6Shwvtm9Mu8hlnG1OQZJaQBwG0S9
         cY0ivv53rev7BTwXe/yL4caTGYrujtAxZ72ZfRFy+dTrma8XVVdydl9Vh6uI42ALW8D/
         HfYtIW9N+Tt2wg5/VrYCeIvVJe8kncwI3amIe143O5GkHVHDakAaOpHLjS6pljW5W+L/
         2MXo95PRU3Hv+Jqx2M3V07x9c/Br6onaVMi9x+lzofjhkcjkujv8z6mkAs5vjfaUOIs8
         ozEmFjBFZlt6n68x3mCVyLycikokQR4+ZT88tWuqXlnGtwU7F9zPEdE4fA7hl16aGy15
         ToOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=UTmkHL+5aM285pQIvp81isppzJHzNX0+TeHPxZbDcO0=;
        b=aZG3lr3fW3N4bglvqmJaA8882sAM0s89Zf3zr0bATJwizUp58bbJPspx9C1hwpPaWu
         kBH7mMeuQhwYBymdQJVRABs8uNQbc1wm2TAqsTpB88XhL9bHWsV9TumdvubFA3Ldi0B5
         fXMxhKDQJ3Jb43UXFGOQr/GQO8+UPAPYG3GlllIOhPcLsKrqDClIV2iUnCv1aDSm2ANn
         mKexofo+kIqGQaHIGgSXIXJySFubB8zFXwIerHtVF52rQxIZQXG4RRQc/9pOMVya8G3v
         71ogZv7uVf7d6EPnCWmuXeSVtWjFm2+OMVlLQ3Jdj/LjsWNTS6tdqUWLrpH6lVh7gpYj
         X46w==
X-Gm-Message-State: AOUpUlFmSEsfDC032rZxwD+m3iJs558CQ6QHRS+0C3KfCAK4Zexn7Vr/
        7873Ps77mE4lShmMmNVAzVzCdyos
X-Google-Smtp-Source: AAOMgpe3bg/BLR2y0PAx1MWiz5btq37rCuPagflALw2CanWiac3XHACDie++AdAHqDRbnFnOtbecgSJ4
MIME-Version: 1.0
X-Received: by 2002:a24:b14a:: with SMTP id c10-v6mr121148itj.4.1531872952437;
 Tue, 17 Jul 2018 17:15:52 -0700 (PDT)
Date:   Tue, 17 Jul 2018 17:14:54 -0700
In-Reply-To: <20180718001455.140575-1-rkir@google.com>
Message-Id: <20180718001455.140575-2-rkir@google.com>
References: <20180718001455.140575-1-rkir@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 2/3] tty: Make constants to be enums instead of #define in goldfish.c
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

enums produce better compilation errors than defines.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/tty/goldfish.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index a92fcb2b0002..a9c8ab8a4750 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -19,18 +19,22 @@
 #include <linux/serial_core.h>
 
 /* Goldfish tty register's offsets */
-#define	GOLDFISH_TTY_REG_BYTES_READY	0x04
-#define	GOLDFISH_TTY_REG_CMD		0x08
-#define	GOLDFISH_TTY_REG_DATA_PTR	0x10
-#define	GOLDFISH_TTY_REG_DATA_LEN	0x14
-#define	GOLDFISH_TTY_REG_DATA_PTR_HIGH	0x18
-#define	GOLDFISH_TTY_REG_VERSION	0x20
+enum {
+	GOLDFISH_TTY_REG_BYTES_READY	= 0x04,
+	GOLDFISH_TTY_REG_CMD		= 0x08,
+	GOLDFISH_TTY_REG_DATA_PTR	= 0x10,
+	GOLDFISH_TTY_REG_DATA_LEN	= 0x14,
+	GOLDFISH_TTY_REG_DATA_PTR_HIGH	= 0x18,
+	GOLDFISH_TTY_REG_VERSION	= 0x20,
+};
 
 /* Goldfish tty commands */
-#define	GOLDFISH_TTY_CMD_INT_DISABLE	0
-#define	GOLDFISH_TTY_CMD_INT_ENABLE	1
-#define	GOLDFISH_TTY_CMD_WRITE_BUFFER	2
-#define	GOLDFISH_TTY_CMD_READ_BUFFER	3
+enum {
+	GOLDFISH_TTY_CMD_INT_DISABLE	= 0,
+	GOLDFISH_TTY_CMD_INT_ENABLE	= 1,
+	GOLDFISH_TTY_CMD_WRITE_BUFFER	= 2,
+	GOLDFISH_TTY_CMD_READ_BUFFER	= 3,
+};
 
 struct goldfish_tty {
 	struct tty_port port;
-- 
2.18.0.203.gfac676dfb9-goog


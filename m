Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4808DC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B3820843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXis77Ik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B3820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeIDHIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:08:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46861 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbeIDHIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:08:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id u24-v6so891298pfn.13;
        Mon, 03 Sep 2018 19:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gCk8mWHnhtx2R8v563AkPHm/bECb7B3+8+2bdvc1AQI=;
        b=kXis77IkUUCXLOartff6QRvsXnQ25XPDuUeq4NLa6kShitU3rTg1KXOS5kIBcHGdV3
         uIPgk8c/PB3YkO1Yk+rSkISlsX9/dTP8O06eM9sApMgdu58f5XRJG3xvL+L6d7soywPY
         72fk5vXI37rdGTXiYZdeztpglI9VKOrLLnUk3PFIbv/8SwC7sUBTdFQBeL8rDQtnu5fK
         Uu0/mvPRWnLCKqSe3fH5G0mLiAGDWJsZrKK4F57wQ7ExDL6RboOqWrjBD7Hg0q1I9sg8
         1kRmSrUyAckcgyhDfS8K1JjHLLq4YLW+s/d7YZecVUSl57pUVNDHcwXG/gCbNr0Wg6Du
         nWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gCk8mWHnhtx2R8v563AkPHm/bECb7B3+8+2bdvc1AQI=;
        b=NacUTprZwzUObZ6Wxuc4XE8Avz0jjZOXVWfqFuwD/DL0XZUECVvoNRNuQRHc2++66N
         rSGF3SydQwWO01+HkTI8fZT2kCxeAI/DDb1rAuhOkxWfar4PPieiC3ACrhIl/iiBxI2a
         ZHotlQ08FXQniCcmtpOgPTQaYAHqvoWFpr0D32PuxYUNlIswhrSmNgQprHr+vRiULzug
         STxDCgfLdnd2yQyjGS+SbUGAHUP8v3AKGjJKpRbIQM3Mp+1wd3a6TiXkUtuvPPLxkrC/
         yosXKTo9hA+H6GzWCgvuk0tZ7UwvZBUij+fEwJ8aTjeRGvBnq5yMhVWfxYJa1y1V0Ml8
         RCTg==
X-Gm-Message-State: APzg51AMig72JVuT1nXLUfYkVwyjgX+dBAHvVAAd31+vwzUkPihKvaxh
        vTTd07XUEXugQVnbx6SuXTs=
X-Google-Smtp-Source: ANB0VdZB7tSPhGLbAj1h6wk3kMlbEmfk2KzDAPBLyJSrvvV8C6RnkBEc3JPAd3M798RwB4lO7UbXSg==
X-Received: by 2002:a62:3241:: with SMTP id y62-v6mr32586471pfy.4.1536029159358;
        Mon, 03 Sep 2018 19:45:59 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:45:58 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 13/25] usb: xhci: dbc: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:39 +0900
Message-Id: <1536029091-4426-14-git-send-email-climbbb.kim@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since tty_port_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/usb/host/xhci-dbgtty.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index aff79ff..18d661c 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -174,8 +174,9 @@ static int dbc_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 	struct dbc_port		*port = driver->driver_state;
 
 	tty->driver_data = port;
+	tty_port_install(&port->port, driver, tty);
 
-	return tty_port_install(&port->port, driver, tty);
+	return 0;
 }
 
 static int dbc_tty_open(struct tty_struct *tty, struct file *file)
-- 
2.7.4


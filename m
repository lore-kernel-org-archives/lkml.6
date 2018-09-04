Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1ACC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E092086B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtxqNB0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E092086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeIDHJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:09:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45597 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbeIDHJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:09:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id j8-v6so879690pll.12;
        Mon, 03 Sep 2018 19:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9fhtRSxRNlhSG2HakM/avAOwn2fzs7e/3lLxQzyJ82M=;
        b=MtxqNB0WA/xheF8oer5OfxpHH+cnB/mFS5n9FY2+qIngoXU2LN6P0ny5VhtK1xJhbi
         D8ATKUqQvESgCYvBa6wJ6P1rAN1s01M1QcKskSibu61DVOa0RoiUs83RTrNmu6/XM3NW
         bynC2ACo8vSZJxZUSDYPOxFnJiOcAGHWocCRm3KiTyJnbMpu3iXC9GrWS+ngdbYg/XnI
         GbBvce2BsHGIHsbrP2tub+g789NyfsB1vl3vkW2Z+pDQ0wOXDIgtgeK9WuRRzrjxrlWP
         fXusYtUOTBC/xkFSb4wmIPQ1bQQSy3UkX8Ww52YENeadayXKav0ZMV2ImRPxm5eDFmR5
         8Nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9fhtRSxRNlhSG2HakM/avAOwn2fzs7e/3lLxQzyJ82M=;
        b=PwAC0DoxAOlPlKKUbiI8jhJbscxD65N8H+r9hfbRUYhA1C6LKvx+z9eIB1PgNG5OAc
         5uitjzK2Mdrs8gIv3u6WlV79XByv1TJeUNEBOdHNUWhKQQTawmdtm3UjTLB5XQrQfNKm
         h4B4zj1ZSwaJNr9OCU2n7jHUDzJo1HzPF3Nxu9VQNetiPL0jhQGlTAaegyOfatEuICzO
         cvqiJPoykG2CzN5X0olzczBVhL1PopPOCY6UIKX6N8iov1ylbZdzYV29/b0jw5H9VHwF
         SDS8/jAW+cVwkxOIMlfZ1sXh23RSgXgxyR5zDnFsaswkuwoQyhNdsUfBaeRAw79r6Ode
         PdIw==
X-Gm-Message-State: APzg51Dbjx6GGVohJ1iM+6VF/Dt85ovOyzjyzgd4zigrd6bF3qXEeSMA
        AIzXGCVe1e+UHeUdHGnu1C8=
X-Google-Smtp-Source: ANB0VdbGNWdoDZT7cp5uWkjz+NRP9RQkbF+dv0PEH/mUMC3Ps4V7vhtxolhlceX7nOpZVgYGv2eimA==
X-Received: by 2002:a17:902:bf43:: with SMTP id u3-v6mr31343352pls.88.1536029214501;
        Mon, 03 Sep 2018 19:46:54 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:46:54 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 25/25] usb: usb-serial: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:51 +0900
Message-Id: <1536029091-4426-26-git-send-email-climbbb.kim@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since tty_standard_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/usb/serial/usb-serial.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index f7aaa7f..5cfc2ca 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -192,9 +192,7 @@ static int serial_install(struct tty_driver *driver, struct tty_struct *tty)
 	if (retval)
 		goto error_get_interface;
 
-	retval = tty_standard_install(driver, tty);
-	if (retval)
-		goto error_init_termios;
+	tty_standard_install(driver, tty);
 
 	mutex_unlock(&serial->disc_mutex);
 
@@ -206,8 +204,6 @@ static int serial_install(struct tty_driver *driver, struct tty_struct *tty)
 
 	return retval;
 
- error_init_termios:
-	usb_autopm_put_interface(serial->interface);
  error_get_interface:
 	module_put(serial->type->driver.owner);
  error_module_get:
-- 
2.7.4


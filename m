Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3286C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA20E20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bx65hI3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA20E20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeIDHJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:09:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44921 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbeIDHJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:09:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id ba4-v6so878053plb.11;
        Mon, 03 Sep 2018 19:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RZT0NlqWPDVv3ZY8knEZ75oaH0KEYhTsNL+EUjOlpgk=;
        b=Bx65hI3SeSwju/CMQO3BmpKV5KW3A7z+7x59hC7W08nF3mou9O0IAO/i26QCK1SAav
         qpfO2abtOD1tOU1XvV39t4Q66+miH6hx+lYSF23Ln0nFrCHq6t8OIrZnakB5FyLMpQiH
         JJbcCQrzro3jr14467jxQwj+fnbPp3AgA6AxS4KK3OzwSFIx6TP3gru3F2vgX11T2QEM
         1nLcSdwTN3OCx3Q5+P6ERKE2TPj2LnR7jH5tNKM10h+UoUDk19KW4qxVB9vlt8pOjJ49
         y4INNwqDe5rIv/tQK3LyH/Y8Q7kVNPecJm2Do/86YjEud3mWKeOnzqtFVw73hq9OdWSV
         uINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RZT0NlqWPDVv3ZY8knEZ75oaH0KEYhTsNL+EUjOlpgk=;
        b=UwyACqdwLsSfS+TqOfEuS0I5nSjS2Cvji/dERcKwZLQ5Ka/540ncRk8PpJQZKgOnY+
         P74M5V43d2KU2ozWNzhoccQtySWLTzRHsshZQwvHuygCk066mEU5+xqCkhmUVbKowoRI
         pQn51i14v+wRi8/FmyltJBe+Y/Y6f8AmnlpwO1xd4ZIg5Uxs776pkZdzi0eRL7XaFobN
         633asy3IbIdUd4rbrE7TbOtJTTjpBrYa0AWtOVOLgZTBh3TdCtkaZhhPDpTyBpwAs2lc
         Fw6ISHip3DLodBMBs+On9nZf0+Jr5dPcCnUTibdzMshO0KiDkyAPntndeUCfzGdX5V/O
         iArw==
X-Gm-Message-State: APzg51D8ZloGCyF918qpoOWswj/cBgOo/AMNjxBtFol4XNWs21o0UnNF
        b0MwPtWPCO10oGzfDwlHYCM=
X-Google-Smtp-Source: ANB0VdZdWeaAIXAcMtwyECEthciNo7IoqHV1eYwdRbpGaJEZKNxxUYIv88HfBs7dyZgV+Zaswfxqaw==
X-Received: by 2002:a17:902:2e83:: with SMTP id r3-v6mr31398676plb.80.1536029210221;
        Mon, 03 Sep 2018 19:46:50 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:46:49 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 24/25] usb: cdc-acm: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:50 +0900
Message-Id: <1536029091-4426-25-git-send-email-climbbb.kim@gmail.com>
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
 drivers/usb/class/cdc-acm.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 27346d6..de6a27e 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -572,23 +572,15 @@ static void acm_softint(struct work_struct *work)
 static int acm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct acm *acm;
-	int retval;
 
 	acm = acm_get_by_minor(tty->index);
 	if (!acm)
 		return -ENODEV;
 
-	retval = tty_standard_install(driver, tty);
-	if (retval)
-		goto error_init_termios;
-
+	tty_standard_install(driver, tty);
 	tty->driver_data = acm;
 
 	return 0;
-
-error_init_termios:
-	tty_port_put(&acm->port);
-	return retval;
 }
 
 static int acm_tty_open(struct tty_struct *tty, struct file *filp)
-- 
2.7.4


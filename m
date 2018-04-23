Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-906599-1524477091-2-2860147403505592199
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524477091; b=fiuanvy6wCG/8z8qCcvYi9bAtukZTmTshWmMam0uSH5dehSgdh
    sl7+nNPHLIw54kX/1lHzj1VlDXzc+79HIwaAL0C+KXNkdGEyAXGdKVfMDSGCVEtZ
    kflAPI3wklLraFPuXMz5NYvewbctPzLrvISobtHp7KDPXPf9h+NgSYa1BJNj8XWS
    3/2CZXCNbCjuJs+stNcrG7y60URVaAlnExnEYu59HI9N864Bb/o3sc8+DO53axjd
    Fjy6Kf8ut/TD0ajb2busOkXNEpeExYntUMkibqA7syCHkj4+IFIvNKNFI2X3msnw
    6vZgClbfIzVX0GyUqIxg0fnbgAjayJDRUT1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=fm2; t=1524477091; bh=Bhc5ue6Y+of/ORuCnpQJI4gGtbNDk6RoEX4yRJB
    Dgs0=; b=eHV//YYYhWElG3MccWDSRudr7H7LyaTukVRf0/Bf3ZALF77JO90Cwi+
    Fj24rUcQFUIGH0BOOSVi4a/Zc0bMkzekH34zrC4Q2sjkK3oGqDs9Bye/xMczxYTb
    896gWF/LmzeIWH8PTvsSIbtEZqxyG392T3p4HrGxy35/gnlxaWMAWSEzggV3YK6B
    BQTGhuALvIYlfV1LZBAyuPoTaz84eTFX+HGuLqGhI4pYM79HhAiQxAr67XFPPs6/
    axf0cSSI3NC1ahIABKOQWcTnSHu424ElcxVvreXT5RUrjU7KK0Xz46TDIL5owaur
    WQ1cvzX8RClIdvwgD+HilwNf1gbyGzw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=OK9Fo08d x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kn/i20R0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=OK9Fo08d x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kn/i20R0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE64xJftv5iRHAqT/1UlqxbnLXtPIjFidNnr8DrAKoFHXBl2vr+v7OXn0IsOIVThj9vk968jm7Obb/H3+9rqO2jZLCDIjt8qYw5B9aKW0WyO8CzOTv8W
    OhGzyI5NIMOQIC12NhRWWGM80sQ1MnRoCpqMaKQJOIlCLh2gwLG8YiNZfBGTtvRVGlnbVXJW9QpvKpmxDGPYBBYw/u4yJ/HxJuZk0TQBSrrXBgkhRfbK8NVg
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=Am4ss40yAAAA:8
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ToVR-tbUxkdWd-CVnVkA:9 a=x8gzFH9gYPwA:10
    a=lf-hbUz_c89dky27wAWH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754773AbeDWJvW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 05:51:22 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41409 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754500AbeDWJvH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Apr 2018 05:51:07 -0400
X-Google-Smtp-Source: AIpwx49QBzv/uNeL/XydSDrddi55NUAVd10Pf/e1ManTOxMidmOYNhX4ymN9BGSkKi7KSkU9syifRQ==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>, geert+renesas@glider.be
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] serial: uartps: Remove console_initcall from the driver
Date: Mon, 23 Apr 2018 11:51:00 +0200
Message-Id: <dc341a4527db1cf4589afa1d932fc9dcd5796860.1524477059.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1524477059.git.michal.simek@xilinx.com>
References: <cover.1524477059.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1524477059.git.michal.simek@xilinx.com>
References: <cover.1524477059.git.michal.simek@xilinx.com>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

register_console() is called from
uart_add_one_port()->uart_configure_port()
that's why register_console() is called twice.

This patch remove console_initcall to call register_console() only from
one location.

Also based on my tests cdns_uart_console_setup() is not called
from the first register_console() call.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Alan Cox <alan@linux.intel.com>
---

I am not quite sure about this because console_initcall is called
early but I can see any difference in usage.
pl011 is not calling this but others are doing it.
---
 drivers/tty/serial/xilinx_uartps.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index bd72dd843338..932210331484 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1293,20 +1293,6 @@ static struct console cdns_uart_console = {
 	.index	= -1, /* Specified on the cmdline (e.g. console=ttyPS ) */
 	.data	= &cdns_uart_uart_driver,
 };
-
-/**
- * cdns_uart_console_init - Initialization call
- *
- * Return: 0 on success, negative errno otherwise
- */
-static int __init cdns_uart_console_init(void)
-{
-	register_console(&cdns_uart_console);
-	return 0;
-}
-
-console_initcall(cdns_uart_console_init);
-
 #endif /* CONFIG_SERIAL_XILINX_PS_UART_CONSOLE */
 
 static struct uart_driver cdns_uart_uart_driver = {
-- 
2.17.0


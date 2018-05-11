Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3782484-1526034104-2-16763774215966670405
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526034103; b=SKz+22MdzT4nefSVFNT07mdD+BOr9XclxBrOyn9KHetH4UXHiS
    6tY02xfl6/Aw5mPr2ViUoRwhWGbRdMqWRIzhTvqEl04cer2BS/kuts8SmpVL8ciO
    +UrAjH96OWZXTRdVMXbNiaIRX8RgGVutLoWhp+6o2nWD4Z7JotWa/AMjL5YCdKs2
    vI/uPcQJ/P99ZVl41LhdQyIHwU8gXZfy2TsIA02YxdMQgWX+N3hZyuVOA45hMaFG
    LkF0Y1tHKRY6CgyxKNJ62J/dzGacknWW4T8JaVv5h3DsisNmvl/LiguiUn6y4APM
    Ywmd3zFegiPVHDkvuMif4L08bxmtJKIeTp6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526034103; bh=xkleVMgOFemK05YnfOIOkMVY+k7HyM
    5EKnL81Cqwozo=; b=NDS9G+/AzWyeNJqalkIlDmqe7IzLiam1CIRiQ/S3EZvmjC
    XgGQGtOlnTA1QwEoTz4O8whZSY9B+JENIPwE7TN1ile331y4Maj1U/lKWyVjFQDX
    O2CVUnBtVSRmqjz8cjWmmuMC0QURdAaYFOeynT7OLF+zmOLj9ZWopGv8bsD6n1NQ
    kjXA+QWg0IW2rpyzcFJ3AoO2tQZi7eLKAfCTGOKfFYuVCGmP/jS/41vG/ksmOC12
    GYb64QxW3JdtgJxJbKxifAdUBX9HLy/F6M9+UAWdlyxD7n2djW32wOWqqDJ+cMr9
    QvzrGkJ1H1PepPymE9K+hpsQFJL7cY10CpcgSLwg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=ege5Fvm0 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=hFzZ6Vky;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=ege5Fvm0 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=hFzZ6Vky;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOvIli7Sf8UJZjS9Iib7mKbYWPrppPlUAog0Sp1/LnPD0yIqPMAuoxGsRM0pUyAnM0sP9QUaWQuzhSdhE393uTSlTK/FSxsYeoqomOweoTkyx7ryEeM6
    5TLaKdK7jxrhN12/ItZMI6PFI69KaYiCseBlBBvXfGORO4hSYgWXHjfyKPx+B8vpVhLhzr6ZfaVx4xUVeHG83/vUCHT3sEuxuU/UjKCKS10iuaNXoh5dZa2G
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=za2JL7ueGaoA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=t2L05WIvPPVFVdcCYHsA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752827AbeEKKUc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 06:20:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52609 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeEKKUb (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 11 May 2018 06:20:31 -0400
X-Google-Smtp-Source: AB8JxZoAQ15+8VEFd1RuKYtwpmB6DQuAfbPCsFrsSlLnym/xh9/QLJ6VQIbVDYL1V1uMc1iltDzYug==
From: Romain Izard <romain.izard.pro@gmail.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH v2 0/3] Fix an Atmel USBA UDC issue introducted in 4.17-rc1
Date: Fri, 11 May 2018 12:19:53 +0200
Message-Id: <20180511101956.11782-1-romain.izard.pro@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The use of GPIO descriptors takes care of inversion flags declared in
the device tree. The conversion of the Atmel USBA UDC driver introduced
in 4.17-rc1 missed it, and as a result the inversion will not work.

In addition, cleanup the code to remove an include left behind after
the suppression of the support of platform_data to declare USBA
controllers.

These changes have not been tested on any hardware, as I do not have
a board that needs to use inverted GPIOs.

--
Changes in v2:
- Use the correct format for the "Fixes:" tag
- Collect "Acked-by:" tags


Romain Izard (3):
  usb: gadget: udc: atmel: GPIO inversion is handled by gpiod
  usb: gadget: udc: atmel: Remove obsolete include
  usb: gadget: udc: atmel: Fix indenting

 drivers/usb/gadget/udc/atmel_usba_udc.c | 22 ++++++++++------------
 drivers/usb/gadget/udc/atmel_usba_udc.h |  1 -
 include/linux/usb/atmel_usba_udc.h      | 24 ------------------------
 3 files changed, 10 insertions(+), 37 deletions(-)
 delete mode 100644 include/linux/usb/atmel_usba_udc.h

-- 
2.14.1


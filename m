Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2871405-1523871306-2-17815630525599935536
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
    1523871306; b=dlPmgiEi1CN4QCIQyB2gWXWHR5tSqn2+3JX9wmxGKXkxMdKWDv
    4AHHnFXzmroZ52ri+lOtiOrysADDgKT5N+zhZSrOZAqGX02zmcH+1Vm6XJj8rgtJ
    V7DYptEO874S48vhZMBoifovFbAhZ9bulo2RCn3Me6Nln9PH7Z6PX7w7gC21/6OP
    g7eh9S+1qYsNllXzLL75XTBlWoSrus+sQv4/4z938az/nbQQV4XFhVEOYdE8EIVf
    NwlW7VMN2gt6mjNNbIRfIIrjFUkJ4bengek9Z9VAX/c/kNFrzNWyK5rUHD+5pCjM
    hlGDjLoux8gCmJfw1wyC2HeoWJ8ExH6df6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523871306; bh=/QlF9roee2cQPlv014WtYBn/gVf5yK
    joXetE9HiE3KA=; b=S6qQn6t8v1urZkWFujIXIWLg+4m8eEYbAFPVHir4E4Zkcz
    8AjPxdnagDMAtHtU90oW+0MtT9/PYE0BK4Ljek0Th838J7j5jUGr63knw0krinfX
    hUtG2Au9w5cTErRVTzwBsEFzTc1yDf6pzNF5a+nslH5M343ZrJxPCicepCSv+eWq
    XBHj+ZXlj8TsRedp8gAbIPU0noQ0vnrMCQ9TixrtB4ooyVE6i/QL13T7xRrM+CVn
    9cVlF8Zzyl9VQZ4ApP0IPLdUsB3qNC6kaMXRIj+HR8q2Tg60TU9vB9IgC6B1RqkI
    59PJyw8R27RSfj0B2q/M++JIw9h86k7SG68I2Ecw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CUAXx1h2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MFwptRu/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CUAXx1h2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MFwptRu/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFG+lyK0emRgwIYosdRkO6Oo7wplySLD12xML9n7yVeZDobkA3ddarMVLzLvxZcefEklUuYCJIAcFsAUveVO7kJExqp7wj11attbcc6s1iyoqvDxkLDm
    B8z034e2mfgZCgkPZqyMAIjgZsXL7f8eMdjrytsXSTi8U2U/4zi0wgUDxUcbObAA5sj1VQOLIbmxKqLocdD1j5TLujIWxP6lWWd/inEe0cg7KkDj0TP/VhL3
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=za2JL7ueGaoA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=t2L05WIvPPVFVdcCYHsA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754317AbeDPJez (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 05:34:55 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45622 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752824AbeDPJex (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 16 Apr 2018 05:34:53 -0400
X-Google-Smtp-Source: AIpwx49uRhRlQ/gVzTYEey4KoyGz8dx2WeGog1rOxpswHhbeNs3UKvANMuLuW0l0bMSFmzfSuxdM1w==
From: Romain Izard <romain.izard.pro@gmail.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH 0/3] Fix an Atmel USBA UDC issue introducted in 4.17-rc1
Date: Mon, 16 Apr 2018 11:34:02 +0200
Message-Id: <20180416093405.16612-1-romain.izard.pro@gmail.com>
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


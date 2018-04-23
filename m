Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-906599-1524477070-2-14656135322972883727
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
    1524477069; b=HcuTSnTsmmRh6BTIjPcM7XtdiNiwCo6aBR0QrfL72kxkAvi+al
    zCSw1dIxRrg4Beklw82uGXmbK72osT+v6aI8hYiB4tgf+wOA7vi/e7Zj9IQSG+Cl
    VixPmr/vtSRqt22DT/oVuUNqXbDGCG72qtfUrUa8HKGyzpKIgtESkQ7eIjsJNpSk
    hkTv19pPzsKgjyi5Bie7OBttCuTAhlExY1PqxUezwp/BlFJ0QI53KvScWIN8gpUS
    /Q+Pbw4p6PASRDNda40Ekg5jScrZ6mCXJOoU8Shew/hV3bDrSjlEXetKU2KS2Omj
    ZZ1mXuRATOUiZXvg1D3cWnbiYq7d7vjJscoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524477069; bh=AogD7aM7dFoo0wisGI57EEnc+xFN5F
    W2uu6Yy2X3DmI=; b=llZBCGMn0OC5Rnig8F21KbREbCj1ZOornoTD2hBbIQ87DM
    QqlZA+sW4tXkiXoG8t7bNCN4QZYkQI/kn8de7EbsBmAQSwK0W4k219lmI9k3yzVh
    UlWUwT3XD0w9c10MbPTfW9JTcQoX9sWIfBG2Et0dCHB9gi5HMhyX6rWjhKgXPvVF
    03eCYnLeV97WVkqril3eeD4GRs/5GfPR5cCCyrRQwWY6Q/QJW07+R59Lqw+yiKdW
    b2INtijaLDw+TKZ8PN53yzgGRbNscK0VQtNszS7O0EYr4QiDRYSthUJrDgJTgomX
    GQq1P83Np1M452oCaxeyk2eRs+849TB9E+h/g2Ag==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=wVMsqCf1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=blgiR6ia;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=wVMsqCf1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=blgiR6ia;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNCfVevyGjN9hSk4D4I6t7tqVvcYLGGt4VzlsLMEPFGbm8YMhIqscaUwPlvxeLfAJEv1ADfI4e5zBlJWbHXdruexqTSEUofv8bspaKubxscuolYq7Ufw
    Cv6l3LXGU4D+KWm05rcqcjKrNyhO7xbQQKuwDeqh2SPJ2JO3SR94d5dwEKdQLobZNgjozX1REvOLzn3a20N8FUewD01B/TWJhYofc/DL5/IB/R+BI6zsKcpI
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=OLL_FvSJAAAA:8
    a=VwQbUJbxAAAA:8 a=A_J5-YiRP2OO3Pcff-sA:9 a=esMPUqux980A:10 a=x8gzFH9gYPwA:10
    a=tqpKPK-PZRsA:10 a=oIrB72frpwYPwTMnlWqB:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754486AbeDWJvG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 05:51:06 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:40940 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754335AbeDWJvF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Apr 2018 05:51:05 -0400
X-Google-Smtp-Source: AIpwx48P3e3itV5pcXf8feuHN7A+/Gudgsq4YAoyN12zryhT0pdtuxNZYw+IItAOA1Cp2m7xeqFs6Q==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>, geert+renesas@glider.be
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] serial: uartps: Dynamic allocation
Date: Mon, 23 Apr 2018 11:50:59 +0200
Message-Id: <cover.1524477059.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

this is the initial version before next step which is move
uart_register_driver to probe function.
I was able to get rid of static array with uart_port structures.
It was wired with console which is also fixed.
And the next step is the most complicated one handle .nr in uart_driver
structure in more generic way.

I am sending these patches as v1. RFC was sent in past
(https://www.spinics.net/lists/linux-serial/msg27106.html)
and I promised to wait till Geert's
"serial: xuartps: Fix out-of-bounds access through DT
alias" (sha1: e7d75e18d0fc3f7193b65282b651f980c778d935) is applied.

Thanks,
Michal


Michal Simek (4):
  serial: uartps: Remove console_initcall from the driver
  serial: uartps: Use dynamic array for console port
  serial: uartps: Move cnds_uart_get_port to probe
  serial: uartps: Remove static port array

 drivers/tty/serial/xilinx_uartps.c | 102 +++++++++++------------------
 1 file changed, 40 insertions(+), 62 deletions(-)

-- 
2.17.0


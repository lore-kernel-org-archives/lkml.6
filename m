Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2626299-1525358332-2-1543811105589083029
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525358332; b=dNNw5040Bbun6dUTtV7fzQ0uO4ktEKFjkioWjEqixkv3RoJZiv
    LO6EZcnLXA+Nhl/vEEmkG3L0DWfKAIBKh+Kqle0Uidwtz/k6R3UNHg9RmF/reuoh
    65DO5UMhm3alzgTdIT+osLNaSOqdurSBuNdTBLBUKhm8xoODbNO06RU3V2Rglfl6
    810wWoIlqu8mjSyUCb1snh6I461hGPnxl1xqKvCwyOm0D+9L9jdqfR+xxi7e5H/N
    AOdjsZFvEiVG2AgO/UmJQAzm5v9km6nFGKbU+4jlV/ICNoYsGXHOM1VuseeTh2FQ
    Yk6pgUvN0ZbSC8bUAQvOdUCKSQ++EnKJDBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:from:date:message-id:subject
    :to:content-type:content-transfer-encoding:sender:list-id; s=
    fm2; t=1525358332; bh=7NrS0WQiJJKIaPwAmlfAEyiSijfs3TW1YkwCUsc+VO
    M=; b=nArD0+dFJ9tq6UtGxkqc7YuZg7F3i84T+Sg/9C6Z/CGcdlj5EQoCK2/ROT
    gW63iUGC+ijHEbPsLBN0idIpsDRgYJ9NGwLwyeY2jmvt9I5aegWSHxpZ/2btxbb5
    C5d4kbr/zOpBqNJnoxuUwzBdnSvHgHsiwqaF45Ycf7KUEZYnHN6jVST/AtpWuP2m
    NdtfItaDOjvlLtpB2YYsJZTuZoZW9Gcw6oJPfOTwu2V8A09ChwKyu5LbXId1wzQY
    mmGLHgjuKcSW29GTWj7rSwiNjWttYJFw8nPq9A7u+T+fJ4gvPZ2C3dbun2gxiTcF
    9uwrfIS3+lQMInQB6giZK/e7AD6Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=sjbxc84Z x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=XbrawN0N;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=sjbxc84Z x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=XbrawN0N;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM/jmdcIlaaRkdIxTHWQPlkq7XkjKDE376+I8v8iF26DwRZX0fE4dhJn3mxUCW3qa9RKkGabsrFxYioy1atQXOkvxwYb+5z4bAPZZ59BwQGIgp5sn88F
    y6IpfuWXz0LdmKo403bvza2PyNGpgGC2Qg7HGl0Q0FE2zQ0IzQcC/s2QygSA20S4jzGhtRuqlQwUPQy3M2MQs/gBjIJMOsnxApJBEXUhy7BaGzM7WH9MUK2D
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=a7Dl5lcatpwA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=2IW-HXrCvLMUAcbykhUA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751079AbeECOiu (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 10:38:50 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:39795 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbeECOiu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 May 2018 10:38:50 -0400
X-Google-Smtp-Source: AB8JxZrvEraRvY9d0koJT3XpuQwhDBeo5IfSNeslwSa3H0WEfOL+yeYF+3yzYU3u3JBQ5rbaEoiC7Gg1npt+LopFjRk=
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Thu, 3 May 2018 20:08:48 +0530
Message-ID: <CAHhAz+iPbNjeHH72Omi7VCUVL_cOUnQjrqbyJKQstUSL6J1hCw@mail.gmail.com>
Subject: serial: start_tx & buffer handling
To: linux-serial <linux-serial@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi All,

I=E2=80=99m trying to understand how user mode buffer is written to low lev=
el
serial hardware registers.

For this I read the kernel code and I came to know that from user mode
write() API lands into kernel=E2=80=99s tty_write() ("drivers/tty/tty_io.c"=
)
and then it calls a uart_write() ("drivers/tty/serial/serial_core.c").

In uart_write(), the buffer is copied to circ_buf and then it calls
low level serial hardware driver=E2=80=99s start_tx() (struct uart_ops
.start_tx). But here I could not find how the buffer kept in circ_buf
is copied to serial port=E2=80=99s TX_FIFO registers?



Can someone take a moment to explain me on this?



--=20
Thanks,
Sekhar

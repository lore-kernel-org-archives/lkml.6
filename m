Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3038698-1522677700-2-14392564196720026548
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522677699; b=hPYnkVN7pLqpFihd0fJXvwXGQWTfL6d3zl4j09ZXPPp/r3khlE
    PwyuHwWt1mA+Y5Q+NjDSfXcv/wv1TQrSWkVQ2kFstawL+TtXvDLZLnEg6eOdX0H2
    P9VNfWRAdr36cMJ49/TgbSWFOdA9Wf0411+ZWKfOjcmsTWlhi3pAzTkU6puUpCVJ
    fKh9d/f5oU9WQlO4txDS9tHkNgjTnaqQtJDjU7WVy0iJLm35md2k9DnXpM9T4mBM
    liU7XUV2JkOvVWDoJl+rZZBCu/Zf8o0wwoyhxcUnBCb8ORQ7Ifr8/Zl5nAbY9tej
    ntYqi8eMrJN7e6lizFyKiduie4ELzLzhXidA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522677699; bh=2KwOv42KxC53DWFwOaaL4G35uO0kNSVUf1jkLnCBWz
    4=; b=HSpJhxylOxJZ59qol1+shV+3a7KixFLJNZllCOuGKZqWpoTdnggKig6i5o
    sgoJfbJUh3OAXijmcGpA7eOxCqiL8sg8ihBo1+9WdA9DUbTkQDnt1d3bzUPHKTRN
    +BGq+Rqw6IIvCCUD5pYUj4fsypgm8yB4KkwA5c7u9ypXW3rnXjByrTsdq3PIj3r+
    Gsax3daAAAhWgtrSViQoOAZUsTU7Hul8KRor2kMp+/6g3tbQNyYcAoPk4Gj52Tn8
    bFz+v8oE+plTyg8SptJT/sOCdVr9yG0Onb9aV3qxXk78rF+vonP7A0B7JemVI94v
    EeyM+AhuFR2XxeCOHGb1ECNheiww==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=d7GBkAu3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H7f8diuh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=d7GBkAu3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H7f8diuh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFqtRn+lNpQA8ODht12C75q0JZ5saVvwtY2Id1ilxH+luKrSEIw3Cv+Qne9JcM4Pp70vvEiQ2n8dkNAeV5Jvj44M+a/Lt45Jn1EnqPzjvaw2+rs5WTL0
    oU2T1roLzWqtutyGTh7Yp1iAGT42u8YiCk0mMZkTdg6oDiHNTrBjUR0mvgPHEjtn9+7E+cLulcW5D5F/NT0pKvN3D74IGr/TX5Vn9oU+gvYHTzFxG/h2a4BL
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=fbV3Th2LUxsA:10 a=Kd1tUaAdevIA:10 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8
    a=_3iAN5dmJPxjh_Nw_akA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=aeg5Gbbo78KNqacMgKqU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750879AbeDBOBZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 10:01:25 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:45030 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbeDBOBY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 Apr 2018 10:01:24 -0400
X-Google-Smtp-Source: AIpwx4+4u6mLZKRD68V5T5OVj6CyhPbIOMJnmCpI+xft6bLJPZv6vEzAnrX5VaPa3qvyVFcbhuP0jDaey9y1+fJ+uRg=
MIME-Version: 1.0
In-Reply-To: <20180402122037.2710-1-vigneshr@ti.com>
References: <20180402122037.2710-1-vigneshr@ti.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 2 Apr 2018 17:01:22 +0300
Message-ID: <CAHp75VdKxsAb4ect_no0g8N2+DQ_OoitWKM8ZH6ao-sfD5dekw@mail.gmail.com>
Subject: Re: [PATCH v2] serial: 8250: omap: Provide ability to enable/disable
 UART as wakeup source
To: Vignesh R <vigneshr@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Tony Lindgren <tony@atomide.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 2, 2018 at 3:20 PM, Vignesh R <vigneshr@ti.com> wrote:

> +       pm_runtime_get_sync(dev);

> +       if (!device_may_wakeup(dev))
> +               priv->wer = 0;

Can it be

priv->wer = device_may_wakeup(dev);

?

> +       serial_out(up, UART_OMAP_WER, priv->wer);
> +       pm_runtime_mark_last_busy(dev);
> +       pm_runtime_put_autosuspend(dev);

-- 
With Best Regards,
Andy Shevchenko

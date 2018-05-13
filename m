Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3110487-1526221430-2-14155520810645796179
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526221430; b=S5qQ/hwpAKO4myv71mxwL+cmSY9EwqzPoRMI+M+RqKKDo9Wyeh
    KGLklqfHY6hmRzCYcrEwi0MQudNr/pq2+4P5mXRN+zCrCENhtJfDrXKHNG9SInWa
    GB2chCfEaDk20ljfI279AqtH9Eq01Ni21dOm1iOxNKC2v6OjdE5i0TrYvtMRGd/G
    0CgS+sFhms9QGlP0O4N+QKdCq7Tn1xO5sEbfI5FsRO8wy5OSlQG9L3Z+IxNHziOA
    gXRYCh+2dhFBGOCu+JQaQnuwsmfWIbWRZb08HTtF154+uYkmg8Mo7cDcyiDIKkrP
    slL0lZYxZGdz23ZxzA0heLE45DxBSTX4kvVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526221430;
    bh=m2VYjz75DJ27rAQRT+vSxwHB1Ko+5reEQZdYS9cDsBQ=; b=W2Lb1lYXUhaT
    fEIKN5HfWSSWDKpdgprDr7ySQuHPlRcsteztGMf9ezADooUZ7xzRTbRyA3LzCfeV
    PXxWCaz/pPAl1nR8ierPzK8N83SZKIp5q/z7G+l3FXscJPPdO0jPqe0uwlm2gE4n
    h2+eqYi1zAuPXOkTdjdlKn3n+I/a0+YBhd3lS301IRBhM+Xs2xO/nkNQrVionXmo
    uaGRU4hReYqLy3BwT9fVXcgZ6v4CnD7Ih96us7IJKgvLwNLRlsjDZND5qaADdtvU
    /vNAD1JNrKE2/yF6052atPd2Gq5V9mZZ5TTCGb60Q7ygM3JefMY/JyeB7/32zdPO
    HNw7g///bQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=hU6g18w5 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=ZUq6ALHb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=hU6g18w5 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=ZUq6ALHb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHtpvsjUPk5Xr40TD2M2AkuMxQVEVJCckw18kHtoM+AJwIGifSLveFRa49iZM2QKNH+DZ8huz3fYuQEZo4g4d7AnCNK2RYQNqcRL4lkoORs5MgqC789d
    C8AQfOEbE4UeACLtmV9W2PEa+NHTYSJtsT8X/kxXPoDcGKg5/JNJ/dR/oMLn4KxvjzAHo0X0A2brwllui3LP9HO0x0Ac+5RICVGpA81ECdimjLvaZyFOfEb+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=fbV3Th2LUxsA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=NyIZytD5itbcn0iuYDkA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbeEMOXh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 13 May 2018 10:23:37 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36778 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeEMOXf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 13 May 2018 10:23:35 -0400
X-Google-Smtp-Source: AB8JxZrU9FJJjusVblOMp4x4aZtO3nn8GIQy0m7c2b+V8TfDUFrx6wPoLbJqt7JNEJ7Bt0T6Am0CRvM8ZpvXshJ1Glw=
MIME-Version: 1.0
In-Reply-To: <20180508100543.12559-4-u.kleine-koenig@pengutronix.de>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de> <20180508100543.12559-4-u.kleine-koenig@pengutronix.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 13 May 2018 17:23:34 +0300
Message-ID: <CAHp75Vf0RmAU8Qvk13JkFJob95pBEv27o4k8FVKo+0vs-SxYRg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] tty: implement led triggers
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        linux-can@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 8, 2018 at 1:05 PM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> The rx trigger fires when data is pushed to the ldisc by the driver. This
> is a bit later than the actual receiving of data but has the nice benefit
> that it doesn't need adaption for each driver and isn't in the hot path.
>
> Similarly the tx trigger fires when data was copied from userspace and is
> given to the ldisc.

>  #include <uapi/linux/tty.h>
>  #include <linux/rwsem.h>
>  #include <linux/llist.h>
> +#include <linux/leds.h>

Even for unordered lists of inclusions I would still try to put new
lines in "somehow" ordered positions.
For example here, I would rather put it before llist.h.

--=20
With Best Regards,
Andy Shevchenko

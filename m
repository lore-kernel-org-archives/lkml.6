Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2004258-1526160668-2-13469985664483201675
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
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526160668; b=lEQ3UddZ7DL8muCwgF7AvU2o/w55cXlJ2wd/X+l/DaF8fKPJer
    3L1Ub4eXvGTQBjIxau/UNLSO+qpJbetXWGziLCFz3LaWaxAOSmqYmgRXBwt/bXcw
    YTKmo+kP1XS5svGdAPRzoVp/9l0c98VoQIHgMIXVJTZDLWexdz9yab/UZ6YlDwbY
    LfqvBU2IrbVVEvHTf8d3kJ0pUZkll1Y/QHSCYiSLoYnKjuANNdehgLtqxzWgSuCc
    OPVFtThk6i3+ej3Ajfp8+eIqsEJA6imnjh/U1Twsuj5Ox7QcCiF26TfO8AVZXIj2
    4dtJQnvVCmgklXcL6Rt45+lVBdEfYbsvYFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526160668; bh=B7jym5mEpTDFVPxsemW2x4JLVfFYSS8atEuj/L2l7n
    k=; b=A9C1JATeC05ZAU9YJGb9e3+Jhek7piEQRFwwK4ep5D0Jx1bOyNRldDH05i
    WuQl3pGRh7ZRiSIKmBt5nzYs0xKYyxg1rvCN7i3MaPmlnpfIkLemcGZ03Ua9e/WB
    vXw90neRi8hZnGWGLb1UwBauMVY2Ryfu6+vJmJ/3DuMwx0+TXjWU3KJdG0/GNPk+
    gfkYMHV99zEcUWAhAisS/iaQSm7rLYqsg0F1mr1fnn5giCiVQn1k/y5J2GRW9s1k
    JaXXEGcgsZfF3Bz7V9Ky4yo2b4GkaSKAg3u9aMtcFAxXrhfSDwnuLLVq6W19hodI
    pOWiRANq45hrFFYo4Jeqv+v1d4vQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=GqP25dqg x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=DpQS8Tyu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=GqP25dqg x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=DpQS8Tyu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEgyTFWTcAcCVn0b6VGhobGsecHXqpv35/YuiwaHbjLaEqY1BJVoZqHLBWYz6XyUIx23G7yMJkhlI+1FmyNucsi+Lkah7Zl0xynYZ5hxktg8JqZ9GT1P
    XW8bWMNLGnGP1hu1ADCjOg+zlrqUYMmjALaB/0kvBqMxlbych+w/YODwMcho9ocvbadykH58SyoU1iX4ka5szZWYXUmqQDQCIEQ76r3Mz779bl9sR8XZj4om
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=fbV3Th2LUxsA:10 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
    a=YCsKcNg7XQxfbLuP8B4A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeELVax (ORCPT <rfc822;greg@kroah.com>);
        Sat, 12 May 2018 17:30:53 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:36340 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeELVaw (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sat, 12 May 2018 17:30:52 -0400
X-Google-Smtp-Source: AB8JxZrshDe4bLhkpiEYWo7ZuH2JnGnQGp8Edh0gDnkE+O8XIpqMgkagTUgCsKqpba8cwDEyblvssGjxYlkMHCZKNfs=
MIME-Version: 1.0
In-Reply-To: <20180511131838.62064-6-heikki.krogerus@linux.intel.com>
References: <20180511131838.62064-1-heikki.krogerus@linux.intel.com> <20180511131838.62064-6-heikki.krogerus@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 13 May 2018 00:30:51 +0300
Message-ID: <CAHp75VfFPiWM8LRwmXU-jugouBWStTnQBqU=FyyPP2s9dnY97g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/5] usb: typec: tcpm: Support for Alternate Modes
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 4:18 PM, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> This adds more complete handling of VDMs and registration of
> partner alternate modes, and introduces callbacks for
> alternate mode operations.
>
> Only DFP role is supported for now.

> +       for (i = 0; i < cnt; i++)
> +               p[i] = le32_to_cpu(payload[i]);

I would recommend to consider to use le32_to_cpu_array().

Though, actually we have slightly different API for BE and LE cases.
For LE existing would be renamed to rather le32_to_cpus_array() and
establishing the former one in the similar way how be32_to_cpu_array()
is implemented.


-- 
With Best Regards,
Andy Shevchenko

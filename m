Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1146574-1526319516-2-3913346799681729977
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526319515; b=a5rZzBPdPewcq9JmOh3L/1kjYFiqRC9Vy9+Vd0uS66Xysw550i
    iK//RSmYYAlTFvyYNN3sOVmwAfXQQZPZa8zU7e6XnApzLVs5Yoz1j5ZDF5J2dktF
    S4ochRFZjZPGuFysAc6+LLbDuPxNqsl217A9/iNQQn7lE2YKBZbR2krUBiULUSTx
    ftTN6HKXHmNz1uVSt35yX1WlL+UFYsrzVGLq7e1OeuoSDitSNwMlDYONC8Y5rf0v
    2o8c3ydxl8eKhoXeW+dfb0aSL+qfaa6t8nrU6UaW1raO7lSQFxUq/a8FNT9rK/Qs
    TWuBWODIpNJY/T00SDxfQPg/kqUYiQriq2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:content-type:sender:list-id; s=fm2;
    t=1526319515; bh=AWxEG/jxqDPFdCgll+ehGoCwQEPRspMYwgzinUBsWeQ=; b=
    DRgIFVyvn9vdcZ090CveJg5ldlfbLQVh4vls/eb47tWFk/Vz6jVIDSsV5xj0AQH5
    4UHsI+o6MuJjpwDDjZ13Y8j0epw2ytQax+anY3FcuQnUwJT8e5L2+gZgEGSp2+7+
    5Je+ELVmJ4h2aA2eT3Y9W76Gzpk98tOyi+O4GIwFZBWmyk6EWRlQpR3SlDco7YRf
    MLk3rSn+2inWhKoGatm4QmYBloYFxByQPdZoWSYi3OzF9pm5sPj50yujzC+AOJb3
    KOIgp/ZhgNM+o3A5uBRjzWIMheY6AXuo5Ubdq7kW4m5SpjhIxVcodJ542y46GlCK
    K+/Xbq8HMm0HlLG9uz3/Dg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=F+GC//gk x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=uJynJ2gr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=F+GC//gk x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=uJynJ2gr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIi8Qp7mrU3qNkwxI4gJQPKASZ/1hkD+YPVHvgXaAnDVGz+Yru0098nzjfBYv+dD2DSnrVAfZ4lyORTUQnGVJLyY46anEL0TNMXDfuoga9xb7MqTaS0b
    eokYEp/bdnUMXpDK93v6wj30hTlmEZY9vul8JY7jgM7KNug938VvENe/eaKzTOboUiwb2AenMfHtcx4aIIOFQT5D4Rbz2gHzQsPHxEv27i8nxIANdywBMuSU
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=fbV3Th2LUxsA:10 a=VUJBJC2UJ8kA:10 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8
    a=RJgyJ46LSXrSVv4BQd0A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbeENRiT (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 13:38:19 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34064 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753240AbeENRiQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 May 2018 13:38:16 -0400
X-Google-Smtp-Source: AB8JxZrwzd7uAhiIBprHB/p69kSEhaVNvwbgN8C21g5Q3cQlKY0GN/P0+2dKnfi4+K9SJMtukeXjVawtra7AtYzJ1HI=
MIME-Version: 1.0
In-Reply-To: <5a3930b867cf8c279953d08c5d5dd1d93113a43b.camel@microchip.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-6-radu.pirea@microchip.com> <CAHp75Ve3Ugnjjm8EZkPQTZSvH1qad1e5SqjOn8zz5syHSQea_g@mail.gmail.com>
 <5a3930b867cf8c279953d08c5d5dd1d93113a43b.camel@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 May 2018 20:38:15 +0300
Message-ID: <CAHp75VdRrL25Jgnbk64Qqc5RY3uJdcntJ3xwRdp3F+rRFeTHBA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
To: Radu Pirea <radu.pirea@microchip.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        alexandre.belloni@bootlin.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

First of all, do not remove mailing lists from Cc and people if you
are not sure they do not need your stuff.

On Mon, May 14, 2018 at 11:11 AM, Radu Pirea <radu.pirea@microchip.com> wrote:
> On Sun, 2018-05-13 at 16:33 +0300, Andy Shevchenko wrote:
>> On Fri, May 11, 2018 at 1:38 PM, Radu Pirea <radu.pirea@microchip.com
>> > wrote:

>> > +static void at91_usart_spi_cleanup(struct spi_device *spi)
>> > +{
>> > +       struct at91_usart_spi_device *ausd = spi->controller_state;
>> > +
>> > +       if (!ausd)
>> > +               return;
>>
>> Is it even possible?
> Theoretically yes.

I would like to know real circumstances when it might happen.

>>
>> Anyway the code below will work fine even if it's the case.
>>
>> > +
>> > +       spi->controller_state = NULL;
>> > +       kfree(ausd);
>> > +}

>> The question is, why you didn't utilize what SPI core provides you?
> I tried, but it did not work the way I expected.

So, what is not going as expected in "SPI core takes care of CSs" case?
Did you use oscilloscope for that?

-- 
With Best Regards,
Andy Shevchenko

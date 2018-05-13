Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3087289-1526218525-2-8597912929798631191
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
    1526218524; b=UNb66+nesv7yVXBqk9Z7hzRFZwWwQOSjJlU8qMNQqX78S9XCP6
    c1/9BYiRovHftZBT1yNZoZ8Tzu5mDrsZ/SvLjRgN9Eui+Y5kzL0i7RE++kq2tLe8
    tt+mAeTpkYW2q3C+aKlK36ptWHs4kSBzQby1A9blySnbzpw0BXkZ3wV1XmN5vhq5
    0u47NN4bL8N2S796mOMlT9FhViQ5ZO5I2Go2j38mGQCF6xpJTLKktP7DVqOV6Hj7
    Eost6eFRs1E509+B8TRlplk/ouF5Ei4wZud5sTu4GBvsyaLo7ok65DzKTld7WK9q
    vm6xlK0gU4VCVYArFdtNgelIRrR2YwbRpSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526218524; bh=ExE1OMZpzhXG87Zzk/ieNAalEd3WP+Lq1CYO2dZO8f
    I=; b=h/rprBlEhHjaULVuHMsOd3rCGaMKeHrua+MYiGy3sFJ1nLvuGCktdrO3Kv
    jf/Z+Y3bKwAJVM4uDt2vpx81+PYcplOp3kNze8faEdwvuoMBrYK2tsqVshWM093t
    wHGvO11+kn3CVne2UXdUvvcrYc+egdIjtLoo9f01M7qPpZFjzdf2cNAG7N0NcPsI
    f4JFPboI7/IJ+THpT+y7AjOcULUmYpswaru9iape0/mzmTa6p2HrrKPx4i1OgXHR
    UiPVF0nGyb3Nr0dAJ+RbzvwI6BpKi/3KYK0bSRENFDXpkHKy6cOj68/eBAIu29qg
    XlFBPcsptpY+MmUjSvj9Pwbei2ZA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=I3AVZ9oI x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Ns+lbyA0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=I3AVZ9oI x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Ns+lbyA0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD4FDihstBGuNdZtB6Ur5vNlHwJv25NagBoK0AQGJICCXdIECD9rm6J3Qfo6ryN9dL5nGVJfq7g9rMgr4UC7JIKFDd/HD0exRUxpI0kY3Th6G/9ScIKo
    fvXV/dtG+HNvKV9EBaHymtxyWXQuu13V655lnmPIR+eOLOPxD3IvSkOjWsJfXVl0BIPefrAh4l9rOfU9mrhFANMpcpTMVqwdcMlNlDtz2gokR7WxdIvxxpB9
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=fbV3Th2LUxsA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=F1CvVM0FvlPrrZ5dkBkA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeEMNfL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 13 May 2018 09:35:11 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:39173 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeEMNfK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 13 May 2018 09:35:10 -0400
X-Google-Smtp-Source: AB8JxZqedX8i7RB1rw3TnCZbV7FL53XXfsXpUAmAHSl6rCLlQciOg6nzTNjDAuwAm98Dx3F35rtoqsifSSOEhcvdHFs=
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve3Ugnjjm8EZkPQTZSvH1qad1e5SqjOn8zz5syHSQea_g@mail.gmail.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-6-radu.pirea@microchip.com> <CAHp75Ve3Ugnjjm8EZkPQTZSvH1qad1e5SqjOn8zz5syHSQea_g@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 13 May 2018 16:35:08 +0300
Message-ID: <CAHp75VedMWUkEmGqPVV6zuJJdTiZz+S6RXHFqPGtsntpsHOVmg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
To: Radu Pirea <radu.pirea@microchip.com>
Cc: devicetree <devicetree@vger.kernel.org>,
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

> I will refer to above as (1) later on.

> The question is, why you didn't utilize what SPI core provides you?

Here I should have referred to (1).

-- 
With Best Regards,
Andy Shevchenko

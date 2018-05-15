Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1994332-1526365789-2-5725572967820794719
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526365788; b=dBahEpNdrD0DimUAcNDyfhIAL3LxAhnc+Ut13L4PYSd+0fI2Cb
    ChZLaneiZFcCIE94/qrOyBcc//2Ft52QE+ArDLMKlmaebqWyBpWkMlRSQLQPMLsz
    5EFUP+FQwAPrXJ/DWwsU3cOYuesKlbXRQikQ7LgctmTbKN2tlJpczFOHQJIL9WIN
    yI147LEjn4SaZrS/HVe1OTLQ+9+ue1r5HYjrKuvVx3LD//NeY/Z3XeXmjVTUNjKz
    qX5eU/sB2uDJFROlZd8PwccfnToYJNVkmhHWj26s06SUTTP/qsaFZrqtBvSVhC5D
    7sitDvNnh9VaZgqiJFvctuEDQ+i/8OLKSy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526365788;
    bh=8lJkWV2oHMbhmNo0RM6UbghAt1L55McN+Jd4Wfze2mw=; b=P10Uibn9b7Qd
    9CIBKWaVfgjLPAwojJOGtmA7EaQjVNpHDtmqmDzA1ZCfUTkfrOOv6J+RjeMFMhWJ
    lBck/VeIIVZ/4P23/ZpyXTn9ljDwfnBexuOFfo0mpmb+V27e9MG3a3dcxPn8XAnd
    jX7rxUMdOC42Y4bCd0240RKu0fRF1aht3e4xORXlp8/alWlmdYE7asf2oQ0yKdR4
    8SfJRPHAQ9xn6EhkFd0WDHTuJaDEXm6ElVIpqqalq9OI1Kac5HCwhNVp5uK6RdFq
    52UkoFtDQJoTqiOkZS75745sRNtl9BF/K6DHm7ifClm+Do0tizKGpnjYoEcbBSB+
    VeIO7NO4bg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfACqZkmASv0+EzFBMCxJVOHEHfdZZ6wxjlZ/4g540A9Le9gcWarKCqyFHSXoOihtJuaxVi5uH/mcJbR7gMJKTeVUgIgmReZ4Po6g8EJGhK3NNlLJsSFy
    2ar+t8mdj1XsmJrx4Okbg0qI2epNKme086eMHssSvUGXo5+2nnXsqi8Gb3kvLowO9CXQEXVezc91qynoH/0foqAYL3BNHRcpGdrjJ94TL5JT2rVwoSK2XcY7
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=dXFxZaXSprYA:10 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=pzuvCT8-ob-W8OYQKBgA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeEOG3J (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 02:29:09 -0400
Received: from mout01.posteo.de ([185.67.36.141]:55729 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752246AbeEOG3H (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 May 2018 02:29:07 -0400
Subject: Re: [PATCH v3 6/6] tty/serial: atmel: changed the driver to work
 under at91-usart mfd
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Radu Pirea <radu.pirea@microchip.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, alexandre.belloni@bootlin.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-7-radu.pirea@microchip.com>
 <4a75568e-a52e-3872-f465-d707372a5c12@sorico.fr>
 <CAHp75Vdcd0MmqCMGkFXcvKLrzcHtxBDcB8U1qTzysaH9By4Y8A@mail.gmail.com>
From: Richard Genoud <richard.genoud@gmail.com>
Message-ID: <f3caeaf5-a61b-bf28-2d4e-0dd4a76224c2@sorico.fr>
Date: Tue, 15 May 2018 08:28:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vdcd0MmqCMGkFXcvKLrzcHtxBDcB8U1qTzysaH9By4Y8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14/05/2018 18:56, Andy Shevchenko wrote:
> On Mon, May 14, 2018 at 1:57 PM, Richard Genoud
> <richard.genoud@gmail.com> wrote:
>> On 11/05/2018 12:38, Radu Pirea wrote:
>>> This patch modifies the place where resources and device tree properties
>>> are searched.
> 
>> I think it may be simpler with something like:
> 
>> +       int size = mfd_pdev->resource[0].end - mfd_pdev->resource[0].start + 1;
> 
> Isn't resource_size() macro for this very purpose?
Indeed.
+       int size = resource_size(mfd_pdev->resource);
would be even simpler !

> 
>>> +     int size = to_platform_device(pdev->dev.parent)->resource[0].end -
>>> +             to_platform_device(pdev->dev.parent)->resource[0].start + 1;
>>>
>> ditto
> 
> Ditto.
> 

Thanks !

Richard.

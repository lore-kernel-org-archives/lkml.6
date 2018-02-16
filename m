Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4118280-1518780121-2-8300396377476793186
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518780121; b=PqqeH4xR5KBFf0bMtYWS0Mh+8Wse+WqPjw6nsjEf093mdOE
    kXho05UdGYSmN74cHgLvuAFu9CM0SS3vRRrmkifn6HqEgrL5CLmetQMhhdH0R9NE
    1YpID19a+8BMzVvn89X5pt8EdUSO0Vs7t7fxZBjG0uo3HDmr328h1NATTZNujwFG
    pMrTQ+xTZUh3Bm0cqtnrjilFbx+SO5ID5cyIffFp9hiKUygSFxi+7vhGrtg9yuat
    AWdHsQfdFLz56K70LvN1Esh6NpU1gODCzK3O3cdQQata4Qwowmq6Pj+XwC9Enajy
    CU7Df/B9M9HoOgRJYo/xFvwf72VzZpfQwkreCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518780121; bh=UO+sqM/PuawEOsdSQ/30j3mZAU/b8YaIBpMmb0kPUTs=; b=I
    WwdnPK/V+vizHXq0fUy/8Rv6AAseD6Es5G+Clhb0CwljwnU2zRo+pMdapURyoVqq
    2xWz0zXyMKoAMYpjVBUInZ6krUKBMexMkFaYz+v6iElcgNOjdZn++wino98wISG8
    9lT+XV2dmNTz1O3U/UI5lKuFOa0e4rIzrOlIdnDdHygcoIEPohnXVpetGzXmDpxF
    2J3DzuJhrGOMKNwnQpQ3feg7CV8gacTgNcG+r6bbpfrcZz0z/7Dg/sjiXghmqLci
    fpSLLWTWELLR8L+AhTbhmpWw7cOeuBwZXwnzDmRhNZ8vO74F+clBNeMUhlTvEEOD
    WeSoqb8hkiirhMqYEZMBQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rM6ZlEyp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rM6ZlEyp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935502AbeBPLVq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 06:21:46 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55188 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935495AbeBPLVp (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Feb 2018 06:21:45 -0500
X-Google-Smtp-Source: AH8x225UdB8YQPp5Bxp/zoaqWkm66fWmAfEFyEsDT5xRkLkRcPwumnKTKK2fLSxrVHQKu9C0FkakAQ==
Subject: Re: [PATCH 02/12] usb: typec: Start using ERR_PTR
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-3-hdegoede@redhat.com>
 <CAHp75VfRX3sPKS8Fbt-5cRskRg=75XYfnE7UYLO5c37iUvkgWg@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <c0b2929e-ca14-3341-6e47-57f6fe49d4e6@redhat.com>
Date: Fri, 16 Feb 2018 12:21:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfRX3sPKS8Fbt-5cRskRg=75XYfnE7UYLO5c37iUvkgWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 16-02-18 12:07, Andy Shevchenko wrote:
> On Fri, Feb 16, 2018 at 12:47 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>
>> In order to allow the USB Type-C Class driver take care of
>> things like muxes and other possible dependencies for the
>> port drivers, returning ERR_PTR instead of NULL from the
>> registration functions in case of failure.
>>
>> The reason for taking over control of the muxes for example
>> is because handling them in the port drivers would be just
>> boilerplate.
> 
>>   void typec_unregister_altmode(struct typec_altmode *alt)
>>   {
>> -       if (alt)
>> -               device_unregister(&alt->dev);
>> +       device_unregister(&alt->dev);
>>   }
> 
> But it's a pattern to guarantee that unregister type of functions are
> NULL (or ERR_PTR) aware.

Agreed this needs an if (!IS_ERR_OR_NULL()), will fix for v2.

Regards,

Hans

> 
> 
>>   void typec_unregister_partner(struct typec_partner *partner)
>>   {
>> -       if (partner)
>> -               device_unregister(&partner->dev);
>> +       device_unregister(&partner->dev);
>>   }
> 
> Ditto.
> 

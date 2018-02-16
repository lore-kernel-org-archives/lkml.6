Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4112161-1518779262-2-12525449415059312739
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518779262; b=SYoENOz2t+WLp+eoBVj4VDhaBwd7fmlIStTQYEItY8LgHK0
    Tjrh26Raf+BgQEods3/JpzbMYSAEuVytnfUBf5t7AAc86Ix5LQs8R4Tpg/OAcPel
    Dn0kcW71foz1Tn90zVfSZzc9TZXCS0rS7fcO43sFzSL384yopRHtGpDXo7MfnTcZ
    boq30x7I20r6sDv04KOzpr11DM2jmOwULSZGEsFl+vIi/LepAwkf7KPpAByM0BYD
    m58FSlwg9x8u/CEMSHYjOgqXwi6T9X+8xjuhjNlqKx7UF+gkkuFvOCs6j9STaABA
    o0nBcfFUxUFtn+GzobvNfX5ooVs/1od5cYorCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518779262; bh=urlLXaXxUJlKgnHov5xBrNTmwkiqWqmUWk6/VZ
    MIab8=; b=WejvW2uwxQ6SaZx6Z8W8pN0yAobaaIC2XYzp4prEzCLRFpQ7bJVH+a
    faErhBR891qPY23HCW/V6t9zvDTyuByfZFXEwacJ/Kw199OZclFgxne/XLZ/lGvX
    B3/i8kFqFruyQS8bG1hwGlRMXXV3p9qZqfuS323Yl1HIzLD0Zy3pha4gVYF+7woa
    kJ2J0dDl9zR21MWe5hDH+pphO2bJ3s7vIVphbAZD++ieSGBa3mCU7A2EBZv5XQsX
    B0kAwhDkCzr7iIU5dr1Vc2jZoHmVnMuCLJoVbXrcouolBeNKeIOVl6Qjep09vih4
    P1MrSzy6DbsOaf/XJuq32LfGn1Ua8VzA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qEdN8d8c x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XhpD0Xio;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qEdN8d8c x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XhpD0Xio;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935250AbeBPLH1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 06:07:27 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:42508 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935119AbeBPLH0 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Feb 2018 06:07:26 -0500
X-Google-Smtp-Source: AH8x227yrbjFos4zrBj+gje0cfaIJyux+N3wNHm2W3RH5IENRfiIx2Oi8/f3jCzG/Mj2aet3LDoV/vbVR/ola6wzWuM=
MIME-Version: 1.0
In-Reply-To: <20180216104751.8371-3-hdegoede@redhat.com>
References: <20180216104751.8371-1-hdegoede@redhat.com> <20180216104751.8371-3-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 13:07:24 +0200
Message-ID: <CAHp75VfRX3sPKS8Fbt-5cRskRg=75XYfnE7UYLO5c37iUvkgWg@mail.gmail.com>
Subject: Re: [PATCH 02/12] usb: typec: Start using ERR_PTR
To: Hans de Goede <hdegoede@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 12:47 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> In order to allow the USB Type-C Class driver take care of
> things like muxes and other possible dependencies for the
> port drivers, returning ERR_PTR instead of NULL from the
> registration functions in case of failure.
>
> The reason for taking over control of the muxes for example
> is because handling them in the port drivers would be just
> boilerplate.

>  void typec_unregister_altmode(struct typec_altmode *alt)
>  {
> -       if (alt)
> -               device_unregister(&alt->dev);
> +       device_unregister(&alt->dev);
>  }

But it's a pattern to guarantee that unregister type of functions are
NULL (or ERR_PTR) aware.


>  void typec_unregister_partner(struct typec_partner *partner)
>  {
> -       if (partner)
> -               device_unregister(&partner->dev);
> +       device_unregister(&partner->dev);
>  }

Ditto.

-- 
With Best Regards,
Andy Shevchenko

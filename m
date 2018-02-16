Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-220077-1518789657-2-11028672037584079361
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
    t=1518789657; b=JZ8PH/EHgQx/kggKLcX+JB/Q5EdrDMCR6YdT1bDAfXhPzeB
    gnMUYovJrQnlgZIM6wEpKobypIeoCv6GCm6g+q1T0un9G0pMhCagUkB54NtaTYp1
    fih694rRsb9mGToi65YSmwhmLMvkSBgs3sVH5NOrpwETfiDrcm951MXtmwsgUuKs
    7ErVHruR3yCajMNaL4l4ybJ30jHruxmHWCQ0fjje7wJTmFiLl7hikEOrQlWr+D3k
    hIUojnLoGlXcjNl22HzpN0aN4EBT5tTRCIb2hQQ1nCn/1fq19ZOC3DndKicaSW+g
    RrU21e57UURS26cTuj4luaLR1m3k0EOj8BUQFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518789657; bh=1osl1jK+0dricvM4PKSLG7PCLLRoFxkWSyYpMy
    chbBs=; b=So81vXKTuBfJOkFAheUX6yptuvt4NmkJizlcuBOqlvJcueboVwNW7e
    oJmekuqLyWIzYNUX/x7a7rp3EIXrs06yaYjxZIpQ+8nXOI2GNbG8gmHbGR/BtPbM
    OL9QUsBJIqjRZBdt3XyY9UiHneC0rG0JJ9UPDzy53cWGhRAOqgfX60MK844bSHgD
    0juRhWfM+8oSfU2ZTPz1Fy7xVrdtfdYmqtDU79Rex99G8eLNhiLGz6I5+5NwmGMa
    y8UyypvRKuo0ux+6shxWUcruiRTnT/fmGRyvKPVMP+erdFMMZEEn4AYqSw5uWhhW
    N2qsBR+K10hvBAGdpYYT8VbvDclJGlxw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iV8jceBd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JDdcUu/t;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iV8jceBd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JDdcUu/t;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033250AbeBPOAg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 09:00:36 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:36252 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032862AbeBPOAe (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Feb 2018 09:00:34 -0500
X-Google-Smtp-Source: AH8x224K48UPKRygnbVDXNPLOI3/oz8SQ3VIdP4rf+WG/6e14Q33lgohk/Ajdo4dc/iXv7IfahlQWKiBAMa3sOxHV6M=
MIME-Version: 1.0
In-Reply-To: <20180216104751.8371-4-hdegoede@redhat.com>
References: <20180216104751.8371-1-hdegoede@redhat.com> <20180216104751.8371-4-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 16:00:32 +0200
Message-ID: <CAHp75VdaK_LdsNeb5XY0kcA7sqH9G8OyjSLs7WRSftK9Zs98GQ@mail.gmail.com>
Subject: Re: [PATCH 03/12] usb: typec: API for controlling USB Type-C Multiplexers
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
> USB Type-C connectors consist of various muxes and switches
> that route the pins on the connector to the right locations.
> The USB Type-C drivers need to be able to control the muxes,
> as they are the ones that know things like the cable plug
> orientation, and the current mode that was negotiated with
> the partner.
>
> This introduces a small API for registering and controlling
> cable plug orientation switches, and separate small API for
> registering and controlling pin multiplexer/demultiplexer
> switches that are needed with Accessory/Alternate Modes.

> +       sw = __device_find_connection(dev, "typec-switch", NULL,
> +                                     typec_switch_match);

Perhaps one line? (even if it takes ~83 characters)

-- 
With Best Regards,
Andy Shevchenko

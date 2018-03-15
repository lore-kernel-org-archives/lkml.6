Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-373521-1521123507-2-11387911038664076994
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521123500; b=RFAm3y8TVxiWF4A3IU+ExAgn/6GlXSINiORof2cw48kh9xh
    6lY3nNDznqTI5NEjF8xGgRKaU7ShArU/B0Zix4Lck+6iwUrRLScFtyPPrPcnO0oX
    n2HouCRE1DmryyYlXtS9RnicMOWybpgy/keQRKdtRyBi+/4hu292f8uu62cQ9G17
    1XD8P2O5CIcZFlwOU4xQh099D1aY1DFVaEsPiUdKmqH++Ahcw9/ueWtv9eMcZwBU
    +FQeEk3Nxa0vwzE7fDruAX57o7kODYKIKZGimAftiut1BZ2KhWwgjRKCpc6Oow3B
    Zu+4+keSOGd0mu2nL6flHveSOlYygIx2CtiMvQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:content-type:sender:list-id; s=
    arctest; t=1521123500; bh=AExJ63KHVFcY4fbT9YfgHOXEYvo9lRzdWd6mCG
    dRWzM=; b=iOI1816EOjTzBJowkqfMm7JlbwiT+RrgFZ8P86gpqDtqTNpyZ8JRWZ
    sE5J1OqsCcEe4DAaBaiex/LwJWBECyGdPAxFEkAaoiN3MJa1GVbGDQnQfz+OG+a2
    XTFUiO0LR9eQIrD/ycVZmOs2iebG7bz2KM+BGo7gBLRUcvcK31tSQps4i5lkI9nZ
    vtrmEPKK03GIdB80aHyFaeZ8ny2aRm1BmB9fXT2XhnzcTmnD3QlRahYC1WCld6Xr
    E1mTNNjpfmMoanG5gMBJUTscUIgc47INvrjpvYj4ZPAOb2KP1QBd5tmkrdnNql+T
    s1PkMHqZk8ueonyXX8zjLlncrCLNvKfQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mC/a9Y0U x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YPdgEeWJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mC/a9Y0U x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YPdgEeWJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeCOOSE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 10:18:04 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:32889 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbeCOOSB (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Mar 2018 10:18:01 -0400
X-Google-Smtp-Source: AG47ELvY55nTaR+0MJ8nJV+H79etWWOzfszbHIXfmDSyl2oo4ZoIfXYEEZmqpwxELtEurBdVNV1/gIFY2OtQ/ox+pXo=
MIME-Version: 1.0
In-Reply-To: <20180314171213.GO14921@uda0271908>
References: <20180314153603.3127932-1-arnd@arndb.de> <20180314153603.3127932-39-arnd@arndb.de>
 <20180314171213.GO14921@uda0271908>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 15:17:59 +0100
X-Google-Sender-Auth: VhT8lnDHb33qnMFN5VfeLuBgElI
Message-ID: <CAK8P3a382ai1hgQe5h3c_oi4nuhSJ=cB8h8oey4Ypa2dg=s9xw@mail.gmail.com>
Subject: Re: [PATCH 38/47] usb: musb: remove blackfin port
To: Bin Liu <b-liu@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 6:12 PM, Bin Liu <b-liu@ti.com> wrote:
> On Wed, Mar 14, 2018 at 04:35:51PM +0100, Arnd Bergmann wrote:

>> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
>> index 5506a9c03c1f..490990e8b015 100644
>> --- a/drivers/usb/musb/Kconfig
>> +++ b/drivers/usb/musb/Kconfig
>> @@ -18,9 +18,6 @@ config USB_MUSB_HDRC
>
> This config entry has "ADI" in its tristate message:
>
> config USB_MUSB_HDRC
>         tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, AW, ...)'
>
> so we might want to remove it along with the whole parentheses?
>
> -       tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, AW, ...)'
> +       tristate 'Inventra Highspeed Dual Role Controller'

Done.

> Other than this,
>
> Acked-by: Bin Liu <b-liu@ti.com>

Thanks!

       Arnd

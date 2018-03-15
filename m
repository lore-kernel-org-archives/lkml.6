Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4136612-1521110569-2-15903616252275818896
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
    t=1521110568; b=Z8eBs7K3jzSTU1CRh33KmO4oBZGlHye42BYRIUQOggGiyDn
    bLtzoPLebAG55w5FocPAbrvpbX+elAoDCwXm5IPdTPc4wGfOMX9DAVEY6kOsFynv
    Z3k9t6EIiMbrdz54wAH+w+HrSObUILLseQVSYk0/imOSEPyF3Dnyehtre21fr69h
    RLIa4M+E+kojlWKDcYFH6dOP+DayphVG4SB2iuBnveSdZblWJMlQ1O4A46Mu7hEL
    sI5AnQvhT2zBH0UdYKTmh8SaP7limERHqAFdmhleVu+PkFZVnZrHdTEG3RzXXnso
    UNhX3FoBwt5ZVIA9zr/mRG+ksrqttqQRuJH+XFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521110568; bh=xxmJDECnlWRDXyYr0+JAhMwttRiuiwO46K/DMn
    X2+wY=; b=eTnjTFmaCLCvZk/6Hd6SKOj6GKGlpWTVKyNse/ipddoW6JPR6lnhOx
    XkrZ/D0PpEafYnsEY6FtsTG66Amre1i9PBwPWUAXM4QOPLEWMRIt94/t/6DCrE1l
    16gWbC9W8DPFdtma5f3afOxMPqdnNMiYNUmqM8M5NJ/ru5NrNbq+F6JqpWLzWbqU
    8RGzZaYyorgsNuiLonDlV2XKKHQEXYpCufW5SoGdTpg31Wx1eobz93sxczT1gjhh
    PZu6mVVHCB+nmNJjk/yQwMV2ClL1b0u3lNG19uHbmXzRo+h9UJRGs7cNbcw5b3bg
    G7lEESGGINNXK8qotdvkkHvNc24kKlxg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=C0hxn5WZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=C19drKIQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=C0hxn5WZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=C19drKIQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeCOKme (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 06:42:34 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:42140 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751619AbeCOKm1 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Mar 2018 06:42:27 -0400
X-Google-Smtp-Source: AG47ELvDThOAhXeoopzNlhr7sk1wlJ5kaxI1y5vHP/frykFEwZXlZ6HbL8zYtn7A5GI1kw6nJFENblo9N0WTIwSGwBo=
MIME-Version: 1.0
In-Reply-To: <6c9d075c-d7a8-72a5-9b2d-af1feaa06c6c@suse.de>
References: <20180314143529.1456168-1-arnd@arndb.de> <2929.1521106970@warthog.procyon.org.uk>
 <6c9d075c-d7a8-72a5-9b2d-af1feaa06c6c@suse.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 11:42:25 +0100
X-Google-Sender-Auth: 8jLxCQUuti_PaQ_nVlrEsrtBKl4
Message-ID: <CAK8P3a01pfvsdM1mR8raU9dA7p4H-jRJz2Y8-+KEY76W_Mukpg@mail.gmail.com>
Subject: Re: [PATCH 00/16] remove eight obsolete architectures
To: Hannes Reinecke <hare@suse.de>
Cc: David Howells <dhowells@redhat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-spi <linux-spi@vger.kernel.org>, linux-usb@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 10:59 AM, Hannes Reinecke <hare@suse.de> wrote:
> On 03/15/2018 10:42 AM, David Howells wrote:
>> Do we have anything left that still implements NOMMU?
>>
> RISC-V ?
> (evil grin :-)

Is anyone producing a chip that includes enough of the Privileged ISA spec
to have things like system calls, but not the MMU parts?

I thought at least initially the kernel only supports hardware that has a rather
complete feature set.

       Arnd

Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-923211-1522742648-2-533160283736076687
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522742647; b=E787e8t1PbAGNF0cHZNEbOggrYrFjUY+qpG8dKxSGPZvnZQW7u
    U4PvIvURS1BVRmjhAau3b4nLXOfCThzZC1zjoG5CBdPbcQZUhhQ5ODdG9Nro/b0p
    eyvZ3qXVDLyiDPb5Jb8oGcBPSZ5rMAd6AxH2eIUqHWSN6wtyB0/V4DBkuRt6X23u
    pEZSrJ5ycYT2XFHhDSl1y+Y5hVPcLZVkZBePkjFjVfuFB5aCJmeUyERwcdp25rbK
    pqbI1FHAvo/yDnMXx+9WC4u4WQdbZXiNqRLn/q2GRKWHiXTApV+iIe0rxAch5QOv
    faq6hKGvj0ZEvn1nGuay6AlLoDuJaDBuz/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1522742647; bh=IKlhGABicXP
    I5JOZ0oGifbTmdMjEjeOYQEjBxcfU2QM=; b=ABOA5ddJiVePZqhUIEDdDyfWTR7
    3ae9D9qHmyVmDYYgaI77CTjY4LWeRe1x2Z+NBA8TmzFEzAi0HxPN5bjrOnM4bJ2G
    0o7rkskrToZoeONuyUyEjAWLOtpWg69u112EMZS3x+oUA2OdlSTlcJtlXleKyGev
    IKSece4FRgYBCfaclEdpnuVDsVKr5tKfc7MrUVyycZ/Mq/exwWCovcIfk+7zuX7K
    1ZfhZmRBtLiALFFQCujqUTGki1lUJCecNdG+pBuWcbofp5vF75qNdD+k4nffj3mu
    Haz+4ZELCmKsCKOfzRE3zUqGIrxIP4clhoAKdgtDD7iiE8/MquXxrLC4lvw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=U2cpeo8C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=t9VVQRmy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=U2cpeo8C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=t9VVQRmy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAID5rPSL3BYxnAodRW540GDFrt07iWqsyoZw1UW9JjlxZoJR3FTdDKlC4Y/XYgJuwMCjwnGu883FoSLnyoBlb3XmqiVlQgONTZHXFGST2ZWJKG9bXes
    +hdt8r7nYxfUj5Hu8yMcA2hJyNwBS4Z4XvSTzqZPfRvwdOu+8E9OTPg/mTshbyPSAlaU3Caq4lVnsmt1VsW7cj2zSSKre5H63hcK4lzwOLMYDThPClGRVGhR
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=D19gQVrFAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=X7uUlSlOYPvWXrwdy3QA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=W4TVW4IDbPiebHqcZpNg:22
    a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755180AbeDCIDp (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 04:03:45 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52416 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755176AbeDCIDm (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 3 Apr 2018 04:03:42 -0400
X-Google-Smtp-Source: AIpwx4+KQuTUYj2aytE9JieAj8G/RipHy0T1+KM7PfeJFfCg11Rz8eOH4jt6QZeR/hHM37gzDu+LGQ==
Date: Tue, 3 Apr 2018 09:03:35 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Question] MFD driver that handles clocks/resets and populates
 child nodes
Message-ID: <20180403080335.ksekhxwvbzbxhmln@dell>
References: <CAK7LNARFWDMgmWsCjUmVrm4ZeYOcKCbizijxmDXob618ABjNWg@mail.gmail.com>
 <20180402120414.GA8159@lunn.ch>
 <CAK7LNAQ6LKk3NtGLB8g07ocyvXidpTHsApeDuctvEHyyLvk2ew@mail.gmail.com>
 <20180402133219.GA10520@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180402133219.GA10520@lunn.ch>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 02 Apr 2018, Andrew Lunn wrote:

> On Mon, Apr 02, 2018 at 10:21:01PM +0900, Masahiro Yamada wrote:
> > 2018-04-02 21:04 GMT+09:00 Andrew Lunn <andrew@lunn.ch>:
> > >> The maintainer of DWC3, Felipe Balbi, requested to
> > >> split the glue layer driver into small parts such as
> > >> reset, regulator, phy, etc.
> > >
> > > What exactly did Felipe ask for? Did he ask that the patch be split
> > > up, one patch per reset, regulator, phy etc?
> > 
> > 
> > Yeah.  That is what we understood from his comments.
> > 
> > 
> > These are the feed-backs from him.
> > 
> > https://lkml.org/lkml/2018/1/23/298
> > https://lkml.org/lkml/2018/1/24/352
> 
> > > Are all these resources used just by the DWC3? Or is it a true MFD,
> > > multiple functions?
> > 
> > I do not think this is a real MFD.
> > 
> > This is a DWC3 glue layer, i.e.
> > a collection of misc registers that control
> > the DWC3 IP.
> > 
> > 
> > Just splitting it into small pieces
> > to use PHY, reset, regulator framework in Linux.
> > 
> > Of course, the price of this approach
> > is so cluttered Device Tree,
> > honestly I do not like it much.
> 
> This however the correct way to do this. You should have a phy driver,
> and a regulator driver, and a reset driver. The DWC3 then uses
> phandles to these drivers.
> 
> How is the IO map area 65b00000 split up. Can you cleanly separate it
> into sub areas, which do not overlap, so you have a sub-area for the
> PHY driver, a sub-area for the regulator driver and a sub-area for the
> reset area? If you can cleanly split it up, you don't need an MFD. If
> however the registers are in overlapping areas, you do need an
> MFD. The MFD core provides access to the registers, while its children
> implement PHY, reset, regulator etc.

This device certainly sounds like an MFD to me.

Can you share the DT you've written please?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

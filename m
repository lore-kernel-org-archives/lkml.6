Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3014039-1522675327-2-3736787053933788523
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522675327; b=VJPHHE2Ad2x5JOy3VM1RSDnoqX1ae9GlO33SfdToocc6US3RDB
    t2/AcwxS4JftGa6rLmwf/6x9CvqCkEgWjInCeTy/4XwiRQLjOQO766HlhCh7D5ch
    X+2bmvEAdZpqMuX3BLD23ISFC+zOT47y/+6MBepLHY5M1568D10TjySm91ouTLuY
    1ZnnnGxEdcWMpV+vJerpwcsgFF9hvm809D7XupKau9pMXJEeJT5fSzath8x9NcA7
    S7NmuyIRWEJ/4E1UbXBwyMpy7Oygbw44iWVUJABCL0MBtyGQMMQpP5Ai833P94Md
    7LpzkVZO8JeWuiIxVSDMxHlhClCVCCwVgEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522675327; bh=dRCnUus/NaNDEQTbEePAbmyAZGOcD/7MKUrboseNwQ
    s=; b=HhUnNX81DYzr9VIU+X0sIaD8EwLz5wsqV8Ffho0iPh8Vg53j4t+876UWgm
    maaS5Bn7upS/F+ZD5vhAnvYJKOPROpqfq/aqr5i9bD2cgVvuUd7WG5giBDCeDsE+
    JcjQXV7jf6Ehx98pTHTYld95vQEmgfCr2quA/JynkRtfI4M1h5K4smH1aW7bxvIz
    ZrPnzql0ByfKLvrBxZnvK1xPoWZKM6Hiv9GiDXLOuWxjrb3RoiI9N2nmI9RzFj3q
    uvZRlI8eHA4FaaYXscncc+ppXdHIW9Qlgy/oBRQjrmagcfKx8KWYaVV6Q9aVShUK
    PYUWgmLgsf1m0/CWqyu7B4QuTg3Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=pIXSmvc/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=pIXSmvc/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO7MSQIFexXqlWO0ObFep++66sk46Ph2PsTAd9qm882V9RXp5aMSLZp8VnmkKB8tkz722IjZrrxWKgatrpVObkfG8p2sbaLxz3EvkBRp2Dh9Y2Gb5m8K
    zPofpw3wQVd/qn1NNg633E64Uh4x2m60QD3Q+WirhvRMCmvB+iyf+jSS2iTW/hN6AZ1I79zlSmRtU0KrtxjmJ+Qiizd2/rX/hyxARuv9i3wBd8WkWGeDN8DL
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=HjgYR4YCvR_c9d8bpsQA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeDBNVx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 09:21:53 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:62560 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbeDBNVw (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 2 Apr 2018 09:21:52 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w32DLhf1028235
X-Nifty-SrcIP: [209.85.213.47]
X-Google-Smtp-Source: AIpwx4+zfCTXta1HTnJABZfrvzcASoUf94OGBxnTHhNic32FgNnsoLM7DFofMMOj3waIvJUjlEurY6UhLke7AN/28sU=
MIME-Version: 1.0
In-Reply-To: <20180402120414.GA8159@lunn.ch>
References: <CAK7LNARFWDMgmWsCjUmVrm4ZeYOcKCbizijxmDXob618ABjNWg@mail.gmail.com>
 <20180402120414.GA8159@lunn.ch>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 2 Apr 2018 22:21:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ6LKk3NtGLB8g07ocyvXidpTHsApeDuctvEHyyLvk2ew@mail.gmail.com>
Message-ID: <CAK7LNAQ6LKk3NtGLB8g07ocyvXidpTHsApeDuctvEHyyLvk2ew@mail.gmail.com>
Subject: Re: [Question] MFD driver that handles clocks/resets and populates
 child nodes
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-02 21:04 GMT+09:00 Andrew Lunn <andrew@lunn.ch>:
>> The maintainer of DWC3, Felipe Balbi, requested to
>> split the glue layer driver into small parts such as
>> reset, regulator, phy, etc.
>
> What exactly did Felipe ask for? Did he ask that the patch be split
> up, one patch per reset, regulator, phy etc?


Yeah.  That is what we understood from his comments.


These are the feed-backs from him.

https://lkml.org/lkml/2018/1/23/298
https://lkml.org/lkml/2018/1/24/352




> Are all these resources used just by the DWC3? Or is it a true MFD,
> multiple functions?

I do not think this is a real MFD.

This is a DWC3 glue layer, i.e.
a collection of misc registers that control
the DWC3 IP.


Just splitting it into small pieces
to use PHY, reset, regulator framework in Linux.

Of course, the price of this approach
is so cluttered Device Tree,
honestly I do not like it much.



>
>          Andrew
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada

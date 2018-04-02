Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3014039-1522675961-2-803789219522566332
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='ch',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522675961; b=loFWXNtP71G1WaWA94PTr7jSTmeagtq1LK1AJG1Vz/lZMP+/Pr
    rTVmEXQtGEdihfHWydjNO8h0ug2udQTzvOYUV5LoOJiFyTfLW3Y+3c2JVhGpqPLZ
    2m8lZoQmfIzMK3dgatlztaQS7PM019mjGhYUc7ogmnm+uiOirQqcPwonoipkwbkE
    XSVjnJVQiNxu4R4iuwqAFzYxOQH+biQ1xyvi4DmUz9L6zTFIzmiXFj4AN2S65FvE
    +zlgq3I8ANaRrLRA9JPcARrLHCVwr8hGzUk75mWZ4jSqkktOHliy4SgZR9PcYHCU
    GuXAF8Te9wwBjuWtAwE1gh6WeMcwNy4Lk7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522675961; bh=tOWsXd508lOJkvAsq8DNoe8oo/wac0
    NbyUqH5SE5Us0=; b=HJm0QTaLebOmkXFCubTTMuIKjMdRzrHYER2EhQ7UqTXAkL
    2cA5Dc7r0OqRfgj4kJTil7GlFHYJyPcn/WlKWq5LpZGlJcvDt2d8vrgxvHHlYmL9
    A4Yyfl1dXSEAlA3Ze5zvJLdvbR/HGSPn87rGBypn92YQxOAcfACFvp/vw+2J3o5r
    AjtzlYwoj8VsZAR32CN3SDwQ6A41nrm6YLCTn8qsjMqPL0rJ/qddlYIbCDHdFcYW
    RgfWl5O7XO+hZPjuyrjWo7fVj7gyJDYPO56EoAAhxsgzE2BISBg5a6qwt+PwC/Vf
    IjF1facWgKME+foCuscyh8hhWhIaiSOPQoMwhijQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=aPywMYpo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=aPywMYpo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBGHoxTmTD/sdgVrY8n2ZLj3t2LSQkA8M3xSU5QIXbOO5hhezBrUwPZ6We0I5y0Uj6aAB6IjZTjv26vrftq7HDbhsUwGcpSgE/X59OY/JwiYP36jDQS7
    XeTnN+vbstpwdJheczcICQgE2s83FmPjTz+Y6aKlefa3yIaEvo09NFdzNQxHHHr2UjKWPf3SOLb2DtYfcj+rhquwbePkiFPiVar1/W++AJX3/xhFcdcKHgeX
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=NA7OA7pJHmX6e-QBywkA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750852AbeDBNc2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 09:32:28 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48847 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750724AbeDBNc1 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 2 Apr 2018 09:32:27 -0400
Date: Mon, 2 Apr 2018 15:32:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
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
Subject: Re: [Question] MFD driver that handles clocks/resets and populates
 child nodes
Message-ID: <20180402133219.GA10520@lunn.ch>
References: <CAK7LNARFWDMgmWsCjUmVrm4ZeYOcKCbizijxmDXob618ABjNWg@mail.gmail.com>
 <20180402120414.GA8159@lunn.ch>
 <CAK7LNAQ6LKk3NtGLB8g07ocyvXidpTHsApeDuctvEHyyLvk2ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ6LKk3NtGLB8g07ocyvXidpTHsApeDuctvEHyyLvk2ew@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 02, 2018 at 10:21:01PM +0900, Masahiro Yamada wrote:
> 2018-04-02 21:04 GMT+09:00 Andrew Lunn <andrew@lunn.ch>:
> >> The maintainer of DWC3, Felipe Balbi, requested to
> >> split the glue layer driver into small parts such as
> >> reset, regulator, phy, etc.
> >
> > What exactly did Felipe ask for? Did he ask that the patch be split
> > up, one patch per reset, regulator, phy etc?
> 
> 
> Yeah.  That is what we understood from his comments.
> 
> 
> These are the feed-backs from him.
> 
> https://lkml.org/lkml/2018/1/23/298
> https://lkml.org/lkml/2018/1/24/352

> > Are all these resources used just by the DWC3? Or is it a true MFD,
> > multiple functions?
> 
> I do not think this is a real MFD.
> 
> This is a DWC3 glue layer, i.e.
> a collection of misc registers that control
> the DWC3 IP.
> 
> 
> Just splitting it into small pieces
> to use PHY, reset, regulator framework in Linux.
> 
> Of course, the price of this approach
> is so cluttered Device Tree,
> honestly I do not like it much.

This however the correct way to do this. You should have a phy driver,
and a regulator driver, and a reset driver. The DWC3 then uses
phandles to these drivers.

How is the IO map area 65b00000 split up. Can you cleanly separate it
into sub areas, which do not overlap, so you have a sub-area for the
PHY driver, a sub-area for the regulator driver and a sub-area for the
reset area? If you can cleanly split it up, you don't need an MFD. If
however the registers are in overlapping areas, you do need an
MFD. The MFD core provides access to the registers, while its children
implement PHY, reset, regulator etc.

	  Andrew

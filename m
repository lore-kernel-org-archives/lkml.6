Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1491286-1522760429-2-2964006207068680994
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522760428; b=efVk/nxwLnd6olX59VG4mzVYqOS6oeDXnf+wWuHxkbZSlV/UeC
    vbfjNyMXOLf8OXBdmTYtF6pLjJ+dpkSoHMUqna4G/8PezNoulZ5KGgT9s5e++5yt
    4SJC7+Wy0NzdP3jiOEtUZVJBKiYLzSxWoOqiCa0znRq+GYHM8dJLHnJtqgQrb6h5
    JlkyqDFEw/adReVMjsUPQ2zvGta8qEFKSvIpZgXllUT2nmNYNv27l5EG6KQGmzWR
    MCg5Lu0PLBlBfujnwKtNaO92OvDx/dclJ9OFKwcLVcjbmVxYsM95c5QIhy+Q+/Da
    ellKnCNA1GTcuHUcd2+Ho1soHKHftL/Lb38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1522760428; bh=8ZXUGyMR700
    gi+ldrzi2Ep6LoGxz63BhaZpzt+kpVzM=; b=OKRNddyHNb4gQbULa9xxKTThSrX
    wlUq+X9YScLyFxoz/vOp65lkwWSA7SIUURpM+u8JmI1tdAE7Mcx4U7WGrWQ4HwvV
    H2hKSW+1q5jM9O8na1DIRSzX9Kfa+jipPWfH/PlwQNPwqooeDVevZ0YIr3LEthPT
    gI+y7WAUa5YskO0TlFv+JIXOOPHWns9blCS5mMrSFeIcsKy5gVMd5rbC4Io7xmfA
    4BD3q7cUc4k7Iwzb3Zv0n4/Y67wtuYVK3tzWORmbl/fX4m6joOCuiwkaOrw92d1r
    +e6owHqdb+SlvruOKiJbj0f1p+6+2Scycuydp+KYhSzYzewwC22jFHe/Bzw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Z8Oq08rV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VIJsjqEZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Z8Oq08rV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VIJsjqEZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHGeI+u0UCcifAjMQ/XJBSbrRvL8fdUhKHHDbDUS9WThw2+OTsJ8xXmIJkiSoJ1obqPbN15/hApxyU/uIuy/kghMLlpUNrrmTyX2GBr5ZuDpLWk+cHTG
    gMvcyWnf79tdFDahTCucTUPWhqb1ckfdQzf8fs/hApLRkUtS1suCzFatynsZ9tXozkC1+IG/pmXROl0HU92gv0MwwMug8ObPA9icaCczdZD3AkGtRiiCn3IK
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=KKAkSRfTAAAA:8 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=He-yJPhLhVRUihxi6CsA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=cvBusfyB2V15izCimMoJ:22
    a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932173AbeDCNAA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 09:00:00 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35254 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932151AbeDCM76 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 3 Apr 2018 08:59:58 -0400
X-Google-Smtp-Source: AIpwx4+mjJ+raGQ3XkKVeV9mT+XgjeKO11aArBcAOlqgh3CMto6XVexLmEQ4k/f0urMc3tOySTFUPw==
Date: Tue, 3 Apr 2018 13:59:53 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20180403125953.qzpbnlsyuxm4w7nm@dell>
References: <CAK7LNARFWDMgmWsCjUmVrm4ZeYOcKCbizijxmDXob618ABjNWg@mail.gmail.com>
 <20180402120414.GA8159@lunn.ch>
 <CAK7LNAQ6LKk3NtGLB8g07ocyvXidpTHsApeDuctvEHyyLvk2ew@mail.gmail.com>
 <20180402133219.GA10520@lunn.ch>
 <20180403080335.ksekhxwvbzbxhmln@dell>
 <CAK7LNAQbWUYuhow5VdNDc+SuttY+u3xh9zk92kLEy9id6TNCFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQbWUYuhow5VdNDc+SuttY+u3xh9zk92kLEy9id6TNCFg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 03 Apr 2018, Masahiro Yamada wrote:

> 2018-04-03 17:03 GMT+09:00 Lee Jones <lee.jones@linaro.org>:
> > On Mon, 02 Apr 2018, Andrew Lunn wrote:
> >
> >> On Mon, Apr 02, 2018 at 10:21:01PM +0900, Masahiro Yamada wrote:
> >> > 2018-04-02 21:04 GMT+09:00 Andrew Lunn <andrew@lunn.ch>:
> >> > >> The maintainer of DWC3, Felipe Balbi, requested to
> >> > >> split the glue layer driver into small parts such as
> >> > >> reset, regulator, phy, etc.
> >> > >
> >> > > What exactly did Felipe ask for? Did he ask that the patch be split
> >> > > up, one patch per reset, regulator, phy etc?
> >> >
> >> >
> >> > Yeah.  That is what we understood from his comments.
> >> >
> >> >
> >> > These are the feed-backs from him.
> >> >
> >> > https://lkml.org/lkml/2018/1/23/298
> >> > https://lkml.org/lkml/2018/1/24/352
> >>
> >> > > Are all these resources used just by the DWC3? Or is it a true MFD,
> >> > > multiple functions?
> >> >
> >> > I do not think this is a real MFD.
> >> >
> >> > This is a DWC3 glue layer, i.e.
> >> > a collection of misc registers that control
> >> > the DWC3 IP.
> >> >
> >> >
> >> > Just splitting it into small pieces
> >> > to use PHY, reset, regulator framework in Linux.
> >> >
> >> > Of course, the price of this approach
> >> > is so cluttered Device Tree,
> >> > honestly I do not like it much.
> >>
> >> This however the correct way to do this. You should have a phy driver,
> >> and a regulator driver, and a reset driver. The DWC3 then uses
> >> phandles to these drivers.
> >>
> >> How is the IO map area 65b00000 split up. Can you cleanly separate it
> >> into sub areas, which do not overlap, so you have a sub-area for the
> >> PHY driver, a sub-area for the regulator driver and a sub-area for the
> >> reset area? If you can cleanly split it up, you don't need an MFD. If
> >> however the registers are in overlapping areas, you do need an
> >> MFD. The MFD core provides access to the registers, while its children
> >> implement PHY, reset, regulator etc.
> >
> > This device certainly sounds like an MFD to me.
> >
> > Can you share the DT you've written please?
> 
> 
> This is still under the internal review in Socionext,
> but I attached it below FWIW.
> 
> (I am not the author of this DT.
>  Written by Kunihiko Hayashi,
> 
> Just skimming the driver, I guess it will be possible to flatten
> the node structure by separating the register space into sub-areas.
> If this is success, we do not the MFD driver.

Sounds like a plan.  Pretty sure this isn't really an MFD.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

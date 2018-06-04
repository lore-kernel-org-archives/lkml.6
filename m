Return-Path: <linux-pci-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2012686-1528151455-2-9791884619089952745
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-pci-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528151455; b=EsDi1pkHQpmJmd9mbIwU0Nt4+xsGUG9hClMieAIqcverbbazFK
    AS9/3ehG9xvyCVPgtGDJOOJfM/pegWR5jnN6np67SvsYL1VIO+pNUgFe7LxAqiOV
    b1HvN2T7UT7TpYXcSfQmh59kQqHtFoy1Debf0ZI4TDymy2ANyeu423/Tahcv/Tp3
    ynpUwE/1XHRaL6xJLj211XMTrwIMfXCWoIirqCf87BRRe8WNJ28ajcUYDaEsj+g8
    YYsZkpW3RGiY8yQZsXLgIoczbPoDPgLKkDr1HH4P+J+4g1imZGryTwtVW29k9zqv
    FeVhUYOFsVpSpNdOyZyUD6tQx2CHqueTGqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1528151455; bh=YPbI2ARoao+FbVBcqgV4ks7A97cjVR
    29R4tU4XKk4RM=; b=M879Q2yMbpWTs60B+3LZk1xuAF50P8HH+bzYPt+sY3dDbZ
    3srxQVVcuShafkj+JE9xwoevRB1tnwO+aoRH7+vss3JeHCjhNi09j3LQXXWxc3aS
    6IPqYbNgRGEkUeStAq2rd8qJEaLCPwka9E/pV/pj0zFfjRipsJv0n+AzSioGTpJ9
    W1kwV6Y4OGeRq+UXq5yuAwxt/jJdCyMzuDgBDOEGixp/UYoEtVUyYWVB6vWXcNt1
    WFktjDLN4+2xAarVMLUt5vHrpE8Zn9J1fijX0ht2deRJNmwdUA8A5iZnrZIb+hxg
    rpJuf4fcTzpY3KDAXtgqdpM/6vtNf3pGgHuGOSgg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ccfmdIIo header.a=rsa-sha256
    header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=ccfmdIIo header.a=rsa-sha256
      header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN/LQYRM3ycSE/Y9TbGK7hyB/S/KEN3Px04chTxqkGZQIRNrolRUJNKPwdNUGDvg0S9JAkAORaxQJgxRe2a7L6B6x+gFLaWOaYuqzrLVzwUMeco1Ho/R
    +oViA78ceA4P5uJwZUYiicpnAXw0On1AC8U0paL7Ip1fYI64JFJsrhuVTzeJkmbVyrbpwjdGCrWxwfL44fdDy9H+g+GB/Fe1/aBb9L65BOHf64cqSNwBPxuq
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yC-0_ovQAAAA:8 a=JhOpUDsbAAAA:8
    a=WlIU11rf6IpP4TvN0I0A:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=QsnFDINu91a9xkgZirup:22 a=id22BOPz_3nJaf3FINPD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbeFDWaw (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 18:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751735AbeFDWav (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jun 2018 18:30:51 -0400
Date: Mon, 4 Jun 2018 17:30:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] PCI: rcar: Add bus notifier so we can limit the DMA
 range
Message-ID: <20180604223048.GC30381@bhelgaas-glaptop.roam.corp.google.com>
References: <20180521220514.30256-1-marek.vasut+renesas@gmail.com>
 <CAK8P3a1PZ_MfgEcvWdUbN-eCcs5Xo38LQ54imLc4kNtSKO9Txw@mail.gmail.com>
 <c2897d82-fe33-52cd-5aa6-3bddb478cb9f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2897d82-fe33-52cd-5aa6-3bddb478cb9f@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-pci-owner@vger.kernel.org
X-Mailing-List: linux-pci@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[+cc ARM64 folks, linux-kernel]

The original patch under discussion is:
https://lkml.kernel.org/r/20180521220514.30256-1-marek.vasut+renesas@gmail.com

On Tue, May 22, 2018 at 11:52:21AM +0200, Marek Vasut wrote:
> On 05/22/2018 10:10 AM, Arnd Bergmann wrote:
> > On Tue, May 22, 2018 at 12:05 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> >> From: Phil Edworthy <phil.edworthy@renesas.com>
> >>
> >> The PCIe DMA controller on RCar Gen2 and earlier is on 32bit bus,
> >> so limit the DMA range to 32bit.
> >>
> >> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> >> Cc: Simon Horman <horms+renesas@verge.net.au>
> >> Cc: Wolfram Sang <wsa@the-dreams.de>
> >> Cc: linux-renesas-soc@vger.kernel.org
> >> To: linux-pci@vger.kernel.org
> >> ---
> >> NOTE: I'm aware of https://patchwork.kernel.org/patch/9495895/ , but the
> >>       discussion seems to have gone way off, so I'm sending this as a
> >>       RFC. Any feedback on how to do this limiting properly would be nice.
> > 
> > Doing it in the driver is clearly not appropriate, we must do this in
> > common code. If I remember correctly, it's specifically ARM64 that is
> > broken here, it incorrectly allows setting a DMA mask to 64 bit
> > when that is not available.
> 
> Yep, that's correct. ARM64 with devices mapping tremendous amounts of
> memory. So did anything change since that discussion references in the NOTE?
> 
> -- 
> Best regards,
> Marek Vasut

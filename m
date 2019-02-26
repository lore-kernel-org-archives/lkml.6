Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35C5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6483920652
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="f+ratOq3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="odeVgsuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfBZWUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:20:17 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56007 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728766AbfBZWUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:20:17 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 903D622267;
        Tue, 26 Feb 2019 17:20:16 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Tue, 26 Feb 2019 17:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        message-id:in-reply-to:references:date:from:to:cc:subject
        :content-type; s=fm2; bh=p4vuxMDnxu3Z395mXwXsvPDeGoEHR4TduiXrnx7
        Bctw=; b=f+ratOq3Ug5KLbu4eLtet1JyjySyRLBrHX4O0T9NfRSlIFcULzUhVYP
        RJqbJpe5+g4yeZVpr4g1ctbN4WVi4iZ7dJf8QM5CDf1eRGXJOBE6Xy5W6wAqSp7W
        oS0Vk3UO6yjO2MpiSw+Y5FJG326iKWAzzNt3aDJ3ADxeMw27ERkzNRUIpKsNRgks
        OgZzELDZ9UD4VMtZ5Q9ZEUwwPjN9L9luGenq/CWqth5MLp3tXjvwWV5MTHa/6TYT
        7eMUAKw7pR9Lou/THwPcXta56cQ9G1bxJQQJ8abRSvnzlW2kLmVWAp9jfKQOIpxy
        XLbwC1EQxKOpcWHKxj4Qedhavxh+WGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:references:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=p4vuxMDnxu3Z395mX
        wXsvPDeGoEHR4TduiXrnx7Bctw=; b=odeVgsuU+gqK4a+bgNeJQJrPFreOSfu07
        L87/IQggFbLTPFELNeAegn9FvbOZwR4Vj3IbaHIxNk52/E3ZOx2alE3SNukY+LbS
        ceEIcGGPiXqo1xoPshYkwgRuwzSV733+Uz/v+mg9O73i83aeIpWWj2h81RjojW93
        qbbRiLnVQRZIJ/bqFpv5Jb5hqTzmhiqIiTJMLMB8AUMueXbiYBwVvaAXwFUyQGaP
        Ab4OnrYy4oHw8vy+JwN20H5yy6Pf3oyWYehrAlzaeKaucvEIRUSr60QaPUlXV96g
        spOzswCIFmsEBa1Xl5I6ubyzw3itaW2LOUpqVoGj19rUuPuf5sP+g==
X-ME-Sender: <xms:nLt1XJdhcd12Xho0roQc_3hf0lVGkADi6dG_qeL5tDOkNhQqyd7hcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrudelgdduieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrg
    hmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:nLt1XMEO-owO6sefbd_D0L-w73DaWWv9jLOISVXnevgKNHAAoSouVg>
    <xmx:nLt1XLH28dqGr0zjM7txwRpDvUuTewg0nHxEb4NtdNtosxZ4QGnWRw>
    <xmx:nLt1XENe2GHnEgFtSCbn1jyJOWIypXKaQhFONw_B3mKBcR1qVXWX9w>
    <xmx:oLt1XGE1D3bdo17iSWtKH75dIpzYiW3WuYGkx-bC7SaensNvC9cI9w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2CE557C1EB; Tue, 26 Feb 2019 17:20:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.5-895-g0d23ba6-fmstable-20190213v1
X-Me-Personality: 52947553
Message-Id: <578fe6cd-cc7c-4f6d-8f7e-39c9f183a8e4@www.fastmail.com>
In-Reply-To: <CAO=notx1OTWbxg5EhgqDUcrpfBpgez3LXXrNKHX5VpOark3GvA@mail.gmail.com>
References: <20190221222537.137331-1-venture@google.com>
 <692c6c5d-9090-4e1f-9324-a03da381b003@www.fastmail.com>
 <CAO=notx+p5PQ1UXW7XKD=5Lb23RvC5+1R+LcJLxXYEnT6vvgkQ@mail.gmail.com>
 <CAO=notx1OTWbxg5EhgqDUcrpfBpgez3LXXrNKHX5VpOark3GvA@mail.gmail.com>
Date:   Tue, 26 Feb 2019 17:20:11 -0500
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Patrick Venture" <venture@google.com>
Cc:     "Arnd Bergmann" <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH 2/2] drivers/misc: Add Aspeed P2A control driver
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Feb 2019, at 08:26, Patrick Venture wrote:
> On Tue, Feb 26, 2019 at 1:42 PM Patrick Venture <venture@google.com> wrote:
> >
> > On Sun, Feb 24, 2019 at 5:26 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> >
> > >
> > > > +
> > > > +     /* Access to these needs to be locked, held via probe, mapping ioctl,
> > > > +      * and release, remove.
> > > > +      */
> > > > +     struct mutex tracking;
> > > > +     u32 readers;
> > > > +     u32 readerwriters[P2A_REGION_COUNT];
> > >
> > > Might be better to use refcount_t here instead of u32?
> >
> > Ack
> 
> refcount requires atomic, is that something we have with the ast2400, 2500?

Ah, we do on the 2500 (armv6) but not the 2400 (armv5)

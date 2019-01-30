Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1FCC282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCD320989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="A1z/aYvn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hLXEBPUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfA3FU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 00:20:29 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51975 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbfA3FU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 00:20:28 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 3EEAE2278C;
        Wed, 30 Jan 2019 00:20:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 30 Jan 2019 00:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        ASSUAlGLWVfPvTu/6Z9HIj9oRBODvHzzY4xOjv2wILg=; b=A1z/aYvnMQ9BDaJY
        l3FlrRo3gpS7J3zkDE9zktvvYiPfggFkvX4LfxEZXSSIXBYZcKUaRe0bHWePasTN
        sZAhHFbbT7IkpsovaM7Gj4BA8hqmbUpAg8DtXGguw/AsRcAEwmt4BrJZ77pW2XTA
        dILB+3HS6CwIaCobi6b4v4dq1JUqeTPc2zhsnPn4atJEmVxk+GDT6CZ+t8iK8gUs
        fvN5FeBUbpN35WmsYbirFy/jD3o7vv8/yP3K+e1IMKz8PY8fwLwy1aRiPzELwEFh
        FyyWyLf+QNgAyP6NbvFkws9rOvSEiUadyXuigJcQPjcvgImYUt8bvsSHxWN55kDT
        QEXXSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=ASSUAlGLWVfPvTu/6Z9HIj9oRBODvHzzY4xOjv2wI
        Lg=; b=hLXEBPUbbSbd8HysRH8R6e0OeGHHE6SDOkmIK0KffR6hPOSQect2YO4on
        2UMmT0C3yyAwhLnZZwAEL1fb2qjf2i1ygQiQoIk49uZnsCNYisI0TO+XPIIWf8Yt
        xGLYl6Mk3kUNK5SPn8vXc7SB+wiGEMnv3djH1yhQ9t04lBOE7eqbxshJjpBdkcjh
        jipx0bJt6v/U2JAymViJuiZUtm0+/Uj7++AMPKEU8mHA+gxYP0h7AZ/99ermg+Ee
        Cw4X4asl78wlK022nSRNAUBK9HQ/H6G2aoLRzGtl7aK3FPwrzZf46tLUW6q59GCl
        UkNDOrPiyFvBFqexZ2uRqE5ZWw3/w==
X-ME-Sender: <xms:GjRRXI-B68QTpG-_unsy2Zay3kttZz7FmRPLtDfrGhSLsjkijPISZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjeefgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfh
    gtofgggfesthejredtredtjeenucfhrhhomhepkfgrnhcumfgvnhhtuceorhgrvhgvnhes
    thhhvghmrgifrdhnvghtqeenucfkphepuddukedrvddtkedrudeijedrheeinecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvthenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:GjRRXE1GdpolNZHA-0V6h4t2mMJjrGVyurbD9UsXtoI_pQzGmiaC4A>
    <xmx:GjRRXLDbxeXUBoRszsQ0wuUlI2Dg3bdbNMlc60Ptc73OxZkmk9SzLg>
    <xmx:GjRRXDBGwIGDmlpTzCRVXOb8UzD5B8tMme0988Eo--8ohtZ22zhlow>
    <xmx:GzRRXCswOL_IVszL50hoQsnEmrNsYAkwkGC7gqA3IzSMKxcqZ4P30w>
Received: from localhost (unknown [118.208.167.56])
        by mail.messagingengine.com (Postfix) with ESMTPA id DEF3510310;
        Wed, 30 Jan 2019 00:20:23 -0500 (EST)
Message-ID: <ee605bb8f5abfa7778211f9f4e9b22934f5870a4.camel@themaw.net>
Subject: Re: [PATCH 3/3] autofs: add ignore mount option
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pan Bian <bianpan2016@163.com>
Date:   Wed, 30 Jan 2019 13:20:20 +0800
In-Reply-To: <20190129205811.2bd83d93dbc05325a8c55954@linux-foundation.org>
References: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
         <154725123970.11260.6113771566924907275.stgit@pluto-themaw-net>
         <20190129171622.5b75f794d2b1e4d1055331eb@linux-foundation.org>
         <553f4a0daf09407371193d7d4782a759561a626a.camel@themaw.net>
         <20190129205811.2bd83d93dbc05325a8c55954@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-29 at 20:58 -0800, Andrew Morton wrote:
> On Wed, 30 Jan 2019 10:07:15 +0800 Ian Kent <raven@themaw.net> wrote:
> 
> > On Tue, 2019-01-29 at 17:16 -0800, Andrew Morton wrote:
> > > On Sat, 12 Jan 2019 08:00:40 +0800 Ian Kent <raven@themaw.net> wrote:
> > > 
> > > > Add an autofs file system mount option that can be used to provide
> > > > a generic indicator to applications that the mount entry should be
> > > > ignored when displaying mount information.
> > > 
> > > What is the reason for adding this feature?
> > 
> > In other OSes that provide autofs and that provide a mount list
> > to user space based on the kernel mount list a no-op mount option
> > ("ignore" is the one use on the most common OS) is allowed so that
> > autofs file system users can optionally use it.
> > 
> > The idea is that it be used by user space programs to exclude
> > autofs mounts from consideration when reading the mounts list.
> > 
> > Prior to the change to link /etc/mtab to /proc/self/mounts all
> > I needed to do to achieve this was to use mount(2) and not update
> > the mtab but now that no longer works.
> > 
> > I know the symlinking happened a long time ago and I considered
> > doing this then but, at the time I couldn't remember the commonly
> > used option name and thought persuading the various utility
> > maintainers would be too hard.
> > 
> > But now I have a RHEL request to do this for compatibility for a
> > widely used product so I want to go ahead with it and try and
> > enlist the help of some utility package maintainers.
> > 
> > Clearly, without the option nothing can be done so it's at least
> > a start.
> 
> OK.  I guess I can just paste the above into the changelog.

I thought this description would be too long but, by all means,
replace or add it to the changelog.

Or, if you prefer, I could try and come up with something more
succinct, the above explanation probably goes into more detail
than is really needed to get the message across.

> 
> Also, Documentation/filesystems/autofs*.txt are owed an update?

Yes, I think so, I'll have a look at it and get onto it, thanks
for the reminder.

Ian


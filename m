Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACD3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9502147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="prRsamLv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5cRdXFlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfBSVyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:54:03 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:52547 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbfBSVyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:54:02 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 50B3034FB;
        Tue, 19 Feb 2019 16:54:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 19 Feb 2019 16:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=DZCAgcu4gs6HRV3PBwax+lMpNOc
        XGgzw0yN/Ik3WJp4=; b=prRsamLvJ8qxlGB39vntN5Xzl8h/90IVtJyhkH/8BOl
        VEe1DdgK/aLa6yDt8jwK0G09CrP2bL9M/p+1AfCUoN6frarX9RHxWKyqXXJc9QRd
        0c94P94VfEECLwkCCGeWFg21p3Bwyck9ZMaxA7LJVy6jBMAQpyFEiZBQYOOVikek
        IYdP01rOYu5ZVqhQ74NDZzEbMl+3dREN5BIlLfDOtVfIcMYmmkuXPGQxNgmYKWBx
        BSNrDaLjKln4svuGiGceDOxxfuCZEQ6RwLLlplrmgMoaKz8uiGkaZBZeKUBLEfS/
        i/zXBO7waFaoWfo763kQ3ZJIEpyk9QQYnj8YDDNsodQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DZCAgc
        u4gs6HRV3PBwax+lMpNOcXGgzw0yN/Ik3WJp4=; b=5cRdXFlr+mwNb+xmMZFjk2
        kPscke6MmRbqz9wN3Q+nMNtXM6koCtzLM4otcIIn+5Xn4+t3PajFHcZ3Tik8UGn7
        ryzqPdnFpDvQBV34+ArZTpMfEh3GFSKuVUpj5BMEwdGWhAAORD/EIc7GiWME1SwU
        JX563HFNftHt77HDPT/Humvl5xZf3v53sYOoFCn5EUBhthrPlVynOINcZAIUi1MA
        cGHLKdNhA2Y6aJbzJKADlMxXsZE8LB2U2sYN125kIngdGjyr2D24jnzY0ZcQ4d6G
        XTsb5tV6xDfR5oxBAFOi6d+9N0FLc+Pq+4v8/zbbWOM99IzPln0SOlnRhz1d5mtw
        ==
X-ME-Sender: <xms:-HpsXDK0i-ga70nQJdWa3WHGrXfpWZr3OV-H2kgY8UJw7y9zs2JR3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdeggdduheegucdltddurdegtdelrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhht
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttder
    tdforedvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesth
    hosghinhdrtggtqeenucfkphepuddvuddrgeegrddvfeelrddugeegnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:-HpsXD5Pw57jgBcFipPCViqNF1AZHK7zNW_NZ4KCRORLyHkGfQ5XlQ>
    <xmx:-HpsXGTxFj6lOcz1AkDUkwKUW1uYrwYMQStxnLAexGBg4GvScy2qVg>
    <xmx:-HpsXPpZ0lhdLsk6-wvQ5GZWSIRC3Ko9A6Dgq69ViKmebxgRfvXgzw>
    <xmx:-HpsXDKacph6aUtdHR3NBqLLKN5TITT75-i9BxJepGeJhe8SSc4J6g>
Received: from localhost (ppp121-44-239-144.bras2.syd2.internode.on.net [121.44.239.144])
        by mail.messagingengine.com (Postfix) with ESMTPA id E99DE10310;
        Tue, 19 Feb 2019 16:53:59 -0500 (EST)
Date:   Wed, 20 Feb 2019 08:53:45 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jann Horn <jannh@google.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] lib: Add function strscpy_from_user()
Message-ID: <20190219215345.GB16094@eros.localdomain>
References: <20190218232308.11241-1-tobin@kernel.org>
 <20190218232308.11241-7-tobin@kernel.org>
 <CAG48ez1n=+GsvhMxHhxL=EBxD6VEqopdLRPcEAff9vrP3+a30g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1n=+GsvhMxHhxL=EBxD6VEqopdLRPcEAff9vrP3+a30g@mail.gmail.com>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 03:12:33AM +0100, Jann Horn wrote:
> On Tue, Feb 19, 2019 at 12:25 AM Tobin C. Harding <tobin@kernel.org> wrote:
> > Currently we have strncpy_from_userspace().  If the user string is
> > longer than the destination kernel buffer we get an error code -EFAULT.
> > We are unable to recover from here because this is the same error
> > returned if the access to userspace fails totally.
> >
> > There is no reason we cannot continue execution with the user string
> > truncated.
> >
> > Add a function strscpy_from_user() that guarantees the string written is
> > null-terminated.  If user string is longer than destination buffer
> > truncates the string.  Returns the number of characters written
> > excluding the null-terminator.
> >
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > ---
> >  lib/strncpy_from_user.c | 43 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
> > index 11fe9a4a00fd..6bd603ccec7a 100644
> > --- a/lib/strncpy_from_user.c
> > +++ b/lib/strncpy_from_user.c
> 
> This file is only built when CONFIG_GENERIC_STRNCPY_FROM_USER is set.
> Some architectures have their own versions of strncpy_from_user() and
> don't set that, so on those architectures, your code wouldn't be built
> into the kernel.

thanks!  Dropping *_from_user() stuff from set.

	Tobin

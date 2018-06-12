Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E7351C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9899F2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="G45fNZ3X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e63O3zcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9899F2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934678AbeFLVmr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:42:47 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42751 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932869AbeFLVmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:42:45 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 45D4A21AD4;
        Tue, 12 Jun 2018 17:42:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Jun 2018 17:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=U/dg3P8dIrtKH/lnsUlnTxSFe7c4SeYHbs6cYB/rlAE=; b=G45fNZ3X
        WKyk+36wXf0UA7wYbSBVWvsEb0x2NBoZ9QEsc4OOcz8hDE+EICzeSFheNpEHJ1vV
        w9dWBvbSGRBdsJIPLBgCzo8A67HtY13SrNnmXynwb2kC1rDXNhfEmZd4iFS4MvMw
        Rdw/qfF27amX+F10Xz3YWsJIwlfa4FesaUf7fnCF98dG7r2QMUFn9MxR4fohx3dg
        OqSerhZFRuB5r4neS/ND+gMbjYwI0Xjys3IApOq5jmr27LAH8J9yzfKpoWn1yH//
        zgykXmrD4ypiG/Y+nkdBZEM25ncGrOBDtrM5pkI3/L49rgSS8Nn6DuiiCJr1/6+U
        rg2+8cloN4Gk7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=U/dg3P8dIrtKH/lnsUlnTxSFe7c4S
        eYHbs6cYB/rlAE=; b=e63O3zcONbZ38y2qrmcPjbORBZk50w/S5NvI2xyG4+ENu
        caz+XXaB6PYUmao314lvna3HGQN/YnFvTlo/OFGrcOadrNxAAaG8NI56gQn+JTPm
        /2VS6QVJxemTFabDxTqfG0U54kBBc4eBB3peB+N/n3x2JjZBH3H+xDoi1/asEb40
        +EvzpRkBaNpmp47j1UAiRueV9Cr/3mvarj0bERh4Xotv8gaOeUH96zvJRnEYLPhz
        /LE+RHy9NdEeCMzA/gEIzhOr7+tioSQ/BQNuKbVzT2y4PTeCEUerMXTmpK4iasxy
        vUBWxZO7sUEHo0Dmns9Dq5/6vgZbTyIgeBBqGsURA==
X-ME-Proxy: <xmx:VT4gW510_LiyKnvFbc7_I9yKRA7ubit26arHlVvVD1D6iXXTmC-FiA>
X-ME-Proxy: <xmx:VT4gWwSrR283VCiOAnb86HfezQ6LgaJXXv1bIrF7iLqPIZKdsXVblw>
X-ME-Proxy: <xmx:VT4gW7uxswykD0St8Si-trvGbpPxkVq59UOFykUo5ibbwq64MGyyzw>
X-ME-Proxy: <xmx:VT4gW1YsW8aVyz7bgJ6rINS_5T8M6-2FOnTJZWco7R2f-wxUNcC3RQ>
X-ME-Proxy: <xmx:VT4gWwsQh2-gklR9jQvSwf0spEgSGNmD2GGTbxIjaDRhhlj2CZwe6w>
X-ME-Proxy: <xmx:VT4gW7xiupTOyJTgEkhxQMKZLGNyJrdG_ChxwLpI5XiktMRouvUiWw>
X-ME-Sender: <xms:VT4gWzjDUTwjOD_AHDguzamYEUB1PN46_kzrS6gqW2auJjaDdZN2_w>
Received: from localhost (ppp118-211-220-95.bras1.syd2.internode.on.net [118.211.220.95])
        by mail.messagingengine.com (Postfix) with ESMTPA id 79C67E47A0;
        Tue, 12 Jun 2018 17:42:44 -0400 (EDT)
Date:   Wed, 13 Jun 2018 07:42:42 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/4] random: Return nbytes filled from hw RNG
Message-ID: <20180612214242.GB4528@eros>
References: <1528763954-27731-1-git-send-email-me@tobin.cc>
 <1528763954-27731-3-git-send-email-me@tobin.cc>
 <CAHp75Vcqni6MtnLcoMG+2Tt_YeGq2QeQy4myEJp+dmjPXdj3XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vcqni6MtnLcoMG+2Tt_YeGq2QeQy4myEJp+dmjPXdj3XQ@mail.gmail.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 11:39:56AM +0300, Andy Shevchenko wrote:.
> On Tue, Jun 12, 2018 at 3:39 AM, Tobin C. Harding <me@tobin.cc> wrote:
> > Currently the function get_random_bytes_arch() has return value 'void'.
> > If the hw RNG fails we currently fall back to using get_random_bytes().
> > This defeats the purpose of requesting random material from the hw RNG
> > in the first place.
> 
> > -               int chunk = min(nbytes, (int)sizeof(unsigned long));
> > +               int chunk = min_t(int, left, (int)sizeof(unsigned long));
> 
> Isn't this (int) implied when you use min_t(int, ...) ?

thanks Andy, will spin another version.

	Tobin

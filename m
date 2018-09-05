Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060B6C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EEB20839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCU55c+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EEB20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeIFAUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:20:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37054 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeIFAUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:20:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so8912607wmc.2;
        Wed, 05 Sep 2018 12:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=js9WsRxl0n3G/PA9K5oX4oD1Km2MP7WrSMeaaOfIOnk=;
        b=KCU55c+0E8RjO8g+M4YpuYRUa6+E8/Z3Sr9+Wo7qSk+YB0Dh9t2ozDOO3dYZPvlqG+
         6i+He3zZxU+6lNSM4u72iOEvSaF4wcJFzr6mXrUbB/FgYiFhuPc7Ibj4v6FB9YAPZ71h
         cJhDbzWTKvky7nCR+Se0rWLube3O/SfBmAL2FLW+YGJ6rr7MLwowTNm4BsmjMZHtK6z/
         GI8p5mcJCHY15xkYM9KJG3hKBfDexPce2FYOfdui0dgzWKF5+Ry7wAGuL5tDLmsUg4Im
         lnGWaqnGwEtbJCb1iDo/k1R4gQZFTt1mrQ3cF/mNG88Tueai4hixaqjQwLm6CS/OJrTz
         ws7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=js9WsRxl0n3G/PA9K5oX4oD1Km2MP7WrSMeaaOfIOnk=;
        b=dnsoDwLXfkGgTxvlv2WUGDuNE/vAl6scC/tSN3IOLhhbT2F+dDx0xRlZjqPbCJtHes
         eiU5RMGVqbZblpgSAojl9643D45GxR94gK5+nkTpPKyhu6d3eTdV4b/0JQPdENVNGJUg
         lgjWAXRAG1JABWhdRdCGQmossTTu0UdciB32takh0L6LZ00QiOCfE+ZKF/fkq9xy+lGj
         FVXU/1Tz0S3zZutm3DDDRbKe7KeEUDjfQY00jEphB0ujHY9UPhDpdNyTNztZzYqOnsrl
         OQUAUR/kpgbA9f6AZaOYE6w34X+8LzA7Vb5wxLzMvnOZd+IZFMspxWjhxhoxsOQZNPSJ
         hW/A==
X-Gm-Message-State: APzg51BLCCb4MJCxGNI2etFWHMdAHcTH/5FNVQdhvwxXvRyGaXC+UbN/
        WEN5HM6ZzEIHC2oU24qRTMY=
X-Google-Smtp-Source: ANB0VdZtmadJaTlZe0BRosFDrwa7yYKCmAqnf8QDovzH6PZ9Ab8bqtl+Vc6LxjfMdygT6xr5au2fPQ==
X-Received: by 2002:a1c:70b:: with SMTP id 11-v6mr1176754wmh.151.1536176943314;
        Wed, 05 Sep 2018 12:49:03 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:b45a:4246:cb70:58f7])
        by smtp.gmail.com with ESMTPSA id i125-v6sm4334199wmd.23.2018.09.05.12.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:49:02 -0700 (PDT)
Date:   Wed, 5 Sep 2018 21:49:01 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        efriedma@codeaurora.org, Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH 07/12] Compiler Attributes: remove unneeded sparse
 (__CHECKER__) tests
Message-ID: <20180905194900.oln7qsifgcyuozrq@ltop.local>
References: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
 <20180903203316.16183-8-miguel.ojeda.sandonis@gmail.com>
 <20180905182038.muv535vfugm72spk@ltop.local>
 <20180905193035.GB3420@localhost>
 <CA+55aFxWcAqzuYOn1OPnRy5g5Uj69mQvxDK9Tn5HqecA-f3eiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxWcAqzuYOn1OPnRy5g5Uj69mQvxDK9Tn5HqecA-f3eiQ@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 12:40:26PM -0700, Linus Torvalds wrote:
> On Wed, Sep 5, 2018 at 12:30 PM Josh Triplett <josh@joshtriplett.org> wrote:
> >
> > Unlike GCC, I don't think it's at all unreasonable to assume a
> > *relatively* recent version of Sparse.
> 
> Yeah, sparse is small and easy to build and installs in your own
> ~/bin/ directory by default.
> 
> Anybody who can build the kernel can trivially fetch and build sparse
> in seconds.  It literally builds from scratch in 2.5s for me.
> 
> I don't think you even need any development packages that you don't
> already need for the kernel. Just a C compiler and libc, basically.
> 
> Sure, some parts of sparse can use things like libxml and llvm and
> even gtk, but that's for functionality that the "check kernel with
> sparse" doesn't even need, and the makefile will automatically disable
> them if you don't have it installed.
> 
> So if people are having trouble, just point them to the sparse repo,
> and tell them that
> 
>     git clone ...
>     cd sparse
>     make -j8
>     make install
> 
> fixes the issue in 30 seconds.
> 
> Although maybe I'm misstating just how easy sparse is to build and
> install, and people have had problems?
> 

I never heard of anyone having a problem to build sparse but I
guess that a lot of people just use their distro's version.

That said, I'm of course, all for encouraging people to upgrad
to a recent version.


-- Luc

Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1410EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE20206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE20206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390406AbeKVJfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:35:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45725 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387668AbeKVJfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:35:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so7497755plm.12;
        Wed, 21 Nov 2018 14:58:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W3SLUllYhiDSE3+aA/Sq9gVZvgBvI7jP88VskiGrhPI=;
        b=JU7GpA7ebAloU5SXY3cuvXVEuEX8K7rHAcgnhEcAgS5CEb+DinE8IUMRKKtdzr1H03
         SOCGHQPITSKBmCdza5QZ69HhwFVzpE8YBrqvLFEv4imiECbGkrfhtFtcOIKb3/dTRSVw
         GAE47jpI4Tq7xO/l21wOfBJ/NY1yKhn0zcfO3QZa7E9cwOloIxVvm0cqgrT1a9FoVM6P
         qgXK/59htbFnZWVgxDPwOsw3hTIdqD8bPTcNZFKP45gvoqUIxry+0o6TY7QxtAANRP1G
         iSL0Nke2COVhpzElIBlXXu49j1MbauprjmAPJ+ph0AG90dVhh2fzvgVLsDM/b9t5Ui6u
         wa+w==
X-Gm-Message-State: AA+aEWa0xhUhM6Om4zu17i30wlM9UjBZZJzIIOJbo1qW+pHmuT6pDNWr
        iYN+Q+r9XKMygFT1KRjQh8s=
X-Google-Smtp-Source: AFSGD/W7wZ2oGkznw7YFCF2jIl0AdzxDoY7kcskakt5GHQw+CENHDL5IQ/3JhpH8wDqOyKL1UlCkAQ==
X-Received: by 2002:a63:a84a:: with SMTP id i10mr7838623pgp.263.1542841133145;
        Wed, 21 Nov 2018 14:58:53 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id h124sm21810539pfg.143.2018.11.21.14.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 14:58:51 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Wed, 21 Nov 2018 14:58:49 -0800
Date:   Wed, 21 Nov 2018 14:58:49 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>, Petr Vorel <pvorel@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Vegard Nossum <vegard.nossum@oracle.com>, nbd@nbd.name,
        kconfig-sat@googlegroups.com
Subject: Re: [kconfig-sat] Re: [ANN] init-kconfig - easy way to embrace
 Linux's kconfig
Message-ID: <20181121225849.GC4922@garbanzo.do-not-panic.com>
References: <20181004200249.GL5238@garbanzo.do-not-panic.com>
 <CAK7LNAT3NQnTtdxyz79jgoQHoUS0TxkP99yuoY-N5yALLnFO1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAT3NQnTtdxyz79jgoQHoUS0TxkP99yuoY-N5yALLnFO1A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 07:48:34PM +0900, Masahiro Yamada wrote:
> Hi,
> 
> 
> 
> On Fri, Oct 5, 2018 at 5:03 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > Every now and then a project is born, and they decide to use Linux's
> > kconfig to enable configuration of their project. As it stands we *know*
> > kconfig is now used in at least over 12 different projects [0]. I myself
> > added kconfig to one as well years ago. Even research reveals that
> > kconfig has become one of the leading industrial variability modeling
> > languages [1] [2].
> >
> > What is often difficult to do though is to start off using kconfig and
> > integrating it into a project. Or updating / syncing to the latest
> > kconfig from upstream Linux.
> >
> > I had yet another need to use kconfig for another small project so
> > decided to make a clean template others can use and help keep it in sync.
> > This is a passive fork which aims to keep in sync with the Linux
> > kernel's latest kconfig to make it easier to keep up to date and to
> > enable new projects to use and embrace kconfig on their own.  The goal
> > is *not* to fork kconfig and evolve it separately, but rather keep in
> > sync with the evolution of kconfig on Linux to make it easier for
> > projects to use kconfig and also update their own kconfig when needed.
> 
> 
> Syncing kconfig files is easy

I disagree. Even as someone who has done this in the past and is an
experience developer it hasn't been a swift process by any mean.

> since the files are collected in the single place, scripts/kconfig/.

That helps, but isn't enough.

> It is true you need some efforts to introduce Kconfig in your project,
> but once established, it is just a matter of copying files
> under scripts/kconfig.

Nope, there is other random subtle work needed, a few of things which
I noted earlier before I forgot what things I had to do / change manually
which we not obvious.

> Copying stuff directly from Linux would be as easy as
> doing so from your init-kconfig.

Clearly I disagree, the idea with init-kconfig is the process of
upkeeping is done centrally, and so users really do just take that
and go.

If we want to make the process smoother upstream, then great.

> > This may also be useful if folks want to test R&D code on a smaller
> > compartamentalized codebase.
> >
> > If you find this useful and you'd like to help keep it in sync, send
> > patches my way as the kernel's kconfig evolves. The code is up on
> > gitlab [3].
> >
> > Do we want to document this option on Linux in case folks want to try
> > and embrace kconfig on their own for other projects?
> >
> > [0] http://www.eng.uwaterloo.ca/~shshe/kconfig_semantics.pdf
> > [1] http://gsd.uwaterloo.ca/sites/default/files/vm-2013-berger.pdf
> > [2] http://gsd.uwaterloo.ca/sites/default/files/ase241-berger_0.pdf
> > [3] https://gitlab.com/mcgrof/init-kconfig
> >
> >   Luis
> 
> 
> Looks like init-kconfig is trying to build some objects as demo.
> 
> obj-y = main.o
> obj-$(CONFIG_FOO) += foo.o
> obj-$(CONFIG_BAR) += bar.o
> obj-$(CONFIG_BAZ) += baz.o
> obj-$(CONFIG_ALPHA) += alpha/

Indeed, we are spoiled with our build process. Mimicing this was
actually a separate effort, and so I didn't match on par, but just
enough to demo a basic use.

> FWIW, this is something I played with some time ago.
> 
> Kbuild Skeleton
> https://github.com/masahir0y/kbuild_skeleton
> 
> It consists of some core Makefiles and Kconfig.
> 
> 
> From the time-stamp, it is already 6 years too old.
> 
> I am not sure if it is useful for people,
> if so, it is pretty easy to sync up with the latest Linux.

Groovy, indeed this is useful thanks. I still think this process can
be improved to allow perhaps both kconfig and its object makefiles magic
& dependency tracking thing be easily sharable. I however understand if
we don't want that to be a goal, there would have to be obvious gains
for it. I don't think we're there yet. Right now it would just make it
easier for enhancements to trickle out to the community and/or fixes to
bubble up, however I don't expect many people doing much kconfig hacking
outside of Linux. Perhaps the best advantage I can think for this as a
goal for us right now is to enable researchers with sandboxes, proof of
concepts, so that we can eventually get the fruits of such work.

  Luis

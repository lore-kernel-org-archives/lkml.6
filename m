Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F204C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 19:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503D1216FC
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 19:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503D1216FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeHYXdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 19:33:31 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:44564 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbeHYXda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 19:33:30 -0400
Received: by mail-qk0-f196.google.com with SMTP id d131-v6so8009730qke.11;
        Sat, 25 Aug 2018 12:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1j34M/FQwRxgsYUj4xHvzZGPWqY+hv4IFB0FnJ74Zxw=;
        b=Ibu4fea1Gutm+VBvOgb+nevq94lP7zeirV8LupGC8SAjHTNuSTKRF+2ifD2cjFbvQn
         abwbMpI+B0FhAW9Xsn1P91qV8TxLoOJgtohKeFsgwieXvWjJY5rxERJyib5/g9VzqhXz
         zNc8odh9CBzRxebKngwvqQFBgauHefSr02gMd/7mQ0qOeVpDac3HaK8c/KnTxRllyqhx
         +/UWu7XAF0bAs4GNAs5dmZDzi0fQA9J59XUrNL52kTkMK01T1nIWu+2qBiVziqz6sp3X
         WDMSn8kUumdujkZOjp/UPcD1tWdb6x2ZaJlDTi/7Q/CT01TVlJzlReeAKKbDqQoZuIDb
         L4CQ==
X-Gm-Message-State: APzg51DxB/bD6965eUTGfzakjXE2MZlXlFoFeJVeoakaA4h/de7b+CAE
        n8IZaA4ppamQ9eFPmR+bEzVgJFrCF2KQYfG4zCM=
X-Google-Smtp-Source: ANB0VdaQbquGurKBBKC9i+G+WaJHbZPIKIg/IcKaM34PuHChEZyl0QENOJPBmiux+S4HX2iWH+6hwMYPEg0M2g+8+I8=
X-Received: by 2002:a37:2941:: with SMTP id p62-v6mr7069536qkh.330.1535226814071;
 Sat, 25 Aug 2018 12:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180824133206.4218c2e5@canb.auug.org.au> <20180824172053.20fa197294f51496dcec5605@kernel.org>
 <CAK8P3a0LXxq8tgsz9YL3hT47dB6nKeBdip3gFA5w0dgRGDwCMQ@mail.gmail.com> <20180826035323.254463c8b183e6912c5b9a13@kernel.org>
In-Reply-To: <20180826035323.254463c8b183e6912c5b9a13@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 25 Aug 2018 21:53:17 +0200
Message-ID: <CAK8P3a1fsQUbUB4fEgTxm6voKjPFV0_RaBhuPBVxhnaRWBnC_g@mail.gmail.com>
Subject: Re: linux-next: build warnings from the build of Linus' tree
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 8:53 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> On Fri, 24 Aug 2018 14:46:16 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Aug 24, 2018 at 10:23 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > On Fri, 24 Aug 2018 13:32:06 +1000
> > > Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > > Hi all,
> > > >
> > > > After merging the origin tree, today's linux-next build (powerpc
> > > > allyesconfig) produced these warnings:
> > > >
> > > > Maybe introduced by commit
> > > >
> > > >   6b7dca401cb1 ("tracing: Allow gcov profiling on only ftrace subsystem")
> > > >
> > > > I am guessing, but that is the only new thing that affects all of
> > > > kernel/trace ...
> > >
> > > Yes, I agree. But I just followed Documentation/dev-tools/gcov.rst
> > > to enable profiling in kernel/trace. Hmm, doesn't ppc64 support
> > > GCOV_PROFILE?  (But as far as I can see, ARCH_HAS_GCOV_PROFILE_ALL
> > > is enabled in arch/powerpc/Kconfig)
> > >
> > > Anyway, I'll try to reproduce it.
> >
> > Thje same commit causes a link failure on ARM with a randconfig
> > kernel (see https://pastebin.com/KspjpyKG for the .config):
>
> OK, I confirmed that this happened with both gcc-7.3.0 and gcc-8.1.0
> with your config.
> I also confirmed that CONFIG_GCOV_PROFILE_ALL causes same issue.
> (Note that CONFIG_GCOV_PROFILE_ALL depends on !CONFIG_COMPILE_TEST,
>  so allyesconfig disables it always)
>
> Hmm, now gcov kernel itself might have a problem on arm and
> powerpc(on gcc-8)?

Yes, that is very possible. I always force CONFIG_COMPILE_TEST=y
in my randconfig tests, so I miss that kind of problem.

      Arnd

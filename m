Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1077C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60068213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60068213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeJDCjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:39:15 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37617 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJDCjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:39:14 -0400
Received: by mail-qk1-f196.google.com with SMTP id x8-v6so4254009qka.4;
        Wed, 03 Oct 2018 12:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DdLqF2MkLGFbo3L2fF0r2cyTmuFYzkLmHMwQ5bP2Zzw=;
        b=gbMyjcYJi+SqYTs0jseifTvRTy9AX/KDCQjbScCynLfumZ8LbEn93W1XBruc0YWEj/
         fI7CWjEA0kduKOyVP34PU8f8BmXgik2M7co7sLAwM7u+4qyEHBfcfAUwj1RGOh+6zyTn
         41TzpfyHXP8S4LWWen0rNQUicQdLqcSM7HJOwNdxsDhynga+bNDBmI1znlgg0QbPowbx
         G0mCW0+PraZ+8zSmap7H9d0SSTfSCQ8a+/IhNJW0fJPG1OtCpgcHcaBJ+d40bE5u8sR+
         HQbIV5vax4lZKGCcDK3UeqdeYK+QixBv47nQEJ1ByLABp8WwfYmTjc35UCGky1njgGF8
         wMjw==
X-Gm-Message-State: ABuFfohstU97KeXCXm5t83PaSfzG1LeoH+RWMx2ZDbC2KksVlJ5YOkU8
        5VZEYuxASe9/QMuD/q1nmg+vYkDLU/7Rx+iZZjs=
X-Google-Smtp-Source: ACcGV60q7T0xhIIujosT6wOCfteRpA6+ivxKcGs4uSkCfm1/eOYPNpBmzxGcE9ukwVWJpCOI3oAS5XzhIVLSJMQPeeY=
X-Received: by 2002:a37:e21a:: with SMTP id g26-v6mr2438197qki.330.1538596165610;
 Wed, 03 Oct 2018 12:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181002210213.GA17826@ls3530.fritz.box> <20181002211645.GA6454@kroah.com>
 <ad45f249-e064-d5a4-c658-eaa03bb3a04a@gmx.de> <20181002222452.GB11788@kroah.com>
 <dbfa0162-8ed1-b16e-a418-da3b92c76230@gmx.de> <20181003181612.GB28575@kroah.com>
In-Reply-To: <20181003181612.GB28575@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 3 Oct 2018 21:49:08 +0200
Message-ID: <CAK8P3a2ntPX4+LbYWJbDG1k-8NwkhyY0nYk-mfZU2FBF_h23Yw@mail.gmail.com>
Subject: Re: [GIT PULL] parisc fixes for kernel v4.19
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     Helge Deller <deller@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        James.Bottomley@hansenpartnership.com,
        John David Anglin <dave.anglin@bell.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 8:16 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Oct 03, 2018 at 04:47:30PM +0200, Helge Deller wrote:
> > On 03.10.2018 00:24, Greg Kroah-Hartman wrote:
> > > On Tue, Oct 02, 2018 at 11:46:11PM +0200, Helge Deller wrote:
> > >>
> > >> I've tagged it for stable release.
> > >> So, it can go in now, or just wait until -rc1 and go in later.
> > >
> > > Why is a major API change a viable stable change?
> >
> > Of course it's not.
> > Esp. not if an API has been used already.
> > IMHO, this case is really different though...
> >
> > > What bugfix does it provide?
> >
> > It fixes that code in stable kernels which would return wrong
> > time values *if* someone would create a libc for 64-bit parisc
> > and would run it with those "stable" kernels.
> > Fixing it now has no side-effects, the change is a trivial
> > 2-line-removal patch, would bring the code in sync with
> > newer kernel source code, and it really fixes existing code.
> >
> > I still believe that this justifies for a backport.
> >
> > Nevertheless, if you really disagree, I'm fine dropping the
> > backport to stable and will only push it in the next
> > merge window for v4.20.
>
> To clarify, you have no users of this api anywhere (hopefully), and so
> the patch in question prevents anyone from using the api in the future.
> This makes the suseconds_t handling easier for some reason because only
> sparc32 is a "problem" now, right?
>
> So I don't see the "bug" that is being fixed here.  I would have pushed
> back on the submission for this for the stable trees as well, this isn't
> anything that anyone is using, so there's nothing to "fix" that I can
> tell.
>
> Yes, doing it in the "future" is fine, to prevent anyone from making
> this mistake (are new machines even being made for this arch?)  But I
> don't see how this is a -stable issue.

The issue here is that glibc has in theory supported 64-bit parisc
user space for a long time, but it has never worked because of the
mismatch. It is very likely that there other problems like it that
/also/ prevent it from working.

Between changing kernel or glibc, I think it's clear that the glibc
has made the better choice of being compatible with all other
architectures (except sparc64), so changing the kernel is better
here.

Between fixing it this late, or doing it for the next merge window,
I don't care. There clearly are no users that are affected by it
today, and if there were, this would fix an important bug, both
security (kernel stack information leak) and functionality
(improving accuracy of gettimeofday() from seconds to
microseconds).

Between backporting it to stable or not, I'd be in favor of the
backport: If we ever want to support 64-bit user space on parisc,
then it's better to have stable kernels get the same working
ABI that new kernels have after the fix (and any other fixes we
may require on top). Or to put it another way: If the argument is
that there won't ever be a 64-bit user space for parisc and we don't
care about it, then we'd be better of removing all native 64-bit
syscalls from arch/parisc/kernel/syscall_table.S.

      Arnd

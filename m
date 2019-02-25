Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A7820643
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uHHmjMKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfBYRrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:47:09 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34647 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfBYRrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:47:09 -0500
Received: by mail-pf1-f193.google.com with SMTP id u9so4836440pfn.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 09:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F2GxijUcb98E/supSimmmluOYibCHtIyMB5HrY5lp98=;
        b=uHHmjMKLS5v+H4merzx13gpb8hwb8MXndRNVl1w7mlPxaPnyCX0WVrZVGxpaEXvfha
         T40sGm7N8uW7xNUaKDI7MPdetdcTeAA5aTS3UYTBuvGx5vMyHj+xTFlXRYHqT5BMrQrT
         3GC3TrjBNt12p3tEyX3ukXYcXn55sw5FOeWh4MeyKSo+Xg31YOOhvXbAgBNBDXomXNO1
         BMkSqF9l+5rYGzCCdPZHTxDw2n+rck78XizGUyLOK2Ee41/fgwCHItAxPjZtnO88jTDj
         bHBcsgGzQ4m5C3ckYa97wBeULKZhWU+GSLmWhtPfn6x90CW5SDiJ8Tr7gntv1mdbhRvw
         OvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2GxijUcb98E/supSimmmluOYibCHtIyMB5HrY5lp98=;
        b=FvG8UplbDdaUYquOTAaPotrCBnvxPKat+j1du+yjFxks0vjvDp+1dx2OLinm7nNfm7
         d2GomfIvQz9nVWmIDSiMjMWk6CnZJfPhTyP62VjlsLiWHiuOGYWNHxlyAfBnUcgNyRWz
         bzuaAqbMHTCxx/LcTnxuVw9xWyRI/V2AtIuzPzZ+edm4wxHqnmiaJL9+RwPSTc9sUjtS
         s+L5FbExvzZpcjeTRC2jg0mEPhzmEiML9g5vr5QlE1HQR8kOGbrGCaUqnmNlTQE5QYBU
         K8S6gwoZDncl10uvQIa9Q/hvkp+nRlIvj/Oq6JyVbDnzgUQLW/CLAJursSqfSijgeBJM
         lxGQ==
X-Gm-Message-State: AHQUAuZIUq3mp1YUX5mvwBf31wQ6euHZQr+O5KbCBf88L/KXK1z7NHvL
        wHNL41QYPc+Dfl2q5UTL4dWjhWdlE2KaBjp6TmSfLw==
X-Google-Smtp-Source: AHgI3IbpsDm7S9DxnGZ70tY7jTdHnfHwL45jBcz9ZgOk8kAleuj8DMOcfKk17f/b0uAUn9XsUA4K29pIvXwVueF92qw=
X-Received: by 2002:a62:a113:: with SMTP id b19mr21271201pff.227.1551116828002;
 Mon, 25 Feb 2019 09:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20190225061301.GA23411@archlinux-ryzen> <20190225144513.GA14055@kroah.com>
 <20190225144719.GA14597@kroah.com> <20190225173508.GA7885@archlinux-ryzen>
In-Reply-To: <20190225173508.GA7885@archlinux-ryzen>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Feb 2019 09:46:56 -0800
Message-ID: <CAKwvOdm9V-ejTLmkzR6P_p41rVPQQ=sENdTr0E_PtZepZFmTSQ@mail.gmail.com>
Subject: Re: Clang patches for 4.9
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 9:35 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Feb 25, 2019 at 03:47:19PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Feb 25, 2019 at 03:45:13PM +0100, Greg Kroah-Hartman wrote:
> > > On Sun, Feb 24, 2019 at 11:13:01PM -0700, Nathan Chancellor wrote:
> > > > Hi Greg and Sasha,
> > > >
> > > > Attached are three mbox files containing patches that bring the Clang
> > > > backports that Nick did in 4.9.139 up to date with what is currently in
> > > > 4.14 and mainline, as well as fix warnings that are present in the arm64
> > > > and x86_64 defconfigs here and in AOSP (cuttlefish_defconfig). All of
> > > > these warnings are fixed in 4.14 so there will be no regressions from
> > > > upgrading.
> > >
> > > Really?  I see a number of these only showing up in much newer kernels.
>
> Sigh that's what I get for not double checking my email after adding
> patches :(
>
> > > Specifically these patches:
> > >   1f60652dd586 ("pinctrl: max77620: Use define directive for max77620_pinconf_param values")
> > >   a0dd6773038f ("phy: tegra: remove redundant self assignment of 'map'")
> > >   a9903f04e0a4 ("sched/sysctl: Fix attributes of some extern declarations")
> > >
> > > from the "arm" mbox you provided.  Why shouldn't the above patches go
> > > into 4.14.y and in some cases, also 4.19.y and 4.20.y?
>
> They should. All three pick cleanly to 4.14.y. Only the first one needs
> to be taken into 4.19.y and 4.20.y.

I feel like I need a script that given a sha, tells me what LTS
branches the patch is in or not.  I have this to tell me "when (what's
the first tag that contains this commit)" a patch first landed:

function first_tag () {
  tag=$1
  git describe --contains "$tag" | sed 's/~.*//'
}

So say a patch landed in 4.15-rc1; and I want to backport to 4.9 and
4.14 (but it's already been backported to 4.14).  Does anyone have a
script to check this quickly?  The process for seeing which LTS
contains a commit or not still is very manual.  I guess backports that
require modification probably complicate the search further.  Just
asking, in case this is already a solved problem.

-- 
Thanks,
~Nick Desaulniers

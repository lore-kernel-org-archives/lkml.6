Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A546C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670A9218A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cnOG35KS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfBKWE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:04:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35126 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfBKWE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:04:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id j13-v6so435148ljc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=uclnA6iShABJh4c5ojTLgu+bzDzNObpzkIwzVTASP2M=;
        b=cnOG35KS0iJ94QrEONEnjElrQ1lTfGab+chRa8IGy82d+NXrgJnaQ4WKpqEUFua3B/
         BI+7g7bpV39yexXeazSHtYHaVZciBZytN3cu9xhblOb99wg6Rw7xjrCLIBpu4KbLTr7A
         Qxyv9wBvjQb7XTgWRgXIB1rn+tZM11slekwpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=uclnA6iShABJh4c5ojTLgu+bzDzNObpzkIwzVTASP2M=;
        b=PB1/ZQleSDamnlWAx0obt5kdpSC/E2Bpqp3KdLE9VDmSWvXNeOfh2MaQdGk0fDmlCc
         30/BYhz5A8zN2zIaBVWM11eGpXgjXHC/LcTaVguG6XGl/svs0MXRE/546qBcB0Rtl6T0
         cCmypdcAfJgBFhGmp9ac9UvGIJh4TW5mi2UM3jBtmhN2HYxSTaJO87VUVcqcYo8pMVPU
         5XDwZ3RnR2WqcAtcCsMwCEA0SST6FxGRPdyrXl2sMYH8Fpy6Z0e9jL58R0bNjUvDKsvW
         0e+I3H3LrrGLu7+vOsYZr0KDssgLBDf0z0tBBYzs0O0eqXvVVWERN77yQ1dO4MOsOFgI
         hw5w==
X-Gm-Message-State: AHQUAuZu5FukMazp86bYe5/CvEWsuCidO6zyd+KOwAonCEHDQi1BRL60
        MLDgWAaiBHNM1jmrcYPugsGqfRJAt8o=
X-Google-Smtp-Source: AHgI3IY4/A+3j/VuAXvSYyT9/GNIVAA8qGgiO+QVa46acb8tzX4TzFBuJx50DB66EQ0W/uRc28YR5g==
X-Received: by 2002:a2e:9e55:: with SMTP id g21-v6mr217125ljk.139.1549922666302;
        Mon, 11 Feb 2019 14:04:26 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id x26sm1555260lfe.45.2019.02.11.14.04.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 14:04:25 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id e17-v6so401394lja.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:04:24 -0800 (PST)
X-Received: by 2002:a2e:96c9:: with SMTP id d9-v6mr240461ljj.105.1549922664252;
 Mon, 11 Feb 2019 14:04:24 -0800 (PST)
MIME-Version: 1.0
References: <20190210041721.GA2805@localhost.localdomain> <154977271617.2362.11794417398216386913.pr-tracker-bot@kernel.org>
 <20190211031921.GA1799@localhost.localdomain> <CAHk-=wgz_WpD7jc084QROuM0zszEG0-WvQhQZPsCboMOWNRiWw@mail.gmail.com>
 <20190211201619.GA8065@work>
In-Reply-To: <20190211201619.GA8065@work>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Feb 2019 14:04:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg9yvP3hGVRSnc=8qoj0g7_zt=_2FjmgSAu-0DViyFtaw@mail.gmail.com>
Message-ID: <CAHk-=wg9yvP3hGVRSnc=8qoj0g7_zt=_2FjmgSAu-0DViyFtaw@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal-SoC management fixes for v5.0-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        pr-tracker-bot@kernel.org, Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 12:16 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> Okay, so I need guidance on the proper behaviour here. As this request
> didn't use the magic wording for the commit-id (as generated by
> git-request-pull), we ended up trying to look up the remote. The remote
> specified was:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes
>
> Since it's a short refname, we first try to look it up as a tag:

No, you don't do even that.

The name is "fixes". But you seem to match it with one of these:

> $ git ls-remote git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes^{}
> a6d25f4c951b8b28f2eaec6f891ff834622532f2        refs/tags/omap-for-v3.10-rc1/fixes^{}
> 77319669af37a1cfc844b801e83343b37e3c7e13        refs/tags/omap/fixes^{}

*NEITHER* of which is a tag named "fixes". One is named
"omap-for-v3.10-rc1/fixes" and the other is a tag named "omap/fixes".

Notice?

What git will do is

 (a) Never *ever* match against a partial name.

     git matches against this list of patterns:

        "%.*s",
        "refs/%.*s",
        "refs/tags/%.*s",
        "refs/heads/%.*s",
        "refs/remotes/%.*s",
        "refs/remotes/%.*s/HEAD",

     so "fixes" can match "refs/heads/fixes" and "refs/tags/fixes" (or
a *remote* called "fixes"), but it can never match against
"refs/tags/omap/fixes".

 (b) If you have an actual ambiguous name, git will indeed pick the
first from that list (so tags before branches, but also HEAD before a
tag called HEAD), but it will generally also warn:

        warning: refname 'xyz' is ambiguous.

So using "ls-remote" the way you are actually gives *way* more matches
than it should. The ls-remote pattern is really just a grep pattern,
not an actual ref lookup.

So if you want to look up tag 'x', you really need to match on
'refs/tags/x' exactly.

But that does explain why you thought it matched.

Anyway, the _real_ merge for that pull request has now happened, and
is commit aa0c38cf39de.

              Linus

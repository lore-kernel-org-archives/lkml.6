Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59262C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B362087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="s9qPdIAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B362087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390026AbeKQBbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:31:37 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:49305 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbeKQBbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 20:31:37 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wAGFIMtt001261
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 00:18:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wAGFIMtt001261
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542381502;
        bh=QgRVSbdNlpAhM3GhMg4oLHwLIoQd9IgUYkTYc/KwbC4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s9qPdIAhS9Ewq8zuIQG8/98QXNGpYPlgKLRzooxx17q1Rs1gTVNJtj8KZ8XGd1aKG
         q4gdm7rt8mIAINXTY/AVJop9+GgVB4VPsy1rUnlgPpJm9+0ECtoJ0w51kBkR1XFlRD
         Vqh/4w64VsORAk+3D58j23jXwmD7+BMX5/eO3T7mHpql9A0zTIWSWCpft33ACXE+u2
         K1/SEdTBcMA4osR1naz+nLA9YAw2ZtHBf83hccu3OTfmSFQaLwF8nld/wk320tvkOI
         yoY5IXgWdELy2TJgCeQcaK8uhKhKW9RomLwRLDFmt4NUpMekAuQvbND6qrODF3H8wq
         qwCMoOp1SPp+w==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id h78so13925518vsi.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 07:18:22 -0800 (PST)
X-Gm-Message-State: AGRZ1gKkXKMCQOLSl73jsXZxECgi+Cz3sfapC29iiL2A1lj669inN2Ju
        63+YmPRWPJ571hw7PJ3K9uf/kHmgwHl3ylW5Agc=
X-Google-Smtp-Source: AJdET5eHzhyRVzCgzsk4BCCoDGVpGywY9zpom3X3QWfGmM7bMppRxR+ww0eQ/gujcdv1jWCpkfCuromcs4NOfL6ONMI=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr4574957vsm.181.1542381501222;
 Fri, 16 Nov 2018 07:18:21 -0800 (PST)
MIME-Version: 1.0
References: <CAJ1xhMXDFAdiWMV6ODcJM8bfjs-ddyv8utf6N+Yh7+-Ne-KaHw@mail.gmail.com>
 <20181111.174140.002789201@genki.is> <CAJ1xhMUA4GUzeDANqR1WafELmEpE+-V569t7e0xCotTG2Lvbyw@mail.gmail.com>
 <CAJ1xhMWw8Mi2dubTFNOxhoP6hk+__Qjo-0+9sQbpqP5K-n4mVw@mail.gmail.com>
 <20181113000938.GA16783@google.com> <CAJ1xhMVFt6bYgwY+N5VoFXNpm5kS1j_HV8-ZS8SkavNgZx1HOg@mail.gmail.com>
 <CA+ASDXPcYp_joFeyGQ7TXFBSK-7i6bNFzaA1z=YYSDEjyMABdg@mail.gmail.com>
 <20181113190335.GA50985@google.com> <878t1w7hzi.fsf@igel.home>
 <CA+ASDXMuovgar22Z=sTcY=EV4KFtpwpjgdFOqvqAUYZEykzcWw@mail.gmail.com> <20181115021116.GA195691@google.com>
In-Reply-To: <20181115021116.GA195691@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 17 Nov 2018 00:17:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNATWu=LdYgdAX4S6WG3OjN928r-6nFB2HWQRAdAfFS_DeQ@mail.gmail.com>
Message-ID: <CAK7LNATWu=LdYgdAX4S6WG3OjN928r-6nFB2HWQRAdAfFS_DeQ@mail.gmail.com>
Subject: Re: [PATCH v3] scripts/setlocalversion: Improve -dirty check with
 git-status --no-optional-locks
To:     Brian Norris <briannorris@chromium.org>
Cc:     alexander.kapshuk@gmail.com, Genki Sky <sky@genki.is>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christian Kujau <lists@nerdbynature.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        schwab@linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 11:12 AM Brian Norris <briannorris@chromium.org> wrote:
>
> git-diff-index does not refresh the index for you, so using it for a
> "-dirty" check can give misleading results. Commit 6147b1cf19651
> ("scripts/setlocalversion: git: Make -dirty check more robust") tried to
> fix this by switching to git-status, but it overlooked the fact that
> git-status also writes to the .git directory of the source tree, which
> is definitely not kosher for an out-of-tree (O=) build. That is getting
> reverted.
>
> Fortunately, git-status now supports avoiding writing to the index via
> the --no-optional-locks flag, as of git 2.14. It still calculates an
> up-to-date index, but it avoids writing it out to the .git directory.
>
> So, let's retry the solution from commit 6147b1cf19651 using this new
> flag first, and if it fails, we assume this is an older version of git
> and just use the old git-diff-index method.
>
> It's hairy to get the 'grep -vq' (inverted matching) correct by stashing
> the output of git-status (you have to be careful about the difference
> betwen "empty stdin" and "blank line on stdin"), so just pipe the output
> directly to grep and use a regex that's good enough for both the
> git-status and git-diff-index version.
>
> Cc: Genki Sky <sky@genki.is>
> Cc: Christian Kujau <lists@nerdbynature.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Suggested-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>


Worked for me, and clean implementation. Nice!

I will wait a few days before I pick it up
in case some people may give comments, Reviewed-by, Tested-by, etc.




-- 
Best Regards
Masahiro Yamada

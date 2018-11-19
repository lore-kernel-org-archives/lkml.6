Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C40C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F247206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="m1elgbwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F247206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbeKTBG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:06:57 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:34158 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbeKTBG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:06:57 -0500
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wAJEgjwu025681
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 23:42:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wAJEgjwu025681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542638566;
        bh=W+HmOS41MvFNGmZWp1Sg20VIsCpePisC0GdiMwACNfQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m1elgbwDv1PaN6mtmkL1OvpBLU0QZKvmnpp0wxF/JeDA3lEgYuWUUb+Z7pS2ZjDcs
         l1kfQEab1HnnK310my3W06l9VjNaIng0EWim7cMrSpv9Xl43qzD3ahYEZpQT/6mk4N
         4uzCeOjicsY9lozBQ0EDl6HCAr+Z8AXqNXfY+ReWazE92wpWH3jBn52eBTYgvqKIAy
         c1OIUlmUCmX9c1Z6q0NKQ3pa+qByj1zb9GMMYE33sZI37wBN6rMTbknW1eWuYd1E13
         ckcjh+FNLPP0hXjeA1OjkwShxAPMllxW9gafpvXPzJ5kvkLQpFvE4FYXyFRzRVDrTD
         oxFccR664EqZg==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id r14so17861261vsc.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 06:42:46 -0800 (PST)
X-Gm-Message-State: AGRZ1gJhtpMXik47KJeyL1/+Zrowgev2q/rnSMyKxrUooeYMA/8xBLWR
        MszQRHXML8aLap4kLUNinjs1j7JEyik6xRwrUsc=
X-Google-Smtp-Source: AJdET5exihuHijzSuQYwoq5GEz1T3k7MbsYzbxrShlWGpV3sTjSnbYA600rgD2A0bYn76jr+ZVBGgNcoxOn6bV0yIqI=
X-Received: by 2002:a67:485:: with SMTP id 127mr9617960vse.54.1542638564929;
 Mon, 19 Nov 2018 06:42:44 -0800 (PST)
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
Date:   Mon, 19 Nov 2018 23:42:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNASaEkUH4egjXVmyKP2awAEccF4_WJacxh=VWA+N3nB-qQ@mail.gmail.com>
Message-ID: <CAK7LNASaEkUH4egjXVmyKP2awAEccF4_WJacxh=VWA+N3nB-qQ@mail.gmail.com>
Subject: Re: [PATCH v3] scripts/setlocalversion: Improve -dirty check with
 git-status --no-optional-locks
To:     Brian Norris <briannorris@chromium.org>
Cc:     Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        Genki Sky <sky@genki.is>,
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
> ---
> v1 -> v2:
>  * handle empty (non-dirty) results properly, where
>      echo "${empty_variable}" | grep -qv "${something_else}"
>    always has a 0 exit status (a blank line is an inverted match for any
>    non-blank expression). Just pipe directly to grep instead, with a
>    hopefully-not-too-permissive regex to handle both versions.
>  * actually tested with dirty and non-dirty trees this time
>
> v2 -> v3:
>  * switch to extended regex (-E), instead of relying on GNU extension
>    (\?)
> ---


Applied to linux-kbuild.
Thanks!


>  scripts/setlocalversion | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index 71f39410691b..365b3c2b8f43 100755
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -73,8 +73,16 @@ scm_version()
>                         printf -- '-svn%s' "`git svn find-rev $head`"
>                 fi
>
> -               # Check for uncommitted changes
> -               if git diff-index --name-only HEAD | grep -qv "^scripts/package"; then
> +               # Check for uncommitted changes.
> +               # First, with git-status, but --no-optional-locks is only
> +               # supported in git >= 2.14, so fall back to git-diff-index if
> +               # it fails. Note that git-diff-index does not refresh the
> +               # index, so it may give misleading results. See
> +               # git-update-index(1), git-diff-index(1), and git-status(1).
> +               if {
> +                       git --no-optional-locks status -uno --porcelain 2>/dev/null ||
> +                       git diff-index --name-only HEAD
> +               } | grep -qvE '^(.. )?scripts/package'; then
>                         printf '%s' -dirty
>                 fi
>
> --
> 2.19.1.930.g4563a0d9d0-goog



-- 
Best Regards
Masahiro Yamada

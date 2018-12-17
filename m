Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E5EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D09C20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BGUoRuLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388495AbeLQSAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:00:36 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42984 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbeLQSAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:00:35 -0500
Received: by mail-yb1-f194.google.com with SMTP id m129so5416705ybf.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IoczmUWVczTqXn4mjZjtTM7DgWRIyDZ6tJA7/fcL3m0=;
        b=BGUoRuLQVKWZ+GbmnZn9ahLSpF2FqxsTcalFkyJwY9+5p2UobvPlwMJ76KXuEDw0Hr
         yUGM0Ui2vPi5+iSGBf/EdYlCzATUHt1u7kgEcdUqoj4y66GZCX1/mAXr9U6bnT6dVggP
         UU566UN+zSkYl4ABeQmTL2vEEr1zJwT/7zxBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IoczmUWVczTqXn4mjZjtTM7DgWRIyDZ6tJA7/fcL3m0=;
        b=I3jhI2aEuhH62/FvVk8IoAYI/L8GNfVKQYG9jKIkq811T0lSudN1aVbIc18+2QFGQK
         igLTF5eiQgZhgAf/VbZsxRiBP4uFP5iXQnlKmJxayiwTLOzo9NLqj4cQkSc7zO01Ovs1
         lnVWasyOsQ373LYk2foaXoyD3W0Nhk8/Exc3mHJQHJEAfTtbdTu4VnpZKY2Uj3j6tVDZ
         Zng0szdX3rKZhavyylECWLpRkZucPlSRg5JDoNKRW/d/52U72ZtiSmEmeRRwAZgRWWsU
         oNA9vzcWvF33T/cFHA7RXciX+1JC3sv7O1KLB152/VSAYITx69ovsN65t7wv4GoqWelI
         IQ7A==
X-Gm-Message-State: AA+aEWYfQV2FmVme7E2q+9MxLns7iVAeSEuKWN8jnx4xcWO/DixHTAn+
        bL3Y6yfBJuLDnaKJ5OS2BVheinfZB0k=
X-Google-Smtp-Source: AFSGD/X1aEUyPRhywV8bBSGMN9jM32XAlbbaQHiOV3WKco7ZJiStc48pVDLdU67HlHPISWivBuGJeQ==
X-Received: by 2002:a25:b990:: with SMTP id r16-v6mr13602487ybg.74.1545069633556;
        Mon, 17 Dec 2018 10:00:33 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id k62sm3108470ywk.84.2018.12.17.10.00.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 10:00:31 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id d136so5410049ybh.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:00:31 -0800 (PST)
X-Received: by 2002:a25:b783:: with SMTP id n3mr14486556ybh.141.1545069631185;
 Mon, 17 Dec 2018 10:00:31 -0800 (PST)
MIME-Version: 1.0
References: <20181214162556.GA7944@beast>
In-Reply-To: <20181214162556.GA7944@beast>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 17 Dec 2018 10:00:20 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKw8sZp8PjkSG+KZVaMdb3ryLPOAgRdOxBRPiZJF3PGtQ@mail.gmail.com>
Message-ID: <CAGXu5jKw8sZp8PjkSG+KZVaMdb3ryLPOAgRdOxBRPiZJF3PGtQ@mail.gmail.com>
Subject: Re: [GIT PULL] seccomp updates for next (part2)
To:     James Morris <jmorris@namei.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 8:26 AM Kees Cook <keescook@chromium.org> wrote:
>
>
> Hi James,
>
> Please pull these seccomp fixes for -next.
>
> Thanks!

Friendly ping: James, can you pick this up for -next?

-Kees

>
> -Kees
>
> The following changes since commit fec7b6690541b8128663a13c9586b1daf42b0a6c:
>
>   samples: add an example of seccomp user trap (2018-12-11 16:32:11 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-next-part2
>
> for you to fetch changes up to 4fc96ee9085d39ceeaa7b60cd475d0a474e7062f:
>
>   seccomp, s390: fix build for syscall type change (2018-12-13 16:51:01 -0800)
>
> ----------------------------------------------------------------
> seccomp fixes for sparse warnings and s390 build (Tycho)
>
> ----------------------------------------------------------------
> Tycho Andersen (2):
>       seccomp: fix poor type promotion
>       seccomp, s390: fix build for syscall type change
>
>  arch/s390/kernel/compat_wrapper.c | 2 +-
>  kernel/seccomp.c                  | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> --
> Kees Cook



-- 
Kees Cook

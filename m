Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EDCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5291720831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0SKeouH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5291720831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeKSU6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:58:47 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:49976 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeKSU6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:58:47 -0500
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wAJAZLFO015987
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 19:35:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wAJAZLFO015987
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542623722;
        bh=R2aLo/QTYYxhbLbN+2LZAAQRs03RBwg6SaaPD0kAfS8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0SKeouH/M4SPQUNXQNtXl5AhrJyUecLSYS/ubkk3Y6W6sfi+mNGm1bdoYg1TYcOFm
         Fu3WPdvoRLzyAJWKPrVuCfLSA3UnU59kLoRPtYOkbFHLNscfSP3anLdCeSScUGJndF
         B6ibCdArrtkZrh6zDa3cF8ID4bbiJVE1Xy9VvhqP/D1yYnxjHSflF01y90lYE4rrXB
         wBPmd6jKq9BkSBI1rBvodS0DkH/p5K1FuOxPifSUbtSdqTlMy1a9cUcnv215SD/Omk
         bsCt15NV8OtAf1iOAfmrFKW7YRltrcjCXded2HM/8BSlaJjxu7ivfLX5JR/tzc/9o4
         7nX2IYWeZRR7A==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id k10so10498733ual.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 02:35:22 -0800 (PST)
X-Gm-Message-State: AGRZ1gJAlg/AxmccsN/bUtyWnzMDuqtCMunrzfZDJXQlXgBhMCGoO1CB
        RVXRqCQzi4CRZRjhlIiqrLgqEHRUG/3dxazm82I=
X-Google-Smtp-Source: AJdET5egnHvk+plHqnlprpl3tnLWPdRlNY49iVMTpoOHYy+UbHtwdr05zALKFvV6OkgPdKYBoGWjtGg4eVMtQnykoXs=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr8940941uaj.42.1542623720844;
 Mon, 19 Nov 2018 02:35:20 -0800 (PST)
MIME-Version: 1.0
References: <1542349645-8852-1-git-send-email-yamada.masahiro@socionext.com>
 <1542349645-8852-2-git-send-email-yamada.masahiro@socionext.com> <20181117003109.jdac5rmjdmpmino7@ltop.local>
In-Reply-To: <20181117003109.jdac5rmjdmpmino7@ltop.local>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 19 Nov 2018 19:34:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNASrWhSbP7=g-iMvEdr48ZLCp+dhgpSUkURC+r1XZiM16Q@mail.gmail.com>
Message-ID: <CAK7LNASrWhSbP7=g-iMvEdr48ZLCp+dhgpSUkURC+r1XZiM16Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] build_bug.h: remove all dummy BUILD_BUG_ON stubs
 for sparse
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 9:33 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Fri, Nov 16, 2018 at 03:27:25PM +0900, Masahiro Yamada wrote:
> > The introduction of these dummy BUILD_BUG_ON stubs dates back to
> > commit 903c0c7cdc21 ("sparse: define dummy BUILD_BUG_ON definition
> > for sparse"). At that time, BUILD_BUG_ON() was implemented with the
> > negative array trick, which Sparse complains about even if the
> > condition can be optimized and evaluated to 0 at compile-time.
>
> OK, but from what I understand, the motivation for commit 903c0c7cdc21
> was not to avoid false warnings but to avoid having twice the same
> warnings: "... So it causes sparse to detect an error too. This
> reduces sparse's usefulness.").

In fact, Sparse was producing false positives.

I mentioned this in the commit message of v3.


> I'm not opposed to this patch (on the contrary, I think it's better
> to have exactly the same code for GCC than for sparse) but I think
> that your commit message need to be adjusted.
>
> Kind regards,
> -- Luc



-- 
Best Regards
Masahiro Yamada

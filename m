Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA4FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685A520658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XLYFS8ge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685A520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeHaUyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:54:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35708 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbeHaUyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:54:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id 7-v6so752768pgf.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 09:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5lvQdgD/EXcDOV9R8OuQUbo/2DyQX0Rl0dUcicH6fsY=;
        b=XLYFS8geXPIrgarFkNKVxqNESUrc7geuGcov3/laCMY9pa8C4DtOiBpnBeB/RUn2D/
         alqrLkkFL2pDzK6kMxY+M9s7BQpgMcIe5ujnHD6DsfsyzhTdpQvZUThmmKY7sffLYJ6K
         9+XVt1YMUnOdTxBcCX+AQ7ZmzV+dJ/zWeSA9BBNebpq4fudgkdJiONS9qdDo5jcfdl5b
         l9s2vEAF3TZcVnYCAbdJJ1iGKVEmWNbc9F7tKDmvKjr+VT4HhzKXd9OyBNmuB/bQGFJK
         coO8gkHhR6GZDQgZtH6jTY0KmPlt9dRUiIayCmOvDF9ftsYH2nzfpu8WNvsRZwAPNHEo
         KJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lvQdgD/EXcDOV9R8OuQUbo/2DyQX0Rl0dUcicH6fsY=;
        b=WcFIaxrP187BqxFIkLMnnEcz2NjhCNVWKvl4zB07KlwZymchiUczEwNMK1kcYHzrop
         2gkPVCPdcaTXF/gpyxaczu6UuK9x+p2zk7FdF9LjMoi0gCogANUKgYYPssS+oYfpAVX4
         4bskb685TkU72rREVEu7Zd7iNgaLCO9WmMhcL0LKszYWc6fzt3bNw64uF0nXYPOmw+GU
         UN8bapnhzgYWwtPDAGNpckY8rUIzGnpHbaFeexhGmLCk/DsFYMYRI5vmF30j4XoWebWL
         tBTOfIg71EKY0GHKndlTG9CWI+btKSCYIFl3Y3S9uk+FTq5DM7fjJ3grT2OBojWZmOWf
         23gA==
X-Gm-Message-State: APzg51C1C0Hs/QdatQ2PD9F+yohxgUUbBKPfMuRYhRaWPImbUtxGmK3M
        4vn2adrs0/dU7NVityChmTIUtJweOC9IJvw47kH6sQ==
X-Google-Smtp-Source: ANB0VdbOrErQLwsxSqSiOUUgltAc0By1++KcxctDSMiE/Z2qEUH4CDRz+dQo15tl76PKKyC87P5iVuNrPrdkp5/JcN8=
X-Received: by 2002:a63:1921:: with SMTP id z33-v6mr7282517pgl.302.1535733973960;
 Fri, 31 Aug 2018 09:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <1535220989-27645-1-git-send-email-yamada.masahiro@socionext.com>
 <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com> <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com> <CAKwvOdkD0cmF5373LRS92U--ptRvikSrG_oKyE-AiaybCQYMBg@mail.gmail.com>
In-Reply-To: <CAKwvOdkD0cmF5373LRS92U--ptRvikSrG_oKyE-AiaybCQYMBg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 31 Aug 2018 09:46:02 -0700
Message-ID: <CAKwvOdnyA=Y_+KnJrDc5mu7twTAEOMXvb8cAZhwzsXTi7a9sEA@mail.gmail.com>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>, sparse@chrisli.org,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        daniel.santos@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 4:00 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Aug 27, 2018 at 1:42 PM Daniel Santos <daniel.santos@pobox.com> wrote:
> >
> > Hello Nick,
> >
> > On 08/27/2018 03:09 PM, Nick Desaulniers wrote:
> > >>> Let's give up __compiletime_assert_fallback().  This commit does not
> > >>> change the current behavior since it just rips off the useless code.
> > >> Clang is not the only target audience of
> > >> __compiletime_assert_fallback().  Instead of ripping out something that
> > >> may benefit builds with gcc 4.2 and earlier, why not override its
> > > Note that with commit cafa0010cd51 ("Raise the minimum required gcc
> > > version to 4.6") that gcc < 4.6 is irrelevant.
> >
> > Ah, I guess I'm not keeping up, that's wonderful news!  Considering that
> > I guess I would be OK with its removal, but I still think it would be
> > better if a similar mechanism to break the Clang build could be found.
>
> I'm consulting with our best language lawyers to see what combinations
> of _Static_assert and __builtin_constant_p would do the trick.

Linus,
Can this patch be merged in the meantime?

-- 
Thanks,
~Nick Desaulniers

Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C45C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D8B2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UdmuLwj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D8B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeHaWw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:52:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34877 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeHaWw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:52:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id d9-v6so5860890plr.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMzGZ2Op4NcYEQUnOF+QtQxIHQ2pSMyF4605uy6pHZU=;
        b=UdmuLwj0ZS6Y/v2NJ9yKDX07xWbuJCbvVeHqFymgW9ALu0tHcE0wULApVIf6VVn3UV
         1zp1CcG5YCU/m12H2uQBm2SccsOdnzZrbLExkm6aXM8wI81RoXAz3ClPapWv6dWbgzjq
         pmH1GHrFf9Qvz+gso2eOqxujSL3bb/QLcb4kIDySMx8FEVngNj2Uu/V7r6IqzsKJpsj3
         mLtDpzAe12Q8ChJmSWnhIITvXsHH+whAmrsqvRkxahveWm+nfD/NSkSZ819HVxXm/Top
         HK9nl+P7wbgtDaW8DuM3gCk/9j1P3Ip/WnHNWkVYT9UCx+4brVkEON7lAHT6p8QObZeC
         O3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMzGZ2Op4NcYEQUnOF+QtQxIHQ2pSMyF4605uy6pHZU=;
        b=Tl/l8sxp+E4/l/BiVypPvs+vYS2zPVCbMq4Z16ihZyC6QI4HqsFV+r4KjA1Bdi13PQ
         XgO1vONTffVCH1j6JPNYqno+Zy26zQRA/B6JQSaOGufxseYFpFD6a2vn5qVQk80twM2b
         +r2cInzJr/AxyDjSf6CMze41xbRGrVkvLioU5PmzVvBX5NwEZBno6x2MdSOK8PCNapdJ
         1kdYdRt2e188XgStybQ8IrBMBM+EgPnJcruZXAK/46Jygy1rNm12l7MNwVpT/mKjSPYh
         GfJl8lUQ6aTmszBoXE/G+k1F2z9hQhxj931MxB00dFZ5ug2tC9g/PY9gQtCCX+O0XABP
         sQdQ==
X-Gm-Message-State: APzg51CRijlzRml7Y4Bm+BwvV6ByRLBlXO35D4IANeC4/kEa0Yx0v4Ke
        TAKHMfVn/YYh96lpcqSyxcTQ3zS71WGX/8HRmZd7iw==
X-Google-Smtp-Source: ANB0VdYsiMmwWbKGQvlFh14f4BdNJibB5LDSCM/P2QkvTsZzBGpVotweOZzhYpMnNXo49etStRujbhcsKtEfHbJZePM=
X-Received: by 2002:a17:902:b7c3:: with SMTP id v3-v6mr16815969plz.238.1535741020280;
 Fri, 31 Aug 2018 11:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com> <a1d6922dea4f80be097fdb912a545727ff96f1b1.camel@perches.com>
In-Reply-To: <a1d6922dea4f80be097fdb912a545727ff96f1b1.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 31 Aug 2018 11:43:28 -0700
Message-ID: <CAKwvOd=kePHrDA7NJKyu8aiXVt7iRsxXNRe3tkG3rp-c0xpO5A@mail.gmail.com>
Subject: Re: [PATCH 1/7] Compiler Attributes: remove unused attributes
To:     joe@perches.com
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, efriedma@codeaurora.org,
        sparse@chrisli.org, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        asmadeus@codewreck.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 10:28 AM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2018-08-31 at 19:05 +0200, Miguel Ojeda wrote:
> > __optimize and __deprecate_for_modules are unused in
> > the whole kernel tree. Simply drop them.
>
> Nice series, thanks Miguel.
>
> It'd be good to have a cover letter for the series.
>
> And I believe there should be the equivalent of:
>
> #if GCC_VERSION < 40600
> # error Sorry, your compiler is too old - please upgrade it.
> #endif
>
> for compiler-intel.h and compiler-clang.h so that
> each supported compiler minimum version is checked.
>
> Is it clang > 13 and icc > 3 ?

Eh, I'm not sure I want to commit yet to a specific minimal version of
Clang.  Right now, we're fixing things so depending on arch's and
configs, the answer might be Top of Tree clang builds.  For Pixel, we
shipped with Clang-4, but pretty quickly we needed Clang-5.
https://lkml.org/lkml/2017/11/22/943

I had sent patches previously for detecting clang version from the C
preprocessor, maybe I should dust those off, then commit to clang 5.

I don't think minimal supported versions are required for these clean
ups, and would not block these patches from landing on that.

Also, haven't found anyone using ICC yet to comment on minimal version
requirements.
-- 
Thanks,
~Nick Desaulniers

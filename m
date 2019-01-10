Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9C7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A17F2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uliuAEyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfAJATn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:19:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33399 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfAJATm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:19:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so4040537pgu.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xeoX7/XEeDdzeXfKpRk/PRonAOglFFarSXEpTPTptTM=;
        b=uliuAEyDtrVBmw6hxxiwAojGUiM4bdRkFH5xFM0DYfpjO4knNrsYwjQyg+AfUPaGXZ
         hhuJP+nkij/INe5JZfU7V1+dT52sVO5d9wzZkYvTLG9PQMD558SdOWXJf/W3EvFRbbdU
         j8fhy4uwI0ecNLUEnzJcz4KkkdHxHvcrEEapG9dH6O4geJTAJhOL7Vxx4MBopY+wKiCn
         U+RmegS+c/Ae9xlmvkSJkyrNmzM5g9pMsdBFGFAC4RfAmFwJJyGgxJDp+q/ul/uoTSnX
         vXTI6+ye4xjYS5pcX3Dn8/BTN1SaVVrjt9f3MTemdgo05B8h74tt/qqSPaYJquLVhXzn
         qC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xeoX7/XEeDdzeXfKpRk/PRonAOglFFarSXEpTPTptTM=;
        b=q778ae1AYKgDI9c4mtM84eSsT6iTXtQ2aqS0dIkcN+PsONpGZZDp0UyBxRfpY3J4Bg
         4gSCHLzZmP7Myq36gwOvqJXFUxKi3V1D4J4PjGD+qfuL+JbOu3maudpgNygf4gz/VaXs
         NBdPp1wW7/NxRyLIJJjFS7zYVyiCjWlJjHgGUb7PZJLXm4RlCmM0w+cSPAFBxYU5KU8m
         b9NMBJunTwPuH+x71ti0v0WyTBrEBUk8G1kc2gIZEOGPTC2UvBuc0q/HAMSgBzkxD2Dq
         Lesqi5V+iU/2HaNZdigEMECNxzuhpgNGNuuBn8er67rRs8dqkfSoV4E4yG271DNXEfwq
         f2Zg==
X-Gm-Message-State: AJcUukf5EsmfuQ2rk/rgT5nQ19Bx5fNzXbgq8IN+gAUEUsp1G+z93e//
        sAN9BpDEegkMNfwwzjw8IsXgpdt93cO2nIX2fURDeg==
X-Google-Smtp-Source: ALg8bN5mp14UtJUAnPQY0yQTCTPafxyIafnug8UUocGsohAu3DyhrkQlN8kXSPF8DVMr9bvwOR9gopKYp1HyLrYYSZo=
X-Received: by 2002:a63:a064:: with SMTP id u36mr7397882pgn.145.1547079581694;
 Wed, 09 Jan 2019 16:19:41 -0800 (PST)
MIME-Version: 1.0
References: <20180926232055.31951-1-natechancellor@gmail.com>
 <20180927051634.GA32508@kroah.com> <CAKwvOdm3Au2V159PtripyZReZf167TtL5o7P9uYY-okr+n4xPw@mail.gmail.com>
 <CAKwvOd=NkgAWVGCS4Mb=Mgs5iu-uX1Kp=fjYSHhXAnh4gAQ-8w@mail.gmail.com>
In-Reply-To: <CAKwvOd=NkgAWVGCS4Mb=Mgs5iu-uX1Kp=fjYSHhXAnh4gAQ-8w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 9 Jan 2019 16:19:30 -0800
Message-ID: <CAKwvOd=+Vqm2FdZ-nb7j2eVTHuP2dWBmiYyZ0WLMEERK9NqNKA@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: Mark ACPI table declaration as used
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        sedat.dilek@credativ.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Digging up an old thread to point out I was wrong:

On Thu, Sep 27, 2018 at 1:08 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> > This is not a million-little-commits problem; more like 2 drivers in
> > the whole tree have this problem.
> >
> > Note that this change that Nathan has DOES NOT need to applied to
> > every driver that uses MODULE_DEVICE_TABLE.  Only when the struct has
> > no other references other than JUST being passed to
> > MODULE_DEVICE_TABLE() is this a problem.  For an allyesconfig, I only
> > see 2 instances of this case in the whole tree:
> >
> > https://github.com/ClangBuiltLinux/linux/issues/169 <- this patch is addressing
> > https://github.com/ClangBuiltLinux/linux/issues/178 <- waiting on the
> > results of this patch
> >
> > If you're ok with this change to two drivers, then:
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

I just landed a fix for this in Clang
(https://reviews.llvm.org/rL350776) which will ship soon in Clang 8.
Sedat helped test this patch and reported that it removed 41
false-negative warnings
https://github.com/ClangBuiltLinux/linux/issues/232#issuecomment-440006399
-- 
Thanks,
~Nick Desaulniers

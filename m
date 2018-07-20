Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDF9ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E6F20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiCkM49u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E6F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbeGTHSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 03:18:24 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:43014 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbeGTHSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 03:18:23 -0400
Received: by mail-ua0-f194.google.com with SMTP id x24-v6so6802415ual.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 23:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jNWinEElFELQIO109coa3xeLIy0FduNHy6bx8WmGWwA=;
        b=WiCkM49u+VnseZ+fIzut1yG1BG2+9Fb+curjUTfageo/0gmiDF4uTYyK7BFjrS9aug
         hxFZ+0zAp2XzA8IbBpBVfWnoPhbHNXe2gVr7cEAwWHB4QTLICpiIDGK8ZXiulhDXpE01
         2wsVjH0F1z/I+JYHpIr0kuhlqLeSaTmJLnthCJ787bwlfBNPdEXHclwP92FN1ZpUwgjL
         EwrMzRvIiMr8Y2Ofv/+bZAQMjj9XbSJWx/EQRLcechPM5nsiFmkAf2e35G5GWlnpRv3y
         eqB21V0+0Gusd6laieIojHQfgDrLIKL2xG9V2/UkJGhvOBC02YQnfdR46vbS59K4YI8Z
         yPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=jNWinEElFELQIO109coa3xeLIy0FduNHy6bx8WmGWwA=;
        b=cskplZShHhqzYD5WZ3CY1h1f8IKZ1wjK0lyVI4FP5K6ALoA39+t3SSiy2ZwRQQlY1X
         4Vp9G0NFRYOAAxobzLF8v6LyJuWXIX8sRNwEl6WQtQaBECXxwj8CfefT8B2yHibuoZOz
         uQZfXgbCwUp7F6b27EpDo4Uiq6NgKl2PfUNeZcd7sajVCYJn+98NoildhfnwF7+QRGNo
         uK8esAPILDgHcJM6r5D3Du4dwBL41P+DCULqHj+SVXV1X9llo6nlETD7KM0VstHIWupX
         RxAQ0dgr7dEG1hN4vxOF0apxSUeN5bzlG+CCK629Tru0a+GS4lSLZaPNpqvV6ubQGrsz
         n2Zg==
X-Gm-Message-State: AOUpUlHukVA2r85/ixuIlJPYz3WONEnrgHPKImlOSozo6ku0RLfvRM7t
        l5DvMxLhl57bMbNXiVRoWmUE0Pw9KOPQfUk0ZkM=
X-Google-Smtp-Source: AAOMgpcSyHHt65MwV7nFAjXFO0+pdMsMLCrvjVmarP9NrHeW/kX5UfoH1cItNqf8DQ1XGFqduQPKVMM48Yeo6X4auiw=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr459770ual.141.1532068303259;
 Thu, 19 Jul 2018 23:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1531124135.git.greentime@andestech.com> <CAEbi=3fi9dZCzZjMFDXQGPNjpbT9+PP0WDUNf2e1mFtXLP0Omg@mail.gmail.com>
In-Reply-To: <CAEbi=3fi9dZCzZjMFDXQGPNjpbT9+PP0WDUNf2e1mFtXLP0Omg@mail.gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 20 Jul 2018 14:31:07 +0800
Message-ID: <CAEbi=3e=sdjQ-VzE5RBus2S5=q5hLJri9pRgP9XyZ8PFuQsWmw@mail.gmail.com>
Subject: Re: [GIT PULL] nds32 fixes for 4.18
To:     Greentime <greentime@andestech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greentime Hu <green.hu@gmail.com> =E6=96=BC 2018=E5=B9=B47=E6=9C=8817=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=882:34=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Linus,
> Greentime Hu <green.hu@gmail.com> =E6=96=BC 2018=E5=B9=B47=E6=9C=889=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:19=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56=
ab40:
> >
> >   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> >
> > are available in the Git repository at:
> >
> >   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/greentime/linu=
x.git tags/nds32-for-linus-4.18
> >
> > for you to fetch changes up to 987553894f0ce8c1d83578136603a89009f42d35=
:
> >
> >   nds32: fix build error "relocation truncated to fit: R_NDS32_25_PCREL=
_RELA" when make allyesconfig (2018-07-05 16:13:47 +0800)
> >
> > ----------------------------------------------------------------
> > nds32 patches for 4.18
> >
> > Here is the nds32 patch set based on 4.18-rc1.
> > Contained in here are the bug fixes and building error fixes for nds32.
> >
> > These are the LTP20170427 testing results.
> >
> > Total Tests: 1902
> > Total Skipped Tests: 593
> > Total Failures: 418
> > Kernel Version: 4.18.0-rc1-00006-g987553894f0c-dirty
> > Machine Architecture: nds32
> >
> > Signed-off-by: Greentime Hu <greentime@andestech.com>
> >
> > ----------------------------------------------------------------
> >
> > Greentime Hu (4):
> >   nds32: To implement these icache invalidation APIs since nds32 cores
> >     don't snoop data cache. This issue is found by Guo Ren. Based on th=
e
> >     Documentation/core-api/cachetlb.rst and it says:
> >   nds32: Fix the dts pointer is not passed correctly issue.
> >   nds32: To simplify the implementation of update_mmu_cache()
> >   nds32: fix build error "relocation truncated to fit:
> >     R_NDS32_25_PCREL_RELA" when make allyesconfig
> >
> > Guenter Roeck (1):
> >   nds32: Fix build error caused by configuration flag rename
> >
> > Luc Van Oostenryck (1):
> >   nds32: define __NDS32_E[BL]__ for sparse
> >
> >  arch/nds32/Kconfig                  |  12 ++---
> >  arch/nds32/Makefile                 |   2 +
> >  arch/nds32/include/asm/cacheflush.h |   9 +++-
> >  arch/nds32/include/asm/futex.h      |   2 +-
> >  arch/nds32/kernel/setup.c           |   3 +-
> >  arch/nds32/mm/cacheflush.c          | 100 +++++++++++++++-------------=
--------
> >  6 files changed, 58 insertions(+), 70 deletions(-)
> >
>
> Ping.
>
> Did this please-pull get lost or is there another reason that prevents
> the upstream integration?
>
> Thank you. :)

Sorry for that I forgot to add your email.
Ping again. :)

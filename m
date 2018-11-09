Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4638EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECEB20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jEEaBwSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECEB20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbeKJCJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:09:35 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:33259 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbeKJCJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:09:35 -0500
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id wA9GS5sN018058;
        Sat, 10 Nov 2018 01:28:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wA9GS5sN018058
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541780886;
        bh=iBHJlD26G8IQ/Tpcn+xbn58aF33WVcfgE+SRD629VqY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jEEaBwSCF5SlYLvQuFeuLVbATHxkfNoZZIrIWoNX9A4GFFzBe5viwRIXqkPRSaelh
         4Rbd+ka0BHJf1XQbPdxW8P4nzmert7HDhWmojY5VFptssCNHx2yHnNT3e/4owjQT5R
         Aa+Sfe9lYmjVa4idJu0PtyX4obxZtm9GCd/UvSycygWo8Dc0kmtYAKmJ/A9keHygoc
         BuhF11mc9zR5xwbtexwIHIRJPaEKg0WOWwLBe9Qo1cE696PKBbEcvA9iV3+Xs7Huy8
         5kykHCgxREX4NvZucvg+mPe9NPEt5gVhaaCJQiDpSEC+/W4I+8mAMS5HrayDX9yOw3
         FTTH2NQA3KRnQ==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id p74so1378247vsc.0;
        Fri, 09 Nov 2018 08:28:06 -0800 (PST)
X-Gm-Message-State: AGRZ1gJFRgTUpzsCm6GCtdHyo9Jx5H8WhvEi+pFdAtahErMgh7n8rgtH
        7SoPE0i5q5DFpzieiLzJozYNJgO7wSq6wb/3SA8=
X-Google-Smtp-Source: AJdET5cCrBM6FJEIcC36UW/emOG9a0+sPMQZSHfXtN1p1wdpU8W59Xq5gbZ2oqrHFF5HI3k9DRsYSGiLZR5jeCtcOSk=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr4135836vsb.155.1541780884990;
 Fri, 09 Nov 2018 08:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20181028130945.23581-1-changbin.du@gmail.com> <20181028130945.23581-2-changbin.du@gmail.com>
 <20181028140911.21d49629@vmware.local.home> <CAK7LNATixykqHqdu5W3NpfXqBXMNsP0OLKjNdsFc_EzJ_diOxA@mail.gmail.com>
 <20181102112728.GC14602@zn.tnic>
In-Reply-To: <20181102112728.GC14602@zn.tnic>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 10 Nov 2018 01:27:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQcdpU+_LOYQ8X+4K4sxd3D-+Z7k6BuBjUOJ9LR0j+zfA@mail.gmail.com>
Message-ID: <CAK7LNAQcdpU+_LOYQ8X+4K4sxd3D-+Z7k6BuBjUOJ9LR0j+zfA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] x86/mm: declare check_la57_support() as inline
To:     Borislav Petkov <bp@alien8.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Changbin Du <changbin.du@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 8:28 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Oct 29, 2018 at 10:04:46PM +0900, Masahiro Yamada wrote:
> > On Mon, Oct 29, 2018 at 3:09 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Sun, 28 Oct 2018 13:09:42 +0000
> > > Changbin Du <changbin.du@gmail.com> wrote:
> > >
> > > > The level4_kernel_pgt is only defined when X86_5LEVEL is enabled.
> > > > So declare check_la57_support() as inline to make sure the code
> > > > referring to level4_kernel_pgt is optimized out. This is a preparation
> > > > for CONFIG_CC_OPTIMIZE_FOR_DEBUGGING.
> > > >
> > > > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > >
> > > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > >
> > > -- Steve
> > >
> >
> > Applied to linux-kbuild.
>
> Next time, before you route a patch through your tree, please get an x86
> maintainer's ACK first.


I changed my mind, and did not include this in my previous pull request
because this series is causing many warnings.

Now, it is aiming for v5.0-rc1

So, it is not too late.

If x86 maintainers issue Acked-by,
I am happy to add it.




> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.



-- 
Best Regards
Masahiro Yamada

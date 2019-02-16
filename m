Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CE8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 02:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E4F222A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 02:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LrqWH1Sx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733162AbfBPCI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 21:08:26 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:26147 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfBPCI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 21:08:26 -0500
X-Greylist: delayed 73126 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Feb 2019 21:08:24 EST
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x1G28IMm022673;
        Sat, 16 Feb 2019 11:08:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x1G28IMm022673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550282899;
        bh=JErR3fgFiQ72ZZEiKwWP6YSIo32wc/VrwAHm0YitJyw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LrqWH1SxDFqJhppZWSuQVmQ1l52qfmrtjXhzYVTDhjv0RzbAL/8Fkh/iUPLk5rffc
         926eIdgar/PaG+lNxJxRKwM9t/b34Qo9HDalD6DwRKoMKsogVWM4NjuFJD6ZIqxSQW
         VMZYn0lxJDj1W3dJrmZyiRmqqySDFOKH1XjCMI9Qgdf42fI8B501DrqFwb7Z6F87dR
         ARJHFoMX1saXYPlMP576eH7TrIA/bxJ0luHVW1hTw2c4EBLt/ZnytyaVf5asuRAoy9
         bWzZHqLyTD3BKSTw2QKd/5iP/gsOI8lmz1L1zwWV7zltiyW/WPayxp8pKi7vkGx+0a
         RFFHXr/UHqnkw==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id e81so3505025vsd.2;
        Fri, 15 Feb 2019 18:08:19 -0800 (PST)
X-Gm-Message-State: AHQUAuY2PxTRZ7MO2uo2CV4UixxPHnNVCQOEF3ysbCWZ0ppKxwN5z+x5
        rsdUAO9WVXs3P+AhTa4gJU3JKBYvyjzJbiTFl30=
X-Google-Smtp-Source: AHgI3Ia2p+8YoxNpxLcoBbk1Ow3HyaKQr4RCMeGqCUQ8i45JfhkNNanLIqTL73IbeyUIF/FhV/j0P6qJd7zXli6FQ9c=
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr474486vsq.215.1550282898003;
 Fri, 15 Feb 2019 18:08:18 -0800 (PST)
MIME-Version: 1.0
References: <1549943095-10956-1-git-send-email-yamada.masahiro@socionext.com>
 <CAKv+Gu8yLY+c6jNmHYkvP3n=xiojF7dcKBHmeGibUW2FUrEczA@mail.gmail.com>
 <CAK7LNASoyeFW=j9R=M2vaoLK_Gms1Z6hA_yKLyVSY=g5ALUi8A@mail.gmail.com> <CAKv+Gu8k63Fj2aPbQPLLvBXvJrdcu5NrODXuZKkb2n21AUM70Q@mail.gmail.com>
In-Reply-To: <CAKv+Gu8k63Fj2aPbQPLLvBXvJrdcu5NrODXuZKkb2n21AUM70Q@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 16 Feb 2019 11:07:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNARd6R31QyGn4MZdDeTfUVGhF7bOx+5ZyuY-c7kZ6fETsA@mail.gmail.com>
Message-ID: <CAK7LNARd6R31QyGn4MZdDeTfUVGhF7bOx+5ZyuY-c7kZ6fETsA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: refactor cmd_stubcopy
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alistair Strachan <astrachan@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 12:38 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Fri, 15 Feb 2019 at 06:49, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > On Tue, Feb 12, 2019 at 4:26 PM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > >
> > > On Tue, 12 Feb 2019 at 04:45, Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > > >
> > > > It took me a while to understand what is going on in the nested
> > > > if-blocks.
> > > >
> > > > Simplify it by removing unneeded code.
> > > >
> > > >   - if_changed automatically adds 'set -e', so any failure in the
> > > >     series of commands makes it immediately fail as a whole.
> > > >     So, the outer if block is entirely redundant.
> > > >
> > > >   - Since commit 9c2af1c7377a ("kbuild: add .DELETE_ON_ERROR special
> > > >     target"), GNU Make automatically deletes the target on any failure
> > > >     in its recipe. The explicit 'rm -f $@' is redundant.
> > > >
> > > >   - surrounding commands with ( ) will spawn a subshell to execute them
> > > >     in it, but it is rarely useful to do so.
> > > >
> > > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > >
> > > Assuming that it still works as expected:
> > >
> > > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > >
> > > You can test this by adding a statically initialized global function
> > > pointer to any of the libstub source files that get built for ARM.
> > >
> > > Thanks!
> >
> >
> > I tried that, and it failed as expected.
> >
>
> Great, thanks for double checking.
>
> Are you taking this directly, or do you want me to take it via the EFI
> tree? Either is fine with me
>
>

Could you apply it to your EFI tree?
Thanks.



-- 
Best Regards
Masahiro Yamada

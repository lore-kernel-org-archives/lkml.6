Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474E0C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0888207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="shBGv4vO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfBGAZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 19:25:19 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:45732 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfBGAZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 19:25:18 -0500
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x170OroZ018276;
        Thu, 7 Feb 2019 09:24:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x170OroZ018276
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549499094;
        bh=Lj4sksm1nfh6MMWu7jwAOv3We3IXD9imivybjU4bRkk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=shBGv4vOFRw72skM31j/evJ037MSBnMrTFEH2djQZdWxghH3gEfMaYlAwluJ9FdG2
         6GlbG/qoTceBIYvDSV7jL74gch8UbjALVx4bjhhovuzN5Pqin0lda9N4B04am9pXRk
         b0uiCad3p275B8wQGzEIn2zJwmg0KIiv30NLEm6PL6K7QrWwmAjOzN4h5WQMWlNAAo
         P3eHjb3Cw/CWGrLH7CONN+rYcoL47q+uIZJvvmAW77ziYTE34aj/1e0tDPjJR7e7S+
         PE+YBO9wdmHpQuAJrJNJB8rWvyeqVbBvoonL8XvbXnv/3SuRWRU7JKOxF364RklmUt
         QtscXMVcj+P5w==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id x1so5642628vsc.10;
        Wed, 06 Feb 2019 16:24:53 -0800 (PST)
X-Gm-Message-State: AHQUAubQzfYL/foxeZpYXzIdaB3K1Rk3jZ7Cv4f6eOwvztMzPzcwtktR
        P7j3zhhSujhq7vdhw5W/gBcAvUc/yiJhDxlIhB8=
X-Google-Smtp-Source: AHgI3IasxbXYPW5kdCbN8atdvYJzihLO6tEMeFWs+nLp3+60YGVrx56OV6UT3GkJrR2AO6sHN+fWX7THOYWC8ZFxjPw=
X-Received: by 2002:a67:f1c2:: with SMTP id v2mr5541167vsm.181.1549499092842;
 Wed, 06 Feb 2019 16:24:52 -0800 (PST)
MIME-Version: 1.0
References: <20190201210853.244043-1-jflat@chromium.org> <CAK7LNAS5j6+o+wb8WL=8WP4r4fgqY1MDSGe0_u9Nri81_Eb3xw@mail.gmail.com>
 <20190206164528.GA8925@archlinux-ryzen> <CACJJ=pyLqhrxka2jXtby9CUqsAr=-_oQUraH5ua3PZpgXHgdOQ@mail.gmail.com>
 <CAKwvOdm=dqScCDVTgQ71i0wtBSqezEzLr69Pxp3bZJFs+_mXsQ@mail.gmail.com> <20190206174339.GA19743@archlinux-ryzen>
In-Reply-To: <20190206174339.GA19743@archlinux-ryzen>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 7 Feb 2019 09:24:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ97h3RjKNy8f2abb7fnCaQS3TOoF2LFeGgNxeoCy0GwA@mail.gmail.com>
Message-ID: <CAK7LNAQ97h3RjKNy8f2abb7fnCaQS3TOoF2LFeGgNxeoCy0GwA@mail.gmail.com>
Subject: Re: [PATCH] kbuild, LLVMLinux: Don't suppress format warnings
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Jon Flatley <jflat@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 3:03 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Feb 06, 2019 at 09:36:55AM -0800, Nick Desaulniers wrote:
> > On Wed, Feb 6, 2019 at 9:32 AM Jon Flatley <jflat@chromium.org> wrote:
> > >
> > > On Wed, Feb 6, 2019 at 8:45 AM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > >
> > > > On Tue, Feb 05, 2019 at 05:26:05PM +0900, Masahiro Yamada wrote:
> > > > > On Sat, Feb 2, 2019 at 6:10 AM <jflat@chromium.org> wrote:
> > > > > >
> > > > > > From: Jon Flatley <jflat@chromium.org>
> > > > > >
> > > > > > gcc produces format warnings that clang suppresses. To keep behavior
> > > > > > consistent between gcc and clang, don't suppress format warnings in
> > > > > > clang.
> > > > > >
> > > > > > Signed-off-by: Jon Flatley <jflat@chromium.org>
> > > > > > ---
> > > > >
> > > > > Applied to linux-kbuild.
> > > > > Thanks.
> > > > >
> > > > >
> > > >
> > > > Hi Jon and Masahiro,
> > > >
> > > > Just as a heads up, this introduces a ton of warnings (duh). Isn't the
> > > > typical plan behind turning on warnings that were disabled to build with
> > > > 'W=', fix them all, then turn them on so as not to pollute the build?
> > > >
> > > > Log file: https://gist.github.com/443db156e56cd3c0f6b21d9d77728d80
> >
> > Oh boy, that's a lot.  Too many to fix quickly IMO.
> >
> > > >
> > > > Note a big chunk of them come from one scnprintf call in
> > > > include/linux/usb/wusb.h but still, there are many other warnings that
> > > > make quite a bit of noise. Some seem relatively easy to fix, which I
> > > > suppose I will try to tackle soon.
> > > >
> > > > Thanks,
> > > > Nathan
> > > >
> > >
> > > Hi Nathan,
> > >
> > > This was definitely not my intention.
> > > I noticed the added warnings this morning and was considering calling
> > > for a revert on this patch.
> > >
> > > The intent was to match the behavior of gcc, as it has -Wformat enabled.
> > > It was rather naive of me to assume the behavior of -Wformat would be
> > > the same in both gcc and clang.
> > > Indeed, it seems gcc is more permissive about what format
> > > substitutions it allows.
> > >
>
> My guess is that it has something to do with how the compilers
> internally handle certain specifier promotions (GCC probably just
> silently ignores the 'h' part of the specifier whereas Clang warns) but
> I didn't do any actual research into the matter. Probably should before
> looking into all of the warnings :)
>
> > > For example passing int to the "%hu" format specifier is fine in gcc
> > > under -Wformat but produces a warning in clang.
> > > Maybe this was the motivation for adding -Wno-format to clang in the
> > > first place.
> >
> > Sorry, I'm late to this thread.  What is it reverting; who authored
> > the original patch? Was it mka@chromium.org?
> >
>
> This patch is turning on '-Wformat' for Clang, which was disabled in
> commit 3d3d6b847420 ("kbuild: LLVMLinux: Adapt warnings for compilation
> with clang").
>
> > > This difference is puzzling to me, and I wonder if it's by design.
> >
> > Probably; internally let's sync up with the Clang devs to understand
> > this difference more.
> >
>
> Yes, I do think it would be a good idea to turn this on eventually but
> it'd be wise to understand why Clang emits a warning but GCC doesn't.
>
> > >
> > > Considering the whole point of this patch was to sync up this behavior
> > > between gcc and clang I am OK with reverting this.
> >
> > Is this patch in -next, or has it already hit mainline?  I think it's
> > better to revert, then start upstreaming fixes, then re-land it once
> > we're warning free.
> >
>
> It's in linux-kbuild/kbuild, it hasn't hit -next yet.


Right, it is just staying in my branch.
I will drop it.


I should have tested this carefully. Sorry.





-- 
Best Regards
Masahiro Yamada

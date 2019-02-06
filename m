Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901C4C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9F420B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3/cq9B3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbfBFRnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:43:45 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39843 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFRnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:43:45 -0500
Received: by mail-ed1-f68.google.com with SMTP id b14so6607061edt.6;
        Wed, 06 Feb 2019 09:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hmD5NE175Br61MGZJNMZ349jIJJGOALRbdmpGAaUL44=;
        b=g3/cq9B3fjRYqIyO44zZdYfckTnUhThQ1dlzoTobihyU/JnMpFOCX8vQG90Yqiqbju
         uhaeu4ijPzuK97TpyYYvCc4Hg9ej8zbZ1ywwOS/0IuzH5LRNLLYLB7MwithNYino5oEY
         Jam/iGxtbeL8aivvHUXKCMuEM/JajwDEf7EXrTMu9D0zniytB8VRe1WHth73CCbTTylN
         SuyDPGED29/WB2m+t0fYvwFuvbeL98k6FIhOldb2zSK+i1/EXoge4K4zzsDRu4Ql5Fex
         tT8Kn7hsup26JMEDT2vXgHqvItkzWEwmHd57/BGkzQa5gKgvcoyswgXdOW0YbPoVr2dM
         8dRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hmD5NE175Br61MGZJNMZ349jIJJGOALRbdmpGAaUL44=;
        b=KM8aEPLGQk8+qsB6mqedS274y8mqxqBMziCTC1uWMBjHVf+rueJ8yRRXmOnro6nZhM
         f9L5JCUxxq0kHR922gAIbdCvDYhlqr+OB1o63nJpB5E8NYU4P5SmtoHdeIV7JxlM6y0z
         ZJhokvqtNzPirupTZFOmOUqtGt63FISCla14q9/66M9XsK1GvA82gpeutixYS7fHtc+Z
         HFCb648DdTYLr/XOR6n6hD4iXctbj/MSGjsOhlA/jb1rKuftrCEap65+/TNS3G89pued
         rwqQLo3ZGKXNxO9WXDu1rBlWihZf5V5yRZDEISaOGTf4i6UTXnKs9XB+192U5fGxvB9a
         SSIg==
X-Gm-Message-State: AHQUAuaj92hwL2XLGtTC2Y/2NPPCgC7eEG8t0wDPda/O+mJaOZr3K8Gh
        s3cEDZdhPJkyyu+fqGaUr/E=
X-Google-Smtp-Source: AHgI3IZi3XYUhOtVtBE5nlJuJZISGpjCY0qOKBc7mqg9sDFiPIiyGM6Mu2YI0wEHaKhLfPJsXRrrrA==
X-Received: by 2002:a17:906:b38a:: with SMTP id o10mr3857987ejz.217.1549475022378;
        Wed, 06 Feb 2019 09:43:42 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id o19sm3672213eja.64.2019.02.06.09.43.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 06 Feb 2019 09:43:41 -0800 (PST)
Date:   Wed, 6 Feb 2019 10:43:39 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jon Flatley <jflat@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] kbuild, LLVMLinux: Don't suppress format warnings
Message-ID: <20190206174339.GA19743@archlinux-ryzen>
References: <20190201210853.244043-1-jflat@chromium.org>
 <CAK7LNAS5j6+o+wb8WL=8WP4r4fgqY1MDSGe0_u9Nri81_Eb3xw@mail.gmail.com>
 <20190206164528.GA8925@archlinux-ryzen>
 <CACJJ=pyLqhrxka2jXtby9CUqsAr=-_oQUraH5ua3PZpgXHgdOQ@mail.gmail.com>
 <CAKwvOdm=dqScCDVTgQ71i0wtBSqezEzLr69Pxp3bZJFs+_mXsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm=dqScCDVTgQ71i0wtBSqezEzLr69Pxp3bZJFs+_mXsQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 09:36:55AM -0800, Nick Desaulniers wrote:
> On Wed, Feb 6, 2019 at 9:32 AM Jon Flatley <jflat@chromium.org> wrote:
> >
> > On Wed, Feb 6, 2019 at 8:45 AM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > On Tue, Feb 05, 2019 at 05:26:05PM +0900, Masahiro Yamada wrote:
> > > > On Sat, Feb 2, 2019 at 6:10 AM <jflat@chromium.org> wrote:
> > > > >
> > > > > From: Jon Flatley <jflat@chromium.org>
> > > > >
> > > > > gcc produces format warnings that clang suppresses. To keep behavior
> > > > > consistent between gcc and clang, don't suppress format warnings in
> > > > > clang.
> > > > >
> > > > > Signed-off-by: Jon Flatley <jflat@chromium.org>
> > > > > ---
> > > >
> > > > Applied to linux-kbuild.
> > > > Thanks.
> > > >
> > > >
> > >
> > > Hi Jon and Masahiro,
> > >
> > > Just as a heads up, this introduces a ton of warnings (duh). Isn't the
> > > typical plan behind turning on warnings that were disabled to build with
> > > 'W=', fix them all, then turn them on so as not to pollute the build?
> > >
> > > Log file: https://gist.github.com/443db156e56cd3c0f6b21d9d77728d80
> 
> Oh boy, that's a lot.  Too many to fix quickly IMO.
> 
> > >
> > > Note a big chunk of them come from one scnprintf call in
> > > include/linux/usb/wusb.h but still, there are many other warnings that
> > > make quite a bit of noise. Some seem relatively easy to fix, which I
> > > suppose I will try to tackle soon.
> > >
> > > Thanks,
> > > Nathan
> > >
> >
> > Hi Nathan,
> >
> > This was definitely not my intention.
> > I noticed the added warnings this morning and was considering calling
> > for a revert on this patch.
> >
> > The intent was to match the behavior of gcc, as it has -Wformat enabled.
> > It was rather naive of me to assume the behavior of -Wformat would be
> > the same in both gcc and clang.
> > Indeed, it seems gcc is more permissive about what format
> > substitutions it allows.
> >

My guess is that it has something to do with how the compilers
internally handle certain specifier promotions (GCC probably just
silently ignores the 'h' part of the specifier whereas Clang warns) but
I didn't do any actual research into the matter. Probably should before
looking into all of the warnings :)

> > For example passing int to the "%hu" format specifier is fine in gcc
> > under -Wformat but produces a warning in clang.
> > Maybe this was the motivation for adding -Wno-format to clang in the
> > first place.
> 
> Sorry, I'm late to this thread.  What is it reverting; who authored
> the original patch? Was it mka@chromium.org?
> 

This patch is turning on '-Wformat' for Clang, which was disabled in
commit 3d3d6b847420 ("kbuild: LLVMLinux: Adapt warnings for compilation
with clang").

> > This difference is puzzling to me, and I wonder if it's by design.
> 
> Probably; internally let's sync up with the Clang devs to understand
> this difference more.
> 

Yes, I do think it would be a good idea to turn this on eventually but
it'd be wise to understand why Clang emits a warning but GCC doesn't.

> >
> > Considering the whole point of this patch was to sync up this behavior
> > between gcc and clang I am OK with reverting this.
> 
> Is this patch in -next, or has it already hit mainline?  I think it's
> better to revert, then start upstreaming fixes, then re-land it once
> we're warning free.
> 

It's in linux-kbuild/kbuild, it hasn't hit -next yet.

Nathan

> -- 
> Thanks,
> ~Nick Desaulniers

Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57DFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42DE206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CvUIONwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbfAJWwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:52:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42671 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfAJWwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:52:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so5819476plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ezsJLU4EKkvT02/AY4f2hZfhN8wqFyGwUgPUbA5Yaoc=;
        b=CvUIONwLqU41zxVQm8AgSQ6Two5GHu3PJVG2WAfv9j2ZErfUG/U9cl1Ps8xUZ0oVLq
         Jjrm7H/KLjyOjvWU1pVl/mvVhLqp2dkTgtUbw+NCnxckZTYi7kCVV4GcOJm91ldRtsP3
         PZDw1+gxIAWlNKWAWxcKpxbkjzQf0n8qw8i3pX/vPreCoYG2AiDxxVqV+Lz0MjKT0D4P
         9Uv/kKLd5m0glsyRjfaDBsa/jzdKAanv5PTNA39QcHfTCVYm2TukUK4TjLJAq5SvvBtf
         jjr/uetTr4kcX1UaWFWWVzh5AK5nD66I+Y0pHUGcAyPmEhs4F34KSSUxJrL+vi/rWu52
         gotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ezsJLU4EKkvT02/AY4f2hZfhN8wqFyGwUgPUbA5Yaoc=;
        b=ttJR/tS7hfd7mbSNdhnAwNMDPcka7pc+LJDOvJXpRYXviCJG4nioBAvDHWN3C/8peG
         BV1FxRzgZxiMLtsLdrI31F1CeVuUuzYQPY4sDMP3GRO3TnXk2VozapWo1t4C1gdJ57gN
         dHN3hGRUVzOWVX7o4T2g/hvYxVe3W4ULkTvk/Ujb2svmVUvfAfdJRBEL5NiVDP5hGgzY
         EpnvjeEIWDEgfZZ/ePgJE/ze/j/Sz9AUATeT0Okj7bvspSn53mqWcel7htYs+nbDd9k9
         Wk52UJykXbV6zBwV0sV0KDEPei2u6bi2IQ/QhuL0adLXwcmNkcHU/UQCPEFh5oqLFod7
         mssQ==
X-Gm-Message-State: AJcUukd4wbkD9Lv3U3gLpKggtKNoynkT/cV26li9aUORif83P0tswqK0
        y4Va2fAtYpwMCrC4U5wOwZfV7m2rd6nwzSYe9pwDcA==
X-Google-Smtp-Source: ALg8bN6w2HH3Nj2VK62bGjMnCe3VEdlAUM1V0b+JSS7h6TeP3nMEVXBXo8FHbhlDqLExOo2lyKRmEZA2Ao8hC+kziqo=
X-Received: by 2002:a17:902:820d:: with SMTP id x13mr12538216pln.229.1547160736140;
 Thu, 10 Jan 2019 14:52:16 -0800 (PST)
MIME-Version: 1.0
References: <20180926232055.31951-1-natechancellor@gmail.com>
 <20180927051634.GA32508@kroah.com> <CAKwvOdm3Au2V159PtripyZReZf167TtL5o7P9uYY-okr+n4xPw@mail.gmail.com>
 <CAKwvOd=NkgAWVGCS4Mb=Mgs5iu-uX1Kp=fjYSHhXAnh4gAQ-8w@mail.gmail.com>
 <CAKwvOd=+Vqm2FdZ-nb7j2eVTHuP2dWBmiYyZ0WLMEERK9NqNKA@mail.gmail.com> <20190110070110.GA29175@kroah.com>
In-Reply-To: <20190110070110.GA29175@kroah.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Jan 2019 14:52:04 -0800
Message-ID: <CAKwvOdmVusJoWeYUfxPo5VurqqiLJhgr+daw_Vc4eB7PrDsGgg@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: Mark ACPI table declaration as used
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, sedat.dilek@credativ.de,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 11:01 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 09, 2019 at 04:19:30PM -0800, Nick Desaulniers wrote:
> > Digging up an old thread to point out I was wrong:
> >
> > On Thu, Sep 27, 2018 at 1:08 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > > > This is not a million-little-commits problem; more like 2 drivers in
> > > > the whole tree have this problem.
> > > >
> > > > Note that this change that Nathan has DOES NOT need to applied to
> > > > every driver that uses MODULE_DEVICE_TABLE.  Only when the struct has
> > > > no other references other than JUST being passed to
> > > > MODULE_DEVICE_TABLE() is this a problem.  For an allyesconfig, I only
> > > > see 2 instances of this case in the whole tree:
> > > >
> > > > https://github.com/ClangBuiltLinux/linux/issues/169 <- this patch is addressing
> > > > https://github.com/ClangBuiltLinux/linux/issues/178 <- waiting on the
> > > > results of this patch
> > > >
> > > > If you're ok with this change to two drivers, then:
> > > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > I just landed a fix for this in Clang
> > (https://reviews.llvm.org/rL350776) which will ship soon in Clang 8.
> > Sedat helped test this patch and reported that it removed 41
> > false-negative warnings
> > https://github.com/ClangBuiltLinux/linux/issues/232#issuecomment-440006399
>
> Great, thanks for letting me know.  Can I revert this patch?

Go for it.  I think my mistake was that we had 2 instances of this
listed in our bug tracker, but an allyesconfig had many many more
instances than I was aware of.
-- 
Thanks,
~Nick Desaulniers

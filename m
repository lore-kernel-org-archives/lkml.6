Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0473C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE0821738
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9NrTG6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfA2DNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 22:13:01 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37198 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfA2DNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 22:13:01 -0500
Received: by mail-qk1-f194.google.com with SMTP id g125so10727655qke.4;
        Mon, 28 Jan 2019 19:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VMWWwMWhbc5Fv9jThS/LXI6OfGbprCD2fUp4iFS5+Tc=;
        b=D9NrTG6+IMuw9nrpAyBxtOyzXWcXVCK5GD6uQydZgZ2B1QGZce21Bz3fuGeRRtCdHi
         uFJmKuf4qMRWEkwSf+wTqrnGWXuzbT/7tzJYQCI3R/eAUoPlBQD4YUJTIpOUbPHrCnNK
         eYJ4XaJedbOILpODbvOqgZWQBKwyGxTW2yOnfTtLMRVC109o8yM9GPW95jU7ytifarCH
         8CwggItQMaV1uvfpoV3mvAUEJigSYUu6V37q4pF3WKczKXphemiU1riIaqQRhOwdYciJ
         9tzlojBUnj8F6AT8KkihKHKcq9hiZkUJPofONCTk+o7XMat6frMo5UG3loHzG58o5CyD
         5Nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VMWWwMWhbc5Fv9jThS/LXI6OfGbprCD2fUp4iFS5+Tc=;
        b=mrBWv6j4l/JLZCREbO0MpwXx+ARsL+ycG8ENBQMA28GgeAxK6O7KR3rmh5HHbN+tEg
         g6rAEWOrGKegfxQrcCqgSK/K9SS98TSh+IWdq4q2Az1h6UXWl/Z3P1rfHoa1UNPLcKuF
         yu1lvq2hq8kWj9LrOmq6vAT7tG7PZ3nkfDM+VR+i0Djo1IjvjI3/CUqZXDYs3yqaJmBV
         M7OFE6cNPTRhQzQBlAFQzDcqn1hq5Fvtns6icgUSCXiPnFX0NqWgqns6/Lp4g/Ugu7e6
         PRvVfVKSaVOs+gen/xYxMnF65xTTWuMVEFmumGP109CjqBMC9wICOVwWQ6TCranMLi8X
         1MRA==
X-Gm-Message-State: AJcUukexS+0sCNN2Q5gNpzxdcnmEh9hWkRIFpIRV2qnkZSN66LfAqvT5
        efOqZk8krwzWiynqI1HXwJIZERxK4OuoSlyrHkI=
X-Google-Smtp-Source: ALg8bN7zuALrKX8RZs3IVLfZt+mi9RSj5m27nQF/AreLbHjgKUavNfKAdnOik6Q+2H4t+tQ9dOTyKf8Q/0zleSRvJQY=
X-Received: by 2002:a37:34d0:: with SMTP id b199mr21601038qka.284.1548731580445;
 Mon, 28 Jan 2019 19:13:00 -0800 (PST)
MIME-Version: 1.0
References: <31468.1548648675@turing-police.cc.vt.edu> <CAPhsuW54z8ao4KOKG9ZjdXus6LTBH2qwAi8LgPFZ_qb_ObKsRg@mail.gmail.com>
 <9865.1548718516@turing-police.cc.vt.edu>
In-Reply-To: <9865.1548718516@turing-police.cc.vt.edu>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 28 Jan 2019 19:12:49 -0800
Message-ID: <CAPhsuW7F0yoOdgF335uET-_j+KkNohRCmG7sseisBK+bpaQy4g@mail.gmail.com>
Subject: Re: [PATCH] bpf/core.c - silence warning messages
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 3:35 PM <valdis.kletnieks@vt.edu> wrote:
>
> On Mon, 28 Jan 2019 09:18:45 -0800, Song Liu said:
> > On Sun, Jan 27, 2019 at 8:43 PM <valdis.kletnieks@vt.edu> wrote:
>
> > > The attached patch silences the warnings, because we *know* we're overwriting
> > > the default initializer. That leaves bpf/core.c with only 6 other warnings,
> > > which become more visible in comparison.
> >
> > My concern is that this will also mute the warning for other parts of
> > bpf/core.c.
>
> I checked and there weren't any warnings for other parts of the file.  Also, this message
> doesn't even happen unless you build with W=1, which apparently happens so rarely
> that nobody else has submitted a patch.
>
> Is there a high likelihood that another overwrite of an initializer is going to
> be included in the source?
>
> > Maybe we should move bpf_opcode_in_insntable() to a separate file, and mute
> > warning for that file?
>
> Seems to be overkill - the intent of this patch was mostly to make the *other*
> warnings issued with W=1 more noticable.

Yeah, I also felt this might be overkill while asking initially.

Acked-by: Song Liu <songliubraving@fb.com>

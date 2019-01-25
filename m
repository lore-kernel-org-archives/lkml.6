Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39CCC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFF9218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="SijG96OG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfAYRND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:13:03 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55984 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfAYRNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:13:02 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so11535363ith.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 09:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4kNYUQzvKZUHTZUbRa0KQMyO0+2paZ7QOSd2bIN6wg=;
        b=SijG96OGcKAK77pezDmqiaVggrFno4ZJ2mdlCABi+MVHTcIm5bHmfvlJAVCMTMcsAV
         MZQav0EegbVH//R2sOmxmjFIOhg7r83XeBz/dG7MhORqB/x/fHNXfhiGy0U/lC44p0JJ
         Eat9bDogPg2X5wu49+gGNdmSD+rwDYr+DdY43qWd7YhDpZdVEbY0l8JFTZdmLLYiZQ4z
         FAw7ivSt64v1FMM5Iskfv8PRWtAOfr26aMYqJtZo3u7cBe3eiFo6uEQT3M7i1hIMoylG
         owA8IZmlN9W6heaXjbaVYByqal9pYfxMmE5cQa5Zrhd2wy6979Gk5Hkm3g5fhyhbgg7d
         TfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4kNYUQzvKZUHTZUbRa0KQMyO0+2paZ7QOSd2bIN6wg=;
        b=RsVj40wPXTAGh2ar9dJ86qOs4y+5Tuyn4P2uW/XGAAYmLoZwu0viQhcoiIPdWd+JLb
         Vcs3DTHULfhbbQugmLGqdDB20ApIG+pEYK2ShpTHX92EMUjig13AreNna7Rvi+HDMRa3
         NAH5l/af19NHiU104CVQCbFottBBe1LawJpk9hZdevbZllHQPfthJnEUM2ysUFl/hcZI
         G3T2B7qe/TVBypf4aFEF6/YQPDN4jv9+fP/bJA9tYK9FfFQXyzD7Cr5ht+GKbt75LFUG
         98iqZk+B76lrstWSujLUL5pjzkI8uB7/R+zKTpyU4fGKR00+aDXF9NWmuxDYXGpGzicV
         UW3w==
X-Gm-Message-State: AJcUukfR+NB5byeFD1Xf7mpYBNwpdOOAqd1Av0ffwysIVI6nzF3mcybn
        Q89pFrrrnwslBE3c2kooBSkB3awGsUbf9r39HoTmvg==
X-Google-Smtp-Source: ALg8bN4LG2i69SMMl7U2Gjr173Wma/eqeSok8FFXZLcC936MrqVwLgDYWXTLhkV3KQSpL41QfnfsYgInyODyzmAcDu8=
X-Received: by 2002:a24:2104:: with SMTP id e4mr4406959ita.59.1548436381132;
 Fri, 25 Jan 2019 09:13:01 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
 <20190125073745.GD11891@kroah.com> <CAOesGMgJUeUMoRXZ98=J8bpfCuZOOMo5pwpVXZX-o-y1dAQsHA@mail.gmail.com>
 <20190125160617.GB14934@kroah.com>
In-Reply-To: <20190125160617.GB14934@kroah.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 25 Jan 2019 09:12:49 -0800
Message-ID: <CAOesGMicf17+0x6AUCNrUYu=d4uREVCyH8F2JvUz5fN5+=jW_A@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, ogabbay@habana.ai
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 8:06 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jan 25, 2019 at 07:33:23AM -0800, Olof Johansson wrote:
> > On Thu, Jan 24, 2019 at 11:37 PM Greg Kroah-Hartman
> > > As for what directory the code should live in, I suggested "misc" as
> > > there was no other universal location, and I hate to see new subsystems
> > > be created with only one driver, as that's pretty sad.  But it's just a
> > > name/location, I have no dog in the fight, so I really don't care where
> > > it ends up in the tree, just as long as it gets merged somewhere :)
> >
> > I'm usually one to push back against new subsystems too, especially
> > when I see a framework proposal with just one driver. In this case,
> > given that we all know more vendors will come along, I think it makes
> > sense to take the discussion and establish structure now. This should
> > give some clarity to those who are out there that we haven't seen yet,
> > and give them a chance to prepare for things such as the low-level
> > userspace pieces mentioned above.
> >
> > So I think setting this up now is the right thing to do, we know there
> > will be more material here and having a common aggregation of it makes
> > sense.
>
> Ok, how about:
>         drivers/deep_thought/
>
> as a first proposal.
>
> Let the bikeshedding begin!  :)

My original proposal upthread was driver/accel. I'm not sure whether
Dave and/or anyone else wants to participate to start though, I hope
they will at least join in once things are heading in the direction
they want.

I'll post patches with the proposed moves and documentation of
expectations shortly, hopefully to collect acks.



-Olof

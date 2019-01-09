Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E4AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65695206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3+UbbUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbfAIPqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:46:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35919 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731857AbfAIPqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:46:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so8745903wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 07:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HY+OQ3ffRelZp13bVBLS+b4yYxzUbzfM5ORJ9lwDgfQ=;
        b=L3+UbbUvIEo/nYGUHUUdR2Slp31zq2+RVR+yBUTW50VxU3LqhpQPV80+vRu3kVKgO/
         lkzWfQq9aYjOV/jSNin6DvEjEwg9LD9lJ1GUcofsViIekS72VdwIAVVp4lRUjpsH4Oez
         zgDx2I/N0Ls/IrtmhvUwiuJxNzhtVGmDxR9OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HY+OQ3ffRelZp13bVBLS+b4yYxzUbzfM5ORJ9lwDgfQ=;
        b=ZAQDvH22aux0D2BnDqum2RdrLa7he7W9YEVLMEMjl29U73vWueJJvOCfkNAl60XxmA
         2j9LcSNKvpVbEU5oKo4cC9rqwtnsS+idJJ+/KIQIwr4AqqwRUIp9lJbZBZXEtSlivLMQ
         5BtpOp2730/RvK9tMmCXIXWI+C/j+dpeMonrkdC/+Qsm+rVQyKENlDlC9ydInkF9Jcqh
         +t9qiYmj8afSRL7cqDIe8hWT4HSWr1Z5wXA/tgz4lYiTFR5DxvNNWx/vWJReqBu72i6b
         xTF7PdZc6wFdD1/UNsh2KeKN+vgcKzBHefwjN8SMHDWU3kRKAbB96GUXH8zr+JXk69zb
         AhRg==
X-Gm-Message-State: AJcUukc1kQZ7PZ3X+DgK8YAAtLNakzy5L4iXEELj5c7xsGq/JcrgJ1uf
        ZYNkOMi3kGGYLtLEpsRnWi6/CzWISkYd+gdJDN/1Nw==
X-Google-Smtp-Source: ALg8bN6+OT/NUZNTJzU4WsSBcBnGUyTafSkKvEIad5QP7xBchoXZcb6KXFVNizFzLIDuLrH36aR1mKbnWm8bNddTb9c=
X-Received: by 2002:a1c:9a0d:: with SMTP id c13mr6416517wme.41.1547048770995;
 Wed, 09 Jan 2019 07:46:10 -0800 (PST)
MIME-Version: 1.0
References: <20181030202713.26203-1-semen.protsenko@linaro.org>
 <CAKaJLVu0h5woVtN5=Mh38ajACBZZQ3JHfRhkjNrwMwYXHEG-NQ@mail.gmail.com>
 <CAHp75Vd-ydncUWQtc8ziLpCMJRFCvjV=ueKB0wRgn7W-pnV09Q@mail.gmail.com>
 <20181121181042.4gzuniz2vzjikpwc@cs.cmu.edu> <CAKaJLVs4MUws7sPPdDk7hnjZ+Z1V0V6bGt=eWn=gsF_B+yULeg@mail.gmail.com>
 <CAKaJLVvHZwJHu_uZuUDtCZrD7EKY-5xpGhNZN7cQ2M4Bz9osDA@mail.gmail.com> <308CF0BD-90AE-45D2-BAF9-D297A530B0F4@cs.cmu.edu>
In-Reply-To: <308CF0BD-90AE-45D2-BAF9-D297A530B0F4@cs.cmu.edu>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 9 Jan 2019 17:45:59 +0200
Message-ID: <CAKaJLVum=eOgsnsaoNzp4WJ7NpAekeuKH2C8Cbk57z0Oy0GM=w@mail.gmail.com>
Subject: Re: [PATCH v2] codafs: Fix build using bare-metal toolchain
To:     Jan Harkes <jaharkes@cs.cmu.edu>
Cc:     hch@lst.de, Andrew Morton <akpm@linux-foundation.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org, Praneeth Bajjuri <praneeth@ti.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

Can you please clarify on this patch? As I can see v5.0-rc1 is out
now, which means merge window is closed, but I can't see this patch in
linux-mainline yet. Do you need any additional steps from my side
(like rebasing, etc)?

Thanks!

On Thu, Nov 22, 2018 at 12:49 AM Jan Harkes <jaharkes@cs.cmu.edu> wrote:
>
> That actually makes a lot of sense.
>
> Jan
>
> On November 21, 2018 2:39:03 PM EST, Sam Protsenko <semen.protsenko@linaro.org> wrote:
> >+ Jan Harkes back to "To:" list, slipped away somehow...
> >
> >On Wed, Nov 21, 2018 at 9:36 PM Sam Protsenko
> ><semen.protsenko@linaro.org> wrote:
> >>
> >> On Wed, Nov 21, 2018 at 8:10 PM Jan Harkes <jaharkes@cs.cmu.edu>
> >wrote:
> >> >
> >> > On Wed, Nov 21, 2018 at 06:41:13PM +0200, Andy Shevchenko wrote:
> >> > > I'm not sure how you managed to miss people in this list (perhaps
> >by
> >> > > default you have suppress all Cc in your Git configuration), but
> >I
> >> > > guess we may gently ask Christoph to apply this in case Jan will
> >not
> >> > > appear.
> >> >
> >> > You have got to give me a little more than 10 minutes to respond
> >before
> >> > assuming that I would not appear... I don't think I've ignored any
> >> > previous emails on this subject and the only issues has been some
> >people
> >> > not receiving my responses for unknown reasons (agressive spam
> >filter?).
> >> >
> >> > I have no problem with this patch, have it sitting with some other
> >> > non-urgent patches and in case it doesn't appear upstream it should
> >> > piggyback with whatever I have to send.
> >> >
> >>
> >> Thanks, Jan, really appreciate it. We need this patch to fix our
> >tests
> >> with allmodconfig configuration (in Linaro CI loops).
> >>
> >> > I still don't know why the bare-metal toolchain couldn't just add a
> >> > -D__linux__.  I understand that this define is expected to be
> >always
> >> > present while compiling kernel headers so that there is no good
> >reason
> >> > to even bother testing for it, which is why I have no issue with
> >the
> >> > patch. But it seems it would make your life a lot easier if you had
> >it
> >> > defined.
> >> >
> >>
> >> As I understand it, from toolchain's point of view, if __linux__ is
> >> defined then it means that the program is being built *for* Linux
> >> (i.e. we can use Linux specific features, ABI, like syscalls).
> >> Checking this definition can make sense in uapi headers, but in
> >kernel
> >> code we shouldn't use it (as kernel is baremetal program and not
> >> compiled for some OS). I presume that's why __linux__ is not defined
> >> in bare-metal toolchains (as those don't provide Linux specific
> >> features, libc, etc).
> >>
> >> > Jan
> >> >

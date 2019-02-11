Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B808C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0F6218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4c91SeZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfBKMpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:45:31 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42416 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfBKMp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:45:29 -0500
Received: by mail-vs1-f67.google.com with SMTP id b20so4817940vsl.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/TVVxPc7j54M2bncIOVY+JCAh4+k47D+oaqD6xUPeQ=;
        b=P4c91SeZcmOuq+JqhcdbR795j+nqtaqbEIrJKRBSLTbFnpzwA3AGmx6cZzUuT3Kcp7
         djQVzvTQ1CNxW4GIXW7WSnAtvEZXLTq325W5cPh3p9XqkIB9H+4uAVGoINkBdSM7vAyz
         gLuZqkZlPGSaDjps+cL8DbMtx/uWt3BSjAuBTFXbhqANI8qbrAhOsKM61o16JjZy2+2N
         80lvzlW+qhQP1wdMGVDk9a6A4oYXaJLyu/GnVy08WfYjCeeXNJkgZ/9pSGSdneHZYgVY
         R0dbIh9Pz/PSPXlEHH5B0DnOXZGZ1OfpNCfD/KWteFM/cIaVliF9fQ+JWIAPknuSXDdx
         kpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/TVVxPc7j54M2bncIOVY+JCAh4+k47D+oaqD6xUPeQ=;
        b=Zw8RXb63ZiqYuSIh7OcCVZAxiPoFGs0WLT2DEpQGo7G3ne7yTbKI/Oy91Ty2bJzumK
         KKPRaYkudNNKyuv4VPYaMjj2ObbB3kZ0CqU5GDSRBjdgMWClex49uL5HnuEnVKZ4MFKU
         UdqZwmxf7EIYHXD/8zgxgA0mt2oIPlZXdI2N5dQfo4RVfN9sEWY7EkTrKOsmmTQwli+s
         wmtcp0mg/Et6kth2GrNFXX4qTp3GYkOtAWoP7XynRKb7ZhgpMgPjI7tUaCcGwlIm7AUE
         DSpfSsMOKaQtJgJ0e8mRdcN1dnL6gGnywQfu6ikflRFHP7tRYINGtOYNFLbM7QIablCZ
         VQJg==
X-Gm-Message-State: AHQUAuZEcpnPZWdd4+1WZTPvKfYA6z0fEoFC87UzKYfacIZWpkMAKf9i
        sQDPfhn/Di5FJumEfu5s9LgfurtAtKHVQzSmPma10A==
X-Google-Smtp-Source: AHgI3IZ31547P5aPi4CvjQXKvaT8ZmfMJ5D4OPmrs9ZUoXv77q4z2k2m8+dgBzTQMcq/n6xv5Rk6HTGBFH3+Ga7Ea3Y=
X-Received: by 2002:a67:ea50:: with SMTP id r16mr14305848vso.61.1549889128471;
 Mon, 11 Feb 2019 04:45:28 -0800 (PST)
MIME-Version: 1.0
References: <20190130220617.4862-1-oded.gabbay@gmail.com> <20190203114957.GD8620@rapoport-lnx>
 <CAFCwf12pB9e++ReBaPYNwW-Am1_Op4p_rQzdS5C6ndFTdbXX3w@mail.gmail.com> <CAFCwf13Jcrr6qHaDRXHPy67NsG-7WuxocZp_uMG-7vZ=AW1Pqw@mail.gmail.com>
In-Reply-To: <CAFCwf13Jcrr6qHaDRXHPy67NsG-7WuxocZp_uMG-7vZ=AW1Pqw@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 11 Feb 2019 14:45:01 +0200
Message-ID: <CAFCwf12vPXs8JEfuGZENPOLnP4Da6OiGeybmsK_steNCbKDw3w@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] Habana Labs kernel driver
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 9, 2019 at 12:05 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Sun, Feb 3, 2019 at 10:35 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> >
> > On Sun, Feb 3, 2019 at 1:50 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
> > > Hi Oded,
> > >
> > > On Thu, Jan 31, 2019 at 12:06:02AM +0200, Oded Gabbay wrote:
> > > > Hello,
> > > > This is v2 of the Habana Labs kernel driver patch-set. It contains fixes
> > > > for almost everything that was brought up in the review of v1.
> > > >
> > > > In addition to local changes in each patch that are detailed in each
> > > > patch's commit message, the global/major changes are:
> > > >
> > > > - Rebased on v5.0-rc4
> > > > - Removed all bitfields from interface files to H/W and F/W
> > > > - Use __le16/32/64 instead of __u16/32/64 in F/W or H/W structures
> > >
> > > For v2 I had comments only for "[PATCH v2 07/15] habanalabs: add h/w queues
> > > module".
> > >
> > > There are still several over-exited printk calls with three exclamation
> > > marks. ;-)
> > >
> > > I've also spotted several places where checkpatch.pl may complain, but I
> > > was to lazy to actually check it.
> > >
> > > > Link to v1 cover letter: https://lwn.net/Articles/777342/
> > > >
> > > > I would appricate any feedback, question and/or review.
> > > >
> > > > Thanks,
> > > > Oded
> > > >
> > > > p.s. for those who prefer to clone the tree instead of looking at the
> > > > emails, you can grab a copy from our company's page in GitHub:
> > > >
> > > > https://github.com/HabanaAI/linux/releases/tag/hl_patchset_v2_20190130
> > > >
> > > > Oded Gabbay (14):
> > > >   habanalabs: add skeleton driver
> > > >   habanalabs: add Goya registers header files
> > >
> > > This one is 4.3M which is 6 times the entire habanalabs driver without
> > > those headers.
> > > Any chance some of it can be dropped?
> > Hi Mike,
> > Managed to remove about 30 files (~1.5MB) from this patch. The patch
> > now is around 2.9MB
> > Unfortunately, I don't see how I can reduce it much more without
> > seriously reducing the readability and maintainability of the driver.
> >
> > Oded
> Thought about another idea how to reduce the size of this patch.
> I will separate the registers from the MASK and SHIFT defines into two
> files per H/W block.
> For most of the blocks, I only need the registers file, without all
> the MASK and SHIFT defines of the fields, so I think this will reduce
> most of the patch size.
> I'm talking to our devOps to create for me the new set of files from
> the H/W database and will update on the results, probably by end of
> next week.
>
> Oded
>
I'm happy to say I managed to reduce the total size of the registers
patch to ~1.4MB (from 2.9MB).
I will soon send v4 of the patch-set with this reduction + fixes for
MMU and Greg's comments.

Oded

Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7CDC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F09120661
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUh7QtNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbfAISqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:46:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38051 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfAISqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:46:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so9478744wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 10:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMukVTmVfInnLbPFaL2IDn+q5LVO76WkVp10SUcldls=;
        b=JUh7QtNPArpe/eDgXRBEohNmF9uMv1rnz7FkC0T6APE+P4hDbmBMKMXyHA36ZCOiN1
         UJOvDrc3zGHgOjwfy6zX8hrvntNXEdt/dM5nWjex+qOqdp8NEk1f1WSzEcEZ84rXLQNf
         RMJ6hkq3Q/bD+Shi9D1Xoa2cGpLFIeKQHe89hwsg4JlAM7Hj8nlW6cPd7a511dCs2vSy
         DcnJBfLuNsLXHW1gomL+M9VNOmJKDRY2y4po9aKefIaXjC+0Pe/jS7pCVjltb4sjH5pf
         XsB1FEtjYC96Xb99jB2+JkQ98p5XQQ/TQZdAAgCL+t+EY2pdwoonQsOSFBfpAGmldiA8
         j2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMukVTmVfInnLbPFaL2IDn+q5LVO76WkVp10SUcldls=;
        b=cMypVI1jP1ET/mKSWMs+1mC/GU5pPvDba4Wwtnf7v1Hqdo4Nu4mWMz0t6K8ZLb2oQU
         mKBSX7WS9Vhp1TTvxMHGaLshRjrsXdWuGr5fAGjlaIqO3AN/A/lLO+gpUQINVfxkoeGQ
         tQiuwJjbq+b67psk4EHBUXciJ/3nRxSn4zYx0KHMLboXZgy4yOV/IVwHVBZmme4Hw0+d
         26cjMXKrc/Ed/4EA3hx6B0D0l0ic86GCrg5ts/mqkcqmuQQSvdr9UOZNzdvVR6i5g+Yx
         0YUH9LKcBumabP5aJxkiT38dhML9hJq6+D209No8Nu1Gm1CgfYQXuWZ47HVRW0sAvZUZ
         DzVQ==
X-Gm-Message-State: AJcUukeiC2fge1BvJqb5kT9sU9HVSuKVESo+NlSRQLCeyw/T7Xe7+zg5
        YXCAZuKDV8/WCVBvPt/eZ17uut789Ux8vMse0yNnWPu1cBc=
X-Google-Smtp-Source: ALg8bN7JP6zA0k55lSt8922kKPas1gV9qINukLafnS8EGLfqvHvI+HUqRREW0Df2uLfEwnTuW2QB7koNJ/1KSCHzH8s=
X-Received: by 2002:a1c:c87:: with SMTP id 129mr6429129wmm.116.1547059572751;
 Wed, 09 Jan 2019 10:46:12 -0800 (PST)
MIME-Version: 1.0
References: <20190108112519.27473-1-kraxel@redhat.com> <20190108112519.27473-16-kraxel@redhat.com>
 <20190109101044.GS21184@phenom.ffwll.local> <20190109145443.l5yus2pgvxcl4zbt@sirius.home.kraxel.org>
 <CAKMK7uG0HCNso9rE9TivP2cVKMD1rNPC2wJH_+yu+CWGEh9XdQ@mail.gmail.com>
In-Reply-To: <CAKMK7uG0HCNso9rE9TivP2cVKMD1rNPC2wJH_+yu+CWGEh9XdQ@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 9 Jan 2019 13:45:59 -0500
Message-ID: <CADnq5_NqSeZzj1=dWS=ymEHwzhBCiP49iBDe_x1YUo6Ga=whQw@mail.gmail.com>
Subject: Re: [PATCH v2 15/15] drm/bochs: reserve bo for pin/unpin
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        David Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 12:36 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Jan 9, 2019 at 3:54 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Wed, Jan 09, 2019 at 11:10:44AM +0100, Daniel Vetter wrote:
> > > On Tue, Jan 08, 2019 at 12:25:19PM +0100, Gerd Hoffmann wrote:
> > > > The buffer object must be reserved before calling
> > > > ttm_bo_validate for pinning/unpinning.
> > > >
> > > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > >
> > > Seems a bit a bisect fumble in your series here: legacy kms code reserved
> > > the ttm bo before calling boch_bo_pin/unpin, your atomic code doesn't. I
> > > think pushing this into bochs_bo_pin/unpin makes sense for atomic, but to
> > > avoid bisect fail I think you need to have these temporarily in your
> > > cleanup/prepare_plane functions too.
> >
> > I think I've sorted that.  Have some other changes too, will probably
> > send v3 tomorrow.
> >
> > > Looked through the entire series, this here is the only issue I think
> > > should be fixed before merging (making atomic_enable optional can be done
> > > as a follow-up if you feel like it). With that addressed on the series:
> > >
> > > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >
> > Thanks.
> >
> > While being at it:  I'm also looking at dma-buf export and import
> > support for the qemu drivers.
> >
> > Right now both qxl and virtio have gem_prime_get_sg_table and
> > gem_prime_import_sg_table handlers which throw a WARN_ONCE() and return
> > an error.
> >
> > If I understand things correctly it is valid to set all import/export
> > callbacks (prime_handle_to_fd, prime_fd_to_handle,
> > gem_prime_get_sg_table, gem_prime_import_sg_table) to NULL when not
> > supporting dma-buf import/export and still advertise DRIVER_PRIME to
> > indicate the other prime callbacks are supported (so generic fbdev
> > emulation can use gem_prime_vmap etc).  Is that correct?
>
> I'm not sure how much that's a good idea ... Never thought about it
> tbh. All the fbdev/dma-buf stuff has plenty of hacks and
> inconsistencies still, so I guess we can't make it much worse really.
>
> > On exporting:
> >
> > TTM_PL_TT should be easy, just pin the buffer, grab the pages list and
> > feed that into drm_prime_pages_to_sg.  Didn't try yet though.  Is that
> > approach correct?
> >
> > Is it possible to export TTM_PL_VRAM objects (with backing storage being
> > a pci memory bar)?  If so, how?
>
> Not really in general. amdgpu upcasts to amdgpu_bo (if it's amgpu BO)
> and then knows the internals so it can do a proper pci peer2peer
> mapping. Or at least there's been lots of patches floating around to
> make that happen.

Here's Christian's WIP stuff for adding device memory support to dma-buf:
https://cgit.freedesktop.org/~deathsimple/linux/log/?h=p2p

Alex

>
> I think other drivers migrate the bo out of VRAM.
>
> > On importing:
> >
> > Importing into TTM_PL_TT object looks easy again, at least when the
> > object is actually stored in RAM.  What if not?
>
> They are all supposed to be stored in RAM. Note that all current ttm
> importers totally break the abstraction, by taking the sg list,
> throwing the dma mapping away and assuming there's a struct page
> backing it. Would be good if we could stop spreading that abuse - the
> dma-buf interfaces have been modelled after the ttm bo interfaces, so
> shouldn't be too hard to wire this up correctly.
>
> > Importing into TTM_PL_VRAM:  Impossible I think, without copying over
> > the data.  Should that be done?  If so, how?  Or is it better to just
> > not support import then?
>
> Hm, since you ask about TTM concepts and not what this means in terms
> of dma-buf: As long as you upcast to the ttm_bo you can do whatever
> you want to really. But with plain dma-buf this doesn't work right now
> (least because ttm assumes it gets system RAM on import, in theory you
> could put the peer2peer dma mapping into the sg list and it should
> work).
> -Daniel
>
> >
> > thanks,
> >   Gerd
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

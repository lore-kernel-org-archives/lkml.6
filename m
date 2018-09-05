Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0D8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F6320839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuxL82jZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F6320839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeIFCDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbeIFCDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:03:53 -0400
Received: from mail-qt0-f173.google.com (mail-qt0-f173.google.com [209.85.216.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 510B920659;
        Wed,  5 Sep 2018 21:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536183109;
        bh=7WMPOEf3A2hARiw+7HK00TWcS4xEIL/Ml1FchfrypDw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nuxL82jZUwH8Nr3OkC6d1V3y1pK2aCsI3L5nPgpFmpf1P+BxCyY+5uf/LejMjEL1m
         BNxxkowBsfvHS3W4rEnk80sQq0Rn7qQpGnR5EQjh3LGg6DeXm8ccqehkmNaZQqNnto
         Yp9l54YVBVurBE5p79JwkhjKKjdQwopMSQ445bBE=
Received: by mail-qt0-f173.google.com with SMTP id d4-v6so9895722qtn.13;
        Wed, 05 Sep 2018 14:31:49 -0700 (PDT)
X-Gm-Message-State: APzg51DkbOyHiC2vDTfC1n/7/CAM465F9ep4A/skRovLHwbElzKJKEw2
        t5tKlsEZRilxQG1s4IUiW+J4eiOLORpKAR3Z3w==
X-Google-Smtp-Source: ANB0VdZ3UITLH82Acc7dHShlBK6+FjYEQwzN45XiwLjKgGFpVB/wrKw1jQjZwX36Ne6uw9VqOyM9LXg84tBl5cDpq/U=
X-Received: by 2002:a0c:d5d3:: with SMTP id h19-v6mr35358674qvi.218.1536183108534;
 Wed, 05 Sep 2018 14:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180830190523.31474-1-robh@kernel.org> <20180830190523.31474-2-robh@kernel.org>
 <b86ed9cf-d5fd-09fb-eb82-0143c759f5cf@gmail.com> <CAL_JsqJy0kDYCC35GR5TGLYyYU-UjOys_r2sFMQZuFto5HkExg@mail.gmail.com>
 <5da7b4ab-acd3-977a-6ac2-275911d7c436@gmail.com> <CAL_JsqKRsXN-MKdP1ts=QexwuwkXO5tbFkORf4xDyYt04FUuUA@mail.gmail.com>
 <00433395-ec1e-8a2c-cb88-5db659967643@gmail.com>
In-Reply-To: <00433395-ec1e-8a2c-cb88-5db659967643@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 5 Sep 2018 16:31:37 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+yfaTzvMefUwzjapvyEYqwFndR5r7KAMPvApDKm=jGFw@mail.gmail.com>
Message-ID: <CAL_Jsq+yfaTzvMefUwzjapvyEYqwFndR5r7KAMPvApDKm=jGFw@mail.gmail.com>
Subject: Re: [PATCH 1/3] of/fdt: Scan the root node properties earlier
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 4:10 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 09/05/18 13:06, Rob Herring wrote:
> > On Wed, Sep 5, 2018 at 1:19 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> On 09/05/18 04:51, Rob Herring wrote:
> >>> On Tue, Sep 4, 2018 at 8:49 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>>>
> >>>> On 08/30/18 12:05, Rob Herring wrote:
> >>>>> Scan the root node properties (#{size,address}-cells) earlier,
> >>>>
> >>>>                                                         ^^^^^^^
> >>>>                              before mdesc->dt_fixup() is called
> >>>>
> >>>>> so that
> >>>>> the dt_root_addr_cells and dt_root_size_cells variables are initialized
> >>>>> and can be used.
> >>>>                  by mdesc->dt_fixup()
> >>>
> >>> That's an ARM specific detail. Granted, ARM is the only caller.
> >>
> >> The dt_root_addr_cells and dt_root_size_cells variables are being
> >> initialized earlier in this patch series so that of_fdt_limit_memory()
> >> can use them.  The only caller of of_fdt_limit_memory() is
> >> exynos_dt_fixup(), which is an mdesc->dt_fixup() function.
> >>
> >>
> >>>
> >>>>>
> >>>>> Cc: Frank Rowand <frowand.list@gmail.com>
> >>>>> Signed-off-by: Rob Herring <robh@kernel.org>
> >>>>> ---
> >>>>>  drivers/of/fdt.c | 7 ++++---
> >>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>>>>
> >>>> Moving early_init_dt_scan_root() to inside early_init_dt_verify()
> >>>> puts something that has nothing to do with verifying the fdt
> >>>> into a function whose purpose is the verify.  It hides the side
> >>>> effect of initializing the dt_root_addr_cells and dt_root_size_cells
> >>>> variables.
> >>>
> >>> It already has the side effect of setting initial_boot_params which
> >>> every subsequent function needs.
> >>
> >> And that side effect should probably also be moved.
> >
> > So 2 functions? One to set the blob and one to verify it. Then we can
>
> No, I would not add yet another function.  All of these side effects are
> an argument in favor of a single setup_machine_fdt(), as I suggested below.
> Then all of these side effects could be in setup_machine_fdt() instead
> of hiding them in sub-functions that are called by all of the different
> architectures.
>
>
> > just let arches decide if they want to do any verification or not.
> >
> > Perhaps it should be called fdt_init(blob) and then it is vague enough
> > I can do whatever I want.
> >
> >>>> I suggest creating a new function early_init_dt_scan_init_pre_dt_fixup(),
> >>>> move the chunk of code there instead of to early_init_dt_scan_nodes(),
> >>>> and call the new function from setup_machine_fdt(), just before
> >>>> calling  mdesc->dt_fixup().  This would be a little bit more code,
> >>>> but more clearly showing the intent.
> >>>
> >>> I'm trying to reduce the number of functions arches call
> >>
> >> I like that goal.
> >>
> >>
> >>> and renaming
> >>> would need a bunch of arch changes. This change will also let me make
> >>> early_init_dt_scan_root private as powerpc is the only user. I need to
> >>> dust off a patch for that.
> >>>
> >>> I'd be more inclined to push exynos to remove this altogether. After
> >>
> >> Not a bad idea.
> >>
> >>> all, if they claim their bindings are unstable, they can't really
> >>> claim their bootloader is stable/fixed.
> >>
> >> It seems that this series is showing us that maybe the three architecture
> >> specific (arc, arm, arm64) versions of setup_machine_fdt() should be
> >> consolidated so that we have consistent behavior for FDT.
> >>
> >> If we had a single setup_machine_fdt() then some of he hidden side
> >> effects of functions called by setup_machine_fdt() could instead
> >> be hoisted into setup_machine_fdt().
> >
> > Those functions are all quite a bit different. ARM matches the machine
> > desc while arm64 doesn't have any such thing. How the DTB gets mapped
> > into virtual space also varies.
>
> I argue that they _should be_ made to be more alike than different.  You
> have only pointed out two differences.  Of those, the mapping could be
> cleanly handled by an mdesc-> callback.  (I would have to look at the
> match to see if that could be handled easily, but I would expect so.)

The machine desc is in no way common and only used on a few arches
(and not even common across those arches). So there's no way the core
DT code can just call a mdesc callback without addressing making that
common first. And callbacks are just another way to call arch specific
functions which are another thing I'm trying to remove.

> On the other hand, in a previous reply you considered removing
> of_fdt_limit_memory(), which is only used for an exynos fixup.  If
> you do that, then patch 1 disappears, and we can continue to
> sweep under the rug the side effects that you reminded me of
> with patch 1.

I'm inclined to just drop the patch. Seemed like a simple clean-up and
I'm not interested in doing more right now (did you look at the stack
of stuff in dt/testing branch). Maybe someone else will care (spoiler:
they won't).

Rob

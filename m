Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1016FC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C943420862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="mRD5ci+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C943420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbeKFVR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:17:28 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:39871 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729878AbeKFVR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:17:27 -0500
Received: by mail-vk1-f194.google.com with SMTP id o10-v6so2787813vki.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 03:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mcMjyk3T3gFCKmpIOk2YoVt7vuTceNdTcGCCLS+JUXA=;
        b=mRD5ci+O9LcDW42utOnD76RjVLpDOn/zG+CyfAF49rSv/CqclAnC4IFpikjnrQ2Ln0
         P1STD13WbNClBsGy6GjS5tmgMU8F96aH14lSKGuWkQ21t9YpAGiyrHoGjRqUhQTP8B3u
         ztR1kYAU1bHUYuhX5EDnWnXUVXisrVIzJrpffYW01csP7JoOqxT4JzICyxBGMLuoef8L
         YpJjWZInBVKmjSscFwXQiAG6mzj6igy/1mJs+OORPFopH6dyPBfvU0nP1yN7Lye3bxoK
         v9Bzyu3GA5Ez/iIBfu7jvQrcCKB1DhnIJOp8u3DhtmIztYwdcEYUVDSjLB3Op4+2VTOi
         M9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcMjyk3T3gFCKmpIOk2YoVt7vuTceNdTcGCCLS+JUXA=;
        b=uH0+zY2sGjn3T+WwFLYqGsB34UgEI+M32iJqDCcCsC1BNMZtiVA79PP0TUb1Qlaavz
         x/M+x9qqrn3XTuKiz0i3dyDYFrvc5xmLCmQjTqBffn2T+1mDbFLzbX6hR4JTnRkoTqtX
         g20qHgooagbgA+vY+aj5+D8Nx0pSmLFI4/U/hB/lRgdXAX6QOMo9CW9gfXtEMAsbEn3E
         kKCsYeLdU2P6VkB9SK11rVyvZMsa+5swAQy0gtrNuRQ0KEnPzMepKfGFtQEg2DqOyKqG
         eE1gG92IzXK8g/9O0AMrbzSNOS/Hr4ceNLrqQ787QX2OclMpc7qQnisDfGU4gATgTs3k
         UGyg==
X-Gm-Message-State: AGRZ1gKB9WMhGAbpAHXzaFQ678Cu7RheqQNGUkg55jWPNwlWB4YrnTI1
        leh6416yUgAMPnpDIRPRyWDTUxbKDNjG8Bo5oaOcoA==
X-Google-Smtp-Source: AJdET5f7CCd9vBMFRyYkr9HXrMyn8R1mcJbmzaxjIp5ABbHsPXV3/j24uiULK6iYtH7sUBsAT8/kxOlGKKbtSvayxps=
X-Received: by 2002:a1f:eecf:: with SMTP id m198mr10968002vkh.49.1541505156091;
 Tue, 06 Nov 2018 03:52:36 -0800 (PST)
MIME-Version: 1.0
References: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
 <20181105122610.1555-2-hans.ml.holmberg@owltronix.com> <de7235bc-e458-381d-442e-11b42dd20dc9@gydle.com>
In-Reply-To: <de7235bc-e458-381d-442e-11b42dd20dc9@gydle.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Tue, 6 Nov 2018 12:52:25 +0100
Message-ID: <CANr-nt1Juq4OX3H+c2B4F4xRYO=HZxu_Sx+_d+0eOi4Y5gqGTA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] lightnvm: pblk: fix resubmission of overwritten
 write err lbas
To:     sboisvert@gydle.com
Cc:     Matias Bjorling <mb@lightnvm.io>,
        Javier Gonzalez <javier@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 4:12 PM Sebastien Boisvert <sboisvert@gydle.com> wrote:
>
>
>
> On 2018-11-05 7:26 a.m., Hans Holmberg wrote:
> > From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> >
> > Make sure we only look up valid lba addresses on the resubmission path.
> >
> > If an lba is invalidated in the write buffer, that sector will be
> > submitted to disk(as it is already mapped to a ppa), and that write
>
> submitted to disk(as it is already mapped to a ppa), and that write
>                  ^
>                  add a space
>
> > might fail, resulting in a crash when trying to look up the lba in the
> > mapping table (as the lba is marked as invalid).
> >
> > Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> > ---
> >  drivers/lightnvm/pblk-write.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
> > index fa8726493b39..3ddd16f47106 100644
> > --- a/drivers/lightnvm/pblk-write.c
> > +++ b/drivers/lightnvm/pblk-write.c
> > @@ -148,9 +148,11 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
> >               w_ctx = &entry->w_ctx;
> >
> >               /* Check if the lba has been overwritten */
> > -             ppa_l2p = pblk_trans_map_get(pblk, w_ctx->lba);
> > -             if (!pblk_ppa_comp(ppa_l2p, entry->cacheline))
> > -                     w_ctx->lba = ADDR_EMPTY;
> > +             if (w_ctx->lba != ADDR_EMPTY) {
> > +                     ppa_l2p = pblk_trans_map_get(pblk, w_ctx->lba);
> > +                     if (!pblk_ppa_comp(ppa_l2p, entry->cacheline))
> > +                             w_ctx->lba = ADDR_EMPTY;
> > +             }
>
> Was w_ctx->lba set to ADDR_EMPTY in the same kernel I/O thread ?
>
> I wonder if w_ctx->lba could become ADDR_EMPTY after
>
>                 if (w_ctx->lba != ADDR_EMPTY) {
>
> but before
>
>                         ppa_l2p = pblk_trans_map_get(pblk, w_ctx->lba);

It can't, the lba adress can only be changed on the write error
handling path, and we'll have to resubmit the write before that can
happen.
Thanks for the review.

/ Hans
>
>
> >
> >               /* Mark up the entry as submittable again */
> >               flags = READ_ONCE(w_ctx->flags);
> >

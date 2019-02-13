Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4B5C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376A921904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwDJouLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404358AbfBMQOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:14:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37657 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfBMQOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:14:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id q206so1344682pgq.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 08:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFeEiSq6X9MdvMn+WEZzeVSUmTbaeo29y0eByH52zdk=;
        b=QwDJouLRKq22xAbzIwIapWewBXRFZd81WrHABB1syN6D3q27cqCkTaZKGEysj0ejKF
         kjcZtAUFoS/8N8GrLqvCYhnD3cEdgCb3PnXJxDIjRL+OsHJ0twD9aufqE24sgx87N9OY
         izGslKrcQofCJVx3mEFrrx5wM2PQriJb7wBQ1bO4HDrmm7ESEZm6wCrvbHoJ2gAKBy41
         BWY9ANw3EnhJJo+e75tBYhFi00LTVGxoQFIxM45tCryGL2QEd0G4qgXzELTFFUzYqURn
         VG96JyMului0WPrL+LxZzHi186jVps73f4DpuR1pdJuXGD+XdSoBYqKRWyiAvd7MFmOG
         b+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFeEiSq6X9MdvMn+WEZzeVSUmTbaeo29y0eByH52zdk=;
        b=sHQHWgdFFPx7Hvxi7CenRI2YCTEEaruESE8VqdAPBQgcYFG6Fr/AvV89Ool362OqFe
         oTNfRAifKl2ghyc8lPmEiqn+RPXxXTSARHq4Q1R+ly4w5/BJtuC30GLt8U5S0sfBob5s
         TJaoG2lv7Fuq0tO4lV7OKhZHS21nshtxnYNYyCbCmXJcmxZeBO3oA9GXeFgBuzcyPtET
         ahdTMUZWvUg11z3ygqo+ERaTkayEGyzGAgH0Udx1ACXgRRMTKqmSY9lk6f0xTmUscAtP
         bsCSB9mNLY1FbTDlxDSv9eTZmNomGHSFBqkEn/Zlwq03FaVCgEabZ97FXw8uQtmRtvvu
         6ozA==
X-Gm-Message-State: AHQUAuZ/oSL8lkD68uNhRKe1Upa40TQ0TOPdc/wsNGgpHcYEkej0SybP
        7n6OK5OWA5v4KXq673D8Qn+ZYekhPiGEMgf72LEwVh94
X-Google-Smtp-Source: AHgI3IbgYWk4vtI5BDn1yQ8CaOYXD02EJPMnXbF85XDp5wl/cv8PaCBREUk3wc3wLs/LNEnQmzrvTWZQL0socuc0bcA=
X-Received: by 2002:a63:5153:: with SMTP id r19mr1111978pgl.281.1550074471611;
 Wed, 13 Feb 2019 08:14:31 -0800 (PST)
MIME-Version: 1.0
References: <5c383af0.1c69fb81.c393d.125c@mx.google.com> <CAFqt6zZnc_XauKefVavwana2cMLF4arEkiqjmfd25h-MWfsuJw@mail.gmail.com>
 <CAJr6mf16yq4gGD-GsfB+taT+JrcA3S3KaBMM-B=AMvdZPrvRaA@mail.gmail.com>
In-Reply-To: <CAJr6mf16yq4gGD-GsfB+taT+JrcA3S3KaBMM-B=AMvdZPrvRaA@mail.gmail.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Wed, 13 Feb 2019 21:44:19 +0530
Message-ID: <CAJr6mf38ZJ12Gf8WMHRami_DzLQ==Z0WCV8XA_03K9AB2DyVRQ@mail.gmail.com>
Subject: Re: [PATCH] fs/cachefiles/namei.c: Remove duplicate header
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 7:59 AM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> On Mon, Jan 14, 2019 at 1:34 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > On Fri, Jan 11, 2019 at 12:12 PM Sabyasachi Gupta
> > <sabyasachi.linux@gmail.com> wrote:
> > >
> > > Remove linux/xattr.h which is included more than once
> > >
> > > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> >
> > Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
> >
> If no further comment, can we get this patch in queue for 5.1 ?

If no further comment, can we get this patch in queue for 5.1 ?

> > > ---
> > >  fs/cachefiles/namei.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> > > index 95983c7..edecb7f 100644
> > > --- a/fs/cachefiles/namei.c
> > > +++ b/fs/cachefiles/namei.c
> > > @@ -20,7 +20,6 @@
> > >  #include <linux/namei.h>
> > >  #include <linux/security.h>
> > >  #include <linux/slab.h>
> > > -#include <linux/xattr.h>
> > >  #include "internal.h"
> > >
> > >  #define CACHEFILES_KEYBUF_SIZE 512
> > > --
> > > 2.7.4
> > >

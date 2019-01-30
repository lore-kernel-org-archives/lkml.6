Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3027CC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F292920857
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9YqSvO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbfA3Ocs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:32:48 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55612 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3Ocs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:32:48 -0500
Received: by mail-it1-f196.google.com with SMTP id m62so10501444ith.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 06:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mf2+BEE8w1aafVM7M3E3AjS2e/fUy2pN4xCa7tnT+go=;
        b=a9YqSvO8i7HhM+7r3JnNKZVaUOz1CDZ89k7QsEOlAC34AoFGpJOhfWm3NokUID4Jrf
         D82MiNk9P2tF0gedCoO4mQtwEu0Bqv2VaBDhJE1AGeUCGISMzYf9s9KG0E0k/d4Zz6cd
         4I+/CV2x4ZoWKH+BpUgwX222Nw1mQE5FHtyPG7pQwfqXqywiyrX4f0qAFA7zvijyETUS
         ls92C43Wv61/4BbltOb0OGaCksedrnUeOo4QfW11EIib836Uj8uh2xIqpf5r3FOTRGwY
         jqSTOnG1PbltQURKxeJAgDSfewn46tHUtDTiu3VoBSUGadoOp+HSF+f1BQWpFVL+w2g3
         UTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mf2+BEE8w1aafVM7M3E3AjS2e/fUy2pN4xCa7tnT+go=;
        b=lKGiTi7ORGW7RULb6hZEuZJ9Uaon3eH1TVFZnq+H7YR1nZN8WOcXwyWHSMge3JVBs7
         3n1sMPk+19NxDLu9JurN0kKaw6laIxEUCwN4hsnPgG7eaBvf0Gfiw9AgI3mzoc+ifxRC
         j2tvhfk3ee/4/7YsiQfE8zuE+Dw5eqsUsmKFGNl92q7VQRrh1SMtazIOpSP7Zlz/8BbR
         nQhg9g86uq3uTXj/3yuU6vU/sx4/J8A7AMG8x09S/w/eaxFP15pI4PYZ9EiL47av9kAL
         KTmyWZQt5qPLoqWJ20BUfyhgx4n6fjidDvhE/ozcbgI7a+jLALRktIZ01GlLw4LstGWr
         gM5A==
X-Gm-Message-State: AJcUukdwd7XJ8ecWPqMaxyOVX1m9jxE5vu24Qt33cxm7O+JjyNeAD5g9
        sYHhFjJ9UxGiTec5MLuMCEcSLNZrNpQkOwlJq1Q10QiWpcE=
X-Google-Smtp-Source: ALg8bN7AYkSIOD6wNRLTUaZQu9OoWZmbUcJZxad5BHjFfGa7HH9YWY1/6PCsENx0aKJKB9UN4iNPJZy/p0BfS/fvsfQ=
X-Received: by 2002:a24:5a8f:: with SMTP id v137mr15394663ita.65.1548858767456;
 Wed, 30 Jan 2019 06:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20190118095152.GA2563@hp-pavilion-15-notebook-pc-brajeswar> <20190118154710.GA29661@guoren-Inspiron-7460>
In-Reply-To: <20190118154710.GA29661@guoren-Inspiron-7460>
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
Date:   Wed, 30 Jan 2019 20:02:35 +0530
Message-ID: <CAFqtX7kqMGFEhMb2BOnoLJYMgc_swJ+WzhkxNXrZC3pGod_-nA@mail.gmail.com>
Subject: Re: [PATCH] arch/csky/mm/fault.c: Remove duplicate header
To:     Guo Ren <guoren@kernel.org>
Cc:     ren_guo@c-sky.com, Arnd Bergmann <arnd@arndb.de>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 9:17 PM Guo Ren <guoren@kernel.org> wrote:
>
> Thx Brajeswar,
>
> Reviewed-by: Guo Ren <ren_guo@c-sky.com>
> Acked-by: Guo Ren <ren_guo@c-sky.com>

If no further comment, can we get this patch in queue for 5.1 ?

>
> On Fri, Jan 18, 2019 at 03:21:52PM +0530, Brajeswar Ghosh wrote:
> > Remove linux/kernel.h which is included more than once
> >
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> > ---
> >  arch/csky/mm/fault.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
> > index 7df57f90b52c..16d8378cf12d 100644
> > --- a/arch/csky/mm/fault.c
> > +++ b/arch/csky/mm/fault.c
> > @@ -15,7 +15,6 @@
> >  #include <linux/smp.h>
> >  #include <linux/version.h>
> >  #include <linux/vt_kern.h>
> > -#include <linux/kernel.h>
> >  #include <linux/extable.h>
> >  #include <linux/uaccess.h>
> >
> > --
> > 2.17.1
> >

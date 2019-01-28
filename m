Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FF3C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691EC20882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY4F9gyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfA1Gej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:34:39 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35567 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfA1Gej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:34:39 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so13213231ljb.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 22:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QHgLGG8mEEUNiU9mEp4wmCyZjP0X29GG9+uZhXvM/LQ=;
        b=DY4F9gyOoziHc/0zvo2HvQqk7zi0Fl+eUe0M4zqI6oHJNScV1za79IW7dDuVbr1eFr
         1JyzSNjKtiaBVN2cv349SxrOuxTKpwabzvXigxZ3W8BJvTHRoHErnzcqOBZ8QQc/EKz9
         RaX3smqYDyHchDD7AOjgY8lakicp314+zFYGVjHONwr4eq1OtKBr3y7WQ4DDqGl3dUYc
         dv4KmZaMLyhY1HapcSuzUX+WopbjvxPP0owas6VmMAKHVKyOki2RQPqhXxtdg/jdt8Z2
         9fzR1vxGXwXoaDtNfT985wMzpsSZsQr0YLI7Yx54JotwqlRzOvmzXqsjMpJeOeapdS6T
         fakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHgLGG8mEEUNiU9mEp4wmCyZjP0X29GG9+uZhXvM/LQ=;
        b=WVcLlup1H2ytDIM6akhACrxwwQKfAFPPrIphEJPFVQr4326ELe9cXcxXDDIvjbtDda
         VDzYmkRquHqEiho8xJ/v/5ekO/uDpiF9W2Go1DfgQ3aDjm1T81cWFPnqVwOz3gBJ92ru
         gyJUCg8ceUNYlj4XdMb0cVOko6vHi2t8dFhkF8vNKTmn/HnQKpxTyyIn0uOqHAdU6h19
         kroWWbjtELQRW58So0sdrK40N5uVBEte43aGIhFoO5BgA0aU3KjNnqpDArBPh7IqZakG
         ifE6NrI69IWsehutFP4MB68qNAKBiiZW1bg/OQzt/+BPH9thEASBaMRVI50tCBJ/rwkP
         ub7Q==
X-Gm-Message-State: AJcUukfFno/PoBrzMTxMPzDQrV0IeR2CiD67wvriBvxg25One+8iYp83
        f4kWp0B5+RjkWJMFgfyRnKuocuev0u2dVTDjnkI=
X-Google-Smtp-Source: ALg8bN4ASS6RJ6hXYxOAQPKuxhUc9rkHC3J3n8gXstmaeNandY6V+2Nh5M8XdAMpLXp53RUYIN/6yl2XQycoSn/m/H0=
X-Received: by 2002:a2e:8643:: with SMTP id i3-v6mr17361424ljj.43.1548657277194;
 Sun, 27 Jan 2019 22:34:37 -0800 (PST)
MIME-Version: 1.0
References: <20190107173719.GA30197@jordon-HP-15-Notebook-PC> <eab5c59d-cfb4-bd2a-de07-7db827830472@gmail.com>
In-Reply-To: <eab5c59d-cfb4-bd2a-de07-7db827830472@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 28 Jan 2019 12:04:25 +0530
Message-ID: <CAFqt6zb0cU3TjAs0LO-DL3Ut98-7=b7cP9+hZ+bUxDLD2EN2vA@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH] arch/arm/xen: Remove duplicate header
To:     Oleksandr Andrushchenko <andr2000@gmail.com>
Cc:     sstabellini@kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        xen-devel@lists.xenproject.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 4:08 PM Oleksandr Andrushchenko
<andr2000@gmail.com> wrote:
>
> On 1/7/19 7:37 PM, Souptick Joarder wrote:
> > Remove duplicate header which is included twice.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Can we get this patch in queue for 5.1 ?
> > ---
> >   arch/arm/xen/mm.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> > index cb44aa2..e1d44b9 100644
> > --- a/arch/arm/xen/mm.c
> > +++ b/arch/arm/xen/mm.c
> > @@ -7,7 +7,6 @@
> >   #include <linux/of_address.h>
> >   #include <linux/slab.h>
> >   #include <linux/types.h>
> > -#include <linux/dma-mapping.h>
> >   #include <linux/vmalloc.h>
> >   #include <linux/swiotlb.h>
> >
>

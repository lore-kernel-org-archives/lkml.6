Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B7BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FB02175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db2TIyug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfA3CcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 21:32:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35979 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbfA3Cb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 21:31:59 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so9669990pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 18:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5VKVCmqAK7XDYxf7ZhHCYlIGgdtiK8Gfv2Vaeypfz8w=;
        b=db2TIyugR8FAJDwOdavBhOTOJfymtN+WKcIuEHv5DfdwYYxpN5rIW2K8+PS6C3vEYx
         gmBv/beVPC7t57ib2EocTVo6E9seMQHgJtH4eau54xhFtlMAEqTggYoaD01pxRUH7wbu
         siZTkNSq1u0tSBwbbIhWth7EZz/GHRpuPvw7nU1/dvRBTnZ9iBMwO6f9R8ChAbN73p3i
         08jx+r1w5L7e9tQvq7d5x5e6Z+2vvvOuTcqU4cwvuUJjCgTmhQ76Ywrv3PkLVRpbrEth
         dDkE+uQMY/K1yIQl6mc8pzr0cwLvI89QIXLFXzlZs/NGdX8LPgvvs8mz08LFgqS9ke5E
         KbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5VKVCmqAK7XDYxf7ZhHCYlIGgdtiK8Gfv2Vaeypfz8w=;
        b=CWCi3+YdNdED1/KhTnV7jsndsszlB0tzMj7XMP8ciRWT1DwOb8JaBHKMSlZc7FLRrC
         Rv54I0EgFkZ5DH2fzUrbeCEip7yMvCEhiYzuRqpbrclNmzElPgcq/mv8SlMKBNb4Sccn
         ReJqxiWCYM2UnqP2rMe0q/gC8P7tRC1W5rIe+X9z3eWGMpJ/0Id1n6pYg0kasT5MkOY5
         WYFjDY20NmmIhCZ+5EGnYyQFG6w6zlr1vmCmNddDwzP71FVfYP14O3/gNQZbQwrTSf01
         oZhrP9QhBwl1e0ch1137PN5gyNGDf4Z50sf4JZhn9thPa2+WeIt2HMa/eHKL8lqkuCLE
         c8Pg==
X-Gm-Message-State: AJcUukfEs//OOvL/053LSWp8Y+heIfbkAXeL5C7PTUouQp0OF68HfqvI
        eSuHXXAR4SpI4/nC+8BFc/MQhzEIwSQwJ753l6k=
X-Google-Smtp-Source: ALg8bN61y+VHNz5ozljJ7R//6MQUyMQprcVjwFzEUrBEgFcKREKHryazMMyKiI+5oyga8wTC7EFfkcQY9GtBw5p5y6E=
X-Received: by 2002:a63:5153:: with SMTP id r19mr25783585pgl.281.1548815519335;
 Tue, 29 Jan 2019 18:31:59 -0800 (PST)
MIME-Version: 1.0
References: <5c38b64a.1c69fb81.a0651.e342@mx.google.com> <CAFqt6zbaAmQCaKXDGR6hJEyh2PXJzQEsyO_TuHMg0jOX38_wog@mail.gmail.com>
In-Reply-To: <CAFqt6zbaAmQCaKXDGR6hJEyh2PXJzQEsyO_TuHMg0jOX38_wog@mail.gmail.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Wed, 30 Jan 2019 08:01:47 +0530
Message-ID: <CAJr6mf25=-92bt9xx1nvjnGHo-Vx0msRYCpytd-diAP2PB5b2w@mail.gmail.com>
Subject: Re: [PATCH] fs/coda/psdev.c: Remove duplicate header
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     jaharkes@cs.cmu.edu, coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 1:40 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Fri, Jan 11, 2019 at 8:59 PM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
> >
> > Remove linux/poll.h which is included more than once
> >
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>
> Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
>
If no further comment, can we get this patch in queue for 5.1 ?
> > ---
> >  fs/coda/psdev.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
> > index c5234c2..f2bb798 100644
> > --- a/fs/coda/psdev.c
> > +++ b/fs/coda/psdev.c
> > @@ -39,7 +39,6 @@
> >  #include <linux/device.h>
> >  #include <linux/pid_namespace.h>
> >  #include <asm/io.h>
> > -#include <linux/poll.h>
> >  #include <linux/uaccess.h>
> >
> >  #include <linux/coda.h>
> > --
> > 2.7.4
> >

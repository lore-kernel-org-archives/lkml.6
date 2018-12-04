Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678EAC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7712082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="POPCE9YA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7712082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeLDOpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:45:04 -0500
Received: from mta-p3.oit.umn.edu ([134.84.196.203]:41134 "EHLO
        mta-p3.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbeLDOpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:45:04 -0500
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Dec 2018 09:45:03 EST
Received: from localhost (localhost [127.0.0.1])
        by mta-p3.oit.umn.edu (Postfix) with ESMTP id 2E96B773
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 14:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1543934137; x=1545748538; bh=fxK91B2Yz0
        Ck0tUzvkhSsKruWIrkhKWLdQ/YbD7u6S8=; b=POPCE9YAB1mQiBXhxCBNWXh8LP
        YCIPc9HXytDxXBc+RCfz84/Gr1vZBpb56msHvMxZQBbCTb1m30b3YsQldtz74pEt
        abHpGU0/SJKQFn3+ibaIDiJvYYbEEf+PRH7pf/dUigp7rh7VFE0cUwRdeGRrNAlA
        GbHxFZ3RPDcbhUhZk/TaYI5ztLMkJf4fYlCsvxJ5rwuPePOmeukYjSS1J7UQfD9G
        XgpwLpY06gjtCjZo7Y7GDEpSIOhZ4UC5m980nB+rQv+4k+UGxeT1e8gCSvGh755k
        bLXEA/2q1KXf0FVw3eC/HOUOruBxpi4OzzWS8IuzC0mh90uC0IvQepwoUPRA==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p3.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p3.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 51TIRMq6Pz9G for <linux-kernel@vger.kernel.org>;
        Tue,  4 Dec 2018 08:35:37 -0600 (CST)
Received: from mail-it1-f177.google.com (mail-it1-f177.google.com [209.85.166.177])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p3.oit.umn.edu (Postfix) with ESMTPSA id 00FC679F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 08:35:37 -0600 (CST)
Received: by mail-it1-f177.google.com with SMTP id i145so15626488ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 06:35:36 -0800 (PST)
X-Gm-Message-State: AA+aEWZAz2+hfaO7oklOUT9SySXQoVDz4BYWRha2DDcgEsXuU9G8lEXW
        GxgAEKpdb+a8zmSUPt/mW/Sey7edhUF8WsS1NMc=
X-Google-Smtp-Source: AFSGD/Uf0AhRCIX7vaZpq5y3wONR4kt4eLYppjYgqID1wTkLrASx/XEi7fRAWFRFCQ5yyn+c4TarGL+CTrZIKDntjMc=
X-Received: by 2002:a24:97c3:: with SMTP id k186mr12598454ite.125.1543934136720;
 Tue, 04 Dec 2018 06:35:36 -0800 (PST)
MIME-Version: 1.0
References: <1539891966-8017-1-git-send-email-wang6495@umn.edu> <1541384613.28670.5.camel@intel.com>
In-Reply-To: <1541384613.28670.5.camel@intel.com>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Tue, 4 Dec 2018 08:35:00 -0600
X-Gmail-Original-Message-ID: <CAAa=b7cNJhESLL8uYt97MYiXkySo9_7oqYA9pD7KCz0p=khwcg@mail.gmail.com>
Message-ID: <CAAa=b7cNJhESLL8uYt97MYiXkySo9_7oqYA9pD7KCz0p=khwcg@mail.gmail.com>
Subject: Re: [PATCH] misc: mic: fix a DMA pool free failure
To:     sudeep.dutt@intel.com
Cc:     Kangjie Lu <kjlu@umn.edu>, ashutosh.dixit@intel.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 4, 2018 at 8:05 PM Sudeep Dutt <sudeep.dutt@intel.com> wrote:
>
> On Thu, 2018-10-18 at 14:46 -0500, Wenwen Wang wrote:
> > In _scif_prog_signal(), a DMA pool is allocated if the MIC Coprocessor is
> > not X100, i.e., the boolean variable 'x100' is false. This DMA pool will be
> > freed eventually through the callback function scif_prog_signal_cb() with
> > the parameter of 'status', which actually points to the start of DMA pool.
> > Specifically, in scif_prog_signal_cb(), the 'ep' field and the
> > 'src_dma_addr' field of 'status' are used to free the DMA pool by invoking
> > dma_pool_free(). Given that 'status' points to the start address of the DMA
> > pool, both 'status->ep' and 'status->src_dma_addr' are in the DMA pool. And
> > so, the device has the permission to access them. Even worse, a malicious
> > device can modify them. As a result, dma_pool_free() will not succeed.
> >
> > To avoid the above issue, this patch introduces a new data structure, i.e.,
> > scif_cb_arg, to store the arguments required by the call back function. A
> > variable 'cb_arg' is allocated in _scif_prog_signal() to pass the
> > arguments. 'cb_arg' will be freed after dma_pool_free() in
> > scif_prog_signal_cb().
> >
> > Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> > ---
> >  drivers/misc/mic/scif/scif_fence.c | 17 +++++++++++++----
> >  drivers/misc/mic/scif/scif_rma.h   | 14 ++++++++++++++
> >  2 files changed, 27 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/misc/mic/scif/scif_fence.c b/drivers/misc/mic/scif/scif_fence.c
> > index cac3bcc..30f7d9b 100644
> > --- a/drivers/misc/mic/scif/scif_fence.c
> > +++ b/drivers/misc/mic/scif/scif_fence.c
> > @@ -195,10 +195,11 @@ static inline void *scif_get_local_va(off_t off, struct scif_window *window)
> >
> >  static void scif_prog_signal_cb(void *arg)
> >  {
> > -     struct scif_status *status = arg;
> > +     struct scif_cb_arg *cb_arg = arg;
> >
> > -     dma_pool_free(status->ep->remote_dev->signal_pool, status,
> > -                   status->src_dma_addr);
> > +     dma_pool_free(cb_arg->ep->remote_dev->signal_pool, cb_arg->status,
> > +                   cb_arg->src_dma_addr);
> > +     kfree(cb_arg);
> >  }
> >
> >  static int _scif_prog_signal(scif_epd_t epd, dma_addr_t dst, u64 val)
> > @@ -209,6 +210,7 @@ static int _scif_prog_signal(scif_epd_t epd, dma_addr_t dst, u64 val)
> >       bool x100 = !is_dma_copy_aligned(chan->device, 1, 1, 1);
> >       struct dma_async_tx_descriptor *tx;
> >       struct scif_status *status = NULL;
> > +     struct scif_cb_arg *cb_arg = NULL;
> >       dma_addr_t src;
> >       dma_cookie_t cookie;
> >       int err;
> > @@ -257,8 +259,15 @@ static int _scif_prog_signal(scif_epd_t epd, dma_addr_t dst, u64 val)
> >               goto dma_fail;
> >       }
> >       if (!x100) {
> > +             err = -ENOMEM;
>
> Should err be set to -ENOMEM only if the cb_arg allocation fails?
>
> > +             cb_arg = kmalloc(sizeof(*cb_arg), GFP_KERNEL);
> > +             if (!cb_arg)
> > +                     goto dma_fail;
> > +             cb_arg->src_dma_addr = src;
> > +             cb_arg->status = status;
> > +             cb_arg->ep = ep;
> >               tx->callback = scif_prog_signal_cb;
> > -             tx->callback_param = status;
> > +             tx->callback_param = cb_arg;
> >       }
>
> cb_arg should be freed if there is a dma_submit_error(..) below in the
> dma_fail path.
>
> Wenwen, can you please fix these up and resend the patch?

Sure, will fix the issues and resubmit the patch. Thanks!

Wenwen

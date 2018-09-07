Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42192C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E874F20876
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T87Av5A1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E874F20876
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeIGINO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 04:13:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32861 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIGINO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 04:13:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id s7-v6so6280945pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 20:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jhc+evSb2NWmZ1C7cp/56oZ3vjfa7bQGOI0fMd45bY4=;
        b=T87Av5A1II3ywRraBekeuTU/im5E27WiQdiPVIe4660ZcyP8ZnTW8PH2wkWW/t3obJ
         3+gJyenUmD5s8S4y8VxDZSCEHy908SOelWaCkkKPiI+8+0BVwkdPmydvSQypTrAl1ZMw
         IS2CnMslTgkpPG918pSdYRGBFOf1kR8H6XfgphecC+iQEV7P+mXWJ73rFjNmaamLnbmO
         rud1NDkF59kSQn30+1uA2nbYcWN+bFO7K0OhHU86Yo9TGleREd0Lrg2nery1yHYeOa5e
         KG3onyHMysVNTIcMoRals1C9Hm0LETjWeidxWuHdss8zAjeQPWSPuuzjXsn3bMYR+F53
         rbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jhc+evSb2NWmZ1C7cp/56oZ3vjfa7bQGOI0fMd45bY4=;
        b=pheAULWaZnHB6nSEqGjySNxlNbO34FdkpHrcUF4eigKksFOrBCKTHKJl2yjYmwDMCk
         gZmIN1T5211Pd7yHmN1hOnYicqmlnk3VfqC4Qa63Y8pBckL2S9HfcQAR8ooB6chWQJmq
         5hqFrcTnxgKuR2DY037frvKd231Q7zm/iHJwarxAb9UdZgoaq6KzTWE0aDdFcMvOWpLH
         /C875kEltqWkd3pEWVCcQBBF47SGY549ildfNkOUTTRHEOY8SHpyjUonhOT25moeO1SO
         xiWiAoX9NiIWDIYgevlEPoIK7MVNf0hDYdjgwRNgyTROUzhAWgQh0i5T0xVhMglwJyw0
         ha5A==
X-Gm-Message-State: APzg51AX+3vIGXUoJzZJOh62ENkN8eOHLmjlx9FKmfPROAWgTInOtqQ6
        //zQOVFb20OIUCC3VFbB2d4=
X-Google-Smtp-Source: ANB0VdZGxXJYr2+xYVMcg42tKTVlOpg9+fZdpDWbd/aEq69UwgmojPYqTEZQyByhpuQh+4ytmvb4Gw==
X-Received: by 2002:a62:da0b:: with SMTP id c11-v6mr6346790pfh.68.1536291265477;
        Thu, 06 Sep 2018 20:34:25 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id p1-v6sm8773048pfn.53.2018.09.06.20.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 20:34:23 -0700 (PDT)
Date:   Fri, 7 Sep 2018 12:34:19 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Martijn Coenen <maco@android.com>, gregkh@linuxfoundation.org
Cc:     "Dae R. Jeong" <threeearcat@gmail.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: KASAN: null-ptr-deref Write in binder_update_page_range
Message-ID: <20180907033419.GA146393@rodete-desktop-imager.corp.google.com>
References: <20180822060704.GA12007@dragonet>
 <20180823052956.GA28628@rodete-desktop-imager.corp.google.com>
 <CAB0TPYGZHD2rH=Ce8GzB451rnukzV8vxNGJ4oJQKa347P8qORA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0TPYGZHD2rH=Ce8GzB451rnukzV8vxNGJ4oJQKa347P8qORA@mail.gmail.com>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Martijn,

Greg, could you have a look to pick up?

On Mon, Aug 27, 2018 at 03:35:24PM +0200, Martijn Coenen wrote:
> Thanks Minchan!
> 
> On Thu, Aug 23, 2018 at 7:29 AM, Minchan Kim <minchan@kernel.org> wrote:
> > Signed-off-by: Todd Kjos <tkjos@google.com>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> Reviewed-by: Martijn Coenen <maco@android.com>
> 
> > ---
> >  drivers/android/binder_alloc.c | 43 +++++++++++++++++++++++++++-------
> >  1 file changed, 35 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> > index 3f3b7b253445..64fd96eada31 100644
> > --- a/drivers/android/binder_alloc.c
> > +++ b/drivers/android/binder_alloc.c
> > @@ -332,6 +332,35 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
> >         return vma ? -ENOMEM : -ESRCH;
> >  }
> >
> > +
> > +static inline void binder_alloc_set_vma(struct binder_alloc *alloc,
> > +               struct vm_area_struct *vma)
> > +{
> > +       if (vma)
> > +               alloc->vma_vm_mm = vma->vm_mm;
> > +       /*
> > +        * If we see alloc->vma is not NULL, buffer data structures set up
> > +        * completely. Look at smp_rmb side binder_alloc_get_vma.
> > +        * We also want to guarantee new alloc->vma_vm_mm is always visible
> > +        * if alloc->vma is set.
> > +        */
> > +       smp_wmb();
> > +       alloc->vma = vma;
> > +}
> > +
> > +static inline struct vm_area_struct *binder_alloc_get_vma(
> > +               struct binder_alloc *alloc)
> > +{
> > +       struct vm_area_struct *vma = NULL;
> > +
> > +       if (alloc->vma) {
> > +               /* Look at description in binder_alloc_set_vma */
> > +               smp_rmb();
> > +               vma = alloc->vma;
> > +       }
> > +       return vma;
> > +}
> > +
> >  static struct binder_buffer *binder_alloc_new_buf_locked(
> >                                 struct binder_alloc *alloc,
> >                                 size_t data_size,
> > @@ -348,7 +377,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
> >         size_t size, data_offsets_size;
> >         int ret;
> >
> > -       if (alloc->vma == NULL) {
> > +       if (!binder_alloc_get_vma(alloc)) {
> >                 binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
> >                                    "%d: binder_alloc_buf, no vma\n",
> >                                    alloc->pid);
> > @@ -723,9 +752,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
> >         buffer->free = 1;
> >         binder_insert_free_buffer(alloc, buffer);
> >         alloc->free_async_space = alloc->buffer_size / 2;
> > -       barrier();
> > -       alloc->vma = vma;
> > -       alloc->vma_vm_mm = vma->vm_mm;
> > +       binder_alloc_set_vma(alloc, vma);
> >         mmgrab(alloc->vma_vm_mm);
> >
> >         return 0;
> > @@ -754,10 +781,10 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
> >         int buffers, page_count;
> >         struct binder_buffer *buffer;
> >
> > -       BUG_ON(alloc->vma);
> > -
> >         buffers = 0;
> >         mutex_lock(&alloc->mutex);
> > +       BUG_ON(alloc->vma);
> > +
> >         while ((n = rb_first(&alloc->allocated_buffers))) {
> >                 buffer = rb_entry(n, struct binder_buffer, rb_node);
> >
> > @@ -900,7 +927,7 @@ int binder_alloc_get_allocated_count(struct binder_alloc *alloc)
> >   */
> >  void binder_alloc_vma_close(struct binder_alloc *alloc)
> >  {
> > -       WRITE_ONCE(alloc->vma, NULL);
> > +       binder_alloc_set_vma(alloc, NULL);
> >  }
> >
> >  /**
> > @@ -935,7 +962,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
> >
> >         index = page - alloc->pages;
> >         page_addr = (uintptr_t)alloc->buffer + index * PAGE_SIZE;
> > -       vma = alloc->vma;
> > +       vma = binder_alloc_get_vma(alloc);
> >         if (vma) {
> >                 if (!mmget_not_zero(alloc->vma_vm_mm))
> >                         goto err_mmget;
> > --
> > 2.18.0.1017.ga543ac7ca45-goog
> >
> >
> >
> >

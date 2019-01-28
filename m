Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EE6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA7421736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX2iQBot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfA1Hxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:53:52 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33006 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfA1Hxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:53:52 -0500
Received: by mail-ua1-f65.google.com with SMTP id t8so5287275uap.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 23:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrKy1dCzL+xr4OrZSZFW3EiUcp4RCDgp4sl4vaiPDhs=;
        b=XX2iQBotls8pebec0Psn3M4wBnG+XyP1DLOoIWsUx7sfbfykiIOD5WF6CF6f1uEUe8
         AgCfulzcsto/HVGvi1+x5b5NF+m+8elAcDTFRTfm+d+h4HeCJDJr3LHP0Jugs2NGd/m6
         qzDOMFyXTcUKfJ0no8GjT/1L11ah8k5Ma34TS78rgVJs5stDdjO47+6FIVX8VQmWX+rP
         1ZsO7q6jh/FtjDHFfy8Rhmu/RAiGXzVW/b6Sygioa1c3bzZCk4S/MLSHp4dQYuzYlSz+
         pjs4b2dGNfbbjnWeYQLgI3B7JHVX7uuGGbMxfUKisgDdYE/kSo9sBYOfqq/KVvwR3G5M
         XiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrKy1dCzL+xr4OrZSZFW3EiUcp4RCDgp4sl4vaiPDhs=;
        b=S14atWgbSYdh27nLyy5MAKNXvONSk0QY6c1NIgd3LY0YbNKkvDZv2U2nkrPdik9qQ8
         0SCfRkCEyHpfmxhsDfESM7YeIxNo93pIMFK3/09mnbkfKw37iG/qv12UFIvK2x48rdFm
         QOYC9iLhHFLyEuDRc/zxrK+jy9UV7Ns85t90RzIqfOQyRCJ8X7pkehm8jpHY8XEhLnJt
         fJL9PyO3hb8PD9phWaQmS+aLqomznn+PZQPgCLIy5PLwKn4TFz6o3N8/Y2BcEQ8Embcu
         j/wjj9BSKt1kw4cg+u/CNmPWML+MZ8hAc58VGqyXsPKHXzxOT9Aq9UDDKTsyctqDxEKE
         Km+A==
X-Gm-Message-State: AJcUukeXwsA8LpA6PG8Kkh3AJbY3pWEKOLAexqE1kV4CMVp6gaJWizz5
        V/Q+FJ45naFm2tTLY5l079NEYyj9aKjEfjSdbInZXL3D
X-Google-Smtp-Source: ALg8bN7ymChpcPPSAKgT7vRrX/subR7K7432TXjdLg7KZUryki742tYJeT5XRcUN6cStk6gjAKRAKs0cCrwooewpFN4=
X-Received: by 2002:ab0:6446:: with SMTP id j6mr8508632uap.2.1548662030544;
 Sun, 27 Jan 2019 23:53:50 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <20190123000057.31477-6-oded.gabbay@gmail.com>
 <20190123122827.GC4747@rapoport-lnx> <CAFCwf10C0XxT4fHZ9eE0o48kFS7Cxcn9FgTfAzWOHOM=Vrk=Fg@mail.gmail.com>
 <20190127064928.GB16853@rapoport-lnx>
In-Reply-To: <20190127064928.GB16853@rapoport-lnx>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 28 Jan 2019 09:55:23 +0200
Message-ID: <CAFCwf104zdiD8LmpDAkCDP3UHSvbVwHw0tsBWYJ8F7pHmBdi+g@mail.gmail.com>
Subject: Re: [PATCH 05/15] habanalabs: add command buffer module
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ogabbay@habana.ai
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 8:49 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Fri, Jan 25, 2019 at 11:47:03PM +0200, Oded Gabbay wrote:
> > On Wed, Jan 23, 2019 at 2:28 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
> > > On Wed, Jan 23, 2019 at 02:00:47AM +0200, Oded Gabbay wrote:
> > > > This patch adds the CB module, which allows the user to create and
> > > > destroy CBs and to map them to the user's process address-space.
> > >
> > > Can you please spell "command buffer" at least first time it's mentioned?
> > fixed
> > >
> > > > A command buffer is a memory blocks that reside in DMA-able address-space
> > > > and is physically contiguous so it can be accessed by the device without
> > > > MMU translation. The command buffer memory is allocated using the
> > > > coherent DMA API.
> > > >
> > > > When creating a new CB, the IOCTL returns a handle of it, and the
> > > > user-space process needs to use that handle to mmap the buffer to get a VA
> > > > in the user's address-space.
> > > >
> > > > Before destroying (freeing) a CB, the user must unmap the CB's VA using the
> > > > CB handle.
> > > >
> > > > Each CB has a reference counter, which tracks its usage in command
> > > > submissions and also its mmaps (only a single mmap is allowed).
> > > >
> > > > The driver maintains a pool of pre-allocated CBs in order to reduce
> > > > latency during command submissions. In case the pool is empty, the driver
> > > > will go to the slow-path of allocating a new CB, i.e. calling
> > > > dma_alloc_coherent.
> > > >
> > > > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > > > ---
> > > >  drivers/misc/habanalabs/Makefile           |   3 +-
> > > >  drivers/misc/habanalabs/command_buffer.c   | 414 +++++++++++++++++++++
> > > >  drivers/misc/habanalabs/device.c           |  43 ++-
> > > >  drivers/misc/habanalabs/goya/goya.c        |  28 ++
> > > >  drivers/misc/habanalabs/habanalabs.h       |  95 ++++-
> > > >  drivers/misc/habanalabs/habanalabs_drv.c   |   2 +
> > > >  drivers/misc/habanalabs/habanalabs_ioctl.c | 102 +++++
> > > >  include/uapi/misc/habanalabs.h             |  62 +++
> > > >  8 files changed, 746 insertions(+), 3 deletions(-)
> > > >  create mode 100644 drivers/misc/habanalabs/command_buffer.c
> > > >  create mode 100644 drivers/misc/habanalabs/habanalabs_ioctl.c
> > > >  create mode 100644 include/uapi/misc/habanalabs.h
>
> [ ... ]
>
> > > > +int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
> > > > +                     u32 cb_size, u64 *handle, int ctx_id)
> > > > +{
> > > > +     struct hl_cb *cb;
> > > > +     bool alloc_new_cb = true;
> > > > +     int rc;
> > > > +
> > > > +     if (hdev->disabled) {
> > > > +             dev_warn_ratelimited(hdev->dev,
> > > > +                     "Device is disabled !!! Can't create new CBs\n");
> > > > +             rc = -EBUSY;
> > > > +             goto out_err;
> > > > +     }
> > > > +
> > > > +     /* Minimum allocation must be PAGE SIZE */
> > > > +     if (cb_size < PAGE_SIZE)
> > > > +             cb_size = PAGE_SIZE;
> > > > +
> > > > +     if (ctx_id == HL_KERNEL_ASID_ID &&
> > > > +                     cb_size <= hdev->asic_prop.cb_pool_cb_size) {
> > > > +
> > > > +             spin_lock(&hdev->cb_pool_lock);
> > > > +             if (!list_empty(&hdev->cb_pool)) {
> > > > +                     cb = list_first_entry(&hdev->cb_pool, typeof(*cb),
> > > > +                                     pool_list);
> > > > +                     list_del(&cb->pool_list);
> > > > +                     spin_unlock(&hdev->cb_pool_lock);
> > > > +                     alloc_new_cb = false;
> > > > +             } else {
> > > > +                     spin_unlock(&hdev->cb_pool_lock);
> > > > +                     dev_warn_once(hdev->dev, "CB pool is empty\n");
> > >
> > > Isn't it going to be a false alarm when you allocate the cb for the first
> > > time?
> > Why ?
> > The cb_pool list holds a list of available CBs. See hl_cb_pool_init()
> > - it adds newly allocated CBs to this pool list.
> >
> > if (!list_empty(&hdev->cb_pool)) {       -  this checks whether the
> > pool is not empty so we can take an available CB from it. If the list
> > is empty (hence the pool is empty), we print the warning.
>
> Sorry if it's too much nitpicking, but why the allocation of the first cb
> should be a warning? There's nothing wrong there... Maybe dev_dbg()
> instead?
Yeah, that's a fair point. The issue is I would like to know if we
reach to this state and dev_dbg isn't usually enabled.
Still, I get what you are saying and I'll change this to dev_dbg.

>
> > > > +             }
> > > > +     }
> > > > +
> > > > +     if (alloc_new_cb) {
> > > > +             cb = hl_cb_alloc(hdev, cb_size, ctx_id);
> > > > +             if (!cb) {
> > > > +                     rc = -ENOMEM;
> > > > +                     goto out_err;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     cb->hdev = hdev;
> > > > +     cb->ctx_id = ctx_id;
> > > > +
> > > > +     spin_lock(&mgr->cb_lock);
> > > > +     rc = idr_alloc(&mgr->cb_handles, cb, 1, 0, GFP_ATOMIC);
> > >
> > > It seems the ID will remain dangling if the cb is reused.
> >
> > I'm not sure what you mean by this comment. Reused by whom ? in how
> > fashion it is reused ?
>
> Sorry if I didn't explain it more clearly.
> If the case the cb is reused, you anyway call idr_alloc() and overwrite the
> previous value of cb->id and it never gets idr_remove()'ed
I don't think that is the case.
Please look at hl_cb_destroy(). There, we do the idr_remove and then
we kref_put the CB. In it's release code path, we check if this is a
CB from pool, and if so, we return it to the pool. When it will be
alloc'ed again, it will get a new id.
The problem in this patch is that hl_cb_destroy is not used yet for
CB's from the pool because the command submission code which use that
comes at a later patch, so indeed it might be confusing. But if you
will take a look at the entire code and check when hl_cb_destroy is
called I think you will agree with me.
But if you still think otherwise, please tell me. I might be missing
something here.

Thanks,
Oded

>
> > >
> > > > +     spin_unlock(&mgr->cb_lock);
> > > > +
> > > > +     if (rc < 0) {
> > > > +             dev_err(hdev->dev, "Failed to allocate IDR for a new CB\n");
> > > > +             goto release_cb;
> > > > +     }
> > > > +
> > > > +     cb->id = rc;
> > > > +
> > > > +     kref_init(&cb->refcount);
> > > > +     spin_lock_init(&cb->lock);
> > > > +
> > > > +     /*
> > > > +      * idr is 32-bit so we can safely OR it with a mask that is above
> > > > +      * 32 bit
> > > > +      */
> > > > +     *handle = cb->id | HL_MMAP_CB_MASK;
> > > > +     *handle <<= PAGE_SHIFT;
> > > > +
> > > > +     return 0;
> > > > +
> > > > +release_cb:
> > > > +     cb_do_release(hdev, cb);
> > > > +out_err:
> > > > +     *handle = 0;
> > > > +
> > > > +     return rc;
> > > > +}
> > > > +
>
> --
> Sincerely yours,
> Mike.
>

Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3590C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4874320858
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhK0WVmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4874320858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbeKQKfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:35:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43365 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729736AbeKQKfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:35:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id g26-v6so21782990lja.10;
        Fri, 16 Nov 2018 16:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j2/na/IKKiop1OB0+lJy0hQ7T5Ptny68Tm8A1E8Fsj4=;
        b=UhK0WVmEjfem9kwnHMydkwPA7V3MmWnOQnjWY3ewHKD/h2/rep/WiYAhvn1vMiUl1B
         YiMyrYjBDzdPD6UNPB4kSfOONrMfHlPpNXte7VrJ6okaCMP3LCtWdF19d9Yjrf7i3ekW
         Nrn9J9FYSDSgx2iLFOSH63vtotwYtBHlIrOnFnmggtsELF9IzrhPRxhgVQbNLcHc64sD
         1yzOJd9oSBX/2g4ZQd90pgvNEG5IDxmRidpJ8e4AG7PaxVEnBpTyAXhdKkJzKUHSba56
         IB3zianFLrZOMHTyT/uYuI6O6ru344KlB1HaKChyHaTwttIshKLUd4qLkKb1RpgPmt/Z
         ZCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j2/na/IKKiop1OB0+lJy0hQ7T5Ptny68Tm8A1E8Fsj4=;
        b=JlNv7Aau3xcdhXOet5Ji/RJa5EetK4ePhgzkvy4T/lEcoySPFMKbb5CFRyL7aCo42v
         xGiuS46o7PUGpfn6cJ0G3cs4QTzV284C26t4INVW1hbBih9VR0HmARZg3HZ18JU3u0SH
         fRTc9eD3nmf8cTGeUofcRBgBMr/CO7lSi7nQFcfwEVzb78XpGfpwmHFyOvQ1fRM5Btnf
         odl5Z2RN/mVsNUCkBt9dpVIrIco/Dr/tm/OAb2z3O/epYNHSGRuoLVDeRUAUOFaPFITp
         Ly1l4LOjIClWxU5FrLX9LyySOItAha/I+tgtStdaLmZTK6OctO8zC57z7uJxn4NHjIqt
         ncCw==
X-Gm-Message-State: AA+aEWbbrAcI1k1oBT/9KHgdAfYeUAX1BJpVSql2XVUQLNMDADeubraA
        lLpjY+R1fOS0VyEy6+3Bb45tjvhHtrMPPPG7ew==
X-Google-Smtp-Source: AJdET5cnTO5hBVrVbGuIUD7dxph9WOARk+Nm7snYYthv9tK4BmfLR4jbhEbVTxu4acZyPdYZm6Prx1p8N4LReTbwBy0=
X-Received: by 2002:a2e:9b52:: with SMTP id o18-v6mr388139ljj.108.1542414055845;
 Fri, 16 Nov 2018 16:20:55 -0800 (PST)
MIME-Version: 1.0
References: <20181031221311.2596-1-longli@linuxonhyperv.com> <20181031221311.2596-2-longli@linuxonhyperv.com>
In-Reply-To: <20181031221311.2596-2-longli@linuxonhyperv.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Fri, 16 Nov 2018 16:20:44 -0800
Message-ID: <CAKywueRa8Uw_wSk3DUMk_8b=56OPsDv5uOPwqiYVJU19amL3NQ@mail.gmail.com>
Subject: Re: [Patch v4 2/3] CIFS: Add support for direct I/O write
To:     Long Li <longli@microsoft.com>
Cc:     Steve French <sfrench@samba.org>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=81=D1=80, 31 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 15:26, Long Li <lo=
ngli@linuxonhyperv.com>:
>
> From: Long Li <longli@microsoft.com>
>
> With direct I/O write, user supplied buffers are pinned to the memory and=
 data
> are transferred directly from user buffers to the transport layer.
>
> Change in v3: add support for kernel AIO
>
> Change in v4:
> Refactor common write code to __cifs_writev for direct and non-direct I/O=
.
> Retry on direct I/O failure.
>
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  fs/cifs/cifsfs.h |   1 +
>  fs/cifs/file.c   | 194 +++++++++++++++++++++++++++++++++++++++++++------=
------
>  2 files changed, 154 insertions(+), 41 deletions(-)
>
> diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
> index 7fba9aa..e9c5103 100644
> --- a/fs/cifs/cifsfs.h
> +++ b/fs/cifs/cifsfs.h
> @@ -105,6 +105,7 @@ extern ssize_t cifs_user_readv(struct kiocb *iocb, st=
ruct iov_iter *to);
>  extern ssize_t cifs_direct_readv(struct kiocb *iocb, struct iov_iter *to=
);
>  extern ssize_t cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to=
);
>  extern ssize_t cifs_user_writev(struct kiocb *iocb, struct iov_iter *fro=
m);
> +extern ssize_t cifs_direct_writev(struct kiocb *iocb, struct iov_iter *f=
rom);
>  extern ssize_t cifs_strict_writev(struct kiocb *iocb, struct iov_iter *f=
rom);
>  extern int cifs_lock(struct file *, int, struct file_lock *);
>  extern int cifs_fsync(struct file *, loff_t, loff_t, int);
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index daab878..1a41c04 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -2524,6 +2524,55 @@ wdata_fill_from_iovec(struct cifs_writedata *wdata=
, struct iov_iter *from,
>  }
>
>  static int
> +cifs_resend_wdata(struct cifs_writedata *wdata, struct list_head *wdata_=
list, struct cifs_aio_ctx *ctx)
> +{
> +       int wait_retry =3D 0;
> +       unsigned int wsize, credits;
> +       int rc;
> +       struct TCP_Server_Info *server =3D tlink_tcon(wdata->cfile->tlink=
)->ses->server;
> +
> +       /*
> +        * Try to resend this wdata, waiting for credits up to 3 seconds.
> +        * Note: we are attempting to resend the whole wdata not in segme=
nts
> +        */
> +       do {
> +               rc =3D server->ops->wait_mtu_credits(server, wdata->bytes=
, &wsize, &credits);
> +
> +               if (rc)
> +                       break;
> +
> +               if (wsize < wdata->bytes) {
> +                       add_credits_and_wake_if(server, credits, 0);
> +                       msleep(1000);
> +                       wait_retry++;
> +               }
> +       } while (wsize < wdata->bytes && wait_retry < 3);
> +
> +       if (wsize < wdata->bytes) {
> +               rc =3D -EBUSY;
> +               goto out;
> +       }
> +
> +       rc =3D -EAGAIN;
> +       while (rc =3D=3D -EAGAIN)
> +               if (!wdata->cfile->invalidHandle ||
> +                   !(rc =3D cifs_reopen_file(wdata->cfile, false)))
> +                       rc =3D server->ops->async_writev(wdata,
> +                                       cifs_uncached_writedata_release);
> +
> +       if (!rc) {
> +               list_add_tail(&wdata->list, wdata_list);
> +               return 0;
> +       }
> +
> +       add_credits_and_wake_if(server, wdata->credits, 0);
> +out:
> +       kref_put(&wdata->refcount, cifs_uncached_writedata_release);
> +
> +       return rc;
> +}
> +
> +static int
>  cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
>                      struct cifsFileInfo *open_file,
>                      struct cifs_sb_info *cifs_sb, struct list_head *wdat=
a_list,
> @@ -2537,6 +2586,8 @@ cifs_write_from_iter(loff_t offset, size_t len, str=
uct iov_iter *from,
>         loff_t saved_offset =3D offset;
>         pid_t pid;
>         struct TCP_Server_Info *server;
> +       struct page **pagevec;
> +       size_t start;
>
>         if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
>                 pid =3D open_file->pid;
> @@ -2553,38 +2604,74 @@ cifs_write_from_iter(loff_t offset, size_t len, s=
truct iov_iter *from,
>                 if (rc)
>                         break;
>
> -               nr_pages =3D get_numpages(wsize, len, &cur_len);
> -               wdata =3D cifs_writedata_alloc(nr_pages,
> +               if (ctx->direct_io) {
> +                       cur_len =3D iov_iter_get_pages_alloc(
> +                               from, &pagevec, wsize, &start);
> +                       if (cur_len < 0) {
> +                               cifs_dbg(VFS,
> +                                       "direct_writev couldn't get user =
pages "
> +                                       "(rc=3D%zd) iter type %d iov_offs=
et %zd count"
> +                                       " %zd\n",
> +                                       cur_len, from->type,
> +                                       from->iov_offset, from->count);
> +                               dump_stack();
> +                               break;
> +                       }
> +                       iov_iter_advance(from, cur_len);
> +
> +                       nr_pages =3D (cur_len + start + PAGE_SIZE - 1) / =
PAGE_SIZE;
> +
> +                       wdata =3D cifs_writedata_direct_alloc(pagevec,
>                                              cifs_uncached_writev_complet=
e);
> -               if (!wdata) {
> -                       rc =3D -ENOMEM;
> -                       add_credits_and_wake_if(server, credits, 0);
> -                       break;
> -               }
> +                       if (!wdata) {
> +                               rc =3D -ENOMEM;
> +                               add_credits_and_wake_if(server, credits, =
0);
> +                               break;
> +                       }
>
> -               rc =3D cifs_write_allocate_pages(wdata->pages, nr_pages);
> -               if (rc) {
> -                       kfree(wdata);
> -                       add_credits_and_wake_if(server, credits, 0);
> -                       break;
> -               }
>
> -               num_pages =3D nr_pages;
> -               rc =3D wdata_fill_from_iovec(wdata, from, &cur_len, &num_=
pages);
> -               if (rc) {
> -                       for (i =3D 0; i < nr_pages; i++)
> -                               put_page(wdata->pages[i]);
> -                       kfree(wdata);
> -                       add_credits_and_wake_if(server, credits, 0);
> -                       break;
> -               }
> +                       wdata->page_offset =3D start;
> +                       wdata->tailsz =3D
> +                               nr_pages > 1 ?
> +                                       cur_len - (PAGE_SIZE - start) -
> +                                       (nr_pages - 2) * PAGE_SIZE :
> +                                       cur_len;
> +               } else {
> +                       nr_pages =3D get_numpages(wsize, len, &cur_len);
> +                       wdata =3D cifs_writedata_alloc(nr_pages,
> +                                            cifs_uncached_writev_complet=
e);
> +                       if (!wdata) {
> +                               rc =3D -ENOMEM;
> +                               add_credits_and_wake_if(server, credits, =
0);
> +                               break;
> +                       }
>
> -               /*
> -                * Bring nr_pages down to the number of pages we actually=
 used,
> -                * and free any pages that we didn't use.
> -                */
> -               for ( ; nr_pages > num_pages; nr_pages--)
> -                       put_page(wdata->pages[nr_pages - 1]);
> +                       rc =3D cifs_write_allocate_pages(wdata->pages, nr=
_pages);
> +                       if (rc) {
> +                               kfree(wdata);
> +                               add_credits_and_wake_if(server, credits, =
0);
> +                               break;
> +                       }
> +
> +                       num_pages =3D nr_pages;
> +                       rc =3D wdata_fill_from_iovec(wdata, from, &cur_le=
n, &num_pages);
> +                       if (rc) {
> +                               for (i =3D 0; i < nr_pages; i++)
> +                                       put_page(wdata->pages[i]);
> +                               kfree(wdata);
> +                               add_credits_and_wake_if(server, credits, =
0);
> +                               break;
> +                       }
> +
> +                       /*
> +                        * Bring nr_pages down to the number of pages we =
actually used,
> +                        * and free any pages that we didn't use.
> +                        */
> +                       for ( ; nr_pages > num_pages; nr_pages--)
> +                               put_page(wdata->pages[nr_pages - 1]);
> +
> +                       wdata->tailsz =3D cur_len - ((nr_pages - 1) * PAG=
E_SIZE);
> +               }
>
>                 wdata->sync_mode =3D WB_SYNC_ALL;
>                 wdata->nr_pages =3D nr_pages;
> @@ -2593,7 +2680,6 @@ cifs_write_from_iter(loff_t offset, size_t len, str=
uct iov_iter *from,
>                 wdata->pid =3D pid;
>                 wdata->bytes =3D cur_len;
>                 wdata->pagesz =3D PAGE_SIZE;
> -               wdata->tailsz =3D cur_len - ((nr_pages - 1) * PAGE_SIZE);
>                 wdata->credits =3D credits;
>                 wdata->ctx =3D ctx;
>                 kref_get(&ctx->refcount);
> @@ -2668,13 +2754,17 @@ static void collect_uncached_write_data(struct ci=
fs_aio_ctx *ctx)
>                                 INIT_LIST_HEAD(&tmp_list);
>                                 list_del_init(&wdata->list);
>
> -                               iov_iter_advance(&tmp_from,
> +                               if (ctx->direct_io)
> +                                       rc =3D cifs_resend_wdata(wdata, &=
tmp_list, ctx);
> +                               else {
> +                                       iov_iter_advance(&tmp_from,
>                                                  wdata->offset - ctx->pos=
);
>
> -                               rc =3D cifs_write_from_iter(wdata->offset=
,
> +                                       rc =3D cifs_write_from_iter(wdata=
->offset,
>                                                 wdata->bytes, &tmp_from,
>                                                 ctx->cfile, cifs_sb, &tmp=
_list,
>                                                 ctx);
> +                               }
>
>                                 list_splice(&tmp_list, &ctx->list);
>
> @@ -2687,8 +2777,9 @@ static void collect_uncached_write_data(struct cifs=
_aio_ctx *ctx)
>                 kref_put(&wdata->refcount, cifs_uncached_writedata_releas=
e);
>         }
>
> -       for (i =3D 0; i < ctx->npages; i++)
> -               put_page(ctx->bv[i].bv_page);
> +       if (!ctx->direct_io)
> +               for (i =3D 0; i < ctx->npages; i++)
> +                       put_page(ctx->bv[i].bv_page);
>
>         cifs_stats_bytes_written(tcon, ctx->total_len);
>         set_bit(CIFS_INO_INVALID_MAPPING, &CIFS_I(dentry->d_inode)->flags=
);
> @@ -2703,7 +2794,7 @@ static void collect_uncached_write_data(struct cifs=
_aio_ctx *ctx)
>                 complete(&ctx->done);
>  }
>
> -ssize_t cifs_user_writev(struct kiocb *iocb, struct iov_iter *from)
> +static ssize_t __cifs_writev(struct kiocb *iocb, struct iov_iter *from, =
bool direct)
>  {
>         struct file *file =3D iocb->ki_filp;
>         ssize_t total_written =3D 0;
> @@ -2712,13 +2803,18 @@ ssize_t cifs_user_writev(struct kiocb *iocb, stru=
ct iov_iter *from)
>         struct cifs_sb_info *cifs_sb;
>         struct cifs_aio_ctx *ctx;
>         struct iov_iter saved_from =3D *from;
> +       size_t len =3D iov_iter_count(from);
>         int rc;
>
>         /*
> -        * BB - optimize the way when signing is disabled. We can drop th=
is
> -        * extra memory-to-memory copying and use iovec buffers for const=
ructing
> -        * write request.
> +        * iov_iter_get_pages_alloc doesn't work with ITER_KVEC.
> +        * In this case, fall back to non-direct write function.
> +        * this could be improved by getting pages directly in ITER_KVEC
>          */
> +       if (direct && from->type & ITER_KVEC) {
> +               cifs_dbg(FYI, "use non-direct cifs_writev for kvec I/O\n"=
);
> +               direct =3D false;
> +       }
>
>         rc =3D generic_write_checks(iocb, from);
>         if (rc <=3D 0)
> @@ -2742,10 +2838,16 @@ ssize_t cifs_user_writev(struct kiocb *iocb, stru=
ct iov_iter *from)
>
>         ctx->pos =3D iocb->ki_pos;
>
> -       rc =3D setup_aio_ctx_iter(ctx, from, WRITE);
> -       if (rc) {
> -               kref_put(&ctx->refcount, cifs_aio_ctx_release);
> -               return rc;
> +       if (direct) {
> +               ctx->direct_io =3D true;
> +               ctx->iter =3D *from;
> +               ctx->len =3D len;
> +       } else {
> +               rc =3D setup_aio_ctx_iter(ctx, from, WRITE);
> +               if (rc) {
> +                       kref_put(&ctx->refcount, cifs_aio_ctx_release);
> +                       return rc;
> +               }
>         }
>
>         /* grab a lock here due to read response handlers can access ctx =
*/
> @@ -2795,6 +2897,16 @@ ssize_t cifs_user_writev(struct kiocb *iocb, struc=
t iov_iter *from)
>         return total_written;
>  }
>
> +ssize_t cifs_direct_writev(struct kiocb *iocb, struct iov_iter *from)
> +{
> +       return __cifs_writev(iocb, from, true);
> +}
> +
> +ssize_t cifs_user_writev(struct kiocb *iocb, struct iov_iter *from)
> +{
> +       return __cifs_writev(iocb, from, false);
> +}
> +
>  static ssize_t
>  cifs_writev(struct kiocb *iocb, struct iov_iter *from)
>  {
> --
> 2.7.4
>

Did you measure the performance benefit of using O_DIRECT with your
patches for non-RDMA mode?

--
Best regards,
Pavel Shilovsky

Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1FEC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12122152C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bPxBgW/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12122152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbeHOKrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 06:47:52 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44658 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeHOKrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 06:47:51 -0400
Received: by mail-oi0-f68.google.com with SMTP id s198-v6so612980oih.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 00:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DxONVkg3YjrD9yT+C59Nab9iuAQsC/w+8Sm59R88oYM=;
        b=bPxBgW/tpZbDHuzE5r4dDLNJoqOpqhpACRe3zhGlMSut30nZxJ57HBofqc41NnWbcH
         pKyPyoKntDUZD3ildmvU3e5g9hoNfqf7TYn1F2TYin4j78Bw52G9WJ4uvkyKVqG7+Urc
         gzXPObnVyjdvlVfJl4lmvslkG6BNQAOz89TFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DxONVkg3YjrD9yT+C59Nab9iuAQsC/w+8Sm59R88oYM=;
        b=J18C40LTiLwHIhweS7kxGj+KpcovaNNFJoZYpwHAcK7hy6OJQp38v4H0TvyUH79lJ7
         kVngwvwGelcMrhtwZyph3I/c+2qu1lf9X3mN7OQNJoE4l5aWp2Y3Ajm2m32V5AWt/eAh
         L0lfzFr/Ua94ZWtSkf20gpw4OGqRQ68KBHCxMXDHqoTHpf/4zy0cROYzPlXfrQ3RUBvB
         fElSGqqBZsYZUZ3b85v0er43r7qA6IcA/BU04DYxxOfo+rvgpjyNfH9bSSFD6SbELPAo
         mJTiF0ut6OSsu8ZCaql7rLOYXTs3SZb9qWyR0Iw7jziIqyPSXLOYeb9GtcS3FFNKBLDe
         WU+Q==
X-Gm-Message-State: AOUpUlHQcSI+CzafOUHQDRfuwWNbJzWr2ZJf1D8HctZSELPBSMqeY0PW
        EIT1OevEPhuC2r5K75JG27TNIMhjMxSszP2gN7OjOXSF
X-Google-Smtp-Source: AA+uWPyPebiQQQBF8mBLQObTggoHohNZhXT8pw4xbLTX5BpDoy6ihRuszO3QhzIbLGK0tYlHtLMdS23QlpE0tKntRmM=
X-Received: by 2002:aca:4bc6:: with SMTP id y189-v6mr24969490oia.181.1534319804518;
 Wed, 15 Aug 2018 00:56:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 00:56:43
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <20180814211717.22170-1-const@MakeLinux.com>
References: <20180814211717.22170-1-const@MakeLinux.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 15 Aug 2018 09:56:43 +0200
Message-ID: <CAJfpegsRj8dgaNP1gC6QSy5c-G6JPt8BuTH2Mr=Ssd7OpNRwoQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fuse: add max_pages option
To:     Constantine Shulyupin <const@makelinux.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, corbet@lwn.net,
        =?UTF-8?B?5YiY56GV54S2?= <liushuoran@jd.com>,
        mitsuo.hayasaka.hu@hitachi.com,
        "open list:FUSE: FILESYSTEM IN USERSPACE" 
        <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 11:17 PM, Constantine Shulyupin
<const@makelinux.com> wrote:
> Replace FUSE_MAX_PAGES_PER_REQ with the configurable
> mount parameter max_pages to improve performance.
>
> Old RFC with detailed description of the problem and
> many fixes by Mitsuo Hayasaka (mitsuo.hayasaka.hu@hitachi.com):
>  - https://lkml.org/lkml/2012/7/5/136

It would be nice to have some performance numbers before/after the patch.

>
> Changes in v3:
> - used clamp_val
> - split documentation change
> - split EXPORT_SYMBOL(pipe_max_size)
>
> Changes in v2:
> - add limitation by pipe_max_size, which was requested in
>   https://lkml.org/lkml/2012/7/12/32
>
> Changes in v1: https://lkml.org/lkml/2017/8/6/194
>  - replace FUSE_MAX_PAGES_PER_REQ with
>    FUSE_DEFAULT_MAX_PAGES_PER_REQ and
>    fc->max_pages
>  - add mount option max_pages
>
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
> ---
>  fs/fuse/dev.c    |  4 ++--
>  fs/fuse/file.c   | 54 ++++++++++++++++++++++++------------------------
>  fs/fuse/fuse_i.h |  5 ++++-
>  fs/fuse/inode.c  | 14 +++++++++++++
>  4 files changed, 47 insertions(+), 30 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 11ea2c4a38ab..b324ffc2d82a 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1663,7 +1663,7 @@ static int fuse_retrieve(struct fuse_conn *fc, struct inode *inode,
>         unsigned int num;
>         unsigned int offset;
>         size_t total_len = 0;
> -       int num_pages;
> +       unsigned num_pages;
>
>         offset = outarg->offset & ~PAGE_MASK;
>         file_size = i_size_read(inode);
> @@ -1675,7 +1675,7 @@ static int fuse_retrieve(struct fuse_conn *fc, struct inode *inode,
>                 num = file_size - outarg->offset;
>
>         num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
> -       num_pages = min(num_pages, FUSE_MAX_PAGES_PER_REQ);
> +       num_pages = min(num_pages, fc->max_pages);
>
>         req = fuse_get_req(fc, num_pages);
>         if (IS_ERR(req))
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index fe8d84eb714a..e0924e46ef24 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -847,11 +847,11 @@ static int fuse_readpages_fill(void *_data, struct page *page)
>         fuse_wait_on_page_writeback(inode, page->index);
>
>         if (req->num_pages &&
> -           (req->num_pages == FUSE_MAX_PAGES_PER_REQ ||
> +           (req->num_pages == fc->max_pages ||
>              (req->num_pages + 1) * PAGE_SIZE > fc->max_read ||
>              req->pages[req->num_pages - 1]->index + 1 != page->index)) {
>                 int nr_alloc = min_t(unsigned, data->nr_pages,
> -                                    FUSE_MAX_PAGES_PER_REQ);
> +                                    fc->max_pages);
>                 fuse_send_readpages(req, data->file);
>                 if (fc->async_read)
>                         req = fuse_get_req_for_background(fc, nr_alloc);
> @@ -886,7 +886,7 @@ static int fuse_readpages(struct file *file, struct address_space *mapping,
>         struct fuse_conn *fc = get_fuse_conn(inode);
>         struct fuse_fill_data data;
>         int err;
> -       int nr_alloc = min_t(unsigned, nr_pages, FUSE_MAX_PAGES_PER_REQ);
> +       int nr_alloc = min_t(unsigned, nr_pages, fc->max_pages);
>
>         err = -EIO;
>         if (is_bad_inode(inode))
> @@ -1101,12 +1101,12 @@ static ssize_t fuse_fill_write_pages(struct fuse_req *req,
>         return count > 0 ? count : err;
>  }
>
> -static inline unsigned fuse_wr_pages(loff_t pos, size_t len)
> +static inline unsigned fuse_wr_pages(loff_t pos, size_t len, unsigned max_pages)
>  {
>         return min_t(unsigned,
>                      ((pos + len - 1) >> PAGE_SHIFT) -
>                      (pos >> PAGE_SHIFT) + 1,
> -                    FUSE_MAX_PAGES_PER_REQ);
> +                    max_pages);
>  }
>
>  static ssize_t fuse_perform_write(struct kiocb *iocb,
> @@ -1128,7 +1128,8 @@ static ssize_t fuse_perform_write(struct kiocb *iocb,
>         do {
>                 struct fuse_req *req;
>                 ssize_t count;
> -               unsigned nr_pages = fuse_wr_pages(pos, iov_iter_count(ii));
> +               unsigned nr_pages = fuse_wr_pages(pos, iov_iter_count(ii),
> +                                                 fc->max_pages);
>
>                 req = fuse_get_req(fc, nr_pages);
>                 if (IS_ERR(req)) {
> @@ -1318,11 +1319,6 @@ static int fuse_get_user_pages(struct fuse_req *req, struct iov_iter *ii,
>         return ret < 0 ? ret : 0;
>  }
>
> -static inline int fuse_iter_npages(const struct iov_iter *ii_p)
> -{
> -       return iov_iter_npages(ii_p, FUSE_MAX_PAGES_PER_REQ);
> -}
> -
>  ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>                        loff_t *ppos, int flags)
>  {
> @@ -1342,9 +1338,10 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>         int err = 0;
>
>         if (io->async)
> -               req = fuse_get_req_for_background(fc, fuse_iter_npages(iter));
> +               req = fuse_get_req_for_background(fc, iov_iter_npages(iter,
> +                                                               fc->max_pages));
>         else
> -               req = fuse_get_req(fc, fuse_iter_npages(iter));
> +               req = fuse_get_req(fc, iov_iter_npages(iter, fc->max_pages));
>         if (IS_ERR(req))
>                 return PTR_ERR(req);
>
> @@ -1389,9 +1386,10 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>                         fuse_put_request(fc, req);
>                         if (io->async)
>                                 req = fuse_get_req_for_background(fc,
> -                                       fuse_iter_npages(iter));
> +                                       iov_iter_npages(iter, fc->max_pages));
>                         else
> -                               req = fuse_get_req(fc, fuse_iter_npages(iter));
> +                               req = fuse_get_req(fc, iov_iter_npages(iter,
> +                                                               fc->max_pages));
>                         if (IS_ERR(req))
>                                 break;
>                 }
> @@ -1818,7 +1816,7 @@ static int fuse_writepages_fill(struct page *page,
>         is_writeback = fuse_page_is_writeback(inode, page->index);
>
>         if (req && req->num_pages &&
> -           (is_writeback || req->num_pages == FUSE_MAX_PAGES_PER_REQ ||
> +           (is_writeback || req->num_pages == fc->max_pages ||
>              (req->num_pages + 1) * PAGE_SIZE > fc->max_write ||
>              data->orig_pages[req->num_pages - 1]->index + 1 != page->index)) {
>                 fuse_writepages_send(data);
> @@ -1846,7 +1844,7 @@ static int fuse_writepages_fill(struct page *page,
>                 struct fuse_inode *fi = get_fuse_inode(inode);
>
>                 err = -ENOMEM;
> -               req = fuse_request_alloc_nofs(FUSE_MAX_PAGES_PER_REQ);
> +               req = fuse_request_alloc_nofs(fc->max_pages);
>                 if (!req) {
>                         __free_page(tmp_page);
>                         goto out_unlock;
> @@ -1903,6 +1901,7 @@ static int fuse_writepages(struct address_space *mapping,
>                            struct writeback_control *wbc)
>  {
>         struct inode *inode = mapping->host;
> +       struct fuse_conn *fc = get_fuse_conn(inode);
>         struct fuse_fill_wb_data data;
>         int err;
>
> @@ -1915,7 +1914,7 @@ static int fuse_writepages(struct address_space *mapping,
>         data.ff = NULL;
>
>         err = -ENOMEM;
> -       data.orig_pages = kcalloc(FUSE_MAX_PAGES_PER_REQ,
> +       data.orig_pages = kcalloc(fc->max_pages,
>                                   sizeof(struct page *),
>                                   GFP_NOFS);
>         if (!data.orig_pages)
> @@ -2386,10 +2385,11 @@ static int fuse_copy_ioctl_iovec_old(struct iovec *dst, void *src,
>  }
>
>  /* Make sure iov_length() won't overflow */
> -static int fuse_verify_ioctl_iov(struct iovec *iov, size_t count)
> +static int fuse_verify_ioctl_iov(struct fuse_conn *fc, struct iovec *iov,
> +                                size_t count)
>  {
>         size_t n;
> -       u32 max = FUSE_MAX_PAGES_PER_REQ << PAGE_SHIFT;
> +       u32 max = fc->max_pages << PAGE_SHIFT;
>
>         for (n = 0; n < count; n++, iov++) {
>                 if (iov->iov_len > (size_t) max)
> @@ -2513,7 +2513,7 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
>         BUILD_BUG_ON(sizeof(struct fuse_ioctl_iovec) * FUSE_IOCTL_MAX_IOV > PAGE_SIZE);
>
>         err = -ENOMEM;
> -       pages = kcalloc(FUSE_MAX_PAGES_PER_REQ, sizeof(pages[0]), GFP_KERNEL);
> +       pages = kcalloc(fc->max_pages, sizeof(pages[0]), GFP_KERNEL);
>         iov_page = (struct iovec *) __get_free_page(GFP_KERNEL);
>         if (!pages || !iov_page)
>                 goto out;
> @@ -2552,7 +2552,7 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
>
>         /* make sure there are enough buffer pages and init request with them */
>         err = -ENOMEM;
> -       if (max_pages > FUSE_MAX_PAGES_PER_REQ)
> +       if (max_pages > fc->max_pages)
>                 goto out;
>         while (num_pages < max_pages) {
>                 pages[num_pages] = alloc_page(GFP_KERNEL | __GFP_HIGHMEM);
> @@ -2639,11 +2639,11 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
>                 in_iov = iov_page;
>                 out_iov = in_iov + in_iovs;
>
> -               err = fuse_verify_ioctl_iov(in_iov, in_iovs);
> +               err = fuse_verify_ioctl_iov(fc, in_iov, in_iovs);
>                 if (err)
>                         goto out;
>
> -               err = fuse_verify_ioctl_iov(out_iov, out_iovs);
> +               err = fuse_verify_ioctl_iov(fc, out_iov, out_iovs);
>                 if (err)
>                         goto out;
>
> @@ -2834,9 +2834,9 @@ static void fuse_do_truncate(struct file *file)
>         fuse_do_setattr(file_dentry(file), &attr, file);
>  }
>
> -static inline loff_t fuse_round_up(loff_t off)
> +static inline loff_t fuse_round_up(struct fuse_conn *fc, loff_t off)
>  {
> -       return round_up(off, FUSE_MAX_PAGES_PER_REQ << PAGE_SHIFT);
> +       return round_up(off, fc->max_pages << PAGE_SHIFT);
>  }
>
>  static ssize_t
> @@ -2865,7 +2865,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>         if (async_dio && iov_iter_rw(iter) != WRITE && offset + count > i_size) {
>                 if (offset >= i_size)
>                         return 0;
> -               iov_iter_truncate(iter, fuse_round_up(i_size - offset));
> +               iov_iter_truncate(iter, fuse_round_up(ff->fc, i_size - offset));
>                 count = iov_iter_count(iter);
>         }
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index f78e9614bb5f..7556301cb493 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -29,7 +29,7 @@
>  #include <linux/user_namespace.h>
>
>  /** Max number of pages that can be used in a single read request */
> -#define FUSE_MAX_PAGES_PER_REQ 32
> +#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
>
>  /** Bias for fi->writectr, meaning new writepages must not be sent */
>  #define FUSE_NOWRITE INT_MIN
> @@ -476,6 +476,9 @@ struct fuse_conn {
>         /** Maximum write size */
>         unsigned max_write;
>
> +       /** Maxmum number of pages that can be used in a single request */
> +       unsigned max_pages;
> +
>         /** Input queue */
>         struct fuse_iqueue iq;
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index db9e60b7eb69..aed77c77cccc 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -22,6 +22,7 @@
>  #include <linux/exportfs.h>
>  #include <linux/posix_acl.h>
>  #include <linux/pid_namespace.h>
> +#include <linux/pipe_fs_i.h>
>
>  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
>  MODULE_DESCRIPTION("Filesystem in Userspace");
> @@ -71,6 +72,7 @@ struct fuse_mount_data {
>         unsigned default_permissions:1;
>         unsigned allow_other:1;
>         unsigned max_read;
> +       unsigned max_pages;
>         unsigned blksize;
>  };
>
> @@ -453,6 +455,7 @@ enum {
>         OPT_DEFAULT_PERMISSIONS,
>         OPT_ALLOW_OTHER,
>         OPT_MAX_READ,
> +       OPT_MAX_PAGES,
>         OPT_BLKSIZE,
>         OPT_ERR
>  };
> @@ -465,6 +468,7 @@ static const match_table_t tokens = {
>         {OPT_DEFAULT_PERMISSIONS,       "default_permissions"},
>         {OPT_ALLOW_OTHER,               "allow_other"},
>         {OPT_MAX_READ,                  "max_read=%u"},
> +       {OPT_MAX_PAGES,                 "max_pages=%u"},
>         {OPT_BLKSIZE,                   "blksize=%u"},
>         {OPT_ERR,                       NULL}

Any reason why you used a mount option instead of negotiating with the
INIT message?


>  };
> @@ -546,6 +550,12 @@ static int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
>                         d->max_read = value;
>                         break;
>
> +               case OPT_MAX_PAGES:
> +                       if (match_int(&args[0], &value))
> +                               return 0;
> +                       d->max_pages = value;
> +                       break;
> +
>                 case OPT_BLKSIZE:
>                         if (!is_bdev || match_int(&args[0], &value))
>                                 return 0;
> @@ -577,6 +587,8 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
>                 seq_puts(m, ",allow_other");
>         if (fc->max_read != ~0)
>                 seq_printf(m, ",max_read=%u", fc->max_read);
> +       if (fc->max_pages != FUSE_DEFAULT_MAX_PAGES_PER_REQ)
> +               seq_printf(m, ",max_pages=%u", fc->max_pages);
>         if (sb->s_bdev && sb->s_blocksize != FUSE_DEFAULT_BLKSIZE)
>                 seq_printf(m, ",blksize=%lu", sb->s_blocksize);
>         return 0;
> @@ -1141,6 +1153,8 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
>         fc->user_id = d.user_id;
>         fc->group_id = d.group_id;
>         fc->max_read = max_t(unsigned, 4096, d.max_read);
> +       fc->max_pages = clamp_val(d.max_pages, FUSE_DEFAULT_MAX_PAGES_PER_REQ,
> +                                 pipe_max_size >> PAGE_SHIFT);
>
>         /* Used by get_root_inode() */
>         sb->s_fs_info = fc;
> --
> 2.17.1
>

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3082549-1519269685-2-12922542212745799295
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519269684; b=V6NIv4gSOrzY99kZ6JzpjdjyLVfztJu/i8QPCIySv9FjKsu
    0CYbYgGxQxQyVlY6kgRawa/CIfpMrFxC4CdF8Gn0SoYg0eU9lZyrNiKsGYswildP
    STMqU+6sjtnauPlCHpWp/yUufZGFiAoWXMULL9oxbeWeKEwu6yhBXErqSFpYCIe9
    sqgu8i38mlwRJFiiS9RBs3BWUJOEPlQGMgyoYoOYtlmJ7GQegHbYRSA7SKz7sAG2
    BEEAl3e7fuPEkZGcn79X08mtOhftAixwRODShyFvRmb2lTvS4hMGYzIfxffRwtOH
    l0EbaufwkF47YMI9ECNBeNI5MC5yD9mkAyqq20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519269684; bh=FbuaSJX2bdZ2Sn8AoxjLPkPIZhONOZnsQU3pB5
    PSpuo=; b=EekKtDIAoAxuzeaNDfMYJcq8Iw5vjsv4EeTSN+TNj9ZToyg7yvUQfp
    XhT8wVAdR1g79HbwawbaDp5xVsW7eaMByVFyWWIUOrWmNqVZwjUKh9dBIVvLFaxx
    obaDFTGV+SVvvQNPRTRHCzfAs2fFDqEbG3oDTs3DtWb7mpSe3n5U/m4t+B8JflWt
    LAs6FNTcPI8Trs9apN2NFuNhDXf/bKHGVvRJSlow+5cvzUlLAKhmnQH9DwVD+/Vw
    dipQbU1FGurRhZ+N8zE0Xian3MyiCCkzloC7fbRPif+qbi3EL13mgIfpFU3F7IEz
    OfiuASbxxmZHTXRKXltAPTJV6rYeN/fg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=H98UBLKZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WJzY9ioE;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=H98UBLKZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WJzY9ioE;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbeBVDVX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 22:21:23 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46413 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbeBVDVW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 22:21:22 -0500
X-Google-Smtp-Source: AH8x225LhJ+C4SA92xORUKMdj00v6OZGjYkgb3klDTZ1W98IK/9Oz7T0EpwoIVhPDjSQc/39gB0trgpLybrDwS9G/o0=
MIME-Version: 1.0
In-Reply-To: <20180212230558.5546-1-ross.zwisler@linux.intel.com>
References: <20180212230558.5546-1-ross.zwisler@linux.intel.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 22 Feb 2018 11:21:20 +0800
Message-ID: <CACVXFVOyJqpwfwnmMqBkJd8x3kC=YZ-=Y7m-AmgdnqPBg8_OWw@mail.gmail.com>
Subject: Re: [PATCH] loop: Fix lost writes caused by missing flag
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm@lists.01.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 7:05 AM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
> The following commit:
>
> commit aa4d86163e4e ("block: loop: switch to VFS ITER_BVEC")
>
> replaced __do_lo_send_write(), which used ITER_KVEC iterators, with
> lo_write_bvec() which uses ITER_BVEC iterators.  In this change, though,
> the WRITE flag was lost:
>
> -       iov_iter_kvec(&from, ITER_KVEC | WRITE, &kvec, 1, len);
> +       iov_iter_bvec(&i, ITER_BVEC, bvec, 1, bvec->bv_len);
>
> This flag is necessary for the DAX case because we make decisions based on
> whether or not the iterator is a READ or a WRITE in dax_iomap_actor() and
> in dax_iomap_rw().
>
> We end up going through this path in configurations where we combine a PMEM
> device with 4k sectors, a loopback device and DAX.  The consequence of this
> missed flag is that what we intend as a write actually turns into a read in
> the DAX code, so no data is ever written.
>
> The very simplest test case is to create a loopback device and try and
> write a small string to it, then hexdump a few bytes of the device to see
> if the write took.  Without this patch you read back all zeros, with this
> you read back the string you wrote.
>
> For XFS this causes us to fail or panic during the following xfstests:
>
>         xfs/074 xfs/078 xfs/216 xfs/217 xfs/250
>
> For ext4 we have a similar issue where writes never happen, but we don't
> currently have any xfstests that use loopback and show this issue.
>
> Fix this by restoring the WRITE flag argument to iov_iter_bvec().  This
> causes the xfstests to all pass.
>
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> Fixes: commit aa4d86163e4e ("block: loop: switch to VFS ITER_BVEC")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: stable@vger.kernel.org
> ---
>  drivers/block/loop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index d5fe720cf149..89d2ee00cced 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -266,7 +266,7 @@ static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
>         struct iov_iter i;
>         ssize_t bw;
>
> -       iov_iter_bvec(&i, ITER_BVEC, bvec, 1, bvec->bv_len);
> +       iov_iter_bvec(&i, ITER_BVEC | WRITE, bvec, 1, bvec->bv_len);
>
>         file_start_write(file);
>         bw = vfs_iter_write(file, &i, ppos, 0);
> --
> 2.14.3
>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


-- 
Ming Lei

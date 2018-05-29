Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2302194-1527607773-2-6095335485643752276
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527607772; b=nGAlNd+JBzVtJhAQp4pI3qojP4VAyihdhpBxKLR0aGrqu5Y2ZA
    CTylX7Buu0Np8ZFZxRwDy3ICNhIi1TPpqGJeZkNRFD5XtAQ8/hm752Wu/+0Xfuwu
    uev+3MhlAFW3bw3DxyCnsqhOe5OuJB83jtl8BCWMgsh5ifIfU65eHEMS8MtQKMDf
    5Q5GFYDM3AmO3uVsywpjnUSaMg19CGBEzh8RNCP3DcxbDSCAZCzMBqL8c2rF8E+6
    iWFhjf9Zh9w4BX25jKxhVh9pqKcaZzfjJXE8b8pZdZcFCitV0ffCR8dBghQ3G+BV
    QGft1CrrTSG0odVyIdzUrVXBXPMZ1KdJza7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527607772; bh=rpOCA1yYfdlfAWlvhcjeCjQnvHnjOD+c1dq/7ZKFtt
    k=; b=Y0KvJFSytp0/6AntV1In4x9GtwjuNEiiDYDjwR4ThXiOiqZIkbe8SlxiYF
    s2WaKd7k3ErhkGQANFyjZz4oTVGjophQy92oL1oD71ZJZOKWrI91JyBBsToppjpf
    1wvTRxkxSSLYXneapmurflvzI+ox7bs+3exIklqFIfcVwEN9t2u9U1Ao53qlvydI
    JfJ+Ez+yoNmhTjbbbETfqsveSIWNR1jKFbJD3kFoWP6xuIxf0RgyH6ELxIm+EMxo
    ro0q6NGJabov97kZP96Xb1dvfOJS+xo0o/sVrkFcH3ioyXYxXw60vW0DryUC0BSU
    lFa/+TycZjrge5zCuH2JtyOQn+qw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=Ulip2sRD header.a=rsa-sha256
    header.s=20161025 x-bits=2048;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=JIJ/M3i8;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=Ulip2sRD header.a=rsa-sha256
      header.s=20161025 x-bits=2048;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=JIJ/M3i8;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIpkPwvM46+hs6jSYUZI+NImaASSIeRdq6+VzaZP9OcnDPUJy6D1cS/TQslqOHOL0CrGmmWfBXGNsiFAv7m63Zh/6Y4sV8msg3wuK4wFp5vIkh347Nty
    RLpXDen4aEjD7GcLx8EWO04VaE7MRyoB4o2ejdRo4f2BMupWXjkZybhizi1mhXllFe9UBleIWiR4PVzBbFlakfqvRSfepHA53/ZQS54bLmOi7kQ9w7bsQ9jh
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=r3nPLSDzUwAA:10 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
    a=drOt6m5kAAAA:8 a=r9Xa0CDJo14xciFPFGgA:9 a=QEXdDO2ut3YA:10
    a=RMMjzBEyIzXRtoq5n5K6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935865AbeE2P3M (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 11:29:12 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34177 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935089AbeE2P3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 11:29:01 -0400
X-Google-Smtp-Source: ADUXVKLVud9W2jXYvQLF/uS6jp+ymwFTwyFCUrqGPegQbHkWM/DxDY6w9nahhbUjqEjMl29hf3PPYMUz5PXLLVWklAk=
MIME-Version: 1.0
In-Reply-To: <20180529144143.16378-8-mszeredi@redhat.com>
References: <20180529144143.16378-1-mszeredi@redhat.com> <20180529144143.16378-8-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 29 May 2018 18:29:00 +0300
Message-ID: <CAOQ4uxg6hVd2k5T20N1u72Of9Eb3O_EAasC0MhDoLY3-o2UrGw@mail.gmail.com>
Subject: Re: [PATCH 07/11] ovl: make ovl_create_real() cope with vfs_mkdir() safely
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 5:41 PM, Miklos Szeredi <mszeredi@redhat.com> wrote:
> From: Amir Goldstein <amir73il@gmail.com>
>
> vfs_mkdir() may succeed and leave the dentry passed to it unhashed and
> negative.  ovl_create_real() is the last caller breaking when that
> happens.
>
> [amir: split re-factoring of ovl_create_temp() to prep patch
>        add comment about unhashed dir after mkdir
>        add pr_warn() if mkdir succeeds and lookup fails]
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/overlayfs/dir.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 1b181292a624..b33d37d1a87c 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -114,6 +114,37 @@ int ovl_cleanup_and_whiteout(struct dentry *workdir, struct inode *dir,
>         goto out;
>  }
>
> +static struct dentry *ovl_mkdir_real(struct inode *dir, struct dentry *dentry,
> +                                    umode_t mode)
> +{
> +       int err;
> +
> +       err = ovl_do_mkdir(dir, dentry, mode);
> +       if (err) {
> +               dput(dentry);
> +               return ERR_PTR(err);
> +       }
> +
> +       /*
> +        * vfs_mkdir() may succeed and leave the dentry passed
> +        * to it unhashed and negative. If that happens, try to
> +        * lookup a new hashed and positive dentry.
> +        */
> +       if (unlikely(d_unhashed(dentry))) {
> +               struct dentry *d;
> +
> +               d = lookup_one_len(dentry->d_name.name, dentry->d_parent,
> +                                  dentry->d_name.len);
> +               if (IS_ERR(d)) {
> +                       pr_warn("overlayfs: failed lookup after mkdir (%pd2, err=%i).\n",
> +                               dentry, err);
> +               }
> +               dput(dentry);
> +               dentry = d;
> +       }
> +       return dentry;
> +}
> +
>  struct dentry *ovl_create_real(struct inode *dir, struct dentry *newdentry,
>                                struct ovl_cattr *attr)
>  {
> @@ -135,8 +166,8 @@ struct dentry *ovl_create_real(struct inode *dir, struct dentry *newdentry,
>                         break;
>
>                 case S_IFDIR:
> -                       err = ovl_do_mkdir(dir, newdentry, attr->mode);
> -                       break;
> +                       /* mkdir is special... */
> +                       return ovl_mkdir_real(dir, newdentry, attr->mode);
>

I like your version with the helper.
So do we not care about the WARN_ON below on non-instantiated dentry
for directories? or we don't need it at all?

Thanks,
Amir.

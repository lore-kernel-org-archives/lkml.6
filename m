Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1784DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C530D20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ocoMAvml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C530D20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbeJBQI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:08:26 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51244 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJBQI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:08:26 -0400
Received: by mail-it1-f195.google.com with SMTP id 74-v6so2536923itw.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=srQjUuYzsMnnVywJEx2exoJkqixDaWaUyvtcNJs6JsU=;
        b=ocoMAvml+bBAhvtzvSZyZ31NNOXXuBEdtuq5tE5Jjz+sxLL7CHcJeK3nb8BFxFTLsB
         NTWKyORrHCGCzIbD4aRS+WYCzj4EQOGMEsiu5GDFz2S1o6wkrg1FR0qz8OpkBRLjJeCr
         DfX4MK/DsDaibCjBJLADgXqBK1ArP/zp+NPGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=srQjUuYzsMnnVywJEx2exoJkqixDaWaUyvtcNJs6JsU=;
        b=MnK1ctvs5SD4+Y+VyMSVKuBRyIpqFOhSxfKdU0l6a0u7VutACfhRAuCrTr1/+3QEfc
         q2TbWTMagpGPY5/D3rQ4NqmKZUK4TkmR4clV3iKdZTZd42MlgBHTBZCybm5wI7De3ynK
         +AhhbERB7QFnm1wbS9rnSJCumDryu0zNn8Il1jv9KzIchjpKiP5j/ge92ob8xb2GtUvy
         bocoJzsG0X4bHSIqPx+sNwD9BV7HlkWSrK3f/tGkrUfNUrWj2d4WWxS46Ahsnxjx9r/z
         pNv8seV21BTMjTBaPdpD8VoTs9RnfKgpJkLVldunARZrnBb/yxO/CiyBgQIWSQnFvfPV
         4Yqw==
X-Gm-Message-State: ABuFfohTLYLHU88xvQgdaWh+5bMI19SC7yzXQLkjCmDgjd4FavDLoslF
        aGH5K7GRfxPGB6KHAlypxVM9+88TsWab/RyrP9/7mg==
X-Google-Smtp-Source: ACcGV63R5jJctyPrBX8lF0lWIIOn9tTqjbutt87N/bLYvvy/O+TSFp1rWd5HQ2FGT3Ce0Z6J1w8LtwHfbPWzsgfX1W0=
X-Received: by 2002:a24:9406:: with SMTP id j6-v6mr1236997ite.136.1538472367040;
 Tue, 02 Oct 2018 02:26:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 02:26:06 -0700 (PDT)
X-Originating-IP: [185.79.92.180]
In-Reply-To: <20180928180048.14259-1-amir73il@gmail.com>
References: <20180928180048.14259-1-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 2 Oct 2018 11:26:06 +0200
Message-ID: <CAJfpegvmfuvVh=1TTh9jTGC_AQ6jpyWv8sXrhF6bO_un4ELWYw@mail.gmail.com>
Subject: Re: [PATCH] fs: fix access beyond unterminated strings in prints
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>,
        Jan Harkes <jaharkes@cs.cmu.edu>, Mark Fasheh <mark@fasheh.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 8:00 PM, Amir Goldstein <amir73il@gmail.com> wrote:
> KASAN detected slab-out-of-bounds access in printk from overlayfs,
> because string format used %*s instead of %.*s.
> Found and fixed 4 other places that use %*s incorrectly in filesystems.
>
>> BUG: KASAN: slab-out-of-bounds in string+0x298/0x2d0 lib/vsprintf.c:604
>> Read of size 1 at addr ffff8801c36c66ba by task syz-executor2/27811
>>
>> CPU: 0 PID: 27811 Comm: syz-executor2 Not tainted 4.19.0-rc5+ #36
> ...
>>  printk+0xa7/0xcf kernel/printk/printk.c:1996
>>  ovl_lookup_index.cold.15+0xe8/0x1f8 fs/overlayfs/namei.c:689
>
> Reported-by: syzbot+376cea2b0ef340db3dd4@syzkaller.appspotmail.com
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Jan Harkes <jaharkes@cs.cmu.edu>
> Cc: Mark Fasheh <mark@fasheh.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Miklos,
>
> I chose not to split the patches per fs in the hope that maintainers
> would quickly ack the patch and ask you to carry it for them.

It's not as simple. While each one looks like a typo, not all of them
may be bugs, and quite likely introduced in different versions, etc...

E.g. look at the fuse_do_setxattr() one: it's there since the initial
merge of overlayfs, but back then it wasn't a bug, since it was only
called for setting the OPAQUE attribute and the supplied value was a
string constant, so the printk would work despite the typo.  Then it
grew users where the string was neither null terminated nor printable
(file handle).  A proper fix would be to print a hex dump of the value
instead, or don't print the value at all...

I'll split and fix the overlay ones, but can't vouch for the others.

Thanks,
Miklos

>
> If this doesn't happen, feel free to drop non-acked bits from the patch.
>
> Thanks,
> Amir.
>
>  fs/coda/dir.c            | 2 +-
>  fs/lockd/host.c          | 2 +-
>  fs/ocfs2/super.c         | 2 +-
>  fs/overlayfs/namei.c     | 2 +-
>  fs/overlayfs/overlayfs.h | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/coda/dir.c b/fs/coda/dir.c
> index 00876ddadb43..23ee5de8b4be 100644
> --- a/fs/coda/dir.c
> +++ b/fs/coda/dir.c
> @@ -47,7 +47,7 @@ static struct dentry *coda_lookup(struct inode *dir, struct dentry *entry, unsig
>         int type = 0;
>
>         if (length > CODA_MAXNAMLEN) {
> -               pr_err("name too long: lookup, %s (%*s)\n",
> +               pr_err("name too long: lookup, %s (%.*s)\n",
>                        coda_i2s(dir), (int)length, name);
>                 return ERR_PTR(-ENAMETOOLONG);
>         }
> diff --git a/fs/lockd/host.c b/fs/lockd/host.c
> index d35cd6be0675..93fb7cf0b92b 100644
> --- a/fs/lockd/host.c
> +++ b/fs/lockd/host.c
> @@ -341,7 +341,7 @@ struct nlm_host *nlmsvc_lookup_host(const struct svc_rqst *rqstp,
>         };
>         struct lockd_net *ln = net_generic(net, lockd_net_id);
>
> -       dprintk("lockd: %s(host='%*s', vers=%u, proto=%s)\n", __func__,
> +       dprintk("lockd: %s(host='%.*s', vers=%u, proto=%s)\n", __func__,
>                         (int)hostname_len, hostname, rqstp->rq_vers,
>                         (rqstp->rq_prot == IPPROTO_UDP ? "udp" : "tcp"));
>
> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> index 3415e0b09398..b74435dc85fd 100644
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c
> @@ -259,7 +259,7 @@ static int ocfs2_osb_dump(struct ocfs2_super *osb, char *buf, int len)
>
>         if (cconn) {
>                 out += snprintf(buf + out, len - out,
> -                               "%10s => Stack: %s  Name: %*s  "
> +                               "%10s => Stack: %s  Name: %.*s  "
>                                 "Version: %d.%d\n", "Cluster",
>                                 (*osb->osb_cluster_stack == '\0' ?
>                                  "o2cb" : osb->osb_cluster_stack),
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index f28711846dd6..9c0ca6a7becf 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -686,7 +686,7 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
>                         index = NULL;
>                         goto out;
>                 }
> -               pr_warn_ratelimited("overlayfs: failed inode index lookup (ino=%lu, key=%*s, err=%i);\n"
> +               pr_warn_ratelimited("overlayfs: failed inode index lookup (ino=%lu, key=%.*s, err=%i);\n"
>                                     "overlayfs: mount with '-o index=off' to disable inodes index.\n",
>                                     d_inode(origin)->i_ino, name.len, name.name,
>                                     err);
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index f61839e1054c..c096f12657cd 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -152,7 +152,7 @@ static inline int ovl_do_setxattr(struct dentry *dentry, const char *name,
>                                   const void *value, size_t size, int flags)
>  {
>         int err = vfs_setxattr(dentry, name, value, size, flags);
> -       pr_debug("setxattr(%pd2, \"%s\", \"%*s\", 0x%x) = %i\n",
> +       pr_debug("setxattr(%pd2, \"%s\", \"%.*s\", 0x%x) = %i\n",
>                  dentry, name, (int) size, (char *) value, flags, err);
>         return err;
>  }
> --
> 2.17.1
>

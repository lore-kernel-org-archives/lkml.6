Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B962C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0B720833
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErIh6E4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0B720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeI0OoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:44:13 -0400
Received: from mail-yw1-f49.google.com ([209.85.161.49]:43202 "EHLO
        mail-yw1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeI0OoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:44:12 -0400
Received: by mail-yw1-f49.google.com with SMTP id k66-v6so719652ywa.10;
        Thu, 27 Sep 2018 01:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0di2wCwN9xA1x+FqtSSlVhpzhb6fEeSlsdksxG6vgI=;
        b=ErIh6E4NR+JKxu+G1ksC5QaTHpmeKkFwbHhI2dBVmNtKBRmEeq2zOnK076upMr4pF6
         x7BGojfri5BMuCMwphIem3bhvsEt12amzMp78whjH6HfdhtKUNibr4Nyg5L9ELKLD+zP
         5E0EcKtx4xOipyzBT8Z4W/vhfLCzWVZmrmDcRkHgZyedvQE1Sg/z5Mu7sCzBFIPvdJpG
         SOJp/m5aWqdZHPM8dyCiCyjkfZjgl4ofdMHKkURtJ9nOL2xSTIVDrVTySSbqMiuqnjn+
         qYoVFDv5hIOKk94TIBN9HakmjS0iflcLKe92bq5hl2FsSDBAXzLrvHojA1cQ3g47U2Qx
         WcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0di2wCwN9xA1x+FqtSSlVhpzhb6fEeSlsdksxG6vgI=;
        b=q5bdXx195EAMP9oL2ISlXY/frmrHEaThnv/7wetbWumCqtgFMG+XfR6FpjkI8ihfKI
         KBNZCiBLXSzjmtqZw0LGO7cmsNvOaDcksFhxhj9yJGt0g53SdPLTYpV+SWz467k3KkJ0
         9Q3fM9zYhFPgIan+xlnNQRZh0LhaJwOyZyzufPE6QhdTXMbDe4jWO0Oq51rLS1piZ9Cr
         x/oXIaZ2ub65bYmcArRnmYABGwqfgEbyhEiJeGpu6NdXS85QHCWrrwEajBs7rbLrt8tv
         2/1l4n2DI/dkcdrdw2kjZk4SFjkorTWVNhJ8YcyKNmLRttTjzqmUm/TdLh6+c1xoz+G2
         bSOw==
X-Gm-Message-State: ABuFfoiuI7r0crTkhP9l2nzorzrFVKCJ2pX4hNy3wSrd05E2bxN5yONc
        3fM1vWxmx8uN0ipcQ7ZQhqRWUqz0ARO0+yla8Fk=
X-Google-Smtp-Source: ACcGV63ILynZ0wnKG+SeYMqJ3LqGMPzqfVxhjjVG4hnmSIMS4JiimNm2126fGpH5gxA1SpdQfAbV0nmBoRdhfzO5Bzo=
X-Received: by 2002:a0d:c947:: with SMTP id l68-v6mr5011032ywd.404.1538036828195;
 Thu, 27 Sep 2018 01:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000044cbf80576baaecd@google.com> <CAJfpegsxLtDZqOpK68kGZU+qeEpA5gmAw-uigUKZorexU5i8BA@mail.gmail.com>
 <CAOQ4uxi7LjOVssduYEfbNnYd7ZbwB+hikd+P03_qPFHZeF_Phg@mail.gmail.com> <CAJfpegvEA4L-3SgoyF-Unt4rNZq6rX86Q4AVQBWBiqaWEqDP8g@mail.gmail.com>
In-Reply-To: <CAJfpegvEA4L-3SgoyF-Unt4rNZq6rX86Q4AVQBWBiqaWEqDP8g@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 27 Sep 2018 11:26:56 +0300
Message-ID: <CAOQ4uxjfmE4Bd49kt7+kD7C=8g5ChN80LCOUDf9e3mqG=8Yrag@mail.gmail.com>
Subject: Re: possible deadlock in path_openat
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     syzbot+a55ccfc8a853d3cff213@syzkaller.appspotmail.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 9:36 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, Sep 27, 2018 at 8:05 AM, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > So this is interesting... if there is a file in overlayfs lower layer with
> > the f_op read = seq_read then &p->lock in the chain above could be
> > takes after ovl locks and that is in reveres order to the order of locks
> > in execve on an overlayfs file.
> >
> > On the one hand, it is possible (not sure if desirable) to use filesystems
> > with seq_file like debugfs as overlay lower fs, but on the other hand,
> > it is not possible to copy up a debugfs file with its original content
> > because (at least for most files I looked) the inode size is reported as 0.
> >
> > Also, from v4.19-rc1, with stacked f_op, ovl_read_iter() calls vfs_iter_read(),
> > so overlayfs is no longer tolerant to underlying files that implement f_op read
> > (and not read_iter), thus, it is no longer possible to read lower debugfs files.
> >
> > That said, if there are files in lower layer that user seq_read f_op and have
> > non zero inode size, the deadlock reported above might be possible.
> >
> > Miklos,
> >
> > What do you recon we should do?
> > Blacklist debugfs just like procfs was blacklisted from fs stacking?
> > Improve the heuristics of ovl_dentry_weird() to cover debugfs and friends?
>
> I think that's the best plan.  There doesn't seem to be any sense in
> supporting debugfs and similar weirdness as lower layer, so the best
> course of action would be to deny at the earilest possible point in
> time.
>

OK. I will leave to you to find the Weirdest Common Denominator
of debugfs and friends.
But there could also be a filesystem with sporadic special files
with seq_read (or no read_iter f_op), or maybe our Weird heuristics didn't
catch the filesystem.
We might want to block those files from being copied up on the grounds that
they cannot be read from overlay before copy up anyway.

Thanks,
Amir.

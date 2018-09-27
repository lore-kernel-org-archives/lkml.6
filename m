Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752FFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B732156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EMapyDXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B732156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeI0MxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 08:53:03 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:53950 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeI0MxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 08:53:03 -0400
Received: by mail-it1-f177.google.com with SMTP id q70-v6so6479985itb.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 23:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yDtD6A1Q8KkHpgoeKwaSXpdD7sIReE8qOIjGmkgI4no=;
        b=EMapyDXnbhb2rPwxp8mNzBUWtnuWf/vM/3PhLLqJ2Z5FITJZN41V5rZHLDURaS1vq1
         CK3LLQxF0j+cqH1t9AS5FNKDhBAXLApRT/l2O5gRwuWrazmHgLi6fhMT3rAnVsIYhc8e
         RJ977sqATt3xpsZFhkJwxZ6jd9hPdvZzq9o2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yDtD6A1Q8KkHpgoeKwaSXpdD7sIReE8qOIjGmkgI4no=;
        b=dt7xDV0KvGxcH4f/X5xVlEtlytB8Z2reEy36NJ9VYL+tp+mFa7M1sXxobECmhUSZ1Z
         5AmdChbKqgUlfmCKwsKG/3pIcCCduHNq2mSCc+pGVgmCzsBo2rvLaqwmpc+JBdT4AzJh
         RagCOxlMh3n4feIeB4DPUEfbwU8GcH/uYv66KfJNaynwsrSGPUdU/03k4olopzqzuXJu
         KlGeGo8nJXtHoLCY+8Y+0sS232NtXKMVnWV13npyofXXX0c8nJRVkKQIeUHyViM1vI/0
         IIE0/29ycUov1qx6S7bBwfXoMucyhc6bpKBkVQakvZn/rrtT0s+CntwlazmyhPRy9L4N
         v9CA==
X-Gm-Message-State: ABuFfogLObdCW2D30/dBBhTh87Or1QUqH3kAp6rKyrapb0ZyoU2nhAPI
        PMk0ma9Cw8zA5pm1Q4o3FN3an8NAeZvxXrongxbJTw==
X-Google-Smtp-Source: ACcGV61gE6dmHJH/Ep5fHUpgn4pTSbV6wm0XcyWcmJabm1RHRHrPLYyiN8OlM7I3yMeC2TF7tSSZD7dPMvHGcm1o4fc=
X-Received: by 2002:a24:27d5:: with SMTP id g204-v6mr8391444ita.47.1538030184228;
 Wed, 26 Sep 2018 23:36:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 23:36:23
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <CAOQ4uxi7LjOVssduYEfbNnYd7ZbwB+hikd+P03_qPFHZeF_Phg@mail.gmail.com>
References: <00000000000044cbf80576baaecd@google.com> <CAJfpegsxLtDZqOpK68kGZU+qeEpA5gmAw-uigUKZorexU5i8BA@mail.gmail.com>
 <CAOQ4uxi7LjOVssduYEfbNnYd7ZbwB+hikd+P03_qPFHZeF_Phg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 27 Sep 2018 08:36:23 +0200
Message-ID: <CAJfpegvEA4L-3SgoyF-Unt4rNZq6rX86Q4AVQBWBiqaWEqDP8g@mail.gmail.com>
Subject: Re: possible deadlock in path_openat
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     syzbot <syzbot+a55ccfc8a853d3cff213@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 8:05 AM, Amir Goldstein <amir73il@gmail.com> wrote:

> So this is interesting... if there is a file in overlayfs lower layer with
> the f_op read = seq_read then &p->lock in the chain above could be
> takes after ovl locks and that is in reveres order to the order of locks
> in execve on an overlayfs file.
>
> On the one hand, it is possible (not sure if desirable) to use filesystems
> with seq_file like debugfs as overlay lower fs, but on the other hand,
> it is not possible to copy up a debugfs file with its original content
> because (at least for most files I looked) the inode size is reported as 0.
>
> Also, from v4.19-rc1, with stacked f_op, ovl_read_iter() calls vfs_iter_read(),
> so overlayfs is no longer tolerant to underlying files that implement f_op read
> (and not read_iter), thus, it is no longer possible to read lower debugfs files.
>
> That said, if there are files in lower layer that user seq_read f_op and have
> non zero inode size, the deadlock reported above might be possible.
>
> Miklos,
>
> What do you recon we should do?
> Blacklist debugfs just like procfs was blacklisted from fs stacking?
> Improve the heuristics of ovl_dentry_weird() to cover debugfs and friends?

I think that's the best plan.  There doesn't seem to be any sense in
supporting debugfs and similar weirdness as lower layer, so the best
course of action would be to deny at the earilest possible point in
time.

Thanks,
Miklos

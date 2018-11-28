Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AA7C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AEF2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="K9A1m8BG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49AEF2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeK1VB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:01:28 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51876 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeK1VB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:01:27 -0500
Received: by mail-it1-f195.google.com with SMTP id x19so3428095itl.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 02:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nn31Rtr1vCmaeg2yOoBYMs142T7jvS7kmETnau6u9co=;
        b=K9A1m8BGbpFwgZc+TRxVMrmacwwJWpOv6euT6GlmlxqOQRaM80Wn597qagLxYeH/1h
         pWlso5H3YSqAuYG1lZ5sgoGXwb/Ztg6bw5+PLoY/n7zFYn1cjnRu+yxVPGDvobNhXIbZ
         87LOZShDNXYerDtPiEnOMfJaa2lrlUxR4yWJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nn31Rtr1vCmaeg2yOoBYMs142T7jvS7kmETnau6u9co=;
        b=R3JGtsHEHWCX2XNa3xSuzv1FYkUXqL+m6AhAtdJTh7iGGTgcmRcEB7yOy2cYEM4Cub
         SEF0srcL4nO0GASnDuvx/phHrH8gWlSPQX909BlqOa3as9AHB5rzuUx9R51NI5atkGFg
         ayeKONCK53obdF+R9ATLKdtyzW6A5se3Wmp/intcpeR8FTNRoG9mQU/S4W+k0JDdhyFk
         VnX3LcvTJMN6FOyKAaZKVV/DajdVu8OJZ1tjvxdXhTl3AZlX31lYyLEjWJ6MEy8lM1lK
         VCLwYQHvmTfN+5ozfUfVvX0TS7G4AdKtugqEtUHKvdOvnn/e/m3MLoZShi1HK0hrLSLp
         BkLg==
X-Gm-Message-State: AA+aEWYuvoq3eEoQJc2tLIhpGo424FBupF5CpfLnguHKpjIlJ4PJRWV0
        3lDSrKD2v4l3vRNd9YUOaYuCKx3j5aorrGUromO9JA==
X-Google-Smtp-Source: AFSGD/UdYgo9CXb7jMDeWDKUDa8yZvzBf/jaRbmE/PwegZrAQo3TAmvD+zfkJwnfq3tuyqWKZHRCgkroJYU3CG7Hk0g=
X-Received: by 2002:a24:710:: with SMTP id f16mr2019643itf.121.1543399221572;
 Wed, 28 Nov 2018 02:00:21 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegs9JjkXguemL4qSiBvRP6Dnut-D+nJo-oLFXkfCL1Egvw@mail.gmail.com>
 <CAJfpegvfqx+0D32n1h2X7oj5d1mZWiLTcSSGpBnD+ba7AKzPyA@mail.gmail.com> <20181127210542.GA2599@redhat.com>
In-Reply-To: <20181127210542.GA2599@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 28 Nov 2018 11:00:09 +0100
Message-ID: <CAJfpegtQGM2z9TOt3DWwd39fC60cQknsC4vNnj7YimVEubRzUg@mail.gmail.com>
Subject: Re: overlayfs access checks on underlying layers
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 10:05 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Nov 27, 2018 at 08:58:06PM +0100, Miklos Szeredi wrote:
> > [resending with fixed email address for Paul Moore]
> >
> > Moving discussion from github[1] to here.
> >
> > To summarize: commit 007ea44892e6 ("ovl: relax permission checking on
> > underlying layers") was added in 4.20-rc1 to make overlayfs access
> > checks on underlying "real" filesystems more consistent.  The
> > discussion leading up to this commit can be found at [2].  The commit
> > broke some selinux-testsuite cases, possibly indicating a security
> > hole opened by this commit.
> >
> > The model this patch tries to follow is that if "cp --preserve=all"
> > was allowed to the mounter from underlying layer to the overlay layer,
> > then operation is allowed.  That means even if mounter's creds doesn't
> > provide permission to for example execute underying file X, if
> > mounter's creds provide sufficient permission to perform "cp
> > --preserve=all X Y"  and original creds allow execute on Y, then the
> > operation is allowed.  This provides consistency in the face of
> > copy-ups.  Consistency is only provided in sane setups, where mounter
> > has sufficient privileges to access both the lower and upper layers.
>
> [cc daniel walsh]
>
> I think current selinux testsuite tests are written keeping these
> rules in mind.
>
> 1. Check overlay inode creds in the context of task and underlying
>    inode creds (lower/upper), in the context of mounter.
>
> 2. For a lower inode, if said file is being copied up, then only
>    check MAY_READ on lower. This is equivalent to mounter creating
>    a copy of file and providing caller access to it (context mount).
>
> For the case of special devices, we do not copy up these. So should
> we continue to do check on lower inode in the context of mounter
> (instead of not doing any check on lower at all).

Hmm, I'm trying to understand the logic... If we follow the "cp
--preserve=all" thing, than mounter needs to have CREATE permission
for the special file, not READ or WRITE.  Does that make sense?  Would
that help with the context= mount use case?

>
> For being able to execute a file, should we atleast check MAY_READ
> on lower.

Yep, that looks like a bug present from day one: MAY_EXEC doesn't
always imply MAY_READ, but to be able to execute a file, the kernel
must read it first, and if mounter doesn't have privilege to read the
file, then user should not be allowed to execute it.

> I am not sure why did we have to drop current checks on special file
> and execute. I will read through the thread you pointed out.

TL;DR: NFS access model is that creds are checked by server (and
cached in client), and server could be denying write access to a
device file to mounter (root) independently of DAC. In that case write
access by user to device file would be inconsistent (denied before
copy-up, allowed after copy-up).  Same goes for execute.

And same goes for MAC:  if it's denying READ/WRITE on device or
denying EXECUTE on readable file to mounter, and mounter can just copy
that device/file to a temporry location not controlled by that MAC,
than it can work around that restriction.  IOW, this is just a
generalization of the rule that we ignore WRITE access on lower layer,
because a write will never reach the lower layer.

Thanks,
Miklos

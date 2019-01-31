Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B354AC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A8A20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="pbs0nwWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfAaCU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 21:20:56 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44718 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaCU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 21:20:56 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so1259973lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 18:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uh74GacBX+DFBcLdPevPo476fnugJ6CFBseLirFZjsU=;
        b=pbs0nwWZNvqqXwvsoeG3K8xT0oDD3xAUd5ChGiWqHuUHR6uXwhWqRNojMnVrcYRonV
         s4U1onizGhCWRYQPV6I6e1G5Ef92kxwqnF6+fUdq2ugTTdmSzpuvWmrYEhGYOyF4Jgqi
         mYGsoWHCo4jGCODSzwHEXKmDEBkTweoArlBce837nEhm40zVt0aQb4cCLbLr6RKrb9Iw
         oOOpz/HchwCOU3vPkXQ9NfmEb+dVQIXaJWAF/PcukSe+NL5O2xLeJfmETHDi3SCIKV0N
         B5XfqsQYGOaFEQBUrr/bv6LlYQPAuaBAFdYmWi86SG6KdK7wOmiOMmGPNUQjwf9PXjUv
         TrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uh74GacBX+DFBcLdPevPo476fnugJ6CFBseLirFZjsU=;
        b=hhY9D4A5MByd+hJJjlfigqEAEw+7YxDi8AYixOv/OBKkO65f28aL+zVDK4SutwklEK
         ZBxkUYRI3hZP8WVqi6VtFFXCtUQW8aoHY6XbLGUQqHHT4ga7R//lPOMdAeFeL+AiyZFw
         zFl+HCl7X3yE+N+nPp8fgdd1Ss50o8y6o1c3Jh8Dezpv+/tH0E7kTHau2SR0Dgq/ikB2
         fF9QYdamuLQCuhJyLwaL17wsVBcvXaCDGzrBpBrOYe9Mi45gXYpTodrUhkhFK3QgWZPF
         B5NTva7S5PqGh+O1mJEoiKNEG54NqtEcwaAirq8eOrKr4jEJdbJqxCs3xZEVKbQbiIh1
         HFbQ==
X-Gm-Message-State: AJcUukeywdlFBAK9+eSW/XElGw06da/puk17IttK4bZ4VtUn35MpK6s3
        m+yT+lzlslwWl7cOMIuCuz6gjxKpfupNH6AvOhif
X-Google-Smtp-Source: ALg8bN539yNCzpfobtIE+JjCNNP5A84m1KWfQn3X/b6cSnuobZ4wnYh4e6z+5dVaQ0RYK4k6bxzzoxDcEADUSTNmUg8=
X-Received: by 2002:a2e:4299:: with SMTP id h25-v6mr26746677ljf.5.1548901253946;
 Wed, 30 Jan 2019 18:20:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548196083.git.rgb@redhat.com> <397a8b086e6aa9eb797f1538901e95462822ecb0.1548196083.git.rgb@redhat.com>
 <CAHC9VhQ14FtJAMxjmrGNu2-AkJe6ELjHnaEHjULLHjwo2FDhkQ@mail.gmail.com>
 <20190125222717.x7lyzjn2qfzdzp4k@madcap2.tricolour.ca> <CAHC9VhSGmTKOAXA74_zcBWn=wL1LAxnx91Wv7v9d49Y-QskWBg@mail.gmail.com>
In-Reply-To: <CAHC9VhSGmTKOAXA74_zcBWn=wL1LAxnx91Wv7v9d49Y-QskWBg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 30 Jan 2019 21:20:42 -0500
Message-ID: <CAHC9VhS1JLd-vuhh8jba4wgiH2GZUiF4ayLqh=61w1Z1aYvMqA@mail.gmail.com>
Subject: Re: [PATCH ghak100 V2 2/2] audit: ignore fcaps on umount
To:     Richard Guy Briggs <rgb@redhat.com>, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 6:25 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Jan 25, 2019 at 5:27 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2019-01-25 16:45, Paul Moore wrote:
> > > On Wed, Jan 23, 2019 at 1:35 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > Don't fetch fcaps when umount2 is called to avoid a process hang while
> > > > it waits for the missing resource to (possibly never) re-appear.
> > > >
> > > > Note the comment above user_path_mountpoint_at():
> > > >  * A umount is a special case for path walking. We're not actually interested
> > > >  * in the inode in this situation, and ESTALE errors can be a problem.  We
> > > >  * simply want track down the dentry and vfsmount attached at the mountpoint
> > > >  * and avoid revalidating the last component.
> > > >
> > > > This can happen on ceph, cifs, 9p, lustre, fuse (gluster) or NFS.
> > > >
> > > > Please see the github issue tracker
> > > > https://github.com/linux-audit/audit-kernel/issues/100
> > > >
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > ---
> > > >  fs/namei.c            |  2 +-
> > > >  fs/namespace.c        |  2 ++
> > > >  include/linux/audit.h | 15 ++++++++++-----
> > > >  include/linux/namei.h |  3 +++
> > > >  kernel/audit.c        | 10 +++++++++-
> > > >  kernel/audit.h        |  2 +-
> > > >  kernel/auditsc.c      |  6 +++---
> > > >  7 files changed, 29 insertions(+), 11 deletions(-)

...

> You posted this patch on the 23rd (last Wednesday), let's give the FS
> folks another day or two to comment since it does touch their code.
> If we don't see any objections by later this week I'll merge it into
> audit/next.

I'm not seeing any objections from the fs folks, so I'm merging this
into audit/next.

-- 
paul moore
www.paul-moore.com

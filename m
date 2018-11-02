Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E3CC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF702082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF702082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeKBWy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:54:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45653 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:54:26 -0400
Received: from mail-yb1-f197.google.com ([209.85.219.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1gIZn6-0002HE-2r
        for linux-kernel@vger.kernel.org; Fri, 02 Nov 2018 13:47:12 +0000
Received: by mail-yb1-f197.google.com with SMTP id e73-v6so1368637ybb.16
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 06:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wHjuCDqeObBE15CayekquH8wJz/oreOBeDvsYn7ZLG0=;
        b=Lc/xSyIupxawOm6TK8er1XwRFT1D9Zd+wXbAx3w91ryvbIw+HF++PP0IWgYsny1vQn
         W5JPtkEKqj9D/4IP5yR1rvkCBAYiipcgu4zw+IuyLQuqCUiezsuO5ExzXDrQ9Y2Yl1iR
         /3bzEYSiF7rlFz1sn8KCXIx5R6xw7sblD5EGZ67ngsVKNlJxQDs2czLesDn6Uw1xzJjZ
         1HGWj6ZMHUw85A04VlM7bmV1NTj5X7f/1a7I0PFXj1osJT9phf5qaL7xuT9bt/NyYaiE
         3A7SCrZCF4j5Ljpu15uKAbZbFCHqswLgrDlDXXZF8egqtiG+q40q8tGVqMPLZmw8Ar0x
         jDnw==
X-Gm-Message-State: AGRZ1gIh0HEKl9dQv1KC+hrq5i1+q9oIqgz3yz/InaiD3klhqbSdQqVO
        j25tq627E33j1z8UhIXdfgLz4crkRjHK0vwXOFwsdezbKJ4vtLNJOx5FWt4Vge4c9WVHLzQysOc
        OMD6JmRNq8WdqgynLR7xFYTy3L5Mhj7hK9/nSrt3OAg==
X-Received: by 2002:a25:c4c5:: with SMTP id u188-v6mr11554341ybf.424.1541166430922;
        Fri, 02 Nov 2018 06:47:10 -0700 (PDT)
X-Google-Smtp-Source: AJdET5cNoYcoWZXt+ahyNISeYSykAPAVwGJTcdr0PX+EBijK6H9ltmyraZQqd5kq7zFqkKxNvlEh6g==
X-Received: by 2002:a25:c4c5:: with SMTP id u188-v6mr11554293ybf.424.1541166430180;
        Fri, 02 Nov 2018 06:47:10 -0700 (PDT)
Received: from localhost ([2605:a601:ac7:2a20:7c8b:4047:a2ef:69cd])
        by smtp.gmail.com with ESMTPSA id e129-v6sm949019ywf.77.2018.11.02.06.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 06:47:08 -0700 (PDT)
Date:   Fri, 2 Nov 2018 08:47:07 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: [RFC PATCH 6/6] shiftfs: support nested shiftfs mounts
Message-ID: <20181102134707.GI29262@ubuntu-xps13>
References: <20181101214856.4563-1-seth.forshee@canonical.com>
 <20181101214856.4563-7-seth.forshee@canonical.com>
 <CAOQ4uxhkH+0tchHkrgvBZGYzeLD2fGGgtkKstt3JmhPDaGW_dg@mail.gmail.com>
 <20181102124400.GB29262@ubuntu-xps13>
 <CAOQ4uxhbgzYzdRBwbDNBKgjjmM3M=hya5-LJhiKmxxZxOo=2CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhbgzYzdRBwbDNBKgjjmM3M=hya5-LJhiKmxxZxOo=2CQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 03:16:05PM +0200, Amir Goldstein wrote:
> On Fri, Nov 2, 2018 at 2:44 PM Seth Forshee <seth.forshee@canonical.com> wrote:
> >
> > On Fri, Nov 02, 2018 at 12:02:45PM +0200, Amir Goldstein wrote:
> > > On Thu, Nov 1, 2018 at 11:49 PM Seth Forshee <seth.forshee@canonical.com> wrote:
> > > >
> > > > shiftfs mounts cannot be nested for two reasons -- global
> > > > CAP_SYS_ADMIN is required to set up a mark mount, and a single
> > > > functional shiftfs mount meets the filesystem stacking depth
> > > > limit.
> > > >
> > > > The CAP_SYS_ADMIN requirement can be relaxed. All of the kernel
> > > > ids in a mount must be within that mount's s_user_ns, so all that
> > > > is needed is CAP_SYS_ADMIN within that s_user_ns.
> > > >
> > > > The stack depth issue can be worked around with a couple of
> > > > adjustments. First, a mark mount doesn't really need to count
> > > > against the stacking depth as it doesn't contribute to the call
> > > > stack depth during filesystem operations. Therefore the mount
> > > > over the mark mount only needs to count as one more than the
> > > > lower filesystems stack depth.
> > >
> > > That's true, but it also highlights the point that the "mark" sb is
> > > completely unneeded and it really is just a nice little hack.
> > > All the information it really stores is a lower mount reference,
> > > a lower root dentry and a declarative statement "I am shiftable!".
> >
> > Seems I should have saved some of the things I said in my previous
> > response for this one. As you no doubt gleaned from that email, I agree
> > with this.
> >
> > > Come to think about it, "container shiftable" really isn't that different from
> > > NFS export with "no_root_squash" and auto mounted USB drive.
> > > I mean the shifting itself is different of course, but the
> > > declaration, not so much.
> > > If I am allowing sudoers on another machine to mess with root owned
> > > files visible
> > > on my machine, I am pretty much have the same issues as container admins
> > > accessing root owned files on my init_user_ns filesystem. In all those cases,
> > > I'd better not be executing suid binaries from the untrusted "external" source.
> > >
> > > Instead of mounting a dummy filesystem to make the declaration, you could
> > > get the same thing with:
> > >    mount(path, path, "none", MS_BIND | MS_EXTERN | MS_NOEXEC)
> > > and all you need to do is add MS_EXTERN (MS_SHIFTABLE MS_UNTRUSTED
> > > or whatnot)  constant to uapi and manage to come up good man page description.
> > >
> > > Then users could actually mount a filesystem in init_user_ns MS_EXTERN and
> > > avoid the extra bind mount step (for a full filesystem tree export).
> > > Declaring a mounted image MS_EXTERN has merits on its own even without
> > > containers and shitfs, for example with pluggable storage. Other LSMs could make
> > > good use of that declaration.
> >
> > I'm missing how we figure out the target user ns in this scheme. We need
> > a context with privileges towards the source path's s_user_ns to say
> > it's okay to shift ids for the files under the source path, and then we
> > need a target user ns for the id shifts. Currently the target is
> > current_user_ns when the final shiftfs mount is created.
> >
> > So, how do we determine the target s_user_ns in your scheme?
> >
> 
> Unless I am completely misunderstanding shiftfs, I think we are saying the
> same thing. You said you wish to get rid of the "mark" fs and that you had
> a POC of implementing the "mark" using xattr.

The PoC was using filesystem contexts and (an earlier version of) the
new mount API, but yes I do think we're in agreement about the mark fs
being awkward.

> I'm just saying another option to implement the mark is using a super block
> flag and you get the target s_user_ns from mnt_sb.
> I did miss the fact that a mount flag is not enough, so that makes the bind
> mount concept fail. Unless, maybe, the mount in the container is a slave
> mount and the "shiftable" mark is set on the master.
> I know too little about mount ns vs. user ns to tell if any of this makes sense.

We need a source and target user ns for the shifting, currently they are
the lower filesystem's s_user_ns and the s_user_ns of the shiftfs fs
(which is current_user_ns at the time the real shiftfs fs is mounted). I
think doing it this way makes sense.

The problem with the slave mount idea is that s_user_ns for the shiftfs
sb is still not the target ns for the id shifting, which is going to
cause all kinds of problems. Unless all of this is done in the vfs, then
it could really be a bind mount. The shifting could be done based on the
mount namespace's user_ns and all permission checks in the vfs could
take this into account. This approach certainly has benefits and is one
of the things I want to discuss.

> Feel free to ignore MS_EXTERN idea.
> 
> Hopefully, mount API v2 will provide the proper facility to implement mark.

The approach I took was to have the source user_ns context set up an fd
that was passed to the target user_ns context. Then that fd was used to
attach the mount to the mount tree, and when that happened the target
s_user_ns was set. It worked, but there were some awkware bits. I
haven't kept up with the changes since then to know if things are any
better or worse with the current patches.

Thanks,
Seth

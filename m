Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B8BC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15842081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15842081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeKBVdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:33:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44149 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKBVdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:33:19 -0400
Received: from mail-yb1-f198.google.com ([209.85.219.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1gIYWn-0006Gy-0F
        for linux-kernel@vger.kernel.org; Fri, 02 Nov 2018 12:26:17 +0000
Received: by mail-yb1-f198.google.com with SMTP id u14-v6so1270580ybi.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 05:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fJMmKp72n9oEkwLssaKQwpZo4PDt7Y4IFB8sokgwAJ0=;
        b=MLWO3sTLNNnFdJld07/5hAZ5n/APGkDvV9jVWQj24FY3Vs2uBKWgaYDudYW4Br1wH4
         IFe3ejJZVTS4HwpdKCIexkXxzlLwLDqViP7q/UWIzT8tCQmKfzKRoTD83iGlMhSvbWM0
         pUrMpRM7WNfFGVlJ6y/7sQRFPs3jk5GMvul16Y9KqzaMqHwOhopxit1iT/ekhRxMFnFm
         dFMVUZLq3GAJqvo+4hv+XHkMDo6XiK6teN+Cja5qqyAPN/wZo+MlejscH21E7tL8MSgT
         4+czZezQUY3Pt+Lqxzgu1nsMDb5+J+zphZsUw19p0+bW12ZMYJ5NkvCMdu61St+L3Pr6
         l5UQ==
X-Gm-Message-State: AGRZ1gIc3HO4Hdx5iMCp9D9zr4spn7anX+kg+Od2/RT2Jbj+QiYGDXko
        PbzeDiBl1Vfd22xHM3Ol+egpFTlhQ+UdYvviuZiSJTmWNiHbAuJvrEE86Rc/+15cuaq1PWv2nPf
        ThMt/LCH0WGyIqp8szSQ/1nhWExLDzCi6813w6M90Dg==
X-Received: by 2002:a25:74cf:: with SMTP id p198-v6mr11063392ybc.309.1541161575338;
        Fri, 02 Nov 2018 05:26:15 -0700 (PDT)
X-Google-Smtp-Source: AJdET5feRIomr+enihfiem8ea8rFRJA5nG+7Jmk5S+62bLuCNgROe90F0ostZYY3peEVI375+oeMWw==
X-Received: by 2002:a25:74cf:: with SMTP id p198-v6mr11063362ybc.309.1541161574782;
        Fri, 02 Nov 2018 05:26:14 -0700 (PDT)
Received: from localhost ([2605:a601:ac7:2a20:7c8b:4047:a2ef:69cd])
        by smtp.gmail.com with ESMTPSA id 84-v6sm8026465ywp.69.2018.11.02.05.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 05:26:14 -0700 (PDT)
Date:   Fri, 2 Nov 2018 07:26:12 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC PATCH 0/6] shiftfs fixes and enhancements
Message-ID: <20181102122612.GA29262@ubuntu-xps13>
References: <20181101214856.4563-1-seth.forshee@canonical.com>
 <CAOQ4uxipSP_eKF-SZQ7ss1_yjnuTMyGniOZcgp7NXKBYB0E=8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxipSP_eKF-SZQ7ss1_yjnuTMyGniOZcgp7NXKBYB0E=8g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 10:59:38AM +0200, Amir Goldstein wrote:
> [cc: linux-unionfs
> It should the mailing list for *all* "stacking fs".
> We have a lot of common problems I think ;-) ]
> 
> On Thu, Nov 1, 2018 at 11:49 PM Seth Forshee <seth.forshee@canonical.com> wrote:
> >
> > I've done some work to fix and enhance shiftfs for a number of use
> > cases, so that we would have an idea what a more full-featured shiftfs
> > would look like. I'm intending for these to serve as a point of
> > reference for discussing id shifting mounts/filesystems at plumbers in a
> > couple of weeks [1].
> >
> > Note that these are based on 4.18, and I've added a small fix to James'
> > most recent patch to fix a build issue there. To work with 4.19 they
> > will need a number of updates due to changes in the vfs.
> >
> 
> Seth,
> 
> I like the way you addressed my concerns about nesting and stacking depth.
> Will provide specific nits on patch.
> 
> In preparation to the Plumbers talk (which I will not be attending), I wanted to
> get your opinion on the matters I brought up last time:
> https://marc.info/?l=linux-fsdevel&m=153013920904844&w=2

I want the session at plumbers to not be a "talk" but more of a
discussion of the sorts of things you raise below. But I'm also happy to
talk about them here.

> 1) Having seen what it takes to catch up with overlayfs w.r.t inotify bugs
> and having peeked into 4.19 to see what work you still have lined up for you
> to bring shitfs up to speed with vfs, did you have time to look into my proposal
> for sharing code with overlayfs in the manner that I have implemented the
> snapshotfs POC?
> https://github.com/amir73il/linux/commit/25416757f2ca47759f59b115e6461b11898c4f06
> 
> Even if you end up not saving a single line of code for shiftfs v1
> meaning that all shiftfs_inode_ops are completely separate implementation
> from overlayfs inode ops, this may still be beneficial to shitfs in
> the long run.
> For example, you may, in fact, won't need to change anything to work with v4.19.
> shittfs (as an overlayfs alias) would use ovl_file_operations and
> shiftfs_inode_ops.

I don't recall seeing the shapshotfs patches before. If id shifting
remains an overlay-style fs and not a feature of the vfs, then I
absolutely think something like this will make life much easier.

> Another example, from the top of my head, see what it took to add NFS export
> support to snapshotfs, because of the code reuse with overlayfs:
> https://github.com/amir73il/linux/commit/d082eb615133490ec26fa2efaa80ed4723860893
> Its practically the exact same implementation shiftfs would need,
> so in the far future, shitfs and snapshotfs can share the same
> export_operations.
> 
> 2) Regarding this part:
> +               /*
> +                * this part is visible unshifted, so make sure no
> +                * executables that could be used to give suid
> +                * privileges
> +                */
> +               sb->s_iflags = SB_I_NOEXEC;
> 
> Why would you want to make the unshifted fs visible at all?
> Is there a requirement for container users to access the unshifted fs
> content? Is there a requirement for container admin to mount shitfted fs
> NOT from the root of the marked mount?
> 
> If those are not required, then I propose NOOP inode operations for
> the unshifted fs, specifically, empty readdir, just enough ops to be able
> to use the mark mount point as the shitfed mount source - no more.

This is part of the original implementation that I didn't touch with
these updates. Imo the mark mount is kind of kludgy, and I'd like to see
it done a different way.

A couple of alternatives have been suggested. One was to use xattrs for
marking, or I did a PoC with an older version of the new mount API
patches where an fsfd was passed to the less privileged context that it
could attach to its mount tree:

https://lkml.kernel.org/r/20180717133847.GB15620@ubuntu-xps13

Either of these can accomplish the same things as the mark mount with
better control over who can create an id-shifted mount of the subtree.

However if the mark mount is kept then no-op inode operations seems
reasonable to me.

Thanks,
Seth

Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E250BC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708202077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Edp2Yx32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708202077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeIEFtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 01:49:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46378 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeIEFtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 01:49:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so4731644ljj.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 18:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0w0PjKyGuT0pxnDu9U9lAoyBrmVujLcu5sAacOGphIY=;
        b=Edp2Yx32i8Dj0Uw0fhmjvqTlY3OnfFWpZaLOzlx3VDlkOjLNsNpvx1QE9MjF0UIavn
         atcEJhTNeusX3IOoFv5IFKxaTCTvhxHO3Mklf9cBlMcLW5awjMfru2i7slcwt3iG7Bww
         HlL0rPv1lBqWWppzl9fUlQAuWjjEbvNHvSJGOIi9qyJ4Q/Gi22UomX5CkFODDQ89liQM
         6Q5BHR69HPClJXiSsaTupBbfcRt+xGsSHSkTHUNg5AmPs3nOQZ+GMWNb3i8gAkGRIh52
         N+rsMT14nwc44CVQsYGkn4XpN48C2sYq06ptwkAI8b96QXmDUMNwp8CTSvqIqcEtzirM
         e0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0w0PjKyGuT0pxnDu9U9lAoyBrmVujLcu5sAacOGphIY=;
        b=pnn9h0LZ/U5qQKj7kLZPKwoR/9YHIXLKVUwTeVk+1hmByHXkxpnra61utddFghHelh
         HQI2b0DpWJjLrvKZ+0H8LLnKnKrbrkOaZ9UEDvgkDYwqrbpGi4/QwiXU33a2aczov7tl
         RyAuswCTLTLs1wQtvTvtRT/dalRUjgAnVxMBv2jOWXB6tIg3ne96c+FvPutieyjyur1r
         r2wmHkRWJQFn6NdKE4A2cPDaV0lxCBQG+VKBi8aN/KdrfTjv7uder+UZAX4FfgiHnD0k
         a3pbRF2h3tOzxKRQoFsjKpb+bonQEou9pr850eXmEE70G3nud6Cb0+En/teDYUC9BQ7v
         Q7fw==
X-Gm-Message-State: APzg51CLixRRqlyXTX0/nhK7yL4j1R09MkskFSpKAXLCqVkQhwFLnE1h
        SfICOhVRkVVby3QbSObuEF1A2UXJJoorhXnZCmL6
X-Google-Smtp-Source: ANB0VdbrJelyLeelrzXz5cXc6sdhRXhwpCp2amjuWHqaIBKY8qWIzOqcsAGj3D7QRv5iPh76vzca/rjsHVwPCrp66Lo=
X-Received: by 2002:a2e:7c12:: with SMTP id x18-v6mr9315565ljc.71.1536110480066;
 Tue, 04 Sep 2018 18:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c178e305749daba4@google.com> <CACT4Y+Z9wmuq=Pb-gxAJauQNi0uZGDUimWEL66UzWGSp_x2uQA@mail.gmail.com>
 <37aec45f-69ad-9705-21f1-64ee4ce4a772@tycho.nsa.gov> <CAHC9VhSeP=b1xxpCT8R-CYLEP3507ezwDwkq2Bsyekfa4otLGw@mail.gmail.com>
 <9537a6ff-daf4-d572-bf93-68230909b68e@tycho.nsa.gov> <4b37e892-4d79-aefb-92ab-7753b89b8963@tycho.nsa.gov>
 <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
 <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov> <CACT4Y+ai0do=8smTG0h0QXDnOrWh8PNwaTosJtqOEB_HG59eGg@mail.gmail.com>
 <b2b38348-f3a4-6498-c9b8-1090532f6a23@tycho.nsa.gov> <CACT4Y+bXaLe0FKyGPT=WqGitZPrawvpOXHS-UOVX0ZXTDV+JVQ@mail.gmail.com>
 <6c9112a2-33f3-0c29-c944-1d129a0026e7@tycho.nsa.gov>
In-Reply-To: <6c9112a2-33f3-0c29-c944-1d129a0026e7@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 4 Sep 2018 21:21:08 -0400
Message-ID: <CAHC9VhR6gG6_RkT1OEH4PArHpzUGkOjVCpKwAmad+TDfC15sgQ@mail.gmail.com>
Subject: Re: WARNING in apparmor_secid_to_secctx
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     dvyukov@google.com,
        syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com,
        tyhicks@canonical.com, john.johansen@canonical.com,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs@googlegroups.com, jeffv@google.com,
        selinux@tycho.nsa.gov, russell@coker.com.au, bigon@debian.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 1:00 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 09/04/2018 11:38 AM, Dmitry Vyukov wrote:
> > On Tue, Sep 4, 2018 at 5:28 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>>> So why not ask for help from the SELinux community? I've cc'd the selinux
> >>>> list and a couple of folks involved in Debian selinux.  I see a couple of
> >>>> options but I don't know your constraints for syzbot:
> >>>>
> >>>> 1) Run an instance of syzbot on a distro that supports SELinux enabled
> >>>> out
> >>>> of the box like Fedora. Then you don't have to fight with SELinux and can
> >>>> just focus on syzbot, while still testing SELinux enabled and enforcing.
> >>>>
> >>>> 2) Report the problems you are having with enabling SELinux on newer
> >>>> Debian
> >>>> to the selinux list and/or the Debian selinux package maintainers so that
> >>>> someone can help you resolve them.
> >>>>
> >>>> 3) Back-port the cgroup2 policy definitions to your wheezy policy,
> >>>> rebuild
> >>>> it, and install that.  We could help provide guidance on that. I think
> >>>> you'll need to rebuild the base policy on wheezy; in distributions with
> >>>> modern SELinux userspace, one could do it just by adding a CIL module
> >>>> locally.
> >>>
> >>>
> >>> Thanks, Stephen!
> >>>
> >>> I would like to understand first if failing mount(2) for unknown fs is
> >>> selinux bug or not. Because if it is and it is fixed, then it would
> >>> resolve the problem without actually doing anything (well, at least on
> >>> our side :)).
> >>
> >>
> >> Yes, I think that's a selinux kernel regression, previously reported here:
> >> https://lkml.org/lkml/2017/10/6/658
> >>
> >> Unfortunately I don't think it has been fixed upstream.  Generally people
> >> using SELinux with a newer kernel are also using a newer policy. That said,
> >> I agree it is a regression and ought to be fixed.
> >
> >
> > How hard is it to fix it? We are on upstream head, so once it's in we
> > are ready to go.
> > Using multiple images is somewhat problematic (besides the fact that I
> > don't know how to build a fedora image) because syzbot does not
> > capture what image was used, and in the docs we just provide the
> > single image, so people will start complaining that bugs don't
> > reproduce but they are just using a wrong image.
>
> I'll take a look and see if I can provide a trivial fix.

As a FYI, Stephen provided a patch and it has been merged into the
selinux/next tree.

* git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
* https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git

  Author: Stephen Smalley <sds@tycho.nsa.gov>
  Date:   Tue Sep 4 16:51:36 2018 -0400

   selinux: fix mounting of cgroup2 under older policies

   commit 901ef845fa2469c ("selinux: allow per-file labeling for cgroupfs")
   broke mounting of cgroup2 under older SELinux policies which lacked
   a genfscon rule for cgroup2.  This prevents mounting of cgroup2 even
   when SELinux is permissive.

   Change the handling when there is no genfscon rule in policy to
   just mark the inode unlabeled and not return an error to the caller.
   This permits mounting and access if allowed by policy, e.g. to
   unconfined domains.

   I also considered changing the behavior of security_genfs_sid() to
   never return -ENOENT, but the current behavior is relied upon by
   other callers to perform caller-specific handling.

   Fixes: 901ef845fa2469c ("selinux: allow per-file labeling for cgroupfs")
   CC: <stable@vger.kernel.org>
   Reported-by: Dmitry Vyukov <dvyukov@google.com>
   Reported-by: Waiman Long <longman@redhat.com>
   Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
   Tested-by: Waiman Long <longman@redhat.com>
   Signed-off-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com

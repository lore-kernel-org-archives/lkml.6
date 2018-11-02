Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FE8C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33362082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPoGXfcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33362082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeKBSGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 14:06:18 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43301 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeKBSGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 14:06:18 -0400
Received: by mail-yw1-f65.google.com with SMTP id j75-v6so479542ywj.10;
        Fri, 02 Nov 2018 01:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x0dxFhjvK44yBJ7cUDpokPt7cyWtq4x7xvYpuPartRY=;
        b=GPoGXfcPI1CwALHhKUSHCaiBp72oRUtK3e7RY0yYd9oMVD+4gf70tyDabveYie6zlu
         kc3MN76dpmtn6p6Q56PAeMPEX1AMuHRtCQst0B+NwR6Hleu5wvVRb6sF6vNGKgehGHkg
         gCqn9pe/PWV5hU5paJCYn1JNyVCzXLuxto0+zqhnJ9iP4wxk83PsxSMU1llSw3YFF/xp
         9u3cc/t6lIUKYlP1Jz/XNdRvsxHRZv9uJMlHlLu4AfmyVjRwxxY6ZP7WqrF2ouXp/S7N
         JO8a7tneNrgUPYR8W+8WS0tsYCz+f51HIvgJb5vtTNdgllTf8ayYu4h5mMkAaN3jysTc
         TeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0dxFhjvK44yBJ7cUDpokPt7cyWtq4x7xvYpuPartRY=;
        b=gSWwDt9VxGnzAMLIUXEPNG498lcJWnQeUXfWpJas8s2yUw3vdS/O4/MAw8sC3d2fT0
         XKmfs9mj+VGAR+o4r5ikJwcawXO6yJREmaDy8iGDo/Ik/dcGtcKg9Paywq83n07P5EZp
         wp2dOOCcOMYOgtFZ7HCwfd8c38tnBeYbknzEjzubBxAeUZ/WDG2s43O+FW41kasDr/MO
         YjDIwZOmiOhlPku9exIL6US8syEmLjOGC0g8748aJztXtxZf7qjV2guGCJbfLsL3YfD1
         sw/lMFYaSqxaXpREeSU3Nhfjr/o5nTxTk4kfHzow6G+D7kQIYL8VMdNvnyuLevKwLhy+
         4yWw==
X-Gm-Message-State: AGRZ1gI6CXI8BjrI1Bc5krUb0g3Y5hVeJW26VXQkkyvztXHKhMmqEtMP
        vIvPcT1b9TnXTeKgTZ5COOEo206/fpfxpglqaAw=
X-Google-Smtp-Source: AJdET5fcPsxx0UG/o6Alk8SoqrI5cH7Hos4vmDw8ABLNLXnowoyNzSWUnAFH8PMb/nsg8sK0LQsz00xnAexBx4NxEEs=
X-Received: by 2002:a81:4d03:: with SMTP id a3-v6mr10109691ywb.211.1541149189940;
 Fri, 02 Nov 2018 01:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181101214856.4563-1-seth.forshee@canonical.com>
In-Reply-To: <20181101214856.4563-1-seth.forshee@canonical.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 2 Nov 2018 10:59:38 +0200
Message-ID: <CAOQ4uxipSP_eKF-SZQ7ss1_yjnuTMyGniOZcgp7NXKBYB0E=8g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] shiftfs fixes and enhancements
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cc: linux-unionfs
It should the mailing list for *all* "stacking fs".
We have a lot of common problems I think ;-) ]

On Thu, Nov 1, 2018 at 11:49 PM Seth Forshee <seth.forshee@canonical.com> wrote:
>
> I've done some work to fix and enhance shiftfs for a number of use
> cases, so that we would have an idea what a more full-featured shiftfs
> would look like. I'm intending for these to serve as a point of
> reference for discussing id shifting mounts/filesystems at plumbers in a
> couple of weeks [1].
>
> Note that these are based on 4.18, and I've added a small fix to James'
> most recent patch to fix a build issue there. To work with 4.19 they
> will need a number of updates due to changes in the vfs.
>

Seth,

I like the way you addressed my concerns about nesting and stacking depth.
Will provide specific nits on patch.

In preparation to the Plumbers talk (which I will not be attending), I wanted to
get your opinion on the matters I brought up last time:
https://marc.info/?l=linux-fsdevel&m=153013920904844&w=2

1) Having seen what it takes to catch up with overlayfs w.r.t inotify bugs
and having peeked into 4.19 to see what work you still have lined up for you
to bring shitfs up to speed with vfs, did you have time to look into my proposal
for sharing code with overlayfs in the manner that I have implemented the
snapshotfs POC?
https://github.com/amir73il/linux/commit/25416757f2ca47759f59b115e6461b11898c4f06

Even if you end up not saving a single line of code for shiftfs v1
meaning that all shiftfs_inode_ops are completely separate implementation
from overlayfs inode ops, this may still be beneficial to shitfs in
the long run.
For example, you may, in fact, won't need to change anything to work with v4.19.
shittfs (as an overlayfs alias) would use ovl_file_operations and
shiftfs_inode_ops.

Another example, from the top of my head, see what it took to add NFS export
support to snapshotfs, because of the code reuse with overlayfs:
https://github.com/amir73il/linux/commit/d082eb615133490ec26fa2efaa80ed4723860893
Its practically the exact same implementation shiftfs would need,
so in the far future, shitfs and snapshotfs can share the same
export_operations.

2) Regarding this part:
+               /*
+                * this part is visible unshifted, so make sure no
+                * executables that could be used to give suid
+                * privileges
+                */
+               sb->s_iflags = SB_I_NOEXEC;

Why would you want to make the unshifted fs visible at all?
Is there a requirement for container users to access the unshifted fs
content? Is there a requirement for container admin to mount shitfted fs
NOT from the root of the marked mount?

If those are not required, then I propose NOOP inode operations for
the unshifted fs, specifically, empty readdir, just enough ops to be able
to use the mark mount point as the shitfed mount source - no more.

Thanks,
Amir.

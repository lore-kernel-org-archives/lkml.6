Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ED9C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 09:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC1B2146D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 09:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhZBMppp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC1B2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbeLAUVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 15:21:22 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46047 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbeLAUVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 15:21:22 -0500
Received: by mail-yb1-f195.google.com with SMTP id f6-v6so3291914ybg.12;
        Sat, 01 Dec 2018 01:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bo3+dNYd8ja+Na04S1BWZUCrnDgrc2vWIJaHBRsSQYY=;
        b=LhZBMpppPdnvjnzyWVbmpBogm76DwVeRzerH9cVrDVpJArG/e+HzDBYfXjinob074F
         sQ/ptYxlIkJylPXc6o2P6mQbIvso8BEt7yd1w6QHSI7CXozM4J7iiQ7iUovCPYOEhSYf
         feMEfbyOxikZLRRWbVErsO7shfY+4Y5WOI9OVxMi6qv86NR5uU+gtkjo4LjTF1DS4N/j
         7lXvFODjg4CFqHq47Dwaa4ruiUqezwQsjsWZoLSFjY77T/MAcDmIyxsHHF3Sk+1Zforp
         U1ZxvQpkODMcqLRrbo7dpGnLghyV1cn1T1P3H8ctBL8baCtOLc5+YuS1+wpLRAc2NNia
         EERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bo3+dNYd8ja+Na04S1BWZUCrnDgrc2vWIJaHBRsSQYY=;
        b=Vf/AjQVA1hjhIfIlQrrwM/rZmYdzfgIrZLFXVtRY5hyEEraodcgcJEFqPZL1gywW5J
         qEeiFFfzbbUoFwnjRueHkEmlk9uci3sphIwO7dzMh6H+Fc4TR7SfYr4bKYI4ufwRBCqE
         nNmtkRuTyWuocI736xBwsQzCijexkjOysRJBrTi0Eguukyd0Jm3K8YI30nhCuETSZyUI
         V8YNlLe18FVvSPh0ivDxJGXPXgrMnaTOBNUu2pKq1IdvSuph0YaQBi5bFryKOCu8o+37
         TPkVjq8P+0Ajx7YeiitIyJ+LMRM5a56puBT/u9355/rOTFrd2e5jGJjw2jGg9U34CSA8
         wshw==
X-Gm-Message-State: AA+aEWbd6Wbh2lGmJmBirDFOv16XiwZjtxophf79U175iYw6x/9AAu3R
        riGTNI/+y4U1MaLUKTlppFCBHZuRyxvhqbXNpJk=
X-Google-Smtp-Source: AFSGD/XDZnZPUr/rf/DOphWYE5u4c85+6LK78egLTwzO1KBEnDpx6L2XtV5F+y4vWt/eooQCak+QMciHHb/jQ0NNHVI=
X-Received: by 2002:a25:d8d5:: with SMTP id p204-v6mr3344958ybg.507.1543655358628;
 Sat, 01 Dec 2018 01:09:18 -0800 (PST)
MIME-Version: 1.0
References: <20181129060110.159878-1-sashal@kernel.org> <20181129060110.159878-25-sashal@kernel.org>
 <20181129121458.GK19305@dastard> <20181129124756.GA25945@kroah.com>
 <20181129224019.GM19305@dastard> <20181130082203.GA26830@kroah.com>
 <20181130101441.GA213156@sasha-vm> <20181130215005.GP19305@dastard> <20181201074909.GC213156@sasha-vm>
In-Reply-To: <20181201074909.GC213156@sasha-vm>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 1 Dec 2018 11:09:05 +0200
Message-ID: <CAOQ4uxhCH3oxVWDMVRcXMZO3JSTCA1Pp5AYnHP5pDxyNktqONw@mail.gmail.com>
Subject: Re: XFS patches for stable
To:     sashal@kernel.org
Cc:     Dave Chinner <david@fromorbit.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        "Luis R. Chamberlain" <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> It's getting to the point that with the amount of known issues with XFS
> >> on LTS kernels it makes sense to mark it as CONFIG_BROKEN.
> >
> >Really? Where are the bug reports?
>
> In 'git log'! You report these every time you fix something in upstream
> xfs but don't backport it to stable trees:
>
> $ git log --oneline v4.18-rc1..v4.18 fs/xfs
> d4a34e165557 xfs: properly handle free inodes in extent hint validators
> 9991274fddb9 xfs: Initialize variables in xfs_alloc_get_rec before using them
> d8cb5e423789 xfs: fix fdblocks accounting w/ RMAPBT per-AG reservation
> e53c4b598372 xfs: ensure post-EOF zeroing happens after zeroing part of a file
> a3a374bf1889 xfs: fix off-by-one error in xfs_rtalloc_query_range
> 232d0a24b0fc xfs: fix uninitialized field in rtbitmap fsmap backend
> 5bd88d153998 xfs: recheck reflink state after grabbing ILOCK_SHARED for a write
> f62cb48e4319 xfs: don't allow insert-range to shift extents past the maximum offset
> aafe12cee0b1 xfs: don't trip over negative free space in xfs_reserve_blocks
> 10ee25268e1f xfs: allow empty transactions while frozen
> e53946dbd31a xfs: xfs_iflush_abort() can be called twice on cluster writeback failure
> 23fcb3340d03 xfs: More robust inode extent count validation
> e2ac836307e3 xfs: simplify xfs_bmap_punch_delalloc_range
>
> Since I'm assuming that at least some of them are based on actual issues
> users hit, and some of those apply to stable kernels, why would users
> want to use an XFS version which is knowingly buggy?
>

Sasha,

There is one more point to consider.
Until v4.16, reflink and rmapbt features were experimental:
76883f7988e6 xfs: remove experimental tag for reverse mapping
1e369b0e199b xfs: remove experimental tag for reflinks

And MANY of the bug fixes flowing in through XFS tree to master
are related to those new XFS features and also to vfs functionality
that depends on them (e.g. clone/dedupe), so there MAY be no
bug reports at all for XFS in stable trees.

IMO users should NOT be expecting XFS to be stable with those
features enabled (they are still disabled by default)
when running on stable kernels below v4.16.

Allow me to act as a self-appointed mediator here and say:
There is obviously some bad blood between xfs developers and stable
tree maintainers.
The conflicts are caused by long standing frustration on both sides.
We would all be better off with looking forward on how to improve the
situation instead dwelling on past mistakes.
This issue was on the agenda at the XFS team meeting on last LSF/MM.
The path towards compliance has been laid out by xfs maintainers.
Luis, Sasha and myself have been working to improve the filesystem
test coverage for stable tree candidate patches.
We have still some way to go.

The stable candidate patches that triggered the recent flames
was outside of the fs/xfs subsystem, which AUTOSEL already know
to stay away from, so nobody had any intention to stir things up.

At the end of the day, most xfs developers work for companies that
ship enterprise distros and need to maintain stable trees, so I would
hope that it is in the best interest of everyone involved to cooperate
on the goal of better stable-xfs ecosystem.

On my part, I would be happy if AUTOSEL could point me at
candidate patch *series* for review instead of single patches.
For that matter, it sure wouldn't hurt if an xfs developer sending
out a patch series would cc:stable on the cover letter and if a developer
would be kind enough to add some backporting hints to the cover letter
text that would be very helpful indeed.

Thanks,
Amir.

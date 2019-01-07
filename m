Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F87C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A702183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546872705;
	bh=5Ngu0N4VELYBXpC3ew/naq8e9lRwUnX8O88YGFv14sE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pwaVp6/N5Hq3piTjrXOvY+FmitRyomfk8yWiIbgGATznxAi8GJjPwnbYQzzbl+hYX
	 /llqe/58eTSZ5WHdfChENV7YZsPpBYk4TnVsxgBfOEX7+UNjwouZzB+C1fbk9IhEEG
	 5Ig9VhGAi9xC5FHk2tTRsiWSvIMc1kTs3Bt+4FM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfAGOvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:51:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbfAGOvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:51:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF79B2087F;
        Mon,  7 Jan 2019 14:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546872703;
        bh=5Ngu0N4VELYBXpC3ew/naq8e9lRwUnX8O88YGFv14sE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K0d5DQLMMDsHoBVRYInha4H6nXEr98pCOsIL8kwy/FNqQvuosRXlNU3aO4Fbr74lV
         qjAR1sxWpl5csYfQDxt8Y2lL6VaP8Hs7/xUuAAU3Tq3WD5PtEE/kiF6mOSjcSvC+WE
         cRboZnI7HhYMwA5AzHerAQo/RdqAPbZEZnkJCZPw=
Date:   Mon, 7 Jan 2019 15:51:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/101] 4.14.92-stable review
Message-ID: <20190107145141.GA27768@kroah.com>
References: <20190107105330.372621917@linuxfoundation.org>
 <CAEUSe78fJzysEuEbQ_=finJ_XwhB3YCbTroL=FMpiSYu8Mh88g@mail.gmail.com>
 <20190107144701.GA27006@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190107144701.GA27006@kroah.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 03:47:01PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Jan 07, 2019 at 08:39:12AM -0600, Daniel Díaz wrote:
> > Hello!
> > 
> > On Mon, 7 Jan 2019 at 06:59, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > This is the start of the stable review cycle for the 4.14.92 release.
> > > There are 101 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > 
> > We see these build errors with 4.14:
> > | /srv/oe/build/tmp-lkft-glibc/work-shared/juno/kernel-source/fs/btrfs/extent-tree.c:
> > In function 'btrfs_drop_snapshot':
> > | /srv/oe/build/tmp-lkft-glibc/work-shared/juno/kernel-source/fs/btrfs/extent-tree.c:9186:8:
> > error: too few arguments to function 'btrfs_run_delayed_items'
> > |   err = btrfs_run_delayed_items(trans);
> > |         ^~~~~~~~~~~~~~~~~~~~~~~
> > | In file included from
> > /srv/oe/build/tmp-lkft-glibc/work-shared/juno/kernel-source/fs/btrfs/btrfs_inode.h:26:0,
> > |                  from
> > /srv/oe/build/tmp-lkft-glibc/work-shared/juno/kernel-source/fs/btrfs/transaction.h:23,
> > |                  from
> > /srv/oe/build/tmp-lkft-glibc/work-shared/juno/kernel-source/fs/btrfs/tree-log.h:23,
> > |                  from
> > /srv/oe/build/tmp-lkft-glibc/work-shared/juno/kernel-source/fs/btrfs/extent-tree.c:30:
> > | /srv/oe/build/tmp-lkft-glibc/work-shared/juno/kernel-source/fs/btrfs/delayed-inode.h:114:5:
> > note: declared here
> > |  int btrfs_run_delayed_items(struct btrfs_trans_handle *trans,
> > |      ^~~~~~~~~~~~~~~~~~~~~~~
> 
> Ugh, why does my build system not show this, but my laptop does...
> 
> Let me go drop the broken patches, thanks fo rletting me know.

Ok, now fixed, 4.9.y also had this issue.  I'll go push out -rc2
releases for both of these trees now.

greg k-h

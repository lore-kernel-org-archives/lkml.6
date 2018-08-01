Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CCBC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B109A208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B109A208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389983AbeHARLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:11:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:52126 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389476AbeHARLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:11:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 514DDAF3C;
        Wed,  1 Aug 2018 15:25:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4D8F4DAC7D; Wed,  1 Aug 2018 17:25:04 +0200 (CEST)
Date:   Wed, 1 Aug 2018 17:25:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCHES][RFC] icache-related stuff
Message-ID: <20180801152503.GJ3218@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
References: <20180729220317.GB30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729220317.GB30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 11:03:17PM +0100, Al Viro wrote:
> A bunch of filesystems switched to discard_new_inode() (btrfs, ufs, udf, ext2,
> jfs)
>       new primitive: discard_new_inode()
>       btrfs: switch to discard_new_inode()
>       ufs: switch to discard_new_inode()
>       udf: switch to discard_new_inode()
>       ext2: make sure that partially set up inodes won't be returned by ext2_iget()
>       jfs: switch to discard_new_inode()

Ack for the btrfs part, please take it through the VFS tree as it
logically belongs to the discard_new_inode updates.

> 4) several btrfs cleanups around btrfs_iget() and friends.
>       btrfs: btrfs_iget() never returns an is_bad_inode() inode.
>       btrfs: IS_ERR(p) && PTR_ERR(p) == n is a weird way to spell p == ERR_PTR(n)
>       btrfs: lift make_bad_inode() into btrfs_iget()
>       btrfs: simplify btrfs_iget()

And I'll take the cleanups through my tree as they don't seem to depend
on the other VFS changes, ie. patches 8, 9, 13 and 14.

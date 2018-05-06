Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeEFVc4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 17:32:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46728 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbeEFVcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 17:32:53 -0400
Date: Sun, 6 May 2018 22:32:47 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Martin Steigerwald <martin@lichtvoll.de>,
        Matthew Wilcox <willy@infradead.org>, dsterba@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-m68k@vger.kernel.org,
        Debian m68k <debian-68k@lists.debian.org>
Subject: Re: moving affs + RDB partition support to staging?
Message-ID: <20180506213247.GM30522@ZenIV.linux.org.uk>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180425203029.GQ21272@twin.jikos.cz>
 <20180426025717.GA32430@bombadil.infradead.org>
 <1613268.lKBQxPXt8J@merkaba>
 <76ca15e2-7b43-8b02-43e1-9ee65ab85356@physik.fu-berlin.de>
 <20180506005946.GI30522@ZenIV.linux.org.uk>
 <20180506073955.GJ30522@ZenIV.linux.org.uk>
 <20180506204622.GL30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180506204622.GL30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2018 at 09:46:23PM +0100, Al Viro wrote:

> 	I'm fixing that pile of crap (along with the NFS exports
> one and, hopefully, rename mess as well).  HOWEVER, I am not going
> to take over the damn thing - David has violated the 11th
> commandment (Thou Shalt Never Volunteer), so he gets to joy of
> learning that codebase and taking care of it from now on.

	Same scenario on link(2) ends up with
* ST_LINKFILE created, inserted into the link chain and left around,
without being present in any hash chain
* target becoming positive hashed dentry, as if link(2) has succeeded,
so dcache lookups will be finding it (for a while)
* unlink(2) on source will have very interesting effects, what with
the attempts to move ST_FILE entry into the directory presumed to
contain ST_LINKFILE one, removing ST_LINKFILE from it at the same time.

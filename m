Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeDYUdH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 16:33:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:48259 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750949AbeDYUdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 16:33:04 -0400
Date: Wed, 25 Apr 2018 22:30:29 +0200
From: David Sterba <dsterba@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Moving unmaintained filesystems to staging
Message-ID: <20180425203029.GQ21272@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180425154602.GA8546@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425154602.GA8546@bombadil.infradead.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 08:46:02AM -0700, Matthew Wilcox wrote:
> Recently ncpfs got moved to staging.  Also recently, we had some fuzzer
> developers report bugs in hfs, which they deem a security hole because
> Ubuntu attempts to automount an inserted USB device as hfs.
> 
> We have no maintainer for hfs, and no likely prospect of anyone stepping
> up soon to become hfs maintainer.  I think it's irresponsible of us
> to present unmaintained code on an equal basis with filesystems under
> active maintenance like ext2.
> 
> I therefore propose we move the following filesystems which are explicitly
> listed as Orphaned to staging:
> 
> affs - Amiga filesystem.
> efs - old SGI filesystem predating XFS, used on CDs for a while.
> hfs - Mac filesystem.
> hfsplus - Mac filesystem.
> 
> I further propose we move the following filesystems which have no entry
> in MAINTAINERS to staging:
> 
> adfs - Acorn filesystem from the 1990s.
> minix
> qnx6

I had similar toughts some time ago while browsing the fs/ directory.
Access to the filesystem images can be reimplemented in FUSE, but other
than that, I don't think the in-kernel code would be missed.

It's hard to know how many users are there. I was curious eg. about bfs,
befs, coda or feevxfs, looked at the last commits and searched around
web if there are any mentions or user community. But as long as there's
somebody listed in MAINTAINERS, the above are not candidates for moving
to staging or deletion.

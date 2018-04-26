Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbeDZFbK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:31:10 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:44144 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752367AbeDZFbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:31:07 -0400
Date: Thu, 26 Apr 2018 07:30:41 +0200
From: Willy Tarreau <w@1wt.eu>
To: Nikolay Borisov <nborisov@suse.com>
Cc: dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Moving unmaintained filesystems to staging
Message-ID: <20180426053041.GD30127@1wt.eu>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180425203029.GQ21272@twin.jikos.cz>
 <a0ae4962-2149-4773-86a8-79c2dbdeac0d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0ae4962-2149-4773-86a8-79c2dbdeac0d@suse.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 07:58:52AM +0300, Nikolay Borisov wrote:
> 
> 
> On 25.04.2018 23:30, David Sterba wrote:
> > On Wed, Apr 25, 2018 at 08:46:02AM -0700, Matthew Wilcox wrote:
> >> Recently ncpfs got moved to staging.  Also recently, we had some fuzzer
> >> developers report bugs in hfs, which they deem a security hole because
> >> Ubuntu attempts to automount an inserted USB device as hfs.
> >>
> >> We have no maintainer for hfs, and no likely prospect of anyone stepping
> >> up soon to become hfs maintainer.  I think it's irresponsible of us
> >> to present unmaintained code on an equal basis with filesystems under
> >> active maintenance like ext2.
> >>
> >> I therefore propose we move the following filesystems which are explicitly
> >> listed as Orphaned to staging:
> >>
> >> affs - Amiga filesystem.
> >> efs - old SGI filesystem predating XFS, used on CDs for a while.
> >> hfs - Mac filesystem.
> >> hfsplus - Mac filesystem.
> >>
> >> I further propose we move the following filesystems which have no entry
> >> in MAINTAINERS to staging:
> >>
> >> adfs - Acorn filesystem from the 1990s.
> >> minix
> >> qnx6
> > 
> > I had similar toughts some time ago while browsing the fs/ directory.
> > Access to the filesystem images can be reimplemented in FUSE, but other
> > than that, I don't think the in-kernel code would be missed.
> > 
> > It's hard to know how many users are there. I was curious eg. about bfs,
> > befs, coda or feevxfs, looked at the last commits and searched around
> > web if there are any mentions or user community. But as long as there's
> > somebody listed in MAINTAINERS, the above are not candidates for moving
> > to staging or deletion.
> > 
> 
> I think the presence of maintainers entry is necessary but insufficient.
> What if the maintainer has long lost interest but just didn't bother
> updating the file. In the very least maintainers should be pinged and
> asked if they are still maintaining the respective piece of code.

That's a good point. However the age of the last commit must not be used
as an excuse for moving them, because if the few users are very happy with
the code, never meet corner cases and never have to report bugs, neither
them nor the maintainers should be punished. In my opinion the only two
reasons for deprecating or removing code are that it's not maintained
anymore or that it's using ancient infrastructure that needs to be
changed and there's no way to adapt the old code to the new one.

In fact I think that the problem with very silent maintainers goes way
beyond FS. Everyone in MAINTAINERS who didn't send a commit in one year
should probably be asked if they're still doing the work, if they'd be
interested in someone else taking over, or if they think the whole code
has no reason to continue to exist.

Willy

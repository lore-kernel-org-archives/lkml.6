Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754948AbeDYPqE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:46:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754578AbeDYPqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:46:03 -0400
Date: Wed, 25 Apr 2018 08:46:02 -0700
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Moving unmaintained filesystems to staging
Message-ID: <20180425154602.GA8546@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently ncpfs got moved to staging.  Also recently, we had some fuzzer
developers report bugs in hfs, which they deem a security hole because
Ubuntu attempts to automount an inserted USB device as hfs.

We have no maintainer for hfs, and no likely prospect of anyone stepping
up soon to become hfs maintainer.  I think it's irresponsible of us
to present unmaintained code on an equal basis with filesystems under
active maintenance like ext2.

I therefore propose we move the following filesystems which are explicitly
listed as Orphaned to staging:

affs - Amiga filesystem.
efs - old SGI filesystem predating XFS, used on CDs for a while.
hfs - Mac filesystem.
hfsplus - Mac filesystem.

I further propose we move the following filesystems which have no entry
in MAINTAINERS to staging:

adfs - Acorn filesystem from the 1990s.
minix
qnx6

We have no listed maintainer for isofs.  This is clearly not a candidate
for staging.  Jan Kara appears to be acting as default maintainer,
so I'd like to propose he gets the appropriate credit with an entry
in MAINTAINERS.

romfs also has no listed maintainer.  I'm not sure who to suggest,
but it seems to have users.

tracefs isn't listed, and probably needs to become part of the
TRACING entry.

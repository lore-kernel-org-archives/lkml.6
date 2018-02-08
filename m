Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbeBHXlB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 18:41:01 -0500
Received: from ozlabs.org ([103.22.144.67]:40719 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751343AbeBHXlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 18:41:00 -0500
Date: Fri, 9 Feb 2018 10:40:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Sterba <dsterba@suse.cz>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: linux-next: build failure after merge of the btrfs-kdave tree
Message-ID: <20180209104057.0e999c19@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

[Seems I somehow failed to actually send the following message a couple
of days ago, sorry.]

After merging the btrfs-kdave tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

fs/btrfs/tree-checker.c:33:10: fatal error: hash.h: No such file or directory
 #include "hash.h"
          ^~~~~~~~

Caused by commit

  8bd2a9b19fd7 ("btrfs: Remove custom crc32c init code")

interacting with commit

  ad7b0368f33c ("btrfs: tree-checker: Add checker for dir item")

from Linus' tree.

It should have been fixed up in commit

  99ca8d38ea90 ("Merge branch 'ext/nikbor/libcrc32c' into for-next-next-v4.16-20180206")

I have used the btrfs-kdave tree from next-20180206 for today.

-- 
Cheers,
Stephen Rothwell

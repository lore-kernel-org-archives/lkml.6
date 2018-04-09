Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753233AbeDIRh4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 13:37:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58384 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbeDIRhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 13:37:55 -0400
Date: Mon, 9 Apr 2018 18:37:54 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git namei stuff
Message-ID: <20180409173753.GJ30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Making lookup_one_len() safe with parent locked only shared
(incoming afs series wants that) + fix of getname_kernel() regression
from 2015 (-stable fodder, that one).

The following changes since commit 04bbc9795d2e89c79edf48fb1303ace2e8c90a60:

  Merge branch 'old.dcache' into work.dcache (2018-04-04 00:40:19 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.namei

for you to fetch changes up to 30ce4d1903e1d8a7ccd110860a5eef3c638ed8be:

  getname_kernel() needs to make sure that ->name != ->iname in long case (2018-04-08 11:57:10 -0400)

----------------------------------------------------------------
Al Viro (4):
      merge common parts of lookup_one_len{,_unlocked} into common helper
      new helper: __lookup_slow()
      make lookup_one_len() safe to use with directory locked shared
      getname_kernel() needs to make sure that ->name != ->iname in long case

 fs/namei.c | 124 ++++++++++++++++++++++++++++---------------------------------
 1 file changed, 57 insertions(+), 67 deletions(-)

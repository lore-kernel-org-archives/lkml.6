Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbeEDWPP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 18:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751628AbeEDWPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 18:15:14 -0400
Date: Fri, 4 May 2018 15:15:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>
Subject: [GIT PULL] xfs: more fixes for 4.17-rc4
Message-ID: <20180504221513.GT26569@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I've got one more bug fix for xfs for 4.17-rc4, which caps the amount of
data we try to handle in one dedupe request so that userspace can't
livelock the kernel.

This series has been run through a full xfstests run during the week and
through a quick xfstests run against this morning's master, with no ajor
failures reported.  Let me know if there are any merge problems.

--D

The following changes since commit 7b38460dc8e4eafba06c78f8e37099d3b34d473c:

  xfs: don't fail when converting shortform attr to long form during ATTR_REPLACE (2018-04-17 19:10:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-4.17-fixes-2

for you to fetch changes up to 021ba8e98fe5c6691b3cc3669faafa02403aa211:

  xfs: cap the length of deduplication requests (2018-05-02 09:21:33 -0700)

----------------------------------------------------------------
Changes since last update:
- Cap the maximum length of a deduplication request at MAX_RW_COUNT/2
  to avoid kernel livelock due to excessively large IO requests.

----------------------------------------------------------------
Darrick J. Wong (1):
      xfs: cap the length of deduplication requests

 fs/xfs/xfs_file.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

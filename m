Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbeFBQkI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 12:40:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33755 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750964AbeFBQkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 12:40:06 -0400
Date: Sat, 2 Jun 2018 10:40:05 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?= <amade@asmblr.net>,
        "Jason Cai (Xiang Feng)" <jason.cai@linux.alibaba.com>
Subject: [GIT PULL] VFIO fix for v4.17
Message-ID: <20180602104005.018ba72c@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Sorry for the last minute pull request, a bisection has just identified
the commit reverted below as introducing a bad page state issue for
vfio users.  Please pull for v4.17.  Thanks,

Alex

The following changes since commit 0512e0134582ef85dee77d51aae77dcd1edec495:

  Merge tag 'xfs-4.17-fixes-3' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux (2018-05-31 16:23:07 -0500)

are available in the Git repository at:

  git://github.com/awilliam/linux-vfio.git tags/vfio-v4.17

for you to fetch changes up to 89c29def6b0101fff66a3d74d0178b844f88d732:

  Revert "vfio/type1: Improve memory pinning process for raw PFN mapping" (2018-06-02 08:41:44 -0600)

----------------------------------------------------------------
VFIO fix v4.17

 - Revert a pfn page mapping optimization identified as introducing
   a bad page state regression (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (1):
      Revert "vfio/type1: Improve memory pinning process for raw PFN mapping"

 drivers/vfio/vfio_iommu_type1.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

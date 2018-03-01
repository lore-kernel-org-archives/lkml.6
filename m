Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033896AbeCASVG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:21:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:14551 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033860AbeCASVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:21:05 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,408,1515484800";
   d="scan'208";a="30760363"
Date: Thu, 1 Mar 2018 20:20:58 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 4.16-5
Message-ID: <20180301182058.GA9000@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Couple of regressions were found, thus this PR.
It's relatively small for this rc round, and has no merge conflicts.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v4.16-5

for you to fetch changes up to 1cedc6385d5f7310af0a08831c6c4303486ba850:

  platform/x86: wmi: Fix misuse of vsprintf extension %pULL (2018-03-01 10:01:39 -0800)

----------------------------------------------------------------
platform-drivers-x86 for v4.16-5

Fix a regression on laptops like Dell XPS 9360 where keyboard stopped
working.

Correct sysfs wakeup attribute after removal of some drivers to reflect
that they are not able to wake system up anymore.

The following is an automated git shortlog grouped by driver:

intel-hid:
 -  Reset wakeup capable flag on removal

intel-vbtn:
 -  Reset wakeup capable flag on removal
 -  Only activate tablet mode switch on 2-in-1's

wmi:
 -  Fix misuse of vsprintf extension %pULL

----------------------------------------------------------------
Joe Perches (1):
      platform/x86: wmi: Fix misuse of vsprintf extension %pULL

Mario Limonciello (1):
      platform/x86: intel-vbtn: Only activate tablet mode switch on 2-in-1's

Rafael J. Wysocki (2):
      platform/x86: intel-vbtn: Reset wakeup capable flag on removal
      platform/x86: intel-hid: Reset wakeup capable flag on removal

 drivers/platform/x86/intel-hid.c  |  1 +
 drivers/platform/x86/intel-vbtn.c | 47 +++++++++++++++++++++++++--------------
 drivers/platform/x86/wmi.c        |  6 ++---
 3 files changed, 34 insertions(+), 20 deletions(-)

-- 
With Best Regards,
Andy Shevchenko

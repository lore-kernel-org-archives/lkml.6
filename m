Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754261AbeBGNtS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:49:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:57180 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753728AbeBGNtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:49:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000";
   d="scan'208";a="202244962"
Date: Wed, 7 Feb 2018 15:49:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 4.16-2
Message-ID: <20180207134915.GA10626@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This, due to dependencies, is sent separately since affected changes
wasn't in your tree yet. The rationale of doing this now is to allow use of
new macro in v4.17 cycle in a conflictless manner.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit a2e5790d841658485d642196dbb0927303d6c22f:

  Merge branch 'akpm' (patches from Andrew) (2018-02-06 22:15:42 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v4.16-2

for you to fetch changes up to 9a7c551ba7aae3648473179f234e960cfd46eaf4:

  platform/x86: samsung-laptop: Re-use DEFINE_SHOW_ATTRIBUTE() macro (2018-02-07 12:50:23 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v4.16-2

DEFINE_SHOW_ATTRIBUTE() macro defined privately in 3 locations is
useful for new and old users to avoid a lot of code duplication.

Move the macro to seq_file.h.

Along with above, clean up 3 drivers to use that macro.

The following is an automated git shortlog grouped by driver:

dell-laptop:
 -  Re-use DEFINE_SHOW_ATTRIBUTE() macro

ideapad-laptop:
 -  Re-use DEFINE_SHOW_ATTRIBUTE() macro

samsung-laptop:
 -  Re-use DEFINE_SHOW_ATTRIBUTE() macro

seq_file:
 -  Introduce DEFINE_SHOW_ATTRIBUTE() helper macro

----------------------------------------------------------------
Andy Shevchenko (4):
      seq_file: Introduce DEFINE_SHOW_ATTRIBUTE() helper macro
      platform/x86: dell-laptop: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      platform/x86: ideapad-laptop: Re-use DEFINE_SHOW_ATTRIBUTE() macro
      platform/x86: samsung-laptop: Re-use DEFINE_SHOW_ATTRIBUTE() macro

 drivers/mfd/ab8500-debugfs.c          | 14 --------------
 drivers/platform/x86/dell-laptop.c    | 14 +-------------
 drivers/platform/x86/ideapad-laptop.c | 28 ++--------------------------
 drivers/platform/x86/pmc_atom.c       | 14 --------------
 drivers/platform/x86/samsung-laptop.c | 18 +++---------------
 include/linux/seq_file.h              | 14 ++++++++++++++
 net/bluetooth/hci_debugfs.c           | 13 -------------
 7 files changed, 20 insertions(+), 95 deletions(-)

-- 
With Best Regards,
Andy Shevchenko

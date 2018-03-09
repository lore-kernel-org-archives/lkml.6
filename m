Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932479AbeCITXs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 14:23:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932230AbeCITXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 14:23:47 -0500
Date: Fri, 9 Mar 2018 11:23:44 -0800
From: Darren Hart <dvhart@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 4.16-6
Message-ID: <20180309192344.GA25680@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This race condition discovery and the resulting fix landed later than I
would have liked in the RC cycle, but I judged it worth fixing now
rather than waiting for stable. The Dell drivers have some legacy
dependencies we've been slowly untangling. I think a more invasive
change should happen in 4.17, but this minimal impact change fixes the
race condition and keeps Kconfig happy.

The following changes since commit 1cedc6385d5f7310af0a08831c6c4303486ba850:

  platform/x86: wmi: Fix misuse of vsprintf extension %pULL (2018-03-01 10:01:39 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v4.16-6

for you to fetch changes up to 32d7b19bad9695c4c9026b0ceb3a384561ddee70:

  platform/x86: dell-smbios: Resolve dependency error on DCDBAS (2018-03-09 09:35:46 -0800)

Thanks,

Darren Hart
VMware Open Source Technology Center

----------------------------------------------------------------
platform-drivers-x86 for v4.16-6

Correct a module loading race condition between the DELL_SMBIOS backend
modules and the first user by converting them to bool features of the
DELL_SMBIOS driver. Fixup the resulting Kconfig dependency issue with
DCDBAS.

The following is an automated git shortlog grouped by driver:

 -  Resolve dependency error on DCDBAS
 -  Allow for SMBIOS backend defaults
 -  Link all dell-smbios-* modules together
 -  Rename dell-smbios source to dell-smbios-base
 -  Correct some style warnings

----------------------------------------------------------------
Darren Hart (VMware) (2):
      platform/x86: Allow for SMBIOS backend defaults
      platform/x86: dell-smbios: Resolve dependency error on DCDBAS

Mario Limonciello (3):
      platform/x86: dell-smbios: Correct some style warnings
      platform/x86: dell-smbios: Rename dell-smbios source to dell-smbios-base
      platform/x86: dell-smbios: Link all dell-smbios-* modules together

 drivers/platform/x86/Kconfig                       | 27 ++++++++++++++------
 drivers/platform/x86/Makefile                      |  5 ++--
 .../x86/{dell-smbios.c => dell-smbios-base.c}      | 29 +++++++++++++++++++---
 drivers/platform/x86/dell-smbios-smm.c             | 18 +++-----------
 drivers/platform/x86/dell-smbios-wmi.c             | 14 +++--------
 drivers/platform/x86/dell-smbios.h                 | 27 +++++++++++++++++++-
 6 files changed, 82 insertions(+), 38 deletions(-)
 rename drivers/platform/x86/{dell-smbios.c => dell-smbios-base.c} (96%)

-- 
Darren Hart
VMware Open Source Technology Center

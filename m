Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeEFCUe (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 22:20:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54816 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeEFCUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 22:20:31 -0400
Date: Sat, 5 May 2018 19:20:22 -0700
From: Darren Hart <dvhart@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 4.17-2
Message-ID: <20180506022022.GA103239@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I was trying to keep DELL_LAPTOP visible in the menu, but the "select"
behavior makes that impossible. I'm planning on refactoring the Kconfig
by vendor for those with many options in 4.18 which should clean things
up. This fix from Mario corrects the potential for misconfiguration for
4.17 and 4.16 via stable.

Thanks,

Darren Hart
VMware Open Source Technology Center

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v4.17-2

for you to fetch changes up to 7fe3fa3b5ec8e75389cce4bf5d052a52e6198d59:

  platform/x86: Kconfig: Fix dell-laptop dependency chain. (2018-05-04 22:20:14 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v4.17-2

We missed a case in the Dell config dependencies resulting in a possible bad
configuration, resolve it by giving up on trying to keep DELL_LAPTOP visible in
the menu and make it depend on DELL_SMBIOS.

Fix a null pointer dereference at module unload for the asus-wireless driver.

The following is an automated git shortlog grouped by driver:

Kconfig:
 -  Fix dell-laptop dependency chain.

asus-wireless:
 -  Fix NULL pointer dereference

----------------------------------------------------------------
João Paulo Rechi Vita (1):
      platform/x86: asus-wireless: Fix NULL pointer dereference

Mario Limonciello (1):
      platform/x86: Kconfig: Fix dell-laptop dependency chain.

 drivers/platform/x86/Kconfig         | 2 +-
 drivers/platform/x86/asus-wireless.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
Darren Hart
VMware Open Source Technology Center

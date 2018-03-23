Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeCWPUe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:20:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751400AbeCWPUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:20:32 -0400
Date: Fri, 23 Mar 2018 09:20:29 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <aik@ozlabs.ru>, <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Casey Leedom <leedom@chelsio.com>, <arjun@chelsio.com>
Subject: [GIT PULL] VFIO fix for v4.16-rc7
Message-ID: <20180323092029.63571038@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Reverting one small v4.16 commit for further rework.  Thanks

The following changes since commit c698ca5278934c0ae32297a8725ced2e27585d7f:

  Linux 4.16-rc6 (2018-03-18 17:48:42 -0700)

are available in the Git repository at:

  git://github.com/awilliam/linux-vfio.git tags/vfio-v4.16-rc7

for you to fetch changes up to 834814e80268c818f354c8f402e0c6604ed75589:

  Revert: "vfio-pci: Mask INTx if a device is not capabable of enabling it" (2018-03-21 22:50:19 -0600)

----------------------------------------------------------------
VFIO fix for v4.16-rc7

 - Revert masking INTx where it cannot be enabled, plays poorly with
   SR-IOV VFs and presumes DisINTx support.

----------------------------------------------------------------
Alex Williamson (1):
      Revert: "vfio-pci: Mask INTx if a device is not capabable of enabling it"

 drivers/vfio/pci/vfio_pci.c | 3 ---
 1 file changed, 3 deletions(-)

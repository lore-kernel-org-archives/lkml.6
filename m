Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbeAaCml (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:42:41 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41577 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751826AbeAaCmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:42:40 -0500
X-ME-Sender: <xms:Hy1xWlEX8bA8u9nulGeMScW1-6C5EN_Qssbdnj3iitfkjp_tyTL4xQ>
Date: Wed, 31 Jan 2018 13:42:36 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] leaking_addresses.pl changes for 4.16-rc1
Message-ID: <20180131024236.GA31627@eros>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d8a5b80568a9cb66810e75b182018e9edb68e8ff:

  Linux 4.15 (2018-01-28 13:20:33 -0800)

are available in the git repository at:

  git://github.com/tcharding/linux.git tags/leaks-4.16-rc1

for you to fetch changes up to 46753437945535271a557dbf9dcb3ea53f1755e5:

  leaking_addresses: add 32-bit support (2018-01-31 08:18:51 +1100)

----------------------------------------------------------------
leaking_addresses patches for 4.16-rc1

Here is the patch set for changes to scripts/leaking_addresses.pl for
the 4.16-rc1 merge window.  The first 4 patches are clean up.  Then we
add the following functionality:

  - check addresses against the vsyscall memory range instead of just
    the first and last address (x86_64)
  - add support for getting config options from the kernel config file
  - add support for 5 page table levels (x86_64)
  - add support for scanning 32 bit kernels (based on the page offset)

Along the way we add some helper sub routines and use `uname -m` instead
of Perl for doing architecture detection.  All these patches, except the
trivial clean up ones, were posted to LKML.  The script with this set
applied has been tested on x86_64 (kernel 4.4 and 4.15), ppc64 (kernel
4.4) and ARM 32-bit (kernel 4.9).

Signed-off-by: Tobin C. Harding <me@tobin.cc>

----------------------------------------------------------------
Tobin C. Harding (10):
      leaking_addresses: fix typo function not called
      leaking_addresses: remove mention of kptr_restrict
      leaking_addresses: remove command examples
      leaking_addresses: indent dependant options
      leaking_addresses: add range check for vsyscall memory
      leaking_addresses: add support for kernel config file
      leaking_addresses: add support for 5 page table levels
      leaking_addresses: use system command to get arch
      leaking_addresses: add is_arch() wrapper subroutine
      leaking_addresses: add 32-bit support

 scripts/leaking_addresses.pl | 261 +++++++++++++++++++++++++++++++++----------
 1 file changed, 205 insertions(+), 56 deletions(-)

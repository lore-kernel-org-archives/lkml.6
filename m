Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754122AbeDBI1A (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 04:27:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54933 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbeDBI06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 04:26:58 -0400
X-Google-Smtp-Source: AIpwx49F9B1lAgK6sWsO28ou8sfylEZZ+AN1oAR0qiqwzWm6d/N9ycoQ2d/7hnw63ArHehG/QD9nBA==
Date: Mon, 2 Apr 2018 10:26:54 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] RAS changes for v4.17
Message-ID: <20180402082654.nyyzqno5pzrccrtk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest ras-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

   # HEAD: e2efacb6a54ab54626da3507be1008d0040492cc Revert "x86/mce/AMD: Collect error info even if valid bits are not set"

The main changes in this cycle were:

  - AMD MCE support/decoding improvements            (Yazen Ghannam)
  - general MCE header cleanups and reorganization   (Borislav Petkov)

 Thanks,

	Ingo

------------------>
Borislav Petkov (5):
      x86/mce: Put private structures and definitions into the internal header
      x86/mce: Convert 'struct mca_config' bools to a bitfield
      x86/mce: Issue the 'mcelog --ascii' message only on !AMD
      x86/mce/AMD: Collect error info even if valid bits are not set
      x86/MCE: Cleanup and complete struct mce fields definitions

Yazen Ghannam (5):
      x86/mce/AMD: Pass the bank number to smca_get_bank_type()
      x86/mce/AMD, EDAC/mce_amd: Enumerate Reserved SMCA bank type
      x86/mce/AMD: Get address from already initialized block
      x86/mce/AMD: Carve out SMCA get_block_address() code
      Revert "x86/mce/AMD: Collect error info even if valid bits are not set"


 arch/x86/include/asm/mce.h                | 53 +--------------------
 arch/x86/include/uapi/asm/mce.h           | 52 +++++++++++----------
 arch/x86/kernel/cpu/mcheck/mce-internal.h | 59 ++++++++++++++++++++++-
 arch/x86/kernel/cpu/mcheck/mce.c          | 20 ++++----
 arch/x86/kernel/cpu/mcheck/mce_amd.c      | 78 ++++++++++++++++++++-----------
 drivers/edac/mce_amd.c                    | 11 +++--
 6 files changed, 156 insertions(+), 117 deletions(-)

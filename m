Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbeFDEtG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 00:49:06 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34022 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeFDEtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 00:49:05 -0400
X-Google-Smtp-Source: ADUXVKIsHbL92qVsjzYw8h84gSiVHZfGNY0nQBXk6OeMO9m6BeLZjn9aO8/m+98dnQovSJqJjcDrKQ==
Date: Sun, 3 Jun 2018 21:49:02 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Colin Cross <ccross@android.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>, Neil Brown <neilb@suse.com>,
        Richard Weinberger <richard@nod.at>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>
Subject: [GIT PULL] rslib updates for v4.18-rc1
Message-ID: <20180604044902.GA25793@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these rslib changes for v4.18-rc1. Thomas asked me to carry
this series since I've been coordinating VLA removal, and he's got enough
trees to worry about. :) This has been in -next for a while now.

Thanks!

-Kees

The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/rslib-v4.18-rc1

for you to fetch changes up to 45888b40d2a6221d46bb69959e2600ddba71cc1f:

  rslib: Allocate decoder buffers to avoid VLAs (2018-04-24 19:50:10 -0700)

----------------------------------------------------------------
Refactors rslib and callers to provide a per-instance allocation area
instead of performing VLAs on the stack.

----------------------------------------------------------------
Thomas Gleixner (10):
      rslib: Add GFP aware init function
      dm/verity_fec: Use GFP aware reed solomon init
      rslib: Cleanup whitespace damage
      rslib: Cleanup top level comments
      rslib: Add SPDX identifiers
      rslib: Remove GPL boilerplate
      rslib: Simplify error path
      rslib: Split rs control struct
      mtd: rawnand: diskonchip: Allocate rs control per instance
      rslib: Allocate decoder buffers to avoid VLAs

 drivers/md/dm-verity-fec.c        |   2 +-
 drivers/mtd/nand/raw/cafe_nand.c  |   7 +-
 drivers/mtd/nand/raw/diskonchip.c |  67 +++++------
 include/linux/rslib.h             |  74 +++++++-----
 lib/reed_solomon/decode_rs.c      |  34 +++---
 lib/reed_solomon/encode_rs.c      |  15 +--
 lib/reed_solomon/reed_solomon.c   | 240 ++++++++++++++++++++++----------------
 7 files changed, 243 insertions(+), 196 deletions(-)

-- 
Kees Cook
Pixel Security

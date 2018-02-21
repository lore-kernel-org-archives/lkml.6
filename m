Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932792AbeBUKTV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:19:21 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57740 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932631AbeBUKTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:19:19 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/8] x86/RAS: Some accumulated stuff
Date: Wed, 21 Feb 2018 11:18:52 +0100
Message-Id: <20180221101900.10326-1-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi,

first 3 are cleanups, 4th makes MCA code collect error info without
looking at the Valid bits because there might be cases where they're not
set.

The last 4 fix the IPI-with-IRQs-off issue which was reported recently.

Thx.

Borislav Petkov (4):
  x86/MCE: Put private structures and definitions into the internal
    header
  x86/MCE: Convert mca_config bools to a bitfield
  x86/mce: Issue the mcelog --ascii message on !AMD
  x86/MCE/AMD: Collect error info even if valid bits are not set

Yazen Ghannam (4):
  x86/MCE/AMD: Pass the bank number to smca_get_bank_type()
  x86/MCE/AMD, EDAC/mce_amd: Enumerate Reserved SMCA bank type
  x86/MCE/AMD: Get address from already initialized block
  x86/MCE/AMD: Carve out SMCA get_block_address() code

 arch/x86/include/asm/mce.h                | 53 +--------------------
 arch/x86/kernel/cpu/mcheck/mce-internal.h | 55 ++++++++++++++++++++++
 arch/x86/kernel/cpu/mcheck/mce.c          | 34 ++++++++++----
 arch/x86/kernel/cpu/mcheck/mce_amd.c      | 78 ++++++++++++++++++++-----------
 drivers/edac/mce_amd.c                    | 11 +++--
 5 files changed, 140 insertions(+), 91 deletions(-)

-- 
2.13.0

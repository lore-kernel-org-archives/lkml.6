Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937545AbeBUQty (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:49:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:35006 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932778AbeBUQtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:49:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,545,1511856000";
   d="scan'208";a="20034192"
From: Ashok Raj <ashok.raj@intel.com>
To: bp@suse.de
Cc: Ashok Raj <ashok.raj@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: [PATCH 0/3] Patch series to address some limitations in OS microcode loading.
Date: Wed, 21 Feb 2018 08:49:41 -0800
Message-Id: <1519231784-9941-1-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following set of patches address some limitations on microcode loading.

First patch avoids a redundant microcode load on sibling thread if
another HT sibling got updated.

Ashok Raj (3):
  x86/microcode/intel: Check microcode revision before updating sibling
    threads
  x86/microcode/intel: Perform a cache flush before ucode update.
  x86/microcode: Quiesce all threads before a microcode update.

 arch/x86/kernel/cpu/microcode/core.c  | 113 +++++++++++++++++++++++++++++-----
 arch/x86/kernel/cpu/microcode/intel.c |  19 +++++-
 2 files changed, 113 insertions(+), 19 deletions(-)

-- 
2.7.4

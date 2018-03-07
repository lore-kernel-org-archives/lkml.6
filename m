Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965891AbeCGTxa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 14:53:30 -0500
Received: from mga18.intel.com ([134.134.136.126]:53937 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934472AbeCGTx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:53:28 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,437,1515484800";
   d="scan'208";a="23759879"
Date: Wed, 7 Mar 2018 11:45:58 -0800
From: Ivan Gorinov <ivan.gorinov@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 0/4] x86/devicetree: Re-enable x86-specific implementation
Message-ID: <cover.1520450752.git.ivan.gorinov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing x86-specific DT implementation in the kernel allows reusing most of
firmware code for SoC that have ARM core replaced with x86, e.g. SC9853i.

Changes since v3:

 * Using fdt_totalsize() to get DTB size before remapping
   instead of setting initial_boot_params and calling
   of_get_flat_dt_size() before early_init_dt_verify();

 * Adding new intel,apic-id property to the documentation.

Changes since v2:

 * WARN_ON_ONCE instead of WARN_ON to aviod multiple warnings
   when APIC ID is missing in CPU device tree nodes

 * Switched to Mutt because of white space issues:
   "Preformatted" paragraph style does not work in Evolution 3.18.5.2

Changes since first version:

 * Splitting a single patch into three parts

Ivan Gorinov (4):
  x86/devicetree: Initialize device tree before using it
  x86/devicetree: Fix device IRQ settings in DT
  of: Documentation: Add x86 local APIC ID property
  x86/devicetree: Enable multiprocessing in DT

 Documentation/devicetree/bindings/x86/ce4100.txt |  6 +++
 arch/x86/kernel/devicetree.c                     | 48 +++++++++++++++++++-----
 2 files changed, 44 insertions(+), 10 deletions(-)

-- 
2.7.4

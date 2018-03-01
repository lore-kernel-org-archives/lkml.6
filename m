Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163046AbeCAXMK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:12:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:6877 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162931AbeCAXMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:12:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="208215291"
Date: Thu, 1 Mar 2018 15:04:45 -0800
From: Ivan Gorinov <ivan.gorinov@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v3 0/3] x86: devicetree: re-enable x86-specific implementation
Message-ID: <20180301230445.GA48473@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing x86-specific DT implementation in the kernel allows reusing most of
firmware code for SoC that have ARM core replaced with x86, e.g. SC9853i.

Changes since v2:

 * WARN_ON_ONCE instead of WARN_ON to aviod multiple warnings
   when APIC ID is missing in CPU device tree nodes

 * Switched to Mutt because of white space issues:
   "Preformatted" paragraph style does not work in Evolution 3.18.5.2

Changes since first version:

 * Splitting a single patch into three parts

Ivan Gorinov (3):
  x86: devicetree: call early_init_dt_verify()
  x86: devicetree: enable multiprocessing in DT
  x86: devicetree: fix device IRQ settings in DT

 arch/x86/kernel/devicetree.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

-- 
2.7.4

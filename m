Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751843AbeCVVnQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 17:43:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:46355 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751669AbeCVVnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 17:43:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,345,1517904000";
   d="scan'208";a="210554301"
Date: Thu, 22 Mar 2018 14:35:19 -0700
From: Ivan Gorinov <ivan.gorinov@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v8 0/2] x86/devicetree: Enable multiprocessing
Message-ID: <cover.1521753738.git.ivan.gorinov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current x86 implementation of Device Tree does not support multiprocessing,
and the bindings documentation describes the "reg" property of "cpu" nodes
as "CPU number" instead of hardware-assigned local APIC ID.

v8:
 * Fixed build error with CONFIG_X86_LOCAL_APIC=n reported by kbuild.

v7:
 * Change log update.

v6:
 * Calling of_property_read_u32() to get Local APIC ID from "reg".

 * DT documentation changes: corrected CPU node example and changed
   the "reg" property description.

v5:
 * Using the "reg" property to specify Local APIC ID.

Ivan Gorinov (2):
  of: Documentation: Specify local APIC ID in "reg"
  x86/devicetree: Use CPU description from Device Tree

 Documentation/devicetree/bindings/x86/ce4100.txt | 37 ++++++++++++++-----
 arch/x86/kernel/devicetree.c                     | 45 +++++++++++++++++-------
 2 files changed, 61 insertions(+), 21 deletions(-)

-- 
2.7.4

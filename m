Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753811AbeCUVif (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 17:38:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:12628 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753570AbeCUVie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 17:38:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,341,1517904000";
   d="scan'208";a="27328997"
Date: Wed, 21 Mar 2018 14:30:40 -0700
From: Ivan Gorinov <ivan.gorinov@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 0/2] x86/devicetree: Enable multiprocessing
Message-ID: <cover.1521667677.git.ivan.gorinov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current x86 implementation of Device Tree does not support multiprocessing,
and the bindings documentation describes the "reg" property as CPU number
instead of hardware-assigned local APIC ID.

v7:
 * Change log update

v6:
 * Calling of_property_read_u32() to get Local APIC ID from "reg"

 * DT documentation changes: corrected CPU node example and changed
   the "reg" property description

v5:
 * Using the "reg" property to specify Local APIC ID

Ivan Gorinov (2):
  of: Documentation: Specify local APIC ID in "reg"
  x86/devicetree: Use CPU description from Device Tree

 Documentation/devicetree/bindings/x86/ce4100.txt | 37 ++++++++++++++++------
 arch/x86/kernel/devicetree.c                     | 39 +++++++++++++++++-------
 2 files changed, 56 insertions(+), 20 deletions(-)

-- 
2.7.4

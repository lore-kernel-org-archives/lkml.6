Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932242AbeCLW2u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 18:28:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:47478 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbeCLW2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 18:28:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,463,1515484800";
   d="scan'208";a="36733715"
Date: Mon, 12 Mar 2018 15:21:10 -0700
From: Ivan Gorinov <ivan.gorinov@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 0/2] x86/devicetree: Enable multiprocessing
Message-ID: <cover.1520891263.git.ivan.gorinov@intel.com>
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

Ivan Gorinov (2):
  of: Documentation: Specify local APIC ID in "reg"
  x86/devicetree: Use CPU description from Device Tree

 Documentation/devicetree/bindings/x86/ce4100.txt | 38 ++++++++++++++++-----
 arch/x86/kernel/devicetree.c                     | 42 +++++++++++++++++-------
 2 files changed, 60 insertions(+), 20 deletions(-)

-- 
2.7.4

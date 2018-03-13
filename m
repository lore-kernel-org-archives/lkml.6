Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752462AbeCMR5z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:57:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:5920 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751529AbeCMR5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:57:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,465,1515484800";
   d="scan'208";a="23974751"
Message-ID: <1520963414.38672.31.camel@intel.com>
Subject: Re: [PATCH v5 1/2] of: Documentation: Specify local APIC ID in "reg"
From: Ivan Gorinov <ivan.gorinov@intel.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Rob Herring <robh+dt@kernel.org>
Date: Tue, 13 Mar 2018 10:50:14 -0700
In-Reply-To: <20180313110153.vdtgljcvsbwiixwx@lakrids.cambridge.arm.com>
References: <cover.1520891263.git.ivan.gorinov@intel.com>
         <a0a0aff3befabf74a65361d0b7b7e5bc9d00176d.1520891263.git.ivan.gorinov@intel.com>
         <20180313110153.vdtgljcvsbwiixwx@lakrids.cambridge.arm.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-13 at 11:01 +0000, Mark Rutland wrote:

> > +		cpu@1 {
> > +			device_type = "cpu";
> > +			compatible = "intel,ce4100";
> > +			reg = <0x02>;
> > +		};
> The unit-address (the bit after the '@' in the node name) should match
> the reg, so this node should be named cpu@2.

OK

> > -The reg property describes the CPU number. The lapic property points to
> > -the local APIC timer.
> Why was the lapic phandle removed?

The "lapic" node may not be required.

Local APIC is an essential part of every logical CPU described by a "cpu"
node, with registers accessed as memory-mapped I/O (except for x2APIC mode).
Current implementation of local APIC kernel driver requires base address to
be the same on all CPUs, default 0xfee00000. If the base address is changed
by firmware, one optional node can describe new address for all CPUs.

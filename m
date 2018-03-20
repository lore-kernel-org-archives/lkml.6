Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbeCTS0V (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 14:26:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35488 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbeCTS0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 14:26:20 -0400
Date: Tue, 20 Mar 2018 19:26:12 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ivan Gorinov <ivan.gorinov@intel.com>
cc: Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v6 1/2] of: Documentation: Specify local APIC ID in
 "reg"
In-Reply-To: <20180320181018.GA8670@intel.com>
Message-ID: <alpine.DEB.2.21.1803201925450.1714@nanos.tec.linutronix.de>
References: <cover.1520974793.git.ivan.gorinov@intel.com> <c5eb2fd010855d187007859e7a332c866fbd41ec.1520974793.git.ivan.gorinov@intel.com> <CAL_JsqLvV6-MY_4ui8T3nYnqG0q=QN6nnCVxbxD0aarhLqjNKA@mail.gmail.com> <20180320181018.GA8670@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2018, Ivan Gorinov wrote:

> On Mon, Mar 19, 2018 at 07:39:52PM -0500, Rob Herring wrote:
> > On Tue, Mar 13, 2018 at 5:05 PM, Ivan Gorinov <ivan.gorinov@intel.com> wrote:
> > > Use the "reg" property to specify the processor's local APIC ID.
> > > Local APIC ID is assigned by hardware and may differ from CPU number.
> > 
> > Is "CPU number" a s/w visible h/w number or has it just been an index
> > for DT? In the latter case, I'm okay with this change. In the former
> > case, you should stick to the existing numbering. For example on ARM,
> > the number here corresponds to a core ID number in a register called
> > MPIDR.
> 
> The latter case. Apparently, "CPU number" was just an index in the list.
> Local APIC ID is the s/w visible h/w assigned number.
> Some processor models allow local APIC ID to be changed by software, but
> CPUID instruction executed with %eax = 0x0b always returns the initial ID
> assigned by hardware in %edx.
> 
> APIC ID does not match index in the list in many systems.

Please document that in the changelog.

Thanks,

	tglx

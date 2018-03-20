Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeCTJJj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:09:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeCTJJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:09:38 -0400
Date: Tue, 20 Mar 2018 10:09:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Liu, Changcheng" <changcheng.liu@intel.com>
Cc: tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        linux-kernel@vger.kernel.org,
        "Stanton, Kevin B" <kevin.b.stanton@intel.com>
Subject: Re: [PATCH] x86/ioapic: don't use unstable TSC to detect timer IRQ
Message-ID: <20180320090931.GQ4043@hirez.programming.kicks-ass.net>
References: <20180320084255.GA187704@sofia>
 <20180320084929.GP4043@hirez.programming.kicks-ass.net>
 <20180320085835.GA56497@sofia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320085835.GA56497@sofia>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 04:58:35PM +0800, Liu, Changcheng wrote:
> On 09:49 Tue 20 Mar, Peter Zijlstra wrote:
> > On Tue, Mar 20, 2018 at 04:42:55PM +0800, Liu, Changcheng wrote:
> > > In rare case, the TSC is every unstable or can't sync with
> > > real time hardware clock. 
> > 
> > However did you manage that? Please provide _FAR_ more details.

> [Changcheng] TSC is simulated and HPET is hardware implemented.
> TSC can't sync with HPET. When running linux, the TSC grows too
> fast and HPET can't trigger periodic timer interrupt in time which
> is used to update jiffies.

How is that not utterly broken, and how is that even allowed behaviour
as per the SDM ?

If the TSC is so utterly broken as to not function according to spec,
you should not advertise the TSC, at which point you'll find that it is
_very_ hard to run modern linux on x86 without TSC.

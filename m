Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752432AbeCTJDd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:03:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34061 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752046AbeCTJDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:03:30 -0400
Date: Tue, 20 Mar 2018 10:03:11 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Liu, Changcheng" <changcheng.liu@intel.com>
cc: Peter Zijlstra <peterz@infradead.org>, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/ioapic: don't use unstable TSC to detect timer IRQ
In-Reply-To: <20180320085835.GA56497@sofia>
Message-ID: <alpine.DEB.2.21.1803201000380.6506@nanos.tec.linutronix.de>
References: <20180320084255.GA187704@sofia> <20180320084929.GP4043@hirez.programming.kicks-ass.net> <20180320085835.GA56497@sofia>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2018, Liu, Changcheng wrote:

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

Why on earth is that system claiming it has a TSC at all? That's just
broken.

Thanks,

	tglx

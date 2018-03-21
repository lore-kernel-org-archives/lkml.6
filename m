Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbeCUJli (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 05:41:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36569 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeCUJlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 05:41:36 -0400
Date: Wed, 21 Mar 2018 10:41:21 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
        mingo@redhat.com, corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org,
        hpa@zytor.com
Subject: Re: [PATCH 1/5] x86/smpboot: Add the missing description of
 possible_cpus
In-Reply-To: <20180321090826.GW4043@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1803211039170.3754@nanos.tec.linutronix.de>
References: <20180320110432.28127-1-douly.fnst@cn.fujitsu.com> <20180320110432.28127-2-douly.fnst@cn.fujitsu.com> <20180320123712.GR4043@hirez.programming.kicks-ass.net> <f64cb207-3851-9a26-2001-653fc0068540@cn.fujitsu.com>
 <20180321090826.GW4043@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2018, Peter Zijlstra wrote:
> On Wed, Mar 21, 2018 at 01:33:24PM +0800, Dou Liyang wrote:
> > How about:
> > 
> > possible_cpus=	[s390,x86_64] Set the number of possible CPUs which
> > 		are determined by the ACPI tables MADT or mptables by
> > 		default. possible_cpus=n : n >= 1 enforces the possible
> > 		number to be 'n'.
> > 		While nr_cpus is also be set: nr_cpus=m, choice the
> > 		minimum one for the number of possible CPUs.
> 
> So what is the exact difference between possible_cpus and nr_cpus ? I
> konw maxcpus= limits the number of CPUs we bring up, and possible_cpus
> limits the possible_map, but I'm not entirely sure what nr_cpus does
> here.

nr_cpus limits the number of CPUs the kernel will handle. Think of it as a
boot time override of NR_CPUs.

Way too many commandline switches though.

Thanks,

	tglx

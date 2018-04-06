Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeDFJFI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 05:05:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35132 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbeDFJFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 05:05:07 -0400
Date: Fri, 6 Apr 2018 11:05:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Li RongQing <lirongqing@baidu.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] genirq: only scan the present CPUs
Message-ID: <20180406090502.GI4129@hirez.programming.kicks-ass.net>
References: <1522647902-11426-1-git-send-email-lirongqing@baidu.com>
 <alpine.DEB.2.21.1804031224150.2511@nanos.tec.linutronix.de>
 <20180403112311.GF4043@hirez.programming.kicks-ass.net>
 <f2bf898d-c9da-dfb8-f50d-6fe8ddb122e6@cn.fujitsu.com>
 <20180406090228.GI4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406090228.GI4082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 11:02:28AM +0200, Peter Zijlstra wrote:
> On Fri, Apr 06, 2018 at 04:42:14PM +0800, Dou Liyang wrote:
> > Hi Thomas, Peter,
> > 
> > At 04/03/2018 07:23 PM, Peter Zijlstra wrote:
> > > On Tue, Apr 03, 2018 at 12:25:56PM +0200, Thomas Gleixner wrote:
> > > > On Mon, 2 Apr 2018, Li RongQing wrote:
> > > > 
> > > > > lots of application will read /proc/stat, like ps and vmstat, but we
> > > > > find the reading time are spreading on Purley platform which has lots
> > > > > of possible CPUs and interrupt.
> > > > > 
> > > > > To reduce the reading time, only scan the present CPUs, not all possible
> > > > > CPUs, which speeds the reading of /proc/stat 20 times on Purley platform
> > > > > which has 56 present CPUs, and 224 possible CPUs
> > > > 
> > > > Why is BIOS/ACPI telling the kernel that there are 224 possible CPUs unless
> > > > it supports physical CPU hotplug.
> > > 
> > > BIOS is crap, news at 11. I've got boxes like that too. Use
> > > possible_cpu=$nr if you're bothered by it -- it's what I do.
> > > 
> > 
> > Yes, I think so. it is a manual way to reset the number.
> > 
> > For this situation, I am investigating to restrict the number of
> > possible CPUs automatically, But, due to the limitation of ACPI
> > subsystem, I can do it _before_ setup_percpu_area where the number will
> > be used.

Ah, did you mean to day "I can _NOT_ do it" ? Still I don't see the
point of frobbing random users if the whole thing is buggered.

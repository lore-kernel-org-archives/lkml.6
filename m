Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755487AbeDCLXW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 07:23:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38120 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755121AbeDCLXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 07:23:21 -0400
Date: Tue, 3 Apr 2018 13:23:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Li RongQing <lirongqing@baidu.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] genirq: only scan the present CPUs
Message-ID: <20180403112311.GF4043@hirez.programming.kicks-ass.net>
References: <1522647902-11426-1-git-send-email-lirongqing@baidu.com>
 <alpine.DEB.2.21.1804031224150.2511@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1804031224150.2511@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 12:25:56PM +0200, Thomas Gleixner wrote:
> On Mon, 2 Apr 2018, Li RongQing wrote:
> 
> > lots of application will read /proc/stat, like ps and vmstat, but we
> > find the reading time are spreading on Purley platform which has lots
> > of possible CPUs and interrupt.
> > 
> > To reduce the reading time, only scan the present CPUs, not all possible
> > CPUs, which speeds the reading of /proc/stat 20 times on Purley platform
> > which has 56 present CPUs, and 224 possible CPUs
> 
> Why is BIOS/ACPI telling the kernel that there are 224 possible CPUs unless
> it supports physical CPU hotplug.

BIOS is crap, news at 11. I've got boxes like that too. Use
possible_cpu=$nr if you're bothered by it -- it's what I do.

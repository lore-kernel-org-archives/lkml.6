Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933658AbeBLNLJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:11:09 -0500
Received: from casper.infradead.org ([85.118.1.10]:58612 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933166AbeBLNLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:11:07 -0500
Date: Mon, 12 Feb 2018 14:06:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        Thomas Mingarelli <thomas.mingarelli@hpe.com>, hpa@zytor.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Dave Hansen <dave@sr71.net>, Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@infradead.org>
Subject: Re: [tip:x86/pti] x86/speculation: Use IBRS if available before
 calling into firmware
Message-ID: <20180212130640.GK25181@hirez.programming.kicks-ass.net>
References: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
 <20180212102211.cdrrqqd4hdw7xu5y@gmail.com>
 <20180212115002.GI25181@hirez.programming.kicks-ass.net>
 <1518438439.6606.36.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518438439.6606.36.camel@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 12:27:19PM +0000, David Woodhouse wrote:
> On Mon, 2018-02-12 at 12:50 +0100, Peter Zijlstra wrote:

> > Wait, we're doing firmware from NMI? That sounds like a _REALLY_ bad
> > idea.
> 
> And spin_lock_irqsave() too. Which is probably why I missed the fact
> that this was being called in NMI context.
> 
> Yay for HP and their persistent attempts to "value subtract" in their
> firmware offerings.
> 
> I'm tempted to drop that part of the patch and declare that if you're
> using this driver, the potential for stray branch prediction when you
> call into the firmware from the NMI handler is the *least* of your
> problems.

We should probably mark it BROKEN or something, or move it into staging.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754267AbeBBTza (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 14:55:30 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37166 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752567AbeBBTzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 14:55:23 -0500
Date: Fri, 2 Feb 2018 20:55:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        efault@gmx.de, tglx@linutronix.de, mingo@kernel.org,
        alexander.levin@verizon.com
Subject: Re: Runqueue spinlock recursion on arm64 v4.15
Message-ID: <20180202195506.GP2269@hirez.programming.kicks-ass.net>
References: <20180202192704.nqwjsthl3agszhzt@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202192704.nqwjsthl3agszhzt@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 07:27:04PM +0000, Mark Rutland wrote:
> ... in some cases, owner_cpu is -1, so I guess we're racing with an
> unlock. I only ever see this on the runqueue locks in wake up functions.

So runqueue locks are special in that the owner changes over a contex
switch, maybe something goes funny there?

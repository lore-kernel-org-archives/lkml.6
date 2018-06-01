Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbeFANVG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:21:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60652 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbeFANVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:21:02 -0400
Date: Fri, 1 Jun 2018 15:20:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>
Subject: Re: 4.13..4.14 scheduling overhead regression (bisected  -
 b956575bed91)
Message-ID: <20180601132055.GT12198@hirez.programming.kicks-ass.net>
References: <1527857873.4674.11.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527857873.4674.11.camel@gmx.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 02:57:53PM +0200, Mike Galbraith wrote:
> b956575bed91ecfb136a8300742ecbbf451471ab is the first bad commit
> commit b956575bed91ecfb136a8300742ecbbf451471ab
> Author: Andy Lutomirski <luto@kernel.org>
> Date:   Mon Oct 9 09:50:49 2017 -0700
> 
>     x86/mm: Flush more aggressively in lazy TLB mode

Oh boy... Maybe we should start looking at that optimization Andy
mentioned.

IIRC all page freeing does indeed go through tlb_remove_page(), it
shouldn't be too hard to make that work.

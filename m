Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754431AbeDWJQw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:16:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754201AbeDWJQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:16:40 -0400
Date: Mon, 23 Apr 2018 11:16:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Diego Viola <diego.viola@gmail.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, len.brown@intel.com,
        rui.zhang@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Experiencing freezes with kernel 4.16.3 on a desktop with E5500
 CPU (bisect included)
Message-ID: <20180423091633.GU4064@hirez.programming.kicks-ass.net>
References: <CA+ToGPE59B0EKYkRbMcoddEtWwe50nXNu-91UMdjamz+s8nKfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ToGPE59B0EKYkRbMcoddEtWwe50nXNu-91UMdjamz+s8nKfg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2018 at 11:19:55PM -0300, Diego Viola wrote:

> The problem only happens *after* resuming from suspend, in normal S0
> state it never happens.

What kind of suspend are you doing? s2disk, s2ram ?

> My machine is a desktop and has a dual core E5500 CPU with 2GB of RAM,
> I run Arch Linux and I use the i3wm.

That's a Core2 era chip; does it actually have stable TSC ?

> aa83c45762a242acce9b35020363225a7b59d7c9 is the first bad commit

That is most curious; that was supposed to only affect early boot. I'll
try and figure out of there's some intersection with suspend.

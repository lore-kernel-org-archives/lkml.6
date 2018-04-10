Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752304AbeDJH4L (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:56:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52750 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751778AbeDJH4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:56:09 -0400
Date: Tue, 10 Apr 2018 09:55:48 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: yuankuiz@codeaurora.org
cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, fweisbec@gmail.com,
        peterz@infradead.org, aulmck@linux.vnet.ibm.com, mingo@kernel.org,
        len.brown@intel.com, linux-kernel@vger.kernel.org
Subject: Re: Subject: [PATCH] [PATCH] time: tick-sched: use bool for
 tick_stopped
In-Reply-To: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1804100946060.2058@nanos.tec.linutronix.de>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018, yuankuiz@codeaurora.org wrote:

> From: John Zhao <yuankuiz@codeaurora.org>
> 
> Variable tick_stopped returned by tick_nohz_tick_stopped
> can have only true / forse values. Since the return type
> of the tick_nohz_tick_stopped is also bool, variable
> tick_stopped nice to have data type as bool in place of int.

The data type is not int. It's part of an integer bitfield and occupies
exactly one bit of storage, while bool has an architecture dependend size
and is at least 1 byte, i.e. 8 bit. So with alignment effects you grew the
size of the data structure and therefore the cache foot print.

This is not about 'nice to have' ....

Thanks,

	tglx

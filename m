Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbeDIQS1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:18:27 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44236 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753231AbeDIQSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:18:21 -0400
X-Google-Smtp-Source: AIpwx4/FybrSrFNjPbFDmbk3XdDP4YxHoiVe277Gz2ANWocymB2Vig7FxacMkCgdHjoMwAd/Q+oQ7g==
Date: Mon, 9 Apr 2018 18:18:17 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick-sched: avoid a maybe-uninitialized warning
Message-ID: <20180409161817.bnmokplnoagyxwrc@gmail.com>
References: <20180409122339.1709840-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409122339.1709840-1-arnd@arndb.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnd Bergmann <arnd@arndb.de> wrote:

> The use of bitfields seems to confuse gcc, leading to a false-positive
> warning in all compiler versions:
> 
> kernel/time/tick-sched.c: In function 'tick_nohz_idle_exit':
> kernel/time/tick-sched.c:538:2: error: 'now' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This introduces a temporary variable to track the flags so gcc
> doesn't have to evaluate twice, eliminating the code path that
> leads to the warning.
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=85301
> Fixes: 1cae544d42d2 ("nohz: Gather tick_sched booleans under a common flag field")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Which tree is this against? There's no such commit either in -tip, upstream or in 
-next AFAICS.

Thanks,

	Ingo

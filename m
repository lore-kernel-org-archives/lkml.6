Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751142AbeBQK3D (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 05:29:03 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:57649 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeBQK3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 05:29:02 -0500
Date: Sat, 17 Feb 2018 11:27:00 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>
cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <kernellwp@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 2/6] nohz: Allow to check if remote CPU tick is stopped
In-Reply-To: <1518655694-8057-3-git-send-email-frederic@kernel.org>
Message-ID: <alpine.DEB.2.21.1802171125270.1473@nanos.tec.linutronix.de>
References: <1518655694-8057-1-git-send-email-frederic@kernel.org> <1518655694-8057-3-git-send-email-frederic@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018, Frederic Weisbecker wrote:

> This check is racy but provides a good heuristic to determine whether
> a CPU may need a remote tick or not.
> 

> +int tick_nohz_tick_stopped_cpu(int cpu)

s/int/bool/ but I'm not religious about that.

> +{
> +	struct tick_sched *ts = per_cpu_ptr(&tick_cpu_sched, cpu);
> +
> +	return ts->tick_stopped;
> +}

Other than that nit:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbeBQKxP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 05:53:15 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:57699 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbeBQKxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 05:53:14 -0500
Date: Sat, 17 Feb 2018 11:53:22 +0100 (CET)
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
Subject: Re: [PATCH 6/6] sched/isolation: Update nohz documentation to explain
 tick offload
In-Reply-To: <1518655694-8057-7-git-send-email-frederic@kernel.org>
Message-ID: <alpine.DEB.2.21.1802171152060.2087@nanos.tec.linutronix.de>
References: <1518655694-8057-1-git-send-email-frederic@kernel.org> <1518655694-8057-7-git-send-email-frederic@kernel.org>
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

> Update the documentation to reflect the 1Hz tick offload changes.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Chris Metcalf <cmetcalf@mellanox.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Luiz Capitulino <lcapitulino@redhat.com>
> Cc: Mike Galbraith <efault@gmx.de>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Wanpeng Li <kernellwp@gmail.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 1d1d53f..50b9837 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1766,6 +1766,17 @@
>  
>  			nohz
>  			  Disable the tick when a single task runs.
> +
> +			  A residual 1Hz tick is offloaded to workqueues, which you
> +			  need to affine to housekeeping through the global
> +			  workqueue's affinity configured via the
> +			  /sys/devices/virtual/workqueue/cpumask sysfs file, or
> +			  by using the 'domain' flag described below.
> +
> +			  NOTE: by default the global workqueue runs on all CPUs,
> +			  so to protect individual CPUs the 'cpumask' file has to
> +			  be configured manually after bootup.

Hmm. Why don't you set that to the housekeeping cpus by default?

Thanks,

	tglx

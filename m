Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeC3LSB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 07:18:01 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33498 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeC3LR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 07:17:59 -0400
X-Google-Smtp-Source: AIpwx4/bfmUNke/z1UtYb1NdlVsgxj6FuGhyGphIaivvOPVNnJToLwTta6UkrPw70RzZjILSdFIoBw==
Date: Fri, 30 Mar 2018 13:17:56 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v4 2/2] locking/debug: Restructure the lock debugging menu
Message-ID: <20180330111756.jvikchnxaeqkojao@gmail.com>
References: <1522246852-17501-1-git-send-email-longman@redhat.com>
 <1522246852-17501-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522246852-17501-3-git-send-email-longman@redhat.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> Two config options in the lock debugging menu that are probably the most
> frequently used, as far as I am concerned, is the PROVE_LOCKING and
> LOCK_STAT. From a UI perspective, they should be front and center. So
> these two options are now moved to the top of the lock debugging menu.
> 
> The DEBUG_WW_MUTEX_SLOWPATH option is also added to the PROVE_LOCKING
> umbrella.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  lib/Kconfig.debug | 146 ++++++++++++++++++++++++++++--------------------------
>  1 file changed, 76 insertions(+), 70 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 6aad28c..dc9ffe2 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1034,6 +1034,79 @@ config DEBUG_PREEMPT
>  
>  menu "Lock Debugging (spinlocks, mutexes, etc...)"
>  
> +config LOCK_DEBUGGING_SUPPORT
> +	bool
> +	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
> +	default y

Ok, this patch is a nice reorganization - but could we please split this into two 
patches, the first one adds the LOCK_DEBUGGING_SUPPORT helper, the other does the 
reordering of the entries (without changing anything in the entries)?

It's hard to review when the two steps are mixed up.

Thanks,

	Ingo

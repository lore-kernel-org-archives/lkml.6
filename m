Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbeBIGzt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 01:55:49 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35627 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbeBIGzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 01:55:48 -0500
X-Google-Smtp-Source: AH8x2248f9aZMoZJ0mpwp4L9dfEqkMTPilP88iyA8uF5u56PWw2/CHMUyd0hFDFp+2mHYOdbDWl6gg==
Date: Fri, 9 Feb 2018 07:55:44 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <kernellwp@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 3/6] sched/isolation: Isolate workqueues when
 "nohz_full=" is set
Message-ID: <20180209065544.6ywka67hwerdrtvt@gmail.com>
References: <1518112779-30196-1-git-send-email-frederic@kernel.org>
 <1518112779-30196-4-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518112779-30196-4-git-send-email-frederic@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Frederic Weisbecker <frederic@kernel.org> wrote:

> -	flags = HK_FLAG_TICK | HK_FLAG_TIMER | HK_FLAG_RCU | HK_FLAG_MISC;
> +	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER |
> +		HK_FLAG_RCU | HK_FLAG_MISC;

> -	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(HK_FLAG_DOMAIN));
> +	cpumask_copy(wq_unbound_cpumask,
> +		     housekeeping_cpumask(HK_FLAG_DOMAIN | HK_FLAG_WQ));

LGTM, but _please_ don't do these ugly line-breaks, just keep it slightly over 
col80.

Thanks,

	Ingo

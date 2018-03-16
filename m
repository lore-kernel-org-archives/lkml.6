Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753080AbeCPH7Q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:59:16 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54973 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbeCPH7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:59:15 -0400
Date: Fri, 16 Mar 2018 08:59:12 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
cc: linux-kernel@vger.kernel.org, sfr@canb.auug.org.au, mingo@elte.hu,
        peterz@infradead.org, jiangshanlai@gmail.com
Subject: Re: [PATCH] kernel/cpu: Move cpuhp_is_atomic_state() into #ifdef
 CONFIG_SMP
In-Reply-To: <20180316063852.22701-1-douly.fnst@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.21.1803160858290.1598@nanos.tec.linutronix.de>
References: <20180316063852.22701-1-douly.fnst@cn.fujitsu.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018, Dou Liyang wrote:

> Commit 17a2f1ced028 ("cpu/hotplug: Merge cpuhp_bp_states and cpuhp_ap_states")
> removed the last use of cpuhp_is_atomic_state() in common case, that caused
> Kernel produced a warning:
> 
>   'cpuhp_is_ap_state' defined but not used
> 
> So, Move it into #ifdef CONFIG_SMP

Thanks for the patch, but a fix is already queued in the smp/hotplug
branch. It just did not make it into the for-next branch yet,

Thanks,

	tglx

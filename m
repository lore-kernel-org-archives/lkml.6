Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F250BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0C121773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfBLIFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:05:53 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42547 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfBLIFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:05:53 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gtT4T-00045m-Qk; Tue, 12 Feb 2019 09:05:38 +0100
Date:   Tue, 12 Feb 2019 09:05:37 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Aubrey Li <aubrey.li@intel.com>
cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [PATCH v9 1/3] /proc/pid/status: Add support for architecture
 specific output
In-Reply-To: <20190211185931.4386-1-aubrey.li@intel.com>
Message-ID: <alpine.DEB.2.21.1902120904410.1654@nanos.tec.linutronix.de>
References: <20190211185931.4386-1-aubrey.li@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019, Aubrey Li wrote:

> The architecture specific information of the running processes could
> be useful to the userland. Add support to examine process architecture
> specific information externally.
> 
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  fs/proc/array.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 0ceb3b6b37e7..d8cb5b5fd7bb 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -392,6 +392,10 @@ static inline void task_core_dumping(struct seq_file *m, struct mm_struct *mm)
>  	seq_putc(m, '\n');
>  }
>  
> +void __weak arch_proc_pid_status(struct seq_file *m, struct task_struct *task)
> +{
> +}

This still lacks a prototype.

Thanks,

	tglx

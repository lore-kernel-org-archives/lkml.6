Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeCLHxN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:53:13 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33887 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751368AbeCLHxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:53:11 -0400
X-Google-Smtp-Source: AG47ELtgIPHCWSwnxRQDtJRy135c82WOzMcc91X7DSfNVriI+EOYaxlLrVpYYHWcxVXKu9j0Rc2LKQ==
Date: Mon, 12 Mar 2018 08:53:07 +0100
From: Ingo Molnar <mingo@kernel.org>
To: linxiulei@gmail.com
Cc: peterz@infradead.org, jolsa@redhat.com, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, eranian@gmail.com,
        torvalds@linux-foundation.org, linux-perf-users@vger.kernel.org,
        brendan.d.gregg@gmail.com, yang_oliver@hotmail.com,
        "leilei.lin" <leilei.lin@alibaba-inc.com>
Subject: Re: [PATCH RESEND v5] perf/core: Fix installing arbitrary cgroup
 event into cpu
Message-ID: <20180312075307.iut52znscixqcpag@gmail.com>
References: <20180306093637.28247-1-linxiulei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306093637.28247-1-linxiulei@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* linxiulei@gmail.com <linxiulei@gmail.com> wrote:

>  	/*
>  	 * Because cgroup events are always per-cpu events,
>  	 * this will always be called from the right CPU.
>  	 */

> +	/*
> +	 * if only the cgroup is running on this cpu
> +	 * and cpuctx->cgrp == NULL (otherwise it would've
> +	 * been set with running cgroup), we put this cgroup
> +	 * into cpu context. Or it would case mismatch in
> +	 * following cgroup events at event_filter_match()
> +	 */

Beyond making sure that what you comment on makes sense, please also follow 
existing comment style, which I quoted above.

There's 3 separate mistakes in that paragraph alone.

Thanks,

	Ingo

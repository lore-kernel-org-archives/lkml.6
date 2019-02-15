Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E996EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12B721B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550243300;
	bh=JcWIUV3G9suOgOWHwwDpYB4/7zZ3Lw2gJmVL0ZFL5vQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=e1P2NulM0W0Aa/uuY3beF9cyOePRYRAHX18fXze2vxJQYGL+dLmZEZfUurM/DW/1P
	 G1/58Bfe8ALJz1b1ap5rcu6U2UW0gfjcWanrwuMbZOBPN0I9xVEiZsQR2WAryebUZJ
	 Iw65dUt9OJN3d3cO3oM48vLiFOd87vgjsCENkxpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388076AbfBOPIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:08:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfBOPIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:08:18 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC72821A4C;
        Fri, 15 Feb 2019 15:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550243297;
        bh=JcWIUV3G9suOgOWHwwDpYB4/7zZ3Lw2gJmVL0ZFL5vQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j3LUOUWnPr950rMsI/U5jBtvc7YOrqObNNtgXFYZazBDR55HnI2nOZGmD+Qq0t5gy
         QkR8PYXc21GiMh4/iFC+jpz7V/a5HbvSC+wX/tKHX7RQTGtc/u4DGqPnXppDlTjnfx
         NPZfUzL3WdlwNT42LHUd1dYzHaRn99G9LDNwBpbM=
Date:   Sat, 16 Feb 2019 00:08:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v15 15/15] tracing: Add hist trigger action 'expected
 fail' test case
Message-Id: <20190216000814.c76e09f4b7597e6892326524@kernel.org>
In-Reply-To: <1790bf93e01dbdfa1b4af945f42147d92bd565aa.1550100284.git.tom.zanussi@linux.intel.com>
References: <cover.1550100284.git.tom.zanussi@linux.intel.com>
        <1790bf93e01dbdfa1b4af945f42147d92bd565aa.1550100284.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Wed, 13 Feb 2019 17:42:55 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Add a test case verifying that basic action combinations fail as
> expected.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> ---
>  .../inter-event/trigger-action-hist-xfail.tc       | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
> new file mode 100644
> index 000000000000..1221240f8cf6
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test inter-event histogram trigger expected fail actions
> +
> +fail() { #msg
> +    echo $1
> +    exit_fail
> +}
> +
> +if [ ! -f set_event ]; then
> +    echo "event tracing is not supported"
> +    exit_unsupported
> +fi
> +
> +if [ ! -f snapshot ]; then
> +    echo "snapshot is not supported"
> +    exit_unsupported
> +fi
> +
> +grep -q "snapshot()" README || exit_unsupported # version issue
> +
> +echo "Test expected snapshot action failure"
> +
> +echo 'hist:keys=comm:onmatch(sched.sched_wakeup).snapshot()' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger && exit_fail
> +
> +echo "Test expected save action failure"
> +
> +echo 'hist:keys=comm:onmatch(sched.sched_wakeup).save(comm,prio)' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger && exit_fail
> +
> +exit_xfail
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

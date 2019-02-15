Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E76FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1B121B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550243183;
	bh=HoZyA14Q7i5wFTseKpWLtwAYij2fOXvU2OakNb1OTp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EW9Fm/ExTWamdhHUbYXI3wX9c7R8QwReoB6ug4cXWFisu9Fz2rxLThSsO7x8n8F81
	 XSHvDZJnNpsEupKgrN85CliT+/MoVy6P5lb3jJ+e+wN1Fm9mKV7eJTP+tzTXf6pjws
	 Ny0OoGxNvyvz3V15MWKMh/NhRJdKJ+uW4cv5HrUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733254AbfBOPGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:06:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:40984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfBOPGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:06:21 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA2A921A4C;
        Fri, 15 Feb 2019 15:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550243180;
        bh=HoZyA14Q7i5wFTseKpWLtwAYij2fOXvU2OakNb1OTp0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DnbpFiGJS7ZQV9kHkNRSoN2/UOE+gjnj+zuNPxt400E90hIhKV5uqtO5Bl61Ew71J
         1Z73kYrxz+ac9M8GowXDpIXHaexq2t71sbl1qr+r0u3cxot8x04jZDIvn5+lmEULKE
         f3CRJyRHluqKdttyJestaJd7pYOcndEJvsLsfW9s=
Date:   Sat, 16 Feb 2019 00:06:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v15 14/15] tracing: Add alternative synthetic event
 trace action test case
Message-Id: <20190216000617.2b3e80357f0bef490cfe6c83@kernel.org>
In-Reply-To: <0616d18423ab1dfdbf333bce9c92ac4fa0779207.1550100284.git.tom.zanussi@linux.intel.com>
References: <cover.1550100284.git.tom.zanussi@linux.intel.com>
        <0616d18423ab1dfdbf333bce9c92ac4fa0779207.1550100284.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Wed, 13 Feb 2019 17:42:54 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Add a test case for the alternative trace(<synthetic_event, params)
> synthetic event generation syntax.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> ---
>  .../inter-event/trigger-trace-action-hist.tc       | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
> new file mode 100644
> index 000000000000..8021d60aafec
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
> @@ -0,0 +1,42 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test inter-event histogram trigger trace action
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
> +if [ ! -f synthetic_events ]; then
> +    echo "synthetic event is not supported"
> +    exit_unsupported
> +fi
> +
> +grep -q "trace(<synthetic_event>" README || exit_unsupported # version issue
> +
> +echo "Test create synthetic event"
> +
> +echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
> +if [ ! -d events/synthetic/wakeup_latency ]; then
> +    fail "Failed to create wakeup_latency synthetic event"
> +fi
> +
> +echo "Test create histogram for synthetic event using trace action"
> +echo "Test histogram variables,simple expression support and trace action"
> +
> +echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_wakeup/trigger
> +echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_wakeup).trace(wakeup_latency,$wakeup_lat,next_pid,next_comm) if next_comm=="ping"' > events/sched/sched_switch/trigger
> +echo 'hist:keys=comm,pid,lat:wakeup_lat=lat:sort=lat' > events/synthetic/wakeup_latency/trigger
> +
> +ping $LOCALHOST -c 5
> +
> +if ! grep -q "ping" events/synthetic/wakeup_latency/hist; then
> +    fail "Failed to create trace action inter-event histogram"
> +fi
> +
> +exit 0
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

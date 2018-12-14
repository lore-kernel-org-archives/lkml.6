Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F834C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004A92070B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544804296;
	bh=opDQ6fraEdycLw9KDkAOlfQb/CxUQrBBV3z3lRLN574=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=P7i6df/POfx2VE9Ca9ImhLrNgsNZt5kRC5LMn/0J32wbpRPOUgtoJDc2EV4uv1pU3
	 9xTI09a5YwbYwFBkcs3PnGK58AspH8r9QZB9F70UuyhFXX2CP+AkQIGzGyZRXikC5q
	 c3xY6OvKrt9Zf/r5cUUAYddQ2/hGNXiRy1Hsl2w4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbeLNQSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:18:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:45266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbeLNQSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:18:13 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46CA5206E0;
        Fri, 14 Dec 2018 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544804293;
        bh=opDQ6fraEdycLw9KDkAOlfQb/CxUQrBBV3z3lRLN574=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OjaH0fTMn/f6K0jdPiKtnJnYjWEawCUxiscOcgRq3Cx4gE02lFnfskaOoPaZG+iku
         bpuImNnAlzKB7EF5Wq2/i0KirI5WHRKlkuUmftdP/Xuj6boA1uccdVo0npQaEIUK/e
         cshz0/LVNnGop36Br8viXcAkx40q+xyBoS0hVWpY=
Date:   Sat, 15 Dec 2018 01:18:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v8 12/22] tracing: Add hist trigger onchange() handler
 test case
Message-Id: <20181215011810.61e1009d133fc1f999534d72@kernel.org>
In-Reply-To: <86f8570a993bd8b70e7d8a0260706736b59da2ea.1544483273.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
        <86f8570a993bd8b70e7d8a0260706736b59da2ea.1544483273.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 18:01:26 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Add a test case verifying the basic functionality of the
> hist:onchange($var) handler.

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

BTW, could you sort these test patches at the end of this series?
(or at least after 2 features? since both depends on new onchange(var) feature)

Thank you,

> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  .../inter-event/trigger-onchange-action-hist.tc    | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
> new file mode 100644
> index 000000000000..064a284e4e75
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
> @@ -0,0 +1,28 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test inter-event histogram trigger onchange action
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
> +grep -q "onchange(var)" README || exit_unsupported # version issue
> +
> +echo "Test onchange action"
> +
> +echo 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio) if comm=="ping"' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
> +
> +ping $LOCALHOST -c 3
> +nice -n 1 ping $LOCALHOST -c 3
> +
> +if ! grep -q "changed:" events/sched/sched_waking/hist; then
> +    fail "Failed to create onchange action inter-event histogram"
> +fi
> +
> +exit 0
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

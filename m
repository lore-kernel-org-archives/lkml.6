Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ED6C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6B72641F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zD43EvFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6B72641F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965028AbeF0MVe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 08:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964988AbeF0MVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 08:21:32 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC09A2640F;
        Wed, 27 Jun 2018 12:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530102092;
        bh=WJHDU4BLzumQ2Ee3raU+ghre3u7TFdCoAA7x2B7Y3dM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zD43EvFD2T3DkRUKYsMxaRJD1y6loBnH7yZkX/Zu94DT5WmN+1XHxaABXlLzSxE2i
         IGEgHlKrHTdExBkC+MF/AM7sE4MFj/KAAMl8UtNmAElCTC23ayWUvwxuJ4TUvjWHll
         LsWnPBffhV8QRGwOUsxek3Byhrd/ishI7FOF+HH4=
Date:   Wed, 27 Jun 2018 21:21:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v9 7/7] kselftests: Add tests for the preemptoff and
 irqsoff tracers
Message-Id: <20180627212127.e05d66b4f5d11b20d0364375@kernel.org>
In-Reply-To: <20180625162102.GA49367@joelaf.mtv.corp.google.com>
References: <20180621223236.211495-1-joel@joelfernandes.org>
        <20180621223236.211495-8-joel@joelfernandes.org>
        <20180625221302.8507c98e500d8efc70c19d88@kernel.org>
        <20180625162102.GA49367@joelaf.mtv.corp.google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018 09:21:02 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:


> 
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH v9.1 7/7] kselftests: Add tests for the preemptoff and irqsoff
>  tracers
> 
> Here we add unit tests for the preemptoff and irqsoff tracer by using a
> kernel module introduced previously to trigger atomic sections in the
> kernel.
> 

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  tools/testing/selftests/ftrace/config         |  3 +
>  .../test.d/preemptirq/irqsoff_tracer.tc       | 74 +++++++++++++++++++
>  2 files changed, 77 insertions(+)
>  create mode 100755 tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> 
> diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
> index b01924c71c09..29588b328345 100644
> --- a/tools/testing/selftests/ftrace/config
> +++ b/tools/testing/selftests/ftrace/config
> @@ -4,3 +4,6 @@ CONFIG_FUNCTION_PROFILER=y
>  CONFIG_TRACER_SNAPSHOT=y
>  CONFIG_STACK_TRACER=y
>  CONFIG_HIST_TRIGGERS=y
> +CONFIG_PREEMPT_TRACER=y
> +CONFIG_IRQSOFF_TRACER=y
> +CONFIG_TEST_ATOMIC_SECTIONS=m
> diff --git a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> new file mode 100755
> index 000000000000..2dcd5e4cafb4
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> @@ -0,0 +1,74 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: test for the preemptirqsoff tracer
> +
> +MOD=test_atomic_sections
> +
> +fail() {
> +    reset_tracer
> +    rmmod $MOD || true
> +    exit_fail
> +}
> +
> +unsup() { #msg
> +    reset_tracer
> +    rmmod $MOD || true
> +    echo $1
> +    exit_unsupported
> +}
> +
> +modprobe $MOD || unsup "$MOD module not available"
> +rmmod $MOD
> +
> +grep -q "preemptoff" available_tracers || unsup "preemptoff tracer not enabled"
> +grep -q "irqsoff" available_tracers || unsup "irqsoff tracer not enabled"
> +
> +reset_tracer
> +
> +# Simulate preemptoff section for half a second couple of times
> +echo preemptoff > current_tracer
> +sleep 1
> +modprobe $MOD atomic_mode=preempt atomic_time=500000 || fail
> +rmmod $MOD || fail
> +modprobe $MOD atomic_mode=preempt atomic_time=500000 || fail
> +rmmod $MOD || fail
> +modprobe $MOD atomic_mode=preempt atomic_time=500000 || fail
> +rmmod $MOD || fail
> +
> +cat trace
> +
> +# Confirm which tracer
> +grep -q "tracer: preemptoff" trace || fail
> +
> +# Check the end of the section
> +egrep -q "5.....us : <stack trace>" trace || fail
> +
> +# Check for 500ms of latency
> +egrep -q "latency: 5..... us" trace || fail
> +
> +reset_tracer
> +
> +# Simulate irqsoff section for half a second couple of times
> +echo irqsoff > current_tracer
> +sleep 1
> +modprobe $MOD atomic_mode=irq atomic_time=500000 || fail
> +rmmod $MOD || fail
> +modprobe $MOD atomic_mode=irq atomic_time=500000 || fail
> +rmmod $MOD || fail
> +modprobe $MOD atomic_mode=irq atomic_time=500000 || fail
> +rmmod $MOD || fail
> +
> +cat trace
> +
> +# Confirm which tracer
> +grep -q "tracer: irqsoff" trace || fail
> +
> +# Check the end of the section
> +egrep -q "5.....us : <stack trace>" trace || fail
> +
> +# Check for 500ms of latency
> +egrep -q "latency: 5..... us" trace || fail
> +
> +reset_tracer
> +exit 0
> +
> -- 
> 2.18.0.rc2.346.g013aa6912e-goog
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

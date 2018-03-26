Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeCZUsk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 16:48:40 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44391 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeCZUsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 16:48:39 -0400
X-Google-Smtp-Source: AG47ELsbbiYUQsy+UQqK6Hlq7ARBDJVaCEbt8lf/LV+6gc7sT5T7US1ZLKcM8wGFYTzIt/+ukPpM5g==
Date: Mon, 26 Mar 2018 13:48:36 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH] tracepoint: Provide tracepoint_kernel_find_by_name
Message-ID: <20180326204834.npkr26bdf5aprwnv@ast-mbp.dhcp.thefacebook.com>
References: <20180326191031.14939-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326191031.14939-1-mathieu.desnoyers@efficios.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 03:10:31PM -0400, Mathieu Desnoyers wrote:
> Provide an API allowing eBPF to lookup core kernel tracepoints by name.
> 
> Given that a lookup by name explicitly requires tracepoint definitions
> to be unique for a given name (no duplicate keys), include a
> WARN_ON_ONCE() check that only a single match is encountered at runtime.
> This should always be the case, given that a DEFINE_TRACE emits a
> __tracepoint_##name symbol, which would cause a link-time error if more
> than one instance is found. Nevertheless, check this at runtime with
> WARN_ON_ONCE() to stay on the safe side.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Alexei Starovoitov <ast@kernel.org>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Ingo Molnar <mingo@kernel.org>

Mathieu, that's not enough.
Commit log is also wrong.
It needs to state that something like this is needed only because
changing for_each_tracepoint_range() semantics will break lttng.
I'll post a follow up patch shortly.

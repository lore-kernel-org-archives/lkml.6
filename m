Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753220AbeBFTII (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:08:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753057AbeBFTHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:07:55 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0780A214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 6 Feb 2018 16:07:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 06/17] tools lib symbol: Skip non-address kallsyms line
Message-ID: <20180206190753.GD3451@kernel.org>
References: <20180206181813.10943-1-jolsa@kernel.org>
 <20180206181813.10943-7-jolsa@kernel.org>
 <20180206190649.GC3451@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206190649.GC3451@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 06, 2018 at 04:06:49PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Feb 06, 2018 at 07:18:02PM +0100, Jiri Olsa escreveu:
> > Adding check on failed attempt to parse the address
> > and skip the line parsing early in that case.
> 
> How did you stumble on that? Can you provide an example of a line or
> situation where this would happen?

Something like this:

[acme@jouet perf]$ cat /proc/kallsyms  | head
          (null) A irq_stack_union
          (null) A __per_cpu_start
          (null) A cpu_debug_store
          (null) A cpu_tss_rw
          (null) A gdt_page
          (null) A exception_stacks
          (null) A entry_stack_storage
          (null) A espfix_waddr
          (null) A espfix_stack
          (null) A cpu_llc_id
[acme@jouet perf]$ id
uid=1000(acme) gid=1000(acme) groups=1000(acme),10(wheel),18(dialout),54(lock) context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
[acme@jouet perf]$

?

- Arnaldo

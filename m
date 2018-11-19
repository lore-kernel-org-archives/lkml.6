Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A85C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76A420851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ea7DiH7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76A420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeKSU5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:57:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34238 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbeKSU5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yEH3NVk5Sy4OrpXgt9O8LXlqToyXL9vqKV94leohspQ=; b=Ea7DiH7Iok2muje/jruSBNErp
        EoUfr+tXaD1kTSHT83B90uf9x+yzCWOhYmA0tn5AOZgFfIdrzMcSS1ZSyBv20jdQ/j8Yx5pk8RErx
        tP1qHKmi26ayJBKbgsZWjV5uA0Zuzd8xKhH9VvVemmMqbZ6R2rDUvp/fzYiCo+xWi8PeVWwlnnZAD
        brBrN5tFZ8jlA15z3jx5th1Aq4KFqF66ZPO+/8gbGh8AvbUFf5nySCnNC0rRzMxABFmQ+2llqNY6J
        AR/6rWAkacBP/BmYX6iHG8klC0ki1FdDmGYLvkSnlV3rCvEhsLxtjtv1Rb77LSPBY0hluSBZG0Qna
        ilel+K/zA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOgs7-0003SY-O8; Mon, 19 Nov 2018 10:33:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 279F420298C0C; Mon, 19 Nov 2018 11:33:37 +0100 (CET)
Date:   Mon, 19 Nov 2018 11:33:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jonatan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 2/2]: Documentation/admin-guide: introduce
 perf-security.rst file
Message-ID: <20181119103337.GZ9761@hirez.programming.kicks-ass.net>
References: <0ac97cd0-4773-fff6-7d4e-74c4a1f076c4@linux.intel.com>
 <a44df303-d962-c1a4-4fe0-6bad887ebcdc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44df303-d962-c1a4-4fe0-6bad887ebcdc@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 08:42:52AM +0300, Alexey Budankov wrote:
> 
> Implement initial version of perf-security.rst documentation file 
> initially covering security concerns related to PCL/Perf performance 
> monitoring in multiuser environments.

Ditch the PCL thing. That's not a term used anywhere in the kernel.

Also:

> +PCL/Perf unprivileged users
> +---------------------------
> +
> +PCL/Perf *scope* and *access* control for unprivileged processes is governed by
> +perf_event_paranoid [2]_ setting:
> +
> +**-1**:
> +     Impose no *scope* and *access* restrictions on using PCL performance
> +     monitoring. Per-user per-cpu perf_event_mlock_kb [2]_ locking limit is
> +     ignored when allocating memory buffers for storing performance data.
> +     This is the least secure mode since allowed monitored *scope* is
> +     maximized and no PCL specific limits are imposed on *resources*
> +     allocated for performance monitoring.
> +
> +**>=0**:
> +     *scope* includes per-process and system wide performance monitoring
> +     but excludes raw tracepoints and ftrace function tracepoints monitoring.
> +     CPU and system events happened when executing either in user or
> +     in kernel space can be monitored and captured for later analysis.
> +     Per-user per-cpu perf_event_mlock_kb locking limit is imposed but
> +     ignored for unprivileged processes with CAP_IPC_LOCK [6]_ capability.
> +
> +**>=1**:
> +     *scope* includes per-process performance monitoring only and excludes
> +     system wide performance monitoring. CPU and system events happened when
> +     executing either in user or in kernel space can be monitored and
> +     captured for later analysis. Per-user per-cpu perf_event_mlock_kb
> +     locking limit is imposed but ignored for unprivileged processes with
> +     CAP_IPC_LOCK capability.
> +
> +**>=2**:
> +     *scope* includes per-process performance monitoring only. CPU and system
> +     events happened when executing in user space only can be monitored and
> +     captured for later analysis. Per-user per-cpu perf_event_mlock_kb
> +     locking limit is imposed but ignored for unprivileged processes with
> +     CAP_IPC_LOCK capability.
> +
> +**>=3**:
> +     Restrict *access* to PCL performance monitoring for unprivileged processes.
> +     This is the default on Debian and Android [7]_ , [8]_ .

that ** crud is unreadable.

http://lkml.kernel.org/r/094556ca-ea87-9c4a-2115-600d2833fb2a@darmarit.de

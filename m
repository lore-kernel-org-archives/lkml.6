Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0203C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A170921564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A170921564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeHYDEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 23:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbeHYDEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 23:04:48 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7800A21557;
        Fri, 24 Aug 2018 23:28:02 +0000 (UTC)
Date:   Fri, 24 Aug 2018 19:28:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 27/32] selftests/ftrace: Add stacktrace ftrace filter
 command testcase
Message-ID: <20180824192800.04290c1e@gandalf.local.home>
In-Reply-To: <153443771560.23257.1531051659949223265.stgit@devbox>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443771560.23257.1531051659949223265.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 01:41:55 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add a test case for stacktrace filter command for ftrace.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
> new file mode 100644
> index 000000000000..ec0d8216d509
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
> @@ -0,0 +1,12 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL2.0
> +# description: ftrace - stacktrace filter command

Add:

 # flags: instance

> +
> +echo _do_fork:stacktrace >> set_ftrace_filter
> +
> +grep -q "_do_fork:stacktrace:unlimited" set_ftrace_filter
> +
> +(echo "forked"; sleep 1)
> +
> +grep -q "<stack trace>" trace

> +

Can remove the extra line.

-- Steve

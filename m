Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1172CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1E62087E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfANQRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:17:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:48618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfANQRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:17:00 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CA5420873;
        Mon, 14 Jan 2019 16:16:59 +0000 (UTC)
Date:   Mon, 14 Jan 2019 11:16:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>
Subject: Re: [PATCH v2 5/9] kprobes: Search non-suffixed symbol in blacklist
Message-ID: <20190114111657.639a3bf8@gandalf.local.home>
In-Reply-To: <154726008226.18060.9082091974811290044.stgit@devbox>
References: <154725993986.18060.2759150647140353514.stgit@devbox>
        <154726008226.18060.9082091974811290044.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jan 2019 11:28:02 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Newer gcc can generate some different instances of a function
> with suffixed symbols if the function is optimized and only
> has a part of that. (e.g. .constprop, .part etc.)
> 
> In this case, it is not enough to check the entry of kprobe
> blacklist because it only records non-suffixed symbol address.
> 
> To fix this issue, search non-suffixed symbol in blacklist if
> given address is within a symbol which has a suffix.
> 
> Note that this can cause false positive cases if a kprobe-safe
> function is optimized to suffixed instance and has same name
> symbol which is blacklisted.
> But I would like to chose a fail-safe design for this issue.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


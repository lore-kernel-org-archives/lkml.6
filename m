Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F6EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A14621873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545222470;
	bh=58nnNtloidHk4jKG/yQsWKwSvlxZzEIlvua7J1EyEGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=E5IurZtZuGHwzmlqP3vnn5CXeyfZ9quC793v/SH9hS68B+pXuW80SoMTP2Ku4N+4m
	 r8BjP1D0RVFMQTo19R3emyDGbB6bhVlxbSyaugDLrk5jamQoiWINq6ErLu3fOZXV3T
	 dQ2jfH7AbIKZ20HxGDfzhAEDaLIUPzCiY580SrQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbeLSM1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:27:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728763AbeLSM1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:27:43 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5A7A204FD;
        Wed, 19 Dec 2018 12:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545222462;
        bh=58nnNtloidHk4jKG/yQsWKwSvlxZzEIlvua7J1EyEGk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lsUMunNJZ6A9m0WD3yQ85jdSlLpEs5kF0RbJ5UJP96T0acSa0yHO99lhsVpUBmd1e
         pE6TDbHJ3fvJEqmEnTZXkfgnX4jFQx93of/WEiAFNXC5LzI4mxMB5oH+1RvqjE1VVy
         tkkzsgBcxgNRhMLeaOzTOAMMliJvj5n/7p0iwuWg=
Date:   Wed, 19 Dec 2018 21:27:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 0/7] tracing: Hist trigger var-ref cleanup and comments
Message-Id: <20181219212739.d5ec4edf7443c3dc1448c8d2@kernel.org>
In-Reply-To: <cover.1545161087.git.tom.zanussi@linux.intel.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Tue, 18 Dec 2018 14:33:19 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Hi,
> 
> This patchset is a standalone series broken out of the v8 version of
> the 'tracing: Hist trigger snapshot and onchange additions' patchset.
> 
> It's a series of changes resulting from some suggestions from Namhyung
> for making the variable-reference handling code more understandable
> through some refactoring and comments.
> 
> It also added a new patch changing all strlen() to sizeof() for string
> constants, in trace_events_hist.c
> 
> Also, in the 'tracing: Remove open-coding of hist trigger var_ref
> management' patch, in create_var_ref(), moved the saving of ref_field
> and update of ref_field->var_ref_idx into the 'if' as pointed out by
> Dan Carpenter/smatch 0-day robot.
> 
> It doesn't introduce any functional changes and can be applied
> independently of the other patchset.

OK, now it is very clear to me :-)

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

for the series.

Thank you,



> 
> Tom
> 
> 
> The following changes since commit 5d6ddf6acce68d1290112cb08b12fd78b201e7d5:
> 
>   arm64: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack (2018-12-08 22:21:31 -0500)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/hist-var-ref-cleanup-v1
> 
> Tom Zanussi (7):
>   tracing: Remove unnecessary hist trigger struct field
>   tracing: Change strlen to sizeof for hist trigger static strings
>   tracing: Use var_refs[] for hist trigger reference checking
>   tracing: Remove open-coding of hist trigger var_ref management
>   tracing: Use hist trigger's var_ref array to destroy var_refs
>   tracing: Remove hist trigger synth_var_refs
>   tracing: Add hist trigger comments for variable-related fields
> 
>  kernel/trace/trace_events_hist.c | 267 +++++++++++++++++++++++----------------
>  1 file changed, 156 insertions(+), 111 deletions(-)
> 
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

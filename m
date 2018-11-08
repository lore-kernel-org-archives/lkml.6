Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540D9ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138742081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138742081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeKIEV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:21:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbeKIEV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:21:56 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B7FC204FD;
        Thu,  8 Nov 2018 18:45:08 +0000 (UTC)
Date:   Thu, 8 Nov 2018 13:45:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     vincent@bernat.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tracing: Fix NULL pointer bug in hist key
 expressions
Message-ID: <20181108134507.2c343e6b@gandalf.local.home>
In-Reply-To: <cover.1541687121.git.tom.zanussi@linux.intel.com>
References: <cover.1541687121.git.tom.zanussi@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Nov 2018 08:41:47 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Hi Steve,
> 
> This is a fix for a user-reported bug in the hist triggers, where if a
> variable reference is used in an expression in a histogram key, it
> results in a NULL pointer dereference and subsequent Oops.

How does one add a variable reference as an expression in a
histogram key?

Can you show an example?

-- Steve

> 
> I separated the fix into two small patches, the first preventing the
> immediate problem bu disallowing a var_ref from ever accessing a NULL
> element, and the second disallowing a user from ever constructing such
> a key.
> 
> Thanks,
> 
> Tom
> 
> The following changes since commit ee474b81fe5aa5dc0faae920bf66240fbf55f891:
> 
>   tracing/kprobes: Fix strpbrk() argument order (2018-11-05 09:47:14 -0500)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/key-ref-fix
> 
> Tom Zanussi (2):
>   tracing: Prevent hist_field_var_ref() from accessing NULL
>     tracing_map_elts
>   tracing: Check keys for variable references in expressions too
> 
>  kernel/trace/trace_events_hist.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 


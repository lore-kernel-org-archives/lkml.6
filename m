Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80C9C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8929B20671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8929B20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbeGZSBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:01:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730197AbeGZSBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:01:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01EDE400E9A3;
        Thu, 26 Jul 2018 16:43:54 +0000 (UTC)
Received: from treble (ovpn-120-3.rdu2.redhat.com [10.10.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADF802142F20;
        Thu, 26 Jul 2018 16:43:53 +0000 (UTC)
Date:   Thu, 26 Jul 2018 11:43:52 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCH] tracing/kprobes: Simplify the logic of
 enable_trace_kprobe()
Message-ID: <20180726164352.tctldcryo4fs3nap@treble>
References: <20180726121152.4dd54330@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180726121152.4dd54330@gandalf.local.home>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 26 Jul 2018 16:43:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 26 Jul 2018 16:43:54 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 12:11:52PM -0400, Steven Rostedt wrote:
> 
> [ Note this is applied on top of the other patch to quiet gcc ]
> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The function enable_trace_kprobe() performs slightly differently if the file
> parameter is passed in as NULL on non-NULL. Instead of checking file twice,
> move the code between the two tests into a static inline helper function to
> make the code easier to follow.
> 
> Link: http://lkml.kernel.org/r/20180725224728.7b1d5db2@vmware.local.home
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

The enable_probe() name is a bit confusing, since it's not clear what
the difference is between enable_probe() and enable_trace_kprobe()
without looking at the code.

Maybe call it __enable_trace_kprobe()?

Otherwise it's a definite improvement.

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

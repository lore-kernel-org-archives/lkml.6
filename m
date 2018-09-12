Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A826FC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50013206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50013206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeILI5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 04:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbeILI5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 04:57:19 -0400
Received: from vmware.local.home (unknown [184.48.106.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE09B20839;
        Wed, 12 Sep 2018 03:54:47 +0000 (UTC)
Date:   Tue, 11 Sep 2018 23:54:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
        Kunxun Xie <xiekunxun@huawei.com>
Subject: Re: [Question] Are the trace APIs declared by
 "TRACE_EVENT(irq_handler_entry" allowed to be used in Ko?
Message-ID: <20180911235445.3f361575@vmware.local.home>
In-Reply-To: <5B987525.9070300@huawei.com>
References: <5B987525.9070300@huawei.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018 10:08:37 +0800
"Leizhen (ThunderTown)" <thunder.leizhen@huawei.com> wrote:

> After patch 7e066fb870fc ("tracepoints: add DECLARE_TRACE() and DEFINE_TRACE()"),
> the trace APIs declared by "TRACE_EVENT(irq_handler_entry" can not be directly used
> by ko, because it's not explicitly exported by EXPORT_TRACEPOINT_SYMBOL_GPL or
> EXPORT_TRACEPOINT_SYMBOL.
> 
> Did we miss it? or it's not recommended to be used in ko?
> 

Why do you need it. This patch is almost 10 years old, and you are just
now finding an issue with it?

-- Steve

> 
> -------------
> 
> commit 7e066fb870fcd1025ec3ba7bbde5d541094f4ce1
> Author: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> Date:   Fri Nov 14 17:47:47 2008 -0500
> 
>     tracepoints: add DECLARE_TRACE() and DEFINE_TRACE()
> 
>     Impact: API *CHANGE*. Must update all tracepoint users.
> 
>     Add DEFINE_TRACE() to tracepoints to let them declare the tracepoint
>     structure in a single spot for all the kernel. It helps reducing memory
>     consumption, especially when declaring a lot of tracepoints, e.g. for
>     kmalloc tracing.
> 
>     *API CHANGE WARNING*: now, DECLARE_TRACE() must be used in headers for
>     tracepoint declarations rather than DEFINE_TRACE(). This is the sane way
>     to do it. The name previously used was misleading.
> 
>     Updates scheduler instrumentation to follow this API change.
> 
> 


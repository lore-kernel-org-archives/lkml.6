Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFB6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B65E206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B65E206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeK2BG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:06:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:35496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbeK2BG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:06:56 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8533B208E7;
        Wed, 28 Nov 2018 14:05:09 +0000 (UTC)
Date:   Wed, 28 Nov 2018 09:05:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     akpm@linux-foundation.org, dvyukov@google.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] kernel/kcov.c: mark funcs in
 __sanitizer_cov_trace_pc as notrace
Message-ID: <20181128090507.41791fe7@gandalf.local.home>
In-Reply-To: <20181128081239.18317-1-anders.roxell@linaro.org>
References: <20181128081239.18317-1-anders.roxell@linaro.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 09:12:39 +0100
Anders Roxell <anders.roxell@linaro.org> wrote:

> Since __sanitizer_cov_trace_pc is marked as notrace, function calls in
> __sanitizer_cov_trace_pc shouldn't be traced either. The function
> ftrace_graph_caller() gets called for each function that isn't marked
> 'notrace', like canonicalize_ip(). This is the call trace from a run:
> 
> [  139.644550]  ftrace_graph_caller+0x1c/0x24
> [  139.648352]  canonicalize_ip+0x18/0x28
> [  139.652313]  __sanitizer_cov_trace_pc+0x14/0x58
> [  139.656184]  sched_clock+0x34/0x1e8
> [  139.659759]  trace_clock_local+0x40/0x88
> [  139.663722]  ftrace_push_return_trace+0x8c/0x1f0
> [  139.667767]  prepare_ftrace_return+0xa8/0x100
> [  139.671709]  ftrace_graph_caller+0x1c/0x24
> 
> Rework so that the functions check_kcov_mode and canonicalize_ip that is
> callef from __sanitizer_cov_trace_pc also is marked as notrace.
> 
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signen-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

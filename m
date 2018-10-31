Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4134EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38BD20685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38BD20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbeJaUnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 16:43:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbeJaUnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 16:43:10 -0400
Received: from vmware.local.home (unknown [217.16.13.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7434020685;
        Wed, 31 Oct 2018 11:45:27 +0000 (UTC)
Date:   Wed, 31 Oct 2018 07:45:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 0/3] tracing: a few simplifying patches
Message-ID: <20181031074457.103f0860@vmware.local.home>
In-Reply-To: <20181029223542.26175-1-linux@rasmusvillemoes.dk>
References: <20181026211347.2442-1-linux@rasmusvillemoes.dk>
        <20181029223542.26175-1-linux@rasmusvillemoes.dk>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2018 23:35:39 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

Hi Rasmus,

I'm currently traveling. I'll try to take a look at these later. If you
don't hear from me by next week, feel free to send me a gentle
reminder ;-)

-- Steve


> Playing around with -Wformat-nonliteral, I stumbled on two instances
> in trace_output.c. Looking at the code a bit, turns out one can remove
> the use of the non-constant format string and eliminate some code
> duplication at the same time.
> 
> v2: Include cover letter, rename argument with_offset -> offset.
> 
> Rasmus Villemoes (3):
>   tracing: merge seq_print_sym_short() and seq_print_sym_offset()
>   tracing: avoid -Wformat-nonliteral warning
>   tracing: simplify printf'ing in seq_print_sym
> 
>  kernel/trace/trace_output.c | 38 ++++++++-----------------------------
>  1 file changed, 8 insertions(+), 30 deletions(-)
> 


Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B772C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2278421A48
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392440AbeLVRBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:01:04 -0500
Received: from ozlabs.org ([203.11.71.1]:45335 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387459AbeLVRBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:01:01 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43MLNt2Sdtz9sCQ;
        Sat, 22 Dec 2018 20:51:25 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [for-next][PATCH 05/24] powerpc/frace: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack
In-Reply-To: <20181221175656.041890777@goodmis.org>
References: <20181221175618.968519903@goodmis.org> <20181221175656.041890777@goodmis.org>
Date:   Sat, 22 Dec 2018 20:51:21 +1100
Message-ID: <87d0ptj3dy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> The structure of the ret_stack array on the task struct is going to
> change, and accessing it directly via the curr_ret_stack index will no
> longer give the ret_stack entry that holds the return address. To access
> that, architectures must now use ftrace_graph_get_ret_stack() to get the
> associated ret_stack that matches the saved return address.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  arch/powerpc/kernel/process.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

I did test the previous series you posted and I think everything was OK
running the ftracetest suite (I got one or two fails but I think that
was because of missing CONFIG options).

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

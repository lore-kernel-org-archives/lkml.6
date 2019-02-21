Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB9CC00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157052075C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfBUOg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:36:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfBUOg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:36:28 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B6CC2075C;
        Thu, 21 Feb 2019 14:36:27 +0000 (UTC)
Date:   Thu, 21 Feb 2019 09:36:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-ID: <20190221093625.56afccd2@gandalf.local.home>
In-Reply-To: <20190221165252.4a9033b3348f30f9d973dbc4@kernel.org>
References: <20190215174712.372898450@goodmis.org>
        <20190215174945.557218316@goodmis.org>
        <20190221165252.4a9033b3348f30f9d973dbc4@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 16:52:52 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Basically OK to me.
> Could you use probe_kernel_read() in this context, since probe_mem_read() is a
> wrapper function for template code.
> 
> With that change,
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

This already hit Linus's tree. I was able to reproduce the crash, so I
streamlined it. I should have still pushed more for your ack first.
Sorry about that.

For some reason, I thought the change was in the generic probe code,
and accepted the probe_mem_read(). Anyway, did you want to send a patch
to change it to probe_kernel_read(), for the merge window?

> 
> And for the long term, I need to find more efficient (or smarter) way to do it,
> like strnlen_user() does.

Agreed.

Thanks,

-- Steve

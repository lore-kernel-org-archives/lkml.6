Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB9BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F60C20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfAQOXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:23:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfAQOXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:23:05 -0500
Received: from vmware.local.home (unknown [12.174.139.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0F0D20856;
        Thu, 17 Jan 2019 14:23:04 +0000 (UTC)
Date:   Thu, 17 Jan 2019 09:23:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] tracing: probeevent: Fix probe argument parser and
 handler
Message-ID: <20190117092302.596b4538@vmware.local.home>
In-Reply-To: <154773287750.2285.5509629487576876823.stgit@devbox>
References: <154773287750.2285.5509629487576876823.stgit@devbox>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 22:47:58 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> This series fixes several bugs in probe event argument parser
> and handler routines.

Hi Masami,

Can you resend with a "Fixes:" tag to each of the patches, so that it
is easy to see what patch needs to be backported to which stable kernel
(or not any stable release if the patch fixes something in 5.0-rc).

Thanks!

-- Steve

> 
> Recently I got 2 issues reported by Andreas, see
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1899098.html
> 
> One issue is already fixed by Andreas (Thanks!) but $comm handling
> issue still exists on uprobe event. [1/3] fixes it.
> And I found other issues around that, [2/3] is just a trivial cleanup,
> [3/3] fixes $comm type issue which occurs not only uprobe events but
> also on kprobe events. Anyway, after this series applied, $comm must
> be "string" type and not be an array.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (3):
>       tracing: uprobes: Re-enable $comm support for uprobe events
>       tracing: probeevent: Do not accumulate on ret variable
>       tracing: probeevent: Fix to make the type of $comm string
> 
> 
>  kernel/trace/trace_probe.c      |   13 +++++++------
>  kernel/trace/trace_probe_tmpl.h |    2 +-
>  kernel/trace/trace_uprobe.c     |   15 +++++++++++++--
>  3 files changed, 21 insertions(+), 9 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


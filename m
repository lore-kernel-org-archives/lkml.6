Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D8CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C53D218FD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfBKUtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:49:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbfBKUtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:49:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF543218D8;
        Mon, 11 Feb 2019 20:49:30 +0000 (UTC)
Date:   Mon, 11 Feb 2019 15:49:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andreas Ziegler <andreas.ziegler@fau.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] tracing: probeevent: Correctly update
 remaining space in dynamic area
Message-ID: <20190211154928.6c99e4f2@gandalf.local.home>
In-Reply-To: <20190206190013.16405-1-andreas.ziegler@fau.de>
References: <20190122152634.18957-1-andreas.ziegler@fau.de>
        <20190206190013.16405-1-andreas.ziegler@fau.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Feb 2019 20:00:13 +0100
Andreas Ziegler <andreas.ziegler@fau.de> wrote:

> Commit 9178412ddf5a ("tracing: probeevent: Return consumed
> bytes of dynamic area") improved the string fetching
> mechanism by returning the number of required bytes after
> copying the argument to the dynamic area. However, this
> return value is now only used to increment the pointer
> inside the dynamic area but misses updating the 'maxlen'
> variable which indicates the remaining space in the dynamic
> area.
> 
> This means that fetch_store_string() always reads the *total*
> size of the dynamic area from the data_loc pointer instead of
> the *remaining* size (and passes it along to
> strncpy_from_{user,unsafe}) even if we're already about to
> copy data into the middle of the dynamic area.
> 
> Fixes: 9178412ddf5a ("tracing: probeevent: Return consumed bytes of dynamic area")
> Signed-off-by: Andreas Ziegler <andreas.ziegler@fau.de>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>

I applied it and will start testing it. But just an FYI, please send
new versions of a patch as a separate thread. Sending it as a reply to
is likely to have it get missed, as maintainers usually search their
inboxes threaded, and only look at patches that are the start of a
thread. I just happened to have this one marked to look at.

-- Steve

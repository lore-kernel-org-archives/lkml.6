Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FEFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9612186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbeLTOdQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:33:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387522AbeLTOdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:33:15 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AAD921852;
        Thu, 20 Dec 2018 14:33:14 +0000 (UTC)
Date:   Thu, 20 Dec 2018 09:33:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: make function =?UTF-8?B?4oCYZnRyYWNlX2V4cG9y?=
 =?UTF-8?B?dHPigJk=?= static
Message-ID: <20181220093313.16b227fd@gandalf.local.home>
In-Reply-To: <20180516193012.25390-1-malat@debian.org>
References: <20180516193012.25390-1-malat@debian.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Cleaning out my INBOX, I stumbled on this patch that slipped through
the cracks. Applied to my local queue.

Thanks, and sorry for the delay.

-- Steve


On Wed, 16 May 2018 21:30:12 +0200
Mathieu Malaterre <malat@debian.org> wrote:

> In commit 478409dd683d ("tracing: Add hook to function tracing for other
> subsystems to use"), a new function ‘ftrace_exports’ was added. Since
> this function can be made static, make it so.
> 
> Silence the following warning triggered using W=1:
> 
>   kernel/trace/trace.c:2451:6: warning: no previous prototype for ‘ftrace_exports’ [-Wmissing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 414d7210b2ec..76b96f453cf7 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2448,7 +2448,7 @@ static inline void ftrace_exports_disable(void)
>  	static_branch_disable(&ftrace_exports_enabled);
>  }
>  
> -void ftrace_exports(struct ring_buffer_event *event)
> +static void ftrace_exports(struct ring_buffer_event *event)
>  {
>  	struct trace_export *export;
>  


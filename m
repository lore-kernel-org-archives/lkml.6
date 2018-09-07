Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC13C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4319C2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4319C2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbeIGUAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbeIGUAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:00:32 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 243942083D;
        Fri,  7 Sep 2018 15:19:09 +0000 (UTC)
Date:   Fri, 7 Sep 2018 11:19:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Baron <jbaron@akamai.com>, trivial@kernel.org
Subject: Re: [PATCH] jump_label: Fix typo in warning message
Message-ID: <20180907111907.750bbdaf@gandalf.local.home>
In-Reply-To: <20180907103521.31344-1-bp@alien8.de>
References: <20180907103521.31344-1-bp@alien8.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Sep 2018 12:35:21 +0200
Borislav Petkov <bp@alien8.de> wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> There's no 'allocatote' - use the next best thing: 'allocate' :-)

Nice.

Probably can go through the trivial tree (Cc'd).

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Cc: Jason Baron <jbaron@akamai.com>
> ---
>  kernel/jump_label.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index 01ebdf1f9f40..2e62503bea0d 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -678,7 +678,7 @@ jump_label_module_notify(struct notifier_block *self, unsigned long val,
>  	case MODULE_STATE_COMING:
>  		ret = jump_label_add_module(mod);
>  		if (ret) {
> -			WARN(1, "Failed to allocatote memory: jump_label may not work properly.\n");
> +			WARN(1, "Failed to allocate memory: jump_label may not work properly.\n");
>  			jump_label_del_module(mod);
>  		}
>  		break;


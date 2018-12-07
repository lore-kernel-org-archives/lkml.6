Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB26C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D272146D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544193737;
	bh=CZ9jXfGH2men5RSEn8xejxXJQoQfBtcvGmSLY5ACqKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Q2IIv/GIc1w8lQOoRrtDo1F/lMcMcHQ8azPHd3kGeqirE8DBrI1FFmdeHqbeHx+pE
	 CtXc3X14fuJwbDAIeUNT6YF09SfHTHhSBIvktDw04UeVEtfR5YX6T+Pf600z8z75du
	 eVUBHzNHfwFWXQWrgZw6+GeRGryXM+Tz0HvUSl2Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D272146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeLGOmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:42:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbeLGOmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:42:15 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 232EC208E7;
        Fri,  7 Dec 2018 14:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544193734;
        bh=CZ9jXfGH2men5RSEn8xejxXJQoQfBtcvGmSLY5ACqKQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cwz7cVe7mOp9pNKS1oSx4fmx/uO7MJeUk1fKtYbFasIw02XXqwg5AtSdg/p7cwMwc
         KHmjNVVI8FDahmKvRT9r3BdIBPeja7fySiib2jhXujcr/6pZJa3h4hIVSbmRz54tjL
         4oK65V3FQTxBvSH6wmmqaI0uv4w8iACSWrfo0ieE=
Date:   Fri, 7 Dec 2018 23:42:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Banman <andrew.banman@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yi Wang <wang.yi59@zte.com.cn>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] x86/kernel: Fix more -Wmissing-prototypes warnings
Message-Id: <20181207234210.c29731b7a481c74a4e57220c@kernel.org>
In-Reply-To: <20181205171547.GM29510@zn.tnic>
References: <20181205101131.28996-1-bp@alien8.de>
        <20181205224906.824483ea3c5d1d5b7712c99a@kernel.org>
        <20181205142448.GH29510@zn.tnic>
        <20181205162526.GB109259@gmail.com>
        <20181205171547.GM29510@zn.tnic>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 5 Dec 2018 18:15:47 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Dec 05, 2018 at 05:25:26PM +0100, Ingo Molnar wrote:
> > Also, preferably the prototype should be eliminated via proper ordering 
> > of functions from lower level to higher levels.
> 
> Well, that trampoline_handler() is special as we call it from inline asm
> and I see Masami has marked it __visible etc.
> 
> So doing this below still builds and the trampoline_handler doesn't get
> discarded but maybe there's a reason for it not being static.
> 
> Masami?

Hmm, I just thought that the symbol only referred from inline asm should
be visible. But if it is OK for any version of supported gcc and clang,
I'm good to remove it. :-) (IOW, I just concerned about older gcc)

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> ---
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 6480056d370f..308bf103cc73 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -66,8 +66,6 @@
>  
>  #include "common.h"
>  
> -void *trampoline_handler(struct pt_regs *regs);
> -
>  DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
>  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>  
> @@ -753,7 +751,7 @@ STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
>  /*
>   * Called from kretprobe_trampoline
>   */
> -__visible __used void *trampoline_handler(struct pt_regs *regs)
> +static __used void *trampoline_handler(struct pt_regs *regs)
>  {
>  	struct kretprobe_instance *ri = NULL;
>  	struct hlist_head *head, empty_rp;
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.


-- 
Masami Hiramatsu <mhiramat@kernel.org>

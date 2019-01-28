Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8187BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508EB21738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548683856;
	bh=zzNDuwt38SD2wmWuak/qv+Ea6Jcf45bcbuRjWhurxFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=s8D1sZT0woOcervwQVG/p+tN75xplAeze3qi/ZLZxU8xF0nt66JphNSAoNRZb1cVL
	 2VoG20X02YfIc6miUqHFS6jAP9qNAFbP/9PTuzlzc/7l9gm4nbdVxCvY+jHobufbU2
	 8rwjwBZdFKFWpMk1q9uPSb8IKk6sP+3XvAtGcDpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfA1N5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:57:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfA1N5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:57:34 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29FC520989;
        Mon, 28 Jan 2019 13:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548683853;
        bh=zzNDuwt38SD2wmWuak/qv+Ea6Jcf45bcbuRjWhurxFg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=amYA3XQ/z6jod9YKFehszHcn4TcRuwdQ1GVL13j3Jg2RujgF1hV2LbCFAKHCvhDGL
         TGhZ/qMmuWikZKaVOugYZ/xkBrRtASzXsvP45SEopQO7L+cYbsmjDPiCYC0gQ0EtXF
         1pSKaJcnPxf1ppSNHV0E8+b9AkdhdSSfb0SBPKAk=
Date:   Mon, 28 Jan 2019 22:57:30 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/hw_breakpoints, kprobes: Remove kprobes ifdeffery
Message-Id: <20190128225730.557ab61746fea62d3f85f584@kernel.org>
In-Reply-To: <20190127131237.4557-1-bp@alien8.de>
References: <20190127131237.4557-1-bp@alien8.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jan 2019 14:12:37 +0100
Borislav Petkov <bp@alien8.de> wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> Remove the ifdeffery in the breakpoint parsing arch_build_bp_info() by
> adding a within_kprobe_blacklist() stub for the !CONFIG_KPROBES case.
> 
> It is returning true when kprobes are not enabled to mean that any
> address is within the kprobes blacklist on such kernels and thus not
> allow kernel breakpoints on non-kprobes kernels.
> 

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you Borislav!!

> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/hw_breakpoint.c | 4 ----
>  include/linux/kprobes.h         | 5 +++++
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> index 7d6f91f2869a..ff9bfd40429e 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -261,12 +261,8 @@ static int arch_build_bp_info(struct perf_event *bp,
>  		 * allow kernel breakpoints at all.
>  		 */
>  		if (attr->bp_addr >= TASK_SIZE_MAX) {
> -#ifdef CONFIG_KPROBES
>  			if (within_kprobe_blacklist(attr->bp_addr))
>  				return -EINVAL;
> -#else
> -			return -EINVAL;
> -#endif
>  		}
>  
>  		hw->type = X86_BREAKPOINT_EXECUTE;
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index e07e91daaacc..201f0f2683f2 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -442,6 +442,11 @@ static inline int enable_kprobe(struct kprobe *kp)
>  {
>  	return -ENOSYS;
>  }
> +
> +static inline bool within_kprobe_blacklist(unsigned long addr)
> +{
> +	return true;
> +}
>  #endif /* CONFIG_KPROBES */
>  static inline int disable_kretprobe(struct kretprobe *rp)
>  {
> -- 
> 2.19.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

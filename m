Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69604C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3700D2148D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vRw2twCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfBBBPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:15:00 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43196 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfBBBPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 20:15:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so4068843plb.10;
        Fri, 01 Feb 2019 17:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0rJ7i+EV9cWj3/MnMr0WxrLS3AGD0khiA71WozRXWsY=;
        b=vRw2twCK5YipJ78jZe0ia/FV8SD3jMr5UhhJhGGlpQoFdw96oU0oqN0LWlRG0GUC5d
         Q4LNWZNC9xaaINWO+c+nzNBXNimHpDIyTcwkVH5GcnGrKZ7U2GPKLcmNVJmw1rZq2NGX
         SqiPhmqOdMc7DN4qOmzs9VqpIaHNE56Y4C0XVpvYq4FO2AeLEMh2FczE7vIV6b54nITx
         frzzI0/sGb704XNnvElYr4Oqx1lOGm+GINKoEdu3WSGz9i2WyBpGGZWfx6bWY2tQb/7Z
         +gpVBtM2LXtlF6rxIE3BCg7Nek4myBsRU67ZSIKc0WkgYf9tsOIAsrXIkmSwz7q3RL1F
         Zn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0rJ7i+EV9cWj3/MnMr0WxrLS3AGD0khiA71WozRXWsY=;
        b=VbTn/F4xTgC8gf55bOrFNiArKCO0R7dCDN+WDhmp156r7LZq8+Kxvq/Y39DNAr6umD
         WMPPjJl+EAd1ok8SX3d98zuyuKcwLsZkBQVFmNKPAIjRm4ZVsiJhcqf7ptUThS2kG9+p
         oGARAb4m8AjhWZo7zH1UoejDHgEkAE5ORAmyT6EMuGPCYPj1AXKlzpg2sGfnUGtziYof
         I7L9lIv00t1KWtewfcWz0oqUoZ3jt2Jw8xc8jQasKyCt/3nVmENto0Lyr7E2gFDmXwzC
         aZwEHdo9cGA7WrPGhw7PQ7v9rhLOWOm/+n/L6a0zE9SVTdX2m3XKeQ4ewQi+WDgSkn+T
         XMUA==
X-Gm-Message-State: AJcUukfNd/DsAT0CCZFWaxIFzMBOydjxaiOcMl0RUVtWDho6CQ0v4/fg
        z1m989wOigiygsp8G+ZUe4k=
X-Google-Smtp-Source: ALg8bN5+FKSDjPtgEULcwzNRN+QiRcaez12HT1ekKJfTmviGjzipybskvQzISvLOFcYjQeVfj5WM9A==
X-Received: by 2002:a17:902:2468:: with SMTP id m37mr42002179plg.314.1549070098955;
        Fri, 01 Feb 2019 17:14:58 -0800 (PST)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id z9sm27419422pfd.99.2019.02.01.17.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 17:14:58 -0800 (PST)
Date:   Sat, 2 Feb 2019 12:14:55 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        live-patching@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicolai Stange <nstange@suse.de>, Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH 1/4] powerpc/64s: Clear on-stack exception marker upon
 exception return
Message-ID: <20190202011455.GN26056@350D>
References: <20190122155724.27557-1-joe.lawrence@redhat.com>
 <20190122155724.27557-2-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122155724.27557-2-joe.lawrence@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 10:57:21AM -0500, Joe Lawrence wrote:
> From: Nicolai Stange <nstange@suse.de>
> 
> The ppc64 specific implementation of the reliable stacktracer,
> save_stack_trace_tsk_reliable(), bails out and reports an "unreliable
> trace" whenever it finds an exception frame on the stack. Stack frames
> are classified as exception frames if the STACK_FRAME_REGS_MARKER magic,
> as written by exception prologues, is found at a particular location.
> 
> However, as observed by Joe Lawrence, it is possible in practice that
> non-exception stack frames can alias with prior exception frames and thus,
> that the reliable stacktracer can find a stale STACK_FRAME_REGS_MARKER on
> the stack. It in turn falsely reports an unreliable stacktrace and blocks
> any live patching transition to finish. Said condition lasts until the
> stack frame is overwritten/initialized by function call or other means.
> 
> In principle, we could mitigate this by making the exception frame
> classification condition in save_stack_trace_tsk_reliable() stronger:
> in addition to testing for STACK_FRAME_REGS_MARKER, we could also take into
> account that for all exceptions executing on the kernel stack
> - their stack frames's backlink pointers always match what is saved
>   in their pt_regs instance's ->gpr[1] slot and that
> - their exception frame size equals STACK_INT_FRAME_SIZE, a value
>   uncommonly large for non-exception frames.
> 
> However, while these are currently true, relying on them would make the
> reliable stacktrace implementation more sensitive towards future changes in
> the exception entry code. Note that false negatives, i.e. not detecting
> exception frames, would silently break the live patching consistency model.
> 
> Furthermore, certain other places (diagnostic stacktraces, perf, xmon)
> rely on STACK_FRAME_REGS_MARKER as well.
> 
> Make the exception exit code clear the on-stack STACK_FRAME_REGS_MARKER
> for those exceptions running on the "normal" kernel stack and returning
> to kernelspace: because the topmost frame is ignored by the reliable stack
> tracer anyway, returns to userspace don't need to take care of clearing
> the marker.
> 
> Furthermore, as I don't have the ability to test this on Book 3E or
> 32 bits, limit the change to Book 3S and 64 bits.
> 
> Finally, make the HAVE_RELIABLE_STACKTRACE Kconfig option depend on
> PPC_BOOK3S_64 for documentation purposes. Before this patch, it depended
> on PPC64 && CPU_LITTLE_ENDIAN and because CPU_LITTLE_ENDIAN implies
> PPC_BOOK3S_64, there's no functional change here.
> 
> Fixes: df78d3f61480 ("powerpc/livepatch: Implement reliable stack tracing for the consistency model")
> Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  arch/powerpc/Kconfig           | 2 +-
>  arch/powerpc/kernel/entry_64.S | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2890d36eb531..73bf87b1d274 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -220,7 +220,7 @@ config PPC
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select HAVE_RCU_TABLE_FREE		if SMP
>  	select HAVE_REGS_AND_STACK_ACCESS_API
> -	select HAVE_RELIABLE_STACKTRACE		if PPC64 && CPU_LITTLE_ENDIAN
> +	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_VIRT_CPU_ACCOUNTING
>  	select HAVE_IRQ_TIME_ACCOUNTING
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 435927f549c4..a2c168b395d2 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -1002,6 +1002,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>  	ld	r2,_NIP(r1)
>  	mtspr	SPRN_SRR0,r2
>  
> +	/*
> +	 * Leaving a stale exception_marker on the stack can confuse
> +	 * the reliable stack unwinder later on. Clear it.
> +	 */
> +	li	r2,0
> +	std	r2,STACK_FRAME_OVERHEAD-16(r1)
> +

Could you please double check, r4 is already 0 at this point
IIUC. So the change might be a simple

std r4,STACK_FRAME_OVERHEAD-16(r1)

Balbir

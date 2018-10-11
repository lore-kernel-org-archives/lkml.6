Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB08AC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A02320658
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A02320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbeJKXze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:55:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50766 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729009AbeJKXze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:55:34 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3IhXvqjhGtB9; Thu, 11 Oct 2018 18:27:35 +0200 (CEST)
Received: from zn.tnic (p200300EC2BD5D200329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd5:d200:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 80DBC1EC0266;
        Thu, 11 Oct 2018 18:27:35 +0200 (CEST)
Date:   Thu, 11 Oct 2018 18:27:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 01/11] x86/entry: remove _TIF_ALLWORK_MASK
Message-ID: <20181011162731.GE25435@zn.tnic>
References: <20181004140547.13014-1-bigeasy@linutronix.de>
 <20181004140547.13014-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181004140547.13014-2-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 04:05:37PM +0200, Sebastian Andrzej Siewior wrote:
> There is no user of _TIF_ALLWORK_MASK since commit 21d375b6b34ff
> ("x86/entry/64: Remove the SYSCALL64 fast path").
> Remove unused define _TIF_ALLWORK_MASK.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/include/asm/thread_info.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index 2ff2a30a264f4..cd6920674b905 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -136,14 +136,6 @@ struct thread_info {
>  	 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT |	\
>  	 _TIF_NOHZ)
>  
> -/* work to do on any return to user space */
> -#define _TIF_ALLWORK_MASK						\
> -	(_TIF_SYSCALL_TRACE | _TIF_NOTIFY_RESUME | _TIF_SIGPENDING |	\
> -	 _TIF_NEED_RESCHED | _TIF_SINGLESTEP | _TIF_SYSCALL_EMU |	\
> -	 _TIF_SYSCALL_AUDIT | _TIF_USER_RETURN_NOTIFY | _TIF_UPROBE |	\
> -	 _TIF_PATCH_PENDING | _TIF_NOHZ | _TIF_SYSCALL_TRACEPOINT |	\
> -	 _TIF_FSCHECK)
> -
>  /* flags to check in __switch_to() */
>  #define _TIF_WORK_CTXSW							\
>  	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|_TIF_SSBD)
> -- 

Just a nitpick for the next version: pls start subjects with a capital
letter, i.e.,

x86/entry: Remove _TIF_ALLWORK_MASK

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

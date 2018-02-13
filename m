Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933603AbeBMHg1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:36:27 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36075 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933468AbeBMHgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:36:25 -0500
X-Google-Smtp-Source: AH8x227ua2hCf0xfXjGDeh6o7ZmtJCgmGv2hdCKci+5+9mjm7+oMznBrlrsHLyBMKMWFkEpo5Zg9Tw==
Date: Tue, 13 Feb 2018 08:36:21 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: x86-ml <x86@kernel.org>, linux-tip-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org, dvlasenk@redhat.com, luto@kernel.org,
        torvalds@linux-foundation.org, jpoimboe@redhat.com, hpa@zytor.com,
        brgerst@gmail.com, linux@dominikbrodowski.net, peterz@infradead.org,
        tglx@linutronix.de
Subject: Re: [PATCH] x86/entry/64: Remove unused icebp macro
Message-ID: <20180213073621.shvpk6l4fgwxc34g@gmail.com>
References: <20180211104949.12992-8-linux@dominikbrodowski.net>
 <tip-5a10e729bc0aa9420a23a70b169eadd229c27bc1@git.kernel.org>
 <20180212201318.GD14640@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212201318.GD14640@pd.tnic>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Feb 12, 2018 at 02:18:55AM -0800, tip-bot for Dominik Brodowski wrote:
> > Commit-ID:  5a10e729bc0aa9420a23a70b169eadd229c27bc1
> > Gitweb:     https://git.kernel.org/tip/5a10e729bc0aa9420a23a70b169eadd229c27bc1
> > Author:     Dominik Brodowski <linux@dominikbrodowski.net>
> > AuthorDate: Sun, 11 Feb 2018 11:49:48 +0100
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Mon, 12 Feb 2018 08:06:37 +0100
> > 
> > x86/entry/64: Indent PUSH_AND_CLEAR_REGS and POP_REGS properly
> 
> Ontop:
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> 
> That macro was touched around 2.5.8 times, judging by the full history
> linux repo, but it was unused even then. Get rid of it already.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/entry/calling.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
> index 6985440c68fa..dce7092ab24a 100644
> --- a/arch/x86/entry/calling.h
> +++ b/arch/x86/entry/calling.h
> @@ -159,10 +159,6 @@ For 32-bit we have the following conventions - kernel is built with
>  	.if \pop_rdi
>  	popq %rdi
>  	.endif
> -	.endm
> -
> -	.macro icebp
> -	.byte 0xf1
>  .endm

Good find!

I applied this separately, and added your SOB: let me know if that's not OK.

Thanks,

	Ingo

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965505AbeBMScd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:32:33 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44365 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965365AbeBMSc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:32:28 -0500
X-Google-Smtp-Source: AH8x225lYy5oSoD4f8bl/aNFhnKA/SvgXzwUEFT84/aUjvL3xVJXkdpbOvJErYBcIlKlxcq/fA2l/Q==
Date: Tue, 13 Feb 2018 21:32:24 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: kirill.shutemov@linux.intel.com
Cc: linux-tip-commits@vger.kernel.org, bp@suse.de, luto@amacapital.net,
        peterz@infradead.org, mingo@kernel.org, hpa@zytor.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de
Subject: Re: [tip:x86/boot] x86/boot/compressed/64: Prepare trampoline memory
Message-ID: <20180213183224.GC17395@uranus.lan>
References: <20180209142228.21231-4-kirill.shutemov@linux.intel.com>
 <tip-b91993a87aff6dafd60a9c8ce80ebc425161a815@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-b91993a87aff6dafd60a9c8ce80ebc425161a815@git.kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 04:19:38AM -0800, tip-bot for Kirill A. Shutemov wrote:
...
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index d598d65..af9ffbd 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
...
> @@ -586,3 +604,7 @@ pgtable:
>  	.fill BOOT_PGT_SIZE, 1, 0
>  lvl5_pgtable:
>  	.fill PAGE_SIZE, 1, 0
> +
> +	.global pgtable_trampoline
> +pgtable_trampoline:
> +	.fill 4096, 1, 0

Btw, Kirill, while you're at this code: 4096 might be changed to PAGE_SIZE I think.
(of course on top of the series, when you have a spare minute, just for polishing)

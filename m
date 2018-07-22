Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51083C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 20:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0B42075B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 20:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDGdLqBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0B42075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbeGVVRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 17:17:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44702 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbeGVVRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 17:17:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so15862323wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 13:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yxFqKJmBLU7LysIYI7sU5qGwJrsfWPn/EpUY+hm/F5A=;
        b=jDGdLqBtNB2R1Z/78AK1Wpuq9QCisIwo3KRZr8R8qej4I9WXWkche6LUtFkrxbCKso
         adfqET4Vgu3d/sSZp3NtKSD3asDHUr5LSYdeuVcU7EXE3rZrSOZmCJvTDV2Q0HlUZ8le
         Q2X84zpjR7GdhFRYdffMeAJExc+40xF56noVS2h7MLo6gfpRkW9XRdVCLdScDii1dAWQ
         J1bokC/H6sDEHxLUx952lCY2hy5HvAWPgBQtGU4WWyBAAe/ghvq4qgBKAJw9jDGryI+A
         pDzSP93RuhStpWPYUM5Lw97CBkGvepEJW+uQcEEIEG7NLcRo0PFxeq32wtnaI0Wqvbue
         9iAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yxFqKJmBLU7LysIYI7sU5qGwJrsfWPn/EpUY+hm/F5A=;
        b=uoZDf73uqymHINMCWByaAaaZidDQo/3f9Lr9DF5ARJa2RhPcVihI9Zk8LTUsOxCuzn
         /KVm/+sZU5DyKPPQ2ovCmNDroh0+1r2S+Ijmjc0e7Gl7Pmm/SHg7LuktYwKiMZmvAty8
         3Eb/maQwwq+zWAuvxBUoJui1bvWNyroXSC2ZzszyBv2VQQsHBt3/O2DYPP6Xp8fkzS5R
         OKyFnThMAZ/JKx5dqa8jrU4nBGZ1depuZZjuAsZbLGe6c7AebcBUut/Xmqgk2Bf/sy8x
         2bl+L/bOtffRC5lVU0O8Mq3l7+f405dzjzWSE+fRoZawGdn7u/UGuNfCMyNNnvMZsdgY
         cOxQ==
X-Gm-Message-State: AOUpUlHuaodPSGqjg1oYzfXYyP/qMdbjMhdIKuvhZduao4DFfmPyXbG2
        m+CwqRrMk1mvFHD9liBv4xA=
X-Google-Smtp-Source: AAOMgpca+sy4rVX6yegB3SHM0Z+tMenCkAfqh6XmYVJkIa0tmCCTL9Ymbr2uUObbkJ+pxzuwk7UEWA==
X-Received: by 2002:adf:fe42:: with SMTP id m2-v6mr6421563wrs.171.1532290334533;
        Sun, 22 Jul 2018 13:12:14 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j9-v6sm20257744wrv.5.2018.07.22.13.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Jul 2018 13:12:13 -0700 (PDT)
Date:   Sun, 22 Jul 2018 22:12:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RFC 1/2] x86/entry/64: Use the TSS sp2 slot for rsp_scratch
Message-ID: <20180722201211.GA30923@gmail.com>
References: <cover.1532281180.git.luto@kernel.org>
 <38b5a24f3c9f519dd7dc98171eb3a3c669fff48c.1532281180.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38b5a24f3c9f519dd7dc98171eb3a3c669fff48c.1532281180.git.luto@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Lutomirski <luto@kernel.org> wrote:

> In the non-trampoline SYSCALL64 path, we use a percpu variable to
> temporarily store the user RSP value.  Instead of a separate
> variable, use the otherwise unused sp2 slot in the TSS.  This will
> improve cache locality, as the sp1 slot is already used in the same
> code to find the kernel stack.  It will also simplify a future
> change to make the non-trampoline path work in PTI mode.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/include/asm/processor.h   | 5 +++++
>  arch/x86/include/asm/thread_info.h | 1 +
>  arch/x86/kernel/asm-offsets_64.c   | 1 +
>  arch/x86/kernel/process_64.c       | 2 --
>  4 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index cfd29ee8c3da..2ef4c39ded45 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -308,7 +308,12 @@ struct x86_hw_tss {
>  	 */
>  	u64			sp1;
>  
> +	/*
> +	 * sp2 is scratch space used by the SYSCALL64 handler.  Linux does
> +	 * not use rung 2, so sp2 is not otherwise needed.
> +	 */
>  	u64			sp2;

s/rung/ring

Thanks,

	Ingo

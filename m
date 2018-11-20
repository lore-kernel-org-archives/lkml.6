Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900C7C04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5718D208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDo+y6cT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5718D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbeKTSHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:07:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35450 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbeKTSHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:07:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so831259wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 23:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KTh18pY+lSpAIfFxvR+iGsJdcknDxwZKhM6POZVoGUc=;
        b=cDo+y6cT1u1j+bcb7clSM1b/Xte2P9t6y4ZuFs/1pCr06mjXZq9E0EFAOW1YTGTzHt
         yS8QePki6/2AmWY8r14yUOhDmJAjcO/4DqAavvRZT5SRFfxysp/fq9T0k2/Qtx8UPgwb
         WXWJgfUJmWpLmcrUTpOc/DbngLCDg8Y1xaOO5AFEGE8HQqP28H22L6ihYpCm0xITAGyz
         +Vw+bYFYJxKddH9t9Zjxy23A9aaSxkd/Hek8chZwxTD2mrDvbgl2QMhTz1OFWMj8xmJT
         Y+gAOeNoPeKVQJWdbyx8P61i+MJDljl3BOtPmCUYwP/2b9awUHqeUfrmDgn9dE3YZaYd
         JVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KTh18pY+lSpAIfFxvR+iGsJdcknDxwZKhM6POZVoGUc=;
        b=SyJlpIoQah5TxH0r1zjmPuN1A+zfjk9RLlWGhimSnVF/mtjeKu0fOvJDKcmwNfeSxJ
         iL5NHncy4qgRXywtTKKBRN8bcR8GBmQr7QIHGuChSsAOcWjTOp0vEDjQXEolG9QvuDuF
         r2ZV5z/PtyZhbD70PSKSJmG/2poL4pn9XqvI+k7TSi5m1wfTTVv7Zhij0RkL/VC4CgVb
         GwaQypdHKYb5x8SQPn0Sl8FfMyvrBHTcN9mYCbH1yomGi5KJFyDWL0AtffStvc3bWvp3
         AZ7bMJBxZTs6es83ytfkbNlYxofIfHt2wjahuPq6AbQ6LB2tgHxhIYeAT/KZauPDke6a
         mxsw==
X-Gm-Message-State: AA+aEWajzNFoz1wwb/pBIfLWki9Wcaarz905WkiCD8zB00jDbvwMfXE6
        cvi2BEp+FTDF6EWCgyTvjSg=
X-Google-Smtp-Source: AFSGD/Uw7MB4jWUQCgR6zmFbsNJ0BdqVCN+IyKPxdIHEop5SAG7PFUoXYgtIHC7A7XpPBeAbVsFUVA==
X-Received: by 2002:a5d:56d2:: with SMTP id m18mr923170wrw.113.1542699568504;
        Mon, 19 Nov 2018 23:39:28 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id p7-v6sm30246697wrs.23.2018.11.19.23.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 23:39:27 -0800 (PST)
Date:   Tue, 20 Nov 2018 08:39:25 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 02/13] x86/fault: Check user_mode(regs) when validating a
 stack extension
Message-ID: <20181120073925.GC79825@gmail.com>
References: <cover.1542667307.git.luto@kernel.org>
 <e2e8e92d67d64700ba88aec73a4fc2b7986c0f87.1542667307.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2e8e92d67d64700ba88aec73a4fc2b7986c0f87.1542667307.git.luto@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Lutomirski <luto@kernel.org> wrote:

> The fault handling code tries to validate that a page fault from
> user mode that would extend the stack is within a certain range of
> the user SP.  regs->sp is only equal to the user SP if
> user_mode(regs).  In the extremely unlikely event that that
> sw_error_code had the USER bit set but the faulting instruction was
> in the kernel (i.e. the faulting instruction was WRUSS), then the
> *kernel* stack pointer would have been checked, which would be an
> info leak.
> 
> Note to -stable maintainers: don't backport this unless you backport
> CET.  The bug it fixes is unobservable in current kernels.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/mm/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 91d4d2722f2e..eae7ee3ce89b 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1377,7 +1377,7 @@ void do_user_addr_fault(struct pt_regs *regs,
>  		bad_area(regs, sw_error_code, address);
>  		return;
>  	}
> -	if (sw_error_code & X86_PF_USER) {
> +	if (user_mode(regs)) {
>  		/*
>  		 * Accessing the stack below %sp is always a bug.
>  		 * The large cushion allows instructions like enter

Note that this check is gone now due to:

  1d8ca3be86eb: x86/mm/fault: Allow stack access below %rsp

Thanks,

	Ingo

Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0519ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3A821476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qqzx3RqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3A821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJSODW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 10:03:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37060 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSODW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 10:03:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id 185-v6so2472326wmt.2;
        Thu, 18 Oct 2018 22:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YNVUw8oVV4jSPk/R/7kyGC47hGiOBUnXZDJK+RSuRk8=;
        b=Qqzx3RqGKLb8SMjTOInEjV03rp8NqSu6rHRkHM+akH7VSS9D9fTCoAQn4DYiU0xQaH
         1cZfwHVCjWaEkPRF5p4rIFsu0i1ckjbJu3+53zXvrk7U8Ed3dWwhC4OyOLlS4rxOBZQH
         X8AYqOSxNzgPOt2BCg0pf/YoBfRRQJ7unHaA7vjR7JlMeUJ11HFgUWbpjDdiJve1Phe5
         ajzk/V8NKEkbK0L9ln9q2uDCKXcgkmNGAcjbOsJD16MJRlRt3cnVhBIdnD9a/Rm9/7sy
         BVOKFM3qQu7N4tdqDje4MWiivN2nqeR86Z2RIhgtTq6lstZi2cz3Mfj0xgTkbsXMEI1A
         Ap8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YNVUw8oVV4jSPk/R/7kyGC47hGiOBUnXZDJK+RSuRk8=;
        b=JYPmXid5EKHWUYvp+LcDMEpIFuAQ9SfzUP5qzC3xdr7Gr97A9HcKNeOEbBMuvEFywS
         zEMSLSB4UeOk2ES0CVfNoXkQnG/oKCuEbR3aHFBKXFxXTsWojgqT2t2I0K6mFHhyK2wS
         fY+0pKKxpj7WZZ1vspJ0x7zmL8gBOfF8dc73RNboEr9cPfgII4JJ6pS22IHwHlqYf/Bi
         LFtx2wXbAjkjIlIRO2ZUZJ+p1PEpZo8raXMvLG8WTHNruTl+lfqS+PqYXgZrLtyxtWls
         RvO9kYRs1uirWxi541criLdR1JMjB4EASdSp3Qazi1rWTaDI+3tfSgXXdLE571nBXYm5
         PdSg==
X-Gm-Message-State: AGRZ1gI7TijtkImZsxonwu091ZZp7mXViK0sTwP3VdVaZ/Xssmz3RP2w
        W3m8+alemv/Xt3bIFrUa+jqz/0jU
X-Google-Smtp-Source: ACcGV62vzzyRxqmtieYwM33AhFe9E2EmnaAM0D9hZ24KReP1YRhRSFi1aYrQcO9sbpUQGWpdryf2LA==
X-Received: by 2002:a1c:234c:: with SMTP id j73-v6mr3197562wmj.68.1539928727414;
        Thu, 18 Oct 2018 22:58:47 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i7-v6sm29336566wrb.30.2018.10.18.22.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 22:58:46 -0700 (PDT)
Date:   Fri, 19 Oct 2018 07:58:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     tip-bot for Dave Hansen <tipbot@zytor.com>,
        linux-tip-commits@vger.kernel.org, dave.hansen@linux.intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        jannh@google.com, sean.j.christopherson@intel.com,
        peterz@infradead.org, luto@kernel.org
Subject: Re: [tip:x86/mm] x86/mm: Break out user address space handling
Message-ID: <20181019055844.GA50013@gmail.com>
References: <20180928160223.9C4F6440@viggo.jf.intel.com>
 <tip-aa37c51b9421d66f7931c5fdcb9ce80c450974be@git.kernel.org>
 <87k1mjpxwi.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1mjpxwi.fsf@xmission.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> tip-bot for Dave Hansen <tipbot@zytor.com> writes:
> 
> > Commit-ID:  aa37c51b9421d66f7931c5fdcb9ce80c450974be
> > Gitweb:     https://git.kernel.org/tip/aa37c51b9421d66f7931c5fdcb9ce80c450974be
> > Author:     Dave Hansen <dave.hansen@linux.intel.com>
> > AuthorDate: Fri, 28 Sep 2018 09:02:23 -0700
> > Committer:  Peter Zijlstra <peterz@infradead.org>
> > CommitDate: Tue, 9 Oct 2018 16:51:15 +0200
> >
> > x86/mm: Break out user address space handling
> >
> > The last patch broke out kernel address space handing into its own
> > helper.  Now, do the same for user address space handling.
> >
> > Cc: x86@kernel.org
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Link: http://lkml.kernel.org/r/20180928160223.9C4F6440@viggo.jf.intel.com
> > ---
> >  arch/x86/mm/fault.c | 47 ++++++++++++++++++++++++++++-------------------
> >  1 file changed, 28 insertions(+), 19 deletions(-)
> >
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index c7e32f453852..0d1f5d39fc63 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -966,6 +966,7 @@ bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
> >  		__bad_area(regs, error_code, address, vma, SEGV_ACCERR);
> >  }
> >  
> > +/* Handle faults in the kernel portion of the address space */
>                            ^^^^^^
> I believe you mean the __user__ portion of the address space.
> Given that the call chain is:
> 
> do_user_addr_fault
>    handle_mm_fault
>       do_sigbus      

It's both:

  /* Handle faults in the kernel portion of the address space */
  static void
  do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
            u32 *pkey, unsigned int fault)
  {
        struct task_struct *tsk = current;
        int code = BUS_ADRERR;

        /* Kernel mode? Handle exceptions or die: */
        if (!(error_code & X86_PF_USER)) {
                no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
                return;
        }

        /* User-space => ok to do another page fault: */
        if (is_prefetch(regs, error_code, address))
                return;

        tsk->thread.cr2         = address;
        tsk->thread.error_code  = error_code;
        tsk->thread.trap_nr     = X86_TRAP_PF;


Note the X86_PF_USER check: that's what determines whether the fault was 
for user or system mappings.

I agree that the comment is misleading and should be clarified.

Thanks,

	Ingo

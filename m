Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D8CC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1001D21920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545403735;
	bh=T5elvB5MF4G4yEKPHw9Ik3m5fzWfaBaOaXVwOSl8syE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mkm7tgy+dz6jdK4oqwk258G6R/CB1NLWcFbzgMG+UA2+cFQs243aHSgOmHrekIcfS
	 qOc3Bm40yPv7FtsXU7h1q3ox5Nwb0pKTzU9Gjrtus4G967YB38cCEFYoAC42MTN3M9
	 dqU+GqyZBRLG0LpzQ1twypOmgPl+2UtPuE7sIDTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404009AbeLUOss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:48:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403992AbeLUOso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:48:44 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98E0621920;
        Fri, 21 Dec 2018 14:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545403722;
        bh=T5elvB5MF4G4yEKPHw9Ik3m5fzWfaBaOaXVwOSl8syE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FHqPKpnmHFzxGMBOTYPHMfN0PuNPcqjO2pV5kHNLsPjjsCSE1Q5MWrRfe5RElDpxn
         oThPACnY+sG62rPli33QtJwUPMoSFcw/vfBUIhOEBKBqOGNnyGjlCQyy3B4HyflbTx
         9UcDr+dSaavyNQUrCg5KAGctTt5xRIspl4Gys0TE=
Date:   Fri, 21 Dec 2018 22:48:36 +0800
From:   Guo Ren <guoren@kernel.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/27] csky: define syscall_get_arch()
Message-ID: <20181221144836.GA4267@guoren-Inspiron-7460>
References: <20181213171833.GA5240@altlinux.org>
 <20181213172207.GH6024@altlinux.org>
 <20181214044412.GB15793@guoren-Inspiron-7460>
 <20181221023641.GC5396@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221023641.GC5396@altlinux.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 05:36:41AM +0300, Dmitry V. Levin wrote:
> Hi,
> 
> On Fri, Dec 14, 2018 at 12:44:12PM +0800, Guo Ren wrote:
> > Thx Dmitry,
> > 
> > Reviewed-by: Guo Ren <guoren@kernel.org>
> 
> Given that the whole series is going to be pinged for quite some
> time yet, would you mind taking this patch into the csky tree?
OK.

Best Regards
 Guo Ren

>  
> Thanks.
> 
> > On Thu, Dec 13, 2018 at 08:22:07PM +0300, Dmitry V. Levin wrote:
> > > syscall_get_arch() is required to be implemented on all architectures
> > > in order to extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO
> > > request.
> > > 
> > > Cc: Guo Ren <guoren@kernel.org>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: Eric Paris <eparis@redhat.com>
> > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > Cc: Andy Lutomirski <luto@kernel.org>
> > > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > > Cc: linux-audit@redhat.com
> > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > > ---
> > > 
> > > Notes:
> > >     v6: unchanged
> > > 
> > >  arch/csky/include/asm/syscall.h | 7 +++++++
> > >  include/uapi/linux/audit.h      | 1 +
> > >  2 files changed, 8 insertions(+)
> > > 
> > > diff --git a/arch/csky/include/asm/syscall.h b/arch/csky/include/asm/syscall.h
> > > index 926a64a8b4ee..d637445737b7 100644
> > > --- a/arch/csky/include/asm/syscall.h
> > > +++ b/arch/csky/include/asm/syscall.h
> > > @@ -6,6 +6,7 @@
> > >  #include <linux/sched.h>
> > >  #include <linux/err.h>
> > >  #include <abi/regdef.h>
> > > +#include <uapi/linux/audit.h>
> > >  
> > >  static inline int
> > >  syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
> > > @@ -68,4 +69,10 @@ syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
> > >  	memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
> > >  }
> > >  
> > > +static inline int
> > > +syscall_get_arch(void)
> > > +{
> > > +	return AUDIT_ARCH_CSKY;
> > > +}
> > > +
> > >  #endif	/* __ASM_SYSCALL_H */
> > > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > > index 72aeea0a740d..55904a40d768 100644
> > > --- a/include/uapi/linux/audit.h
> > > +++ b/include/uapi/linux/audit.h
> > > @@ -384,6 +384,7 @@ enum {
> > >  #define AUDIT_ARCH_C6X		(EM_TI_C6000|__AUDIT_ARCH_LE)
> > >  #define AUDIT_ARCH_C6XBE	(EM_TI_C6000)
> > >  #define AUDIT_ARCH_CRIS		(EM_CRIS|__AUDIT_ARCH_LE)
> > > +#define AUDIT_ARCH_CSKY		(EM_CSKY|__AUDIT_ARCH_LE)
> > >  #define AUDIT_ARCH_FRV		(EM_FRV)
> > >  #define AUDIT_ARCH_I386		(EM_386|__AUDIT_ARCH_LE)
> > >  #define AUDIT_ARCH_IA64		(EM_IA_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
> > > -- 
> > > ldv
> 
> -- 
> ldv



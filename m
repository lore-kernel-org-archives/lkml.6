Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C5DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFE521924
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545403769;
	bh=tEdcXntZBNF5npTYm4g0ETjv8TdsgAsyd0iFGuyz7e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W/SB+0lelzlc/ln8AaPepDDvCzUdf51OTGOD/SdPPDdwA1Ljer9xwPANAJHLgTLMu
	 7KmIgML7yuMGbgH6haDmo/RX4JdBdsTVJbUlD6UvpLGezVMpDDcIKuYGPqschmJFgo
	 fLwwF0h/tZQBebQAIyNzVd3YFdgP9eMb/y7yFKeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390879AbeLUOt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:49:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729556AbeLUOt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:49:27 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE1E321920;
        Fri, 21 Dec 2018 14:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545403767;
        bh=tEdcXntZBNF5npTYm4g0ETjv8TdsgAsyd0iFGuyz7e4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PmP9haVwWc6DKinmAB9Iz4MLDiaRWuDWT6E4Vv50wAozVCxWNx1h/LnWXpLP6Idio
         tt/jEW6zsS+FlwngLkgnCImVmDmK4xpps+zCXi/GaO2jtuguyMDy+JPsXf74epYVlJ
         YDyMJ1+mUzIcEWfM3mANgWQHx7TnFVQ3/RlZdQ54=
Date:   Fri, 21 Dec 2018 22:49:21 +0800
From:   Guo Ren <guoren@kernel.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/27] elf-em.h: add EM_CSKY
Message-ID: <20181221144921.GB4267@guoren-Inspiron-7460>
References: <20181213171833.GA5240@altlinux.org>
 <20181213172200.GG6024@altlinux.org>
 <20181214044308.GA15793@guoren-Inspiron-7460>
 <20181221023552.GB5396@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221023552.GB5396@altlinux.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 05:35:52AM +0300, Dmitry V. Levin wrote:
> Hi,
> 
> On Fri, Dec 14, 2018 at 12:43:08PM +0800, Guo Ren wrote:
> > Reviewed-by: Guo Ren <guoren@kernel.org>
> 
> Given that the whole series is going to be pinged for quite some
> time yet, would you mind taking this patch into the csky tree?
Ok

Best Regards
 Guo Ren
> 
> Thanks.
> 
> > On Thu, Dec 13, 2018 at 08:22:00PM +0300, Dmitry V. Levin wrote:
> > > The uapi/linux/audit.h header is going to use EM_CSKY in order
> > > to define AUDIT_ARCH_CSKY which is needed to implement
> > > syscall_get_arch() which in turn is required to extend
> > > the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
> > > 
> > > The value for EM_CSKY has been taken from arch/csky/include/asm/elf.h
> > > and confirmed by binutils:include/elf/common.h
> > > 
> > > Cc: Guo Ren <guoren@kernel.org>
> > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > Cc: Andy Lutomirski <luto@kernel.org>
> > > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > > ---
> > > 
> > > Notes:
> > >     v6: unchanged
> > > 
> > >  include/uapi/linux/elf-em.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
> > > index 42b7546352a6..ee0b26ab92b0 100644
> > > --- a/include/uapi/linux/elf-em.h
> > > +++ b/include/uapi/linux/elf-em.h
> > > @@ -45,6 +45,7 @@
> > >  #define EM_ARCV2	195	/* ARCv2 Cores */
> > >  #define EM_RISCV	243	/* RISC-V */
> > >  #define EM_BPF		247	/* Linux BPF - in-kernel virtual machine */
> > > +#define EM_CSKY		252	/* C-SKY processor family */
> > >  #define EM_FRV		0x5441	/* Fujitsu FR-V */
> > >  
> > >  /*
> > > -- 
> > > ldv
> 
> -- 
> ldv



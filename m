Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75A8C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B74208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYVgq+Uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B74208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbeH1JKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 05:10:43 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:34803 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbeH1JKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 05:10:42 -0400
Received: by mail-it0-f54.google.com with SMTP id x79-v6so1171109ita.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 22:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PXBkSapl8039WQoTt+L1UVBaN/EBSKrweoiphv+Awxg=;
        b=BYVgq+UyVDys4r3wq8plnpIoKAtmGV/ORG1Et0Ga+op+WZBIdyN/yBfSYzAJ3Lxrte
         byNlH/s+YUVTS0e5R78NGlq4BSwb+9AMpG9XtQNdxRUx1Cl5Gh1zhVzjZqxczIPQuN7O
         2i97UXXj9RG6HdpKFIZEnJbPSbTyoK5RAfvBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=PXBkSapl8039WQoTt+L1UVBaN/EBSKrweoiphv+Awxg=;
        b=s1diScipCCrx/3ylEXKoCzaSpO7vcFse1oAwsKdLCnHGrnD/Vj8aszYSm+geASm2sE
         hbdR5lDbDTN0ZlaVptoVCB+35kOREy1ukQgQpiAoXacvvwn5zzBujGHoADtVNH0FY6EW
         RqmapbLHavyr5+SyNZrlbf/JIZODLmrSGFznWpz1lDTUeiC0ey2XzomiSwayTxfzH4qf
         WdCyKko+WGeRjojd0w/jg9rS8y9JQPGFiCxnWTQPgDzgK23w30frmnnsxN7kD/LTVOAl
         Po6+f8faZFyZ8o6S6AH8uc3+S/LbKdld0vhsmZODR8vQQ0cuCBVmaWTEwCv3LOgFe2Ar
         ctdw==
X-Gm-Message-State: APzg51ARw6pAs5YiidAp74gvvJoi5qp0KWvhYwKXUa7GX3L8JMdS4lpK
        +VSPoz72KbM3ekrWUfr4BKvfMg==
X-Google-Smtp-Source: ANB0VdatHjbE/ylFZ+X117H6ujX+fuM0LLcoeB3cVdLfZKmMacMXVxJzXxM/9dVNjuSCOd/DM2bNbg==
X-Received: by 2002:a02:55c2:: with SMTP id e185-v6mr13371059jab.141.1535433647122;
        Mon, 27 Aug 2018 22:20:47 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id g8-v6sm31902ioh.43.2018.08.27.22.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 22:20:46 -0700 (PDT)
Date:   Tue, 28 Aug 2018 14:21:09 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Dave Young <dyoung@redhat.com>
Cc:     Pingfan Liu <piliu@redhat.com>, Philipp Rudo <prudo@linux.ibm.com>,
        catalin marinas <catalin.marinas@arm.com>,
        will deacon <will.deacon@arm.com>, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, bhe@redhat.com, arnd@arndb.de,
        schwidefsky@de.ibm.com, heiko carstens <heiko.carstens@de.ibm.com>,
        ard biesheuvel <ard.biesheuvel@linaro.org>,
        james morse <james.morse@arm.com>, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "piliu@redhat.com Thiago Jung Bauermann" 
        <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v13 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
Message-ID: <20180828052107.GE12252@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Young <dyoung@redhat.com>, Pingfan Liu <piliu@redhat.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        catalin marinas <catalin.marinas@arm.com>,
        will deacon <will.deacon@arm.com>, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com,
        heiko carstens <heiko.carstens@de.ibm.com>,
        ard biesheuvel <ard.biesheuvel@linaro.org>,
        james morse <james.morse@arm.com>, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "piliu@redhat.com Thiago Jung Bauermann" <bauerman@linux.vnet.ibm.com>
References: <20180801075820.3753-1-takahiro.akashi@linaro.org>
 <20180801075820.3753-4-takahiro.akashi@linaro.org>
 <20180801102951.527cfc57@ThinkPad>
 <20180802000150.GN11258@linaro.org>
 <20180806055047.GC4246@dhcp-128-65.nay.redhat.com>
 <20180809033416.GA5069@dhcp-128-65.nay.redhat.com>
 <1235507889.17337085.1533788045597.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1235507889.17337085.1533788045597.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Thu, Aug 09, 2018 at 12:14:05AM -0400, Pingfan Liu wrote:
> 
> 
> 
> 
> ----- Original Message -----
> > From: "Dave Young" <dyoung@redhat.com>
> > To: "AKASHI Takahiro" <takahiro.akashi@linaro.org>, "Philipp Rudo" <prudo@linux.ibm.com>, "catalin marinas"
> > <catalin.marinas@arm.com>, "will deacon" <will.deacon@arm.com>, dhowells@redhat.com, vgoyal@redhat.com,
> > herbert@gondor.apana.org.au, davem@davemloft.net, bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com, "heiko
> > carstens" <heiko.carstens@de.ibm.com>, "ard biesheuvel" <ard.biesheuvel@linaro.org>, "james morse"
> > <james.morse@arm.com>, bhsharma@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
> > linux-kernel@vger.kernel.org, "piliu@redhat.com Thiago Jung Bauermann" <bauerman@linux.vnet.ibm.com>
> > Sent: Thursday, August 9, 2018 11:34:16 AM
> > Subject: Re: [PATCH v13 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
> > 
> > Add more cc. Pingfan Liu confirmed ppc does not use 0 as valid address,
> > if so it should be safe.
> > 
> > Pingfan, can you add more words?
> > 
> 
> ppc64 uses a few KB starting from 0 for exception handler.

It assures that 0 (zero) is valid, but won't be assigned as a result of
kexec_add_buffer().

So do you think that yet I should submit another patch set, introducing
explicit KEXEC_BUF_MEM_UNKNOWN, while assuming 0 by default is safe for now?

Now that this is the only comment against my v13, it's up to you.

Thanks,
-Takahiro AKASHI


> > On 08/06/18 at 01:50pm, Dave Young wrote:
> > > Add Thiago in cc so that he can review from powerpc point of view.
> > > 
> > > On 08/02/18 at 09:01am, AKASHI Takahiro wrote:
> > > > Hi,
> > > > 
> > > > On Wed, Aug 01, 2018 at 10:29:51AM +0200, Philipp Rudo wrote:
> > > > > Hey Akashi,
> > > > > 
> > > > > I kept thinking about this patch and remembered why I didn't made the
> > > > > change
> > > > > you are suggesting now.
> > > > 
> > > > Hmm.
> > > > 
> > > > > The problem is when you only check for kbuf->mem you are excluding
> > > > > address 0,
> > > > > which might be a valid address to load the kernel to. On s390 this is
> > > > > actually
> > > > > done when the kernel is not loaded via a boot loader. For kexec_file
> > > > > however,
> > > > > we cut off the first few kB of the image and jump directly to
> > > > > 'startup'. So
> > > > > checking for !0 does not cause a problem here.
> > > > 
> > > > Yeah, as Dave(RedHat) described, all the current kexec-capable
> > > > architectures,
> > > > except arm64, implicitly initialize kbuf.mem to zero with "kbuf = { ...
> > > > }"
> > > > initializer. So surely my change would not break anything on the existing
> > > > code.
> > > > On the other hand, I also see your concern here.
> > > > 
> > > > > Anyway, the long term safer solution would be something like
> > > > > 
> > > > > #define KEXEC_BUF_MEM_UNKNOWN (-1UL)
> > > > > 
> > > > > for architectures to tell common code to search a fitting mem hole.
> > > > 
> > > > This would require the existing code on every arch to be modified, which
> > > > I think should be avoided if possible. Instead,
> > > > we'd better define in linux/kexec.h:
> > > >   #ifndef KEXEC_BUF_MEM_UNKNOWN
> > > >   #define KEXEC_BUF_MEM_UNKNOWN 0
> > > >   #endif
> > > > and then check for kbuf in kexec_locate_mem_hole():
> > > >   if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
> > > >         return 0;
> > > >   ...
> > > > 
> > > > This way if some arch wants to treat *zero* as a valid address, it can
> > > > redefine this macro in arch/asm/kexec.h.
> > > 
> > > I think this way works if powerpc is safe for using zero as the unknown
> > > address in this case.  Thiago, can you provide some review?
> > > 
> > > Philipp, thanks for catching the problem!
> > > 
> > > > 
> > > > Thanks,
> > > > -Takahiro AKASHI
> > > > 
> > > > > 
> > > > > Back then I didn't do the change because I had the other workaround,
> > > > > which
> > > > > didn't require a common code change. But when you are touching the code
> > > > > now it
> > > > > is worth thinking about it.
> > > > > 
> > > > > Just wanted to let you know
> > > > > Philipp
> > > > > 
> > > > > 
> > > > > On Wed,  1 Aug 2018 16:58:07 +0900
> > > > > AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> > > > > 
> > > > > > Since s390 already knows where to locate buffers, calling
> > > > > > arch_kexec_mem_walk() has no sense. So we can just drop it as
> > > > > > kbuf->mem
> > > > > > indicates this while all other architectures sets it to 0 initially.
> > > > > > 
> > > > > > This change is a preparatory work for the next patch, where all the
> > > > > > variant memory walks, either on system resource or memblock, will be
> > > > > > put in one common place so that it will satisfy all the
> > > > > > architectures'
> > > > > > need.
> > > > > > 
> > > > > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > > > Reviewed-by: Philipp Rudo <prudo@linux.ibm.com>
> > > > > > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > > > > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > > > > > Cc: Dave Young <dyoung@redhat.com>
> > > > > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > > > > Cc: Baoquan He <bhe@redhat.com>
> > > > > > ---
> > > > > >  arch/s390/kernel/machine_kexec_file.c | 10 ----------
> > > > > >  kernel/kexec_file.c                   |  4 ++++
> > > > > >  2 files changed, 4 insertions(+), 10 deletions(-)
> > > > > > 
> > > > > > diff --git a/arch/s390/kernel/machine_kexec_file.c
> > > > > > b/arch/s390/kernel/machine_kexec_file.c
> > > > > > index f413f57f8d20..32023b4f9dc0 100644
> > > > > > --- a/arch/s390/kernel/machine_kexec_file.c
> > > > > > +++ b/arch/s390/kernel/machine_kexec_file.c
> > > > > > @@ -134,16 +134,6 @@ int kexec_file_add_initrd(struct kimage *image,
> > > > > > struct s390_load_data *data,
> > > > > >  	return ret;
> > > > > >  }
> > > > > >  
> > > > > > -/*
> > > > > > - * The kernel is loaded to a fixed location. Turn off
> > > > > > kexec_locate_mem_hole
> > > > > > - * and provide kbuf->mem by hand.
> > > > > > - */
> > > > > > -int arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > > > > > -			int (*func)(struct resource *, void *))
> > > > > > -{
> > > > > > -	return 1;
> > > > > > -}
> > > > > > -
> > > > > >  int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> > > > > >  				     Elf_Shdr *section,
> > > > > >  				     const Elf_Shdr *relsec,
> > > > > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > > > > index 63c7ce1c0c3e..bf39df5e5bb9 100644
> > > > > > --- a/kernel/kexec_file.c
> > > > > > +++ b/kernel/kexec_file.c
> > > > > > @@ -534,6 +534,10 @@ int kexec_locate_mem_hole(struct kexec_buf
> > > > > > *kbuf)
> > > > > >  {
> > > > > >  	int ret;
> > > > > >  
> > > > > > +	/* Arch knows where to place */
> > > > > > +	if (kbuf->mem)
> > > > > > +		return 0;
> > > > > > +
> > > > > >  	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> > > > > >  
> > > > > >  	return ret == 1 ? 0 : -EADDRNOTAVAIL;
> > > > > 
> > > > 
> > > > _______________________________________________
> > > > kexec mailing list
> > > > kexec@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/kexec
> > > 
> > > Thanks
> > > Dave
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 

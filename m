Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EA2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A7F20658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqJgVAPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A7F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeHaOje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:39:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46732 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbeHaOjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:39:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id b129-v6so5254342pga.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 03:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+CTUHYsErLoJW3t3oCMBo1xNpD+PqSuEeAq3+/L7qA8=;
        b=lqJgVAPwSknFBuRMFvRMQOAhCBdsFx0y90UTo8p2PzXOO3HPKwuiSptIgnTY6puODe
         zqtRsCNBTrBZZaUCIrSZM+twTR4CDienL9BIQ71oodwnM0KrQPNuSN39GRsGBfUKVcRe
         Gl78hwGhA+y+SKNbzWzH3PCgj2dOzWFEhLndyk9862d56OhW/+Ng85wQG5JXx0kp+whI
         hESBG5TeA+B32LdSF7Zsc/zSXD+UqhIsYXdvgdR63VnHLZG5sW5yL/spSMWKEKgrEISM
         eyq5KKRTUU0hXAFuSeNwteUf+oCv0MXeZdE24mqiHoX8AMgZ7jVioEBFwFXCoe0Rc8GH
         YlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+CTUHYsErLoJW3t3oCMBo1xNpD+PqSuEeAq3+/L7qA8=;
        b=tYW8ZGfLQTJ+UXcvvfVRu/MQCE3TbaUF4MPJZKSmhs6ORe1s/UMtvg2airm8MxnPey
         CGSEDTSChlJLcPIAkacgmAwyhZ+hnhQguBN0wXZm/yR85Oz0hiaziKmCLfdhACJfrCkc
         AW/WI62kk9yd3qsna3eltAanQ/efJTv7jqaLFBwajdt1FfnupHyzgYzWgN96+sUXMWmo
         yjfoDDQbDgUoTb1pdhXVC+1SRScl7hMjETcIV/RTf23C9b5XG5rXnks5smFTw/oLasiN
         YdQm5l8KenG7thgglAzwhNahHGM5AtP7BIZ6mQ2W6BMYPw+tLhbo5/MajaTF6NYwvg2t
         blHg==
X-Gm-Message-State: APzg51Av7goS2yNjtHzlGnuFsWBMp7RTw4+Bdd4d3zTF5iBoWp/qLZ/8
        TseFOHtWkHqgMQauXtmJ4os=
X-Google-Smtp-Source: ANB0VdbjjP2gqkek4T8Rk9BCzb3qrVe1/ebpuprz/ngId5D6YUADl0qWbWkAvCIF653DKNCFcav5pg==
X-Received: by 2002:a62:cc41:: with SMTP id a62-v6mr15048258pfg.131.1535711562904;
        Fri, 31 Aug 2018 03:32:42 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id z63-v6sm13158622pgd.69.2018.08.31.03.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 03:32:42 -0700 (PDT)
Date:   Fri, 31 Aug 2018 20:32:34 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/12] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
Message-ID: <20180831203234.7b8f4d13@roar.ozlabs.ibm.com>
In-Reply-To: <20180831101014.GG24124@hirez.programming.kicks-ass.net>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
        <CA+55aFzMMU5RBhn52Lbzf-FXvx3inh5VPVZL613srY+dVU+Lxw@mail.gmail.com>
        <20180831110054.475a3534@roar.ozlabs.ibm.com>
        <CA+55aFyweLwdAeeLnPv1ceje2y9Qc2AkM+LdMzK_z29fFb96ug@mail.gmail.com>
        <20180831095417.GF13166@arm.com>
        <20180831101014.GG24124@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018 12:10:14 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Aug 31, 2018 at 10:54:18AM +0100, Will Deacon wrote:
> 
> > Proposal below (omitted Linus because that seems to be the pattern elsewhere
> > in the file and he's not going to shout at himself when things break :)
> > Anybody I've missed?
> > 
> > Will
> >   
> > --->8  
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a5b256b25905..7224b5618883 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9681,6 +9681,15 @@ S:	Maintained
> >  F:	arch/arm/boot/dts/mmp*
> >  F:	arch/arm/mach-mmp/
> >  
> > +MMU GATHER AND TLB INVALIDATION
> > +M:	Will Deacon <will.deacon@arm.com>
> > +M:	Nick Piggin <npiggin@gmail.com>

Oh gee, I suppose. powerpc hash is kind of interesting because it's
crazy, Aneesh knows that code a lot better than I do. radix modulo
some minor details of exact instructions is fairly like x86 (he 
wrote a lot of that code too AFAIK).

> > +M:	Peter Zijlstra <peterz@infradead.org>
> > +L:	linux-arch@vger.kernel.org

Maybe put linux-mm as well? Or should there just be one list?

> > +S:	Maintained
> > +F:	include/asm-generic/tlb.h
> > +F:	arch/*/include/asm/tlb.h
> > +
> >  MN88472 MEDIA DRIVER
> >  M:	Antti Palosaari <crope@iki.fi>
> >  L:	linux-media@vger.kernel.org  
> 
> If we're going to do that (and I'm not opposed); it might make sense to
> do something like the below and add:
> 
>  F:  mm/mmu_gather.c

I think that is a good idea regardless. How do feel about calling it
tlb.c? Easier to type and autocompletes sooner.

> 
> ---
>  b/mm/mmu_gather.c         |  250 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/asm-generic/tlb.h |    2 
>  mm/Makefile               |    2 
>  mm/memory.c               |  247 ---------------------------------------------

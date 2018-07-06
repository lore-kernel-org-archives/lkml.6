Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F14C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F7F23E0B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="BfAz6arm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F7F23E0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753946AbeGFKlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:41:53 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43161 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753455AbeGFKlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:41:52 -0400
Received: by mail-pl0-f68.google.com with SMTP id c41-v6so2709864plj.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 03:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jxs37GRyEAa5tV2D4gZOSFqQLduVpQfWCGij/yCC9ec=;
        b=BfAz6armzPEGMARe4VQpSEjixJeZ7J8d/pqZVAwKK8iLXPvrIfSUjK2VLb3XixjTbE
         BlGDMLeYFDDEp40+O9hoegH9jwxfRGsfFL/iMI3zzOA00XyCBxgiq/Lj8Zn8fJnm3Per
         Lc45gpLsmk6so6d5R7Fln0jE7rhMBn+1WxEfIeq/gbg55d0nRJp9h8FewUGSEKFsfHIS
         JIZzRRuTUaqND3iK3OpI3BwURvPGHp8QoUxqZgudb1pf8ZKmrlTYr2RHu0vnj1Ae0zap
         0U8muuaUNfqe7/cATeZ5y4yLeu397solocl9QX4a+Rlu4ovLvaez6ho0cTmrXbyM8WOC
         tiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jxs37GRyEAa5tV2D4gZOSFqQLduVpQfWCGij/yCC9ec=;
        b=RbvUaNwp/PpF2avqJCtrror+lDhxEh8XXrPUK9lchcWQyHF4lAsZzO4VQI+RR8wkH0
         51Ufs60UMHviC6rQimO1GWMkxTKnemvblu5YlFmcFduA42fat/RSGVwu9zM+FLS6lN6q
         UgF27H+iYKcTKdrCCrbtBZAb6VJ40WSNyXqm2hTFSYVnafN3yFn4hC1EUAeljpliC4Lq
         LvxRWqBoy9jSobuWo/Dlnv3nKk12f+pIg8LBG/Lsps1/uPRvCYQkmoSCqz2Pepdt2DJK
         VLxmZXqXEoB2OPL6CH1t5IP79ZfDIc8V0Y4zeJhvBWbjSA7G8KwwlCFVvd69hiEKpr0x
         +Eag==
X-Gm-Message-State: APt69E0Yf8nBtTWYnwACkq3oYA1uQmu6zfvUSJ3m6mB0KMAoblEao6BN
        OLJFoHyZ99X45SdyZwwv8B8i2w==
X-Google-Smtp-Source: AAOMgpcYNACPKzbaFkEehJQICvr61OC4EyLTB068aM4qt9x9CsKjm49z78WwNbZDfv79l3U6qCfK/g==
X-Received: by 2002:a17:902:5481:: with SMTP id e1-v6mr9862274pli.7.1530873711515;
        Fri, 06 Jul 2018 03:41:51 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id f6-v6sm11995166pgp.13.2018.07.06.03.41.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 03:41:50 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 4360430003D; Fri,  6 Jul 2018 13:41:44 +0300 (+03)
Date:   Fri, 6 Jul 2018 13:41:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Gabriel C <nix.or.die@gmail.com>,
        Benjamin Gilbert <bgilbert@redhat.com>,
        linux-x86_64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        bero@lindev.ch, Andi Kleen <ak@linux.intel.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
Message-ID: <20180706104144.6p2s43o3sqc6d5y3@kshutemo-mobl1>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems>
 <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
 <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1>
 <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
 <20180704150857.szamkvy6jx3fqxlf@kshutemo-mobl1>
 <CAK7LNARMbt0h4WVdzPzKhMQD-M4ABjffjo4TdtK40RV-NGzTLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARMbt0h4WVdzPzKhMQD-M4ABjffjo4TdtK40RV-NGzTLw@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 03:37:58PM +0900, Masahiro Yamada wrote:
> >> > > Also see https://bugzilla.kernel.org/show_bug.cgi?id=200385 ,
> >> > >
> >> > > 0a1756bd2897951c03c1cb671bdfd40729ac2177 is acting up
> >> > > too with the same symptoms
> >> >
> >> > I tracked it down to -flto in LDFLAGS. I'll look more into this.
> >>
> >> -flto in LDFLAGS screws up this part of paging_prepare():
> >
> > +Masahiro, Michal.
> >
> > I've got it wrong. *Any* LDFLAGS option passed to make this way:
> >
> >   make LDFLAGS="..."
> >
> > would cause a issue. Even empty.
> >
> > It overrides all assignments to the variable in the makefile.
> > As result the image is built without -pie and linker doesn't generate
> > position independed code.
> >
> > Looks like the patch below helps, but my make-fu is poor.
> > I don't see many override directives in kernel makefiles.
> > It makes me think that there's a better way to fix this.
> >
> > Hm?
> 
> 
> LDFLAGS is for internal-use.
> Please do not override it from the command line.

Can we generate a build error if a user try to override LDFLAGS, CFLAGS or
other critical internal-use-only variables?

This breakage was rather hard to debug. We need to have some kind of
fail-safe for the future.

> You want to pass your own linker flags
> for building vmlinux and modules,
> but do not want to pass them to
> the decompressor (arch/x86/boot/compressed).
> 
> Correct?

I personally don't think that changing compiler/linker options for kernel
build is good idea in general.

> Kbuild provides a way for users
> to pass additional linker flags to modules.
> (LDFLAGS_MODULE)
> 
> 
> But, there is no way to do that for vmlinux.
> 
> It is easy to support it, though.
> 
> https://patchwork.kernel.org/patch/10510833/
> 
> If this is the one you want, I can merge this.
> 
> 
> make LDFLAGS_KERNEL=...  LDFLAGS_MODULE=...
> will allow you to append linker flags.

Okay. It makes me wounder if we should taint kernel in such cases?
Custom compiler/linker flags are risky and can lead to weird bugs.

-- 
 Kirill A. Shutemov

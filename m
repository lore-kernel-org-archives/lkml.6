Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAF4C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3508323E14
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3508323E14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbeFVHPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:15:52 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36180 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeFVHPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:15:51 -0400
Received: by mail-oi0-f66.google.com with SMTP id 14-v6so5281585oie.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 00:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Tb3Ce87FAOkNHrrHzLNJH34R5gLXJvg5QWr1VX08w8=;
        b=ns2wOlQ5Xxczu4lO/k1fv/5+FQ9rpV8GVhVyq8xKPPWXphGQHi0LXRjda6Lg+oauyR
         1A1E+tBLl6w7ZWn/8kcppQriEM/3QaKxlNRWtE8UJCNNwtxBMSyLrhzo4gzYNK4fGQ9D
         IOQEw/yrrX124qC2LNr+59dfbxs8UNzyq+aGeqhHBZ1RUHc6BMexXsnyLXqVyFrEQdTc
         Y+RZ2Atu8kJJWX8r+pOm1wBQR/IIkc0/xMdp/3k5t5PnGcFiYSKwmhCu+QRN+Jd/5HeN
         KgxCLVkupIWRh7kTroK+xmRzEgHb6Bgjw2c7bJ50s+RXgSWeDi1KZYAdTxIUbbTmXtFw
         PZlA==
X-Gm-Message-State: APt69E0xvjp8ku3/p47ocEhue7MPkjZU0/DEGurzGah2V0Rqtx0XJEyq
        W1rTYcGl/8oPjgyp1nj8EZ6Ori9Wslj/ah2ZLDfSpz3I
X-Google-Smtp-Source: ADUXVKJqPs8uKU+4bOXXIhdMSqHkDEcfc/K/bEoS+vD6WNhTEFsUsed4q/ECgugZyP+bJPQB01DlwmIXJBUgBrvJVSk=
X-Received: by 2002:aca:ad91:: with SMTP id w139-v6mr232712oie.107.1529651750660;
 Fri, 22 Jun 2018 00:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180408194821.19682-1-malat@debian.org> <20180620190038.3250-1-malat@debian.org>
 <87602cfkh5.fsf@concordia.ellerman.id.au>
In-Reply-To: <87602cfkh5.fsf@concordia.ellerman.id.au>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 22 Jun 2018 09:15:39 +0200
Message-ID: <CA+7wUswdBvm+XCi6r6ewGFuSTAaV9FWmhUyV9vNKatCnurvL-A@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/32: Remove left over function prototypes
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 1:27 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Mathieu Malaterre <malat@debian.org> writes:
>
> > In commit 4aea909eeba3 ("powerpc: Add missing prototypes in setup_32.c")
>
> I don't have that commit ^ ?
>
> That might be because I squashed some of your fixes together or something?

I am doing an awful lots of mistakes these days. Indeed you've changed
one of my patch:

https://patchwork.kernel.org/patch/10240997/

This one appeared after a git rebase on my side.

> > diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
> > index 35ca309848d7..829ed66f0a40 100644
> > --- a/arch/powerpc/kernel/setup.h
> > +++ b/arch/powerpc/kernel/setup.h
> > @@ -19,9 +19,6 @@ void irqstack_early_init(void);
> >  void setup_power_save(void);
> >  unsigned long __init early_init(unsigned long dt_ptr);
> >  void __init machine_init(u64 dt_ptr);
> > -int __init ppc_setup_l2cr(char *str);
> > -int __init ppc_setup_l3cr(char *str);
> > -int __init ppc_init(void);
> >  #else
> >  static inline void setup_power_save(void) { };
> >  #endif
>
> I have:
>
> #ifdef CONFIG_PPC32
> void setup_power_save(void);
> #else
> static inline void setup_power_save(void) { };
> #endif

Correct.

Sorry for the noise.

>
> cheers

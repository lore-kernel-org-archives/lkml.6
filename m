Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569A5C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010942177A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uaMhBVcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010942177A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbeHCT0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:26:30 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36809 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbeHCT03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:26:29 -0400
Received: by mail-it0-f66.google.com with SMTP id p81-v6so9458021itp.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 10:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6qe4QD2LITbU4cVVLz54Rwb7sR4qWtD3odJGTkSZFo=;
        b=uaMhBVccsUSJOtj6Mk8iiZKvXyzUHHxq3+dbCMAVm77aG47DAzi+bA0uYK3f9oX8qv
         BWjzXc/ody3Uu98OOr3JJCj3YySRpRjUG4LgLrCaO39Aof1x0sCqcRXGSniL5PSmrPtF
         XqDICRKBM6bOl4d0CT7Vsh+TMxHC8VGOU49C9F/ZhmVq9+velTNEurc/WM4VcZvB9GDR
         TzG7gNxl0QUMlDD+0JCbL1/EYelBzxXOAadLjII7u7TNb9um3/ete5lXG4wjeSbXzHB0
         i/Q3/xPaseYBiaooFBYZMFmaRj8NLT3HkI1g451fcqbcBrhpc3OgRFwCa6kGYfvbre4i
         eoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6qe4QD2LITbU4cVVLz54Rwb7sR4qWtD3odJGTkSZFo=;
        b=lK7R0N1X0RnHZPOsF63Zcz5RMfRLbbvbIrv6VIXyL2kRgTiOcdkDQu/txzB/4oxrq+
         lcRv48fNku0VXoVUcxoctyoBCSHINSyhldJ6qeHys3+7N1vJLAWxIoVNCqP0+IxLs6b/
         8wXAnqPQb/W3YFUr5KLI3WCZ4zXhm6mIOVqI809Gy1VcvLy5qJJGTRYy/xxcAHiqTMNe
         WPlo6k0q70qpgPT6Vdp6nfA9WqDSCk0QZb2kSSkZk7ZscE9QHW8lq7k29e8BhbbbsdSB
         +pMONIzQ2cVZUsgF5jRY/5KaCehNOTPO6Ik5z89wWpFGGMIkvKTxpTDMYs9ULNO4yK5t
         /M6A==
X-Gm-Message-State: AOUpUlGD4uaDF721MUQJ9mzjGDGFuJq9fih6+1I3ai/xqeF1wsQOdtcB
        Hm2EtHY/L64bduUcGYCvVOQ4oyZzMWIP3V7tPmn3L5oePJg=
X-Google-Smtp-Source: AAOMgpfSS0tf4dXFC6+ZKIZzN45RW+LWCVPfqpOFgYzKeGcIueR2cg+a+t6iLAluBr8GDRbihA6xYKHFHAIaNh5j/o4=
X-Received: by 2002:a24:6c8a:: with SMTP id w132-v6mr7280934itb.141.1533317354819;
 Fri, 03 Aug 2018 10:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180718224159.18236-1-astrachan@google.com> <alpine.DEB.2.21.1808031223500.1745@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1808031223500.1745@nanos.tec.linutronix.de>
From:   Alistair Strachan <astrachan@google.com>
Date:   Fri, 3 Aug 2018 10:29:04 -0700
Message-ID: <CANDihLEy1zQy=ACvZh=kRSZYqNnGYoA4-sCPZfzziBWAPXqinA@mail.gmail.com>
Subject: Re: [PATCH] x86: vdso: Use $LD instead of $CC to link
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        hpa@zytor.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, kernel-team@android.com, joel@joelfernandes.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 3:26 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, 18 Jul 2018, Alistair Strachan wrote:
> >  export CPPFLAGS_vdso.lds += -P -C
> >
> > -VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
> > -                     -Wl,--no-undefined \
> > -                     -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096 \
> > -                     $(DISABLE_LTO)
> > +VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
> > +                     -z max-page-size=4096 -z common-page-size=4096
>
> Aside of the fact that it does not apply to upstream,

It seems to apply fine to Linus's tree (0585df4), but I'll send a v2
which is rediffed.

> why is this dropping
> the $(DISABLE_LTO) part?
>
> The changelog is utterly silent about that.

$ git grep DISABLE_LTO
arch/sparc/vdso/Makefile:KBUILD_CFLAGS += $(DISABLE_LTO)
arch/sparc/vdso/Makefile:                       $(DISABLE_LTO)
arch/x86/entry/vdso/Makefile:KBUILD_CFLAGS += $(DISABLE_LTO)
arch/x86/entry/vdso/Makefile:                   $(DISABLE_LTO)
kernel/Makefile:CFLAGS_sys_ni.o = $(DISABLE_LTO)
scripts/Makefile.build:cmd_cc_s_c       = $(CC) $(c_flags)
$(DISABLE_LTO) -fverbose-asm -S -o $@ $<

Looks like a dead option to me, but maybe somebody else knows better.
v2 will explain this removal.

> Thanks,
>
>         tglx

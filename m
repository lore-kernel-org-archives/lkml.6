Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D811ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D97520818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="E706BHL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D97520818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbeKIHA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:00:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38491 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbeKIHA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:00:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id f2-v6so116676wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 13:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Fm+Swwz5U6PYgdF4xz3yvF0Ae+TVaAPPC+XBP1RMAY=;
        b=E706BHL0Td3myb4413EwEA1PhNfwbex5uMj+f31Sv1vypjDGhg3Ry8ZMpr6jUhq7JI
         Pm1oqp/XMJ7g2jwJUZXRiOH0BhwPq7WEUFskMxiV4QUb8BTVzOItGsNAwDpzbcF9LiAi
         nM/JyQif/POUtX3zV9LqpeMzmZ1MDjVF8edn/5HIez3tnVH1TSEH1JpeyqCWV1pdrkjH
         zw77zTBffvybM4PLLRgxhLjKeCNkGDhwNPamR7rFmaYJ0yL7vyQsYPWyIB9zGE/25PrV
         5DFkRkEr6rEVkBk16gvVZv6wfT84lVTypKJugSbE14Ue5T3WLoK8Yz2g60amCTLl/O/q
         +MOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Fm+Swwz5U6PYgdF4xz3yvF0Ae+TVaAPPC+XBP1RMAY=;
        b=eCEb0EqdLkuSZRSBRY094FXIc/sxZHCZDLwUsM4FoZEfCcITPlDw+Z7EoNYP+NDoGp
         OEP8TyZhyAap5tkaXpZ5W82NdvQRU3bqRw3AnLYpd8ibJ2aG9/1iez4BNbuA+urfrdmf
         ViT4ukgj2fT7HMO4rjODCiO56hvrJDnHMBi2Cb0vlnMcXG2tVCsdnMvTF2WHkPW5YWK4
         8hIcB7xaBCt+FSitA+0sz73R0Z1Zg8syF7GABAG68B9fyQczd5604dDtBgK8o6OjyNLr
         r+IbFKSWqn7WlPNxc3Luh9JSyXtj0FaCTPPO5O0Ar8wMSRjH9Xqke0KNXBQL2of6QbrS
         sGdw==
X-Gm-Message-State: AGRZ1gK7+dn9cvGhxqu9lEHCveZ0hJmFMkWJOLSTA8+yinXCJs+iNjvL
        OKC1aGVRXRjx+I/oeobRJLGkuddjfqqJzB/77lnTxA==
X-Google-Smtp-Source: AJdET5f3qm2+Se9JRO2uShWB+aZYI4xGcIp8Ei4ckDSNwMSVm4Vs9gfxgnH/ClkF1tgiBk+VpHdLJQOv253gUKyjBW4=
X-Received: by 2002:a1c:4b1a:: with SMTP id y26-v6mr2593259wma.82.1541712184530;
 Thu, 08 Nov 2018 13:23:04 -0800 (PST)
MIME-Version: 1.0
References: <20181011151523.27101-1-yu-cheng.yu@intel.com> <20181011151523.27101-5-yu-cheng.yu@intel.com>
 <CALCETrVAe8R=crVHoD5QmbN-gAW+V-Rwkwe4kQP7V7zQm9TM=Q@mail.gmail.com> <4295b8f786c10c469870a6d9725749ce75dcdaa2.camel@intel.com>
In-Reply-To: <4295b8f786c10c469870a6d9725749ce75dcdaa2.camel@intel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 8 Nov 2018 13:22:54 -0800
Message-ID: <CALCETrUKzXYzRrWRdi8Z7AdAF0uZW5Gs7J4s=55dszoyzc29rw@mail.gmail.com>
Subject: Re: [PATCH v5 04/27] x86/fpu/xstate: Add XSAVES system states for
 shadow stack
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 1:06 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> On Thu, 2018-11-08 at 12:46 -0800, Andy Lutomirski wrote:
> > On Thu, Oct 11, 2018 at 8:20 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > >
> > > Intel Control-flow Enforcement Technology (CET) introduces the
> > > following MSRs into the XSAVES system states.
> > >
> > >     IA32_U_CET (user-mode CET settings),
> > >     IA32_PL3_SSP (user-mode shadow stack),
> > >     IA32_PL0_SSP (kernel-mode shadow stack),
> > >     IA32_PL1_SSP (ring-1 shadow stack),
> > >     IA32_PL2_SSP (ring-2 shadow stack).
> > >
> > > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > > ---
> > >  arch/x86/include/asm/fpu/types.h            | 22 +++++++++++++++++++++
> > >  arch/x86/include/asm/fpu/xstate.h           |  4 +++-
> > >  arch/x86/include/uapi/asm/processor-flags.h |  2 ++
> > >  arch/x86/kernel/fpu/xstate.c                | 10 ++++++++++
> > >  4 files changed, 37 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/include/asm/fpu/types.h
> > > b/arch/x86/include/asm/fpu/types.h
> > > index 202c53918ecf..e55d51d172f1 100644
> > > --- a/arch/x86/include/asm/fpu/types.h
> > > +++ b/arch/x86/include/asm/fpu/types.h
> > > @@ -114,6 +114,9 @@ enum xfeature {
> > >         XFEATURE_Hi16_ZMM,
> > >         XFEATURE_PT_UNIMPLEMENTED_SO_FAR,
> > >         XFEATURE_PKRU,
> > > +       XFEATURE_RESERVED,
> > > +       XFEATURE_SHSTK_USER,
> > > +       XFEATURE_SHSTK_KERNEL,
> > >
> > >         XFEATURE_MAX,
> > >  };
> > > @@ -128,6 +131,8 @@ enum xfeature {
> > >  #define XFEATURE_MASK_Hi16_ZMM         (1 << XFEATURE_Hi16_ZMM)
> > >  #define XFEATURE_MASK_PT               (1 <<
> > > XFEATURE_PT_UNIMPLEMENTED_SO_FAR)
> > >  #define XFEATURE_MASK_PKRU             (1 << XFEATURE_PKRU)
> > > +#define XFEATURE_MASK_SHSTK_USER       (1 << XFEATURE_SHSTK_USER)
> > > +#define XFEATURE_MASK_SHSTK_KERNEL     (1 << XFEATURE_SHSTK_KERNEL)
> > >
> > >  #define XFEATURE_MASK_FPSSE            (XFEATURE_MASK_FP |
> > > XFEATURE_MASK_SSE)
> > >  #define XFEATURE_MASK_AVX512           (XFEATURE_MASK_OPMASK \
> > > @@ -229,6 +234,23 @@ struct pkru_state {
> > >         u32                             pad;
> > >  } __packed;
> > >
> > > +/*
> > > + * State component 11 is Control flow Enforcement user states
> > > + */
> > > +struct cet_user_state {
> > > +       u64 u_cet;      /* user control flow settings */
> > > +       u64 user_ssp;   /* user shadow stack pointer */
> > > +} __packed;
> > > +
> > > +/*
> > > + * State component 12 is Control flow Enforcement kernel states
> > > + */
> > > +struct cet_kernel_state {
> > > +       u64 kernel_ssp; /* kernel shadow stack */
> > > +       u64 pl1_ssp;    /* ring-1 shadow stack */
> > > +       u64 pl2_ssp;    /* ring-2 shadow stack */
> > > +} __packed;
> > > +
> >
> > Why are these __packed?  It seems like it'll generate bad code for no
> > obvious purpose.
>
> That prevents any possibility that the compiler will insert padding, although in
> 64-bit kernel this should not happen to either struct.  Also all xstate
> components here are packed.
>

They both seem like bugs, perhaps.  As I understand it, __packed
removes padding, but it also forces the compiler to expect the fields
to be unaligned even if they are actually aligned.

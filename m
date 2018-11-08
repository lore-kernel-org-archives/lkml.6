Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CF1ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B921C20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="OGaoTl5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B921C20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeKIGXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:23:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34607 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbeKIGXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:23:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so22723618wre.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 12:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DLl2v3vIw7M0YRcW5fy9V9s5+BwSa4Xzl7tiDfa/DtQ=;
        b=OGaoTl5bZvC9kcZMZ5J7lTfdHXQQAVXjRK1OqlZwyTQ4Tb8BKh3noqY2Gre4c+qQRv
         4vDwf6ZPuvbnrgYAk/VCZmA0+gpu4vZFANsi0eUASrwFqAX+67F88Q2GietX/vqLviYZ
         gzw9dGo8JwcLXZ6SOs5YvJ2LZ5KbNUwiu85XdZa3CsbFHCrFbVb1WAIa6QM4w8JGMI5B
         W+NEEaDokByG2UaagkODirIEjmtFw9EA7IKaBf429uM0k8tjPmpa5y6Yy5b6GRM/QzfG
         2vUSnRWLcRc4z/D/9AlPUdIxpgtgEhHf7Cxmx4Gna5G1GBejneZ4n/zpFA/IQZlfYC7b
         K02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DLl2v3vIw7M0YRcW5fy9V9s5+BwSa4Xzl7tiDfa/DtQ=;
        b=InmADm31pmNtAUw3eq0OCyzyYJE1MVSo+QjNYsEBx/PRip5i69cLA+6ZAjeu7r+jix
         3Of/BXD/RtIyzb8xFiPdlT0twqQWqrkQiRfvT1WkYWja8/HIx/xNgADpG8I8KcYPF1ey
         138+C4Ztemzv6B/AUcO2IZkg8FKj8VINAEWOg5+HSaKZh1pSBnZ8Hz1OV8mHsqOpG2VH
         aIKEmILhHcuhM0w8xX1tyCIxy1RzRfCJFfpcGEsKrwo0mf6GVQ9FvKrjq95Y+fqnSOxj
         an65tlMvKjIMZaJa72aZSjYq9oly2lk58RD4aiGhOokS8kifdvG4NX2gEzx0liKfUfOZ
         umqw==
X-Gm-Message-State: AGRZ1gLIu504F+TUIvnmUiI64XIpx0wxkB7uajZWU2OE8HbvC3IsPsBM
        NyeOu9DPNHaMSSnTL4AWz6Eow+wlvkYWRlonKbQsPA==
X-Google-Smtp-Source: AJdET5cXZ+fRO+fyHIIeJUOZCeXLMkTxoTTaF1EOu4aDPs/jsY4nq5rL+OYsKpYPQowDhUPjYFok7NEMCowXy/ABi+s=
X-Received: by 2002:a5d:4450:: with SMTP id x16-v6mr5508356wrr.308.1541709999716;
 Thu, 08 Nov 2018 12:46:39 -0800 (PST)
MIME-Version: 1.0
References: <20181011151523.27101-1-yu-cheng.yu@intel.com> <20181011151523.27101-5-yu-cheng.yu@intel.com>
In-Reply-To: <20181011151523.27101-5-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 8 Nov 2018 12:46:29 -0800
Message-ID: <CALCETrVAe8R=crVHoD5QmbN-gAW+V-Rwkwe4kQP7V7zQm9TM=Q@mail.gmail.com>
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

On Thu, Oct 11, 2018 at 8:20 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> Intel Control-flow Enforcement Technology (CET) introduces the
> following MSRs into the XSAVES system states.
>
>     IA32_U_CET (user-mode CET settings),
>     IA32_PL3_SSP (user-mode shadow stack),
>     IA32_PL0_SSP (kernel-mode shadow stack),
>     IA32_PL1_SSP (ring-1 shadow stack),
>     IA32_PL2_SSP (ring-2 shadow stack).
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/fpu/types.h            | 22 +++++++++++++++++++++
>  arch/x86/include/asm/fpu/xstate.h           |  4 +++-
>  arch/x86/include/uapi/asm/processor-flags.h |  2 ++
>  arch/x86/kernel/fpu/xstate.c                | 10 ++++++++++
>  4 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
> index 202c53918ecf..e55d51d172f1 100644
> --- a/arch/x86/include/asm/fpu/types.h
> +++ b/arch/x86/include/asm/fpu/types.h
> @@ -114,6 +114,9 @@ enum xfeature {
>         XFEATURE_Hi16_ZMM,
>         XFEATURE_PT_UNIMPLEMENTED_SO_FAR,
>         XFEATURE_PKRU,
> +       XFEATURE_RESERVED,
> +       XFEATURE_SHSTK_USER,
> +       XFEATURE_SHSTK_KERNEL,
>
>         XFEATURE_MAX,
>  };
> @@ -128,6 +131,8 @@ enum xfeature {
>  #define XFEATURE_MASK_Hi16_ZMM         (1 << XFEATURE_Hi16_ZMM)
>  #define XFEATURE_MASK_PT               (1 << XFEATURE_PT_UNIMPLEMENTED_SO_FAR)
>  #define XFEATURE_MASK_PKRU             (1 << XFEATURE_PKRU)
> +#define XFEATURE_MASK_SHSTK_USER       (1 << XFEATURE_SHSTK_USER)
> +#define XFEATURE_MASK_SHSTK_KERNEL     (1 << XFEATURE_SHSTK_KERNEL)
>
>  #define XFEATURE_MASK_FPSSE            (XFEATURE_MASK_FP | XFEATURE_MASK_SSE)
>  #define XFEATURE_MASK_AVX512           (XFEATURE_MASK_OPMASK \
> @@ -229,6 +234,23 @@ struct pkru_state {
>         u32                             pad;
>  } __packed;
>
> +/*
> + * State component 11 is Control flow Enforcement user states
> + */
> +struct cet_user_state {
> +       u64 u_cet;      /* user control flow settings */
> +       u64 user_ssp;   /* user shadow stack pointer */
> +} __packed;
> +
> +/*
> + * State component 12 is Control flow Enforcement kernel states
> + */
> +struct cet_kernel_state {
> +       u64 kernel_ssp; /* kernel shadow stack */
> +       u64 pl1_ssp;    /* ring-1 shadow stack */
> +       u64 pl2_ssp;    /* ring-2 shadow stack */
> +} __packed;
> +

Why are these __packed?  It seems like it'll generate bad code for no
obvious purpose.

Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79B6C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8991320873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Su6v94ta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8991320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389611AbeGKTnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:43:16 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39804 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389486AbeGKTnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:43:15 -0400
Received: by mail-oi0-f68.google.com with SMTP id d189-v6so51378967oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3LXUR9nQD0pc+O2mZgeYpMpc/NwJ3OV10XN889Lpzk=;
        b=Su6v94tanbltsA+6+y8Rq9aI2A/VZ4v1G7rQ2r6JD26Uep44LItZocVVqss6fqkL5P
         eTs6//9kiW7/L6xn30kRsce3AIvFAdvkTlJyrI34DOm7R8OHBUVoVeNUJKbmM67d6NhQ
         ZM07JL2i5//NSlJsKRk12TTARh1Hfs7sLZW6+AliKW8LKAGNgPThgntFbrAQdAFpx/8X
         ZlKuX16LlBFPuCLayvW+cgKFopV4r9eWkB2BJ++LnM8Mpfjdpr3m6/tYQGbw2IkcFHNP
         LDtn1W+4yeHcEHbYX1yescRr/TRb8xNhaazB1hXREjmzEZl6xUMOykSVqKfsrFHEyQvy
         4agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3LXUR9nQD0pc+O2mZgeYpMpc/NwJ3OV10XN889Lpzk=;
        b=Z7m/yNX9MaFJHpCGgZ80fJnBX7JNtFBRv5AkuupCqi/sPP5AW+thDG1qK2S35aNOMF
         ukgxQvEhBuSDqERDR6b+BUm/vaDLuZqzpRIaSMolbOpmdd0TX5DSBZvv9pe4I/vCIOFw
         SQK39DUQQG21nmsWKwI3corKcVHqUfgbd3H/to/EKE5u4sIQgh2r3MDdwoR4r0FK7tf8
         igBjEFQvhsj5Km3EGpBOLGxK1gfSlYaO+WViM+ZN/vdtoF6UwZP+52BFFib8z0ZWNYDB
         r/tilykyPGDKqnIkBVbzq7Fa4N1ZQRzsc2DCWWAt5oKK+0K+10zex39ThOQoziRAXUjV
         Mu5g==
X-Gm-Message-State: AOUpUlGMBZY1qdkHGJySGbvMO8wUehsetUvLm3kqc9QP24zN95FWrF6x
        IdnDEwgLxLSOqSjqLFw72So3AUElyULkR70E4RGVbg==
X-Google-Smtp-Source: AAOMgpeF4GgY637d33fRYpggwzoIXKNrirwsqo+1PKoudyAEWAm+FjJG3CbbbEHFME3u9XFaFTmMYMdT8ByA0y/dEE4=
X-Received: by 2002:aca:5155:: with SMTP id f82-v6mr742047oib.272.1531337846593;
 Wed, 11 Jul 2018 12:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180710222639.8241-1-yu-cheng.yu@intel.com> <20180710222639.8241-21-yu-cheng.yu@intel.com>
In-Reply-To: <20180710222639.8241-21-yu-cheng.yu@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 11 Jul 2018 12:37:00 -0700
Message-ID: <CAG48ez3DYQtgk_WfOwbFFeuWJmzwZhH-DkDT1UKYVZaYi6V_Pg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 20/27] x86/cet/shstk: ELF header parsing of CET
To:     yu-cheng.yu@intel.com
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>, bsingharora@gmail.com,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>, hjl.tools@gmail.com,
        Jonathan Corbet <corbet@lwn.net>, keescook@chromiun.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        ravi.v.shankar@intel.com, vedvyas.shanbhogue@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 3:31 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> Look in .note.gnu.property of an ELF file and check if shadow stack needs
> to be enabled for the task.
>
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
[...]
> diff --git a/arch/x86/kernel/elf.c b/arch/x86/kernel/elf.c
> new file mode 100644
> index 000000000000..233f6dad9c1f
> --- /dev/null
> +++ b/arch/x86/kernel/elf.c
[...]
> +#define NOTE_SIZE_BAD(n, align, max) \
> +       ((n->n_descsz < 8) || ((n->n_descsz % align) != 0) || \
> +        (((u8 *)(n + 1) + 4 + n->n_descsz) > (max)))

Please do not compute out-of-bounds pointers and then compare them
against an expected maximum pointer. Computing an out-of-bounds
pointer is undefined behavior according to the C99 specification,
section "6.5.6 Additive operators", paragraph 8; and in this case,
n->n_descsz is 32 bits wide, which means that even if the compiler
isn't doing anything funny, if you're operating on addresses in the
last 4GiB of virtual memory and the pointer wraps around, this could
break.
In particular, if anyone ever uses this code in a 32-bit kernel, this
is going to blow up.
Please use size comparisons instead of pointer comparisons.

> +
> +/*
> + * Go through the property array and look for the one
> + * with pr_type of GNU_PROPERTY_X86_FEATURE_1_AND.
> + */
> +static u32 find_x86_feature_1(u8 *buf, u32 size, u32 align)
> +{
> +       u8 *end = buf + size;
> +       u8 *ptr = buf;
> +
> +       while (1) {
> +               u32 pr_type, pr_datasz;
> +
> +               if ((ptr + 4) >= end)
> +                       break;

Theoretical UB.

> +               pr_type = *(u32 *)ptr;
> +               pr_datasz = *(u32 *)(ptr + 4);
> +               ptr += 8;
> +
> +               if ((ptr + pr_datasz) >= end)
> +                       break;

UB, like in NOTE_SIZE_BAD().

> +               if (pr_type == GNU_PROPERTY_X86_FEATURE_1_AND &&
> +                   pr_datasz == 4)
> +                       return *(u32 *)ptr;
> +
> +               ptr += pr_datasz;
> +       }
> +       return 0;
> +}
[...]
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 0ac456b52bdd..3395f6a631d5 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1081,6 +1081,22 @@ static int load_elf_binary(struct linux_binprm *bprm)
>                 goto out_free_dentry;
>         }
>
> +#ifdef CONFIG_ARCH_HAS_PROGRAM_PROPERTIES
> +
> +       if (interpreter) {
> +               retval = arch_setup_features(&loc->interp_elf_ex,
> +                                            interp_elf_phdata,
> +                                            interpreter, true);
> +       } else {
> +               retval = arch_setup_features(&loc->elf_ex,
> +                                            elf_phdata,
> +                                            bprm->file, false);
> +       }

So for non-static binaries, the ELF headers of ld.so determine whether
CET will be on or off for the entire system, right? Is the intent here
that ld.so should start with CET enabled, and then either use the
compatibility bitmap or turn CET off at runtime if the executable or
one of the libraries doesn't actually work with CET?

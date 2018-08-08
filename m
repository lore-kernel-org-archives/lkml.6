Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B59C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5524B219EF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQxwC2CJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5524B219EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbeHHWyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 18:54:22 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41801 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHHWyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 18:54:22 -0400
Received: by mail-yw1-f66.google.com with SMTP id q129-v6so2566047ywg.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 13:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=42tBd4zeomd3c7Yh54htW6IrZr3FrXTnYZPQu0HwDpc=;
        b=gQxwC2CJgLE/5MmmBc1dHo05XFsVSPapnrTvD4vGyCfMbFATBDq64ost0fWU9FA60I
         FRI5p+2bEYh5qpxX5ZEahwL8YVRTnUR/3Qig/E7nnux1WOGRgFxoFMV2w92wrCfB7rsz
         ceLo/0nTrbhSpA70QYq2YalZvSYaEEEfV9JIAiu2KfTrIsaUbrsidsW8+57rbUTIAVVr
         skec6i43ss1iEH/aW1RuNAJcqEu621Aa9KhNZhu97FDgGD79yGKP8496Z1sCnR75peWa
         wxRk9uiMEYXZZ06P3w0bC2le/Itq+lg2sXjrLya4EeyziCTTacaJsXA2WQaNf2/OCYx/
         Nw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=42tBd4zeomd3c7Yh54htW6IrZr3FrXTnYZPQu0HwDpc=;
        b=dRBnaN9WrynXHizImGngQV3/HPgN/Jz34vLwKG6Tpml46H/JOo+c+0UW7oTzdbZlli
         ko0z+c6TiOfDOxPjnwsyIntAmaoRBS18SzfS2Dnay/IQsWoDNDuVNo2ooHXz7i5CJvlk
         5rCv8DCX9mNpSC7wCoro56wSJlJfuYBx6PCwLexZf/8j5GwsdKBN2vlwhxQqXJibP4um
         JdAQdMSbAyqnN1LfIPJXmUahq+YzS3UIVOQacAbmSsucUQ46EtL0ZQq/x8rYigIsprhV
         gHVKYBYABYsNgNvnGH3TyrqgBYy+P+YDNM02E2Q+PaxYRsqfOfl0DqgECKQL0QWit1AT
         kGCg==
X-Gm-Message-State: AOUpUlELVGOIr1h9OIG7li5KUEzm+LtpiKDfwDf4Z/8pyoC+z0A0LGka
        hoFnAAuwSIzRtchOIFFxGvG96/1Wg7uXYaRov0pLYQ==
X-Google-Smtp-Source: AA+uWPwVrWwzQgC+hlyqK2b7xzmitqoPMySCy1YcKvmNXfQuqW0Z2qlwW+83uIUJ2cy20dmhKZqTKJZMe1hWZOjzeWQ=
X-Received: by 2002:a81:2706:: with SMTP id n6-v6mr2285868ywn.88.1533760381770;
 Wed, 08 Aug 2018 13:33:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:7450:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 13:33:01 -0700 (PDT)
In-Reply-To: <1533727000-9172-1-git-send-email-joro@8bytes.org>
References: <1533727000-9172-1-git-send-email-joro@8bytes.org>
From:   Kees Cook <keescook@google.com>
Date:   Wed, 8 Aug 2018 13:33:01 -0700
Message-ID: <CAGXu5jK-wd=wbXcqoaogThVF1gHvH+UXgvVtsFuV2efjo8K46g@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/pti: Move user W+X check into pti_finalize()
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Anthony Liguori <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 4:16 AM, Joerg Roedel <joro@8bytes.org> wrote:
> From: Joerg Roedel <jroedel@suse.de>
>
> The user page-table gets the updated kernel mappings in
> pti_finalize(), which runs after the RO+X permissions got
> applied to the kernel page-table in mark_readonly().
>
> But with CONFIG_DEBUG_WX enabled, the user page-table is
> already checked in mark_readonly() for insecure mappings.
> This causes false-positive warnings, because the user
> page-table did not get the updated mappings yet.
>
> Move the W+X check for the user page-table into
> pti_finalize() after it updated all required mappings.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/include/asm/pgtable.h | 7 +++++--
>  arch/x86/mm/dump_pagetables.c  | 3 +--
>  arch/x86/mm/pti.c              | 2 ++
>  3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index e39088cb..a1cb333 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -30,11 +30,14 @@ int __init __early_make_pgtable(unsigned long address, pmdval_t pmd);
>  void ptdump_walk_pgd_level(struct seq_file *m, pgd_t *pgd);
>  void ptdump_walk_pgd_level_debugfs(struct seq_file *m, pgd_t *pgd, bool user);
>  void ptdump_walk_pgd_level_checkwx(void);
> +void ptdump_walk_user_pgd_level_checkwx(void);
>
>  #ifdef CONFIG_DEBUG_WX
> -#define debug_checkwx() ptdump_walk_pgd_level_checkwx()
> +#define debug_checkwx()                ptdump_walk_pgd_level_checkwx()
> +#define debug_checkwx_user()   ptdump_walk_user_pgd_level_checkwx()
>  #else
> -#define debug_checkwx() do { } while (0)
> +#define debug_checkwx()                do { } while (0)
> +#define debug_checkwx_user()   do { } while (0)
>  #endif
>
>  /*
> diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
> index ccd92c4..b8ab901 100644
> --- a/arch/x86/mm/dump_pagetables.c
> +++ b/arch/x86/mm/dump_pagetables.c
> @@ -569,7 +569,7 @@ void ptdump_walk_pgd_level_debugfs(struct seq_file *m, pgd_t *pgd, bool user)
>  }
>  EXPORT_SYMBOL_GPL(ptdump_walk_pgd_level_debugfs);
>
> -static void ptdump_walk_user_pgd_level_checkwx(void)
> +void ptdump_walk_user_pgd_level_checkwx(void)
>  {
>  #ifdef CONFIG_PAGE_TABLE_ISOLATION
>         pgd_t *pgd = INIT_PGD;
> @@ -586,7 +586,6 @@ static void ptdump_walk_user_pgd_level_checkwx(void)
>  void ptdump_walk_pgd_level_checkwx(void)
>  {
>         ptdump_walk_pgd_level_core(NULL, NULL, true, false);
> -       ptdump_walk_user_pgd_level_checkwx();
>  }
>
>  static int __init pt_dump_init(void)
> diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
> index 69a9d60..026a89a 100644
> --- a/arch/x86/mm/pti.c
> +++ b/arch/x86/mm/pti.c
> @@ -628,4 +628,6 @@ void pti_finalize(void)
>          */
>         pti_clone_entry_text();
>         pti_clone_kernel_text();
> +
> +       debug_checkwx_user();
>  }

I'm slightly nervous about complicating this and splitting up the
check. I have a mild preference that all the checks get moved later,
so that all architectures have the checks happening at the same time
during boot. Splitting this up could give us some weird differences
between architectures, etc.

-Kees

-- 
Kees Cook
Pixel Security

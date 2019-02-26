Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAE7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B6B2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V+kM/FN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfBZFni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 00:43:38 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45462 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBZFnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 00:43:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so5630059pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 21:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5xyv1fNfDGlGg9siZmH4kTxv/+JHEmjDQOSbD75FlM=;
        b=V+kM/FN1oYtNuAe0bWJL+QhJ0n1PnBRPlKoLdIQ/BpF1aZHXmKHRnloXWMkZgJsw8C
         b5uqn+Ygzn4uddKHes8qiFONB/JRG1EAmkeU37Edsmnm/gKKr0fkrp8ZIBIVP1elo5El
         3+bczcqNwaJyFZeIx0fIMupSKib8KeeG1V7IJWlB3Fi6m36Kdzz9CEmaP3O97t6xj/HM
         ZKAmHquYWWs9JY9Pmp6gb+MTfmBffrxZH8Y0MF/HpR+QbXZlBDi+Z2xyadSLPOTr/d6u
         /EZLWaNc7wxfY3lUUC0qGT+RpSwCi35d+BimLHkbJ+lCsK56nfowsLPMNzdT1drZ7V+k
         rJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5xyv1fNfDGlGg9siZmH4kTxv/+JHEmjDQOSbD75FlM=;
        b=UJ212jPS361mSyX7tBP6FRd97kO8wllGwJ7HrIbS4kQXNIPOittMcHc5Vyx1UQ4i+8
         YraxrK3U9R4eBrpKddrBdd/QLYhqcxRnBwuQ0/wdFGOHhXvHMWO1rzBNse2oaP54FdR1
         7N82SX/00L4t7YzmtiQXpCAbPA0l62r1LlrXVQIqT6vGBmDoCwhVIIOzwu97+GcTmPo9
         nXXT64xhxaMQNJvIRsfjS3vssTiBlyb7YL4GDO/L0FUMCvFR/iaM7ShOQ/KqK42/IZNV
         txaQgkUqBDtgTaEuCMGGH/oaw1wi9ocWF4DDXYijNnLyrWbcLH0w+1Z7HrDtlZEHG7TO
         +MWw==
X-Gm-Message-State: AHQUAuafZY8SwxCfM4lOc4pUAU8mygV75iGDQ7Yc8b9n5LnMFuZrRzm6
        nGSxLHFfxAJkn++S7B9jjShC8pryn9PG9X8vd8tLSA==
X-Google-Smtp-Source: AHgI3IblwsDq0v8w8uwDFDXShUnGCXvsmZCLS8U72WJ/yG50fLocYpIaMzDH+pF3bkPLatzQ2GN2GmFAnlAXAVBgLXU=
X-Received: by 2002:a63:5506:: with SMTP id j6mr22882913pgb.202.1551159816396;
 Mon, 25 Feb 2019 21:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20190226053855.7020-1-natechancellor@gmail.com>
In-Reply-To: <20190226053855.7020-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Feb 2019 21:43:24 -0800
Message-ID: <CAKwvOd=PsmVmxoQVT1fhGx+eMkKRqJV_yUQ56_Fs0R-guTuo2Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc/xmon: Fix opcode being uninitialized in print_insn_powerpc
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 9:39 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> arch/powerpc/xmon/ppc-dis.c:157:7: warning: variable 'opcode' is used
> uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>   if (cpu_has_feature(CPU_FTRS_POWER9))
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/xmon/ppc-dis.c:167:7: note: uninitialized use occurs here
>   if (opcode == NULL)
>       ^~~~~~
> arch/powerpc/xmon/ppc-dis.c:157:3: note: remove the 'if' if its
> condition is always true
>   if (cpu_has_feature(CPU_FTRS_POWER9))
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/xmon/ppc-dis.c:132:38: note: initialize the variable
> 'opcode' to silence this warning
>   const struct powerpc_opcode *opcode;
>                                      ^
>                                       = NULL
> 1 warning generated.
>
> This warning seems to make no sense on the surface because opcode is set
> to NULL right below this statement. However, there is a comma instead of
> semicolon to end the dialect assignment, meaning that the opcode
> assignment only happens in the if statement. Properly terminate that
> line so that Clang no longer warns.
>
> Fixes: 5b102782c7f4 ("powerpc/xmon: Enable disassembly files (compilation changes)")
> Link: https://github.com/ClangBuiltLinux/linux/issues/390
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

haha! (shows office mates).  Nice find, and fix!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/powerpc/xmon/ppc-dis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/xmon/ppc-dis.c b/arch/powerpc/xmon/ppc-dis.c
> index 9deea5ee13f6..27f1e6415036 100644
> --- a/arch/powerpc/xmon/ppc-dis.c
> +++ b/arch/powerpc/xmon/ppc-dis.c
> @@ -158,7 +158,7 @@ int print_insn_powerpc (unsigned long insn, unsigned long memaddr)
>      dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7
>                 | PPC_OPCODE_POWER8 | PPC_OPCODE_POWER9 | PPC_OPCODE_HTM
>                 | PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2
> -               | PPC_OPCODE_VSX | PPC_OPCODE_VSX3),
> +               | PPC_OPCODE_VSX | PPC_OPCODE_VSX3);
>
>    /* Get the major opcode of the insn.  */
>    opcode = NULL;
> --
> 2.21.0
>


-- 
Thanks,
~Nick Desaulniers

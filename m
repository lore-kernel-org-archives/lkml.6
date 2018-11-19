Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3187EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9B02080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="G5Zj+kB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9B02080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbeKTIns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:43:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46657 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbeKTIns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:43:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so20808480wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 14:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rn6DTdvqAWgPMVnXBkpNx8JUXTqj9odqPaLxlpVq9GY=;
        b=G5Zj+kB/DaPzFLkMUYOSH0jVEoj14icD+FYAsOkO++yUs7sqsA1BFRQXpJw1ybRXrO
         UQN/1gM5jbJAd5hI5zrckdCiklRoesLWWzBmM1r8Nmnq7UpUiRGFACYyKMVgACG+6MIW
         TeFnQG6MV+1t7FQMFvCbaeaPllvEfJkuAFMWGW+hJ9iki3WGgB6towompIrX27cKZWz9
         cOdQcMudfG3VEWWbMCWXPyMaARsP6YbojroF3PWy02H2pdmANuMnJMA90agoHf4aRoQ5
         ETy1O/mq6zZR7AQy4TvYQcOBIPygaq5NDLpRHNC0G4B1qzOmNtgub9aZrQtQIGlhDm97
         uhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rn6DTdvqAWgPMVnXBkpNx8JUXTqj9odqPaLxlpVq9GY=;
        b=tr11rbQqnrJYSbmNlehOT3GfnCRsNgvT21Cd5gR7ORRvfyt9ZbPkVdhlkFNsgQnWe5
         PJseBIT0fyvUAS6Gjv3/KGH+Qjf3fTf1LCoysSMskpxmTxuSIsfkDHQKCU8buJj2889U
         ai2Sv6ECb3AarefcV9n+HNNlVO5+5ThFKOwSRG63ExjpMnuYAmda2QoFmjOkto6BhSgR
         rDsi+zQDfJ+JWLY7ex8BdR1OP6c7qJGFJpp2M+SDc6Cusi40BKkkgul7RxWcu4BqXd47
         wNWBgG1S3HIvEOceg7lDqJDDmeYohV+rBMDgZX/YWD+C3zQnJwEkZTF419CeeknuhG2r
         NG0Q==
X-Gm-Message-State: AGRZ1gIQmIA3rne0xX53nDxAwzkLYceUwSZQf0AH593mD9ANFPYmi1/i
        ld7YSsLEVgqBebdwJewSL0l6jjMgfMiFtEyyv0w/uA==
X-Google-Smtp-Source: AJdET5cwjEMH66N+G50Kms8lEvgZQI1cbGvVz4noSdxEGU5YhgZUVxQwryVZc7E/98DvlHrHhRtOsOdYZ5ofWYgEOL0=
X-Received: by 2002:adf:e08c:: with SMTP id c12mr18845438wri.199.1542665880506;
 Mon, 19 Nov 2018 14:18:00 -0800 (PST)
MIME-Version: 1.0
References: <20181119214934.6174-1-yu-cheng.yu@intel.com> <20181119214934.6174-9-yu-cheng.yu@intel.com>
In-Reply-To: <20181119214934.6174-9-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 19 Nov 2018 14:17:48 -0800
Message-ID: <CALCETrW9ABDotyM020V147+kuizpTRJUAANn-6kUt6-h0Qn0og@mail.gmail.com>
Subject: Re: [RFC PATCH v6 08/11] x86: Insert endbr32/endbr64 to vDSO
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

On Mon, Nov 19, 2018 at 1:55 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> From: "H.J. Lu" <hjl.tools@gmail.com>
>
> When Intel indirect branch tracking is enabled, functions in vDSO which
> may be called indirectly must have endbr32 or endbr64 as the first
> instruction.  Compiler must support -fcf-protection=branch so that it
> can be used to compile vDSO.
>
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> ---
>  arch/x86/entry/vdso/.gitignore        |  4 ++++
>  arch/x86/entry/vdso/Makefile          | 12 +++++++++++-
>  arch/x86/entry/vdso/vdso-layout.lds.S |  1 +
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/entry/vdso/.gitignore b/arch/x86/entry/vdso/.gitignore
> index aae8ffdd5880..552941fdfae0 100644
> --- a/arch/x86/entry/vdso/.gitignore
> +++ b/arch/x86/entry/vdso/.gitignore
> @@ -5,3 +5,7 @@ vdso32-sysenter-syms.lds
>  vdso32-int80-syms.lds
>  vdso-image-*.c
>  vdso2c
> +vclock_gettime.S
> +vgetcpu.S
> +vclock_gettime.asm
> +vgetcpu.asm


What's this hunk about?

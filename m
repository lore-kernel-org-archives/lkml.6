Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACB5C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 19:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB39325449
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 19:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EK7vIj9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB39325449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeF3TBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 15:01:35 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36284 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751523AbeF3TBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 15:01:32 -0400
Received: by mail-io0-f194.google.com with SMTP id k3-v6so11349321iog.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/u+jU+4Ef6tjMWtVtI80r0J7E5Z6EDU4kldRmqBNPmk=;
        b=EK7vIj9P93hZysHHTkXTuoT+wjqCs1MXhIL+oS3ZGa97RSBiS4ncseApWguRRWKkhY
         m2RK3ltowN2/gwG24epAhBT1HqlvuJ0jAUTEct7B6trbl6+Nw/NLc6VyNFwdQwzWM3ZA
         V9iSuOTZ/dJWcoh9u/EGhFr41Qw0PXU7AED58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/u+jU+4Ef6tjMWtVtI80r0J7E5Z6EDU4kldRmqBNPmk=;
        b=C6xAx7LflW+uv8lSoXZkM3raTaA+XcQFSXHq+/c8D55fHIl2cyNkvflmD2vqt9j75l
         NXqEa0YPYtjuN4AEKvV62Nql6iIRutW0OmVceJl70zcL31/2CAA4MbK3wXxgXA/j+ob4
         osQ/eLMxwen+bYSAuZwD2cLJ2J7FTZdvpl3xBqjksBgMyEc2rMJ4rsaL771novmhxfz0
         XLlRJKwFpw0OWNoMISaZZjB4G5zFNrZ7C8pVc4wpaZ1cl9D8Vs4UqMgDlFxManvomnlz
         RAq6h2TLvfMyYSmlooTDJua64wRsB9fBskJCSXuDCgpHrcdzdi9NM0P0QN/9EZmJSe/P
         L5Fg==
X-Gm-Message-State: APt69E0JAvwwXtUumC2aB5Zc8/0PmpgD67zGhxISJ4GUJcRx5a1bQV8I
        7YDv62jTkeLQaQij+XOzzNC/lDZ6gAKwcJI2toQ=
X-Google-Smtp-Source: AAOMgpcPCeosIbFdKXIPK0PpmSKxm1mbAhdvlsDKE13UXagvRXdGVe2GtT2DGnj2+YPAv17A8cTSbGdPJkSIwOpgGT8=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr16967713ion.259.1530385291614;
 Sat, 30 Jun 2018 12:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180630084933.GA15210@gmail.com>
In-Reply-To: <20180630084933.GA15210@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Jun 2018 12:01:20 -0700
Message-ID: <CA+55aFz4BiRVKKwdF+y8K4O1jZnig8mmuQZ7prGp6o+DiH_TeQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86 fixes
To:     Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 1:49 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -477,7 +477,7 @@ ENTRY(entry_SYSENTER_32)
>          * whereas POPF does not.)
>          */
>         addl    $PT_EFLAGS-PT_DS, %esp  /* point esp at pt_regs->flags */
> -       btr     $X86_EFLAGS_IF_BIT, (%esp)
> +       btrl    $X86_EFLAGS_IF_BIT, (%esp)
>         popfl

Ho humm. Just looking at this patch, my reaction was "why isn't this
an 'andl $~X86_EFLAGS_IF' instead"?

Yeah, I guess the 'andl' is two bytes longer (due to the 32-bit
constant - because IF is bit 9, you can't use a byte constant, and you
don't want to get a partial word write just before the popfl).

But btr is really pretty heavy operation for older CPU's (it's gotten
better, but 32-bit code presumably cares more about the older CPUs).

It really doesn't matter, I guess. The btr goes back to commit
c2c9b52fab0d ("x86/entry/32: Restore FLAGS on SYSEXIT").

Andy?

                Linus

Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D544FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB35A21916
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404572AbfBOIqO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:46:14 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45500 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfBOIqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:46:13 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so15230348ota.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 00:46:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B0dPGRCNmKatrjVoIUq55VqUlKIBw5TV2xm1zcMqDZc=;
        b=sgMrKxkkDSifrvX9s/sQwx+gURdFkbl96UsXdpm2vsCFLaE/ZgLVjeFAO7Bsvi9FX6
         FNvoawwcnG3VsyU0IUhpUTBpz4AHRAxB/V+h6px/T2AQKDoy1ADWLQ742jl89h6iBvF3
         kRDFcp4LxpZVyIQj/eBoyhpcnQfUE1rPZXjURLV1x3lYnOHnHyEWQCp6W840ht7xupTP
         3mdP1HRNJ0l3K7Rjuo1xM6kwInVmdCK5iSjHZ7PzeJoxZ4Dth9SK1g79iOzThlpnliIz
         49TgXQr/IHgKRNntPuRb+w9nCrfgjwP3/+RlP0wJEsZwGSfLrTIoW8cflDP/p4eXGZ+s
         8jCw==
X-Gm-Message-State: AHQUAuaRQEIAjCmUx8ZJhNO39XvDlm6zvVa862u7bCpLcMK/v6RkQO+W
        7if7RfaRFuLgB4PnRPvdZGLjjnpC9hCmBOXNO7Y=
X-Google-Smtp-Source: AHgI3IZgQHJSKnoLPZzKL9wKux0sc32X9U7EzUSc+1uPSTqORyddQJbB+r/ekzllKtB2ttYsv/vnqmvoBgfl+PifaWs=
X-Received: by 2002:a9d:7841:: with SMTP id c1mr5170654otm.354.1550220372529;
 Fri, 15 Feb 2019 00:46:12 -0800 (PST)
MIME-Version: 1.0
References: <20181208154624.6504-1-malat@debian.org> <CA+7wUswJy0z_+aytawQv6+1pOVvH2z8SfOz1sxziHtgjqZ1F9g@mail.gmail.com>
 <e95cb3ea-019f-28b0-0af0-ad8c80b3106b@c-s.fr>
In-Reply-To: <e95cb3ea-019f-28b0-0af0-ad8c80b3106b@c-s.fr>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 15 Feb 2019 09:46:01 +0100
Message-ID: <CA+7wUswX34amxhJW827tm9zmSaq6T9NvEpxWpgcofGNL=3Kmxg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/ptrace: Add prototype for function pt_regs_check
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 9:21 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 15/02/2019 à 09:11, Mathieu Malaterre a écrit :
> > On Sat, Dec 8, 2018 at 4:46 PM Mathieu Malaterre <malat@debian.org> wrote:
> >>
> >> `pt_regs_check` is a dummy function, its purpose is to break the build
> >> if struct pt_regs and struct user_pt_regs don't match.
> >>
> >> This function has no functionnal purpose, and will get eliminated at
> >> link time or after init depending on CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
> >>
> >> This commit adds a prototype to fix warning at W=1:
> >>
> >>    arch/powerpc/kernel/ptrace.c:3339:13: error: no previous prototype for ‘pt_regs_check’ [-Werror=missing-prototypes]
> >>
> >> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> >> ---
> >>   arch/powerpc/kernel/ptrace.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> >> index a398999d0770..341c0060b4c8 100644
> >> --- a/arch/powerpc/kernel/ptrace.c
> >> +++ b/arch/powerpc/kernel/ptrace.c
> >> @@ -3338,6 +3338,10 @@ void do_syscall_trace_leave(struct pt_regs *regs)
> >>          user_enter();
> >>   }
> >>
> >> +void __init pt_regs_check(void);
> >> +/* dummy function, its purpose is to break the build if struct pt_regs and
> >> + * struct user_pt_regs don't match.
> >> + */
> >
> > Another trick which seems to work with GCC is:
> >
> > -void __init pt_regs_check(void)
> > +static inline void __init pt_regs_check(void)
>
> Does this really work ? Did you test to ensure that the BUILD_BUG_ON
> still detect mismatch between struct pt_regs and struct user_pt_regs ?
>

My bad, I was unaware of GCC behavior for static inline in this case.
Sorry for the noise.
Original ugly patch does work though.
>
> >
> >>   void __init pt_regs_check(void)
> >>   {
> >>          BUILD_BUG_ON(offsetof(struct pt_regs, gpr) !=
> >> --
> >> 2.19.2
> >>

Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96F0C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AA02178D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sYpbGUxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AA02178D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731885AbeHCWby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 18:31:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45382 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbeHCWby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 18:31:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id f1-v6so3332099pgq.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 13:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7pbELVPlEmBFoIK49lGoMM6zfDBfgJOHwwyvMmhHeGI=;
        b=sYpbGUxQ9J5SCqK15dSKFaYspru2fpVAA+mjqWvvjFv+ST8JMMmUlOF/VDM4DNzLkv
         QkJtLhTQNE7jsH46uh1oKTjrbyFYY3vCNCgLWruSYdzJRYmNllXLGoA1LKFIq+3pSbKF
         UVCBpJjoVqMbTVxTs45+0+dyJxwnGr6f+RDq/rwDe/xHvCywEnrRaGgwWOYMxGCyWQm1
         QKpLFJRqfBIELqbse62HCw3bkhl4EfinuNqn03Mxk1OcPIRqY3S2C7JNw9duA43dZw9j
         B7EFdO/iPwwHY9ItDbxs/yyHTQfuG83TfYPaYwbTR2hqU0a1lf2tMS4RYRnW3ihpD2kt
         A8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7pbELVPlEmBFoIK49lGoMM6zfDBfgJOHwwyvMmhHeGI=;
        b=BNpwmg3btaFwGZ3NlW9HBwLaR7mE4K/T4wmZpOcXmJzBM9z+W5tcNVdW8vvtzoH+tk
         J/vEkSOs8buNsUl/bTYEky8I2abs/KJ62udCtfzLYeM22642RAm0pGlCar++0eR1zC7m
         AWOAqBAGn/R+lV95fvTpUqDLtadmVI3rBQqAUJQ8JVBqUiV9FP2AUPQ7aLK6q8QlfRTn
         Q9CKs0IeWqFIlCeCfn0j6W2uiebP9yxxy1S2rS3rcvXyxn5dqBhYnXeyN5WZXp6ah0u8
         YXG7RmADx8um0t51wUGSHfVLyP/pz8XYKNCRIk91N0nvvINspGnDyCzsFQtN+xJoq9pH
         MYnQ==
X-Gm-Message-State: AOUpUlGAgj/pmo7ZN8Lp7Sj+ofX1YLUd144yPVZ6xzYHnA8w28YS/2Rb
        qZBtkvm4em1QttF9yCMJffLu/ASDYsMRCX+R7z2o3A==
X-Google-Smtp-Source: AAOMgpeZve2neMXLcn8OywYnrRp8TBzaWtJ+5Vnwdx9QLpbIhaBCbr/SMf2xK/Kx6VNMPiJCSS28wvOoRx5HAmplHbQ=
X-Received: by 2002:a63:9619:: with SMTP id c25-v6mr5111699pge.75.1533328442239;
 Fri, 03 Aug 2018 13:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180801182258.17834-1-ndesaulniers@google.com>
 <78c667f9-5c8b-3835-83eb-4b59e27e4f7e@bell.net> <CAKwvOdmdrA+UvAWyqe8sNJt5nxHXHsSwf5Yxih9HYgVL+kovxQ@mail.gmail.com>
 <fe7b57d8-b586-a390-31d2-2274f69db3c0@bell.net> <CAKwvOd=CLBFZRQ4HQb_+VCydDEvsbC2w2gD4hTwvp_jm1zqN9Q@mail.gmail.com>
 <54b2139b-53d2-01c5-f240-93a692cdbc59@bell.net> <CAKwvOdktvrZL8T_5K2VtQtgt_mscS7kzVXYVy0O7CSuGX53Y5A@mail.gmail.com>
 <536ef1b1-cfa2-f66d-4261-fb8405964632@bell.net> <CAKwvOdmwj76aESZNKhzfPmhfzGKvrfDut7oD5KAwA+VR-JukSg@mail.gmail.com>
 <80743c1c-2a8c-7bce-2068-24c63790eba7@bell.net> <CAKwvOdmDwO1U1sk=3-6zXFrVw6by1e_9VBx1WWMCx_rMqYSw-A@mail.gmail.com>
 <81a7e33a-0403-b6d4-fcba-c2168a608ba6@bell.net>
In-Reply-To: <81a7e33a-0403-b6d4-fcba-c2168a608ba6@bell.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 3 Aug 2018 13:33:50 -0700
Message-ID: <CAKwvOdmXi_EY5=sOO9tRqeoFrHjLsF9L988cGC2yjnFYBxac4w@mail.gmail.com>
Subject: Re: [PATCH] parisc: prefer _THIS_IP_ and _RET_IP_ statement expressions
To:     dave.anglin@bell.net
Cc:     deller@gmx.de, jejb@parisc-linux.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Alistair Strachan <astrachan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 12:09 PM John David Anglin <dave.anglin@bell.net> wrote:
>
> On 2018-08-03 2:11 PM, Nick Desaulniers wrote:
> > But the kernel uses the generic_THIS_IP_  *everywhere*, not parisc's
> > custom current_text_addr().  So if this did actually break unwinding,
> > you should have noticed by now.
> The unwind problem was noticed.

So parisc is currently broken (doesn't unwind) due to the pervasive
use of _THIS_IP_ (generic C) throughout the kernel?

If no, that implies this patch (generic C) causes no unwinding problems.
If yes, that implies that the diff I posted later in this thread
(inline assembly) is preferable, and that parisc has bigger problems
(and probably needs to do rewrite the unwinding code to handle these
extra labels everywhere).

> Patches were recently applied to gcc and binutils to try and fix it.
> The gcc patch moved
> branch tables to rodata so that the label at the head of the table
> wasn't in text.
>
> https://gcc.gnu.org/ml/gcc-patches/2018-07/msg01804.html
> https://sourceware.org/ml/binutils/2018-07/msg00474.html
>
> When I saw your suggested change, I realized there was another source of
> text labels
> that need linker relocations.

Thank you for the links.

On Fri, Aug 3, 2018 at 10:57 AM John David Anglin <dave.anglin@bell.net> wrote:
> The label breaks the unwind data, not the unwind code.  So, localizing
> the use of
> current_text_addr() to the parisc unwind code doesn't help.

Have you confirmed that applying my patch breaks *the ability to
unwind correctly*? It looks like return_address() is used in
ftrace_return_address(), so I assume you can boot a kernel with my
patch applied, and CONFIG_FTRACE=y, then run:

$ sudo trace-cmd record -p function date
$ trace-cmd report | grep date- | less

and see if the stacks aren't unwound or look messed up.
-- 
Thanks,
~Nick Desaulniers

Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5ECC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4749B20836
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GahXkin8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4749B20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeH3Tmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:42:47 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41833 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeH3Tmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:42:46 -0400
Received: by mail-oi0-f65.google.com with SMTP id k12-v6so16192356oiw.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 08:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kz8MQNPDzN7DpxJUSNa0x2jNVynzAGDge5M0MJqhY20=;
        b=GahXkin85mYJmrx3gkxXQUSOqfxLsi/S3VnWOXUHAnhj2laosZYLnElcPMFU9jBlcM
         MpeaAdrPAiq0cIZUu06yCjopY/3JAhnPiFzVo7CzX9/Sa5TBQMYgH5E48wCryCZXWoQY
         K2OiwrfN+NapCxb6HlqTTc1S1mjkkyi7a5Y1+YRH2UkUpcNfqiAEUzj/oxCZ0TONKgJC
         gUUYYiUnAmJl2qm99Uz/1rdppwThCn97f79155Vo2tuFLecwQk5drDbdd/fIItHv7RmF
         xOQe14fJb+0XH2Vuu+UGJKsbhqgBI8qi3NuJ49joiSzqZFxBUQS3GHkn3Dkjps+yxMEf
         3vlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kz8MQNPDzN7DpxJUSNa0x2jNVynzAGDge5M0MJqhY20=;
        b=JMhi3jf8br3rQ52Q3EWTfqwhyLNuuLMZzzpQo5BAw0SPdCcch3EZWZgsRcqlBCx2UT
         jUXFenisJNTIG0vx3jZR4MDM1PyuNiTX/rLV2g9UmOJmlthQwGpY9GS8IsHhCHLU87fZ
         0gvxHq+PnsQ6D8Uvw4o/hZvY4+7zuz8TUJ+jAj5/j5G2A9aoUsB6Mz5X+tny6/5EhN92
         Aiw7VdBSpk7aTg7RRA2uyyTe6MV15iVyzFdpNHMD67h+322GkIO3/3WLvUl75654g0Qn
         VjxkjG7mG+Jl/DMqMnoB9f/qagz/ySYXhE606o219922AxvF0p7A6/dOmnBkf9O7fgp7
         JPHg==
X-Gm-Message-State: APzg51B+7EG+kkIURCeQQYz+rD2zl/qJWiBKaFo7JLSjpOwo2/89chGk
        +Awjww8Bd5CEUDKFf/9dILdE6GyElwp1s6eR2UI1fw==
X-Google-Smtp-Source: ANB0VdYaBXuBowN4ka7CRUckryC7LCadsYYfFF5hzkra4PeZDW+8Km3yy7+qQSyezootxpeVpbiOv87LI2ozFTl8JS4=
X-Received: by 2002:aca:4204:: with SMTP id p4-v6mr2836500oia.242.1535643601937;
 Thu, 30 Aug 2018 08:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180830143904.3168-1-yu-cheng.yu@intel.com> <20180830143904.3168-20-yu-cheng.yu@intel.com>
In-Reply-To: <20180830143904.3168-20-yu-cheng.yu@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 30 Aug 2018 17:39:35 +0200
Message-ID: <CAG48ez3uZrC-9uJ0uMoVPTtxRXRN8D+3zs5FknZD2woTT6mazg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 19/24] x86/cet/shstk: Introduce WRUSS instruction
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
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
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

On Thu, Aug 30, 2018 at 4:44 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> WRUSS is a new kernel-mode instruction but writes directly
> to user shadow stack memory.  This is used to construct
> a return address on the shadow stack for the signal
> handler.
>
> This instruction can fault if the user shadow stack is
> invalid shadow stack memory.  In that case, the kernel does
> fixup.
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
[...]
> +static inline int write_user_shstk_64(unsigned long addr, unsigned long val)
> +{
> +       int err = 0;
> +
> +       asm volatile("1: wrussq %1, (%0)\n"
> +                    "2:\n"
> +                    _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_wruss)
> +                    :
> +                    : "r" (addr), "r" (val));
> +
> +       return err;
> +}

What's up with "err"? You set it to zero, and then you return it, but
nothing can ever set it to non-zero, right?

> +__visible bool ex_handler_wruss(const struct exception_table_entry *fixup,
> +                               struct pt_regs *regs, int trapnr)
> +{
> +       regs->ip = ex_fixup_addr(fixup);
> +       regs->ax = -1;
> +       return true;
> +}

And here you just write into regs->ax, but your "asm volatile" doesn't
reserve that register. This looks wrong to me.

I think you probably want to add something like an explicit
`"+&a"(err)` output to the asm statements.

> @@ -1305,6 +1305,15 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
>                 error_code |= X86_PF_USER;
>                 flags |= FAULT_FLAG_USER;
>         } else {
> +               /*
> +                * WRUSS is a kernel instrcution and but writes

Nits: typo ("instrcution"), weird grammar ("and but writes")

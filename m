Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A56C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5378026AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9UTc9yE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5378026AAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933943AbeFZRgT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:36:19 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44768 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933906AbeFZRgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:36:18 -0400
Received: by mail-vk0-f65.google.com with SMTP id x4-v6so10531429vkx.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 10:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W7d12bvV04atbsAOGPjeJFCf3JdUdGFuDP+f8RQQ4VM=;
        b=A9UTc9yEPepmJ134vDxFn8VKTyqiHLb/vidCesv2yFXHkj4Mn+uP4RCenrW9eE9+Bm
         iCuG5RB/Ag8F51vFj+O+P1T4VxZBnHvdTj9AmIP6ckU2/o4VyNYeih3PUNNN3ndgwAjd
         omrF29nXnqXV897ONLQtorI0jL9phYJA7AnnVLb+EmuVRfhdEkxO9Hna1II9lluUeNLE
         lDRYIopAMJ87t9Z/3Gof98pAwR8HC73ZtXzYWFs9iSkGRc9N7pVd2xL9ZxVML7DAiyOy
         8RjeakO2uRRZaikrLcrS36gWmZStzPWWgG0mTnFPbQKxjRrkpSyHijijU+TGCu3d6G5O
         nrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W7d12bvV04atbsAOGPjeJFCf3JdUdGFuDP+f8RQQ4VM=;
        b=MGBvNpzE7DB8HnNQTCNQuc89J84RKpa/3xqLtShQI6lw4f7L42ugXU77yHxA1te8hO
         z4vHS7JVyldT7mc6M8RoyMIIkmjQXPo7+EXvXN1Dg3rvCZstADWRzJ9TF7R1e2rLJN2b
         a8VElrSzpcOLL1RAX/PdKhbBeoBMLr9/4AVuGltuifid+Qt2oVAtzkbSbM52Xh7MXQuA
         VYTCxWEKuJWMU5LoiYGkyO+rLa9InrlAxMWKatSaD1h0HHCUC+I9RKq5vv/gpN9LsJdT
         JuwtzTcUj1Q03ZhUC8vseL/eXjIISVDtS5nxbIjaGgybjoRM6VlIdYhg0EmxKKC0bF7q
         O4Tw==
X-Gm-Message-State: APt69E3xqrpykGteRXuzotH1OQUHqVDjHu+qEFE8w3uYDGmpcRfhPIU7
        UG6P0wIh9VKYwdzX8dU1IqQqd25ww6kXEue+Mj4=
X-Google-Smtp-Source: AAOMgpen2dL3T0q2whza6Qdu4Y4aHLjNXCVEnmRytjkiuRrzFe0BoknQqOtojxu/qBnLnxctgt5ER7A/QSZKSeBFfB4=
X-Received: by 2002:a1f:d1c5:: with SMTP id i188-v6mr353761vkg.131.1530034577270;
 Tue, 26 Jun 2018 10:36:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 10:36:16
 -0700 (PDT)
In-Reply-To: <20180626072843.158906-1-dvyukov@gmail.com>
References: <20180626072843.158906-1-dvyukov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jun 2018 20:36:16 +0300
Message-ID: <CAHp75VeBCOFvem=Bu5Q04X=eZkTGtJKK79HhsoerVgLerxmTcw@mail.gmail.com>
Subject: Re: [PATCH v3] arch/x86: get rid of KERN_CONT in show_fault_oops()
To:     Dmitry Vyukov <dvyukov@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 10:28 AM, Dmitry Vyukov <dvyukov@gmail.com> wrote:
> From: Dmitry Vyukov <dvyukov@google.com>
>
> KERN_CONT leads to split lines in kernel output
> and complicates useful changes to printk like
> printing context before each line.
>
> Only acceptable use of continuations is basically
> boot-time testing.
>
> Get rid of it.
>
> Also tidy up code around as asked by reviewers.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>
> ---
>
> Changes since v1:
>  - use pr_alert() instead of printk(KERN_ALERT)
>
> Changes since v2:
>  - drop unnecessary parenthesis
>  - remove once used nx_warning and smep_warning
> ---
>  arch/x86/mm/fault.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 9a84a0d08727..a73575cacfd9 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -641,11 +641,6 @@ static int is_f00f_bug(struct pt_regs *regs, unsigned long address)
>         return 0;
>  }
>
> -static const char nx_warning[] = KERN_CRIT
> -"kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n";
> -static const char smep_warning[] = KERN_CRIT
> -"unable to execute userspace code (SMEP?) (uid: %d)\n";
> -
>  static void
>  show_fault_oops(struct pt_regs *regs, unsigned long error_code,
>                 unsigned long address)
> @@ -664,20 +659,18 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
>                 pte = lookup_address_in_pgd(pgd, address, &level);
>
>                 if (pte && pte_present(*pte) && !pte_exec(*pte))
> -                       printk(nx_warning, from_kuid(&init_user_ns, current_uid()));
> +                       pr_crit("kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n",
> +                               from_kuid(&init_user_ns, current_uid()));
>                 if (pte && pte_present(*pte) && pte_exec(*pte) &&
>                                 (pgd_flags(*pgd) & _PAGE_USER) &&
>                                 (__read_cr4() & X86_CR4_SMEP))
> -                       printk(smep_warning, from_kuid(&init_user_ns, current_uid()));
> +                       pr_crit("unable to execute userspace code (SMEP?) (uid: %d)\n",
> +                               from_kuid(&init_user_ns, current_uid()));
>         }
>
> -       printk(KERN_ALERT "BUG: unable to handle kernel ");
> -       if (address < PAGE_SIZE)
> -               printk(KERN_CONT "NULL pointer dereference");
> -       else
> -               printk(KERN_CONT "paging request");
> -
> -       printk(KERN_CONT " at %px\n", (void *) address);
> +       pr_alert("BUG: unable to handle kernel %s at %px\n",
> +               address < PAGE_SIZE ? "NULL pointer dereference" :
> +               "paging request", (void *) address);
>
>         dump_pagetable(address);
>  }
> --
> 2.18.0.rc2.346.g013aa6912e-goog
>



-- 
With Best Regards,
Andy Shevchenko

Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1141CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 23:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6682075E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 23:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d6c2Yx4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6682075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbeHRDA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 23:00:56 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41526 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbeHRDAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 23:00:55 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so16807048oiw.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 16:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ds396LVoVtBCaofAqS7RtuLP2vc9hietrCDCgYaSKw4=;
        b=d6c2Yx4MSwCHCupcyE1cFwXDnrAiEVYFvfsKXnd5MjYxzqNRV3fHrYPESvGdLJ02uF
         eH89ksYancvIy9M4y+Slt32DbDpNoDCjvBEO+r0ldMfvZ1SEixV+BEywKYSDt92oeAiO
         5aJVcJtz6cSInEgM6NmPd3DpPOLsI0PGo/L0OTJg4M8TN9SncQOkMaXIZZQHmLPXt7LF
         lIhhOwLO76lJpj0QTalgE/MqFXMtRK5HyuJhHnpgbQuxp3XBjSFJNj+nDI8TobWaun30
         nLNTCcchzMdV+EJ510pdusJkRalP18z1kSbVc7k1ox9+hD4zlQMT2EUozVUVOAqSJ1dn
         YYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ds396LVoVtBCaofAqS7RtuLP2vc9hietrCDCgYaSKw4=;
        b=aX1Pezinrucs5GXYS9BmQv+5XTubwJD012HaXK+DX3AQA+ejPQTXTmj56Z2pcPfvzD
         ziPDTcre0C/7Cg9kWBeX3Y22hxuwc9GbSZ32Q7dUkAPn22szqywZ2b/3mpGvBUqvg7Fs
         aZgoGlm7D1x9XJH23KresuSYe5ydqldjBv24zPx0SkHqkaH5DKfWT7hPP8V+sOgkFVKJ
         JzncZKg7wxMYG7dmXEa6Pbfd6uwoyjPsbqPMCXLFFhLG6+hED4l9u7h7IX1jiJbJu2vn
         bQr3c8YADTFdxdDh1HRIlLbYgP+87kcxWC6E3EaeO32eCx+J772EBrvFIWn4+A9dxrgX
         /HAw==
X-Gm-Message-State: AOUpUlEYr9sTGBEF3kWf1xZhqXWPL1pnPkJ6hYTDpsqyzRxVsT/XL+5e
        WPU4iVztJWpMSoBedLC/B64qSjIp5JWoi5DfvrBt4hkcEzS/LQ==
X-Google-Smtp-Source: AA+uWPwoBrs5jZD697eAyoyZs2cwFT2RyHA9sJeZiBMSPbJIn3pKMU8bt/hrP0o8/j1a3XaJc/q/ybFlJzvFALBCebM=
X-Received: by 2002:aca:c585:: with SMTP id v127-v6mr4769841oif.348.1534550128363;
 Fri, 17 Aug 2018 16:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180817221624.10232-1-casey.schaufler@intel.com> <20180817221624.10232-3-casey.schaufler@intel.com>
In-Reply-To: <20180817221624.10232-3-casey.schaufler@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 18 Aug 2018 01:55:02 +0200
Message-ID: <CAG48ez23G+wcnkCMNZV_mxYMS=h+pZkpx1451Wz5GB9_tcDv3Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/5] X86: Support LSM determination of side-channel vulnerability
To:     Casey Schaufler <casey.schaufler@intel.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Dave Hansen <dave.hansen@intel.com>,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 12:17 AM Casey Schaufler
<casey.schaufler@intel.com> wrote:
>
> From: Casey Schaufler <cschaufler@localhost.localdomain>
>
> When switching between tasks it may be necessary
> to set an indirect branch prediction barrier if the
> tasks are potentially vulnerable to side-channel
> attacks. This adds a call to security_task_safe_sidechannel
> so that security modules can weigh in on the decision.
>
> Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
> ---
>  arch/x86/mm/tlb.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 6eb1f34c3c85..8714d4af06aa 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -7,6 +7,7 @@
>  #include <linux/export.h>
>  #include <linux/cpu.h>
>  #include <linux/debugfs.h>
> +#include <linux/security.h>
>
>  #include <asm/tlbflush.h>
>  #include <asm/mmu_context.h>
> @@ -270,11 +271,14 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>                  * threads. It will also not flush if we switch to idle
>                  * thread and back to the same process. It will flush if we
>                  * switch to a different non-dumpable process.
> +                * If a security module thinks that the transition
> +                * is unsafe do the flush.
>                  */
> -               if (tsk && tsk->mm &&
> -                   tsk->mm->context.ctx_id != last_ctx_id &&
> -                   get_dumpable(tsk->mm) != SUID_DUMP_USER)
> -                       indirect_branch_prediction_barrier();
> +               if (tsk && tsk->mm && tsk->mm->context.ctx_id != last_ctx_id) {
> +                       if (get_dumpable(tsk->mm) != SUID_DUMP_USER ||
> +                           security_task_safe_sidechannel(tsk) != 0)
> +                               indirect_branch_prediction_barrier();
> +               }

When you posted v1 of this series, I asked:

| Does this enforce transitivity? What happens if we first switch from
| an attacker task to a task without ->mm, and immediately afterwards
| from the task without ->mm to a victim task? In that case, whether a
| flush happens between the attacker task and the victim task depends on
| whether the LSM thinks that the mm-less task should have access to the
| victim task, right?

Have you addressed that? I don't see it...

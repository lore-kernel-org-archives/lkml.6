Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9D9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6281208EA
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WnFTTzc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6281208EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390843AbeHPRIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:08:50 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35448 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389865AbeHPRIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:08:49 -0400
Received: by mail-oi0-f67.google.com with SMTP id m11-v6so8244710oic.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 07:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R8V/VATXaUG1NBxPIVcMG9W6YIR2vLHATGZXwtoAXgk=;
        b=WnFTTzc+n49UniYqvGanoAO2JpMtKjNOrXJF6vagWkariDH/DDt4AK9ToXVAuNQZxS
         2gY7A8nM3WLtExppcdlt0spJuwSxM/KZr9iwV1IfmfYbjgu1VmF4jPayB9kAe8KD8gQ8
         5pwT7DmVIpCwCgBE3V0jj+rApDpbhM9zSHjMeaZvc0xrb6Es/eg2AGk6g35jSle7XVIp
         3N0JWQcwGN1X+BSz0LcM6OryErRZxr5TJ5yWLE7TX2M0djdu0R6YQijgt75+WunB+QhO
         kWXbFzIufPSWfsk8Z+FYK9poJIJ3iuyKlClbjZFBMkk/iFr1mKJ8znzGDFJevWUPyc6F
         pzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R8V/VATXaUG1NBxPIVcMG9W6YIR2vLHATGZXwtoAXgk=;
        b=c8zmnyCQs22HQewrMyO6iL/Zqi9ti2JAMQDSevbQQ2vLmIskpeuMvaVeW2xfrXG08U
         wQni7GaCw3iBQCnrsDVEFNsHpOdcNB2Rah9rskYAQ8Den2E3uxtZroxGyU0o92ZKsw1J
         p2zI8Dv5UF5JcZZ0JSMLgsyYuWM2yj8JMumt85FPskBzz0PP69vuXFXYSmmr3Vb+y039
         z78r+SHhl/QSMoe5GCTc57HeS/07dBB2uTyoSVEVAbBb8n1ZlV6NXtyUcpp2a5VKsrlG
         ZccodpOLJLtsQ/thq0+e1jZlodqlBhFjgdH4TlKuJtW4W14ZT49PykIfD8cRkDipdz/d
         c89w==
X-Gm-Message-State: AOUpUlHnMYZh8mc3RDy9PNlWYeq8xM4XBItATBBTvI3qYKnZJ7ReCp1b
        wMjEZWgSCAHbD2KPWri3i1HH8q/Yf+zrMgS8xKBuMw==
X-Google-Smtp-Source: AA+uWPyFWgrDsmaRh9FYodBvx2VgGazK9tOSI7NelzG5UikSd6NKAuwtpH3naPBm/3wszgqIqaz++XnNLuzL+dMTkQg=
X-Received: by 2002:aca:dc55:: with SMTP id t82-v6mr32247857oig.159.1534428597305;
 Thu, 16 Aug 2018 07:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180815235355.14908-1-casey.schaufler@intel.com> <20180815235355.14908-3-casey.schaufler@intel.com>
In-Reply-To: <20180815235355.14908-3-casey.schaufler@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 16 Aug 2018 16:09:31 +0200
Message-ID: <CAG48ez0=RSok9mAo9QHsho+Qnm_ZDqkH68Amfzj9A_jWmOZaOA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] X86: Support LSM determination of side-channel vulnerability
To:     casey.schaufler@intel.com
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, SMACK-discuss@lists.01.org,
        Dave Hansen <dave.hansen@intel.com>, deneen.t.dock@intel.com,
        kristen@linux.intel.com, Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 11:51 AM Casey Schaufler
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

Does this enforce transitivity? What happens if we first switch from
an attacker task to a task without ->mm, and immediately afterwards
from the task without ->mm to a victim task? In that case, whether a
flush happens between the attacker task and the victim task depends on
whether the LSM thinks that the mm-less task should have access to the
victim task, right?

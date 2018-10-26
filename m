Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EADECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16712086C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOxvdFqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16712086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeJ0CYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:24:25 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34337 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeJ0CYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:24:24 -0400
Received: by mail-qk1-f195.google.com with SMTP id a132so1187223qkg.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 10:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+qQIQ9Lma18WDkP1IDbcit9GHSv4XLjifXKMP8+lZuE=;
        b=sOxvdFqgNjBwZCy0bad9nuOuoG4WWH7ATJJWkzdLDQNtEEPQTUk/zwOrN3yqTui3Ta
         ErVb03O3+Gni3IzjTLpOwJS3m2YnPczUfksSPv3SnjiqOA95lI2HWsJQRzxLq6klxkiK
         47Iz2e28Ky8h8gQpoIPKyM6+Em4X3bI/dLg+LBrsfBfO+Nmgdtk4G5sUjPHhupyvU5zl
         KiBW6kfwwz2jjstbkO+OzJEtsMveac5QNU5PpF3xSAsHWPALWUdpsP+z9xkbO156nH6p
         xHiBdVNzQQsWvYEF9veMhyJY1OwmqAYDU7vSMO3rXJEURbUJlXxoEZWNAvvKXiQdvpuL
         MD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+qQIQ9Lma18WDkP1IDbcit9GHSv4XLjifXKMP8+lZuE=;
        b=T3IAiwjOFMPEwndhdDuo0HRrMQmfymtZ/9LSiWFJ86YHeuXbJsybfx8Fom7YI2/+I0
         BhBa+6h+w6B3aQ1JZDT6Ly4XngTgEFO6mx65SEOmRIQW6gf1cBENwfgupNq4bgBzy2bH
         2Cw3hCFTdSANwXsRYMhWpTwhVfufFryrCkjGlO/mzQK/1tU5AwR+ag2lNSHv4zSamRse
         PjV0ocDpnBRb7ekFAvmVnE4O2Z2Dhx9MjSXttpPRO1LbnzBwL5ruKeGtMS+0sRbnFFC8
         LD6kVaXfH1iU8vh78JCwrfyCW60gM9PjmkDGjQzmG+3LcclLeP8Ej0qtN+PU+otlWWtC
         XLpQ==
X-Gm-Message-State: AGRZ1gJPmTFM7UMFAyTvouw7C6Kw06BGGxCjJKb/E1ArYZ+yV2BdKmV8
        cdWBfXelFd+NgQPB6aX2Hcw=
X-Google-Smtp-Source: AJdET5dfDSbOIMjSytHOu4ze0VgUEMPlIhQ/9tnHjScJgeG640wLPJxsIAw7br/Z5Q2pK4dkYT+dmQ==
X-Received: by 2002:a37:8282:: with SMTP id e124-v6mr3962306qkd.76.1540575988622;
        Fri, 26 Oct 2018 10:46:28 -0700 (PDT)
Received: from llong.remote.csb (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h49-v6sm9250343qth.32.2018.10.26.10.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 10:46:27 -0700 (PDT)
Subject: Re: [Patch v3 12/13] x86/speculation: Protect non-dumpable processes
 against Spectre v2 attack
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
References: <cover.1539798901.git.tim.c.chen@linux.intel.com>
 <e36e964567beed0a2769d84c8d4144870e922655.1539798901.git.tim.c.chen@linux.intel.com>
From:   Waiman Long <longman9394@gmail.com>
Message-ID: <83fff257-57f3-06db-91ac-7f072bc93b23@gmail.com>
Date:   Fri, 26 Oct 2018 13:46:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <e36e964567beed0a2769d84c8d4144870e922655.1539798901.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 01:59 PM, Tim Chen wrote:
> Mark the non-dumpable processes with TIF_STIBP flag so they will
> use STIBP and IBPB defenses against Spectre v2 attack from
> processes in user space.
>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 1d317f2..cc77b9e 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -14,6 +14,7 @@
>  #include <linux/module.h>
>  #include <linux/nospec.h>
>  #include <linux/prctl.h>
> +#include <linux/sched/coredump.h>
>  
>  #include <asm/spec-ctrl.h>
>  #include <asm/cmdline.h>
> @@ -773,6 +774,26 @@ int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
>  	}
>  }
>  
> +void arch_set_dumpable(struct task_struct *tsk, unsigned int value)
> +{
> +	bool update;
> +
> +	if (!static_branch_unlikely(&spectre_v2_app_lite))
> +		return;
> +	if (!static_cpu_has(X86_FEATURE_STIBP))
> +		return;
> +	if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_NONE)
> +		return;

The third if above seems to be a subset of the first one. Do you need to
do the check one more time?

Cheers,
Longman

> +
> +	if (tsk->mm && value != SUID_DUMP_USER)
> +		update = !test_and_set_tsk_thread_flag(tsk, TIF_STIBP);
> +	else
> +		update = test_and_clear_tsk_thread_flag(tsk, TIF_STIBP);
> +
> +	if (tsk == current && update)
> +		speculation_ctrl_update_current();
> +}
> +
>  #ifdef CONFIG_SECCOMP
>  void arch_seccomp_spec_mitigate(struct task_struct *task)
>  {



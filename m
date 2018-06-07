Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 13vLN0ZAGVuLYAAAmS7hNA
	; Thu, 07 Jun 2018 14:25:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EA080608BA; Thu,  7 Jun 2018 14:25:55 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1JUFI93"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 48DC6602FC;
	Thu,  7 Jun 2018 14:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48DC6602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933384AbeFGOZx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:25:53 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:45192 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753103AbeFGOZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:25:49 -0400
Received: by mail-vk0-f65.google.com with SMTP id n134-v6so6145214vke.12;
        Thu, 07 Jun 2018 07:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ro7exVqps1s/SXZT/NIJdfCFQHjGQLvvszmoBJ9+0+U=;
        b=t1JUFI93L/Wy7y0Om6qaFzoPKd/um0W1k5yrhP+/QiSuUCOzacsu2dFeG+YtmBfi+W
         4qH/fIfpkAOW89AFYDXK++eRWQw0JGMncEs9bLbQXhh3urxcU3RRbDg/wVJgE6Ut/AT3
         uVdK+TalzBDRELJ7DYEjm8c3C08MmoX8cLlbn4+vnkuJHigTocLMh8ARw5u1y+mB3spO
         HxCZiStD7DTlrN4XnEd9JZK0L4m9sBnGTwtQW/BGjCbb601cX6aWnng1QTev0py67yNM
         UZ6I9wPTGqVt+87aVqk2gJutIh+UkfNg3lfmOoQQStBc0uwDAmKBTGquaX+eu3tOPrVK
         yGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ro7exVqps1s/SXZT/NIJdfCFQHjGQLvvszmoBJ9+0+U=;
        b=McOI7gY3snbEbZyA9ZKeMMNfJ9vxreWPlpHUbV9u2FoEFFLTntcbJ+EHHRAgoY6JPM
         6BOegAhYF5gH9aa9kGM1h5b1QOw3DH3Qp8JGV4vH9DNA+7BRfpPEWU1q18QR2YhuCJp0
         zck0Qk0KMMXkks8auGl0+aiSBMLortZwCCJKDmDV96IAIH2csg/XU3Vn4H4WoS5t0yFj
         Q5Ko46OaM6HpbURMvkEJwXSJyGOIle8e8Lln/H4kowEMMTZEn0JnmJIpFe8cPemZD50M
         zPIJtlo+3u8jdV49xiLGiZV8oKlmBGzJFHRqo3JzMYmE456aXBNaIypkMvjoTPys6cRt
         xWdQ==
X-Gm-Message-State: APt69E3X1VX5k4ltkL3+BFr+pvPd+pFiq92Bsnb3CHNe8d5Oi2R6GMom
        Y0tgJP1RN8yHIE9K407MlvNmLLftfwieJHyMYGRn/u0a
X-Google-Smtp-Source: ADUXVKLTvhz7JytbgFuG6ZHzE/2MriImr9RBX3j0LdND7AnNEi8u5K8W/t3UD3oBeSbRCPy1rZTyxx0F7toeuqceIi4=
X-Received: by 2002:a1f:644:: with SMTP id 65-v6mr1255432vkg.159.1528381548345;
 Thu, 07 Jun 2018 07:25:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8596:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 07:25:47 -0700 (PDT)
In-Reply-To: <20180606163846.495725-1-jeremy.linton@arm.com>
References: <20180606163846.495725-1-jeremy.linton@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Jun 2018 16:25:47 +0200
X-Google-Sender-Auth: lQM9OY0W6E8363vRRasoz6LxfRU
Message-ID: <CAMuHMdXW4M5CNS3wvb1R8v7ioGX7Q3ODcfgcdn2Ok3FRedTMZA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: topology: Avoid checking numa mask for
 scheduler MC selection
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>, Morten.Rasmussen@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

On Wed, Jun 6, 2018 at 6:38 PM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> The numa mask subset check can often lead to system hang or crash during
> CPU hotplug and system suspend operation if NUMA is disabled. This is

Also during boot, if CONFIG_ARM_PSCI_CHECKER=y.

> mostly observed on HMP systems where the CPU compute capacities are
> different and ends up in different scheduler domains. Since
> cpumask_of_node is returned instead core_sibling, the scheduler is
> confused with incorrect cpumasks(e.g. one CPU in two different sched
> domains at the same time) on CPU hotplug.
>
> Lets disable the NUMA siblings checks for the time being, as NUMA in
> socket machines have LLC's that will assure that the scheduler topology
> isn't "borken".
>
> The NUMA check exists to assure that if a LLC within a socket crosses
> NUMA nodes/chiplets the scheduler domains remain consistent. This code will
> likely have to be re-enabled in the near future once the NUMA mask story
> is sorted.  At the moment its not necessary because the NUMA in socket
> machines LLC's are contained within the NUMA domains.
>
> Further, as a defensive mechanism during hot-plug, lets assure that the
> LLC siblings are also masked.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Thanks!

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  arch/arm64/kernel/topology.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 7415c166281f..f845a8617812 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -215,13 +215,8 @@ EXPORT_SYMBOL_GPL(cpu_topology);
>
>  const struct cpumask *cpu_coregroup_mask(int cpu)
>  {
> -       const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));
> +       const cpumask_t *core_mask = &cpu_topology[cpu].core_sibling;
>
> -       /* Find the smaller of NUMA, core or LLC siblings */
> -       if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
> -               /* not numa in package, lets use the package siblings */
> -               core_mask = &cpu_topology[cpu].core_sibling;
> -       }
>         if (cpu_topology[cpu].llc_id != -1) {
>                 if (cpumask_subset(&cpu_topology[cpu].llc_siblings, core_mask))
>                         core_mask = &cpu_topology[cpu].llc_siblings;
> @@ -239,8 +234,10 @@ static void update_siblings_masks(unsigned int cpuid)
>         for_each_possible_cpu(cpu) {
>                 cpu_topo = &cpu_topology[cpu];
>
> -               if (cpuid_topo->llc_id == cpu_topo->llc_id)
> +               if (cpuid_topo->llc_id == cpu_topo->llc_id) {
>                         cpumask_set_cpu(cpu, &cpuid_topo->llc_siblings);
> +                       cpumask_set_cpu(cpuid, &cpu_topo->llc_siblings);
> +               }
>
>                 if (cpuid_topo->package_id != cpu_topo->package_id)
>                         continue;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

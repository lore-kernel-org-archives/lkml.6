Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AC4C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6031221479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6031221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbeJIOvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:51:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44948 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeJIOvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:51:05 -0400
Received: by mail-oi1-f196.google.com with SMTP id u74-v6so449012oia.11;
        Tue, 09 Oct 2018 00:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tJNcZl1Wcpt1/GGU3Sqg7LJJL6lJ73XqCHik5wAEtw=;
        b=LJAzGfV71Lt0q3IVkr091+PLUwPzD7EKBgBj+rBJgXQmygs+7gO9VPpQ3a0646YIYH
         yC+yYAepN71OMi6sDIcc+vsDEScInwkFEhsXqRB8IBCNstzGAWIYMfvkep3FU07BXD2m
         iVChszb6Xa8O19pHyXDJgxLMvQfKdep0dnDI5tmgT5V5iHkitrJXR0AvAtDziOIDWPWf
         8ba0vftzBFdzpvu5xJ4AkFJCcD7WJdBUvyWYRWzE4qOs0FX1eedppCT1PxApfLzi1Xd7
         KEBVXryU9ZQ3BzWUMArQxLfBc77B8TNIdhLyTmVwnTQqGxK2r86DevcdtumVCyEAK5pX
         VTmg==
X-Gm-Message-State: ABuFfojiSiNc/g4x428+A4b//fVlDebdvOnuAJ7CEjsOWZyV7JYTmhi+
        TeNKJie5qfTtBxc6cHaCiTuwdkJ4E9rk2xtjtq4=
X-Google-Smtp-Source: ACcGV61hvRq0U3DI+W5yy3VEjtZfmD1BrNp5Rl0sFOn/Gzv6+ByE7gn7a8JgjL57gESskb72TOo/aV1cN7WJLQ29aTg=
X-Received: by 2002:aca:b157:: with SMTP id a84-v6mr6577730oif.289.1539070529396;
 Tue, 09 Oct 2018 00:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181008165136.9288-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20181008165136.9288-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Oct 2018 09:35:17 +0200
Message-ID: <CAJZ5v0h1ir+vU7xzQ15edSO6uNwXzmqXRFkbhPGpUY8gSz+gVg@mail.gmail.com>
Subject: Re: [RESEND][PATCH] ACPI / CPPC: Add support for guaranteed performance
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devel@acpica.org, Linux PM <linux-pm@vger.kernel.org>,
        Prashanth Prakash <pprakash@codeaurora.org>,
        George Cherian <george.cherian@cavium.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 6:55 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> The Continuous Performance Control Package can have guaranteed performance
> field. Add support to read guaranteed performance.

The spec says that it is optional, but you seem to assume that it
always will be there.

What happens if it is not there?

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> No changes. But adding CC to mailing lists.
>
>  Documentation/acpi/cppc_sysfs.txt |  2 ++
>  drivers/acpi/cppc_acpi.c          | 10 ++++++++--
>  include/acpi/cppc_acpi.h          |  1 +
>  3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/acpi/cppc_sysfs.txt b/Documentation/acpi/cppc_sysfs.txt
> index f20fb445135d..812574d30717 100644
> --- a/Documentation/acpi/cppc_sysfs.txt
> +++ b/Documentation/acpi/cppc_sysfs.txt
> @@ -22,6 +22,7 @@ $ ls -lR  /sys/devices/system/cpu/cpu0/acpi_cppc/
>  /sys/devices/system/cpu/cpu0/acpi_cppc/:
>  total 0
>  -r--r--r-- 1 root root 65536 Mar  5 19:38 feedback_ctrs
> +-r--r--r-- 1 root root 65536 Mar  5 19:38 guaranteed_perf
>  -r--r--r-- 1 root root 65536 Mar  5 19:38 highest_perf
>  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_freq
>  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_nonlinear_perf
> @@ -33,6 +34,7 @@ total 0
>
>  --------------------------------------------------------------------------------
>
> +* guaranteed_perf : Guaranteed performance of this processor (abstract scale).
>  * highest_perf : Highest performance of this processor (abstract scale).
>  * nominal_perf : Highest sustained performance of this processor (abstract scale).
>  * lowest_nonlinear_perf : Lowest performance of this processor with nonlinear
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index d9ce4b162e2c..5babb9402f11 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -153,6 +153,7 @@ __ATTR(_name, 0444, show_##_name, NULL)
>         }                                                               \
>         define_one_cppc_ro(member_name)
>
> +show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, guaranteed_perf);
>  show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, highest_perf);
>  show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_perf);
>  show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_perf);
> @@ -189,6 +190,7 @@ static struct attribute *cppc_attrs[] = {
>         &nominal_perf.attr,
>         &nominal_freq.attr,
>         &lowest_freq.attr,
> +       &guaranteed_perf.attr,
>         NULL
>  };
>
> @@ -1061,9 +1063,9 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  {
>         struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>         struct cpc_register_resource *highest_reg, *lowest_reg,
> -               *lowest_non_linear_reg, *nominal_reg,
> +               *lowest_non_linear_reg, *nominal_reg, *guaranteed_reg,
>                 *low_freq_reg = NULL, *nom_freq_reg = NULL;
> -       u64 high, low, nom, min_nonlinear, low_f = 0, nom_f = 0;
> +       u64 high, low, guaranteed, nom, min_nonlinear, low_f = 0, nom_f = 0;
>         int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>         struct cppc_pcc_data *pcc_ss_data = NULL;
>         int ret = 0, regs_in_pcc = 0;
> @@ -1079,6 +1081,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>         nominal_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
>         low_freq_reg = &cpc_desc->cpc_regs[LOWEST_FREQ];
>         nom_freq_reg = &cpc_desc->cpc_regs[NOMINAL_FREQ];
> +       guaranteed_reg = &cpc_desc->cpc_regs[GUARANTEED_PERF];
>
>         /* Are any of the regs PCC ?*/
>         if (CPC_IN_PCC(highest_reg) || CPC_IN_PCC(lowest_reg) ||
> @@ -1107,6 +1110,9 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>         cpc_read(cpunum, nominal_reg, &nom);
>         perf_caps->nominal_perf = nom;
>
> +       cpc_read(cpunum, guaranteed_reg, &guaranteed);
> +       perf_caps->guaranteed_perf = guaranteed;
> +
>         cpc_read(cpunum, lowest_non_linear_reg, &min_nonlinear);
>         perf_caps->lowest_nonlinear_perf = min_nonlinear;
>
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 8e0b8250a139..cf59e6210d27 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -104,6 +104,7 @@ enum cppc_regs {
>   * today.
>   */
>  struct cppc_perf_caps {
> +       u32 guaranteed_perf;
>         u32 highest_perf;
>         u32 nominal_perf;
>         u32 lowest_perf;
> --
> 2.17.1
>

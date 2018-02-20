Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752055AbeBTSnS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:43:18 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35241 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbeBTSnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:43:16 -0500
X-Google-Smtp-Source: AH8x225LUEIvd+FbExo2TQAMHDsVQsM+d/q93XTdJUo8ScP9aInmCmfFqB0yLJcfGhT4ODo3rj4g1VQDoM2ZmhQODow=
MIME-Version: 1.0
In-Reply-To: <20180220180506.65523-3-andriy.shevchenko@linux.intel.com>
References: <20180220180506.65523-1-andriy.shevchenko@linux.intel.com> <20180220180506.65523-3-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Feb 2018 19:43:15 +0100
X-Google-Sender-Auth: yCYSmserIGS_DCZr02euQ6VYsCo
Message-ID: <CAJZ5v0iVP-=RPNU2nwz2DUuvDxp42G86iiyD4_ZuJU-GJFZzrw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] x86/platform/intel-mid: Add special handling of
 ACPI HW reduced platforms
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 7:05 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> When switching to ACPI HW reduced platforms we still want to initialize timers.
> Override x86_init.acpi.reduced_hw_init to achieve that.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/platform/intel-mid/intel-mid.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
> index 2c67bae6bb53..c556f1e8936e 100644
> --- a/arch/x86/platform/intel-mid/intel-mid.c
> +++ b/arch/x86/platform/intel-mid/intel-mid.c
> @@ -199,6 +199,12 @@ void __init x86_intel_mid_early_setup(void)
>
>         legacy_pic = &null_legacy_pic;
>
> +       /*
> +        * Do nothing for now as everything needed done in
> +        * x86_intel_mid_early_setup() below.
> +        */
> +       x86_init.acpi.reduced_hw_early_init = x86_init_noop;
> +
>         pm_power_off = intel_mid_power_off;
>         machine_ops.emergency_restart  = intel_mid_reboot;
>
> --
> 2.15.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

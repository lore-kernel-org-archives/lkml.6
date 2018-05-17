Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeEQKPl convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:15:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59003 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeEQKPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:15:39 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mathieu Malaterre <malat@debian.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi: add missing prototype for =?UTF-8?B?4oCYYXJjaF9wb3N0X2FjcGlfc3Vic3lzX2luaXTigJk=?=
Date: Thu, 17 May 2018 12:15:04 +0200
Message-ID: <1741093.hO3EZQahsV@aspire.rjw.lan>
In-Reply-To: <20180505203603.4071-1-malat@debian.org>
References: <20180505203603.4071-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, May 5, 2018 10:36:03 PM CEST Mathieu Malaterre wrote:
> In commit e7ff3a47630d ("x86/amd: Check for the C1E bug post ACPI subsystem
> init") a new function ‘arch_post_acpi_subsys_init’ was introduced. This
> weak function can potentially be overridden on a per arch basis, introduce
> the prototype for clarity.
> 
> Silence the following gcc warning (W=1):
> 
>   init/main.c:484:20: warning: no previous prototype for ‘arch_post_acpi_subsys_init’ [-Wmissing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  include/linux/acpi.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 15bfb15c2fa5..cb4d7b6b085c 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -578,6 +578,7 @@ int acpi_match_platform_list(const struct acpi_platform_list *plat);
>  
>  extern void acpi_early_init(void);
>  extern void acpi_subsystem_init(void);
> +extern void arch_post_acpi_subsys_init(void);
>  
>  extern int acpi_nvs_register(__u64 start, __u64 size);
>  
> 

Applied, thanks!

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeD2EQw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 00:16:52 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36399 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbeD2EQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 00:16:51 -0400
X-Google-Smtp-Source: AB8JxZqXrLPmspxxLtDSibHQbjJh4sRYeFFkJRy+Mp+gtQ62H8DM5NJbfgSN1g9KG3KXTq9/HWuiA6PIf5/r3z4ikJA=
MIME-Version: 1.0
In-Reply-To: <1524966879-9424-1-git-send-email-linux@roeck-us.net>
References: <1524966879-9424-1-git-send-email-linux@roeck-us.net>
From: Gabriel C <nix.or.die@gmail.com>
Date: Sun, 29 Apr 2018 06:16:19 +0200
Message-ID: <CAEJqkghLXNMmxjJ5ARv=E20FqvGxOaihAH5dizsetGoBOV_r=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/amd_nb: Add support for Raven Ridge CPUs
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Clemens Ladisch <clemens@ladisch.de>, X86 ML <x86@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Brian Woods <brian.woods@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-29 3:54 GMT+02:00 Guenter Roeck <linux@roeck-us.net>:
> Add Raven Ridge root bridge and data fabric PCI IDs.
> This is required for amd_pci_dev_to_node_id() and amd_smn_read().
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> This patch is a prerequisite for the second patch in the series.
> I'll be happy to apply both patches through hwmon if that is acceptable
> (and Cc: stable for 4.16+). If not, I'll be happy to wait for this patch
> to be available upstream.
>
> Since that there is no public documentation available for Raven Ridge,
> PCI IDs are derived from output of lspci.
>
>  arch/x86/kernel/amd_nb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index c88e0b127810..bd33613ecb7c 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -14,8 +14,11 @@
>  #include <asm/amd_nb.h>
>
>  #define PCI_DEVICE_ID_AMD_17H_ROOT     0x1450
> +#define PCI_DEVICE_ID_AMD_17H_RR_ROOT  0x15d0
>  #define PCI_DEVICE_ID_AMD_17H_DF_F3    0x1463
>  #define PCI_DEVICE_ID_AMD_17H_DF_F4    0x1464
> +#define PCI_DEVICE_ID_AMD_17H_RR_DF_F3 0x15eb
> +#define PCI_DEVICE_ID_AMD_17H_RR_DF_F4 0x15ec
>
>  /* Protect the PCI config register pairs used for SMN and DF indirect access. */
>  static DEFINE_MUTEX(smn_mutex);
> @@ -24,6 +27,7 @@ static u32 *flush_words;
>
>  static const struct pci_device_id amd_root_ids[] = {
>         { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_ROOT) },
> +       { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_RR_ROOT) },
>         {}
>  };
>
> @@ -39,6 +43,7 @@ const struct pci_device_id amd_nb_misc_ids[] = {
>         { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
>         { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
>         { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
> +       { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_RR_DF_F3) },
>         { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
>         {}
>  };
> @@ -51,6 +56,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>         { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_NB_F4) },
>         { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F4) },
>         { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F4) },
> +       { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_RR_DF_F4) },
>         { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
>         {}
>  };
> --
> 2.7.4
>

Works fine for me on top stable and on top v4.17-rc2-398-gcdface520934

Tested-by: Gabriel Craciunescu <nix.or.die@gmail.com>


Regards

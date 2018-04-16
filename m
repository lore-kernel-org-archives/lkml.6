Return-Path: <ard.biesheuvel@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523866997; cv=none;
        d=google.com; s=arc-20160816;
        b=h2JA0xI7xzWDM0gMMqMmPfv2r4A19xS1KrV+LDh5HUAvGokwKS3rMDh1/QUgHr5+Iu
         cG1uZsuLcQdEiqWuZ3X/gAkkYYZ6X8lQzS5xiNP3z0KJPrQXABUI8yUeAnxzY07Raccy
         gufjoUe3fYjCFKfkEOXNIX88ZHEUB/KAjkglqukBYsAxwgKfIDuOQWyCjUf23g9NNSAE
         /kpTTpUBOaCD4jRSzoS9TUvUZJgpEss36oZVpzXu/KeViYpl4xndbda3+0SaawhnX0l3
         GC7GziKj01WQ9mx/pntzq+KaOMYWl3rcfjAG1zOByPoDdFXbx6M/OsADuZBaZ8LYopwX
         Lwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=B22lYjnhsda1CwXZO/eKgpXOVFrV2obCtCDKvLQ0tRQ=;
        b=xaR+sy/a5nVbRSVSvpoyvgxAglIKjS6PPUNibxE3yLLCZttPp+7kVW/OOuBL6cmJkR
         Fxk3NTteLKOsHA549rtfsdGLuCjBRRoMHcpCxOFfIVIikvzzM+IGT1J2bHFUeuFo9kVe
         LvRQbGbTX0Ic4ZZyFCp7qTlo25TqJA6h8UnLDohSP0OSdayNHYCVXEyiPZ7LgEoixhil
         wxxP//ryqyLNKR5xfBCd/i2tvYo6JLH5XM5EtxYv2PY+WJZENEjQCVJqdgDsRLtwGJ5+
         fDaTEKj085btFmeKaKhgpt7hkYVLrWdOJcVc5oG3LGkL0W1gzjiaGu2YPNMjH1PTIXF1
         lTOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=FQ19EKxX;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=FQ19EKxX;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx48LZ3DC3Iv3SBpuROqYtMHpthUagyQQ7La4JRAYoDd/YSxAHyfiri7/13fP0HJcVJAfMY54fSk66G1RtAq7+mY=
MIME-Version: 1.0
In-Reply-To: <20180408174014.21908-2-hdegoede@redhat.com>
References: <20180408174014.21908-1-hdegoede@redhat.com> <20180408174014.21908-2-hdegoede@redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 16 Apr 2018 10:23:17 +0200
Message-ID: <CAKv+Gu-DZ86y5pmQ+-gQWLHAcs47H-cixCM1pBKmKZXA=+jRmg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] efi: Export boot-services code and data as debugfs-blobs
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	platform-driver-x86@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Jones <pjones@redhat.com>,
	Dave Olsthoorn <dave@bewaar.me>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
	Matt Fleming <matt@codeblueprint.co.uk>, David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Martin Fuzzey <mfuzzey@parkeon.com>,
	Kees Cook <keescook@chromium.org>, Kalle Valo <kvalo@codeaurora.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Broeking <nbroeking@me.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>, Torsten Duwe <duwe@suse.de>,
	"the arch/x86 maintainers" <x86@kernel.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597199777602363676?=
X-GMAIL-MSGID: =?utf-8?q?1597890361100552989?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hallo Hans,

On 8 April 2018 at 19:40, Hans de Goede <hdegoede@redhat.com> wrote:
> Sometimes it is useful to be able to dump the efi boot-services code and
> data. This commit adds these as debugfs-blobs to /sys/kernel/debug/efi,
> but only if efi=debug is passed on the kernel-commandline as this requires
> not freeing those memory-regions, which costs 20+ MB of RAM.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Do not call pr_err on debugfs call failures
> ---
>  arch/x86/platform/efi/quirks.c |  4 +++
>  drivers/firmware/efi/efi.c     | 53 ++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 5b513ccffde4..0f968c7bcfec 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -374,6 +374,10 @@ void __init efi_free_boot_services(void)
>         int num_entries = 0;
>         void *new, *new_md;
>
> +       /* Keep all regions for /sys/kernel/debug/efi */
> +       if (efi_enabled(EFI_DBG))
> +               return;
> +
>         for_each_efi_memory_desc(md) {
>                 unsigned long long start = md->phys_addr;
>                 unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index cd42f66a7c85..10c896e8b82b 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -18,6 +18,7 @@
>  #include <linux/kobject.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> +#include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/efi.h>
>  #include <linux/of.h>
> @@ -316,6 +317,55 @@ static __init int efivar_ssdt_load(void)
>  static inline int efivar_ssdt_load(void) { return 0; }
>  #endif
>
> +#ifdef CONFIG_DEBUG_FS
> +
> +#define EFI_DEBUGFS_MAX_BLOBS 32
> +
> +static struct debugfs_blob_wrapper debugfs_blob[EFI_DEBUGFS_MAX_BLOBS];
> +
> +static void __init efi_debugfs_init(void)
> +{
> +       struct dentry *efi_debugfs;
> +       efi_memory_desc_t *md;
> +       char name[32];
> +       int type_count[EFI_BOOT_SERVICES_DATA + 1] = {};
> +       int i = 0;
> +
> +       efi_debugfs = debugfs_create_dir("efi", NULL);
> +       if (IS_ERR_OR_NULL(efi_debugfs))
> +               return;
> +
> +       for_each_efi_memory_desc(md) {
> +               switch (md->type) {
> +               case EFI_BOOT_SERVICES_CODE:
> +                       snprintf(name, sizeof(name), "boot_services_code%d",
> +                                type_count[md->type]++);
> +                       break;
> +               case EFI_BOOT_SERVICES_DATA:
> +                       snprintf(name, sizeof(name), "boot_services_data%d",
> +                                type_count[md->type]++);
> +                       break;
> +               default:
> +                       continue;
> +               }
> +
> +               debugfs_blob[i].size = md->num_pages << EFI_PAGE_SHIFT;
> +               debugfs_blob[i].data = memremap(md->phys_addr,
> +                                               debugfs_blob[i].size,
> +                                               MEMREMAP_WB);
> +               if (!debugfs_blob[i].data)
> +                       continue;
> +
> +               debugfs_create_blob(name, 0400, efi_debugfs, &debugfs_blob[i]);
> +               i++;
> +               if (i == EFI_DEBUGFS_MAX_BLOBS)
> +                       break;
> +       }
> +}
> +#else
> +static inline void efi_debugfs_init(void) {}
> +#endif
> +
>  /*
>   * We register the efi subsystem with the firmware subsystem and the
>   * efivars subsystem with the efi subsystem, if the system was booted with
> @@ -360,6 +410,9 @@ static int __init efisubsys_init(void)
>                 goto err_remove_group;
>         }
>
> +       if (efi_enabled(EFI_DBG))
> +               efi_debugfs_init();
> +

This doesn't really make any sense on non-x86. The boot services
regions are released to the kernel for general allocation, and so
exposing them this way only makes sense if you keep them as you do for
x86.

Could you please try to make this call specific to situations where it
makes sense? I don't mind allocating a new EFI_xxx flag for preserving
the boot services regions so we could decide to set it for ARM/arm64
as well in certain cases in the future.

>         return 0;
>
>  err_remove_group:
> --
> 2.17.0
>

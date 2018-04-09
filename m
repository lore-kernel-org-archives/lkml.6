Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523261369; cv=none;
        d=google.com; s=arc-20160816;
        b=twQ0CM7seAXf9go3qLV7EWfJoOjxnKxPCGt8cdM9GoRpbJv9jjyN+j9JC7g8MqJzqN
         jDO0MVlzu6p2kUeHZpOM9+3m5Y6v6R4YtemIImhYHkAmDbvxYdDkeDtwvzFQdCMwkiEN
         7IdL0OS9qpj6epg/u892CYZiaZsGqLRLhoxgy+Se90WEjZou+610fzftKWYi6CVJECU/
         uf2wWIA0VqNsDCzWQfRa8+i4nabprZIi+s6aH3AU3POsjmiGqMky+Xz2rwx1HdheW2w9
         G0pgHbD4qrUOhZILzoUbGKIBTWep26qEOSg7zOsUnuJ5j+/hWPowwaav7GDApLq12a9a
         B5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=qOvedLpwxF4jfZ32+xT7UGEBCTiSnXIfG0Sk344TtHo=;
        b=Vr4/B2gIb1QAlkNfKxf8dg8jS51hkFHMfzB+F21vAsIz/iVb/OlfO+bhdELjSdKFmn
         K1u3A4PhlYZZz7x8z2/dywklsdSUTrLyUOY5uSGNa8YcChcs6JFNx6xai5CsBHwRlMLo
         4eLJ7hrHzftkJucNRULp4jjU1GBt7QJf+gaIMGXofnhaeOYaV8F07cRHGoBbHuqygYBV
         h6BTIMvGp5+JRKxGWDzI6gMvmgVBJK4SCVBcQicQOTA/6LeZ2iZjnNQ2wti7cJkphIvX
         Pmn1xqQqVc6So+p1crypsSD4es9Gt8f02t88YTyAeswIAzY1OltEFMyso9H2MCNR3BPv
         85mg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZmK0zOAb;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZmK0zOAb;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48VA7N1IBUMHbp9yYsqGNg7LHpCjrha4ZJ8H7VI0a8DOqG3wIF8/3tXUqNmTgkMx595mmSHx+2dJ8LABebFFX0=
MIME-Version: 1.0
In-Reply-To: <20180408172636.13926-5-hdegoede@redhat.com>
References: <20180408172636.13926-1-hdegoede@redhat.com> <20180408172636.13926-5-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 9 Apr 2018 11:09:28 +0300
Message-ID: <CAHp75VfSH5_N=tfJuw25ddD_rLvB7+irSyOW=dvAhAcwY9g+gg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] platform/x86: touchscreen_dmi: Add EFI embedded
 firmware info support
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Luis R . Rodriguez" <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Platform Driver <platform-driver-x86@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Jones <pjones@redhat.com>,
	Dave Olsthoorn <dave@bewaar.me>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
	Matt Fleming <matt@codeblueprint.co.uk>, David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, mfuzzey@parkeon.com,
	Kees Cook <keescook@chromium.org>, Kalle Valo <kvalo@codeaurora.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, nbroeking@me.com,
	Bjorn Andersson <bjorn.andersson@linaro.org>, Torsten Duwe <duwe@suse.de>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597199789543333032?=
X-GMAIL-MSGID: =?utf-8?q?1597255314653209753?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 8, 2018 at 8:26 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Sofar we have been unable to get permission from the vendors to put the
> firmware for touchscreens listed in touchscreen_dmi in linux-firmware.
>
> Some of the tablets with such a touchscreen have a touchscreen driver, and
> thus a copy of the firmware, as part of their EFI code.
>
> This commit adds the necessary info for the new EFI embedded-firmware code
> to extract these firmwares, making the touchscreen work OOTB without the
> user needing to manually add the firmware.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

for PDx86 bits only.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/firmware/efi/embedded-firmware.c |  3 +++
>  drivers/platform/x86/Kconfig             |  1 +
>  drivers/platform/x86/touchscreen_dmi.c   | 26 +++++++++++++++++++++++-
>  include/linux/efi_embedded_fw.h          |  2 ++
>  4 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/embedded-firmware.c b/drivers/firmware/efi/embedded-firmware.c
> index cb57225a340d..26101ac1a282 100644
> --- a/drivers/firmware/efi/embedded-firmware.c
> +++ b/drivers/firmware/efi/embedded-firmware.c
> @@ -23,6 +23,9 @@ struct embedded_fw {
>  static LIST_HEAD(found_fw_list);
>
>  static const struct dmi_system_id * const embedded_fw_table[] = {
> +#ifdef CONFIG_TOUCHSCREEN_DMI
> +       touchscreen_dmi_table,
> +#endif
>         NULL
>  };
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index b836576f0fe4..5bb0f5edd7f2 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1197,6 +1197,7 @@ config INTEL_TURBO_MAX_3
>  config TOUCHSCREEN_DMI
>         bool "DMI based touchscreen configuration info"
>         depends on ACPI && DMI && I2C=y && TOUCHSCREEN_SILEAD
> +       select EFI_EMBEDDED_FIRMWARE if EFI_STUB
>         ---help---
>           Certain ACPI based tablets with e.g. Silead or Chipone touchscreens
>           do not have enough data in ACPI tables for the touchscreen driver to
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 87fc839b28f7..6488cd50ba79 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -15,12 +15,15 @@
>  #include <linux/acpi.h>
>  #include <linux/device.h>
>  #include <linux/dmi.h>
> +#include <linux/efi_embedded_fw.h>
>  #include <linux/i2c.h>
>  #include <linux/notifier.h>
>  #include <linux/property.h>
>  #include <linux/string.h>
>
>  struct ts_dmi_data {
> +       /* The EFI embedded-fw code expects this to be the first member! */
> +       struct efi_embedded_fw_desc embedded_fw;
>         const char *acpi_name;
>         const struct property_entry *properties;
>  };
> @@ -31,10 +34,17 @@ static const struct property_entry cube_iwork8_air_props[] = {
>         PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
>         PROPERTY_ENTRY_STRING("firmware-name", "gsl3670-cube-iwork8-air.fw"),
>         PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +       PROPERTY_ENTRY_BOOL("efi-embedded-firmware"),
>         { }
>  };
>
>  static const struct ts_dmi_data cube_iwork8_air_data = {
> +       .embedded_fw = {
> +               .name   = "silead/gsl3670-cube-iwork8-air.fw",
> +               .prefix = { 0xf0, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00 },
> +               .length = 38808,
> +               .crc    = 0xfecde51f,
> +       },
>         .acpi_name      = "MSSL1680:00",
>         .properties     = cube_iwork8_air_props,
>  };
> @@ -119,10 +129,17 @@ static const struct property_entry pipo_w2s_props[] = {
>         PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
>         PROPERTY_ENTRY_STRING("firmware-name",
>                               "gsl1680-pipo-w2s.fw"),
> +       PROPERTY_ENTRY_BOOL("efi-embedded-firmware"),
>         { }
>  };
>
>  static const struct ts_dmi_data pipo_w2s_data = {
> +       .embedded_fw = {
> +               .name   = "silead/gsl1680-pipo-w2s.fw",
> +               .prefix = { 0xf0, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00 },
> +               .length = 39072,
> +               .crc    = 0x28d5dc6c,
> +       },
>         .acpi_name      = "MSSL1680:00",
>         .properties     = pipo_w2s_props,
>  };
> @@ -162,10 +179,17 @@ static const struct property_entry chuwi_hi8_pro_props[] = {
>         PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
>         PROPERTY_ENTRY_STRING("firmware-name", "gsl3680-chuwi-hi8-pro.fw"),
>         PROPERTY_ENTRY_BOOL("silead,home-button"),
> +       PROPERTY_ENTRY_BOOL("efi-embedded-firmware"),
>         { }
>  };
>
>  static const struct ts_dmi_data chuwi_hi8_pro_data = {
> +       .embedded_fw = {
> +               .name   = "silead/gsl3680-chuwi-hi8-pro.fw",
> +               .prefix = { 0xf0, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00 },
> +               .length = 39864,
> +               .crc    = 0xfe2bedba,
> +       },
>         .acpi_name      = "MSSL1680:00",
>         .properties     = chuwi_hi8_pro_props,
>  };
> @@ -277,7 +301,7 @@ static const struct ts_dmi_data teclast_x3_plus_data = {
>         .properties     = teclast_x3_plus_props,
>  };
>
> -static const struct dmi_system_id touchscreen_dmi_table[] = {
> +const struct dmi_system_id touchscreen_dmi_table[] = {
>         {
>                 /* CUBE iwork8 Air */
>                 .driver_data = (void *)&cube_iwork8_air_data,
> diff --git a/include/linux/efi_embedded_fw.h b/include/linux/efi_embedded_fw.h
> index 0f7d4df3f57a..4c8cfe38ec02 100644
> --- a/include/linux/efi_embedded_fw.h
> +++ b/include/linux/efi_embedded_fw.h
> @@ -20,6 +20,8 @@ struct efi_embedded_fw_desc {
>         u32 crc;
>  };
>
> +extern const struct dmi_system_id touchscreen_dmi_table[];
> +
>  int efi_get_embedded_fw(const char *name, void **dat, size_t *sz, size_t msize);
>
>  #endif
> --
> 2.17.0
>



-- 
With Best Regards,
Andy Shevchenko

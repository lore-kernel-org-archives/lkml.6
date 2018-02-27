Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519773750; cv=none;
        d=google.com; s=arc-20160816;
        b=cYNGbzJnRWz/2qGYbMoe6vqqkVyBAW1yoBZ4TGuRR8JN5bmI3kYjWN5PBjXbiOF4CB
         e9k2Ahr5Aytxeyp8Jbe6/izd2rbRMWnBYg9X9KH9pD7CTGffqyMRC/ANuiEm/TNkj5gm
         kycOS52h6qDUgSUYstAPupWFIpphFj+SPW3GZVulUIGAO6IGXZ8+s0PNmcrmM4eeg6Tx
         Q2ItO6X8JGVBXa4MWoVTWy1YtKccuaUOy+0wa6wInkLJsuXz5YNglyPXJwGAXSX4VWuE
         R17iqPcEXzoKen3xS1U/bgcIefmm3lEqKRhtv3EMlwU9VXGpoMnrfjcTnBBYRr0t8P3S
         vOTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=n8EnnNxSSc251rNtaSoWTmEtd2dYo9VgVPZgpBBMfUk=;
        b=05NqQFdCUR3fgpYnBJ9AeFiYOORvcWHb4Aa4IRE3jKWukFU3MzLst5PVIktFhVUSZ8
         jJZaQQQQzh5a9XIh1bxjth3cdxERHAH6ZyDG4qwZ2zmTz7HIVAPYWUDgu/w3SlwFAVJ2
         A1ggBifwhc1ebCimo+YzitZd0iWtJOhtU0gizsBLz53uvFBY2pgbKcUu7WHjjAAQO+aB
         5XHaUjLzYh6GymAtDVEhMFsW4nDYLIy4o8uXtrKxAVNqp2Cpg2/HQt3tPxD6CLvPnxDT
         prQT7eZ1VH+/3iDyEV6qrl+3YsV3EnUBPv/N+OrhdMJujkvvTpOwK/Vg8k2A18+3zIES
         OybA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=UugIFv7V;
       dkim=pass header.i=@chromium.org header.s=google header.b=gRjpjXyQ;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=UugIFv7V;
       dkim=pass header.i=@chromium.org header.s=google header.b=gRjpjXyQ;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELsH739xP6/tlLQq8iUqAyp1p6xXAhX+WM4/75FjRgKkxw4Kxp5YrdIpda2w70fOSHC6MA2kcf4iAjg5Yfh6Q+I=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180224024613.24078-9-mcgrof@kernel.org>
References: <20180224024613.24078-1-mcgrof@kernel.org> <20180224024613.24078-9-mcgrof@kernel.org>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 15:22:28 -0800
X-Google-Sender-Auth: gZ2QiIUd233qgCL1C_MxxKu1taw
Message-ID: <CAGXu5jJG5JpRYqcL+NvAaqxZZP75Q66cr+qrVwTvpABVNn-m=w@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] firmware: enable run time change of forcing
 fallback loader
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Martin Fuzzey <mfuzzey@parkeon.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, pali.rohar@gmail.com,
	Takashi Iwai <tiwai@suse.de>, arend.vanspriel@broadcom.com,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, nbroeking@me.com,
	Vikram Mulukutla <markivx@codeaurora.org>, stephen.boyd@linaro.org,
	Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay_Salunke@dell.com, bjorn.andersson@linaro.org, jewalt@lgsinnovations.com,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248720825062588?=
X-GMAIL-MSGID: =?utf-8?q?1593598280238533724?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 6:46 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> Currently one requires to test four kernel configurations to test the
> firmware API completely:
>
> 0)
>   CONFIG_FW_LOADER=y
>
> 1)
>   o CONFIG_FW_LOADER=y
>   o CONFIG_FW_LOADER_USER_HELPER=y
>
> 2)
>   o CONFIG_FW_LOADER=y
>   o CONFIG_FW_LOADER_USER_HELPER=y
>   o CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
>
> 3) When CONFIG_FW_LOADER=m the built-in stuff is disabled, we have
>    no current tests for this.
>
> We can reduce the requirements to three kernel configurations by making
> fw_config.force_sysfs_fallback a proc knob we flip on off. For kernels that
> disable CONFIG_IKCONFIG_PROC this can also enable one to inspect if
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK was enabled at build time by checking
> the proc value at boot time.

You'll still need compile tests of each configuration, but I love that
this will give one kernel to test them all.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees


>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  drivers/base/firmware_fallback.c       |  1 +
>  drivers/base/firmware_fallback.h       |  4 +++-
>  drivers/base/firmware_fallback_table.c | 17 +++++++++++++++++
>  kernel/sysctl.c                        | 11 +++++++++++
>  4 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/firmware_fallback.c b/drivers/base/firmware_fallback.c
> index 47690207e0ee..cbce9a950cd8 100644
> --- a/drivers/base/firmware_fallback.c
> +++ b/drivers/base/firmware_fallback.c
> @@ -7,6 +7,7 @@
>  #include <linux/security.h>
>  #include <linux/highmem.h>
>  #include <linux/umh.h>
> +#include <linux/sysctl.h>
>
>  #include "firmware_fallback.h"
>  #include "firmware_loader.h"
> diff --git a/drivers/base/firmware_fallback.h b/drivers/base/firmware_fallback.h
> index 550498c7fa4c..ca7e69a8417b 100644
> --- a/drivers/base/firmware_fallback.h
> +++ b/drivers/base/firmware_fallback.h
> @@ -12,12 +12,14 @@
>   *
>   * @force_sysfs_fallback: force the sysfs fallback mechanism to be used
>   *     as if one had enabled CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y.
> + *     Useful to help debug a CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
> + *     functionality on a kernel where that config entry has been disabled.
>   * @old_timeout: for internal use
>   * @loading_timeout: the timeout to wait for the fallback mechanism before
>   *     giving up, in seconds.
>   */
>  struct firmware_fallback_config {
> -       const bool force_sysfs_fallback;
> +       unsigned int force_sysfs_fallback;
>         int old_timeout;
>         int loading_timeout;
>  };
> diff --git a/drivers/base/firmware_fallback_table.c b/drivers/base/firmware_fallback_table.c
> index 53cc4e492520..77300d5e9c52 100644
> --- a/drivers/base/firmware_fallback_table.c
> +++ b/drivers/base/firmware_fallback_table.c
> @@ -19,6 +19,9 @@
>  /* Module or buit-in */
>  #ifdef CONFIG_FW_LOADER_USER_HELPER
>
> +static unsigned int zero;
> +static unsigned int one = 1;
> +
>  struct firmware_fallback_config fw_fallback_config = {
>         .force_sysfs_fallback = IS_ENABLED(CONFIG_FW_LOADER_USER_HELPER_FALLBACK),
>         .loading_timeout = 60,
> @@ -26,4 +29,18 @@ struct firmware_fallback_config fw_fallback_config = {
>  };
>  EXPORT_SYMBOL_GPL(fw_fallback_config);
>
> +struct ctl_table firmware_config_table[] = {
> +       {
> +               .procname       = "force_sysfs_fallback",
> +               .data           = &fw_fallback_config.force_sysfs_fallback,
> +               .maxlen         = sizeof(unsigned int),
> +               .mode           = 0644,
> +               .proc_handler   = proc_douintvec_minmax,
> +               .extra1         = &zero,
> +               .extra2         = &one,
> +       },
> +       { }
> +};
> +EXPORT_SYMBOL_GPL(firmware_config_table);
> +
>  #endif
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index acdf4e85c0a1..aa8355953fcf 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -253,6 +253,10 @@ extern struct ctl_table random_table[];
>  extern struct ctl_table epoll_table[];
>  #endif
>
> +#ifdef CONFIG_FW_LOADER_USER_HELPER
> +extern struct ctl_table firmware_config_table[];
> +#endif
> +
>  #ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
>  int sysctl_legacy_va_layout;
>  #endif
> @@ -748,6 +752,13 @@ static struct ctl_table kern_table[] = {
>                 .mode           = 0555,
>                 .child          = usermodehelper_table,
>         },
> +#ifdef CONFIG_FW_LOADER_USER_HELPER
> +       {
> +               .procname       = "firmware_config",
> +               .mode           = 0555,
> +               .child          = firmware_config_table,
> +       },
> +#endif
>         {
>                 .procname       = "overflowuid",
>                 .data           = &overflowuid,
> --
> 2.16.2
>



-- 
Kees Cook
Pixel Security

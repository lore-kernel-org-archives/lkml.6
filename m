Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519773784; cv=none;
        d=google.com; s=arc-20160816;
        b=mg+8eUuUvIj13m7jTl9bxHcLgghNf5c+Iy4ZYrth418uxoFpCKTLlUD4OSMqQGSJzX
         M5i4c0hexEPVjUrytvpB0KuR1vAcYLtbZ23vAojLrVmdYvfmPtnZUFbTS5SstQez9Sod
         DCwLOKKYa9auZUmgd+bHWgchdAXz0yFYlKI0hj0P1brB/ts3FW8fy7GFX7YYx4MexKX6
         a2fsU7gjcq6Qy3cMtloZKtHjdIxeKKsN5lLjHyUN2YmLU3mbrVboKXMJCjIc+TZ1beJY
         du6ZrqxPAiwsctZqP77fy/29oF0rqtedymwBiSMZxHThxs+ENnOtLe1kZnp/s22wPCsk
         eyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=tGDi/70heOUovRST6lROw/JMYgjYh9dezyoUHJ8A/30=;
        b=UiAJlcgVT+iFcMwsC8rF1euohCUVa4kcXvT/pldezhLuVJMGAy38plDvrntCCR321u
         wQH8If3lVo1kEsnXnXFhGuN4jiyElzx0Mr2ntgDOjEYbOukYNfcGhOGrvpvmY7pqp/Wl
         +lM4FWbYI9y2x9DuGX1jPm6+LZ3v8WLyC9Z9Mm5GlEmTUx1IbhUguK8JSWob1Wn2Fh2P
         GjU5lNduDJhDjmiIunJD8Z82T72lTlLm162Q01myG9b144EV/+5MZCUXBslQg/MoNxzJ
         SqMCDZeMOMOHVKp5dmulWAcGLOio9Qec5VpaiiYpEZMM+i+ML3SY6F1PgkvVfQBbv5UF
         A3/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=mfviC+8p;
       dkim=pass header.i=@chromium.org header.s=google header.b=dKLF2sLS;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=mfviC+8p;
       dkim=pass header.i=@chromium.org header.s=google header.b=dKLF2sLS;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELu/AVDFAjiw41a6Jy6HPz7lGPziEH4r6c8fZqv60TFdy5YKhcMcf5hk7rV9D4GQK4s7zfLa4Odr7cr/d5h5SJA=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180224024613.24078-10-mcgrof@kernel.org>
References: <20180224024613.24078-1-mcgrof@kernel.org> <20180224024613.24078-10-mcgrof@kernel.org>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 15:23:03 -0800
X-Google-Sender-Auth: ZYScVxCijSRqqBUqwBYIrCLPuvc
Message-ID: <CAGXu5jKDrPDFz=iFD9XnB2OfcG_fgQuaQT96PCJi=+dhL7UB5w@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] firmware: enable to force disable the fallback
 mechanism at run time
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
X-GMAIL-THRID: =?utf-8?q?1593248722155111296?=
X-GMAIL-MSGID: =?utf-8?q?1593598316273048748?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 6:46 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> You currently need four different kernel builds to test the firmware
> API fully. By adding a proc knob to force disable the fallback mechanism
> completely we are able to reduce the amount of kernels you need built
> to test the firmware API down to two.
>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/base/firmware_fallback.c       | 5 +++++
>  drivers/base/firmware_fallback.h       | 4 ++++
>  drivers/base/firmware_fallback_table.c | 9 +++++++++
>  3 files changed, 18 insertions(+)
>
> diff --git a/drivers/base/firmware_fallback.c b/drivers/base/firmware_fallback.c
> index cbce9a950cd8..13fa5ff2b46c 100644
> --- a/drivers/base/firmware_fallback.c
> +++ b/drivers/base/firmware_fallback.c
> @@ -643,6 +643,11 @@ static bool fw_force_sysfs_fallback(unsigned int opt_flags)
>
>  static bool fw_run_sysfs_fallback(unsigned int opt_flags)
>  {
> +       if (fw_fallback_config.ignore_sysfs_fallback) {
> +               pr_info_once("Ignoring firmware sysfs fallback due to debugfs knob\n");
> +               return false;
> +       }
> +
>         if ((opt_flags & FW_OPT_NOFALLBACK))
>                 return false;
>
> diff --git a/drivers/base/firmware_fallback.h b/drivers/base/firmware_fallback.h
> index ca7e69a8417b..dfebc644ed35 100644
> --- a/drivers/base/firmware_fallback.h
> +++ b/drivers/base/firmware_fallback.h
> @@ -14,12 +14,16 @@
>   *     as if one had enabled CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y.
>   *     Useful to help debug a CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
>   *     functionality on a kernel where that config entry has been disabled.
> + * @ignore_sysfs_fallback: force to disable the sysfs fallback mechanism.
> + *     This emulates the behaviour as if we had set the kernel
> + *     config CONFIG_FW_LOADER_USER_HELPER=n.
>   * @old_timeout: for internal use
>   * @loading_timeout: the timeout to wait for the fallback mechanism before
>   *     giving up, in seconds.
>   */
>  struct firmware_fallback_config {
>         unsigned int force_sysfs_fallback;
> +       unsigned int ignore_sysfs_fallback;
>         int old_timeout;
>         int loading_timeout;
>  };
> diff --git a/drivers/base/firmware_fallback_table.c b/drivers/base/firmware_fallback_table.c
> index 77300d5e9c52..5e990b0330c7 100644
> --- a/drivers/base/firmware_fallback_table.c
> +++ b/drivers/base/firmware_fallback_table.c
> @@ -39,6 +39,15 @@ struct ctl_table firmware_config_table[] = {
>                 .extra1         = &zero,
>                 .extra2         = &one,
>         },
> +       {
> +               .procname       = "ignore_sysfs_fallback",
> +               .data           = &fw_fallback_config.ignore_sysfs_fallback,
> +               .maxlen         = sizeof(unsigned int),
> +               .mode           = 0644,
> +               .proc_handler   = proc_douintvec_minmax,
> +               .extra1         = &zero,
> +               .extra2         = &one,
> +       },
>         { }
>  };
>  EXPORT_SYMBOL_GPL(firmware_config_table);
> --
> 2.16.2
>



-- 
Kees Cook
Pixel Security

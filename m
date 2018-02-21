Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519205906; cv=none;
        d=google.com; s=arc-20160816;
        b=XNI/KKRbmcwfJTZBph+WAbFUPyhz/xHj7E2ZarpO6WDit6hhaMEJWSgJp2CGORPH4e
         DOAcvjYiJ9SiWRkZp0TWLvf65ZkP2oEcseTL3R9Fk3MTB0c+HLlwSinR1BKNWx0wV2dB
         jsbPuQ5iGvdh/20aLINlf9l9Um0NavtfEBGkCd+cjtiTqe+EbnRXiYA4C/IWASh+QMT5
         R9StwuuZPZLQjoll+V5yXaAcGhklAaElcVnH8pqldqCzj+5+CadYViUXX+DZRdea+okN
         0Sw4STAbHrrsbs3nZ4TFaCzuvYIPP1mGRZVvH5uBkpgEvFMW7Fj/t7nswOBLVNf8FITa
         VfWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=VX8nqh9zMdQ8vCIYQySFmL/PIBTHsD/yBPBK0keJDCY=;
        b=Z8rEhD51OBxSV5pZDuS4oX2JrVkv/4+bSebUvLxn38+SFJ4qLupPEjnfPyxvuNkn5Y
         DExVyw/6zO5puHq20I0bRX7s5uuNtDNCMK9sbf+Xe8aMR1uz8KXqTBIyyaFNbLLIOXEv
         /fedNIdos4Dd8TqNRJ4WkHXlUevdWkrrMFL5r/C6/im4A32kdMPKlizymC2lf9B2LOZV
         aVHUvCwlxId95xjxl6yc7LqRbGVjjizxfRFCFuKN7sNTJr6rGYwRlwEMHmLVmCfSl0pF
         BqXdE+AYm+62yFCP8Qi7pv4hiODnkiXeaak38AGOn3kg4IcReeM2Wolwso0tLqrlhaDY
         6fzw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CHk8CEpO;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CHk8CEpO;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AG47ELvBNbWb1gTl1qv0BZYFpTbvJlzpkOlAra6hrY4uAlpuuvrHyLfHIs8kt2Ov9xn8xnfse7ZhjonfkA6KzKdzMaA=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180220214400.66749-21-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com> <20180220214400.66749-21-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Feb 2018 10:38:25 +0100
X-Google-Sender-Auth: CIcYCq6kDEKxZCQubP37c6H25xQ
Message-ID: <CAMuHMdV9Ho3yh8e8z3N1awPj1ZjQu=7LtMetAY5TX=AVuXCVOQ@mail.gmail.com>
Subject: Re: [PATCH v2 20/21] mk68/mac: Switch to use %ptR
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-rtc@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>, Mark Salyzyn <salyzyn@android.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957919041334939?=
X-GMAIL-MSGID: =?utf-8?q?1593002852671734349?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Andy,

On Tue, Feb 20, 2018 at 10:43 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Use %ptR instead of open coded variant to print content of
> struct rtc_time in human readable format.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/m68k/Kconfig.machine | 1 +
>  arch/m68k/mac/misc.c      | 8 ++------
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
> index 64a641467736..620a55da648e 100644
> --- a/arch/m68k/Kconfig.machine
> +++ b/arch/m68k/Kconfig.machine
> @@ -26,6 +26,7 @@ config MAC
>         bool "Macintosh support"
>         depends on MMU
>         select MMU_MOTOROLA if MMU
> +       select PRINTK_PEXT_TIMEDATE

Yeah, now you have to track whatever code uses the new %p extension...

Note that the user below uses pr_debug(), so technically it depends on
DYNAMIC_DEBUG, or (more likely) someone manually inserting "#define DEBUG"
at the top of the file for a short debug session ;-)

> --- a/arch/m68k/mac/misc.c
> +++ b/arch/m68k/mac/misc.c
> @@ -673,13 +673,9 @@ int mac_hwclk(int op, struct rtc_time *t)
>                 unmktime(now, 0,
>                          &t->tm_year, &t->tm_mon, &t->tm_mday,
>                          &t->tm_hour, &t->tm_min, &t->tm_sec);
> -               pr_debug("%s: read %04d-%02d-%-2d %02d:%02d:%02d\n",
> -                        __func__, t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
> -                        t->tm_hour, t->tm_min, t->tm_sec);
> +               pr_debug("%s: read %ptR\n", __func__, t);
>         } else { /* write */
> -               pr_debug("%s: tried to write %04d-%02d-%-2d %02d:%02d:%02d\n",
> -                        __func__, t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
> -                        t->tm_hour, t->tm_min, t->tm_sec);
> +               pr_debug("%s: tried to write %ptR\n", __func__, t);
>
>                 now = mktime(t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
>                              t->tm_hour, t->tm_min, t->tm_sec);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

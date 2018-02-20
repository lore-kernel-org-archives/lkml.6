Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x225rv4IytnoU2J+0PfCI5A3YOCpvXL7e8VpHqurQi8mStMAYmAE2JqvxWd2AFLqiQvDGaJBE
ARC-Seal: i=1; a=rsa-sha256; t=1519118244; cv=none;
        d=google.com; s=arc-20160816;
        b=P+TiR8YzPfSz0Q82AQpgmcrGJFguqcQTCLYUxQzwLDNCaqEfvorMrkYQKrLZghrwYb
         lVux/7ZiH2hB6UicsGkJfT0enaZYZZfmL+LT04g1HeUVjjlbM5jXlK35ielJ9UvKDG9b
         9jYpt3UJQjqwjt66Owrm6/ZIyNewg2RKDC5rx4NoyhEYtgjJiE2wyDF0oocfLDSyMF8v
         z38NrBSUFPXfzCIncqfmC2FunoR8lpuLXjF3FPeoaZXXoDOk+hfzFjg4czNsSCLJEheQ
         5oQIeVhM00wpCN2+4jgQCtssdX/etebvhXa0XebAsoOnwlGFnsFAorWCUVRU0dLzYDn1
         KF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=qK5FLSTgceQ0HY1BW5y1so1sJgpYuL3EkXaXmm7f984=;
        b=aGRizOBNcIXGhFhYjUulbGTBGDtW0BZYeBQpcTxKR9ye0DeS6Vnw8gsniJObOVAS5o
         /h/9iLh6xSu2bOxJLzvmtOerafjeKjbKzSSdSKny6NgXMrzG0lzrKUp/9maG9E35qaxs
         JJJnGpF4f2nVfC4qo558x0dtq1M7Movy5gDhwF079oVUgazHGd24D4Q8KPOv3NZIZUC7
         D3tdPJgCZxJrXuLBn+FKzl/vcomICF6wMNWCpiQCto/Cif5sWRJQD//djf5aL+bGlEDl
         nm87VmTC19Vst1oNmiCTh7ChvJVkJnJFE4NqQSQdLQYkbAFiaEoZ+jF3/wWyNpKxwNyP
         wY3w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=wID6WTXI;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=wID6WTXI;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w1K9Gwgi022404
X-Nifty-SrcIP: [209.85.217.177]
MIME-Version: 1.0
In-Reply-To: <20180216214117.1947175-4-arnd@arndb.de>
References: <20180216214117.1947175-1-arnd@arndb.de> <20180216214117.1947175-4-arnd@arndb.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 20 Feb 2018 18:16:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQVSVtXzWXjLRAQXynSvHHbiF1xYLhjLBwPfFOpnX_NRA@mail.gmail.com>
Message-ID: <CAK7LNAQVSVtXzWXjLRAQXynSvHHbiF1xYLhjLBwPfFOpnX_NRA@mail.gmail.com>
Subject: Re: [PATCH 3/3] Kconfig: add a default allrandom.config
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Yann E . MORIN" <yann.morin.1998@free.fr>,
        Michal Marek <mmarek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592595421999203989?=
X-GMAIL-MSGID: =?utf-8?q?1592910932334072686?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-17 6:41 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> Building randconfig kernels frequently leads to build errors from
> drivers that have additional build dependencies, or that we don't
> want to build for compile-testing for some other reason.

Can you fix the former case?

The latter seems OK.


> We already have a couple of compile-time options that can deal with this
> problem, but the complete set is not documented well.  We also have a
> method to override some options during 'make randconfig' and a couple
> of other make targets. However, we don't yet combine those two.


>From this statement,

kernel/configs/compile_test.config

would make more sense?




> This adds a new allrandom.config file to turn on CONFIG_COMPILE_TEST,
> CONFIG_STANDALONE and CONFIG_PREVENT_FIRMWARE_BUILD for all randconfig
> builds. This in turn disables some other options that we already try
> to avoid in 'allmodconfig' builds and that make no sense in a general
> randconfig build.
>
> Building with 'make randconfig KCONFIG_ALLCONFIG=1' should now always


Can you type 'make randconfig compile_test.config', instead?

(Or 'make allmodconfig compile_test.config' for full-build test)


The merge_config has a little bit different logic
from KCONFIG_ALLCONFIG=1, but I guess it leads to the almost same result.



> succeed without warnings on x86 and arm64, aside from recent regressions.
> Other architectures probably need additional bugfixes.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/configs/allrandom.config | 6 ++++++
>  1 file changed, 6 insertions(+)
>  create mode 100644 kernel/configs/allrandom.config
>
> diff --git a/kernel/configs/allrandom.config b/kernel/configs/allrandom.config
> new file mode 100644
> index 000000000000..67294ef2e3a2
> --- /dev/null
> +++ b/kernel/configs/allrandom.config
> @@ -0,0 +1,6 @@
> +# maximize search space, disable options not worth testing
> +CONFIG_COMPILE_TEST=y
> +
> +# reduce compile-time dependencies
> +CONFIG_STANDALONE=y
> +CONFIG_PREVENT_FIRMWARE_BUILD=y
> --
> 2.9.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada

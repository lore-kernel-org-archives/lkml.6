Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeFENQz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:16:55 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:47446 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeFENQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:16:54 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w55DGeLZ027314
X-Nifty-SrcIP: [209.85.213.52]
X-Google-Smtp-Source: ADUXVKIqgWSOpsTGG9+ZYvQR/FXgDfcOqZvs7XxH/o87eaYITxwsZiR0b+ZlufmsXveO23W+ldqXdtKzzbQIcIariJ0=
MIME-Version: 1.0
In-Reply-To: <20180602160209.23605-1-natechancellor@gmail.com>
References: <20180602160209.23605-1-natechancellor@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 5 Jun 2018 22:15:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNATCTZTzcEpW8kBG8GktMeDZSuinAQX7_hnjysj0OaztcQ@mail.gmail.com>
Message-ID: <CAK7LNATCTZTzcEpW8kBG8GktMeDZSuinAQX7_hnjysj0OaztcQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Avoid format overflow warning from GCC 8.1
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w55DH2eq012362

2018-06-03 1:02 GMT+09:00 Nathan Chancellor <natechancellor@gmail.com>:
> In file included from scripts/kconfig/zconf.tab.c:2485:
> scripts/kconfig/confdata.c: In function ‘conf_write’:
> scripts/kconfig/confdata.c:773:22: warning: ‘%s’ directive writing likely 7 or more bytes into a region of size between 1 and 4097 [-Wformat-overflow=]
>   sprintf(newname, "%s%s", dirname, basename);
>                       ^~
> scripts/kconfig/confdata.c:773:19: note: assuming directive output of 7 bytes
>   sprintf(newname, "%s%s", dirname, basename);
>                    ^~~~~~
> scripts/kconfig/confdata.c:773:2: note: ‘sprintf’ output 1 or more bytes (assuming 4104) into a destination of size 4097
>   sprintf(newname, "%s%s", dirname, basename);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> scripts/kconfig/confdata.c:776:23: warning: ‘.tmpconfig.’ directive writing 11 bytes into a region of size between 1 and 4097 [-Wformat-overflow=]
>    sprintf(tmpname, "%s.tmpconfig.%d", dirname, (int)getpid());
>                        ^~~~~~~~~~~
> scripts/kconfig/confdata.c:776:3: note: ‘sprintf’ output between 13 and 4119 bytes into a destination of size 4097
>    sprintf(tmpname, "%s.tmpconfig.%d", dirname, (int)getpid());
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Increase the size of tmpname and newname to make GCC happy.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---

Applied to linux-kbuild.  Thanks!


>  scripts/kconfig/confdata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index 5f87ad561b08..39e20974f4a3 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -720,7 +720,7 @@ int conf_write(const char *name)
>         struct menu *menu;
>         const char *basename;
>         const char *str;
> -       char dirname[PATH_MAX+1], tmpname[PATH_MAX+1], newname[PATH_MAX+1];
> +       char dirname[PATH_MAX+1], tmpname[PATH_MAX+22], newname[PATH_MAX+8];
>         char *env;
>
>         dirname[0] = 0;
> --
> 2.17.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada

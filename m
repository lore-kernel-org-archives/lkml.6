Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbeDEPvz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:51:55 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:17109 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbeDEPvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:51:53 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w35FpllY030140
X-Nifty-SrcIP: [209.85.213.54]
X-Google-Smtp-Source: AIpwx48aTFoWwhC36XpVkNM7r12XglWBMD8bN4kbQIBFFl7dNr36azY+r3uqbOLyXmbpCuOOJqNbe7zUd/SEHmr9DBE=
MIME-Version: 1.0
In-Reply-To: <20180405151645.19130-4-jolsa@kernel.org>
References: <20180405151645.19130-1-jolsa@kernel.org> <20180405151645.19130-4-jolsa@kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 6 Apr 2018 00:50:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQHEWAk_J8uZ4_ETR=JzBU9szDCVNxmUvY447uMj1XLVA@mail.gmail.com>
Message-ID: <CAK7LNAQHEWAk_J8uZ4_ETR=JzBU9szDCVNxmUvY447uMj1XLVA@mail.gmail.com>
Subject: Re: [PATCH 3/9] kbuild: Do not pass arguments to link-vmlinux.sh
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Eugene Syromiatnikov <esyr@redhat.com>, Jiri Benc <jbenc@redhat.com>,
        Stanislav Kozina <skozina@redhat.com>,
        Jerome Marchand <jmarchan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>, Jiri Kosina <jkosina@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-06 0:16 GMT+09:00 Jiri Olsa <jolsa@kernel.org>:
> There's no need to pass LD* arguments to link-vmlinux.sh,
> because they are passed as variables. The only argument
> the link-vmlinux.sh supports is the 'clean' argument.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Wrong.

$(LD) $(LDFLAGS) $(LDFLAGS_vmlinux)
exist here so that any change in them
invokes scripts/linkk-vmlinux.sh




>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index d3300e46f925..a65a3919c6ad 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1027,7 +1027,7 @@ ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
>
>  # Final link of vmlinux with optional arch pass after final link
>  cmd_link-vmlinux =                                                 \
> -       $(CONFIG_SHELL) $< $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) ;    \
> +       $(CONFIG_SHELL) $< ;                                       \
>         $(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
>
>  vmlinux: scripts/link-vmlinux.sh vmlinux_prereq $(vmlinux-deps) FORCE






-- 
Best Regards
Masahiro Yamada

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeDEOYL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:24:11 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:44028 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeDEOYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:24:09 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w35EO3Pn027828
X-Nifty-SrcIP: [209.85.213.52]
X-Google-Smtp-Source: AIpwx48Ashp0LMRtQcmZhAdahYTNoQSKO4PkOlZs3rGrLXpJor5DVBr+mQfe/8KVJo60PduqOb6mFUdjBt7+nkOR6yI=
MIME-Version: 1.0
In-Reply-To: <c59adbdd18dc083fc1e08a9a889e67282fcbbaa2.1519668832.git.robin.jarry@6wind.com>
References: <cover.1519393674.git.robin.jarry@6wind.com> <cover.1519668832.git.robin.jarry@6wind.com>
 <c59adbdd18dc083fc1e08a9a889e67282fcbbaa2.1519668832.git.robin.jarry@6wind.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 5 Apr 2018 23:23:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNASj6O790hbr0de4dU4GPk99LCGBsGj6t65G1iyxA7WhSA@mail.gmail.com>
Message-ID: <CAK7LNASj6O790hbr0de4dU4GPk99LCGBsGj6t65G1iyxA7WhSA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kbuild: use HOSTLDFLAGS for single .c executables
To: Robin Jarry <robin.jarry@6wind.com>
Cc: Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-27 3:41 GMT+09:00 Robin Jarry <robin.jarry@6wind.com>:
> When compiling executables from a single .c file, the linker is also
> invoked. Pass the HOSTLDFLAGS like for other linker commands.
>
> Signed-off-by: Robin Jarry <robin.jarry@6wind.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  scripts/Makefile.host | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.host b/scripts/Makefile.host
> index e6dc6ae2d7c4..aa971cc3f339 100644
> --- a/scripts/Makefile.host
> +++ b/scripts/Makefile.host
> @@ -84,7 +84,7 @@ hostcxx_flags  = -Wp,-MD,$(depfile) $(__hostcxx_flags)
>  # Create executable from a single .c file
>  # host-csingle -> Executable
>  quiet_cmd_host-csingle         = HOSTCC  $@
> -      cmd_host-csingle = $(HOSTCC) $(hostc_flags) -o $@ $< \
> +      cmd_host-csingle = $(HOSTCC) $(hostc_flags) $(HOSTLDFLAGS) -o $@ $< \
>                 $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
>  $(host-csingle): $(obj)/%: $(src)/%.c FORCE
>         $(call if_changed_dep,host-csingle)


This one is correct anyway.

I applied to linux-kbuild.



-- 
Best Regards
Masahiro Yamada

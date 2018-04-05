Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeDES77 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 14:59:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751655AbeDES75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 14:59:57 -0400
Date: Thu, 5 Apr 2018 20:59:50 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Eugene Syromiatnikov <esyr@redhat.com>, Jiri Benc <jbenc@redhat.com>,
        Stanislav Kozina <skozina@redhat.com>,
        Jerome Marchand <jmarchan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>, Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 3/9] kbuild: Do not pass arguments to link-vmlinux.sh
Message-ID: <20180405185950.GA3668@krava>
References: <20180405151645.19130-1-jolsa@kernel.org>
 <20180405151645.19130-4-jolsa@kernel.org>
 <CAK7LNAQHEWAk_J8uZ4_ETR=JzBU9szDCVNxmUvY447uMj1XLVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQHEWAk_J8uZ4_ETR=JzBU9szDCVNxmUvY447uMj1XLVA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 12:50:00AM +0900, Masahiro Yamada wrote:
> 2018-04-06 0:16 GMT+09:00 Jiri Olsa <jolsa@kernel.org>:
> > There's no need to pass LD* arguments to link-vmlinux.sh,
> > because they are passed as variables. The only argument
> > the link-vmlinux.sh supports is the 'clean' argument.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> 
> Wrong.
> 
> $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux)
> exist here so that any change in them
> invokes scripts/linkk-vmlinux.sh

sry, I can't see that.. but it's just a side fix,
which is actually not needed for the rest

I'll check on more and address this separately

thanks,
jirka

> 
> 
> 
> 
> >  Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index d3300e46f925..a65a3919c6ad 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1027,7 +1027,7 @@ ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
> >
> >  # Final link of vmlinux with optional arch pass after final link
> >  cmd_link-vmlinux =                                                 \
> > -       $(CONFIG_SHELL) $< $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) ;    \
> > +       $(CONFIG_SHELL) $< ;                                       \
> >         $(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
> >
> >  vmlinux: scripts/link-vmlinux.sh vmlinux_prereq $(vmlinux-deps) FORCE
> 
> 
> 
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

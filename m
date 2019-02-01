Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522E7C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B1820823
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HpZBn6RG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbfBAETY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 23:19:24 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:42305 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfBAETW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 23:19:22 -0500
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x114IqNa020665;
        Fri, 1 Feb 2019 13:18:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x114IqNa020665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548994733;
        bh=ytG2UnX2OWy6Sd6XVKbUkNzEA7dS+LYBYHA8/JjzbhI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HpZBn6RGSMi1qpHXQo+IuoVth+qELHwyb1c+0bZFSRij+Oe5Qij9fgmzl90S78ssi
         ntE/XV2PkxzCezD5/j/T7IpK6yky/GST4uL05hG9cb9avelQ4EAtyqbqWXr1WVT3cd
         eAyucaz3MBwA5hsk4Eec5qvyO8SDBcscLhVmG3so2exz43h2uCd4Re9hXXLbvfaqe4
         b7AEGNGacGlcP51TOHPxnxGHR3uRsm9HMoFWVXhb6ldtgagi2kwenkWaLekF46Xs8w
         WsxxJgrvmjVmMtQ46xXP7UPiPUUovd57DHavQy84/t67in9Kc4TtJUixOyrgz2RDnU
         LAEvXAiZZG2VQ==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id n7so1820051uao.7;
        Thu, 31 Jan 2019 20:18:53 -0800 (PST)
X-Gm-Message-State: AJcUukcqh0A7Uifqr7uQNhgv0vMFz2TZPIMXFFaoy4mZ1lupJEx0olQY
        z8EWcyVVTEOtHBJviNdFA+IcBpfwPs9MulUmK2M=
X-Google-Smtp-Source: ALg8bN5Wh2/1BCIfwmdnkpI0Ck/O4/ANyfM6IGW0+oNsmeYRvFKv5T8RwgIqNTtyQdPYzrK1h9JblUpl6SfJAslEETE=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr15514843uap.6.1548994732100;
 Thu, 31 Jan 2019 20:18:52 -0800 (PST)
MIME-Version: 1.0
References: <20190130111447.26032-1-vladimir.kondratiev@linux.intel.com>
In-Reply-To: <20190130111447.26032-1-vladimir.kondratiev@linux.intel.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 1 Feb 2019 13:18:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8g3g3OTtqTN8begMxzbSS82Wn0CqY8u6vuELEZaLo3g@mail.gmail.com>
Message-ID: <CAK7LNAS8g3g3OTtqTN8begMxzbSS82Wn0CqY8u6vuELEZaLo3g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: gitignore output directory
To:     Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 8:15 PM Vladimir Kondratiev
<vladimir.kondratiev@linux.intel.com> wrote:
>
> When compiling into output directory using O=, many files
> created under KBUILD_OUTPUT that git considers
> as new ones; git clients, ex. "git gui" lists it, and it clutters
> file list making it difficult to see what was really changed
>
> Generate .gitignore in output directory that ignores all
> its content
>
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
> ---
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 141653226f3c..ee66ea28869b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -483,10 +483,13 @@ PHONY += outputmakefile
>  # outputmakefile generates a Makefile in the output directory, if using a
>  # separate output directory. This allows convenient use of make in the
>  # output directory.
> +# At the same time when output Makefile generated, generate .gitignore to
> +# ignore whole output directory
>  outputmakefile:
>  ifneq ($(KBUILD_SRC),)
>         $(Q)ln -fsn $(srctree) source
>         $(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
> +       echo "# this is build directory, ignore it\n*" > .gitignore
>  endif
>
>  ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
> --
> 2.19.1
>


The idea looks OK to me.
The implementation must be improved.


You need to add $(Q) to suppress the annoying command echo.

Also, this patch does not work for all distributions because
echo "\n"
is not portable.



GNU Make runs recipes in /bin/sh (unless SHELL variable is changed),
but the implementation of /bin/sh depends on distributions.


This patch works on Ubuntu etc.
because /bin/sh is a symbolic link to dash.


But, in some distributions,
/bin/sh is a symbolic link to bash.



Docker is useful for quick tests of
various distributions. :)

See the result of  echo "hello\nworld"


[Ubuntu]

foo@8ad1275125c5:~$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=18.10
DISTRIB_CODENAME=cosmic
DISTRIB_DESCRIPTION="Ubuntu 18.10"
foo@8ad1275125c5:~$ ls -l /bin/sh
lrwxrwxrwx 1 root root 4 Nov 14 23:00 /bin/sh -> dash
foo@8ad1275125c5:~$ /bin/sh
$ type echo
echo is a shell builtin
$ echo "hello\nworld"
hello
world




[CentOS]


[foo@c3fbaa4b6f72 ~]$ cat /etc/redhat-release
CentOS Linux release 7.6.1810 (Core)
[foo@c3fbaa4b6f72 ~]$ ls -l /bin/sh
lrwxrwxrwx 1 root root 4 Dec  5 01:36 /bin/sh -> bash
[foo@c3fbaa4b6f72 ~]$ /bin/sh
sh-4.2$ type echo
echo is a shell builtin
sh-4.2$ echo "hello\nworld"
hello\nworld





On example for workaround might be:

diff --git a/Makefile b/Makefile
index ee66ea2..010c1c6 100644
--- a/Makefile
+++ b/Makefile
@@ -489,7 +489,7 @@ outputmakefile:
 ifneq ($(KBUILD_SRC),)
        $(Q)ln -fsn $(srctree) source
        $(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
-       echo "# this is build directory, ignore it\n*" > .gitignore
+       $(Q){ echo "# this is build directory, ignore it"; echo "*"; }
> .gitignore
 endif

 ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)






-- 
Best Regards
Masahiro Yamada

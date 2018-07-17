Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCA2ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594F120852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="pKxTcUuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594F120852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbeGQNiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:38:14 -0400
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:52697 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729664AbeGQNiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:38:14 -0400
X-Greylist: delayed 494 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Jul 2018 09:38:11 EDT
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::30])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id 2A85421787;
        Tue, 17 Jul 2018 15:57:22 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtpcorp1o.mail.yandex.net (Yandex) with ESMTP id 2208F2440DFC;
        Tue, 17 Jul 2018 15:57:22 +0300 (MSK)
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:854c:7dcd:9203:76a5])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id yHIX3QnRFv-vL5eP9o4;
        Tue, 17 Jul 2018 15:57:22 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1531832242; bh=hCzr5Fc1NkK14H05sX/7KhvSsgVtWNllE17bLsN/ZHU=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=pKxTcUuMEV0jeN+YPI1nrRgBPJLXP58KzIt/zbXGlDn2RohK0l9wXeeTkf0U3a3E+
         3pTI6Rc5ZtEfpdvJ136Uk3P/LxfBlERlh5h1TsiNcV0X8kP5MfuNK7kq5eSpFYtJo/
         pyupJLjtaha/TUSpjABZQzzewu2bODKR0QSDlZJA=
Authentication-Results: smtpcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: Re: [PATCH 4.4 14/43] tools build: fix # escaping in .cmd files for
 future Make
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <20180716073511.796555857@linuxfoundation.org>
 <20180716073513.350026232@linuxfoundation.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <d1a883c6-1b7c-8bf5-49e6-3e29a60ca117@yandex-team.ru>
Date:   Tue, 17 Jul 2018 15:57:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180716073513.350026232@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit depends on commit 9564a8cf422d7b58f6e857e3546d346fa970191e
"Kbuild: fix # escaping in .cmd files for future Make"
which is missing in 4.4.141


this breaks compilation of tools/perf for me

make -C tools/perf V=1 JOBS=24 WERROR=0 NO_GTK2=1 LDFLAGS=-static all
make[1]: Entering directory `/tmp/buildd/linux-yandex-4.4.141/tools/perf'
   BUILD:   Doing 'make -j24' parallel build

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ OFF ]
...                         glibc: [ on  ]
...                          gtk2: [ OFF ]
...                      libaudit: [ on  ]
...                        libbfd: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ on  ]
...        numa_num_possible_cpus: [ on  ]
...                       libperl: [ OFF ]
...                     libpython: [ OFF ]
...                      libslang: [ on  ]
...                     libunwind: [ on  ]
...            libdw-dwarf-unwind: [ OFF ]
...                          zlib: [ on  ]
...                          lzma: [ on  ]
...                     get_cpuid: [ on  ]
...                           bpf: [ on  ]

config/Makefile:274: No libdw DWARF unwind found, Please install elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR
config/Makefile:282: Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.157
config/Makefile:458: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev
config/Makefile:501: No 'Python.h' (for Python 2.x support) was found: disables Python support - please install python-devel/python-dev
$(:)
make -C /tmp/buildd/linux-yandex-4.4.141/tools/build fixdep
/bin/sh util/PERF-VERSION-GEN
make -f /tmp/buildd/linux-yandex-4.4.141/tools/build/Makefile.build dir=. obj=fixdep
. util/generate-cmdlist.sh > common-cmds.h+ && mv common-cmds.h+ common-cmds.h
.fixdep.o.cmd:1: *** missing separator.  Stop.
make[3]: *** [fixdep-in.o] Error 2
make[2]: *** [fixdep] Error 2


On 16.07.2018 10:36, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> commit 9feeb638cde083c737e295c0547f1b4f28e99583 upstream.
> 
> In 2016 GNU Make made a backwards incompatible change to the way '#'
> characters were handled in Makefiles when used inside functions or
> macros:
> 
> http://git.savannah.gnu.org/cgit/make.git/commit/?id=c6966b323811c37acedff05b57
> 
> Due to this change, when attempting to run `make prepare' I get a
> spurious make syntax error:
> 
>      /home/earnest/linux/tools/objtool/.fixdep.o.cmd:1: *** missing separator.  Stop.
> 
> When inspecting `.fixdep.o.cmd' it includes two lines which use
> unescaped comment characters at the top:
> 
>      \# cannot find fixdep (/home/earnest/linux/tools/objtool//fixdep)
>      \# using basic dep data
> 
> This is because `tools/build/Build.include' prints these '\#'
> characters:
> 
>      printf '\# cannot find fixdep (%s)\n' $(fixdep) > $(dot-target).cmd; \
>      printf '\# using basic dep data\n\n' >> $(dot-target).cmd;           \
> 
> This completes commit 9564a8cf422d ("Kbuild: fix # escaping in .cmd files
> for future Make").
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=197847
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>   tools/build/Build.include |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/tools/build/Build.include
> +++ b/tools/build/Build.include
> @@ -62,8 +62,8 @@ dep-cmd = $(if $(wildcard $(fixdep)),
>              $(fixdep) $(depfile) $@ '$(make-cmd)' > $(dot-target).tmp;           \
>              rm -f $(depfile);                                                    \
>              mv -f $(dot-target).tmp $(dot-target).cmd,                           \
> -           printf '\# cannot find fixdep (%s)\n' $(fixdep) > $(dot-target).cmd; \
> -           printf '\# using basic dep data\n\n' >> $(dot-target).cmd;           \
> +           printf '$(pound) cannot find fixdep (%s)\n' $(fixdep) > $(dot-target).cmd; \
> +           printf '$(pound) using basic dep data\n\n' >> $(dot-target).cmd;           \
>              cat $(depfile) >> $(dot-target).cmd;                                 \
>              printf '%s\n' 'cmd_$@ := $(make-cmd)' >> $(dot-target).cmd)
>   
> 
> 
> 


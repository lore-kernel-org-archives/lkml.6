Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030904AbeEXOLZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:11:25 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:60429 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030707AbeEXOLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:11:18 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w4OEBDdd003983
X-Nifty-SrcIP: [209.85.213.50]
X-Google-Smtp-Source: AB8JxZrJJg4N+ZJK88ddxVlI1GVAhZcYxWR+NTOHxObLmRNpNWeeKaUl0xgZ+87KJ1xORJeqUuOt6jbYUrVfuVIqnKk=
MIME-Version: 1.0
In-Reply-To: <1526973741-664-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526973741-664-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 24 May 2018 23:10:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT88uzCRpH18GT3Hy2M_MPFx0Y4DLijk2gjHRHDr9-DWA@mail.gmail.com>
Message-ID: <CAK7LNAT88uzCRpH18GT3Hy2M_MPFx0Y4DLijk2gjHRHDr9-DWA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] kconfig: refactor package checks for GUI frontends
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arvind Prasanna <arvindprasanna@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-22 16:22 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>
> Kconfig supports 4 GUI frontends.
> Each of them needs some support packages, but checks them differently:
>
>   qconf, gconf: check packages in Makefile (pkg-config is required)
>   mconf: lxdialog/check-lxdialog.sh
>   nconf: needs ncurses, but its presence is not checked
>
> This series refactor the package checks so that all of them work
> in the same way.
>
> The package check scripts have been moved to scripts/kconfig/*conf-cfg.sh
>
> The motivation of this clean-up is Randy's following patch:
> https://patchwork.kernel.org/patch/10277723/
>
> I want to clean up existing code before adding more checks.
>
>
> Masahiro Yamada (4):
>   kbuild: do not display CHK for filechk
>   kconfig: refactor Qt package checks for building qconf
>   kconfig: refactor GTK+ package checks for building gconf
>   kconfig: refactor ncurses package checks for building mconf and nconf


Applied to linux-kbuild/kconfig.




>  scripts/Kbuild.include                     |   1 -
>  scripts/kconfig/Makefile                   | 168 ++++++++++-------------------
>  scripts/kconfig/gconf-cfg.sh               |  23 ++++
>  scripts/kconfig/lxdialog/check-lxdialog.sh |  93 ----------------
>  scripts/kconfig/lxdialog/dialog.h          |   2 +-
>  scripts/kconfig/mconf-cfg.sh               |  44 ++++++++
>  scripts/kconfig/nconf-cfg.sh               |  43 ++++++++
>  scripts/kconfig/qconf-cfg.sh               |  25 +++++
>  8 files changed, 195 insertions(+), 204 deletions(-)
>  create mode 100755 scripts/kconfig/gconf-cfg.sh
>  delete mode 100755 scripts/kconfig/lxdialog/check-lxdialog.sh
>  create mode 100755 scripts/kconfig/mconf-cfg.sh
>  create mode 100644 scripts/kconfig/nconf-cfg.sh
>  create mode 100755 scripts/kconfig/qconf-cfg.sh
>
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada

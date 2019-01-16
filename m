Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D2EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0211A20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YTZLoqYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393564AbfAPOeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:34:18 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:55518 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbfAPOeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:34:18 -0500
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x0GEXnu0020594;
        Wed, 16 Jan 2019 23:33:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x0GEXnu0020594
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547649230;
        bh=i9n+Tvoysx7stDI34FUWayfXq+ikii7FW3AXihr/w1c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YTZLoqYYYPcxmhJ13NdNWYY1iR/3VayGGNuPzcTeAwH7ZtZ4NGl18B0t3D45vVDoh
         CHW1zLJO0aR+EY6XFuj6EttDVH1wrAjfX5RoJUMH2TVsyshM2LvFL0nFcCVzMKPp7G
         xzjEOkKK76+u58SXDumZ/B2cpjREuYojdA0OejIEx1RdfuUJNYob+P4HTcg8Jb001W
         VZvvZCJSaUwQsO5TQRX3eAOrqy4qh/b94fBRd/mt1plM7EQXL/35aY/g7DSK0nUlsZ
         xLeC6vr2f5F7vObCGSLnUhfjxEIkbE2aR2uM9RevPMrua0g0lA0PT4eMbo4wcXpTxb
         isQ6VxBm9o1NA==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id d19so2202550uaq.11;
        Wed, 16 Jan 2019 06:33:49 -0800 (PST)
X-Gm-Message-State: AJcUukd0b66miUCWFTv7HbRPWd4svyR+JNfnUOuNcqBU1huMJvd/Lqps
        Z5m3qy6GqmDwtnQKsmKz8xpdrsS6yqW+gGYKOQs=
X-Google-Smtp-Source: ALg8bN7yIQbpDZn2pw/UohLfON8FFbJkfF52MDLuTmYWkf3yaSVOFCgm6Gx0R2pZ322s1cBvdRUTkynH76aIhzoAk7I=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr3502757uaj.42.1547649228316;
 Wed, 16 Jan 2019 06:33:48 -0800 (PST)
MIME-Version: 1.0
References: <1546657311-24661-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1546657311-24661-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 16 Jan 2019 23:33:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNAReq2wmuOOV3f2VxOsZpmatJXqPoDz4htoiVYq-oM8QsQ@mail.gmail.com>
Message-ID: <CAK7LNAReq2wmuOOV3f2VxOsZpmatJXqPoDz4htoiVYq-oM8QsQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: rename generated .*conf-cfg to *conf-cfg
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 12:02 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Remove the dot-prefixing since it is just a matter of the
> .gitignore file.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild/fixes.

>
>  scripts/kconfig/.gitignore |  1 +
>  scripts/kconfig/Makefile   | 36 ++++++++++++++++++------------------
>  2 files changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
> index 0aabc1d..b5bf92f 100644
> --- a/scripts/kconfig/.gitignore
> +++ b/scripts/kconfig/.gitignore
> @@ -2,6 +2,7 @@
>  # Generated files
>  #
>  *.moc
> +*conf-cfg
>
>  #
>  # configuration programs
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 679e62e..c05ab00 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -157,53 +157,53 @@ conf-objs := conf.o $(common-objs)
>  hostprogs-y    += nconf
>  nconf-objs     := nconf.o nconf.gui.o $(common-objs)
>
> -HOSTLDLIBS_nconf       = $(shell . $(obj)/.nconf-cfg && echo $$libs)
> -HOSTCFLAGS_nconf.o     = $(shell . $(obj)/.nconf-cfg && echo $$cflags)
> -HOSTCFLAGS_nconf.gui.o = $(shell . $(obj)/.nconf-cfg && echo $$cflags)
> +HOSTLDLIBS_nconf       = $(shell . $(obj)/nconf-cfg && echo $$libs)
> +HOSTCFLAGS_nconf.o     = $(shell . $(obj)/nconf-cfg && echo $$cflags)
> +HOSTCFLAGS_nconf.gui.o = $(shell . $(obj)/nconf-cfg && echo $$cflags)
>
> -$(obj)/nconf.o $(obj)/nconf.gui.o: $(obj)/.nconf-cfg
> +$(obj)/nconf.o $(obj)/nconf.gui.o: $(obj)/nconf-cfg
>
>  # mconf: Used for the menuconfig target based on lxdialog
>  hostprogs-y    += mconf
>  lxdialog       := checklist.o inputbox.o menubox.o textbox.o util.o yesno.o
>  mconf-objs     := mconf.o $(addprefix lxdialog/, $(lxdialog)) $(common-objs)
>
> -HOSTLDLIBS_mconf = $(shell . $(obj)/.mconf-cfg && echo $$libs)
> +HOSTLDLIBS_mconf = $(shell . $(obj)/mconf-cfg && echo $$libs)
>  $(foreach f, mconf.o $(lxdialog), \
> -  $(eval HOSTCFLAGS_$f = $$(shell . $(obj)/.mconf-cfg && echo $$$$cflags)))
> +  $(eval HOSTCFLAGS_$f = $$(shell . $(obj)/mconf-cfg && echo $$$$cflags)))
>
> -$(obj)/mconf.o: $(obj)/.mconf-cfg
> -$(addprefix $(obj)/lxdialog/, $(lxdialog)): $(obj)/.mconf-cfg
> +$(obj)/mconf.o: $(obj)/mconf-cfg
> +$(addprefix $(obj)/lxdialog/, $(lxdialog)): $(obj)/mconf-cfg
>
>  # qconf: Used for the xconfig target based on Qt
>  hostprogs-y    += qconf
>  qconf-cxxobjs  := qconf.o
>  qconf-objs     := images.o $(common-objs)
>
> -HOSTLDLIBS_qconf       = $(shell . $(obj)/.qconf-cfg && echo $$libs)
> -HOSTCXXFLAGS_qconf.o   = $(shell . $(obj)/.qconf-cfg && echo $$cflags)
> +HOSTLDLIBS_qconf       = $(shell . $(obj)/qconf-cfg && echo $$libs)
> +HOSTCXXFLAGS_qconf.o   = $(shell . $(obj)/qconf-cfg && echo $$cflags)
>
> -$(obj)/qconf.o: $(obj)/.qconf-cfg $(obj)/qconf.moc
> +$(obj)/qconf.o: $(obj)/qconf-cfg $(obj)/qconf.moc
>
>  quiet_cmd_moc = MOC     $@
> -      cmd_moc = $(shell . $(obj)/.qconf-cfg && echo $$moc) -i $< -o $@
> +      cmd_moc = $(shell . $(obj)/qconf-cfg && echo $$moc) -i $< -o $@
>
> -$(obj)/%.moc: $(src)/%.h $(obj)/.qconf-cfg
> +$(obj)/%.moc: $(src)/%.h $(obj)/qconf-cfg
>         $(call cmd,moc)
>
>  # gconf: Used for the gconfig target based on GTK+
>  hostprogs-y    += gconf
>  gconf-objs     := gconf.o images.o $(common-objs)
>
> -HOSTLDLIBS_gconf    = $(shell . $(obj)/.gconf-cfg && echo $$libs)
> -HOSTCFLAGS_gconf.o  = $(shell . $(obj)/.gconf-cfg && echo $$cflags)
> +HOSTLDLIBS_gconf    = $(shell . $(obj)/gconf-cfg && echo $$libs)
> +HOSTCFLAGS_gconf.o  = $(shell . $(obj)/gconf-cfg && echo $$cflags)
>
> -$(obj)/gconf.o: $(obj)/.gconf-cfg
> +$(obj)/gconf.o: $(obj)/gconf-cfg
>
>  # check if necessary packages are available, and configure build flags
>  filechk_conf_cfg = $(CONFIG_SHELL) $<
>
> -$(obj)/.%conf-cfg: $(src)/%conf-cfg.sh FORCE
> +$(obj)/%conf-cfg: $(src)/%conf-cfg.sh FORCE
>         $(call filechk,conf_cfg)
>
> -clean-files += .*conf-cfg
> +clean-files += conf-cfg
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada

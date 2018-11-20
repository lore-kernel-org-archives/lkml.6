Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD09C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C82420851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C82420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeKUBio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:38:44 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58270 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbeKUBio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:38:44 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5E7BB2074F; Tue, 20 Nov 2018 16:09:06 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id F1DAA206D8;
        Tue, 20 Nov 2018 16:09:05 +0100 (CET)
Date:   Tue, 20 Nov 2018 16:09:05 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-doc@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] kbuild: announce removal of SUBDIRS if used
Message-ID: <20181120160905.5fc4ba4a@bbrezillon>
In-Reply-To: <1542726258-8418-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542726258-8418-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 00:04:18 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> SUBDIRS has been kept as a backward compatibility since
> commit ("[PATCH] kbuild: external module support") in 2002.
> 
> We do not need multiple ways to do the same thing, so I will remove
> SUBDIRS after the Linux 5.3 release. I cleaned up in-tree code, and
> updated the document so that nobody would try to use it.
> 
> Meanwhile, display the following warning if SUBDIRS is used.
> 
> Makefile:189: ================= WARNING ================
> Makefile:190: 'SUBDIRS' will be removed after Linux 5.3
> Makefile:191: Please use 'M=' or 'KBUILD_EXTMOD' instead
> Makefile:192: ==========================================
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  Documentation/kbuild/kbuild.txt    | 7 +------
>  Makefile                           | 4 ++++
>  drivers/mtd/maps/scx200_docflash.c | 7 -------

For the docflash driver

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>

>  drivers/watchdog/scx200_wdt.c      | 7 -------
>  samples/connector/Makefile         | 2 +-
>  5 files changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/kbuild/kbuild.txt b/Documentation/kbuild/kbuild.txt
> index 8390c36..c9e3d93 100644
> --- a/Documentation/kbuild/kbuild.txt
> +++ b/Documentation/kbuild/kbuild.txt
> @@ -81,12 +81,7 @@ KBUILD_EXTMOD
>  --------------------------------------------------
>  Set the directory to look for the kernel source when building external
>  modules.
> -The directory can be specified in several ways:
> -1) Use "M=..." on the command line
> -2) Environment variable KBUILD_EXTMOD
> -3) Environment variable SUBDIRS
> -The possibilities are listed in the order they take precedence.
> -Using "M=..." will always override the others.
> +Setting "M=..." takes precedence over KBUILD_EXTMOD.
>  
>  KBUILD_OUTPUT
>  --------------------------------------------------
> diff --git a/Makefile b/Makefile
> index 370d13b..57be5fb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -186,6 +186,10 @@ endif
>  # Old syntax make ... SUBDIRS=$PWD is still supported
>  # Setting the environment variable KBUILD_EXTMOD take precedence
>  ifdef SUBDIRS
> +  $(warning ================= WARNING ================)
> +  $(warning 'SUBDIRS' will be removed after Linux 5.3)
> +  $(warning Please use 'M=' or 'KBUILD_EXTMOD' instead)
> +  $(warning ==========================================)
>    KBUILD_EXTMOD ?= $(SUBDIRS)
>  endif
>  
> diff --git a/drivers/mtd/maps/scx200_docflash.c b/drivers/mtd/maps/scx200_docflash.c
> index f1c1f73..7f1a0e6 100644
> --- a/drivers/mtd/maps/scx200_docflash.c
> +++ b/drivers/mtd/maps/scx200_docflash.c
> @@ -216,10 +216,3 @@ static void __exit cleanup_scx200_docflash(void)
>  
>  module_init(init_scx200_docflash);
>  module_exit(cleanup_scx200_docflash);
> -
> -/*
> -    Local variables:
> -        compile-command: "make -k -C ../../.. SUBDIRS=drivers/mtd/maps modules"
> -        c-basic-offset: 8
> -    End:
> -*/
> diff --git a/drivers/watchdog/scx200_wdt.c b/drivers/watchdog/scx200_wdt.c
> index 836377c..ec4063e 100644
> --- a/drivers/watchdog/scx200_wdt.c
> +++ b/drivers/watchdog/scx200_wdt.c
> @@ -262,10 +262,3 @@ static void __exit scx200_wdt_cleanup(void)
>  
>  module_init(scx200_wdt_init);
>  module_exit(scx200_wdt_cleanup);
> -
> -/*
> -    Local variables:
> -	compile-command: "make -k -C ../.. SUBDIRS=drivers/char modules"
> -	c-basic-offset: 8
> -    End:
> -*/
> diff --git a/samples/connector/Makefile b/samples/connector/Makefile
> index fe3c854..6ad7162 100644
> --- a/samples/connector/Makefile
> +++ b/samples/connector/Makefile
> @@ -14,4 +14,4 @@ HOSTCFLAGS_ucon.o += -I$(objtree)/usr/include
>  all: modules
>  
>  modules clean:
> -	$(MAKE) -C ../.. SUBDIRS=$(CURDIR) $@
> +	$(MAKE) -C ../.. M=$(CURDIR) $@


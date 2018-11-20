Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F8EC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE5A2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJlt9nvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE5A2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbeKUCzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:55:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44472 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeKUCzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:55:43 -0500
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so1223181plq.11;
        Tue, 20 Nov 2018 08:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ci1XMUtf//2JuBIxRgj+8FuHiqnqlP3LX5Y4rT2kOQg=;
        b=qJlt9nvlC7CzfhlacCI61002Cyh/+6X5UXHv96pFRd0n30ExopymB/GK0qHSh7mapJ
         99zZ11W8klu4CadOHFq91twSmtjuMbilKR6e1LsetHZ3hb3WAsVIVW1cxjaBH8t+DS3f
         2lftRzpVYg2jyQIMYp6l+VJ2WRA0gs1m1MQaNf3w+LItxM2bCSnmq36yW/p6vIwtpzxc
         N/cHkayU5yjrIenlz7HTmhjQSVJVlsi/HxM/4wYWPkm6Gtr8AEU26T7/VIVuUlt5mVhK
         rs8esjcMouPwHOSdlnrQj8Euh4mJNodp4q15/HP0uTVxXzwE3lyTm5jKUIkKpj2+ym8s
         CsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ci1XMUtf//2JuBIxRgj+8FuHiqnqlP3LX5Y4rT2kOQg=;
        b=fP2mjoNQR+2FX/L5+27gfO+ZUodvvFbDZpe8YRXI5C2w1CZm6iZQPMxoONC/Z15R2S
         rkfWLR2L5wGr26ZW+N7xoCViyOBkeduIbKLhIUhzKCokBXJ8ZwGTKzcEnZVPfvREWQgp
         ByKxA9U+DnM/CIXL/ltXCm3zvwUQMSi5xnDHOO4DpaLC153mUZfawHK17kaRPRJsKtcV
         gzaezv6+LWgCvqunSIfZ+AJ3JQchrknQtKxu6RIp/dFmm0ttwhTes3J+dDIsk6JN1GsG
         744OH2Pqbcx7ih4Zh6fIvXvjITpfXlsBjrNmsIo5RgJIXobefWFXhatGu1lzaUDUOIHS
         b+nQ==
X-Gm-Message-State: AA+aEWYL2UEDehY7djiO67WSXbZQHkZUdS1oe4n5p2LulNTUZ4W60Nd8
        YXyRq18qd8vA44Qku6pPbQI=
X-Google-Smtp-Source: AFSGD/XpPLURnbxQaRuMYr9weTRImAMZp23btin3Tw/tmBISE745v7rJfo3eO/52pVIOwGWdi4S1og==
X-Received: by 2002:a17:902:be0e:: with SMTP id r14-v6mr2907910pls.23.1542731145085;
        Tue, 20 Nov 2018 08:25:45 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e23sm57892643pfh.68.2018.11.20.08.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:25:44 -0800 (PST)
Date:   Tue, 20 Nov 2018 08:25:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-doc@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH] kbuild: announce removal of SUBDIRS if used
Message-ID: <20181120162543.GB4765@roeck-us.net>
References: <1542726258-8418-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542726258-8418-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 12:04:18AM +0900, Masahiro Yamada wrote:
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
>  drivers/watchdog/scx200_wdt.c      | 7 -------

For watchdog:

Acked-by: Guenter Roeck <linux@roeck-us.net>

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
> -- 
> 2.7.4
> 

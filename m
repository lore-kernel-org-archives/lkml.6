Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB94C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80B723D80
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="L5v6Fw3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80B723D80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752906AbeGEFlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:41:21 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:60028 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeGEFlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:41:20 -0400
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com [209.85.213.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w655eu3v026042;
        Thu, 5 Jul 2018 14:40:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w655eu3v026042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530769257;
        bh=VHOJilQXKJjE0TPG5dCxs62sReXJMa6NZeuc6PC63Nw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=L5v6Fw3ZNoL34ldQydIBb3Fo1nKQdFgjclL9b4H22XxOLct5AekTyBsPU9lbseJaX
         T0IQf4t5I8JH6T0gOf8oHc3sbempGGSGMq8M+DWhv0gE8yh8ATtTcwi6v03JX+ctA7
         xgiuu22eBdkDhDI9OIzyxZWyfzG33JEqY5WG2CzJLJtfHnQroNTmXNsabKLPrNrYUR
         mqCWMOJAggDeUJx86CkgpjfoOzOv1DMWfr5E/IjHF5OoHg33/ilA49f21o7vc7+fqI
         wrWrJ/QYeQWy214oomis8HlSVMqtoSQp1SzdbtguCxXEZOKEbxbZ38zNOsYiAwGMlv
         SeOgYm3JnOMiQ==
X-Nifty-SrcIP: [209.85.213.52]
Received: by mail-vk0-f52.google.com with SMTP id l64-v6so4183987vkl.12;
        Wed, 04 Jul 2018 22:40:56 -0700 (PDT)
X-Gm-Message-State: APt69E3Tb7sSwdW9Kgon9gHx+OwydJi1yECoeLsu4w9/sC9WcUwEEAJf
        xsjSi8qodDv5Ia7unPs7TGfNQb2qJhXRu7The/0=
X-Google-Smtp-Source: AAOMgpd92WxTEPIAeg4DIXDn/rQTuJBrPn2OPW/qpXrTCFl7lwL4W1CwqbK7rBRAlnUSNdFXZYV4x8+3WQjZUGbTX+U=
X-Received: by 2002:a1f:88:: with SMTP id 130-v6mr2535999vka.154.1530769255572;
 Wed, 04 Jul 2018 22:40:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 22:40:15 -0700 (PDT)
In-Reply-To: <20180702144711.22111-3-hch@lst.de>
References: <20180702144711.22111-1-hch@lst.de> <20180702144711.22111-3-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 5 Jul 2018 14:40:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT-hR1OtB4K53EeYoJEXY6kP8OjpFDt6Kpasw2fzQKPYw@mail.gmail.com>
Message-ID: <CAK7LNAT-hR1OtB4K53EeYoJEXY6kP8OjpFDt6Kpasw2fzQKPYw@mail.gmail.com>
Subject: Re: [PATCH 2/5] Kconfig: consolidate the "Kernel hacking menu"
To:     Christoph Hellwig <hch@lst.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-02 23:47 GMT+09:00 Christoph Hellwig <hch@lst.de>:
> Move the source of lib/Kconfig.debug and arch/$(ARCH)/Kconfig.debug to
> the top-level Kconfig.  For two architectures that means moving their
> arch-specific symbols in that menu into a new arch Kconfig.debug file,
> and for a few more creating a dummy file so that we can include it
> unconditionally.
>
> Also move the actual 'Kernel hacking' menu to lib/Kconfig.debug, where
> it belongs.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---




> diff --git a/arch/c6x/Kconfig.debug b/arch/c6x/Kconfig.debug
> new file mode 100644
> index 000000000000..49edf08813eb
> --- /dev/null
> +++ b/arch/c6x/Kconfig.debug
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +config ACCESS_CHECK
> +       bool "Check the user pointer address"
> +       default y
> +       help
> +         Usually the pointer transfer from user space is checked to see if its
> +         address is in the kernel space.
> +
> +         Say N here to disable that check to improve the performance.
> +

Just a nit:

When I ran 'git am', it complained about a blank line at the end of file.

.git/rebase-apply/patch:229: new blank line at EOF.






-- 
Best Regards
Masahiro Yamada

Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877DAC04AB9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 04:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EB7214C3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 04:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wuC53nu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EB7214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbeHPHfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 03:35:12 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:47344 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387933AbeHPHfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 03:35:11 -0400
Received: from mail-vk0-f47.google.com (mail-vk0-f47.google.com [209.85.213.47]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w7G4dR7f028294;
        Thu, 16 Aug 2018 13:39:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w7G4dR7f028294
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534394368;
        bh=lyrDa94olQTmuq24n9p0X2WJLbjDhCnQgLTh3zMh26g=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=wuC53nu060ClIj2M7nMd0pUKhb2IjQxSzp82znUo1IMqS+bJyC61kGSsmr+AsFBtF
         Yua/nr9jeXUgKLmN5rB5qdR85F7NwZfp4qmR6Y28DppI2qOsveW+6gqHrB7bS9O9yl
         GlYSgmqoFMTTD/J/cPkFw0aBEBbdTsMPkHUX54GQUBi2MLItOHVvxI+W2GJ61XG7zU
         ajUtF66a8cajz9h98LrNnH3vmuEkeSx7/PwCltPfifwNzdFFLjIiajmkYtr62NhCo2
         pw3jFrO9sTRx27v4J7xc3l7zNSigZ0XjnsQPeSipX6N2rRP8hcCkX304JBuBsrDwIo
         7QWNYYJ2t/UhA==
X-Nifty-SrcIP: [209.85.213.47]
Received: by mail-vk0-f47.google.com with SMTP id s17-v6so773318vke.10;
        Wed, 15 Aug 2018 21:39:28 -0700 (PDT)
X-Gm-Message-State: AOUpUlHTSp6T8wBB4yYTKeReHmTj+HyPdcZk0f/rkqSnOGhf8xxnKPn/
        fDtbuON+7nAUOiIAol9RO1Nmf6FQAbavXKmwcXE=
X-Google-Smtp-Source: AA+uWPxBTjh6AxIyYdHc0O6OZmhBMPMvCm9drx5U9lgGvI4kmOGU5bqP2PbRWPDwGgSDFLnu7L5JPfm0sm2qTeHwOOA=
X-Received: by 2002:a1f:4049:: with SMTP id n70-v6mr18539524vka.140.1534394367285;
 Wed, 15 Aug 2018 21:39:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 21:38:46
 -0700 (PDT)
In-Reply-To: <20180616111004.GB28657@zn.tnic>
References: <20180616111004.GB28657@zn.tnic>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 16 Aug 2018 13:38:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNATpMkwS523LMDSU2sQfMzTfQ8kv_+MWjz5jdbZHS65G8Q@mail.gmail.com>
Message-ID: <CAK7LNATpMkwS523LMDSU2sQfMzTfQ8kv_+MWjz5jdbZHS65G8Q@mail.gmail.com>
Subject: Re: /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

2018-06-16 20:10 GMT+09:00 Borislav Petkov <bp@alien8.de>:
> Hi,
>
> I'm seeing this when I do
>
> # make menuconfig
>
> after a fresh repo clean: git clean -dqfx
>
> Might wanna silence it...
>
> /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
> /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
> /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
>   HOSTCC  scripts/kconfig/lxdialog/checklist.o
> /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
> /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
> /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
>   HOSTCC  scripts/kconfig/lxdialog/inputbox.o
> /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
> /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
> /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
>   HOSTCC  scripts/kconfig/lxdialog/menubox.o
> /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
> /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
> /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
>   HOSTCC  scripts/kconfig/lxdialog/textbox.o
> /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
> /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
> /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
>   HOSTCC  scripts/kconfig/lxdialog/util.o
> /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
> /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
> /bin/sh: 1: .: Can't open scripts/kconfig/.mconf-cfg
>   HOSTCC  scripts/kconfig/lxdialog/yesno.o
>   UPD     scripts/kconfig/.mconf-cfg
>   HOSTCC  scripts/kconfig/mconf.o
>   HOSTLD  scripts/kconfig/mconf
> scripts/kconfig/mconf  Kconfig
>
> Thx.


Sorry for delay.

Now I addressed this problem.
https://patchwork.kernel.org/patch/10566951/


Thanks.


> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada

Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F34FC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEC521501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YT43JfBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEC521501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbeHBRDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:03:30 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:17029 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387456AbeHBRDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:03:30 -0400
Received: from mail-vk0-f43.google.com (mail-vk0-f43.google.com [209.85.213.43]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w72FBj21026266;
        Fri, 3 Aug 2018 00:11:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w72FBj21026266
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533222706;
        bh=v9ag9jPJSLb0UDeYHR5VLj2sQh8th2PgAZa7ob104TY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=YT43JfBN93shGJ1wQOT/YZwYZO45U2vnCObFrRwHJ1bDiyKAr/Ey/PNih1+OT2qz9
         QKXLtAA5/bL+bRw3hI6jb1N2TB6TJO5kewlikLijkkS6vNzuxpk6I9wTZbF0Wn5Qfl
         bx4FYKulNRU890sl9tSLM1SQC0c+CUXIBkGk/9swiWCHX3p0gsWA8Qw/OG7NGOezwo
         Do/UkhQayIT/5KAp3yk/5y8Bvt8EU9iW3AD+Ka5yeImQWugU6smdwMSVQVQd13GzXS
         KuDAIKrTqPkbDnc+6ITa2Jbh5OD15Ll7KwRQSzaD4rosjDz94lLIjqzn5Yz8SvEaXf
         TiXQVlizuZpXw==
X-Nifty-SrcIP: [209.85.213.43]
Received: by mail-vk0-f43.google.com with SMTP id v72-v6so1215859vkd.4;
        Thu, 02 Aug 2018 08:11:46 -0700 (PDT)
X-Gm-Message-State: AOUpUlG4pagmPeNc0QQ7yfpl7ROQWC9RBqX0XNbYC4P6CPiDLQy/7+bC
        IXghOOmH4Mv433MdcEUtU2DQsHGhnFeCnoO3LuU=
X-Google-Smtp-Source: AAOMgpcnKX7UgYHXcKO/VIkwzGvkw/sGQRoAW8Gk4fGxmUr1Dlk8DQcldlZ6femIjHiJ9T5I+MQquOdWJI3YRCGF1Ww=
X-Received: by 2002:a1f:2cce:: with SMTP id s197-v6mr1856916vks.106.1533222705137;
 Thu, 02 Aug 2018 08:11:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 08:11:04 -0700 (PDT)
In-Reply-To: <31061.1533131891@warthog.procyon.org.uk>
References: <31061.1533131891@warthog.procyon.org.uk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 3 Aug 2018 00:11:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT2_eaGbd04y1b=rfYhabiTpbEqYO+fznJrFOdzzmQ9Kw@mail.gmail.com>
Message-ID: <CAK7LNAT2_eaGbd04y1b=rfYhabiTpbEqYO+fznJrFOdzzmQ9Kw@mail.gmail.com>
Subject: Re: Can we fix samples/ dependency on headers please?
To:     David Howells <dhowells@redhat.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nicolas Pitre <nico@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.



2018-08-01 22:58 GMT+09:00 David Howells <dhowells@redhat.com>:
> Hi,
>
> I'm currently having to mark various userspace programs I've added to the
> samples/ directory as BROKEN in samples/Kconfig because the root Makefile
> mucks up the dependencies between building samples and headers_install.
>
> The main culprit seems to be:
>
>         commit dd92478a15fa3bfd746ee08b4ef59401c1537804
>         Author: Nicolas Pitre <nicolas.pitre@linaro.org>
>         Date:   Sun Feb 28 22:00:00 2016 -0500
>         kbuild: build sample modules along with the rest of the kernel
>
> which make the samples build in parallel with the build, thereby voiding the
> explicit dependency:
>
>         Documentation/ samples/: headers_install
>
> and thereby breaking:
>
>         commit ddea05fa148b4d8e66498e522a616d87f9cf81e3
>         Author: Arnd Bergmann <arnd@arndb.de>
>         Date:   Mon Jul 4 16:39:35 2016 +0200
>         kbuild: make samples depend on headers_install
>
> The obvious fix is to revert commit dd92478a15fa3bfd746ee08b4ef59401c1537804
> (see attached patch).
>
> David
> ---
> commit 5c186b58db93e2644012e2fcb4c6ca2e74c6754b
> Author: David Howells <dhowells@redhat.com>
> Date:   Wed Aug 1 14:48:22 2018 +0100
>
>     Revert "kbuild: build sample modules along with the rest of the kernel"
>
>     This reverts commit dd92478a15fa3bfd746ee08b4ef59401c1537804.
>
>     The problem with this commit is that some of the samples require the header
>     installation to occur first, but building them in parallel with the rest of
>     the build breaks that requirement.
>
>     Signed-off-by: David Howells <dhowells@redhat.com>
>
> diff --git a/Makefile b/Makefile
> index ca2af1ab91eb..30fc0a37ad41 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1009,16 +1009,14 @@ vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) FORCE
>  ifdef CONFIG_HEADERS_CHECK
>         $(Q)$(MAKE) -f $(srctree)/Makefile headers_check
>  endif
> +ifdef CONFIG_SAMPLES
> +       $(Q)$(MAKE) $(build)=samples
> +endif
>  ifdef CONFIG_GDB_SCRIPTS
>         $(Q)ln -fsn $(abspath $(srctree)/scripts/gdb/vmlinux-gdb.py)
>  endif
>         +$(call if_changed,link-vmlinux)
>
> -# Build samples along the rest of the kernel
> -ifdef CONFIG_SAMPLES
> -vmlinux-dirs += samples
> -endif
> -
>  # The actual objects are generated when descending,
>  # make sure no implicit rule kicks in
>  $(sort $(vmlinux-deps)): $(vmlinux-dirs) ;
> --


I dot not understand why this would fix your problem.

Does the combination of CONFIG_SAMPLES=y and CONFIG_HEADERS_CHECK=n
still fail to build?


If you need to install headers before building samples,
this should work:


diff --git a/Makefile b/Makefile
index b47af5a..555ee84 100644
--- a/Makefile
+++ b/Makefile
@@ -1023,6 +1023,7 @@ endif
 # Build samples along the rest of the kernel
 ifdef CONFIG_SAMPLES
 vmlinux-dirs += samples
+samples: headers_install
 endif

 # The actual objects are generated when descending,




Please note Arnd's patch only works for single targets.
'samples/' and 'samples' are different targets.


-- 
Best Regards
Masahiro Yamada

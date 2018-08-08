Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4448AC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DB3216E3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="yRJMFBNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DB3216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeHHElP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 00:41:15 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:63031 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbeHHElP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 00:41:15 -0400
Received: from mail-ua0-f175.google.com (mail-ua0-f175.google.com [209.85.217.175]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w782NlkJ015720;
        Wed, 8 Aug 2018 11:23:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w782NlkJ015720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533695028;
        bh=6bXCNQ6EJT5ymW++t7qV9ed1kqJVjxjTjisDB5XZNZk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=yRJMFBNfIxUloUD6nXHnIExU9OjCF6WkWqzO4pZM+IPtWc1y0t9z69NRxDtYVQmy3
         NrSiM1hFG06IQ0ZRbP1bJxv/HLMWkBckEgoI44yp90b+RkmMcbwGMDwPHhPvQ0HIhC
         vZdAPOM1LfcVdtW5Ydi2sINJojeQ7rqROO/9AUD0dp3CJlKj58n8OFTd9FedQL7DGN
         TkhWsbZZjR/UA43NR53hAB01+XZ/DBTGOM4CmcYx2mAMChSmR+bINBMPu/THmNAavz
         N0SVxKU4M0H2WUVF4wWl1FMnApDeHClqnyEbAAYPrpmH+mAv2/pQn9NyRQP1TiN5dD
         3Yq0hUln57JYA==
X-Nifty-SrcIP: [209.85.217.175]
Received: by mail-ua0-f175.google.com with SMTP id k8-v6so705546uaq.12;
        Tue, 07 Aug 2018 19:23:48 -0700 (PDT)
X-Gm-Message-State: AOUpUlHR3sqKpApK5pWmP/oqbLW2Uv3ZSrSQFXpRneyFB599NlLz+SDQ
        rhKZBRqNr/Uc+1im+bOU11VXx42i8o7S3L4SOHQ=
X-Google-Smtp-Source: AA+uWPzDEUarZEz3myJsOr/l9YOGH5VmduysQFTEdNbe83nQ3cd7aghTkkv+i61uwoQ+foYXZp2BN+XkQ3m3u3G+pIc=
X-Received: by 2002:a1f:4049:: with SMTP id n70-v6mr628694vka.140.1533695027092;
 Tue, 07 Aug 2018 19:23:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 19:23:06 -0700 (PDT)
In-Reply-To: <1533694454-7086-1-git-send-email-yamada.masahiro@socionext.com>
References: <1533694454-7086-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 8 Aug 2018 11:23:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNARPPskMNPkOjOZ9Xq06aVwWTocMXcVdqBHWWN+KZsOPRw@mail.gmail.com>
Message-ID: <CAK7LNARPPskMNPkOjOZ9Xq06aVwWTocMXcVdqBHWWN+KZsOPRw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: make samples really depend on headers_install
To:     David Howells <dhowells@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-08 11:14 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Kernel headers must be installed into $(objtree)/usr/include to avoid
> the build failure of samples.
>
> Commit ddea05fa148b ("kbuild: make samples depend on headers_install")
> addressed this, but "samples/" is only used for the single target build.
>
> "make samples/" properly installs kernel headers, but it does not work
> for general building because a phony target "sample" (no trailing slash)
> is used.
>
> Reported-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


David,
Could you check this patch, please?

Will you apply this to your tree
to fix the vfs sample issue?

Please let me know your thought.

Thanks.





> Changes in v2:
>   - Correct commit log (backslash -> slash)
>   - Fix a typo
>
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 7a3c454..1e47d13 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1009,9 +1009,10 @@ ifdef CONFIG_GDB_SCRIPTS
>  endif
>         +$(call if_changed,link-vmlinux)
>
> -# Build samples along the rest of the kernel
> +# Build samples along the rest of the kernel. This needs headers_install.
>  ifdef CONFIG_SAMPLES
>  vmlinux-dirs += samples
> +samples: headers_install
>  endif
>
>  # The actual objects are generated when descending,
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

Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2785ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 20:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741D3208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 20:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gd+TpTAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741D3208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeJGDhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 23:37:02 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:58294 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeJGDhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 23:37:02 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w96KVwiE023451;
        Sun, 7 Oct 2018 05:31:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w96KVwiE023451
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538857919;
        bh=R4yqrd5O7PrHUAbBYz6A/zw/aNoHrkoSfYsQoZEJ30s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gd+TpTAQEHquAxXzzzGbHlpN0hayfarZ4bPIt73bDzdBSZ414RGLso1dW27PLWlo0
         8dj9VYSchr5viQc0V+mZyLw6yBs/UgJde+Uj7GUXSWIam15m9tlEP0CxMDuDpJg1zy
         qgYoL1XJ6j3S8btNionWao4FVTtuyweJa8AbCcX67wBZ2+uTcLlKMtdgDUW4/Lpyk2
         hVXhAqIHEKluCv/VFXkIbgbhWf31x3jPrDZaxcCNu9QRrgadTr6/LwiPjy4imPVyix
         ZqjsF8JyvtLEJXYE9v5sk8rqDxc/7znmsV+HvXqfNcOEOXPR23K9+y2eRmAdtiBHe/
         KHWlMLrCQyf7w==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id m13-v6so5881632uak.10;
        Sat, 06 Oct 2018 13:31:58 -0700 (PDT)
X-Gm-Message-State: ABuFfojmTJwOdBeZaYPl7bRHLD7922FuYARPiiCZ8qMhjmGfdyp+nJq4
        SfdNMZ6d13h+FhrEXDcqrzHiokdm7aflHVvE4Pk=
X-Google-Smtp-Source: ACcGV60Qpzwl+vxyChOdQxa1d8IaCssS1izVcKW75svSeQhkSbRtqf7geNG8tLvHsLCXh95RiD59gZK+SFjl1ZXukno=
X-Received: by 2002:ab0:7093:: with SMTP id m19mr6847025ual.55.1538857917863;
 Sat, 06 Oct 2018 13:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180921142234.16882-1-kieran.bingham+renesas@ideasonboard.com> <20181005083313.2088252-1-arnd@arndb.de>
In-Reply-To: <20181005083313.2088252-1-arnd@arndb.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 7 Oct 2018 05:31:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQzOeoid3dRnAbZE3H-ZSbcJ4wJa_nreC-VLOutUH_ssA@mail.gmail.com>
Message-ID: <CAK7LNAQzOeoid3dRnAbZE3H-ZSbcJ4wJa_nreC-VLOutUH_ssA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix kernel/bounds.c 'W=1' warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        kieran.bingham+renesas@ideasonboard.com,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 5:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Building any configuration with 'make W=1' produces a warning:
>
> kernel/bounds.c:16:6: warnign: no previous prototype for 'foo' [-Wmissing-prototypes]
>
> When also passing -Werror, this prevents us from building any
> other files. Nobody ever calls the function, but we can't make
> it 'static' either since we want the compiler output.
>
> Calling it 'main' instead however avoids the warning, because gcc
> does not insist on having a declaration for main.
>
> Reported-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---


Applied to kbuild/fixes
with 's/warnign/warning/'

Thanks!




> I have run into this problem several times before, and thought I had
> sent a fix at some point. Looking in the archives, I came across
> the suggested fix from Kieran, so I'm following up on that here.
> ---
>  kernel/bounds.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bounds.c b/kernel/bounds.c
> index c373e887c066..9795d75b09b2 100644
> --- a/kernel/bounds.c
> +++ b/kernel/bounds.c
> @@ -13,7 +13,7 @@
>  #include <linux/log2.h>
>  #include <linux/spinlock_types.h>
>
> -void foo(void)
> +int main(void)
>  {
>         /* The enum constants to put into include/generated/bounds.h */
>         DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
> @@ -23,4 +23,6 @@ void foo(void)
>  #endif
>         DEFINE(SPINLOCK_SIZE, sizeof(spinlock_t));
>         /* End of constants */
> +
> +       return 0;
>  }
> --
> 2.18.0
>


-- 
Best Regards
Masahiro Yamada

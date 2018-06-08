Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id eEV4HMObGltpPwAAmS7hNA
	; Fri, 08 Jun 2018 15:08:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8A668607DC; Fri,  8 Jun 2018 15:08:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTZTldxM"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E29F5607E4;
	Fri,  8 Jun 2018 15:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E29F5607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeFHPIG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 11:08:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53542 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbeFHPIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 11:08:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id x6-v6so3907164wmc.3;
        Fri, 08 Jun 2018 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7TFSpge1gG2JkMrqIKV3kDdZoFZkMlCNQUTi0g778v0=;
        b=fTZTldxMGMZX0wHNLqOZHlZ9RXJ54XETYM1sZCMuMRtGlgKPiY58iTeRfVod86lbbe
         U46WBJuxB9ObJ+rE4UJfXcCVmQYKfeblR2xocru76aKMJ3TAHjuCdSLG2lOEoExNgVFV
         5fGlXXTK8c1VRaGtvI1qYrJKCoDIuRJzDnygHmdaJ5X7w6QQWSMN6gC3h/v1J4E2grCe
         dxs+VKxckyHxaP4ievhpIN/msO9J20LbexfnMUy6BOZWWLSP9TYNZn4FAAe3VULZ0uAH
         dHGrQbDNbnOJuHSXA6Q779IuMv6dr4wlkEq7yMr8B+ReAzEl3i4HKRNLOdoyqY/9aDd3
         E+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7TFSpge1gG2JkMrqIKV3kDdZoFZkMlCNQUTi0g778v0=;
        b=lWEuVz19hh0X6YGn8mhJpTKBgg1ARDd51lIfFnLypjMHbh3BR4MQf8FURqUdeuE0yV
         CQcoGJX7CX82k3zIBQsJE+BzEKSK7CyKW0EkFCBKdQ29qpolU505INZSPBI5GZFO4UJQ
         IWbm9zqRMdaHx1SUYGIFyWl80w9NrgfqAx44bgyGwvjjsUpvSm94Cd0ARMELsL7+Xd6Q
         UKoE1uqjkzbATd/qroP3jf1KJxS+vMR7wKpTzdEYAE/LIA9tkLK46eLiPfd54BqV51sI
         uyQOt0xYSmu9HzxAxbz8s4aEb50JgOxsywK2Z8jTBdGIQlKZgcr3r2xAWaJM6ehklb/q
         paKA==
X-Gm-Message-State: APt69E0GPFO1olia27/GlWiEUS3NAGZEAFRihzV16Eulhnxsl0SpYTNl
        UWXhhZ0PylejRNKD8/NI+C8es5g/v9FHgDY3fV8=
X-Google-Smtp-Source: ADUXVKLS8rqfymMl2aMit8IOqukdCC2mPKZvxMZ0HGB77QFIjZOGcKtqIWoAZvvpfMTcyLcdv8yvZkreHE9bBkHim4Y=
X-Received: by 2002:a50:9793:: with SMTP id e19-v6mr7486365edb.58.1528470482705;
 Fri, 08 Jun 2018 08:08:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:a087:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 08:08:02 -0700 (PDT)
In-Reply-To: <1528375527-22761-1-git-send-email-geert@linux-m68k.org>
References: <1528375527-22761-1-git-send-email-geert@linux-m68k.org>
From: Ramon Fried <ramon.fried@gmail.com>
Date: Fri, 8 Jun 2018 18:08:02 +0300
Message-ID: <CA+Kvs9m_XnE-4F+R9jKD4sD9=7eQP7rBidA_7Hi0XVLs7-KhUA@mail.gmail.com>
Subject: Re: [PATCH] wcn36xx: Remove Unicode Byte Order Mark from testcode
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Eyal Ilsar <eilsar@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        wcn36xx@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 3:45 PM, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> Older gcc (< 4.4) doesn't like files starting with a Unicode BOM:
>
>     drivers/net/wireless/ath/wcn36xx/testmode.c:1: error: stray =E2=80=98=
\357=E2=80=99 in program
>     drivers/net/wireless/ath/wcn36xx/testmode.c:1: error: stray =E2=80=98=
\273=E2=80=99 in program
>     drivers/net/wireless/ath/wcn36xx/testmode.c:1: error: stray =E2=80=98=
\277=E2=80=99 in program
>
> Remove the BOM, the rest of the file is plain ASCII anyway.
>
> Output of "file drivers/net/wireless/ath/wcn36xx/testmode.c" before:
>
>     drivers/net/wireless/ath/wcn36xx/testmode.c: C source, UTF-8 Unicode =
(with BOM) text
>
> and after:
>
>     drivers/net/wireless/ath/wcn36xx/testmode.c: C source, ASCII text
>
> Fixes: 87f825e6e246cee0 ("wcn36xx: Add support for Factory Test Mode (FTM=
)")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks Geert !
Acked-by: Ramon Fried <ramon.fried@gmail.com>

> ---
>  drivers/net/wireless/ath/wcn36xx/testmode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/testmode.c b/drivers/net/wi=
reless/ath/wcn36xx/testmode.c
> index 1279064a3b716c2e..51a038022c8b8040 100644
> --- a/drivers/net/wireless/ath/wcn36xx/testmode.c
> +++ b/drivers/net/wireless/ath/wcn36xx/testmode.c
> @@ -1,4 +1,4 @@
> -=EF=BB=BF/*
> +/*
>   * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>   *
>   * Permission to use, copy, modify, and/or distribute this software for =
any
> --
> 2.7.4
>
>
> _______________________________________________
> wcn36xx mailing list
> wcn36xx@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/wcn36xx

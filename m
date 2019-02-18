Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E65C10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B812147C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="NuGOmLGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfBRL5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:57:25 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:32907 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbfBRL5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:57:24 -0500
Received: by mail-ua1-f68.google.com with SMTP id q17so5725136uam.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 03:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=weT4TD1xezzx/iYCiwVCobi5Soc4QsB9VKo5sTQMWUM=;
        b=NuGOmLGEv9vFd1kLoZ00BSI2cZCQd/6AsEokJA5o5ioLKOPAO6Xk8kpyqEInZp30Xz
         F91HL3fI3+5skkRTZU+nZQYsBEyY5Vh/IMHqq0pwL7ERpimmqOlzlBkEy/FhbJOzp11X
         ypumI8h1PLJB4aC6WldSllCN8s4vzUFSvd291zyoIFByZDWRlshPlXqq/S/pd9oe9dQP
         1Mu1epZekavFcN1bvqAnwxvk9zQWkMyHFIq0v4hABpLSM7SRtfTRx7cJWsW7loZETh+8
         /QDpGYiH/pHWhXF9LfCI0OvOE4cla0bVVP+XVfaqUHaZRF5YfdfelT88gbATKCAWks5V
         Qo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=weT4TD1xezzx/iYCiwVCobi5Soc4QsB9VKo5sTQMWUM=;
        b=VLveCSK3jiT6jjqQKTxAzpKi2D2o8u8C6Nc3r62INr57y39oJbORxXrkPx2uw/lwNO
         XnPJbEuX1BxHqfi44+9moIvEeyCoSxjt6YRxvdJGTPbijaqGLfVxlf0OYaZ3I04fpQ1d
         6e17F0haNoF5BVkAnTWsuAtcc/UCKq7u5MW7jlSGSz0bKQFKuM3jyWUJSKkxxnfd4+EN
         G8wWGscRMpShlNAY1jvWruO0zM2QgHVJ/DESbnJ79/qV4hzUGsAQSIr4q3EgS3X2S+Xi
         /1oKdY+UC8SNqIvqwb9ZBqtlJ9kETwo5jCiVdPFa13tkv3S8Sm3dWOJ5JT/rDpgim3QB
         S6Ow==
X-Gm-Message-State: AHQUAuaB+8L7jNJL4+1HMu0Hv91RZMqcOPNhfV7KqqsF8JAlBH253tt0
        1krfeJ5g2zDzXFW5+Z2q1ctIkKyxSchr7NeWnFlctA==
X-Google-Smtp-Source: AHgI3IYAN0ZekUY/dAup2LjXp43TPno6n27TskQqbfxEJKUmKCBuyxJSbiTHmzWm6ijpRQX7Oir8+k7o4B9qnLQHkFg=
X-Received: by 2002:ab0:2c08:: with SMTP id l8mr11413017uar.113.1550491043805;
 Mon, 18 Feb 2019 03:57:23 -0800 (PST)
MIME-Version: 1.0
References: <20190211142758.16718-1-gilad@benyossef.com> <CAMuHMdUXAY7wBjCYH94V2NV7+MXdOKufnWpi=B1vAWkNFysxpg@mail.gmail.com>
In-Reply-To: <CAMuHMdUXAY7wBjCYH94V2NV7+MXdOKufnWpi=B1vAWkNFysxpg@mail.gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Mon, 18 Feb 2019 13:57:11 +0200
Message-ID: <CAOtvUMcss05jdH1JWaw3Z7eKvp3+gsMLvR+NSUxK--8Zu726aQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccree: add missing inline qualifier
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drag <ofir.drang@arm.com>, stable <stable@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 18, 2019 at 10:48 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> On Mon, Feb 11, 2019 at 3:29 PM Gilad Ben-Yossef <gilad@benyossef.com> wr=
ote:
> > Commit 1358c13a48c4 ("crypto: ccree - fix resume race condition on init=
")
> > was missing a "inline" qualifier for stub function used when CONFIG_PM
> > is not set causing a build warning.
> >
> > Fixes: 1358c13a48c4 ("crypto: ccree - fix resume race condition on init=
")
> > Cc: stable@kernel.org # v4.20
>
> # v5.0
>
> However, I believe the version comment is not necessary, as the same
> version is indicated by the Fixes tag.

I've marked it v4.20 since I've marked the patch that this fixes for
inclusion in 4.20.

Although the underlying bug was there all along, it was only revealed
by a change that
went into 4.20.
>
> > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>


Thanks!
Gilad


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!

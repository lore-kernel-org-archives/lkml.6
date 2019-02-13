Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5ABC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBA7222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vsQQUyDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbfBMIfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:35:47 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38490 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbfBMIfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:35:47 -0500
Received: by mail-vs1-f67.google.com with SMTP id t7so906723vsq.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 00:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1CJ7+HBssyW4VgrPSTkVO+QUsjpdif2wB2Ncp6ltYSU=;
        b=vsQQUyDp1rZxWyX/tCBU6HR2ElSUPwTlpRRWFnf5z/toGyZYwMYY5twEqvy4z0Jq0y
         Wp5L21DqIDyD6kde5StKA/IK6MviD2qwF433lHfWtwvKn7kefBEmEOsax5loPKkAuTn+
         0tr3kFdTd7k4lTGdjWbOH1L2jYvapytjQGRHsQ5eb/B+ykciLw4B5Tohs5AmLBlP1X3x
         cqFUUMKF6Y2YGdmHQ2LOFlnvrJ1mMcLWrbZ051ThJ3wOHdxcdQfDd9ObiDopVXwijf6J
         bMl9v5Kw9x+O8dWMsAzpOicDRsysjnWuDCbem2MBcislxcgl3+QdUd46VE7nNPnYDECa
         hq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1CJ7+HBssyW4VgrPSTkVO+QUsjpdif2wB2Ncp6ltYSU=;
        b=cwZh147ORrokZHeKfkXMuXhqbLYf5E4mqABCpAWn4VnQ6LJkL7KU/j9QYgtmSGCYsV
         dEtqpIBAHoov0MGNYzy38EiIVM3NiWYpHc8FrHsuERuMdH3Xy0yVjwSWSgc0gOdstd2u
         VaMzjq8HfB+dXugZYMWTWC/Hy0q9Hi0UGRV/w7oscBp3Mxy8q4hawPxYg8xo4iGFKCs1
         EJ8MyTjQArkF951jwTBbJ63SHcFkUwKo8pJJutu3CTEJ3apSbowyHbalNC7HZwnnAoBh
         OQQ8ZM8eVVppDIbWbvmAjlzH0W0JHFUIqg/Pp17Z9WrQCGfhxEalDxHqKVKai6RD6N0R
         SbEQ==
X-Gm-Message-State: AHQUAubVnjhytL3BQyFFrpn77KoF1FdCRmolq62tTKi3G5cy534tzUm1
        eb9fu2UjVOVWPvsnxnJo/+4TeiJKww87s42LiR8UB6pG
X-Google-Smtp-Source: AHgI3IYbZGP5UWt2TZFLIb1rQsRRqwfTSEHsbQ3ukj/qF+qwcoiro0ePSA7QHkIyNe7ugUGCXFpqWxlAfcdiOfU7h98=
X-Received: by 2002:a67:7685:: with SMTP id r127mr3298985vsc.35.1550046945890;
 Wed, 13 Feb 2019 00:35:45 -0800 (PST)
MIME-Version: 1.0
References: <20190212152558.GA21933@embeddedor>
In-Reply-To: <20190212152558.GA21933@embeddedor>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Feb 2019 09:35:10 +0100
Message-ID: <CAPDyKFrP3GX16EXQTjCa1ThfF-jzWM-JdtvY6TOqo8LBCJ2bbw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Hu Ziji <huziji@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 at 16:26, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warning:
>
> drivers/mmc/host/sdhci-xenon-phy.c: In function =E2=80=98xenon_emmc_phy_s=
low_mode=E2=80=99:
> drivers/mmc/host/sdhci-xenon-phy.c:527:47: warning: this statement may fa=
ll through [-Wimplicit-fallthrough=3D]
>    if ((priv->init_card_type =3D=3D MMC_TYPE_SDIO) ||
>        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
>        params->slow_mode) {
>        ~~~~~~~~~~~~~~~~~
> drivers/mmc/host/sdhci-xenon-phy.c:534:2: note: here
>   default:
>   ^~~~~~~
>
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>
> Notice that, in this particular case, the code comment is modified
> in accordance with what GCC is expecting to find.
>
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied for next - and by cleaning up the somewhat noisy change log, thanks=
!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-xenon-phy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-=
xenon-phy.c
> index 5b5eb53a63d2..8d07ee1b8f08 100644
> --- a/drivers/mmc/host/sdhci-xenon-phy.c
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> @@ -530,7 +530,7 @@ static bool xenon_emmc_phy_slow_mode(struct sdhci_hos=
t *host,
>                         ret =3D true;
>                         break;
>                 }
> -               /* else: fall through */
> +               /* fall through */
>         default:
>                 reg &=3D ~XENON_TIMING_ADJUST_SLOW_MODE;
>                 ret =3D false;
> --
> 2.20.1
>

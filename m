Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFA6C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AA3206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AG6bPljF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AA3206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbeJEUxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:53:35 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50545 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbeJEUxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:53:35 -0400
Received: by mail-it1-f194.google.com with SMTP id j81-v6so2693851ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 06:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fJ3Bbyp9OOzT20pG7lLiErkCSzzM0as8sL7KXcgm604=;
        b=AG6bPljFDZRGQlbIrkgVGEp6StW85sgY3gsot6Bpv3DfS73S4TSkS5g29YkuR8IoAy
         lttptLcfREOp+hsfrluRzkmouYWfu2rJwiV5A8lpWFUOTcxlwwwKcBtS2YMlyP5cpq+0
         lTYM9T6h68fwB0zCvMNYwDSb1nzLNg8dxEsSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fJ3Bbyp9OOzT20pG7lLiErkCSzzM0as8sL7KXcgm604=;
        b=I63t5CUZg+ZDNc5cGOg2zAJXN6fu3s2uKYtBaJdtbaQdmjn1BwD7QZcQDS70ZqDypS
         434f4Zrv769XxsZQLST9hDz8uO1VXrxBisUKF22OIGYD6vJ54GevJ7YIZaPmlE3Qxqxd
         Y0SL+9seuhS8KNe40/WgyNgNz2f8pmF/XdrcBq/2v0nzdhviZYeM0B5Ur1nmDmU44+Un
         oJ48d1vSWJDtWVbArk5AccUmyHVMOg92IL2kbpipp5tbuv7TrJW0eDNgdPmvkrG0LZV5
         CNCe9c5pLcJZsJqoyhnI+Yel7Ts0RPkZdfy+MQYMw2bdUGt4gT3rWAcAlL+qJ0w9MzSv
         5P2Q==
X-Gm-Message-State: ABuFfoiR6c0hJMRiSRBOtcbrTtqd/vRsWKbpRuS8svKfn6nTp0QKhtSH
        sla7h0ObD2fTzOaDraFp9Ja0vbwKSWqBIq1BIE5McfPGK5c=
X-Google-Smtp-Source: ACcGV61s2NY/Sv2NhrZzRo85kzih8smjcGfmm+IcADdR/3lw8x4EppGEA8lASs8h5PpTuCo0LT76wSR1jQ/zYJRwjso=
X-Received: by 2002:a05:660c:243:: with SMTP id t3mr8223631itk.146.1538747684291;
 Fri, 05 Oct 2018 06:54:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Fri, 5 Oct 2018 06:54:03 -0700 (PDT)
In-Reply-To: <20181005100903.GA32057@embeddedor.com>
References: <20181005100903.GA32057@embeddedor.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 5 Oct 2018 15:54:03 +0200
Message-ID: <CAPDyKFo6g9dHDBuL4FL2HW5DSAmwtbVKRFOcTAKxFkyQkDDQiQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-mx-sdio: mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 October 2018 at 12:09, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Notice that in this particular case, I replaced the "fall-through:"
> comment with a proper "fall through", which is what GCC is
> expecting to find.
>
> Addresses-Coverity-ID: 1373880 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>


Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/meson-mx-sdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index 2cfec33..abe253c 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -294,7 +294,7 @@ static void meson_mx_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         switch (ios->power_mode) {
>         case MMC_POWER_OFF:
>                 vdd = 0;
> -               /* fall-through: */
> +               /* fall through */
>         case MMC_POWER_UP:
>                 if (!IS_ERR(mmc->supply.vmmc)) {
>                         host->error = mmc_regulator_set_ocr(mmc,
> --
> 2.7.4
>

Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C62C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D0A20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GNXFVutU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfA1MDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:03:53 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46453 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfA1MDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:03:52 -0500
Received: by mail-ua1-f67.google.com with SMTP id v24so5479220uap.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 04:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sByUJrKsTOxJYVww13dSB2bgQhM1gVqK4ReGQH3yoFk=;
        b=GNXFVutUcpCdIF+x7BZJlfEO1iFZLh8FqB8E6XFAXbPl6/2tbGtG43iCMOvFvuvqaa
         XEb+C51YbMXKZbWfWA6RKydxfFm5XBtULSuQyBAlPFxqQwT11ZTKleRWmEfrUupeQuxt
         Y+M6Fz+u8aBkN5eniihRN1DMq2qAj+sv9BNX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sByUJrKsTOxJYVww13dSB2bgQhM1gVqK4ReGQH3yoFk=;
        b=M24A6pyPCdUJxdFN6XKTxBvwo4A4vXfI+x1jgzOJwGz7pYiO7D76E2jxYLoF25C3Zr
         k+yklmehaiU8uJoqrYpvxPr0Ns34Uy0ey50gqTp8+Cvx3I2VEUmo8hfTReLGjEy2TgbL
         FZ9CoC+MUGQHJdMdO25TMm3s4btaXAdi9KYY5xOHj/HVgxlS596eo3DUcaYSqrJmy6Sm
         y+7OP3eqjOf1XFlnnfGjCNMtlFzse3Z432NDBnnbrbX/muevqZFWhJ5b1+HngD128WUr
         vO26OUQds71KrMr2RMyEkCmNR8W0vXtnkbXcFsKl4UOvV1PmNNz8YqrXg/kn5HJudMNy
         GJzA==
X-Gm-Message-State: AJcUukfljjyXqxvppkRKDufPX4rxfsh+eibLkA9UyQ6P100jJ1AEtGR9
        /CTxXIPhnDWLcB4OerewniUJud8taEqy35xEMEQnkQ==
X-Google-Smtp-Source: ALg8bN7cUn8ayIYSRR8QH1Dr2XY8uGoKJxJmlhbQTvSNbYqmrlvZ+PXPK+onvfJN2abZAp7wF603MtSPMOW67iWOmbM=
X-Received: by 2002:ab0:b83:: with SMTP id c3mr8378257uak.77.1548677031631;
 Mon, 28 Jan 2019 04:03:51 -0800 (PST)
MIME-Version: 1.0
References: <1548245125-31664-1-git-send-email-chaotian.jing@mediatek.com>
In-Reply-To: <1548245125-31664-1-git-send-email-chaotian.jing@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Jan 2019 13:03:15 +0100
Message-ID: <CAPDyKFoWDDrNx0+k+4AuXAThxLizmvXUUMHqmA0Cy2OgVm6iKA@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: fix incorrect register setting of hs400_cmd_int_delay
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Yong Mao <yong.mao@mediatek.com>,
        jjian zhou <jjian.zhou@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 at 13:05, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> to set cmd internal delay, need set PAD_TUNE register but not PAD_CMD_TUNE
> register.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Applied for fixes, adding a fixes+stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 8afeaf8..833ef05 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -846,7 +846,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>
>         if (timing == MMC_TIMING_MMC_HS400 &&
>             host->dev_comp->hs400_tune)
> -               sdr_set_field(host->base + PAD_CMD_TUNE,
> +               sdr_set_field(host->base + tune_reg,
>                               MSDC_PAD_TUNE_CMDRRDLY,
>                               host->hs400_cmd_int_delay);
>         dev_dbg(host->dev, "sclk: %d, timing: %d\n", host->mmc->actual_clock,
> --
> 1.8.1.1.dirty
>

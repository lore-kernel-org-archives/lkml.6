Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A07C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE5D20841
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vh9D9VND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE5D20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeJJURT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:17:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38761 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeJJURT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:17:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id l1so5205742otj.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 05:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QnQ0/BbfvUwWvvx/bslCw+vNABRQpSxBufcVdDRcS/s=;
        b=vh9D9VND5m1VxJS22var0LyHg4TdXZ9wNFq1Lf6X3XRC5NpnMooADmFThpftZF0jjL
         1M+TVnIoQNcrczwKLtcx7ch2cXVwyVW8ey1tnrMfpLV5b4iZWGgcgT3nnB3Uz53K2/Q5
         S18Fw+OqXXG++NcoULqdCgP4ZEx8QvQTgxbc604KUxQCRuBpUGcBng8/Kv6nGoDYEARB
         VgTnfq/Tu82khtNuqyIzh2r1zFdR+ylx8IA3wByut8zQi28n69w9f8vTRLF/7ZW8BkPb
         9ydCYgkX168eihh6Hj28fCwZ28RSfrf6V2XEX1g4AjPdAUpNwwvss/U+YacVEfukI0z/
         kiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QnQ0/BbfvUwWvvx/bslCw+vNABRQpSxBufcVdDRcS/s=;
        b=hvGrp1rRBPWQWBM56S7Mj2qkgNg8+WpL8laiakSHPjHG5BffQIzTban2QA8VjWHY3P
         8UJaM9FHDsjYngFKMvBlrWD+IwDt06lFyzqaPYz2/tFnveGdQ/+Qbx4tzJfa1SHqeD04
         CHdF6ZUM04xKpGifbm6rNUsn58HmwOviFwlmJOn4r25VNTDgR8dfahiJ2LplfTuWfWmR
         YZicD3G7DtwYmjUnOQ1FXwRuofE8JHVjql37eFtNqkNwpeozHeXPttkePzVL6Lazp4Yp
         Ozm+Mo2lrA2y5USZhybOv/Q0Z/C2ycVOKJLNfIfSj4G17vOQmWzYVhvu0AYbHmeDbpfS
         a3lA==
X-Gm-Message-State: ABuFfogRtCVqoKs/0NIArE0nNY4LeBF1kOtJn4TTcgelZMkOWiO71KwS
        AMe0QOSpIpB+Boz7q0ozTr+7YV4or7KJuUnd54k=
X-Google-Smtp-Source: ACcGV60THSYsFzu2KF1D7TaZ7cT/iYUJimhjstbs/nWhJBxpeie5MixRDwOw5GEGh2iJwF4yrFGk6lntZwSg4W2p45M=
X-Received: by 2002:a9d:4374:: with SMTP id y49mr17409976oti.287.1539176115269;
 Wed, 10 Oct 2018 05:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181009153526eucas1p2cdbb125bc7a66e0685f2277740a25630@eucas1p2.samsung.com>
 <20181009153526eucas1p2cdbb125bc7a66e0685f2277740a25630~b_q7Stknv2226522265eucas1p2C@eucas1p2.samsung.com>
In-Reply-To: <20181009153526eucas1p2cdbb125bc7a66e0685f2277740a25630~b_q7Stknv2226522265eucas1p2C@eucas1p2.samsung.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 10 Oct 2018 09:55:14 -0300
Message-ID: <CAOMZO5DGNu-oabp+U2DcTYQ4ozBESaOvaSW5pcJJJCWmw5+Szg@mail.gmail.com>
Subject: Re: [PATCH] config: arm: imx: remove PROVE_LOCKING from defconfig
To:     l.luba@partner.samsung.com
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Tue, Oct 9, 2018 at 12:36 PM Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> PROVE_LOCKING enables LOCKDEP, which causes big overhead on cache and
> bus transactions.
>
> On some ARM big.LITTLE architecutres (Exynos 5433) the overhead is really big.
> The overhead can be measures using hackbench which will speed up
> by x3 times (11sec -> 3.4sec).
> When you check transaction on cache or buses, the results are way higher
> than normal for the same hackbench test:
> L1d cache invalidations: 26mln vs 4mln
> L2u cache invalidations: 42mln vs 12mln
> bus cyc/access: 30cyc/access vs. 20cyc/access
> context switch is x3 times cheaper
>
> Enable this option only when you have some locking issue to investigate.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 7eca43f..f55cd2d 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -425,7 +425,6 @@ CONFIG_PRINTK_TIME=y
>  CONFIG_DEBUG_FS=y
>  CONFIG_MAGIC_SYSRQ=y
>  # CONFIG_SCHED_DEBUG is not set
> -CONFIG_PROVE_LOCKING=y

Russell explains here why it is desirable to have
CONFIG_PROVE_LOCKING=y for development:
https://www.spinics.net/lists/kernel/msg2929513.html

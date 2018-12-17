Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293FDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB922133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388123AbeLQQ3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:29:45 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:23162 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbeLQQ3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:29:44 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id E2D7113F838;
        Mon, 17 Dec 2018 17:29:18 +0100 (CET)
Subject: Re: [PATCH v1 1/1] MAINTAINERS: update list of qcom drivers
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <cover.1545063166.git.amit.kucheria@linaro.org>
 <ced6f6be01195e706ded5548897ff72503780146.1545063166.git.amit.kucheria@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <142a773d-9726-777c-b932-1dccf251cda1@free.fr>
Date:   Mon, 17 Dec 2018 17:29:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ced6f6be01195e706ded5548897ff72503780146.1545063166.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/2018 17:19, Amit Kucheria wrote:

> Several drivers didn't have a specific maintainer (other than the
> subsystem maintainer). Switch to using the 'qcom' and 'msm' regex
> patterns to capture all of them and add exceptions to the couple of
> drivers that contain 'msm' but are not related to qcom hardware.
> 
> Thanks to Marc for the idea to use the N regex.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  MAINTAINERS | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3318f30903b2..c9376030f77a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1929,20 +1929,14 @@ M:	Andy Gross <andy.gross@linaro.org>
>  M:	David Brown <david.brown@linaro.org>
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/soc/qcom/
> -F:	arch/arm/boot/dts/qcom-*.dts
> -F:	arch/arm/boot/dts/qcom-*.dtsi
> -F:	arch/arm/mach-qcom/
> -F:	arch/arm64/boot/dts/qcom/*
> +N:	qcom
> +N:	msm
> +X:	drivers/rtc/rtc-msm6242.c
> +X:	drivers/net/wireless/broadcom/brcm80211/brcmsmac/

I would exclude all of drivers/net/wireless/broadcom

Aside from that trivial issue,
Reviewed-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Regards.

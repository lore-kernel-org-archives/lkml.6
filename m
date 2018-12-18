Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B77AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684512133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbeLRIFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:05:18 -0500
Received: from purkki.adurom.net ([80.68.90.206]:33166 "EHLO purkki.adurom.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbeLRIFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:05:17 -0500
X-Greylist: delayed 1339 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Dec 2018 03:05:16 EST
Received: from localhost
        ([127.0.0.1] helo=purkki.adurom.net ident=kvalo)
        by purkki.adurom.net with esmtp (Exim 4.80)
        (envelope-from <kvalo@adurom.com>)
        id 1gZA1j-0003YC-Q1; Tue, 18 Dec 2018 09:42:51 +0200
From:   Kalle Valo <kvalo@adurom.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, marc.w.gonzalez@free.fr,
        bjorn.andersson@linaro.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/1] MAINTAINERS: update list of qcom drivers
References: <cover.1545063166.git.amit.kucheria@linaro.org>
        <ced6f6be01195e706ded5548897ff72503780146.1545063166.git.amit.kucheria@linaro.org>
Date:   Tue, 18 Dec 2018 09:42:51 +0200
In-Reply-To: <ced6f6be01195e706ded5548897ff72503780146.1545063166.git.amit.kucheria@linaro.org>
        (Amit Kucheria's message of "Mon, 17 Dec 2018 21:49:27 +0530")
Message-ID: <87r2ef701w.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amit Kucheria <amit.kucheria@linaro.org> writes:

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

IMHO this is pretty fragile in the long term. For example only due to
historical reasons qualcomm wireless drivers currently under ath
directory but who knows if at some point we switch using qcom (or
qualcomm) directory. Also the wireless drivers might easily have
filenames containing strings like "msm" or "qcom" (which I assume would
match with "N" rules above).

-- 
Kalle Valo

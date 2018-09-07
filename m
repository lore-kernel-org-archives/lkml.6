Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6294CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2183D20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2183D20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeIHBHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:07:44 -0400
Received: from baldur.buserror.net ([165.227.176.147]:48620 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeIHBHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:07:44 -0400
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1fyNJR-0007Sx-DR; Fri, 07 Sep 2018 15:25:06 -0500
Message-ID: <86101ce0f4201d05510e57d74cafe8c665b8e5d4.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Ran Wang <ran.wang_1@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Fri, 07 Sep 2018 15:25:04 -0500
In-Reply-To: <20180831035219.31619-3-ran.wang_1@nxp.com>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
         <20180831035219.31619-3-ran.wang_1@nxp.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: ran.wang_1@nxp.com, leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH 3/3] soc: fsl: add RCPM driver
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-31 at 11:52 +0800, Ran Wang wrote:
> The NXP's QorIQ Processors based on ARM Core have RCPM module (Run
> Control and Power Management), which performs all device-level
> tasks associated with power management such as wakeup source control.
> 
> This driver depends on FSL platform PM driver framework which help to
> isolate user and PM service provider (such as RCPM driver).
> 
> Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
> Signed-off-by: Ying Zhang <ying.zhang22455@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  drivers/soc/fsl/Kconfig   |    6 ++
>  drivers/soc/fsl/Makefile  |    1 +
>  drivers/soc/fsl/ls-rcpm.c |  153
> +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 160 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/soc/fsl/ls-rcpm.c

Is there a reason why this is LS-specific, or could it be used with PPC RCPM
blocks?

> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
> index 6517412..882330d 100644
> --- a/drivers/soc/fsl/Kconfig
> +++ b/drivers/soc/fsl/Kconfig
> @@ -30,3 +30,9 @@ config FSL_PLAT_PM
>  	  have to know the implement details of wakeup function it require.
>  	  Besides, it is also easy for service side to upgrade its logic
> when
>  	  design changed and remain user side unchanged.
> +
> +config LS_RCPM
> +	bool "Freescale RCPM support"
> +	depends on (FSL_PLAT_PM)

Why is this parenthesized?

-Scott


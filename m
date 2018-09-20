Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A00ECE567
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CA12152C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="j0s+TY3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CA12152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbeITSJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:09:17 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:50864 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731580AbeITSJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:09:16 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8E61B1BE0;
        Thu, 20 Sep 2018 14:25:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1537446359;
        bh=Bx8sqA4o3agO+upiCfUs92q34FKK6gZVJzPSjM9T7mE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j0s+TY3NxF9Nif3+nLPJs+i60TW8rhZWLWMHidqdVGOPN7FLMgrPwfRgNmUWJh0v/
         +Vr5Mve24E+Fx3zKbgE3/NVGz6lLV+/TXLc4/3XC0Vh2fEJqpbNIiI1BravSg8NDWy
         YvKD3oDBRY7+J6/a/dONr1ZT8CM9T9sNIL7nIAyc=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joao.Pinto@synopsys.com, festevam@gmail.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>
Subject: Re: [V2, 1/5] media: platform: Add a DesignWare folder to have Synopsys drivers
Date:   Thu, 20 Sep 2018 15:26:11 +0300
Message-ID: <5939502.lGiqCuzIrn@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180920111648.27000-2-lolivei@synopsys.com>
References: <20180920111648.27000-1-lolivei@synopsys.com> <20180920111648.27000-2-lolivei@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

Thank you for the patch.


On Thursday, 20 September 2018 14:16:39 EEST Luis Oliveira wrote:
> This patch has the intention of make the patch series more clear by creating
> a dwc folder.
> 
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>

No issue with the content, but you should fold this in patch 3/5, it doesn't 
deserve a patch on its own.

> ---
> Changelog
> v2:
> - Fix Kbuild error with no Makefile present
> 
>  drivers/media/platform/Kconfig      | 1 +
>  drivers/media/platform/Makefile     | 3 +++
>  drivers/media/platform/dwc/Kconfig  | 0
>  drivers/media/platform/dwc/Makefile | 0
>  4 files changed, 4 insertions(+)
>  create mode 100644 drivers/media/platform/dwc/Kconfig
>  create mode 100644 drivers/media/platform/dwc/Makefile
> 
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index f627587..f627a27 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -137,6 +137,7 @@ source "drivers/media/platform/am437x/Kconfig"
>  source "drivers/media/platform/xilinx/Kconfig"
>  source "drivers/media/platform/rcar-vin/Kconfig"
>  source "drivers/media/platform/atmel/Kconfig"
> +source "drivers/media/platform/dwc/Kconfig"
> 
>  config VIDEO_TI_CAL
>  	tristate "TI CAL (Camera Adaptation Layer) driver"
> diff --git a/drivers/media/platform/Makefile
> b/drivers/media/platform/Makefile index 6ab6200..def2f33 100644
> --- a/drivers/media/platform/Makefile
> +++ b/drivers/media/platform/Makefile
> @@ -98,3 +98,6 @@ obj-$(CONFIG_VIDEO_QCOM_VENUS)		+= qcom/venus/
>  obj-y					+= meson/
> 
>  obj-y					+= cros-ec-cec/
> +
> +obj-y					+= dwc/
> +
> diff --git a/drivers/media/platform/dwc/Kconfig
> b/drivers/media/platform/dwc/Kconfig new file mode 100644
> index 0000000..e69de29
> diff --git a/drivers/media/platform/dwc/Makefile
> b/drivers/media/platform/dwc/Makefile new file mode 100644
> index 0000000..e69de29

-- 
Regards,

Laurent Pinchart




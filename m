Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEEFC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B8521836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544951908;
	bh=3pxuy9Pl1V0ZcdoriibymykrZXTEiFIG4oHxrcFUDsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E20mA//cOpDYwit/7gJHMliMmLz7YMIt7n3hA8wbrIacwS5973AZ4mir3udcKpybL
	 Jei8AOMS4Y0scAqrncMAPRA7M55O4Nw0hsfXgffx9POY5jZo6wN98SHmDH/uVqEwa0
	 hM23MK3vxxzMW8PoZUYukc80g9wuXoVxlE47stHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbeLPJS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 04:18:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729758AbeLPJS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 04:18:26 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBC672084D;
        Sun, 16 Dec 2018 09:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544951906;
        bh=3pxuy9Pl1V0ZcdoriibymykrZXTEiFIG4oHxrcFUDsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lK+SohxduZbowFte47Wwupd5ZV/Bu74BS6MyQLfDzXJKxKtYNhQIGlwXYZW7Rm60X
         JDWlJl4cpldx0NaQPTTvYpytGS18BLg/hCrIoipEi/K7oPB2DD0lv2lkZCHJ1NjUk1
         awAKhd1StG2MYpAzRG4liHIaG05HZLTn8skqHF5c=
Date:   Sun, 16 Dec 2018 17:17:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
        Abel Vesa <abelvesa@linux.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH v5 3/6] arm64: add support for i.MX8M EVK board
Message-ID: <20181216091718.GL13243@dragon>
References: <1544365552-30270-1-git-send-email-abel.vesa@nxp.com>
 <1544365552-30270-4-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544365552-30270-4-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 02:26:08PM +0000, Abel Vesa wrote:
...
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 7748e6d..0001361 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -18,3 +18,5 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
> +
> +dtb-$(CONFIG_SOC_IMX8MQ) += imx8mq-evk.dtb

I changed the line as below to drop use of SOC_IMX8MQ.

   dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb

Shawn

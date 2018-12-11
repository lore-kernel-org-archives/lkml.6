Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DE6C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066E620849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544515826;
	bh=pc1y6yXVirKZvqR8LRZ77oAwdhGNMOQFuh25Qf6BiZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZRYtQW2XUWl7N/+gphLipY4mrS1cR9doSTdagL7T32C6PQviAMWjmKH1We6O1oLGt
	 PTg6A+0qqPpLJ1YZlhamV4bdEbVNDY7sM6NyMxXsjsah1oGF+BtkKdI3c2rUBiwV/V
	 n4H0cqHYkj0dmqKlOU3Z4qfTMpLNA/SgavGur99c=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066E620849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeLKIKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:10:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbeLKIKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:10:24 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14AF020811;
        Tue, 11 Dec 2018 08:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544515824;
        bh=pc1y6yXVirKZvqR8LRZ77oAwdhGNMOQFuh25Qf6BiZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wvaYS3s9/PD3FiBRfgoc/0Ry31w9gugGkLlXWRbQGGJj2plFkOeej34EFnX2rR+ZR
         yiLFRP0/oZMG4lGGUmtuECzlpN05NPA7+/K15yaXlFodZyOiy9sBtB7IKel7L7QdIL
         tPuNEmTNxNkoGnQtSEQ4vNs3f0Fy5IRFO9xbrD3k=
Date:   Tue, 11 Dec 2018 16:09:29 +0800
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
Subject: Re: [PATCH v5 0/6] Add basic support for i.MX8MQ SoC and i.MX8MQ EVK
 board
Message-ID: <20181211080854.GZ3987@dragon>
References: <1544365552-30270-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544365552-30270-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 02:26:05PM +0000, Abel Vesa wrote:
> Took this from Lucas since he's busy with some other work for the moment and
> I thought we might be able to get this ready for the merge window.
> 
> Basically is just a respin with a minor fix for a comment from Rob.
> 
> Lucas, thanks for all the effort with this.

When you handle patches from someone else, you should have your SoB
added.  Fixed for you.

> 
> Changes since v5:
>  * replaced the name of the node peripherals with soc in dts file
> 
> Baruch Siach (2):
>   arm64: dts: imx8mq: add watchdog devices
>   arm64: dts: imx8mq-evk: enable watchdog
> 
> Lucas Stach (4):
>   arm64: add basic Kconfig symbols for i.MX8
>   arm64: add basic DTS for i.MX8MQ
>   arm64: add support for i.MX8M EVK board
>   MAINTAINERS: add i.MX8 DT path to i.MX architecture
> 
>  Documentation/devicetree/bindings/arm/fsl.txt  |   8 +

This file will be removed in v4.21-rc1 as we are moving to json-schema.
So I dropped the changes on fsl.txt and will patch fsl.yaml for the new
compatible strings.

Series is applied.

Shawn

>  MAINTAINERS                                    |   1 +
>  arch/arm64/Kconfig.platforms                   |  14 +
>  arch/arm64/boot/dts/freescale/Makefile         |   2 +
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts   | 303 ++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h | 623 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi      | 416 +++++++++++++++++
>  7 files changed, 1367 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-evk.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq.dtsi
> 
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE2EC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1846420892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544060444;
	bh=pWxeNia+YaLSnHDguFDAptVM0w1dUjSe1Qe4eXfmRsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V7EkrfCUDM6e6iK94dtRWaERttp6Sq31XgYO21XZociqSdp7oQOjYrOIBMdgSeopE
	 25xB77Fnx9TYVvWPqMFdOuV3J23lPkYqhSEgV4lEnZz3wABYeA72HgQiIjukVtkleh
	 v4vJcDX6vE+UM/0Y8epaE7atE9JssW8+VKJRCGSM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1846420892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbeLFBkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:40:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbeLFBkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:40:43 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3545D205C9;
        Thu,  6 Dec 2018 01:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544060442;
        bh=pWxeNia+YaLSnHDguFDAptVM0w1dUjSe1Qe4eXfmRsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dgv9hHPL7qPEXEx2NUQqA3OpKWK2u/BZ/hueXsTZ7fMmnz/iTJ4vN6/0U/ey0TMFl
         46ZlrRx1KQBZO/GwxdjPaii5z6gt1Pdp+I6aKhGuAQ7aJZ5ehgRMXrbtqG9GXXT6pD
         CVEkNVMb66lgAyFlnx+rRYa5doBGjf1cmsNIpfSU=
Date:   Thu, 6 Dec 2018 09:40:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 0/9] Improvements for i.MX7D PICO SoM and its baseboards
Message-ID: <20181206013959.GV3987@dragon>
References: <20181202212520.16650-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202212520.16650-1-otavio@ossystems.com.br>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 07:25:11PM -0200, Otavio Salvador wrote:
> This patchset rework the imx7d-pico SoM, its Pi baseboard
> and add the Hobbit baseboard support as well.
> 
> 
> Fabio Estevam (8):
>   ARM: dts: imx7d-pico: Do not harcode the memory size
>   ARM: dts: imx7d-pico: Switch to SPDX identifier
>   ARM: dts: imx7d-pico-pi: Move SoM related part to imx7d-pico.dtsi

The applying fails on this patch.  Please rebase the series on imx/dt
branch.

Shawn

>   ARM: dts: imx7d-pico: Pass the USBOTG1_PWR pinctrl
>   ARM: dts: imx7d-pico: Pass the Ethernet PHY reset GPIO
>   ARM: dts: imx7d-pico: Extend peripherals support
>   ARM: dts: imx7d-pico-pi: Extend peripherals support
>   ARM: dts: imx7d-pico: Add the imx7d-pico-hobbit variant
> 
> Otavio Salvador (1):
>   ARM: dts: imx7d-pico: Improve WiFi regulator name
> 
>  arch/arm/boot/dts/Makefile              |   1 +
>  arch/arm/boot/dts/imx7d-pico-hobbit.dts | 105 +++++++
>  arch/arm/boot/dts/imx7d-pico-pi.dts     | 180 +++---------
>  arch/arm/boot/dts/imx7d-pico.dtsi       | 355 ++++++++++++++++++++----
>  4 files changed, 457 insertions(+), 184 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx7d-pico-hobbit.dts
> 
> -- 
> 2.19.2
> 

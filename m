Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0717C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 13:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FCD20837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 13:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544361019;
	bh=rmOD0wDcgC3N59mERBqnvW/chMO+mzlfiUEafmnlDYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QvbAfe0j+XTkoX4rA5AoM8zC1FcIlR9FCmPrMnARc1IXX1Y1FqxJ+DRN8gcc7wDXa
	 qfPZ1sSW+CzrauKFaVt+KWdaXx+z8FgH4+gWEw3jZjWbEiJqANRUdW9ooamDEkhL4n
	 a7f8wF3mertfc9aPEOk9qWxWEWuNa7wh1vdnByQc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FCD20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeLINKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 08:10:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:44842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeLINKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 08:10:17 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A37E2081C;
        Sun,  9 Dec 2018 13:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544361017;
        bh=rmOD0wDcgC3N59mERBqnvW/chMO+mzlfiUEafmnlDYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kfafvZLlj3Ei+zAsmCr2+WU5M/VRhSOL6HQqnIiITPjp8g6B9InenIQ1Eg8KwIlWZ
         00+6xIXpud+pErwQI2UR9iQx5XpH3CF24L/hfiQ/hVV5hakgbf087nubkdDCytLo2i
         i0mjcFCtliWSUfg4Ep/DzdFB8CNz1LHlUYxo/ugQ=
Date:   Sun, 9 Dec 2018 21:09:25 +0800
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
Subject: Re: [PATCH v2 0/9] Improvements for i.MX7D PICO SoM and its
 baseboards
Message-ID: <20181209130923.GF22960@dragon>
References: <20181206100905.15053-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206100905.15053-1-otavio@ossystems.com.br>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 08:08:56AM -0200, Otavio Salvador wrote:
> This patchset rework the imx7d-pico SoM, its Pi baseboard
> and add the Hobbit baseboard support as well.
> 
> Changes in v2:
> - replace fsl,uart-has-rtscts with uart-has-rtscts
> 
> Fabio Estevam (8):
>   ARM: dts: imx7d-pico: Do not harcode the memory size
>   ARM: dts: imx7d-pico: Switch to SPDX identifier
>   ARM: dts: imx7d-pico-pi: Move SoM related part to imx7d-pico.dtsi
>   ARM: dts: imx7d-pico: Pass the USBOTG1_PWR pinctrl
>   ARM: dts: imx7d-pico: Pass the Ethernet PHY reset GPIO
>   ARM: dts: imx7d-pico: Extend peripherals support
>   ARM: dts: imx7d-pico-pi: Extend peripherals support
>   ARM: dts: imx7d-pico: Add the imx7d-pico-hobbit variant
> 
> Otavio Salvador (1):
>   ARM: dts: imx7d-pico: Improve WiFi regulator name

Applied all, thanks.

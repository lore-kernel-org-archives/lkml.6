Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0E653C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4385208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+HxZ6Ua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4385208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754448AbeFMElS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 00:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754244AbeFMElR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 00:41:17 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3708120693;
        Wed, 13 Jun 2018 04:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528864876;
        bh=Nb83pzoBu53BHi8YVLtNNV/BRC2jvzPQiiyUAJMdUJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h+HxZ6Ua16JRilkkFtUSMSZjDqv3GYI5m+x38tMr5NFyHukTK4ZOhDueEt+SejPT/
         l9kuLE35DODQZLdLupbEvotcK71Um8FlJ2EQCdRDrnwPMaLklMylgeC9aFS7cKB3X5
         CyW69tnfxxAXyuNXUZjUVVUS6X90lABP5I7Hf8vo=
Date:   Wed, 13 Jun 2018 06:40:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/21] 3.18.113-stable review
Message-ID: <20180613044055.GA32451@kroah.com>
References: <20180612164825.401145490@linuxfoundation.org>
 <5b20444c.1c69fb81.cb5e6.5a8d@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b20444c.1c69fb81.cb5e6.5a8d@mx.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 03:08:12PM -0700, kernelci.org bot wrote:
> stable-rc/linux-3.18.y boot: 52 boots: 28 failed, 18 passed with 1 offline, 5 conflicts (v3.18.112-22-gb0582263e3c9)
> 
> Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-3.18.y/kernel/v3.18.112-22-gb0582263e3c9/
> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.y/kernel/v3.18.112-22-gb0582263e3c9/
> 
> Tree: stable-rc
> Branch: linux-3.18.y
> Git Describe: v3.18.112-22-gb0582263e3c9
> Git Commit: b0582263e3c9810fd887ca92d19cb9ff30a4d9f6
> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> Tested: 24 unique boards, 12 SoC families, 13 builds out of 183
> 
> Boot Regressions Detected:
> 
> arm:
> 
>     bcm2835_defconfig:
>         bcm2835-rpi-b:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
> 
>     davinci_all_defconfig:
>         dm365evm,legacy:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
> 
>     exynos_defconfig:
>         exynos5800-peach-pi:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
> 
>     imx_v6_v7_defconfig:
>         imx6dl-wandboard_dual:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         imx6dl-wandboard_solo:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         imx6q-wandboard:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
> 
>     multi_v7_defconfig:
>         am335x-boneblack:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         armada-xp-openblocks-ax3-4:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         exynos5800-peach-pi:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         imx6dl-wandboard_dual:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         imx6dl-wandboard_solo:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         imx6q-wandboard:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         omap3-beagle:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         omap3-beagle-xm:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         omap4-panda:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         sun4i-a10-cubieboard:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         sun7i-a20-cubietruck:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         tegra124-jetson-tk1:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         tegra20-iris-512:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         tegra30-beaver:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         zynq-zc702:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
> 
>     mvebu_v7_defconfig:
>         armada-xp-openblocks-ax3-4:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
> 
>     omap2plus_defconfig:
>         am335x-boneblack:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         omap3-beagle:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         omap3-beagle-xm:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         omap3-beagle-xm,legacy:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         omap4-panda:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
> 
>     sama5_defconfig:
>         at91-sama5d4ek:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
> 
>     sunxi_defconfig:
>         sun4i-a10-cubieboard:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         sun7i-a20-cubietruck:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
> 
>     tegra_defconfig:
>         tegra124-jetson-tk1:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         tegra20-iris-512:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)
>         tegra30-beaver:
>             lab-baylibre-seattle: new failure (last pass: v3.18.112)

That is a lot of new failures, did the whole lab fail, or is this really
a problem in v3.18.112 here?

thanks,

greg k-h

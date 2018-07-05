Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAE4C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61D024037
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61D024037
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754347AbeGEN0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:26:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52371 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754042AbeGEN02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:26:28 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 54FC020733; Thu,  5 Jul 2018 15:26:26 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 226B2203B4;
        Thu,  5 Jul 2018 15:26:16 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     stable@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH] arm64: dts: marvell: fix CP110 ICU node size
References: <20180705123449.6052-1-miquel.raynal@bootlin.com>
Date:   Thu, 05 Jul 2018 15:26:16 +0200
In-Reply-To: <20180705123449.6052-1-miquel.raynal@bootlin.com> (Miquel
        Raynal's message of "Thu, 5 Jul 2018 14:34:49 +0200")
Message-ID: <87k1q924qv.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,
 
 On jeu., juil. 05 2018, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> commit 2f872ddcdb1e8e2186162616cea4581b8403849d upstream.
>
> ICU size in CP110 is not 0x10 but at least 0x440 bytes long (from the
> specification).
>
> Fixes: 6ef84a827c37 ("arm64: dts: marvell: enable GICP and ICU on Armada 7K/8K")
> Cc: stable@vger.kernel.org # 4.14.x
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

See
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f872ddcdb1e8e2186162616cea4581b8403849d

it is already in the linux kernel.

Gregory

> ---
>
> Backport to 4.14 stable tree: the original patch did not applied
> because of the effort of DT de-duplication that merged two files in one.
>
>
>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 2 +-
>  arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> index 9a7b63cd63a3..7c19f32d0f44 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> @@ -169,7 +169,7 @@
>  
>  			cpm_icu: interrupt-controller@1e0000 {
>  				compatible = "marvell,cp110-icu";
> -				reg = <0x1e0000 0x10>;
> +				reg = <0x1e0000 0x440>;
>  				#interrupt-cells = <3>;
>  				interrupt-controller;
>  				msi-parent = <&gicp>;
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index faf28633a309..150e97a1dfea 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -169,7 +169,7 @@
>  
>  			cps_icu: interrupt-controller@1e0000 {
>  				compatible = "marvell,cp110-icu";
> -				reg = <0x1e0000 0x10>;
> +				reg = <0x1e0000 0x440>;
>  				#interrupt-cells = <3>;
>  				interrupt-controller;
>  				msi-parent = <&gicp>;
> -- 
> 2.14.1
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

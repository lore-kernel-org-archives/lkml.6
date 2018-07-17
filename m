Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C09AECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AFA2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sPJ9H1qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AFA2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbeGQPTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:19:40 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:36841 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729727AbeGQPTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Oht8vdGdMDhgSfTUpfLmlZdsbOF1IkwtcsByLdAq/lY=;
        b=sPJ9H1qwz53QHS4S7o6/vTQ/OTlvqm8X+5nCC9cANJ6FeqibcCN+TjzTFco8KjVXOOM9VoNwdAvuZf5KsG0miT2gMAnJnyF6iIrgCLOoEw0YllcP6BuVW3Fcn2JBItZ7j9sJMHqmb1x6NQVLphEZ26kxVPWBgPVACZhXkbE88rM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ffRFO-0004TX-55; Tue, 17 Jul 2018 16:46:38 +0200
Date:   Tue, 17 Jul 2018 16:46:38 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: vf610: Add ZII SSMB SPU3 board
Message-ID: <20180717144638.GB16320@lunn.ch>
References: <20180717040651.641-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717040651.641-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:06:51PM -0700, Andrey Smirnov wrote:
> Add support for Zodiac Inflight Innovations SSMB SPU3
> board (VF610-based).
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: cphealy@gmail.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                |   3 +-
>  arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 343 ++++++++++++++++++++++
>  2 files changed, 345 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index bea41b129493..e331b2c16539 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -570,7 +570,8 @@ dtb-$(CONFIG_SOC_VF610) += \
>  	vf610m4-cosmic.dtb \
>  	vf610-twr.dtb \
>  	vf610-zii-dev-rev-b.dtb \
> -	vf610-zii-dev-rev-c.dtb
> +	vf610-zii-dev-rev-c.dtb \
> +	vf610-zii-ssmb-spu3.dtb
>  dtb-$(CONFIG_ARCH_MXS) += \
>  	imx23-evk.dtb \
>  	imx23-olinuxino.dtb \
> diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
> new file mode 100644
> index 000000000000..b692117d7839
> --- /dev/null
> +++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
> @@ -0,0 +1,343 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +
> +/*
> + * Device tree file for ZII's SSMB SPU3 board
> + *
> + * SSMB - SPU3 Switch Management Board
> + * SPU - Seat Power Unit

I think this is the first Zodiac board with mutually recursive
acronyms.

Probably a question for Chris: Does SSMB specifically refer to version
3 of the SPU?

   Andrew

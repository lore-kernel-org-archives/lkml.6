Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4125AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08CF20857
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvfvTIlP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08CF20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeICGua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:50:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeICGua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:50:30 -0400
Received: from dragon (unknown [45.56.155.166])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8C672077C;
        Mon,  3 Sep 2018 02:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535941949;
        bh=RNFmeBFRZjwCpnDHQ4EenPy5DlO0eFIZm9DQzXFFtoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UvfvTIlP0MQygyuQ8cN8XZxiZMWVQmXxikP0CEt3ET041SAgElRKwPPxEV/IZ9CXB
         mUWU4rLi13MzKH/i1PHQ7rJsprJYk4YSVOdSkjRVLwsa/w8HcU4iSxrSH16E6fiXW1
         FVe7gQtRDUADTzfrvNxyH8SoLCpRzulgD1t1C8HI=
Date:   Mon, 3 Sep 2018 10:31:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kurt Kanzenbach <kurt@linutronix.de>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ls208xa: add second duart
Message-ID: <20180903023120.GG3850@dragon>
References: <20180830090038.6956-1-kurt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830090038.6956-1-kurt@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks good to me.  @Leo, are you okay with it?

Shawn

On Thu, Aug 30, 2018 at 11:00:38AM +0200, Kurt Kanzenbach wrote:
> The NXP LS208xA SoCs have two dual uarts. Thus, add the second one.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index 8cb78dd99672..547a86ec7cd2 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -22,6 +22,8 @@
>  		crypto = &crypto;
>  		serial0 = &serial0;
>  		serial1 = &serial1;
> +		serial2 = &serial2;
> +		serial3 = &serial3;
>  	};
>  
>  	cpu: cpus {
> @@ -221,6 +223,20 @@
>  			interrupts = <0 32 0x4>; /* Level high type */
>  		};
>  
> +		serial2: serial@21d0500 {
> +			compatible = "fsl,ns16550", "ns16550a";
> +			reg = <0x0 0x21d0500 0x0 0x100>;
> +			clocks = <&clockgen 4 3>;
> +			interrupts = <0 33 0x4>; /* Level high type */
> +		};
> +
> +		serial3: serial@21d0600 {
> +			compatible = "fsl,ns16550", "ns16550a";
> +			reg = <0x0 0x21d0600 0x0 0x100>;
> +			clocks = <&clockgen 4 3>;
> +			interrupts = <0 33 0x4>; /* Level high type */
> +		};
> +
>  		cluster1_core0_watchdog: wdt@c000000 {
>  			compatible = "arm,sp805-wdt", "arm,primecell";
>  			reg = <0x0 0xc000000 0x0 0x1000>;
> -- 
> 2.11.0
> 

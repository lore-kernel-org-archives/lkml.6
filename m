Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbeBBHSl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 02:18:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:36178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751671AbeBBHSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 02:18:30 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB7A21798
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Fri, 2 Feb 2018 15:18:20 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sascha Hauer <kernel@pengutronix.de>, Frank Li <Frank.li@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, Ian Ray <ian.ray@ge.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6q-bx50v3: Enable secure-reg-access
Message-ID: <20180202071819.GE25699@dragon>
References: <20180115160722.17206-1-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115160722.17206-1-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Frank

On Mon, Jan 15, 2018 at 05:07:22PM +0100, Sebastian Reichel wrote:
> From: Peter Senna Tschudin <peter.senna@collabora.com>
> 
> Add secure-reg-access on device tree include file for Bx50 devices
> to enable PMU and hardware counters for perf.
> 
> Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  arch/arm/boot/dts/imx6q-bx50v3.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
> index 86cfd4481e72..ccaaee83e2fa 100644
> --- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
> +++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
> @@ -43,6 +43,13 @@
>  #include "imx6q-ba16.dtsi"
>  
>  / {
> +	soc {
> +		pmu {
> +			compatible = "arm,cortex-a9-pmu";
> +			secure-reg-access;

I'm not sure this could be a board level configuration.  Shouldn't this
property just be added into pmu node in imx6qdl.dtsi?

Shawn

> +		};
> +	};
> +
>  	clocks {
>  		mclk: clock@0 {
>  			compatible = "fixed-clock";
> -- 
> 2.15.1
> 

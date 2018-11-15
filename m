Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF49C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DC72087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DC72087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbeKOTkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:40:12 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49747 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeKOTkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:40:12 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gNE1J-00009s-Rk; Thu, 15 Nov 2018 10:33:05 +0100
Message-ID: <1542274384.4915.4.camel@pengutronix.de>
Subject: Re: [PATCH 1/3] arm64: dts: stratix10: use "altr,stratix10-rst-mgr"
 binding
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinh.nguyen@intel.com>
Date:   Thu, 15 Nov 2018 10:33:04 +0100
In-Reply-To: <20181105200549.17159-1-dinguyen@kernel.org>
References: <20181105200549.17159-1-dinguyen@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinh,

On Mon, 2018-11-05 at 14:05 -0600, Dinh Nguyen wrote:
> From: Dinh Nguyen <dinh.nguyen@intel.com>
> 
> The standard reset-simple driver the uses the "altr,rst-mgr" binding is
> not getting initialized early enough in the boot process, so timers
> that the kernel needs are still left in reset. Thus an early
> reset driver was created. This early reset driver is only for the
> SoCFPGA 32-bit platform.
> 
> The Stratix10 platform does not need any of the timers that in reset to
> boot, thus we don't need to early reset driver. Therefore, use the
> "altr,stratix10-rst-mgr" binding for the reset-simple platform driver on
> the Stratix10 platform.
> 
> Also remove the "altr,modrst-offset" property because the driver no
> longer needs it.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> index 8253a1a9e985..5f0b18ae5007 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> @@ -308,9 +308,8 @@
>  
>  		rst: rstmgr@ffd11000 {
>  			#reset-cells = <1>;
> -			compatible = "altr,rst-mgr";
> +			compatible = "altr,stratix10-rst-mgr", "altr,rst-mgr";
>  			reg = <0xffd11000 0x1000>;
> -			altr,modrst-offset = <0x20>;
>  		};
>  
>  		spi0: spi@ffda4000 {

Do you want me to pick this up as well, or just patches 2 and 3?

regards
Philipp

Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B40BC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA1E2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLvOlA0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA1E2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeILGIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 02:08:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbeILGIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 02:08:17 -0400
Received: from dragon (unknown [104.237.86.3])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD94320866;
        Wed, 12 Sep 2018 01:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536714381;
        bh=nKocfVpaIZhZ7tdjJ6mqqqr5SHUlcrEvrYP0nwWeSwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qLvOlA0QEq7bQvZ+2TAYrga5zZHFO3RquQ7ZkDTpLlfhbdZupg2hCIAPlGwVUL4Ke
         jae5TTr51biJY7IXFm10Rx/G0LqhwvtlqdOxsET/pJkdryGoHV1yBvF0Dmeqq8O9ih
         2HiuMW0qx/CJH6c4+zblVDANEbCfkmOO8pVslaD0=
Date:   Wed, 12 Sep 2018 09:04:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>, linux-imx@nxp.com,
        yibin.gong@nxp.com, "A.s. Dong" <aisheng.dong@nxp.com>
Subject: Re: [PATCH v9 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
Message-ID: <20180912010428.GA28469@dragon>
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802103425.3053-2-o.rempel@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I updated the subject as below to make it clear this is a bindings
change.

  dt-bindings: imx6q-clock: add new fsl,pmic-stby-poweroff property

Patch applied, thanks.

Shawn

On Thu, Aug 02, 2018 at 12:34:20PM +0200, Oleksij Rempel wrote:
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/clock/imx6q-clock.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> index a45ca67a9d5f..e1308346e00d 100644
> --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> @@ -6,6 +6,14 @@ Required properties:
>  - interrupts: Should contain CCM interrupt
>  - #clock-cells: Should be <1>
>  
> +Optional properties:
> +- fsl,pmic-stby-poweroff: Configure CCM to assert PMIC_STBY_REQ signal
> +  on power off.
> +  Use this property if the SoC should be powered off by external power
> +  management IC (PMIC) triggered via PMIC_STBY_REQ signal.
> +  Boards that are designed to initiate poweroff on PMIC_ON_REQ signal should
> +  be using "syscon-poweroff" driver instead.
> +
>  The clock consumer should specify the desired clock by having the clock
>  ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx6qdl-clock.h
>  for the full list of i.MX6 Quad and DualLite clock IDs.
> -- 
> 2.18.0
> 

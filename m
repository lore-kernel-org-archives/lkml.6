Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145F7C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA1720882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA1720882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeINAWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:22:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52637 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbeINAWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:22:52 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 76399208AC; Thu, 13 Sep 2018 21:12:00 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 40D7620877;
        Thu, 13 Sep 2018 21:11:50 +0200 (CEST)
Date:   Thu, 13 Sep 2018 21:11:50 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 2/5] dt-binding: rtc-pcf85063: add quartz load property
Message-ID: <20180913191150.GH14988@piout.net>
References: <20180822183555.GA24084@ravnborg.org>
 <20180907193508.24974-3-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907193508.24974-3-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You can remove 'rtc-' from the part name in the subject.

On 07/09/2018 21:35:05+0200, Sam Ravnborg wrote:
> From: Søren Andersen <san@skov.dk>
> 
> The NXP pcf85063 support two different quartz loads.
> - 7 pF (default)
> - 12.5 pF (minimum power consumption)
> 
> The pcf85063 needs to know the size of the external capacitor,
> otherwise the RTC will have a bad precision (hours/week).
> 
> The power-on default is 7 pF
> Add a property that tells if the external capacitor is 12.5 pF
> 
> Signed-off-by: Søren Andersen <san@skov.dk>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  .../devicetree/bindings/rtc/nxp,pcf85063.txt          | 19 +++++++++++++++++++
>  Documentation/devicetree/bindings/trivial-devices.txt |  1 -
>  2 files changed, 19 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
> new file mode 100644
> index 000000000000..22ebb2ce52c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
> @@ -0,0 +1,19 @@
> +* NXP PCF85063 Real Time Clock
> +
> +NXP PCF85063 Real Time Clock
> +
> +Required properties:
> +- compatible: Should contain "nxp,pcf85063".
> +- reg: I2C address for chip.
> +
> +Optional property:
> +- nxp,quartz_load_12.5pF: The capacitive load on the quartz is 12.5 pF,
> +  which differ from the default value of 7 pF
> +
> +Example:
> +
> +pcf85063: pcf85063@51 {
> +	compatible = "nxp,pcf85063";
> +	reg = <0x51>;
> +	nxp,quartz_load_12.5pF;

Same comment as the previous patch, a value in fF is more useful. It
could also probably be made a generic rtc property.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

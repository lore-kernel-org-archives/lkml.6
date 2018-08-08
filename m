Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AD8C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9ED21B31
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jkYNhc8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9ED21B31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbeHIBUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 21:20:37 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:40548 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbeHIBUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 21:20:36 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 23BF0CD;
        Thu,  9 Aug 2018 00:58:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533769125;
        bh=WRWMJU+hNit+bQp/IIrsn7VuyK7h9q3bI8x/RShFECY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jkYNhc8ZMn7j6VyTnQj8Nf8+aya3Lo3mrmdpXVVQ/++UEQ4sfbPUBTSbkl6STCY0N
         ui1ttEflaDwBBJvjwZjKw8JH8y/PqlpwjvdFiMQjOMOKSrEabZ0OWYIz0b7Ad9tNRA
         vsBjP3AukVFyQ8NfAI9k8RWIpkBrjj8WWV1gw12A=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     mchehab@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: media: adv748x: Document secondary addresses
Date:   Thu, 09 Aug 2018 01:59:29 +0300
Message-ID: <4299631.dFueHHkrC4@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180808173128.6400-1-kieran.bingham@ideasonboard.com>
References: <20180808173128.6400-1-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Wednesday, 8 August 2018 20:31:28 EEST Kieran Bingham wrote:
> The ADV748x supports configurable slave addresses for its I2C pages.
> Document the page names, and example for setting each of the pages
> excplicitly.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> ---
>  .../devicetree/bindings/media/i2c/adv748x.txt          | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/adv748x.txt
> b/Documentation/devicetree/bindings/media/i2c/adv748x.txt index
> 21ffb5ed8183..9515d8ad0e31 100644
> --- a/Documentation/devicetree/bindings/media/i2c/adv748x.txt
> +++ b/Documentation/devicetree/bindings/media/i2c/adv748x.txt
> @@ -18,6 +18,11 @@ Optional Properties:
>  		     "intrq3". All interrupts are optional. The "intrq3" interrupt
>  		     is only available on the adv7481
>    - interrupts: Specify the interrupt lines for the ADV748x
> +  - reg-names : Names of maps with programmable addresses.
> +		It can contain any map needed a non-default address.

s/can contain any map needed/shall contain all maps needing/

> +		Possible map names are:
> +		  "main", "dpll", "cp", "hdmi", "edid", "repeater",
> +		  "infoframe", "cbus", "cec", "sdp", "txa", "txb"

Should you also update the description of the reg property, possibly with the 
same text as the adv7604 bindings ?

>  The device node must contain one 'port' child node per device input and
> output port, in accordance with the video interface bindings defined in
> @@ -47,7 +52,10 @@ Example:
> 
>  	video-receiver@70 {
>  		compatible = "adi,adv7482";
> -		reg = <0x70>;
> +		reg = <0x70 0x71 0x72 0x73 0x74 0x75
> +		       0x60 0x61 0x62 0x63 0x64 0x65>;
> +		reg-names = "main", "dpll", "cp", "hdmi", "edid", "repeater",
> +			    "infoframe", "cbus", "cec", "sdp", "txa", "txb";
> 
>  		#address-cells = <1>;
>  		#size-cells = <0>;

-- 
Regards,

Laurent Pinchart




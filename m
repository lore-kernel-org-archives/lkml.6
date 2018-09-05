Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C278C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4465A2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JOV1Z2cQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4465A2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeIELgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:36:05 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:52710 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeIELgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:36:05 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:4407:cd00:1953:677d:5909:a7be])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CABDE994;
        Wed,  5 Sep 2018 09:07:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536131238;
        bh=+QNzEIFgK58HIZLrPi2ND9EqMX5Qc8LpXR8HYm8sZCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JOV1Z2cQPjP93JAqZbjpIW4cH43XsZbDmDZlodYzv1HnH4m74Ge8FQSwkouhBwW4e
         Rd0SVUpwh6nKq4ZoC4EXpMsZMtNojmUYunZ78/sZVTsV2OOAb4paiub0K1/cD7nKZo
         56X2lO4x8SIOdyfoXj4Vgn/UVBjUJIuSj4AsqJX4=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     linus.walleij@linaro.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        p.zabel@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, architt@codeaurora.org,
        a.hajda@samsung.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: display: add data-enable polarity property
Date:   Wed, 05 Sep 2018 10:07:24 +0300
Message-ID: <139651706.L0sBFfZMDQ@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180905052113.21262-3-stefan@agner.ch>
References: <20180905052113.21262-1-stefan@agner.ch> <20180905052113.21262-3-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Thank you for the patch.

On Wednesday, 5 September 2018 08:21:10 EEST Stefan Agner wrote:
> Allow to specify the data-enable polarity required by a dumb VGA
> DAC converting parallel RGB to VGA.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  .../devicetree/bindings/display/bridge/dumb-vga-dac.txt          | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt index
> 164cbb15f04c..adbd2ca0af2f 100644
> --- a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> @@ -18,6 +18,7 @@ graph bindings specified in
> Documentation/devicetree/bindings/graph.txt.
> 
>  Optional properties:
>  - vdd-supply: Power supply for DAC
> +- de-active: data-enable pulse is active low/high/ignored

Which value corresponds to low, high and ignored ?

>  Example
>  -------

-- 
Regards,

Laurent Pinchart




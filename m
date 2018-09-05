Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A40C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89712073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Pcn9QpmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89712073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeIFBWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:22:16 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33754 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeIFBWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:22:16 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:4407:cd00:1953:677d:5909:a7be])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3504E119E;
        Wed,  5 Sep 2018 22:50:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536180619;
        bh=7rbWdbWTKex0+qtSwIK+amJ0MYKJoWEGQNQ64UinKq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pcn9QpmYPjmvIO549mCTBOcKr0mTs825e9DvcH256X8W0wL1xJ5f3KIiFH1uoyeK7
         cWVL5GmAhT1HTv3BFMVciUDc9EHuJUhHVw4TEzQ2RrmhABRpxYRU2dG1ePhBukZjbn
         ZGqNPWt0fZw8lleqZrxX0pgNfpczgoYqs8KtYD9I=
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
Date:   Wed, 05 Sep 2018 23:50:25 +0300
Message-ID: <6830776.vZAoroGVFQ@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <e708c5bac502e60a2eeb685fddf67042@agner.ch>
References: <20180905052113.21262-1-stefan@agner.ch> <139651706.L0sBFfZMDQ@avalon> <e708c5bac502e60a2eeb685fddf67042@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Wednesday, 5 September 2018 21:10:08 EEST Stefan Agner wrote:
> On 05.09.2018 00:07, Laurent Pinchart wrote:
> > On Wednesday, 5 September 2018 08:21:10 EEST Stefan Agner wrote:
> >> Allow to specify the data-enable polarity required by a dumb VGA
> >> DAC converting parallel RGB to VGA.
> >> 
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> ---
> >> 
> >>  .../devicetree/bindings/display/bridge/dumb-vga-dac.txt          | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git
> >> a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> >> b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt index
> >> 164cbb15f04c..adbd2ca0af2f 100644
> >> --- a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> >> +++ b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> >> @@ -18,6 +18,7 @@ graph bindings specified in
> >> Documentation/devicetree/bindings/graph.txt.
> >> 
> >>  Optional properties:
> >>  - vdd-supply: Power supply for DAC
> >> 
> >> +- de-active: data-enable pulse is active low/high/ignored
> > 
> > Which value corresponds to low, high and ignored ?
> 
> The wording is taken from
> Documentation/devicetree/bindings/display/panel/display-timing.txt. But
> I agree, not very useful.
> 
> 0 is low active, 1 is high active, and none is using driver defaults.
> 
> How about:
> - de-active: data-enable pulse is 0=active low/1=active high

The data enable signal isn't really a pulse. I would word this as

- de-active: Polarity of the data enable signal. 0 for active low, 1 for 
active high, unset for system-specific defaults.

> >>  Example
> >>  -------

-- 
Regards,

Laurent Pinchart




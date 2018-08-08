Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF200C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DDE219F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hxFYMiOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DDE219F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbeHHS4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:56:04 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33398 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHS4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:56:04 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3D2F3CE;
        Wed,  8 Aug 2018 18:35:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533746133;
        bh=ue830gXXK5yGcmxoEDhcQ3BLtQZ5vrFDhyWlny+uvlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxFYMiOnhxKO5HlbfHm2+/riOzqsGiSQRKjCXa5shJTmTlxoQhec7mF/Vsj9EHaR5
         iOeUBsD4RgLaVLE2UAa+OnTpq5DHs0YQvVvpbxufJCQK1kMRIju6K/O86nNhQWA9zZ
         fML0DSdKIk4TqEyps/3sIIU5Gq2WOIq1WSYlRX1U=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     mchehab@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Subject: Re: [PATCH v2] dt-bindings: media: adv7604: Fix slave map documentation
Date:   Wed, 08 Aug 2018 19:36:16 +0300
Message-ID: <80734187.pp6Fhz4Hl4@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180808163351.28852-1-kieran.bingham@ideasonboard.com>
References: <20180808163351.28852-1-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Wednesday, 8 August 2018 19:33:51 EEST Kieran Bingham wrote:
> The reg-names property in the documentation is missing an '='. Add it.
> 
> Fixes: 9feb786876c7 ("media: dt-bindings: media: adv7604: Extend
> bindings to allow specifying slave map addresses")
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v2:
>  - Commit title changed to prefix as "dt-bindings: media:"
> 
> If this is collected through a DT tree, I assume therefore this will be
> fine, but if it is to go through the media-tree, please update as
> necessaary to prevent the redundant dual "media:" tagging.

I assume Hans will take the patch in his tree and submit a pull request. 
Mauro, this will then require special handling to avoid a rewrite of the 
subject.

> (I'll leave it to the maintainers to decide whose tree thise should go
> through)
> 
> Thanks
> 
> Kieran
> 
>  Documentation/devicetree/bindings/media/i2c/adv7604.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/adv7604.txt
> b/Documentation/devicetree/bindings/media/i2c/adv7604.txt index
> dcf57e7c60eb..b3e688b77a38 100644
> --- a/Documentation/devicetree/bindings/media/i2c/adv7604.txt
> +++ b/Documentation/devicetree/bindings/media/i2c/adv7604.txt
> @@ -66,7 +66,7 @@ Example:
>  		 * other maps will retain their default addresses.
>  		 */
>  		reg = <0x4c>, <0x66>;
> -		reg-names "main", "edid";
> +		reg-names = "main", "edid";
> 
>  		reset-gpios = <&ioexp 0 GPIO_ACTIVE_LOW>;
>  		hpd-gpios = <&ioexp 2 GPIO_ACTIVE_HIGH>;

-- 
Regards,

Laurent Pinchart




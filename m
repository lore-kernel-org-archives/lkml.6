Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16202C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE783217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OitbcZja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfAVUyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:54:52 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:55460 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfAVUyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:54:51 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8B9EB575;
        Tue, 22 Jan 2019 21:54:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1548190489;
        bh=F7NCVLDxfErDktuJUauv9GjVjEkRl8qS4a2LDtd+6MQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OitbcZja4OgZuMbjKArI4pE4M7VmQ4TPzMPTGesJprJl5hj31l5KRq/xfvcIvH0X8
         Y3o5iw009szRxDHqegdbDJ555DJO3BOLO2mnrPukeRr7nKImM1nkAW64HR+dqYB25t
         uf4F8O++aJHvw8P3gi4GcKQgQtWjcsUeKXUc1UcM=
Date:   Tue, 22 Jan 2019 22:54:49 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] dt-bindings: display: bridge: thc63lvdm83d: use
 standard powerdown-gpios
Message-ID: <20190122205449.GG3264@pendragon.ideasonboard.com>
References: <20181229070649.21308-1-peda@axentia.se>
 <20181229070649.21308-4-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181229070649.21308-4-peda@axentia.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch.

On Sat, Dec 29, 2018 at 07:07:31AM +0000, Peter Rosin wrote:
> The name powerdown-gpios is the standard property name for the
> functionality covered by the previous pwdn-gpios name. This rename
> should be safe to do since the linux driver supporting the binding
> (lvds-encoder.c) never implemented the property, and no dts file
> names it. At least not upstream.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/display/bridge/thine,thc63lvdm83d.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvdm83d.txt b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvdm83d.txt
> index 527e236e9a2a..fee3c88e1a17 100644
> --- a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvdm83d.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvdm83d.txt
> @@ -10,7 +10,7 @@ Required properties:
>  
>  Optional properties:
>  
> -- pwdn-gpios: Power down control GPIO
> +- powerdown-gpios: Power down control GPIO (the /PWDN pin, active low).
>  
>  Required nodes:
>  

-- 
Regards,

Laurent Pinchart

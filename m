Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839CBC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CF921916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="uhA0U1r5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfBHBGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:06:17 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:59418 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfBHBGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 20:06:17 -0500
Received: from pendragon.ideasonboard.com (d51A4137F.access.telenet.be [81.164.19.127])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3A074F9;
        Fri,  8 Feb 2019 02:06:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1549587975;
        bh=/fuGl1ZLH005u96LAPwZPs3oaqvoVAVa3QFpmSQ9/dQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uhA0U1r5fj9W5H9f0B3lFUPDzR0Kvnm2YpDCHj08gLOvkCJJApfrjfEujXuSHHRr4
         uSP7wAYNM1di14KabWeFW6v5HMhQd8q1DN798H9LGxze2NXtMApExYW5XaKNXWp8/p
         5IUk7II48GtaXYd+w7BdAjlwngYOgUKrvihq1zNo=
Date:   Fri, 8 Feb 2019 03:06:13 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     tomi.valkeinen@ti.com, airlied@linux.ie, daniel@ffwll.ch,
        sre@kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH v2 2/2] dt-bindings: panel: td028ttec1: add backlight
 property
Message-ID: <20190208010613.GJ10386@pendragon.ideasonboard.com>
References: <20190205063813.14873-1-andreas@kemnade.info>
 <20190205063813.14873-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190205063813.14873-3-andreas@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

Thank you for the patch.

On Tue, Feb 05, 2019 at 07:38:13AM +0100, Andreas Kemnade wrote:
> This adds an additional backlight property as described
> in panel-common.txt
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
> index ed34253d9fb1..898e06ecf4ef 100644
> --- a/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
> +++ b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
> @@ -6,6 +6,7 @@ Required properties:
>  
>  Optional properties:
>  - label: a symbolic name for the panel
> +- backlight: phandle of the backlight device
>  
>  Required nodes:
>  - Video port for DPI input
> @@ -21,6 +22,7 @@ lcd-panel: td028ttec1@0 {
>  	spi-cpha;
>  
>  	label = "lcd";
> +	backlight = <&backlight>;
>  	port {
>  		lcd_in: endpoint {
>  			remote-endpoint = <&dpi_out>;

-- 
Regards,

Laurent Pinchart

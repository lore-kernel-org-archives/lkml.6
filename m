Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED9CC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438B820652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="deBS9lm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438B820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeJBSLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:11:35 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41126 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbeJBSLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:11:35 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 78AC2B7F;
        Tue,  2 Oct 2018 13:28:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1538479724;
        bh=wuj6Nk8NNwxAN45cqnjPXlVW6qEV9jnt5CBHbbmmwys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=deBS9lm6SLhPNQWsk7PLA/2pwHaziBJe358Bdod+uUtSdnMWp7f5svB2Kwo0EpRTx
         SV4KxIzdEN4VCmeNb4hV5vsLyfC9TmqTgrbtfepMhDtm4ut4+7w5OCOZFUWfKu244W
         OITkWFiLlJQivxrgjCinXzA8u9ZFEEarw8NeQlOs=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/6] [media] ad5820: DT new optional field enable-gpios
Date:   Tue, 02 Oct 2018 14:29:01 +0300
Message-ID: <3235299.fxFho4aFbc@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181002111356.32298-1-ricardo.ribalda@gmail.com>
References: <20181002111356.32298-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Tuesday, 2 October 2018 14:13:56 EEST Ricardo Ribalda Delgado wrote:
> Document new enable-gpio field. It can be used to disable the part
> without turning down its regulator.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/media/i2c/ad5820.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> b/Documentation/devicetree/bindings/media/i2c/ad5820.txt index
> 5940ca11c021..db596e8eb0ba 100644
> --- a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> +++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> @@ -8,6 +8,11 @@ Required Properties:
> 
>    - VANA-supply: supply of voltage for VANA pin
> 
> +Optional properties:
> +
> +   - enable-gpios : GPIO spec for the XSHUTDOWN pin. The XSHUTDOWN signal
> is +active low, a high level on the pin enables the device.
> +
>  Example:
> 
>         ad5820: coil@c {
> @@ -15,5 +20,6 @@ Example:
>                 reg = <0x0c>;
> 
>                 VANA-supply = <&vaux4>;
> +               enable-gpios = <&msmgpio 26 GPIO_ACTIVE_HIGH>;
>         };


-- 
Regards,

Laurent Pinchart




Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71294C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363D7204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JU1grm4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363D7204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeJBRSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:18:02 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:40578 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeJBRSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:18:02 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DF132B7F;
        Tue,  2 Oct 2018 12:35:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1538476524;
        bh=IZN+3gQsIx56O1lSz697WLU1W7a7Ptv7AhwLzSp59AM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JU1grm4ZaTOwO/mNyhwe1Kwa5z0C7XlmdtsBw4XzLCSLkhXJWe+JqdNNiWa4nJXxW
         ZYsZIsDCAdYo5TIqRJvCBz75rUyh0PjCcxo6WsgtfCnO5Bx6qRlmgEc0pljm8g8MDS
         pTmUWtGVUJuPKEXfbL0PrpT7X/BmvFPw1nwZnXQA=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/6] [media] ad5820: DT new optional field enable-gpios
Date:   Tue, 02 Oct 2018 13:35:40 +0300
Message-ID: <2128166.ZAkUExjJHM@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181002073222.11368-2-ricardo.ribalda@gmail.com>
References: <20181002073222.11368-1-ricardo.ribalda@gmail.com> <20181002073222.11368-2-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Tuesday, 2 October 2018 10:32:18 EEST Ricardo Ribalda Delgado wrote:
> Document new enable-gpio field. It can be used to disable the part
> without turning down its regulator.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
>  Documentation/devicetree/bindings/media/i2c/ad5820.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> b/Documentation/devicetree/bindings/media/i2c/ad5820.txt index
> 5940ca11c021..9ccd96d3d5f0 100644
> --- a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> +++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> @@ -8,6 +8,12 @@ Required Properties:
> 
>    - VANA-supply: supply of voltage for VANA pin
> 
> +Optional properties:
> +
> +   - enable-gpios : GPIO spec for the XSHUTDOWN pin. Note that the polarity
> of +the enable GPIO is the opposite of the XSHUTDOWN pin (asserting the
> enable +GPIO deasserts the XSHUTDOWN signal and vice versa).

After reading this one more time, I think the text is at the very least 
confusing. The logic level of the enable GPIO is the same as the logic level 
of the XSHUTDOWN pin. The latter being active low, asserting "enable" will 
deassert "shutdown", but talking about "desserting XSHUTDOWN" is confusing.

>  Example:
> 
>         ad5820: coil@c {
> @@ -15,5 +21,6 @@ Example:
>                 reg = <0x0c>;
> 
>                 VANA-supply = <&vaux4>;
> +               enable-gpios = <&msmgpio 26 GPIO_ACTIVE_HIGH>;
>         };


-- 
Regards,

Laurent Pinchart




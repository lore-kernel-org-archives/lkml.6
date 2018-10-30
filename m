Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFECC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17242081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="Akt2Di3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17242081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fpond.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbeJ3MoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 08:44:12 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:35439 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeJ3MoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 08:44:12 -0400
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Oct 2018 08:44:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1540871546;
        s=strato-dkim-0002; d=fpond.eu;
        h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=BEgiISacGBCIrmbEEWjTFnue6l8ZC4GZMmnBlkG7Icc=;
        b=Akt2Di3saE/h+U5XzgzeezqYoX9/HhajdZHVMlKyiqcHzxR0braIEbYAlIczhPhXH1
        0jzdhypKWq1Zra+6vlfp+V4poorDFQjzjPcwSFya4y90MuCjmMsF1nd1FfFc3BcEiGFm
        2ILKiEziuuU/knU2mmZCtov6UPIW7IyYCEdyV1AhPzhFhLn6aM/VRkY//tV/jh0XnPYY
        BZQUcW8PmVU7+JUX8rb0gNRX91iOfJOThhY/+vn1f1Ll4LZB8RsY51XlnBmWFKQAH3jY
        lON23ryYBigkPpEFD+Sx0PGXtPX8gX3eZsvGAF+yUUzniXcM2eJk3kp6ZIAjMlE3pctl
        s1Qw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from null
        by smtp-ox.front (RZmta 44.3 AUTH)
        with ESMTPSA id 20819cu9U3kRxs5
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 30 Oct 2018 04:46:27 +0100 (CET)
Date:   Tue, 30 Oct 2018 04:46:26 +0100 (CET)
From:   Ulrich Hecht <uli@fpond.eu>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>, geert+renesas@glider.be,
        laurent.pinchart@ideasonboard.com, horms@verge.net.au
Cc:     linus.walleij@linaro.org, linux-renesas-soc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1822236810.335136.1540871186977@webmail.strato.com>
In-Reply-To: <1540836824-4636-2-git-send-email-jacopo+renesas@jmondi.org>
References: <1540836824-4636-1-git-send-email-jacopo+renesas@jmondi.org>
 <1540836824-4636-2-git-send-email-jacopo+renesas@jmondi.org>
Subject: Re: [PATCH 1/2] pinctrl: sh-pfc: Introduce VIN_DATA_PIN_GROUP_VER
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev45
X-Originating-Client: open-xchange-appsuite
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On October 29, 2018 at 7:13 PM Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> 
> 
> VIN data groups may appear on different sets of pins, usually named
> "vinX_data_[a|b]". The existing VIN_DATA_PIN_GROUP() does not support appending
> the 'a' or 'b' suffix, leading to the definition of groups names not consistent
> with the ones defined using SH_PFC_PIN_GROUP() macro.
> 
> Fix this by adding a macro that supports appending suffixes when required.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  drivers/pinctrl/sh-pfc/sh_pfc.h | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
> index 458ae0a..2930e9a 100644
> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -54,17 +54,27 @@ struct sh_pfc_pin_group {
>  
>  /*
>   * Using union vin_data saves memory occupied by the VIN data pins.
> - * VIN_DATA_PIN_GROUP() is  a macro  used  to describe the VIN pin groups
> - * in this case.
> + *
> + * VIN_DATA_PIN_GROUP() is  a macro  used  to describe the VIN pin groups,

Maybe fix the odd spacing, while you're at it?

> + * while VIN_DATA_PIN_GROUP_VER() is used when the same pin group can appear
> + * on different sets of pins.
>   */
> -#define VIN_DATA_PIN_GROUP(n, s)				\
> -	{							\
> -		.name = #n#s,					\
> +#define __VIN_DATA_PIN_GROUP(n, s)				\
>  		.pins = n##_pins.data##s,			\
>  		.mux = n##_mux.data##s,				\
>  		.nr_pins = ARRAY_SIZE(n##_pins.data##s),	\
>  	}
>  
> +#define VIN_DATA_PIN_GROUP(n, s)				\
> +	{							\
> +		.name = #n#s,					\
> +		__VIN_DATA_PIN_GROUP(n, s)
> +
> +#define VIN_DATA_PIN_GROUP_VER(n, v, s)				\
> +	{							\
> +		.name = #n#s"_"#v,				\
> +		__VIN_DATA_PIN_GROUP(n##_##v, s)
> +
>  union vin_data {
>  	unsigned int data24[24];
>  	unsigned int data20[20];
> -- 
> 2.7.4
>

With or without the whitespace fix:

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli

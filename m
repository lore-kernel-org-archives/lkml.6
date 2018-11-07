Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B662C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C2320862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj8691yP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C2320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbeKHELh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:11:37 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38667 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeKHELh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:11:37 -0500
Received: by mail-pl1-f195.google.com with SMTP id p4-v6so5859834plo.5;
        Wed, 07 Nov 2018 10:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3tYg3L3iX9vnDr3Hcweo1P7+NX3L80cpvnFpMnYM21g=;
        b=Lj8691yPXrlTzy7Dq5opf2cqVVxvqdTjkqpzf+4dDUwGbGeYB3DdN9cGQ3ju4OH/9E
         lCB2KqY1dK/Yv5XmGnu5Bm1WXaQo+68FN4o2CWdbUIlpZEjDTdgyqhX2kCYyZHPKlWis
         OcuKjkqj9C5Zr9X9218xmOlFyhgzarHeG+A+Qy89pzNzv4fKAp44dCQG+dK0GwbbHc1+
         B6UWuorp8nOf4SDag9PfL+PaikSdzZaFtEp/vFXxfmA3Dz+qLC5/sA8gGzj3AhgOtE9t
         wjmZ/1NwRzzBUnP2lM4ekSoOGVvLqsI1fickUHY3DORiXRT9C0MQ1PnJTjfk0A+Z4d9m
         AfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3tYg3L3iX9vnDr3Hcweo1P7+NX3L80cpvnFpMnYM21g=;
        b=RgCeCOHKE8v+7ZZQgQRbX9KzDuLGPYOi3HXv7LgnYm1JTmbQ6Ua1NrnTxdqfMhz75k
         jnep5sGoRWfEtksOCQAVhdWlqPHcUaPFW1lYKFTc8YXfnN8ZWIVBrhn39QNpl5B+91Q6
         LjC8EQk2692wXV1FsxcddUPncbkLoiHX5ifuhgx1gsnBM0CoH2017nd9otlc01S2iCqq
         m/1pe0y0aQkVxQIZpSFaxjYveT/TwO7YRt1h434077uE/bsTR2OrasiQJMYFC0HlnDGJ
         T08YuuqxHJh0DjK5iNsQ/qgVG/OGHCsNw85AOfDa5MHFTqgGors7AasNybTgAqylr7Mz
         qyjQ==
X-Gm-Message-State: AGRZ1gLEMqcgpjBhRkuBEv9CMKyePm8eUWCBsQoLe95V1IrLCBMsOEJw
        CWw/FAWnUx0RFS5/X4imjCc=
X-Google-Smtp-Source: AJdET5cQ7jjYXXffDSJARuegSymHoLQIdtkPw3rqW+r5M0g3fJTAhT3m5iRflWyW7PITgWMiHn+FWw==
X-Received: by 2002:a17:902:d907:: with SMTP id c7-v6mr1325614plz.198.1541616000391;
        Wed, 07 Nov 2018 10:40:00 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r1-v6sm1893138pfb.41.2018.11.07.10.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 10:39:59 -0800 (PST)
Date:   Wed, 7 Nov 2018 10:39:58 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@bq.com>
Subject: Re: [PATCH] dt-bindings: hwmon: tmp108: add optional interrupts and
 #thermal-sensor-cells
Message-ID: <20181107183958.GB5468@roeck-us.net>
References: <20181107154708.422-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107154708.422-1-heiko@sntech.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 07, 2018 at 04:47:08PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
> 
> The tmp108 does have an alert output that can be used as interrupt source
> and can of course also be used as part of a thermal sensor setup for things
> like thermal-based cpu frequencies, so document the necessary properties.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>

Do you also plan to actually implement interrupt support in the driver ?

Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/tmp108.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/tmp108.txt b/Documentation/devicetree/bindings/hwmon/tmp108.txt
> index 8c4b10df86d9..54d4beed4ee5 100644
> --- a/Documentation/devicetree/bindings/hwmon/tmp108.txt
> +++ b/Documentation/devicetree/bindings/hwmon/tmp108.txt
> @@ -7,6 +7,10 @@ Requires node properties:
>  - compatible : "ti,tmp108"
>  - reg : the I2C address of the device. This is 0x48, 0x49, 0x4a, or 0x4b.
>  
> +Optional properties:
> +- interrupts: Reference to the TMP108 alert interrupt.
> +- #thermal-sensor-cells: should be set to 0.
> +
>  Example:
>  	tmp108@48 {
>  		compatible = "ti,tmp108";
> -- 
> 2.18.0
> 

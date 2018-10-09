Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F3EC67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B5821476
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nktb3K9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B5821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeJIH16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:27:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42596 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIH15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:27:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id g15-v6so19955111wru.9;
        Mon, 08 Oct 2018 17:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0PYuaQLJaO6FuIXLpMxYe5HoEMMLtIDZXjmewcX9kYI=;
        b=Nktb3K9OIcd4n0HbDeYK4zEVwst2JD9GHLZ2zvc3SZdlIDhxY9pl5K9LuWdeyFy+Ft
         H8QGfSFX7Xs5W46V0b72VxTAKojE7/8eernL8LmBU+8vfzM7WzWLF2sJmKxEuVLd9zjw
         zolI0N4p/3bDrALJ5AhjlNGLBKnnDiX+3UHEjI1zQ9XKE8deAszVqf2cdpU01gMN8n7x
         UbH5Bmnkoj8xOAPRfKvtJa3GvoRrrDfecd7Fu9Lt9HU06euQXRM5I/KUuIKhVMfvLHN8
         zsqVfm+9Z2AxNbPuBV6yBJdCLaicfxzuPxPpUe8g9My0J6U5TWFEFsdDs0axkzEL6wm8
         3Msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0PYuaQLJaO6FuIXLpMxYe5HoEMMLtIDZXjmewcX9kYI=;
        b=XEjDk0ONpSUbJUPLEbekwbtEDd4xsanOwQcGihSGV6cHao0/ok6lJEancfpBVoqTEC
         Wo33pbvPkyuYKyhQLlnaRaKPkwES2idc6lU4TmW9QatqEv+F09+2SuLzHchKhML0E+j3
         DUXGqIvyzk/Q1e/TFppmgdl6L2BddYtP1OfpB/MxhTLmnhQXIu81/z/QDqfbDuSfglzH
         O7WP9hr45zgS9aTED7tLLqjHu94fUG0o8YTV6CCcszcNGv5bYZ+if35qkwGFspxJln9c
         7cJLFkra63J37ty9oPrz4SdBThSfSZH1uxIE4PX8NJgK9c+/dvBKcV6p87MBgav6abcZ
         Wg5g==
X-Gm-Message-State: ABuFfohW+XtxP5zWJmGrfHo18ekzJX4lZbcsmGK3K0+7BLaQ8l83Afl7
        LwlwvX1yOEVD10jkZkbw3E0=
X-Google-Smtp-Source: ACcGV63x8ioLSwf6vDsvzkct5JpYLst3MGlnk3DKEZ0oVNtFAHUYlTq2mg4zF4Mkl/O4avwfWsbP+g==
X-Received: by 2002:adf:e512:: with SMTP id j18-v6mr17557063wrm.111.1539044020195;
        Mon, 08 Oct 2018 17:13:40 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-30-92.net.upcbroadband.cz. [86.49.30.92])
        by smtp.gmail.com with ESMTPSA id p8sm17672451wrx.9.2018.10.08.17.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 17:13:39 -0700 (PDT)
Subject: Re: [PATCH 1/7] dt-bindings: mfd: ds90ux9xx: add description of TI
 DS90Ux9xx ICs
To:     Vladimir Zapolskiy <vz@mleia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sandeep Jain <Sandeep_Jain@mentor.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
References: <20181008211205.2900-1-vz@mleia.com>
 <20181008211205.2900-2-vz@mleia.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <5631ac17-a1c1-af12-8b30-314880af42df@gmail.com>
Date:   Tue, 9 Oct 2018 02:13:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181008211205.2900-2-vz@mleia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2018 11:11 PM, Vladimir Zapolskiy wrote:
> From: Sandeep Jain <Sandeep_Jain@mentor.com>
> 
> The change adds device tree binding description of TI DS90Ux9xx
> series of serializer and deserializer controllers which support video,
> audio and control data transmission over FPD-III Link connection.
> 
> Signed-off-by: Sandeep Jain <Sandeep_Jain@mentor.com>
> [vzapolskiy: various updates and corrections of secondary importance]
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
>  .../devicetree/bindings/mfd/ti,ds90ux9xx.txt  | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,ds90ux9xx.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,ds90ux9xx.txt b/Documentation/devicetree/bindings/mfd/ti,ds90ux9xx.txt
> new file mode 100644
> index 000000000000..0733da88f7ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,ds90ux9xx.txt
> @@ -0,0 +1,66 @@
> +Texas Instruments DS90Ux9xx de-/serializer controllers
> +
> +Required properties:
> +- compatible: Must contain a generic "ti,ds90ux9xx" value and
> +	may contain one more specific value from the list:
> +	"ti,ds90ub925q",
> +	"ti,ds90uh925q",
> +	"ti,ds90ub927q",
> +	"ti,ds90uh927q",
> +	"ti,ds90ub926q",
> +	"ti,ds90uh926q",

Keep the list sorted.

> +	"ti,ds90ub928q",
> +	"ti,ds90uh928q",
> +	"ti,ds90ub940q",
> +	"ti,ds90uh940q".
> +
> +Optional properties:
> +- reg : Specifies the I2C slave address of a local de-/serializer.
> +- power-gpios : GPIO line to control supplied power to the device.

Shouldn't this be regulator phandle ?

> +- ti,backward-compatible-mode : Overrides backward compatibility mode.
> +	Possible values are "<1>" or "<0>".

Make this bool , ie. present or not.

> +	If "ti,backward-compatible-mode" is not mentioned, the backward
> +	compatibility mode is not touched and given by hardware pin strapping.
> +- ti,low-frequency-mode : Overrides low frequency mode.
> +	Possible values are "<1>" or "<0>".
> +	If "ti,low-frequency-mode" is not mentioned, the low frequency mode
> +	is not touched and given by hardware pin strapping.
> +- ti,video-map-select-msb: Sets video bridge pins to MSB mode, if it is set
> +	MAPSEL pin value is ignored.
> +- ti,video-map-select-lsb: Sets video bridge pins to LSB mode, if it is set
> +	MAPSEL pin value is ignored.

This needs some additional explanation, what's this about ?

> +- ti,pixel-clock-edge : Selects Pixel Clock Edge.
> +	Possible values are "<1>" or "<0>".
> +	If "ti,pixel-clock-edge" is High <1>, output data is strobed on the
> +	Rising edge of the PCLK. If ti,pixel-clock-edge is Low <0>, data is
> +	strobed on the Falling edge of the PCLK.
> +	If "ti,pixel-clock-edge" is not mentioned, the pixel clock edge
> +	value is not touched and given by hardware pin strapping.
> +- ti,spread-spectrum-clock-generation : Spread Sprectrum Clock Generation.
> +	Possible values are from "<0>" to "<7>". The same value will be
> +	written to SSC register. If "ti,spread-spectrum-clock-gen" is not
> +	found, then SSCG will be disabled.
> +
> +TI DS90Ux9xx serializers and deserializer device nodes may contain a number
> +of children device nodes to describe and enable particular subcomponents
> +found on ICs.
> +
> +Example:
> +
> +serializer: serializer@c {
> +	compatible = "ti,ds90ub927q", "ti,ds90ux9xx";
> +	reg = <0xc>;
> +	power-gpios = <&gpio5 12 GPIO_ACTIVE_HIGH>;
> +	ti,backward-compatible-mode = <0>;
> +	ti,low-frequency-mode = <0>;
> +	ti,pixel-clock-edge = <0>;
> +	...
> +}
> +
> +deserializer: deserializer@3c {
> +	compatible = "ti,ds90ub940q", "ti,ds90ux9xx";
> +	reg = <0x3c>;
> +	power-gpios = <&gpio6 31 GPIO_ACTIVE_HIGH>;
> +	...
> +}
> +
> 


-- 
Best regards,
Marek Vasut

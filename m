Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96175C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8112089A
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="efWXMrUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8112089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeKISgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:36:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55954 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbeKISgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:36:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id s10-v6so1228687wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 00:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qYKootPcIB4r8J6KSprtoc4R+LBMZo96WYHAZXPL+38=;
        b=efWXMrUCkJ9fz8c/mSEpZ+Rt2LUdVaHuJyPrySeIRifl/+adC5g2iFJYigRnnCZg9O
         4NCdyhapUIDLelIRBo/T0w3QC1qsvQ2ye5GCBc1hZ8LSOnR/6fMc+u4PVLFpxQnyKYPW
         9UN2oNsGBwQrNaFl9XY8BToX4vQds/Adl+xxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qYKootPcIB4r8J6KSprtoc4R+LBMZo96WYHAZXPL+38=;
        b=Uo/lOht8kQNVh7m8oy0/8EXDPcJYrETmhj+Lx9UECyqpO5sSeWArvgMSA5KLjFKVWf
         okR5JQ9/1mM/PNm6m/Kk57itoF6oHyXFJ5IqbqKxfLCgE4hTeh5O45Vkn1R6RzM7Q/nu
         qBz1933xvbZvszQQ0g6Vo1Jyw9LJZ49+5sCTanpBc86KGrz7ayu8KSnmKQ0tFVql27n+
         suOleBLK1QcGytQWrWvw+SnDYEJR/0AMtC8TN/Paq4GvKFXhkIyMVDOnaY14BlSnDsYV
         AFzrWYy/mJPwyj7wnDW0NxW0tLMmxVU+nW2tgZtuxTgI2kO55Le5bJcFo/i6o6W04iuz
         NrNw==
X-Gm-Message-State: AGRZ1gJFgCFAG/Ff6IDBHD5I+/lTxFCiMcNXTq3cmUUe1fmOnChMJuXp
        we6fgbuLmyH9x+sMAKR0YL6AbG5DITE=
X-Google-Smtp-Source: AJdET5fa2pWQIiM0v+RaV7nMpbfPTBtW7hT0L4ygrjX4210pDH2EryEJk2A4OiBSmloFA8ubrD7JfA==
X-Received: by 2002:a1c:1605:: with SMTP id 5-v6mr3900754wmw.126.1541753835449;
        Fri, 09 Nov 2018 00:57:15 -0800 (PST)
Received: from [192.168.27.197] ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id m69-v6sm894155wmb.8.2018.11.09.00.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:57:14 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: media: i2c: Fix i2c address for OV5645
 camera sensor
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mchehab@kernel.org, robh+dt@kernel.org, hansverk@cisco.com
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181109075643.17575-1-manivannan.sadhasivam@linaro.org>
From:   Todor Tomov <todor.tomov@linaro.org>
Message-ID: <a777f934-9adb-83d7-b0b6-0777563410c0@linaro.org>
Date:   Fri, 9 Nov 2018 10:57:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20181109075643.17575-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On  9.11.2018 09:56, Manivannan Sadhasivam wrote:
> The i2c address for the Omnivision OV5645 camera sensor is 0x3c. It is
> incorrectly mentioned as 0x78 in binding. Hence fix that.

The seven bit i2c address of ov5645 is really 0x3c.
Thank you for finding this and sending the fix!

Best regards,
Todor

> 
> Fixes: 09c716af36e6 [media] media: i2c/ov5645: add the device tree binding document
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/media/i2c/ov5645.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ov5645.txt b/Documentation/devicetree/bindings/media/i2c/ov5645.txt
> index fd7aec9f8e24..1a68ca5eb9a3 100644
> --- a/Documentation/devicetree/bindings/media/i2c/ov5645.txt
> +++ b/Documentation/devicetree/bindings/media/i2c/ov5645.txt
> @@ -26,9 +26,9 @@ Example:
>  	&i2c1 {
>  		...
>  
> -		ov5645: ov5645@78 {
> +		ov5645: ov5645@3c {
>  			compatible = "ovti,ov5645";
> -			reg = <0x78>;
> +			reg = <0x3c>;
>  
>  			enable-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
>  			reset-gpios = <&gpio5 20 GPIO_ACTIVE_LOW>;
> 


Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0C6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D1C2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjfCXX16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D1C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeK1Oxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:53:54 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37664 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeK1Oxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 09:53:53 -0500
Received: by mail-pg1-f194.google.com with SMTP id 80so8864652pge.4;
        Tue, 27 Nov 2018 19:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cPtt2u1IbbKoJZkuH9Oh8GFlJB8QWN7Me6aCSoMtezU=;
        b=IjfCXX16hbvo4+51jVpRq80pew6QE+QU6nqeA2p5eIOpS4juiIsq5dzS+UOpAyr/Ey
         WjAm8Wzc6NutLDip23gF/aJXueYsIxQuJycd7v7WyULTnQ4pLtr2EEAIrnJejXgsxXtR
         EowPu2VLUZJhBPYphA6lv970L/ZVhtkeiuKZtSm1OhesldbSzwjJLI9ndwCGDExeTh3e
         6RTdqaEEbs20AXBpCQyoqVmboiQ3rWTFFz5aTngYohJp4lEq4ZLOnzLOR4cUcgIxP/N/
         5ZC0yQtQpbeRgU+Vtlsrxn9B5/l/dDWEbUIMP5jf3RCjDB7OpZ+ItztJCqxRR/AbTFL3
         6SDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cPtt2u1IbbKoJZkuH9Oh8GFlJB8QWN7Me6aCSoMtezU=;
        b=t7wqxBSgxRurzeTt5EB3hUxp9pbSOjLE5JZXCeebpSYQL4Fhpj5S3xhAafmJnWwEmJ
         C7D2vFNw4EP1CQAlLvtEaoRoeSpzI4XSJJ8pGb2RH2OFV5RxqKYrYqk05ku3mMY8WR2G
         BLmTXFAHy9Cr8JighFZefPYDjVwWFvKJ+ACJpH9gG+1V0cOLGDZg8AA8SH9E/HLbyvHu
         WLNq2pohmWNzIEgGBF/slTT5gVMKZLRo3VKh3bCOUtBfq50FlnWUUDW1zLhYQbAOCQvL
         uGhRwiGTvh+dH0kjzKz1JACJN85uV6kfhGFCtgwhqV2VICigjYvJUgrlt/pa1NYtfhQV
         o9Bw==
X-Gm-Message-State: AGRZ1gK3mnKpZpKrpxomemDnyUBYVeZTRW8/aUP0X1hzh1MQq0xyG7O8
        mUa/ic5GU17DBBYzVLEms1I=
X-Google-Smtp-Source: AJdET5f5IIJa3+mTtviKIlZbJc5AzgnfAdt/CpY4lduBvzJupvXGhOFZ0K8VkDwPRV2gyrj8FDLH0Q==
X-Received: by 2002:a62:1f9d:: with SMTP id l29mr35848521pfj.14.1543377225171;
        Tue, 27 Nov 2018 19:53:45 -0800 (PST)
Received: from ?IPv6:2604:4080:1012:8070:9a48:b5d:be16:1cdc? ([2604:4080:1012:8070:9a48:b5d:be16:1cdc])
        by smtp.gmail.com with ESMTPSA id q1sm7288071pfb.96.2018.11.27.19.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 19:53:44 -0800 (PST)
Subject: Re: [PATCH] Input: xpad - add support for Hyperkin Duke Xbox One
 gamepad
From:   Cameron Gutman <aicommander@gmail.com>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com
Cc:     shelby@jueden.org
References: <20181128032857.26167-1-aicommander@gmail.com>
Message-ID: <e920f403-a9e0-5345-27a7-522488b89d27@gmail.com>
Date:   Tue, 27 Nov 2018 19:53:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181128032857.26167-1-aicommander@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/2018 07:28 PM, Cameron Gutman wrote:
> Originally submitted by Shelby Jueden (GitHub: AkBKukU) to paroj/xpad:
> https://github.com/paroj/xpad/pull/97
> 
> Minor change to the location of the new entries done by me.
> 
> Cc: Shelby Jueden <shelby@jueden.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Cameron Gutman <aicommander@gmail.com>
> ---

I'm going to actually NACK this one myself.

I didn't realize Shelby had already submitted it here and received
feedback - https://patchwork.kernel.org/patch/10421897/

I believe I have a patch to always read from Xbox One gamepads kicking around
here somewhere. I'll send that in a series with this patch (or Shelby's if he
wants to make a v2 with the ordering fixed).

>  drivers/input/joystick/xpad.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index cfc8b94527b9..8d6ea091a01a 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -330,6 +330,7 @@ static const struct xpad_device {
>  	{ 0x24c6, 0x5b03, "Thrustmaster Ferrari 458 Racing Wheel", 0, XTYPE_XBOX360 },
>  	{ 0x24c6, 0x5d04, "Razer Sabertooth", 0, XTYPE_XBOX360 },
>  	{ 0x24c6, 0xfafe, "Rock Candy Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
> +	{ 0x2e24, 0x0652, "Hyperkin Duke X-Box One pad", 0, XTYPE_XBOXONE },
>  	{ 0x3767, 0x0101, "Fanatec Speedster 3 Forceshock Wheel", 0, XTYPE_XBOX },
>  	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", 0, XTYPE_XBOX },
>  	{ 0x0000, 0x0000, "Generic X-Box pad", 0, XTYPE_UNKNOWN }
> @@ -440,6 +441,7 @@ static const struct usb_device_id xpad_table[] = {
>  	XPAD_XBOX360_VENDOR(0x1bad),		/* Harminix Rock Band Guitar and Drums */
>  	XPAD_XBOX360_VENDOR(0x24c6),		/* PowerA Controllers */
>  	XPAD_XBOXONE_VENDOR(0x24c6),		/* PowerA Controllers */
> +	XPAD_XBOXONE_VENDOR(0x2e24),		/* Hyperkin Duke X-Box One pad */
>  	{ }
>  };
>  
> 

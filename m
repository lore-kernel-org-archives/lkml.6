Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7338FC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD062082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjQ9U6wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD062082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeLHSoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 13:44:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35957 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbeLHSon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 13:44:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so6267724ljk.3;
        Sat, 08 Dec 2018 10:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LZLACOcCLED7YhS6FtIUV9p2SeZWScNM1UeKsefbuCk=;
        b=ZjQ9U6wzlfTBKRGNxjOnjvmgYj/WIU5/34MKDFpfwkD0uLWPhTwnyZaHLedQKu9H1M
         fPgtKtEn3uQD26Iu0faMIwhM0MdYtZrP/dNGeWra3IXHp2UHZ5MDVAgxESD65y7B7VvQ
         Jtnxoav/bdjJ6RyBTdz0yQeOdnWODRdVCOr49wpoYh1TYFCn6QkKzApsVgSYDyCr+aGu
         5gmc659LcVZhMhuNzWkHna0lU0u/3NpfBbIKZ4g7wWYD77ug6b6CRcSf4hTynKSgZfut
         8xdjRBEKURuTrGb/MhVvapn1EcL1NefLHRI/kuls06XdgM6iWZmRTLa+hyxeqt+TUxxG
         XKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LZLACOcCLED7YhS6FtIUV9p2SeZWScNM1UeKsefbuCk=;
        b=Qv5RJeGexzKKnAAx90NCnOJah8FQJKVKKgKsIzGD4OuQl4E/KE2DmMm5Mp0DB4Y+s6
         Obpg1jKUejPET+6ufve3TGVFXHMn3N3D1qQVcWuKMMrKEKR3sORYFFDVbqa2BI29lnxg
         s9yemwHnEXsE0IDrh0WfFd+KqUdfSEBUUoLtuk3ubKbg9x8aGcmzxcUmqsZOU25K+0tK
         JQYiHZhOnA9D9A6J8K0sS0wjpfvSEexV+whKKbB0ctv0yg04um/Qrn5BEUywlVMtMnDa
         T0KEm/5PG2y75HbGB12I5GxyClN/sKAU27ujvnJRr5RaNt7gGKqO0y+3zz5hGykeBaSQ
         TpuQ==
X-Gm-Message-State: AA+aEWZ95EiXxFRL0qYxj3TO2crwD668mlGyKInaqQ7zYMcctafo9PDY
        7wyAPahhT6GLTpG6BCxFPAItmrZ6
X-Google-Smtp-Source: AFSGD/UeHV0YuL/ytFfxIfESYFwQarQAIaH8z8DuPkALgYadK67hA3v1x/1TzgZvKqdUxVenDAoVmw==
X-Received: by 2002:a2e:b1ca:: with SMTP id e10-v6mr4258718lja.16.1544294681147;
        Sat, 08 Dec 2018 10:44:41 -0800 (PST)
Received: from [192.168.1.18] (blg173.neoplus.adsl.tpnet.pl. [83.28.200.173])
        by smtp.gmail.com with ESMTPSA id l3-v6sm1198866ljg.21.2018.12.08.10.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 10:44:40 -0800 (PST)
Subject: Re: [PATCH 4/4] leds: trigger: Add pattern initialization from Device
 Tree
To:     Krzysztof Kozlowski <krzk@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544185974-5932-1-git-send-email-krzk@kernel.org>
 <1544185974-5932-4-git-send-email-krzk@kernel.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <8222f85b-4e61-69c4-6d31-ba559de02829@gmail.com>
Date:   Sat, 8 Dec 2018 19:44:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1544185974-5932-4-git-send-email-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the patch set.

Applied 1/4 and 2/4.

I'll hold on merging 3/4 until we sort out the issues
I have with this one. Please refer to my comment below.

On 12/7/18 1:32 PM, Krzysztof Kozlowski wrote:
> Allow initialization of pattern used in pattern trigger from Device Tree
> property.
> 
> This is especially useful for embedded systems where the pattern trigger
> would be used to indicate the process of boot status in a nice,
> user-friendly blinking way.  This initialization pattern will be used
> till user-space is brought up and sets its own pattern, indicating the
> boot status is for example finished.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   drivers/leds/trigger/ledtrig-pattern.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
> index 1870cf87afe1..96309d3bc43c 100644
> --- a/drivers/leds/trigger/ledtrig-pattern.c
> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> @@ -11,6 +11,7 @@
>   #include <linux/leds.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
> +#include <linux/of.h>
>   #include <linux/slab.h>
>   #include <linux/timer.h>
>   
> @@ -331,6 +332,21 @@ static const struct attribute_group *pattern_trig_groups[] = {
>   	NULL,
>   };
>   
> +static void pattern_init(struct led_classdev *led_cdev)
> +{
> +	struct device_node *np = dev_of_node(led_cdev->dev);
> +	const char *pattern;
> +
> +	if (!np)
> +		return;
> +
> +	if (!of_property_read_string(np, "linux,trigger-pattern", &pattern)) {
> +		if (strlen(pattern))
> +			pattern_trig_store_patterns(led_cdev, pattern,
> +						    strlen(pattern), false);
> +	}
> +}
> +
>   static int pattern_trig_activate(struct led_classdev *led_cdev)
>   {
>   	struct pattern_trig_data *data;
> @@ -354,6 +370,8 @@ static int pattern_trig_activate(struct led_classdev *led_cdev)
>   	timer_setup(&data->timer, pattern_trig_timer_function, 0);
>   	led_cdev->activated = true;
>   
> +	pattern_init(led_cdev);

It means that the pattern defined in DT would be applied
whenever the pattern trigger is set for a LED class device,
whereas it should happen only on LED class device initialization,
if linux,default-trigger is set to "pattern".

What we would need for making that work is a generic support for
parsing trigger specific initialization data in the
of_led_classdev_register().

> +
>   	return 0;
>   }
>   
> 

-- 
Best regards,
Jacek Anaszewski

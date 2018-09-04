Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC97C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECAF2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPA7Czog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECAF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeIEAqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:46:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53245 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeIEAqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:46:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id y139-v6so5682729wmc.2;
        Tue, 04 Sep 2018 13:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=noz+J3+KbGCGVyL9B2Mk1Kdz6HPazR/R0Intkyb7mIQ=;
        b=PPA7CzogJeXCR6sthEV1AHpbclr2b6WLly6XRSiXAa2oJ7nT1cElHv+yh/3OWDSYm4
         5KLl7nmSiG7DZE6YSTwKshSqXHvrPr0URxJOYxBZBd7cmpAGeEa0oL5KmI7vBiuN1P5b
         sVAvpSZZxAtLydps6dTrfVFwvd2NMKyXDa/Ikkq9ZpEZSWgCKMwHQQTnhx2DZgfuuE6G
         OWbKeaPnJOyln9jM6H7YmxitzwSQ9CdvKo9w6lAZzD2onZde6kSAVcopKsHptkJQvDHu
         SF7Jv/TRCf84Ymo4zQOQ1id06xR68/Ydy9Ecz2c9AFy0mqhZDd+zNe+Nd9sC+zTjtCm8
         2pkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=noz+J3+KbGCGVyL9B2Mk1Kdz6HPazR/R0Intkyb7mIQ=;
        b=F66MbNZ9BlQEOV/NKKxXTjNGB7TU+B78lFLLWeVjj8TVyTTytEwJ+jT0XMvDsV2l7z
         DoPqaNPM5YphnA1IMmYpVC1JAhbrv5LQwulWBfDFFPfEMy3jvlZ746Pb/MeDJdwm2TAY
         QeQcJWuqv4lPIsNGAJgkLvhFzjlYAxrOOy457zbRqzewGx/IyYCP6e0H5YmXAXeG2udm
         Oj1XjMt16T4PKpKRJS/CxRz3a2C0DFO12qSudJ2adM3th9+p9F/lTKHpHtZ6FUckZMUO
         YuGzAfDL9IMi1hEbhdkYN3IDHMmHIvhqu+Bu8GnaeogPyMkLmBdomj8tWpSVqf3cyrPC
         /lVA==
X-Gm-Message-State: APzg51BEJ4znPeSyg64VtuA5iSjqDvLftJtpLr7yCFJcYFO6WoGRv4dS
        Ohq+tY6HdESDv6qVFz/B9BkRNA8Z
X-Google-Smtp-Source: ANB0VdYPnbzZL06Pt8+wCLsUV8Ddi2/JmjAHVh+/ozd460X5lvMcW/7hVyMExmxNwEyd05Pgx77SrQ==
X-Received: by 2002:a1c:7f93:: with SMTP id a141-v6mr3300882wmd.45.1536092386164;
        Tue, 04 Sep 2018 13:19:46 -0700 (PDT)
Received: from [192.168.1.18] (bgs148.neoplus.adsl.tpnet.pl. [83.28.82.148])
        by smtp.gmail.com with ESMTPSA id q16-v6sm15453956wrn.41.2018.09.04.13.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 13:19:45 -0700 (PDT)
Subject: Re: [PATCH v8 2/2] leds: sc27xx: Add pattern_set/clear interfaces for
 LED controller
To:     Baolin Wang <baolin.wang@linaro.org>, pavel@ucw.cz
Cc:     rteysseyre@gmail.com, bjorn.andersson@linaro.org,
        broonie@kernel.org, linus.walleij@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536027873.git.baolin.wang@linaro.org>
 <e7642c73ac1c20b97990a887f76f2f51c41f930b.1536027873.git.baolin.wang@linaro.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <ff34b0fd-dd56-f239-94a9-d84673f6869a@gmail.com>
Date:   Tue, 4 Sep 2018 22:19:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e7642c73ac1c20b97990a887f76f2f51c41f930b.1536027873.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On 09/04/2018 01:01 PM, Baolin Wang wrote:
> This patch implements the 'pattern_set'and 'pattern_clear'
> interfaces to support SC27XX LED breathing mode.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v7:
>  - Add its own ABI documentation file.
> 
> Changes from v6:
>  - None.
> 
> Changes from v5:
>  - None.
> 
> Changes from v4:
>  - None.
> 
> Changes from v3:
>  - None.
> 
> Changes from v2:
>  - None.
> 
> Changes from v1:
>  - Remove pattern_get interface.
> ---
>  .../ABI/testing/sysfs-class-led-driver-sc27xx      |   11 +++
>  drivers/leds/leds-sc27xx-bltc.c                    |   94 ++++++++++++++++++++
>  2 files changed, 105 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
> new file mode 100644
> index 0000000..ecef3ba
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
> @@ -0,0 +1,11 @@
> +What:		/sys/class/leds/<led>/hw_pattern
> +Date:		September 2018
> +KernelVersion:	4.20
> +Description:
> +		Specify a hardware pattern for the SC27XX LED. For the SC27XX
> +		LED controller, it only supports 4 hardware patterns to configure

If I understand it correctly then the four components: low, rise, high,
and fall time make a single pattern. So calling it "4 hardware patterns"
can be misleading. Below you're using "stage" notion - it would be good
to use it consequently on the whole span of this document.

> +		the low time, rise time, high time and fall time for the breathing
> +		mode, and each stage duration unit is 125ms. So the format of
> +		the hardware pattern values should be:

I'd be more precise here:

Min stage duration: ???
Max stage duration: ???
Stage duration step: 125 ms

> +		"brightness_1 duration_1 brightness_2 duration_2 brightness_3
> +		duration_3 brightness_4 duration_4".

Looking at sc27xx_led_pattern_set() it doesn't seem like you would
use brightnesses other then brightness_1. I assume that the low
brightness is fixed to 0 and the high brightness is the brightness_1.
If yes, than we don't need brightnesses in this pattern definition,
since the current brightness will suffice.

You'd need to alter the hw_pattern description to say that the
brightness currently set is to be used as a high brightness, and the
hw_pattern for this driver consists only of the four delta_t components.

This is clear example of what I had on mind when having doubts
about using tuples for pattern_set.

Alternatively, if we want to enforce tuples format for hw_pattern,
and if we want to be consistent - we'd need to require defining target
brightness for each stage properly, i.e.

echo "100 500 100 500 0 500 0 500" > pattern

Which would mean:

1. Rise from brightness 0 to 100 for 500 ms.
2. Keep brightness 100 for 500 ms.
3. Fall from brightness 100 to 0 for 500 ms.
4. Keep brightness 0 for 500 ms.

-- 
Best regards,
Jacek Anaszewski

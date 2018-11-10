Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F587C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76AE20840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzzbjuZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76AE20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbeKKE0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 23:26:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37091 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeKKE0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 23:26:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id u13-v6so2390629pfm.4;
        Sat, 10 Nov 2018 10:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NqVkS3VJalGB/t0Ng95SkyTAUA42pM749sevTQoLmGw=;
        b=rzzbjuZF+CflZ1tX8Lj11rshLLCqEdsGKF1Ftqzmbc4m76aZoDX2zOdLa6lA/3/cUf
         Km4RsmDkD5YppFOWg7EE2VF7UNmUllgjVa8SC14oPexy0AgHaQRFOZj4doztSFlXH+sh
         WNqZwVpsPLxCot2yf5NqOZexDJbqPGw6t+x8KlUeMSOQaqOyMuMnLXvpaVsCFRUAB/XD
         2y1OQJdbRZvDgWWGuGNlcL7mEAVBvmFXVU5UAF63UOdva86bikgX5xcszzcJydAs6c+d
         rdM7zo17k63cHs9j4LPEcG4orAnL2z68MLZA4qI0yPaVQ/a7KdqisRfivzZ9IAOIg1GO
         BHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NqVkS3VJalGB/t0Ng95SkyTAUA42pM749sevTQoLmGw=;
        b=lXVJ30mJkyS/kU6auiXrYJGw2CqI9L0+ofw34/rw/utC/K6EX2hoyuXAJ696K5ZIxo
         aSVZseOy6fH9xjObjdicnHXDelhbgkZg6jHGG7IfAd+7s9FVFic/x4bRlU7gGBE/q0hB
         WOAsoiDoakVdp7F7omdSETW33mTZbsFhVR9BM5BI+hBQQ7RjESWc9nYYmim+6tirrVXv
         Tc9lszYhsxLIe1KJhRwu6SMnkjrLA7nIkGoErPNpekGsQ2zdgcLYklvL9YukZRR4NQLW
         vZO3Us5LyQ683wLOQ9IR7KNKb6l8l6X9E5itUeuTB5hm6HeXcX7TM+O8hui0GRgEKMA6
         QGFQ==
X-Gm-Message-State: AGRZ1gLUT1ugI/TYLp51kDjpAjNgKQ94MVhVEe59KEuEefkoNO9L8cqE
        5u4FkZfsSSHvz6RDcJpK4g0=
X-Google-Smtp-Source: AJdET5fBhND557/ONA0LH62Fc4mClJ1phsYoAIBlB5NbdBZjQugQy8gV7c7jxAV2rJdRjTq0GQ/j3Q==
X-Received: by 2002:a62:995c:: with SMTP id d89-v6mr13740794pfe.11.1541875233247;
        Sat, 10 Nov 2018 10:40:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l6-v6sm894837pff.147.2018.11.10.10.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 10:40:32 -0800 (PST)
Subject: Re: [PATCH v1 3/5] staging: typec: fusb302: Rename fcs,extcon-name to
 linux,extcon-name
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
 <20181110181101.24557-3-andriy.shevchenko@linux.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <951e707e-4774-4c25-92d8-b4b60b772656@roeck-us.net>
Date:   Sat, 10 Nov 2018 10:40:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181110181101.24557-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/18 10:10 AM, Andy Shevchenko wrote:
> Since we are going to use the same in Designware USB 3 driver,
> rename the property to be consistent across the drivers.
> 
> No functional change intended.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/platform/x86/intel_cht_int33fe.c | 2 +-
>   drivers/usb/typec/tcpm/fusb302.c         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> index 464fe93657b5..87cbf18d0305 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe.c
> @@ -79,7 +79,7 @@ static const struct property_entry max17047_props[] = {
>   };
>   
>   static const struct property_entry fusb302_props[] = {
> -	PROPERTY_ENTRY_STRING("fcs,extcon-name", "cht_wcove_pwrsrc"),
> +	PROPERTY_ENTRY_STRING("linux,extcon-name", "cht_wcove_pwrsrc"),
>   	PROPERTY_ENTRY_U32("fcs,max-sink-microvolt", 12000000),
>   	PROPERTY_ENTRY_U32("fcs,max-sink-microamp",   3000000),
>   	PROPERTY_ENTRY_U32("fcs,max-sink-microwatt", 36000000),
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 6d332066202b..62816ac571a0 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1765,7 +1765,7 @@ static int fusb302_probe(struct i2c_client *client,
>   	 * to be set by the platform code which also registers the i2c client
>   	 * for the fusb302.
>   	 */
> -	if (device_property_read_string(dev, "fcs,extcon-name", &name) == 0) {
> +	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
>   		chip->extcon = extcon_get_extcon_dev(name);
>   		if (IS_ERR(chip->extcon))
>   			return PTR_ERR(chip->extcon);
> 


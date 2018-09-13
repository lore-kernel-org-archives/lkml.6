Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A53C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D33420C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D33420C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeIMPkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 11:40:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34966 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeIMPkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 11:40:10 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1g0Ou6-0005J0-OQ
        for linux-kernel@vger.kernel.org; Thu, 13 Sep 2018 10:31:18 +0000
Received: by mail-pf1-f199.google.com with SMTP id v9-v6so2732042pff.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 03:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Pb+Q/SiNh8ATEDYxlzjH3k/GhDpgaFnhmPlPrDN/U4U=;
        b=HaCSLWs5ctX3TYSEj+wZTFyby7c0iVBiuHcESIiL1TKdRb5n7wc9KCX8/HUF4nIay4
         ggmOgyIdhEk94KgRahju2VS56BKZmSpl3JkXZxUbcFUVAe3pnRGjR2P9Scj4soHOhOhp
         RDoQfcVyjG6CSXPLNN0B8G9wn0v22KsLb9vW1ckOtltokV7DTFYaMsJoeOOXzF7fG9ZB
         urOlUVq1/vZ3YmF/Cj5LvKpjoySghyxVzDyRoDOFdoKiij1NS6mIet7cW0qIbdXAzi3t
         3ZfAnWZCMZxHGIJhgsHqDe+vrbV+tu9S2vLmnqx6L0pBreuv8B90LETY6HVil06jlWjM
         oGqA==
X-Gm-Message-State: APzg51DXJTjTvqgr5Q7uzveGsBvUTeOVM3efmQJ9+/Dth2JKK9H2WNmH
        70a8R/VhoBL7ojv7rRzZh+ig2DGTIHRnoc+RiQ6pEog8DrZU5ca1cUVu0un+ksYoUiX/FBJuaOd
        nke7b3o8q6H0+GF2PuH/1G4li3cGrKjT7E3KQL5av5g==
X-Received: by 2002:a17:902:8a97:: with SMTP id p23-v6mr6550327plo.21.1536834677207;
        Thu, 13 Sep 2018 03:31:17 -0700 (PDT)
X-Google-Smtp-Source: ANB0VdbFmbuLOAjogxB7xNtr6v8QUvFaS06fxjyqOy9F1vN7IJiM1qiWxuv/t1Dx3WysRvcNtNTvog==
X-Received: by 2002:a17:902:8a97:: with SMTP id p23-v6mr6550279plo.21.1536834676596;
        Thu, 13 Sep 2018 03:31:16 -0700 (PDT)
Received: from [192.168.1.206] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id 3-v6sm6303051pfq.10.2018.09.13.03.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 03:31:15 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 1/5] misc: rtsx_usb: Use USB remote wakeup signaling for
 card insertion detection
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180731061721.15831-2-kai.heng.feng@canonical.com>
Date:   Thu, 13 Sep 2018 18:31:11 +0800
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <9C387477-5253-497B-8BE2-8245AB88C551@canonical.com>
References: <20180731061721.15831-1-kai.heng.feng@canonical.com>
 <20180731061721.15831-2-kai.heng.feng@canonical.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, Ulf,

at 14:17, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> Although rtsx_usb doesn't support card removal detection, card insertion
> will resume rtsx_usb by USB remote wakeup signaling.
>
> When rtsx_usb gets resumed, also resumes its child devices,
> rtsx_usb_sdmmc and rtsx_usb_ms, to notify them there's a card in its
> slot.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/misc/cardreader/rtsx_usb.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/misc/cardreader/rtsx_usb.c  
> b/drivers/misc/cardreader/rtsx_usb.c
> index b97903ff1a72..f7a66f614085 100644
> --- a/drivers/misc/cardreader/rtsx_usb.c
> +++ b/drivers/misc/cardreader/rtsx_usb.c
> @@ -723,8 +723,15 @@ static int rtsx_usb_suspend(struct usb_interface  
> *intf, pm_message_t message)
>  	return 0;
>  }
>
> +static int rtsx_usb_resume_child(struct device *dev, void *data)
> +{
> +	pm_request_resume(dev);
> +	return 0;
> +}
> +
>  static int rtsx_usb_resume(struct usb_interface *intf)
>  {
> +	device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
>  	return 0;
>  }
>
> @@ -734,6 +741,7 @@ static int rtsx_usb_reset_resume(struct usb_interface  
> *intf)
>  		(struct rtsx_ucr *)usb_get_intfdata(intf);
>
>  	rtsx_usb_reset_chip(ucr);
> +	device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
>  	return 0;
>  }

I am working on the next version of this series, and the last missing  
puzzle is to differentiate system-wide resume from runtime resume in  
usb_driver's resume() and reset_resume() callback.

The parent device, rtsx_usb, has two child devices, rtsx_usb_ms and  
rtsx_usb_sdmmc.
pm_request_resume() is used in rtsx_usb's resume() to facilitate USB remote  
wakeup signaling, so we don't need to poll the card slot status.
But this has a side effect: during system resume the rtsx_usb calls  
pm_request_resume() in its resume(), so child devices calls their  
runtime_resume() instead of resume() callback.

So, is it reasonable to pass pm_message_t to resume() and reset_resume()  
callbacks and use PMSG_IS_AUTO() to differentiate them?

Kai-Heng

>
> -- 
> 2.17.1



Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB7DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A219E2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A219E2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbeIXVrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:47:35 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44830 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeIXVrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:47:35 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B23C720725; Mon, 24 Sep 2018 17:44:46 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 88C1A204AE;
        Mon, 24 Sep 2018 17:44:46 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rtc: armada38x: add range
References: <20180924142536.27801-1-alexandre.belloni@bootlin.com>
        <20180924142536.27801-2-alexandre.belloni@bootlin.com>
Date:   Mon, 24 Sep 2018 17:44:47 +0200
In-Reply-To: <20180924142536.27801-2-alexandre.belloni@bootlin.com> (Alexandre
        Belloni's message of "Mon, 24 Sep 2018 16:25:35 +0200")
Message-ID: <87zhw6ew7k.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,
 
 On lun., sept. 24 2018, Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> The RTC is a 32bit seconds counter.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

I checked that with a 64bits userspace setting the date further than
2106 doesn't wrap silently anymore.

Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory

> ---
>  drivers/rtc/rtc-armada38x.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
> index b74338d6dde6..d0278ad0a7f9 100644
> --- a/drivers/rtc/rtc-armada38x.c
> +++ b/drivers/rtc/rtc-armada38x.c
> @@ -577,6 +577,8 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)
>  	/* Update RTC-MBUS bridge timing parameters */
>  	rtc->data->update_mbus_timing(rtc);
>  
> +	rtc->rtc_dev->range_max = U32_MAX;
> +
>  	ret = rtc_register_device(rtc->rtc_dev);
>  	if (ret)
>  		dev_err(&pdev->dev, "Failed to register RTC device: %d\n", ret);
> -- 
> 2.19.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

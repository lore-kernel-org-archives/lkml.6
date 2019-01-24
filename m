Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD7CC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7706521872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfAXLSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:18:46 -0500
Received: from foss.arm.com ([217.140.101.70]:54868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfAXLSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 06:18:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C56F1596;
        Thu, 24 Jan 2019 03:18:46 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CFE63F237;
        Thu, 24 Jan 2019 03:18:44 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: hikey: Revert "Enable HS200 mode on eMMC"
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Ryan Grachek <ryan@edited.us>,
        Alistair Strachan <astrachan@google.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        "stable #4 . 17+" <stable@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-kernel@lists.infradead.org
References: <1548273966-5889-1-git-send-email-john.stultz@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <107a6e2e-ddd8-cbc1-5680-1b5899665327@arm.com>
Date:   Thu, 24 Jan 2019 11:18:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548273966-5889-1-git-send-email-john.stultz@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 23/01/2019 20:06, John Stultz wrote:
> From: Alistair Strachan <astrachan@google.com>
> 
> This reverts commit abd7d0972a192ee653efc7b151a6af69db58f2bb. This
> change was already partially reverted by John Stultz in commit
> 9c6d26df1fae ("arm64: dts: hikey: Fix eMMC corruption regression").
> 
> This change appears to cause controller resets and block read failures
> which prevents successful booting on some hikey boards.

FWIW, you might want to have a play with the pinctrl settings - I've 
seen various flakiness with HS200 eMMCs on Rockchip boards which could 
be solved by bumping up the drive strength.

Robin.

> Cc: Ryan Grachek <ryan@edited.us>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: stable <stable@vger.kernel.org> #4.17+
> Signed-off-by: Alistair Strachan <astrachan@google.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>   arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index 6102350..7092460 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -300,7 +300,6 @@
>   
>   		dwmmc_0: dwmmc0@f723d000 {
>   			cap-mmc-highspeed;
> -			mmc-hs200-1_8v;
>   			non-removable;
>   			bus-width = <0x8>;
>   			vmmc-supply = <&ldo19>;
> 

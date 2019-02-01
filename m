Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608BCC282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31868207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfBAQgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:36:45 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32857 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727057AbfBAQgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:36:45 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 235CDDE81A500C6CE2C1;
        Fri,  1 Feb 2019 16:36:44 +0000 (GMT)
Received: from [127.0.0.1] (10.202.226.46) by LHREML710-CAH.china.huawei.com
 (10.201.108.33) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Feb 2019
 16:36:40 +0000
Subject: Re: [PATCH] arm64: dts: hikey: Revert "Enable HS200 mode on eMMC"
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
CC:     Alistair Strachan <astrachan@google.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        "stable #4 . 17+" <stable@vger.kernel.org>
References: <1548273966-5889-1-git-send-email-john.stultz@linaro.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5be6f6d5-83e7-7225-914f-f61205ce6e7f@hisilicon.com>
Date:   Fri, 1 Feb 2019 16:36:39 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548273966-5889-1-git-send-email-john.stultz@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 1/23/2019 8:06 PM, John Stultz wrote:
> From: Alistair Strachan <astrachan@google.com>
> 
> This reverts commit abd7d0972a192ee653efc7b151a6af69db58f2bb. This
> change was already partially reverted by John Stultz in commit
> 9c6d26df1fae ("arm64: dts: hikey: Fix eMMC corruption regression").
> 
> This change appears to cause controller resets and block read failures
> which prevents successful booting on some hikey boards.
> 
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

Applied to the hisilicon soc dt tree.
Thanks!

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index 6102350..7092460 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -300,7 +300,6 @@
>  
>  		dwmmc_0: dwmmc0@f723d000 {
>  			cap-mmc-highspeed;
> -			mmc-hs200-1_8v;
>  			non-removable;
>  			bus-width = <0x8>;
>  			vmmc-supply = <&ldo19>;
> 


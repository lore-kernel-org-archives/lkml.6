Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D06DC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0579C2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfBARAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:00:24 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32860 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728892AbfBARAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:00:24 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id C64D34F342B631B14FBD;
        Fri,  1 Feb 2019 17:00:22 +0000 (GMT)
Received: from [127.0.0.1] (10.202.226.46) by lhreml709-cah.china.huawei.com
 (10.201.108.32) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Feb 2019
 17:00:20 +0000
Subject: Re: [PATCH v2] arm64/hisilicon: fix SDcard detection
To:     Vincent Guittot <vincent.guittot@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>
References: <1547454274-1674-1-git-send-email-vincent.guittot@linaro.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <3722223a-4f06-3e1c-86ca-542289c7c918@hisilicon.com>
Date:   Fri, 1 Feb 2019 17:00:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547454274-1674-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 1/14/2019 8:24 AM, Vincent Guittot wrote:
> The SDcard detection of hikey960 is active low so cd-inverted is wrong.
> Instead of adding cd-inverted, we should better set correctly cd-gpios
> to use GPIO_ACTIVE_LOW.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Updated the subject as Leo suggested and applied to the hisilicon tree.
Thanks!

Best Regards,
Wei

> ---
> 
> SD card detection was not working on v5.0-rc1 but patch
> https://marc.info/?l=linux-mmc&m=154637189021211&w=2 makes it work.
> Nevertheles, latest changes in of_mmc_detection makes possible to have 
> a correct DT config.
> 
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index 71bfe41..dc314e7 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -665,8 +665,7 @@
>  	sd-uhs-sdr50;
>  	sd-uhs-sdr104;
>  	disable-wp;
> -	cd-inverted;
> -	cd-gpios = <&gpio25 3 0>;
> +	cd-gpios = <&gpio25 3 GPIO_ACTIVE_LOW>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&sd_pmx_func
>  		     &sd_clk_cfg_func
> 


Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFC9C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BAC2791F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BAC2791F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754652AbeF1U1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:27:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9185 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753654AbeF1U1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:27:02 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0EA76C990AF37;
        Fri, 29 Jun 2018 04:26:49 +0800 (CST)
Received: from [127.0.0.1] (10.47.90.156) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.382.0; Fri, 29 Jun 2018
 04:26:48 +0800
Subject: Re: [PATCH] arm64: dts: hikey960: Define wl1837 power capabilities
To:     Ryan Grachek <ryan@edited.us>
References: <20180613180321.16745-1-ryan@edited.us>
CC:     <valentin.schneider@arm.com>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5B354481.5080207@hisilicon.com>
Date:   Thu, 28 Jun 2018 21:26:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180613180321.16745-1-ryan@edited.us>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.90.156]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

On 2018/6/13 19:03, Ryan Grachek wrote:
> These properties are required for compatibility with runtime PM.
> Without these properties, MMC host controller will not be aware
> of power capabilities. When the wlcore driver attempts to power
> on the device, it will erroneously fail with -EACCES. This fixes
> a regression found here: https://lkml.org/lkml/2018/6/12/930
> 
> Signed-off-by: Ryan Grachek <ryan@edited.us>
> ---

Applied to hisilicon fix tree.
Thanks!

Best Regards,
Wei

>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index c6999624ed8a..68c5a6c819ae 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -585,6 +585,8 @@
>  	vmmc-supply = <&wlan_en>;
>  	ti,non-removable;
>  	non-removable;
> +	cap-power-off-card;
> +	keep-power-in-suspend;
>  	#address-cells = <0x1>;
>  	#size-cells = <0x0>;
>  	status = "ok";
> 


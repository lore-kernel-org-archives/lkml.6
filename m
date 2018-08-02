Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB69CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6622150D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6622150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbeHBOmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:42:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49199 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387418AbeHBOmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:42:54 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 49275A2744992;
        Thu,  2 Aug 2018 20:51:46 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Thu, 2 Aug 2018
 20:51:44 +0800
Date:   Thu, 2 Aug 2018 13:51:31 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Parthiban Nallathambi <pn@denx.de>
CC:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <matthias.bgg@gmail.com>, <wd@denx.de>, <sbabic@denx.de>,
        <hs@denx.de>
Subject: Re: [PATCH v3 2/2] iio: light: Add device tree binding for vishay
 vcnl4035
Message-ID: <20180802135131.000037cb@huawei.com>
In-Reply-To: <20180802095230.2049554-2-pn@denx.de>
References: <20180629153802.1639514-1-pn@denx.de>
        <20180802095230.2049554-1-pn@denx.de>
        <20180802095230.2049554-2-pn@denx.de>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2018 11:52:30 +0200
Parthiban Nallathambi <pn@denx.de> wrote:

> Adding device tree binding for vcnl4035 and vendor
> prefix for Vishay Intertechnology
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> -------
Generally don't add your own cut line, just use the one that is already there below.

One minor comment inline.
> 
> Changelog in v3:
> - removed interrupt-parent property reference in documentation
> - renamed vcnl4035 to light-sensor
> ---
>  .../devicetree/bindings/iio/light/vcnl4035.txt         | 18 ++++++++++++++++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt  |  1 +
>  2 files changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4035.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4035.txt b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
> new file mode 100644
> index 000000000000..871f995f7b35
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
> @@ -0,0 +1,18 @@
> +VISHAY VCNL4035 -  Ambient Light and proximity sensor
> +
> +Link to datasheet: https://www.vishay.com/docs/84251/vcnl4035x01.pdf
> +
> +Required properties:
> +
> +	-compatible: should be "vishay,vcnl4035"
> +	-reg: I2C address of the sensor, should be 0x60

Bit random on the spacing after -.

> +	- interrupts: interrupt mapping for GPIO IRQ (level active low)
> +
> +Example:
> +
> +light-sensor@60 {
> +	compatible = "vishay,vcnl4035";
> +	reg = <0x60>;
> +	interrupt-parent = <&gpio4>;
> +	interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 7cad066191ee..3cc46d5735a9 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -395,6 +395,7 @@ v3	V3 Semiconductor
>  variscite	Variscite Ltd.
>  via	VIA Technologies, Inc.
>  virtio	Virtual I/O Device Specification, developed by the OASIS consortium
> +vishay	Vishay Intertechnology, Inc
>  vivante	Vivante Corporation
>  vocore VoCore Studio
>  voipac	Voipac Technologies s.r.o.



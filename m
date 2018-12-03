Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518BBC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1990B206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1990B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbeLCNRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:17:52 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42107 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbeLCNRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:17:51 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 067E4A2AC0FC;
        Mon,  3 Dec 2018 21:16:35 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Mon, 3 Dec 2018
 21:16:33 +0800
Date:   Mon, 3 Dec 2018 13:16:21 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <kernel-usp@googlegroups.com>
Subject: Re: [PATCH] staging: iio: ad5933: add binding doc for ad5933
Message-ID: <20181203131621.00002a40@huawei.com>
In-Reply-To: <20181202165712.t6pd6ygq57llf2lr@smtp.gmail.com>
References: <20181202165712.t6pd6ygq57llf2lr@smtp.gmail.com>
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

On Sun, 2 Dec 2018 14:57:12 -0200
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Add a devicetree documentation for the ad5933 and ad5934 impedance
> converter, network analyzer.
> 
> Co-Developed-by: Gabriel Capella <gabriel@capella.pro>

Put this in line below Gabriel's sign off - it makes script
parsing of these easier.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Gabriel Capella <gabriel@capella.pro>
Co-Developed-by: Gabriel Capella <gabriel@capella.pro>

> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Gabriel Capella <gabriel@capella.pro>
> ---
>  .../iio/impedance-analyzer/ad5933.txt         | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt b/Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt
> new file mode 100644
> index 000000000000..d9ae2babf016
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt
> @@ -0,0 +1,23 @@
> +Analog Devices AD5933/AD5934 Impedance Converter, Network Analyzer
> +
> +https://www.analog.com/media/en/technical-documentation/data-sheets/AD5933.pdf
> +https://www.analog.com/media/en/technical-documentation/data-sheets/AD5934.pdf
> +
> +Required properties:
> + - compatible : should be one of
> +		"adi,ad5933"
> +		"adi,ad5934"
> + - reg : the I2C address
> + - vdd-supply : supply reference for the device.
> +
> +Optional properties:
> + - vref_mv : default voltage reference.

Regulator framework rather than a simple voltage.

> + - ext_clk_hz : external master clock for the system.

Please use the clocks framework for this rather than rolling our own.
There are fixed clocks to cover the common case, but it may be supplied by
something smarter.

> +
> +Example:
> +
> +	impedance-analyzer@0d {
> +		compatible = "adi,ad5933";
> +		reg = <0x0d>;
> +		vdd-supply = <&vdd_supply>;
> +	};



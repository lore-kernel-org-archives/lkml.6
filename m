Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeEDIXo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:23:44 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:54877 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751440AbeEDIXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:23:43 -0400
Subject: Re: [PATCH] ARM: dts: da850-lcdk: increase the size of the u-boot
 nand partition
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180504080835.28632-1-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <a998535f-8963-9e95-0652-b6ac16a13afa@ti.com>
Date: Fri, 4 May 2018 13:53:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504080835.28632-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On Friday 04 May 2018 01:38 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Current mainline u-boot builds images that are bigger than the 0x80000
> bytes u-boot partition allocated from the NAND memory. Using the free
> space partition results in an unbootable system. Increase the partition
> size to 0xa0000 bytes.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/boot/dts/da850-lcdk.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
> index 7de302f890d7..fc8667445892 100644
> --- a/arch/arm/boot/dts/da850-lcdk.dts
> +++ b/arch/arm/boot/dts/da850-lcdk.dts
> @@ -336,11 +336,11 @@
>  				partition@20000 {
>  					/* The LCDK defaults to booting from this partition */
>  					label = "u-boot";
> -					reg = <0x020000 0x080000>;
> +					reg = <0x020000 0x0a0000>;
>  				};
>  				partition@a0000 {
>  					label = "free space";
> -					reg = <0x0a0000 0>;
> +					reg = <0x0c0000 0>;

Unfortunately, we cannot do this because it introduces incompatibility
(data loss) for users who may have some data stored in "free space".

I should have insisted on a lot of padding for the u-boot partition or
asked not to add partitions to DT at all. For now the only solution is
to use command line partitions. They take precedence over DT partitions.

Thanks,
Sekhar

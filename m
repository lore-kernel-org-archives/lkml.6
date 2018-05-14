Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932251AbeENNsS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:48:18 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39757 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752482AbeENNsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:48:17 -0400
X-Google-Smtp-Source: AB8JxZp70YgEy/U1sP2Rcxzgk92QEMe446fwbtSV1z7VF9kZbLosY00dZfVkjifZpwnaIKmU8I/T2w==
Message-ID: <1526305693.2897.16.camel@baylibre.com>
Subject: Re: [PATCH 1/2] ARM64: dts: meson-gxbb: odroidc2: enable sdcard UHS
 modes
From: Jerome Brunet <jbrunet@baylibre.com>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 14 May 2018 15:48:13 +0200
In-Reply-To: <20180501185902.3556-1-linux.amoon@gmail.com>
References: <20180501185902.3556-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-02 at 00:29 +0530, Anand Moon wrote:
> Enable UHS modes for sdcard, on odroidc2.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index 54954b314a45..c90f8b46c60c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -258,6 +258,11 @@
>  	cap-sd-highspeed;
>  	max-frequency = <100000000>;
>  	disable-wp;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	sd-uhs-ddr50;
>  
>  	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
>  	cd-inverted;

Hi Anand,

I tried a few sdcards on the OC2 with your 2 patches.
Like with the libretech-cc, sdr104@200Mhz works "mostly", but, with some
sdcards, it does not - please see below. The same sdcards appear to be working
fine on my laptop.

This is something I have not been able to crack yet on the libretech-cc.

I'd suggest dropping sdr104 and keeping the max frequency at 100Mhz until we can
figure out the problem here.

With this changed:

Tested-by: Jerome Brunet <jbrunet@baylibre.com>

dd if=/dev/mmcblk1 of=/dev/zero bs=4M                                   
[  446.925817] mmc1: tuning execution failed: -5                               
[  446.956597] mmc1: tuning execution failed: -5                               
[  489.957810] print_req_error: I/O error, dev mmcblk1, sector 6654424         
[  490.141975] print_req_error: I/O error, dev mmcblk1, sector 6656440         
[  490.148304] print_req_error: I/O error, dev mmcblk1, sector 6656944         
[  490.349650] print_req_error: I/O error, dev mmcblk1, sector 6658456         
[  491.804382] print_req_error: I/O error, dev mmcblk1, sector 6747688         
[  492.281246] print_req_error: I/O error, dev mmcblk1, sector 6784992         
[  492.419034] print_req_error: I/O error, dev mmcblk1, sector 6785496         
[  492.865878] print_req_error: I/O error, dev mmcblk1, sector 6791800         
[  493.023809] print_req_error: I/O error, dev mmcblk1, sector 6792192         
[  493.024435] Buffer I/O error on dev mmcblk1, logical block 849024, async page
read                                                                         
[  493.217751] print_req_error: I/O error, dev mmcblk1, sector 6792808         
[  494.891779] mmc1: tuning execution failed: -5                               
[  495.374186] print_req_error: 3 callbacks suppressed                         
[  495.374193] print_req_error: I/O error, dev mmcblk1, sector 6854576         
[  495.767498] print_req_error: I/O error, dev mmcblk1, sector 6860000         
[  496.013104] print_req_error: I/O error, dev mmcblk1, sector 6863024         
[  496.223042] print_req_error: I/O error, dev mmcblk1, sector 6864032         
[  496.227003] print_req_error: I/O error, dev mmcblk1, sector 6864536         
[  496.375175] print_req_error: I/O error, dev mmcblk1, sector 6864176         
[  496.375806] Buffer I/O error on dev mmcblk1, logical block 858022, async page
read                                                                         
[  496.521229] print_req_error: I/O error, dev mmcblk1, sector 6864184         
[  496.521852] Buffer I/O error on dev mmcblk1, logical block 858023, async page
read                                                                         
[  503.596978] print_req_error: I/O error, dev mmcblk1, sector 6983312         
[  503.597606] Buffer I/O error on dev mmcblk1, logical block 872914, async page
read                                                                         
[  505.280621] print_req_error: I/O error, dev mmcblk1, sector 7004536         
[  505.281249] Buffer I/O error on dev mmcblk1, logical block 875567, async page
read                                                                         
[  507.372560] print_req_error: I/O error, dev mmcblk1, sector 7048696         
[  507.373192] Buffer I/O error on dev mmcblk1, logical block 881087, async page
read                                                                         
[  511.355248] print_req_error: I/O error, dev mmcblk1, sector 7131352         
[  511.355883] Buffer I/O error on dev mmcblk1, logical block 891419, async page
read                                                                         
[  511.369076] print_req_error: I/O error, dev mmcblk1, sector 7131352         
[  511.369694] Buffer I/O error on dev mmcblk1, logical block 891419, async page
read                                                                         
dd: error reading '/dev/mmcblk1': Input/output error                           
868+7 records in                       
868+7 records out                      
3651252224 bytes (3.7 GB, 3.4 GiB) copied, 66.7736 s, 54.7 MB/s   

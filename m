Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932407AbeCSHRc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 03:17:32 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35173 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932134AbeCSHR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 03:17:27 -0400
X-Google-Smtp-Source: AG47ELuiL6oFxgAQMk/dSGTdb1Nfj3odfhyWrEF1v2hamtgkYTP4GcQprpg4O9Wnmf0fu1+9NXAmkQ==
Date: Mon, 19 Mar 2018 12:47:23 +0530
From: afzal mohammed <afzal.mohd.ma@gmail.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Harald Geyer <harald@ccbib.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, info@olimex.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-arm-kernel@lists.infradead.org, Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCHv2 5/5] arm64: allwinner: a64: Add support for TERES-I
 laptop
Message-ID: <20180319071723.GA854@afzalpc>
References: <20180315162510.11669-1-harald@ccbib.org>
 <20180315162510.11669-6-harald@ccbib.org>
 <20180318202251.5gpv6sblfr4edxmj@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180318202251.5gpv6sblfr4edxmj@flea>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Sun, Mar 18, 2018 at 09:22:51PM +0100, Maxime Ripard wrote:
> The first part is supposed to be the name of the boards. I did sed
> s/leds/teres-i/, and applied, together with all the patches but the
> PWM (so I had to drop the backlight node as well).
> 
> Please coordinate with Andre about who should send the PWM support.

Assuming that these patches were applied to your sunxi/dt64-for-4.17
branch, since PWM support patch is missing, there is a build error,

arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts:129.1-5 Label or path pwm not found

Diff at the end cures it.

(there is another H6 pine 64 DT build error related to header file
missing)

afzal


--->8---
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index b3c7ef6b6fe5..d9baab3dc96b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -126,12 +126,6 @@
        status = "okay";
 };
 
-&pwm {
-       pinctrl-names = "default";
-       pinctrl-0 = <&pwm_pin>;
-       status = "okay";
-};
-
 &ohci1 {
        status = "okay";
 };

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeBZREs convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:04:48 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37716 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeBZREq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:04:46 -0500
X-Google-Smtp-Source: AH8x227iBR9ZIgOhVyvYIK301017w4oJ+IiduEYUEVwFyUNPw1bCxatYk8gO+2G4dW3kqkF3yf5HcQ==
Date: Mon, 26 Feb 2018 18:04:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marian Mihailescu <mihailescu2m@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/2] ARM: dts: exynos: Fix address of PPMU ACP on
 Exynos4210
Message-ID: <20180226170442.opmhse4wm3iqoshz@kozik-lap>
References: <CGME20180222191146epcas2p1e0fc10e3f8b278f0c3671d32e2d76350@epcas2p1.samsung.com>
 <20180222191111.23747-1-krzk@kernel.org>
 <5A8F608E.4030509@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <5A8F608E.4030509@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 09:30:06AM +0900, Chanwoo Choi wrote:
> On 2018년 02월 23일 04:11, Krzysztof Kozlowski wrote:
> > Typo in unit address of PPMU ACP caused DTC warnings:
> > 
> >     arch/arm/boot/dts/exynos4412-odroidu3.dtb:
> >         Warning (simple_bus_reg): Node /soc/ppmu_acp@10ae0000 simple-bus unit address format error, expected "106e0000"
> > 
> > PPMU ACP (under 0x10ae0000 address) is present only in Exynos4210 so
> > move this node to exynos4210.dtsi with fixing the reg address to proper
> > one.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  arch/arm/boot/dts/exynos4.dtsi    | 6 ------
> >  arch/arm/boot/dts/exynos4210.dtsi | 6 ++++++
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> > index 967cd02401c5..909a9f2bf5be 100644
> > --- a/arch/arm/boot/dts/exynos4.dtsi
> > +++ b/arch/arm/boot/dts/exynos4.dtsi
> > @@ -821,12 +821,6 @@
> >  			status = "disabled";
> >  		};
> >  
> > -		ppmu_acp: ppmu_acp@10ae0000 {
> > -			compatible = "samsung,exynos-ppmu";
> > -			reg = <0x106e0000 0x2000>;
> > -			status = "disabled";
> > -		};
> > -
> >  		ppmu_rightbus: ppmu_rightbus@112a0000 {
> >  			compatible = "samsung,exynos-ppmu";
> >  			reg = <0x112a0000 0x2000>;
> > diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> > index 853604d91158..88fb47cef9a8 100644
> > --- a/arch/arm/boot/dts/exynos4210.dtsi
> > +++ b/arch/arm/boot/dts/exynos4210.dtsi
> > @@ -162,6 +162,12 @@
> >  			iommus = <&sysmmu_g2d>;
> >  		};
> >  
> > +		ppmu_acp: ppmu_acp@10ae0000 {
> > +			compatible = "samsung,exynos-ppmu";
> > +			reg = <0x10ae0000 0x2000>;
> > +			status = "disabled";
> > +		};
> > +
> >  		ppmu_lcd1: ppmu_lcd1@12240000 {
> >  			compatible = "samsung,exynos-ppmu";
> >  			reg = <0x12240000 0x2000>;
> > 
> 
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks for reviews!

Applied both.

Best regards,
Krzysztof

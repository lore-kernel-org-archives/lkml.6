Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756033AbeEAQPx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:15:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52957 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754798AbeEAQPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:15:51 -0400
X-Google-Smtp-Source: AB8JxZpE5a5KNaE6BW5NkAevewyJzj+NwG++OdRvRvjOhR4r4EbWIjn2EUqMbea7xCENXDmVZvaY2w==
Date: Tue, 1 May 2018 18:15:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mathieu Malaterre <malat@debian.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/25] arm: exynos/s3c: dts: Remove leading 0x and 0s
 from bindings notation
Message-ID: <20180501161546.6w3fkenk7q6s4kqe@kozik-lap>
References: <20171215124630.30082-1-malat@debian.org>
 <CAJKOXPdkYLisej5965rh2SbOjbFms-RK2VnXt=L==MW_JcA+OA@mail.gmail.com>
 <CA+7wUsxp_n6V--PE9PQSsT1xu3b0HJn5gWBhnp=ngRNqBSVvFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+7wUsxp_n6V--PE9PQSsT1xu3b0HJn5gWBhnp=ngRNqBSVvFg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2017 at 11:17:24AM +0100, Mathieu Malaterre wrote:
> On Mon, Dec 18, 2017 at 10:40 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Fri, Dec 15, 2017 at 1:46 PM, Mathieu Malaterre <malat@debian.org> wrote:
> >> Improve the DTS files by removing all the leading "0x" and zeros to fix the
> >> following dtc warnings:
> >>
> >> Warning (unit_address_format): Node /XXX unit name should not have leading "0x"
> >>
> >> and
> >>
> >> Warning (unit_address_format): Node /XXX unit name should not have leading 0s
> >>
> >> Converted using the following command:
> >>
> >> find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -i -e "s/@\([0-9a-fA-FxX\.;:#]+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1 {/g" -e "s/@0+\(.*\) {/@\1 {/g" {} +^C
> >>
> >> For simplicity, two sed expressions were used to solve each warnings separately.
> >>
> >> To make the regex expression more robust a few other issues were resolved,
> >> namely setting unit-address to lower case, and adding a whitespace before the
> >> the opening curly brace:
> >>
> >> https://elinux.org/Device_Tree_Linux#Linux_conventions
> >>
> >> This will solve as a side effect warning:
> >>
> >> Warning (simple_bus_reg): Node /XXX@<UPPER> simple-bus unit address format error, expected "<lower>"
> >>
> >> This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")
> >>
> >> Reported-by: David Daney <ddaney@caviumnetworks.com>
> >> Suggested-by: Rob Herring <robh@kernel.org>
> >> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > Ack was for different patchset, touching only three files...
> 
> So sorry, when I read your email:
> 
> https://lkml.org/lkml/2017/12/15/152
> 
> I assumed you meant for all the Exynos* and S3C* DTS files, but I did
> not check carefully which files were touched originally.
> 
> >> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> >> ---
> >>  arch/arm/boot/dts/exynos3250.dtsi             | 34 ++++++------
> >>  arch/arm/boot/dts/exynos4.dtsi                | 56 +++++++++----------
> >>  arch/arm/boot/dts/exynos4210.dtsi             |  8 +--
> >>  arch/arm/boot/dts/exynos4412-pinctrl.dtsi     |  2 +-
> >>  arch/arm/boot/dts/exynos4412.dtsi             | 22 ++++----
> >>  arch/arm/boot/dts/exynos5.dtsi                | 22 ++++----
> >>  arch/arm/boot/dts/exynos5250.dtsi             | 64 +++++++++++-----------
> >>  arch/arm/boot/dts/exynos5260.dtsi             | 26 ++++-----
> >>  arch/arm/boot/dts/exynos5420.dtsi             | 78 +++++++++++++--------------
> >>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  2 +-
> >>  arch/arm/boot/dts/exynos5440.dtsi             | 14 ++---
> >>  arch/arm/boot/dts/s3c2416.dtsi                |  8 +--
> >>  12 files changed, 168 insertions(+), 168 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> >> index 2bd3872221a1..8d47571b3984 100644
> >> --- a/arch/arm/boot/dts/exynos3250.dtsi
> >> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> >> @@ -164,31 +164,31 @@
> >>                         syscon = <&pmu_system_controller>;
> >>                 };
> >>
> >> -               pd_cam: cam-power-domain@10023C00 {
> >> +               pd_cam: cam-power-domain@10023c00 {
> >
> > This is not related to this patch and it was not present in the
> > version I acked. I also already fixed this here:
> > https://patchwork.kernel.org/patch/10113323/
> >
> > There is no changelog explaining the difference in patches. Original
> > patch was okay, why changing it?
> 
> Accept my sincere apologizes I really messed this series. I discover
> my original ARM patch did not apply lower case to all unit-address
> equally, so I added at last minute a sed expression to make all
> unit-address lower case.
> 
> I guess you can just drop this one for now.

Hi Mathieu,

Do you plan to resend this in its original form (removing 0)?

Best regards,
Krzysztof

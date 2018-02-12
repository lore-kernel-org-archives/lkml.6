Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbeBLPXT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:23:19 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39778 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752199AbeBLPXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:23:17 -0500
X-Google-Smtp-Source: AH8x226+hLCFPQsZ3YcupthyT+bfpxin0pnaj/CIikUuRU33QQ0FS2OIQrYB0T7KJKoNdR5M3ZqVBagGuUvq0Xf6pZg=
MIME-Version: 1.0
In-Reply-To: <1518446590-16800-11-git-send-email-patrice.chotard@st.com>
References: <1518446590-16800-1-git-send-email-patrice.chotard@st.com> <1518446590-16800-11-git-send-email-patrice.chotard@st.com>
From: Rob Herring <rob.herring@linaro.org>
Date: Mon, 12 Feb 2018 09:22:55 -0600
Message-ID: <CABGGisxgejFHj0xQq-aBQETt9CX3OzLc3ER_Y9nyrw7FeLdt6g@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] ARM: dts: STi: Add fake reg property for clocks
To: patrice.chotard@st.com
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux@armlinux.org.uk,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 8:43 AM,  <patrice.chotard@st.com> wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
>
> For all clock's element inside SoC, add a fake reg property,
> this allows to fix the following warnings when compiling
> dtb with W=1 option :
>
> arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
> Node /clocks/clk-m-a9-periphs missing or empty reg/ranges property
> arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
> Node /clocks/clk-m-a9-ext2f-div2s missing or empty reg/ranges property
> arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
> Node /clocks/clk-tmdsout-hdmi missing or empty reg/ranges property
>
> arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
> Node /clocks/clk-m-a9-periphs missing or empty reg/ranges property
> arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
> Node /clocks/clk-m-a9-ext2f-div2s missing or empty reg/ranges property
> arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
> Node /clocks/clk-tmdsout-hdmi missing or empty reg/ranges property
>
> arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
> Node /clocks/clk-m-a9-periphs missing or empty reg/ranges property
> arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
> Node /clocks/clk-m-a9-ext2f-div2s missing or empty reg/ranges property
> arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
> Node /clocks/clk-tmdsout-hdmi missing or empty reg/ranges property
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>
> v2: _ add a fake reg property to node without reg property.
>
>  arch/arm/boot/dts/stih407-clock.dtsi | 9 ++++++---
>  arch/arm/boot/dts/stih410-clock.dtsi | 9 ++++++---
>  arch/arm/boot/dts/stih418-clock.dtsi | 9 ++++++---
>  3 files changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
> index b882dcf3a649..1bba47e06ebe 100644
> --- a/arch/arm/boot/dts/stih407-clock.dtsi
> +++ b/arch/arm/boot/dts/stih407-clock.dtsi
> @@ -24,9 +24,10 @@
>                 /*
>                  * ARM Peripheral clock for timers
>                  */
> -               arm_periph_clk: clk-m-a9-periphs {
> +               arm_periph_clk: clk-m-a9-periphs@0 {
>                         #clock-cells = <0>;
>                         compatible = "fixed-factor-clock";
> +                       reg = <0 0>;

Don't do this. The correct fix is change the location of these nodes
to be under whatever controls them.

Rob

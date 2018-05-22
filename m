Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751601AbeEVSCn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:02:43 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33015 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbeEVSCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:02:40 -0400
X-Google-Smtp-Source: AB8JxZoSakFXKq/mvlegGPD/NOj1hHVkkyKFfDdNfHCWumsIV/QxQlVImGuGGAtihH1ZidMtN+Zh4A==
Date: Tue, 22 May 2018 13:02:38 -0500
From: Rob Herring <robh@kernel.org>
To: djw@t-chip.com.cn
Cc: linux-rockchip@lists.infradead.org, Wayne Chou <zxf@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/5] gpio: syscon: Add gpio-syscon for rockchip
Message-ID: <20180522180238.GA7328@rob-hp-laptop>
References: <1526614328-6869-1-git-send-email-djw@t-chip.com.cn>
 <1526615528-9707-1-git-send-email-djw@t-chip.com.cn>
 <1526615528-9707-2-git-send-email-djw@t-chip.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526615528-9707-2-git-send-email-djw@t-chip.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 11:52:05AM +0800, djw@t-chip.com.cn wrote:
> From: Levin Du <djw@t-chip.com.cn>
> 
> Some GPIOs sit in the GRF_SOC_CON registers of Rockchip SoCs,
> which do not belong to the general pinctrl.
> 
> Adding gpio-syscon support makes controlling regulator or
> LED using these special pins very easy by reusing existing
> drivers, such as gpio-regulator and led-gpio.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>
> 
> ---
> 
> Changes in v2:
> - Rename gpio_syscon10 to gpio_mute in doc
> 
> Changes in v1:
> - Refactured for general gpio-syscon usage for Rockchip SoCs.
> - Add doc rockchip,gpio-syscon.txt
> 
>  .../bindings/gpio/rockchip,gpio-syscon.txt         | 41 ++++++++++++++++++++++
>  drivers/gpio/gpio-syscon.c                         | 30 ++++++++++++++++
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
> new file mode 100644
> index 0000000..b1b2a67
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
> @@ -0,0 +1,41 @@
> +* Rockchip GPIO support for GRF_SOC_CON registers
> +
> +Required properties:
> +- compatible: Should contain "rockchip,gpio-syscon".
> +- gpio-controller: Marks the device node as a gpio controller.
> +- #gpio-cells: Should be two. The first cell is the pin number and
> +  the second cell is used to specify the gpio polarity:
> +    0 = Active high,
> +    1 = Active low.

There's no need for this child node. Just make the parent node a gpio 
controller.

Rob

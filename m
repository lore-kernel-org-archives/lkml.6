Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeC2QQI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:16:08 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38693 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbeC2QQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:16:05 -0400
X-Google-Smtp-Source: AIpwx49IZB+omPt0Mf1/BCadeo+Zb1b7a5e1KvipLA7ZTgHwciMt4PnxgukFtoFNmxsIW8PRraatKA==
Date: Thu, 29 Mar 2018 09:16:02 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Chen Zhong <chen.zhong@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Linus Walleij <linus.walleij@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Jaechul Lee <jcsing.lee@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v6 3/6] dt-bindings: input: Add document bindings for
 mtk-pmic-keys
Message-ID: <20180329161602.GC107392@dtor-ws>
References: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
 <1508937364-30054-4-git-send-email-chen.zhong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508937364-30054-4-git-send-email-chen.zhong@mediatek.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2017 at 09:16:01PM +0800, Chen Zhong wrote:
> This patch adds the device tree binding documentation for the MediaTek
> pmic keys found on PMIC MT6397/MT6323.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  .../devicetree/bindings/input/mtk-pmic-keys.txt    |   43 ++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> new file mode 100644
> index 0000000..2888d07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> @@ -0,0 +1,43 @@
> +MediaTek MT6397/MT6323 PMIC Keys Device Driver
> +
> +There are two key functions provided by MT6397/MT6323 PMIC, pwrkey
> +and homekey. The key functions are defined as the subnode of the function
> +node provided by MT6397/MT6323 PMIC that is being defined as one kind
> +of Muti-Function Device (MFD)
> +
> +For MT6397/MT6323 MFD bindings see:
> +Documentation/devicetree/bindings/mfd/mt6397.txt
> +
> +Required properties:
> +- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
> +- linux,keycodes: See Documentation/devicetree/bindings/input/keys.txt
> +
> +Optional Properties:
> +- wakeup-source: See Documentation/devicetree/bindings/power/wakeup-source.txt
> +- mediatek,long-press-mode: Long press key shutdown setting, 1 for
> +	pwrkey only, 2 for pwrkey/homekey together, others for disabled.
> +- power-off-time-sec: See Documentation/devicetree/bindings/input/keys.txt
> +
> +Example:
> +
> +	pmic: mt6397 {
> +		compatible = "mediatek,mt6397";
> +
> +		...
> +
> +		mt6397keys: mt6397keys {
> +			compatible = "mediatek,mt6397-keys";
> +			mediatek,long-press-mode = <1>;
> +			power-off-time-sec = <0>;
> +
> +			power {
> +				linux,keycodes = <116>;
> +				wakeup-source;
> +			};
> +
> +			home {
> +				linux,keycodes = <114>;
> +			};
> +		};
> +
> +	};
> -- 
> 1.7.9.5
> 

-- 
Dmitry

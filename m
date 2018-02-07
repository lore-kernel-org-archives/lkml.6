Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753703AbeBGKpn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:45:43 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38758 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753454AbeBGKpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:45:42 -0500
X-Google-Smtp-Source: AH8x22559Bk8e2lyHTSxAYFg+BcRsEjGF/ognYdLg+iWvqh3evA85/BeNbzIoww65l2ZerB5z9NH8A==
Subject: Re: [PATCH v2 01/16] dt-bindings: clock: mediatek: add missing
 required #reset-cells
To: sean.wang@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>
References: <cover.1517910489.git.sean.wang@mediatek.com>
 <d58fcf36319254d6de4c7fe100cbdca1bbec27a5.1517910489.git.sean.wang@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <391278e5-9b72-1142-0262-5d286fe17d8d@gmail.com>
Date: Wed, 7 Feb 2018 11:45:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <d58fcf36319254d6de4c7fe100cbdca1bbec27a5.1517910489.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/06/2018 10:52 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> All ethsys, pciesys and ssusbsys internally include reset controller, so
> explicitly add back these missing cell definitions to related bindings
> and examples.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt   | 2 ++
>  Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt  | 2 ++
>  Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
> index 7aa3fa1..8f5335b 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
> @@ -9,6 +9,7 @@ Required Properties:
>  	- "mediatek,mt2701-ethsys", "syscon"
>  	- "mediatek,mt7622-ethsys", "syscon"
>  - #clock-cells: Must be 1
> +- #reset-cells: Must be 1
>  
>  The ethsys controller uses the common clk binding from
>  Documentation/devicetree/bindings/clock/clock-bindings.txt
> @@ -20,4 +21,5 @@ ethsys: clock-controller@1b000000 {
>  	compatible = "mediatek,mt2701-ethsys", "syscon";
>  	reg = <0 0x1b000000 0 0x1000>;
>  	#clock-cells = <1>;
> +	#reset-cells = <1>;

The example is already fixed upstream, but I forgot the binding description,
please rebase this patch.

And please don't forget to add all clock maintainers.

Regards,
Matthias

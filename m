Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbeBCO0W (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 09:26:22 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52743 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751787AbeBCO0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 09:26:13 -0500
X-Google-Smtp-Source: AH8x226mN/xtcbWHNjFYuESnbqoF57aQ9DHsaUPuxgj5Lrr+kMt0OMAlNjc0jkpvZdptUQ9KbtauAA==
Subject: Re: [PATCH v2 2/5] clk: mediatek: modify MT7622 audsys to adapt MFD
 device
To: Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Garlic Tseng <garlic.tseng@mediatek.com>
References: <cover.1515639336.git.ryder.lee@mediatek.com>
 <d6669277f5232446b4798a6b724074b18d5c21aa.1515639336.git.ryder.lee@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <72058f8d-c83d-d0e6-dc07-83c9f5fc2710@gmail.com>
Date: Sat, 3 Feb 2018 15:26:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <d6669277f5232446b4798a6b724074b18d5c21aa.1515639336.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/31/2018 08:42 AM, Ryder Lee wrote:
> As the new MFD parent is in place, switch probing method to adapt it.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mt7622-aud.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
> index 13f752d..8c18536 100644
> --- a/drivers/clk/mediatek/clk-mt7622-aud.c
> +++ b/drivers/clk/mediatek/clk-mt7622-aud.c
> @@ -142,11 +142,12 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
>  {
>  	struct clk_onecell_data *clk_data;
>  	struct device_node *node = pdev->dev.of_node;
> +	struct device_node *pnode = pdev->dev.parent->of_node;
>  	int r;
>  
>  	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
>  
> -	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
> +	mtk_clk_register_gates(pnode, audio_clks, ARRAY_SIZE(audio_clks),

We will need a fallback here for older device tree bindings.

Regards,
Matthias

>  			       clk_data);
>  
>  	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031577AbeCSUcH convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030696AbeCSUcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:32:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1695A20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Rob Herring <robh+dt@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <3a3c198707a69297abc05d2a7fef97857e7fab5a.1520327262.git.ryder.lee@mediatek.com>
Cc: devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        Garlic Tseng <garlic.tseng@mediatek.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1520327262.git.ryder.lee@mediatek.com>
 <3a3c198707a69297abc05d2a7fef97857e7fab5a.1520327262.git.ryder.lee@mediatek.com>
Message-ID: <152149151947.242365.12823569223681242175@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 2/6] clk: mediatek: add devm_of_platform_populate() for MT7622
 audsys
Date: Mon, 19 Mar 2018 13:31:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryder Lee (2018-03-06 01:09:27)
> @@ -150,12 +151,15 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
>                                clk_data);
>  
>         r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> -       if (r)
> +       if (r) {
>                 dev_err(&pdev->dev,
>                         "could not register clock provider: %s: %d\n",
>                         pdev->name, r);
>  
> -       return r;
> +               return r;
> +       }
> +
> +       return devm_of_platform_populate(&pdev->dev);

And now we fail to remove the clk provider when this fails.

>  }
>  
>  static const struct of_device_id of_match_clk_mt7622_aud[] = {
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

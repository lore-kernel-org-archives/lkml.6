Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA8AC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 13:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA40206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 13:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpB+vhiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA40206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeI2T72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 15:59:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44087 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeI2T72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 15:59:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id 63-v6so1849872wra.11;
        Sat, 29 Sep 2018 06:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ULBL/Z+9wB7XvHlyxs5wk7N0ZuhqVFq8zqY+5AsT/tk=;
        b=IpB+vhiypB5CnczTFyqeepbE0b81cwxdsA/n8MSaM50JObcUpt+OPrxdRK+aA7goBv
         2yvDsJWFmwlXZGREe053srbd5ruDeglS3F7ozvuUj7cagZbSKZvuZlUHO3VUExxnWG7b
         h4HQJE0v3wOz5BdWjRbTGoUnQ+7YyRWFRlDCrbRgAITBSRi6skspYbL7jIheJCc5hBB7
         b0y3yo9mDX8pNqeqnoimp2s4fg2D+14zPdXbdJKl63OmGdWQQzQQAUtqJVlvWo1wd7zt
         h3JYvoa/7TBP7nZ7Y2mLH21oyhi7a5jBePBV8xtXht71NvdhovwltxTuYY4Bn68Mz8+a
         QS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ULBL/Z+9wB7XvHlyxs5wk7N0ZuhqVFq8zqY+5AsT/tk=;
        b=KmefIsBrDQ0HACiBmU7gCBuCwBi6Z0nlG6shMszCjF2ZuxNTuTGKFyTem2p3wIj5zG
         cjM932DShqMll7EEYBcB2tFw5y0aEuLbXdJX2tYYI+peRbS/6zv3swmqeHwu+fM2CAOq
         94rWIaUerp5WQZOg1+aN9CjELS3M+pzG/QSCa3geJNI/NQ96iPuNS+AVAd8DWydnlr9Z
         TdLXeBI5AG0/c8wqrdiQb/vvzP2Ma6i6UJjjIuvmyhvsWXV0z91/bEO7ckmu2KTvXy2c
         4WTRpw2uwWUoSYF0xZp9hbm98U5Y2DfFy6JV8z5qyDR5iiDSdgCDLKFgYWjPOhfsWKvQ
         fS0w==
X-Gm-Message-State: ABuFfogqnSrm7kRW6e+bRWaVhhwpN5rA5mZZo9JowE14jYUcfz2W1iUt
        yz+XUEsMihG7gzML8JAvj4A=
X-Google-Smtp-Source: ACcGV61iPHfcdVCZphB4FGQuiNl5C7eRsfBiQYnGEkTVSnQBTEtgs87BYtxcksx66sqsXYGfh46jcg==
X-Received: by 2002:adf:8b5e:: with SMTP id v30-v6mr1830015wra.282.1538227856950;
        Sat, 29 Sep 2018 06:30:56 -0700 (PDT)
Received: from ziggy.stardust (p54A4E637.dip0.t-ipconnect.de. [84.164.230.55])
        by smtp.gmail.com with ESMTPSA id p8sm3951380wrx.9.2018.09.29.06.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 06:30:55 -0700 (PDT)
Subject: Re: [PATCH 4/4] arm64: dts: mediatek: add pwrap device node for
 mt8183
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     argus.lin@mediatek.com, sean.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, chenglin.xu@mediatek.com,
        chen.zhong@mediatek.com, srv_heupstream@mediatek.com
References: <1537341961-20736-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1537341961-20736-5-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <f1cc2f58-ad3c-2f88-8e86-b80848e17cc5@gmail.com>
Date:   Sat, 29 Sep 2018 15:30:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1537341961-20736-5-git-send-email-hsin-hsiung.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/09/2018 09:26, Hsin-Hsiung Wang wrote:
> add pwrap device node for mt8183.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)

The basic support for mt8183 is not ready to be merged.
I'll also try to not forget about this patch.
If you re-submit after basic mt8183 support got accepted, that will help me. :)

Thanks,
Matthias

> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index c22a2dc..fa67d781 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -170,6 +170,16 @@
>  		#clock-cells = <1>;
>  	};
>  
> +	pwrap: pwrap@1000d000 {
> +		compatible = "mediatek,mt8183-pwrap";
> +		reg = <0 0x1000d000 0 0x1000>;
> +		reg-names = "pwrap";
> +		interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&topckgen CLK_TOP_MUX_PMICSPI>,
> +			 <&infracfg CLK_INFRA_PMIC_AP>;
> +		clock-names = "spi", "wrap";
> +	};
> +
>  	uart0: serial@11002000 {
>  		compatible = "mediatek,mt8183-uart",
>  			     "mediatek,mt6577-uart";
> 

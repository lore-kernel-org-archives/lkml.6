Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A26C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E7120C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U63S2eK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E7120C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbeIYVzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:55:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37996 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbeIYVzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:55:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id r77-v6so6730206pgr.5;
        Tue, 25 Sep 2018 08:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r1jf7I8m9XEAKsAK1/gwrUfL1vDsUdRh0ZhYbhKAyEA=;
        b=U63S2eK2/Mu+Es1QQKtVa2ueoabCpSycT3yT6RVAGYzlNsBWHLYCetm+c+6JwauGXW
         4xWxX53qpltw5GdXEFpWMY5REKHs0qLoVrUm4twJMD9U5YgSQkYM1h3YBHIIkUxoXrUQ
         qRQiFIgT2EfmWy4/xWgPnYnQnO9uAfqZPO3H+k9rdCSRXYbrrk6c181CVkTVO826wucl
         m9MEbt2weMjscvvS+mDgeE/TgQI/Bd3KsQ06K8bVZJ15aEIJybh2jkV/tOxrYyb0Oter
         Bj9hi00NZzVkIfj5ue3vBdUP4H6bvSypPpRinGK0V0whT2M3EjeoQF9rY99w8nGl+wO1
         /nJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=r1jf7I8m9XEAKsAK1/gwrUfL1vDsUdRh0ZhYbhKAyEA=;
        b=lKgzwaCR6hn+jIiiK4kM5ztFp7pQRC0ha3NQXLUpQkOa9PF00ZpL6BbL5q+caYzNEB
         P71M8UtPR4LPoL5dWyrYRuUIGBJIsiouXQj1/4EU8aKlSxhgufTmsEmbtp6SZQexOjNE
         CuwV+h2Zj7kTNWSy4S0HGmgollJfxv3YiILdKQFXJqBmxDkykvlFP1AUF8CPEueIMcj4
         FVTrmqmpr7+snx4wAGzxJwTkLHDuMuVnXkA+Py7MlWgcKhpYrfeyV28cAaE44J/jeCsj
         hAm0LLxalPMUzVAepZwfyIopu52mDW9MeKpciwMmORq854ccWf8DLRHpTqtCB6as6sGA
         cZfg==
X-Gm-Message-State: ABuFfogamVfr1eqYjpRhkw7U+BUVMul3mf3tUyXKMQQPz0RirdOXBMDq
        tviCRxmyMqAM+yzmXmJzrdo=
X-Google-Smtp-Source: ACcGV62gN7TuCKPMJTUtbGmCft+VCIcwKp+K57qMmG4dDdKfMNstr3b5TcAkFiNe2VgArj8uWUN3iQ==
X-Received: by 2002:a17:902:bf43:: with SMTP id u3-v6mr1849588pls.88.1537890419472;
        Tue, 25 Sep 2018 08:46:59 -0700 (PDT)
Received: from ziggy.stardust ([37.223.146.97])
        by smtp.gmail.com with ESMTPSA id h82-v6sm7337718pfa.173.2018.09.25.08.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 08:46:58 -0700 (PDT)
Subject: Re: [PATCH 2/5] arm: dts: mt7623: update subsystem clock controller
 device nodes
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <84011aa94dd7be9239b7a2f944dd30fc70568fbb.1536141302.git.ryder.lee@mediatek.com>
 <6cc820db27996d8fd3094df10abbba1a2008907a.1536141302.git.ryder.lee@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <64b5187f-8a4d-b94e-8a3b-f1e19538697a@gmail.com>
Date:   Tue, 25 Sep 2018 17:46:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <6cc820db27996d8fd3094df10abbba1a2008907a.1536141302.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/09/2018 12:22, Ryder Lee wrote:
> Update MT7623 subsystem clock controllers, inlcuding mmsys, imgsys,
> vdecsys, g3dsys and bdpsys.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Applied to v4.19-next/dts32

> ---
>  arch/arm/boot/dts/mt7623.dtsi | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index 8c43bd0..b7ccf8b 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -692,6 +692,39 @@
>  		status = "disabled";
>  	};
>  
> +	g3dsys: syscon@13000000 {
> +		compatible = "mediatek,mt7623-g3dsys",
> +			     "mediatek,mt2701-g3dsys",
> +			     "syscon";
> +		reg = <0 0x13000000 0 0x200>;
> +		#clock-cells = <1>;
> +		#reset-cells = <1>;
> +	};
> +
> +	mmsys: syscon@14000000 {
> +		compatible = "mediatek,mt7623-mmsys",
> +			     "mediatek,mt2701-mmsys",
> +			     "syscon";
> +		reg = <0 0x14000000 0 0x1000>;
> +		#clock-cells = <1>;
> +	};
> +
> +	imgsys: syscon@15000000 {
> +		compatible = "mediatek,mt7623-imgsys",
> +			     "mediatek,mt2701-imgsys",
> +			     "syscon";
> +		reg = <0 0x15000000 0 0x1000>;
> +		#clock-cells = <1>;
> +	};
> +
> +	vdecsys: syscon@16000000 {
> +		compatible = "mediatek,mt7623-vdecsys",
> +			     "mediatek,mt2701-vdecsys",
> +			     "syscon";
> +		reg = <0 0x16000000 0 0x1000>;
> +		#clock-cells = <1>;
> +	};
> +
>  	hifsys: syscon@1a000000 {
>  		compatible = "mediatek,mt7623-hifsys",
>  			     "mediatek,mt2701-hifsys",
> @@ -946,6 +979,14 @@
>  		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
>  		status = "disabled";
>  	};
> +
> +	bdpsys: syscon@1c000000 {
> +		compatible = "mediatek,mt7623-bdpsys",
> +			     "mediatek,mt2701-bdpsys",
> +			     "syscon";
> +		reg = <0 0x1c000000 0 0x1000>;
> +		#clock-cells = <1>;
> +	};
>  };
>  
>  &pio {
> 

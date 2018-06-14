Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 87609C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C741208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="0Uls+s+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C741208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755190AbeFNLmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:42:39 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40932 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755135AbeFNLmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:42:36 -0400
Received: by mail-lf0-f67.google.com with SMTP id q11-v6so8913453lfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 04:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZZOq51i2a6P7g5jxdUXvZ6Ci0o4lWElGXnzoXiqjRN0=;
        b=0Uls+s+5wNb2s2bp6a8pSGS4TXDu6dBZI9lrOy8KOUNhEPDyszc9S2PLD4W+Ccpy0O
         eYcczh3fk4kDyKSXH/R5nKIGg9fC1kVFJXM/s1Llnfsdns9fNGmjaJ+qZvxgjCkvH4NG
         sULuJpiFatm2APbxh+1tN1NMMxDl7NZFKCWp2Q+sGUWqft94wQBWOwp4L0Z45AiIVYPx
         kJGdGcYMuWdFLiUreRDL1TPvBfy2/f5yZ1WsS0LZy5+x3lPVWkFOQ9fTTimx+7uPKdn1
         MPO+PGbiV7a1AbC5XWyrs5h3c2/7xK3ulJUqK83mTlQiSS7YhwR51+LUM+R8iCEipaYq
         GW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZZOq51i2a6P7g5jxdUXvZ6Ci0o4lWElGXnzoXiqjRN0=;
        b=Z9pwr3pZ/G35gxjhh2U3NMcTnTHvEtrddr1CttfM1tRn/dnjLPPcTOEXT5B8cgB+CZ
         cWtLpRE+7lCbeFlEHInWyrXby3jStm++g+h8lndtOS/0pMxzzi0bkP2wJC73iEM+/y5s
         SDH8GN+CpDorGNYb/puyYuAjqYcIyvgr5RWcxMZ4aKxUK6z8Cc55l3ohFGUBonUiL/gK
         RQF3FuK5E19FODKCsgcx0vYzPSlBBV3RUgmH5A2sM5lkpZb7IQMZpzg9d7iOVLuzFX81
         Eij1UNGhrmsyQ7XpVwWOZ0dy/xIx/jrURbCECLu6Li+h4p4xqq/MYYTy9tuv/l1kAH2u
         VlHQ==
X-Gm-Message-State: APt69E2teuQR8wfsn1gFQMMQLkCY6/7c4OCbIezol61ZmXYTSNTl7e89
        ZxLPF7yfLuoKvx1L0uXjJ3eqikOsEoQ=
X-Google-Smtp-Source: ADUXVKJu3GVoWvc27jIXzA4MR08bgMF5e4bMRGrhRX3FvjXmOJ3dAV3+mkJIVtbMXXNsOYHuWXTLTA==
X-Received: by 2002:a19:f611:: with SMTP id x17-v6mr5959247lfe.116.1528976554618;
        Thu, 14 Jun 2018 04:42:34 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.84.212])
        by smtp.gmail.com with ESMTPSA id d20-v6sm902599ljc.62.2018.06.14.04.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 04:42:33 -0700 (PDT)
Subject: Re: [PATCH v1 4/5] ARM: dts: Renesas R9A06G032 pinctrl node
To:     Michel Pollet <michel.pollet@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>
Cc:     phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1528974029-29617-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528974029-29617-5-git-send-email-michel.pollet@bp.renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <7e9eefe0-5310-5925-3b00-b75800e6d87e@cogentembedded.com>
Date:   Thu, 14 Jun 2018 14:42:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1528974029-29617-5-git-send-email-michel.pollet@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 06/14/2018 02:00 PM, Michel Pollet wrote:

> This provides a pinctrl driver for the Renesas R9A06G032 SoC
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  arch/arm/boot/dts/r9a06g032.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
> index 3e45375..fbad039 100644
> --- a/arch/arm/boot/dts/r9a06g032.dtsi
> +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> @@ -88,6 +88,14 @@
>  			status = "disabled";
>  		};
>  
> +		pinctrl: pinctrl@40067000 {

   "pin-controller@..." please, it's looking more generic.

> +			compatible = "renesas,r9a06g032-pinctrl";
> +			reg = <0x40067000 0x1000>, <0x51000000 0x800>;
> +			clocks = <&sysctrl R9A06G032_HCLK_PINCONFIG>;
> +			clock-names = "bus";
> +			status = "okay";
> +		};
> +
>  		gic: gic@44101000 {
>  			compatible = "arm,cortex-a7-gic", "arm,gic-400";
>  			interrupt-controller;

MBR, Sergei

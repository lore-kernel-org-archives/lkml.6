Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B119C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 02:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44A220815
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 02:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546569895;
	bh=Oq2Z4+RLU4p7bcwY/aGJ9Qt8mGq4rp82GVYBAs5zuDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qJtqfJYkV5oF/svhub1VOR9dlfdc7za9qjmF7uKGMx75Yb9ei46Hkn0ayG97q24Bh
	 ipwfqFofuyiTGgupKXjBdO8yXo9GK/W5kkFrET7c72FHmeqWH4XhSNv/YVsAeydiMU
	 4XrbmkErSbW7MayHCG3HU2Bq3IwmBKVKFtckMnNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfADCoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 21:44:55 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55515 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfADCoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 21:44:54 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so48096524ith.5;
        Thu, 03 Jan 2019 18:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=diwqjDGc9sdTVKZvvVFpkAPDTc6C/pPT/CmD+S+0pW4=;
        b=NixoIMQvLf62JN8HDCiE6pOkf/br1dv7yLD1DoxFLf3Rwdf4OEanGUvMHbcxsf6ytf
         D8htd9wqHNBA8ucOMyOTP8BPgi5t5jmsCushS1mBh7jn6by1JxGLlhVKtCOrCEhaqAkw
         i9c++giFHrTF8DDbdkiRSRJXdNtaXrVcwJWY/FL78sgpm5xTVQhc6odbpNwR6zVN77sw
         EWI2qZGEad4ciKqA0YY7GLgKZv5ZKEPjK8er/NTtdB6tT/d8szJscSOL1ZvWd2KQqEMF
         MmY/fNRXvEAcDQRKIb9yr2rXo93VzaaDrrcBbygSReHF5j3M7VzxNWx7dVTqaHD5JC7q
         zneA==
X-Gm-Message-State: AA+aEWbdFYAGnVhX8D/mNkWfxhwITcDbrGzN/lfeTAjc8ffcg4wN2A02
        jBfC8I1YndTShIeBYXbt8Q==
X-Google-Smtp-Source: AFSGD/VwTgD/i9VU363h8Jvg9qeDVGJUo50bCe453VNvk/mCwW8afZMeMMyUPIgKhSiNxv5I9q7pQQ==
X-Received: by 2002:a24:f143:: with SMTP id q3mr33671999iti.42.1546569892534;
        Thu, 03 Jan 2019 18:44:52 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id f13sm25307757iol.82.2019.01.03.18.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 18:44:51 -0800 (PST)
Date:   Thu, 3 Jan 2019 20:44:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     h00249924 <hutenghui@huawei.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        liyuequan@hisilicon.com, cash.qianli@hisilicon.com,
        huangli295@hisilicon.com, hantanglei@huawei.com,
        wangyoulin1@hisilicon.com, ninggaoyu@hisilicon.com,
        hanxiaolong3@hisilicon.com,
        Youlin Wang <wwx575822@notesmail.huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/3] arm64: dts: hi3660: Add hisi asp dma device
Message-ID: <20190104024449.GB17431@bogus>
References: <1545978983-124360-1-git-send-email-hutenghui@huawei.com>
 <1545978983-124360-3-git-send-email-hutenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545978983-124360-3-git-send-email-hutenghui@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 02:36:23PM +0800, h00249924 wrote:
> From: Youlin Wang <wwx575822@notesmail.huawei.com>
> 
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
> Signed-off-by: Tanglei Han <hantanglei@huawei.com>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index f432b0a..5223e36 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -1122,5 +1122,19 @@
>  				};
>  			};
>  		};
> +
> +		asp_dmac: asp_dmac@E804B000 {

dma-controller@e804b000

> +			compatible = "hisilicon,hisi-pcm-asp-dma-1.0";
> +			reg = <0x0 0xe804b000 0x0 0x1000>;
> +			#dma-cells = <1>;
> +			dma-channels = <16>;
> +			dma-requests = <32>;
> +			dma-min-chan = <0>;
> +			dma-used-chans = <0xFFFE>;

Use lowercase hex.

But more importantly, as John mentioned, this and other properties 
aren't documented.

> +			dma-share;
> +			interrupts = <0 216 4>;
> +			interrupt-names = "asp_dma_irq";
> +			status = "ok";

Don't need this.

> +		};
>  	};
>  };
> -- 
> 1.9.1
> 
